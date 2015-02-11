package com.csValue.common.util.page;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import org.apache.ibatis.executor.statement.PreparedStatementHandler;
import org.apache.ibatis.executor.statement.RoutingStatementHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.RowBounds;
import org.hibernate.dialect.MySQL5InnoDBDialect;

@Intercepts({ @Signature(type = StatementHandler.class, method = "prepare", args = { Connection.class }) })
public class DiclectStatementHandlerInterceptor implements Interceptor {

	private static final String DIALECT = "org.hibernate.dialect.MySQL5InnoDBDialect";

	@SuppressWarnings("unchecked")
	public Object intercept(Invocation invocation) throws Throwable {
		RoutingStatementHandler statement = (RoutingStatementHandler) invocation.getTarget();
		Object obj = ReflectUtil.getFieldValue(statement, "delegate");
		if (!(obj instanceof PreparedStatementHandler)) {
			return invocation.proceed();
		}
		PreparedStatementHandler handler = (PreparedStatementHandler) obj;
		RowBounds rowBounds = (RowBounds) ReflectUtil.getFieldValue(handler, "rowBounds");
		Configuration conf = (Configuration) ReflectUtil.getFieldValue(handler, "configuration");
		MappedStatement ms = (MappedStatement) ReflectUtil.getFieldValue(handler, "mappedStatement");

		if (rowBounds.getLimit() > 0 && rowBounds.getLimit() < RowBounds.NO_ROW_LIMIT) {
			BoundSql boundSql = statement.getBoundSql();
			String sql = boundSql.getSql();

			MySQL5InnoDBDialect dialect = (MySQL5InnoDBDialect) Class.forName(DIALECT).newInstance();
			sql = dialect.getLimitString(sql, rowBounds.getOffset(), rowBounds.getLimit());
			HashMap map = (HashMap) boundSql.getParameterObject();
			/*HashMap addPms  =(HashMap) ReflectUtil.getFieldValue(boundSql, "additionalParameters");
			if(addPms==null||addPms.size()==0)
				addPms.put("_parameter", map);*/
			/*
			 * mysql limit n,m表示从n+1开始，取m行数据。修改之前，limit取偏移量+步进量。offset取偏移量。
			 * 造成每次从偏移量+步进值开始取，取的行的长度为偏移量的值。
			 * 举例说明：
			 * 假设当前取第三页，每页行数为15.则在此处，偏移量为：15*（3-1）-30，步进量：15
			 * 修改之前实际取值为：取数开始位置：偏移量+步进量=45，取数行数为：偏移量=30
			 * 实际上正确的取值为：取数开始位置：偏移量=30，取数行数为：步进量：15
			 * 故对代码按照正确逻辑进行修改。
			 * modified by 曹圣泉 2011-01-11
			 */
			/*map.put("Limit", rowBounds.getOffset() + rowBounds.getLimit());
			if (rowBounds.getOffset() != 0)
				map.put("Offset", rowBounds.getOffset());
			List<ParameterMapping> psMap = boundSql.getParameterMappings();
			List psMapL = new ArrayList(psMap);

			ParameterMapping p1 = new ParameterMapping.Builder(conf, "Limit", Object.class).build();
			psMapL.add(p1);
			if (rowBounds.getOffset() != 0) {
				ParameterMapping p = new ParameterMapping.Builder(conf, "Offset", Object.class).build();
				psMapL.add(p);
			}*/
			map.put("Limit", rowBounds.getLimit());
			if (rowBounds.getOffset() != 0)
				map.put("Offset", rowBounds.getOffset());
			List<ParameterMapping> psMap = boundSql.getParameterMappings();
			List psMapL = new ArrayList(psMap);

			if (rowBounds.getOffset() != 0) {
				ParameterMapping p = new ParameterMapping.Builder(conf, "Offset", Object.class).build();
				psMapL.add(p);
			}
			ParameterMapping p1 = new ParameterMapping.Builder(conf, "Limit", Object.class).build();
			psMapL.add(p1);
			ReflectUtil.setFieldValue(boundSql, "parameterMappings", psMapL);
			ReflectUtil.setFieldValue(boundSql, "parameterObject", map);
			ReflectUtil.setFieldValue(boundSql, "sql", sql);
		} else if (rowBounds.getLimit() == -100) {//获取总页数
			BoundSql boundSql = statement.getBoundSql();
			String sql = boundSql.getSql();

			sql = "select count(*) \"totalCount\" from (" + sql + ") tmp";
			ReflectUtil.setFieldValue(boundSql, "sql", sql);
		}

		return invocation.proceed();
	}

	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	public void setProperties(Properties properties) {
	}
}
