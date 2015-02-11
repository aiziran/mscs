package com.csValue.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

public class SocketSender
{
  public static String httpSend(String ip, String content)
  {
    System.out.println("-------------");
    String result = "";
    PostMethod post = new PostMethod("http://192.168.1.199/LedWeb/WebForm1.aspx");
    post.getParams().setParameter("http.protocol.content-charset", "utf-8");
    try
    {
      NameValuePair[] data = { 
        new NameValuePair("ip", ip), 
        new NameValuePair("content", content) };

      post.setRequestBody(data);

      HttpClient client = new HttpClient();

      client.executeMethod(post);

      byte[] responseBody = post.getResponseBodyAsString().getBytes(post.getResponseCharSet());

      String response = new String(responseBody, "utf-8");
      result = response;
      System.out.println("-返回结果:" + response);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    finally
    {
      post.releaseConnection();
    }
    return result;
  }

  public static void send(String msg)
  {
    try
    {
      System.out.println("SocketSender=========》》》》》》执行中");

      Socket socket = new Socket("192.168.1.199", 6666);

      System.out.println("SocketSender=========》》》》》》");
      OutputStream os = socket.getOutputStream();
      PrintWriter pw = new PrintWriter(os);

      InputStream is = socket.getInputStream();
      BufferedReader br = new BufferedReader(new InputStreamReader(is));

      pw.write(msg);
      pw.flush();
      socket.shutdownOutput();

      br.close();
      is.close();
      pw.close();
      os.close();
      socket.close();
    } catch (UnknownHostException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  public static void main(String[] args) { String content = "中国人EEERRRTTTT";
    httpSend("192.1.1.1", content);
  }
}