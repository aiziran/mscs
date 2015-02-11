package ssdevframework.core.dispatcher;

import static javax.servlet.http.HttpServletResponse.*;

import java.io.IOException;
import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.Dispatcher;
import org.apache.struts2.dispatcher.ServletRedirectResult;
import org.apache.struts2.dispatcher.StrutsResultSupport;
import org.apache.struts2.dispatcher.mapper.ActionMapper;
import org.apache.struts2.dispatcher.mapper.ActionMapping;
import org.apache.struts2.views.util.UrlHelper;

import ssdevframework.core.collection.CData;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.inject.Inject;
import com.opensymphony.xwork2.util.logging.Logger;
import com.opensymphony.xwork2.util.logging.LoggerFactory;
import com.opensymphony.xwork2.util.reflection.ReflectionException;
import com.opensymphony.xwork2.util.reflection.ReflectionExceptionHandler;

public class ServletRedirectParamsResult extends StrutsResultSupport implements ReflectionExceptionHandler {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4074932753053468696L;

	private static final Logger LOG = LoggerFactory.getLogger(ServletRedirectResult.class);

	protected boolean prependServletContext = true;

	protected ActionMapper actionMapper;

	protected int statusCode = SC_FOUND;

	protected boolean supressEmptyParameters = false;

	protected Map<String, String> requestParameters = new LinkedHashMap<String, String>();

	protected String anchor;

	public ServletRedirectParamsResult() {
		super();
	}

	public ServletRedirectParamsResult(String location) {
		this(location, null);
	}

	public ServletRedirectParamsResult(String location, String anchor) {
		super(location);
		this.anchor = anchor;
	}

	@Inject
	public void setActionMapper(ActionMapper mapper) {
		this.actionMapper = mapper;
	}

	public void setStatusCode(int code) {
		this.statusCode = code;
	}

	/**
	 * Set the optional anchor value.
	 * @param anchor
	 */
	public void setAnchor(String anchor) {
		this.anchor = anchor;
	}

	/**
	 * Sets whether or not to prepend the servlet context path to the redirected URL.
	 *
	 * @param prependServletContext <tt>true</tt> to prepend the location with the servlet context path,
	 *                              <tt>false</tt> otherwise.
	 */
	public void setPrependServletContext(boolean prependServletContext) {
		this.prependServletContext = prependServletContext;
	}

	public void execute(ActionInvocation invocation) throws Exception {
		if (anchor != null) {
			anchor = conditionalParse(anchor, invocation);
		}

		super.execute(invocation);
	}

	/**
	 * Redirects to the location specified by calling {@link HttpServletResponse#sendRedirect(String)}.
	 *
	 * @param finalLocation the location to redirect to.
	 * @param invocation    an encapsulation of the action execution state.
	 * @throws Exception if an error occurs when redirecting.
	 */
	protected void doExecute(String finalLocation, ActionInvocation invocation) throws Exception {
		ActionContext ctx = invocation.getInvocationContext();
		HttpServletRequest request = (HttpServletRequest) ctx.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) ctx.get(ServletActionContext.HTTP_RESPONSE);

		if (isPathUrl(finalLocation)) {
			if (!finalLocation.startsWith("/")) {
				ActionMapping mapping = actionMapper.getMapping(request, Dispatcher.getInstance()
						.getConfigurationManager());
				String namespace = null;
				if (mapping != null) {
					namespace = mapping.getNamespace();
				}

				if ((namespace != null) && (namespace.length() > 0) && (!"/".equals(namespace))) {
					finalLocation = namespace + "/" + finalLocation;
				} else {
					finalLocation = "/" + finalLocation;
				}
			}

			// if the URL's are relative to the servlet context, append the servlet context path
			if (prependServletContext && (request.getContextPath() != null) && (request.getContextPath().length() > 0)) {
				finalLocation = request.getContextPath() + finalLocation;
			}
			CData data = (CData) invocation.getStack().findValue("data", CData.class);
			for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();) {
				String key = (String) iterator.next();
				if (key.startsWith("query") || "selShowpageNO".equals(key) || "selPageRow".equals(key)
						|| "selPageOrderBy".equals(key) || "selPageOrder".equals(key)) {
					requestParameters.put(key, data.getString(key));
				}
			}

			StringBuilder tmpLocation = new StringBuilder(finalLocation);
			UrlHelper.buildParametersString(requestParameters, tmpLocation, "&");

			// add the anchor
			if (anchor != null) {
				tmpLocation.append('#').append(anchor);
			}

			finalLocation = response.encodeRedirectURL(tmpLocation.toString());
		}

		if (LOG.isDebugEnabled()) {
			LOG.debug("Redirecting to finalLocation " + finalLocation);
		}

		sendRedirect(response, finalLocation);
	}

	protected List<String> getProhibitedResultParams() {
		return Arrays.asList(new String[] { DEFAULT_PARAM, "namespace", "method", "encode", "parse", "location",
				"prependServletContext", "supressEmptyParameters", "anchor" });
	}

	/**
	 * Sends the redirection.  Can be overridden to customize how the redirect is handled (i.e. to use a different
	 * status code)
	 *
	 * @param response The response
	 * @param finalLocation The location URI
	 * @throws IOException
	 */
	protected void sendRedirect(HttpServletResponse response, String finalLocation) throws IOException {
		if (SC_FOUND == statusCode) {
			response.sendRedirect(finalLocation);
		} else {
			response.setStatus(statusCode);
			response.setHeader("Location", finalLocation);
			response.getWriter().write(finalLocation);
			response.getWriter().close();
		}

	}

	private static boolean isPathUrl(String url) {
		// filter out "http:", "https:", "mailto:", "file:", "ftp:"
		// since the only valid places for : in URL's is before the path specification
		// either before the port, or after the protocol
		return (url.indexOf(':') == -1);
	}

	/**
	 * Sets the supressEmptyParameters option
	 *
	 * @param supressEmptyParameters The new value for this option
	 */
	public void setSupressEmptyParameters(boolean supressEmptyParameters) {
		this.supressEmptyParameters = supressEmptyParameters;
	}

	/**
	 * Adds a request parameter to be added to the redirect url
	 *
	 * @param key The parameter name
	 * @param value The parameter value
	 */
	public ServletRedirectParamsResult addParameter(String key, Object value) {
		requestParameters.put(key, String.valueOf(value));
		return this;
	}

	public void handle(ReflectionException ex) {
		// Only log as debug as they are probably parameters to be appended to the url
		LOG.debug(ex.getMessage(), ex);
	}
}
