<%@page import="tea.entity.Http"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%
Http h=new Http(request,response);
String access_token=request.getParameter("access_token");
String nurl = "https://graph.qq.com/oauth2.0/me?access_token="+access_token;//拼获取openid请求的url
HttpClient client=new HttpClient();
HttpMethod method=new GetMethod(nurl);//请求获取openid
client.executeMethod(method);
String json_str=method.getResponseBodyAsString();
method.releaseConnection(); //释放连接
String str = json_str.substring(json_str.indexOf("(")+1,json_str.indexOf(")"));
JSONObject obj = new JSONObject(str);
String openid = (String)obj.get("openid");
out.print("<script>location='"+"/jsp/pcadmin/loginAjax.jsp?act=qq&openid="+openid+"&access_token="+access_token+"';</script>");//发送到下个页面
%>
</body>
</html>