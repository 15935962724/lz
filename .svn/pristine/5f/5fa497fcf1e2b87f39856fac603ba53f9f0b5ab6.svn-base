<%@page import="sun.net.www.http.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.member.Logs"%>
<%@page import="tea.entity.member.OnlineList"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.Seq"%>
<%@page import="tea.entity.RV"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<!-- qq登陆  -->
<body>
<%
try{
Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
String code=request.getParameter("code");//获取返回code
String url = "https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id=101144312&client_secret=e7e146844650eca81ab29d0f002c0e03&code="+code+"&redirect_uri=www.fashiongolf.com/jsp/pcadmin/qqlogin.jsp";
String json_str="";
String myurl = "";
	HttpClient client=new HttpClient();
	HttpMethod method=new GetMethod(url);//发送请求
	client.executeMethod(method);
	json_str=method.getResponseBodyAsString();//获得token
	method.releaseConnection(); //释放连接
	out.print("<script>location='/jsp/pcadmin/NextQQ.jsp?"+json_str+"';</script>");
}catch(Exception e){
	out.print("<script>alert('登陆失败！请重试');location='/';</script>");
}
%>
</head>
</body>
</html>