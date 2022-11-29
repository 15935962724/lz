<%@page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<body>
<%          

String ua = request.getHeader("user-agent");
if(ua!=null&&ua.indexOf("http://")!=-1)
{
  //String re=request.getHeader("referer");
  //String ip=request.getRemoteAddr();
  //System.out.println("\r\nUA:"+ua);
  //System.out.println("IP:"+ip);
  //System.out.println("RE:"+re);
  %>
<a href="http://down.c06.net/html/N22160.html" target="_top">极品五笔</a>

<script language="javascript" type="text/javascript" src="http://js.users.51.la/1373439.js"></script>
<noscript><img src="http://img.users.51.la/1373439.asp" /></noscript>
<%
}
%>
</body>
</html>
