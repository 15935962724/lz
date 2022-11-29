<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.ocean.*"%><%@page import="tea.entity.site.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession =new TeaSession(request);
String ids[]=request.getParameterValues("ids");



String oceancard =teasession.getParameter("oceancard");
response.setHeader("Content-Disposition", "attachment; filename=exp.doc");



%>
<html>
<head>
<base href="http://<%=request.getServerName()+":"+request.getServerPort()%>/"/>

<style type="text/css">
tea/CssJs/bj-sea.css
</style>
<title>
海洋馆图片征集表
</title>
</head>
<body bgcolor="#ffffff">
<h1>
海洋馆图片征集表
</h1>
<%

for(int iiii=0;iiii<ids.length;iiii++)
{
LevyPicture lpoj = LevyPicture.find(Integer.parseInt(ids[iiii]));
if(iiii>0)out.print("<hr>");
%>
<form action="">
<table border="1" id="tablecenter">
    <tr><td nowrap="nowrap">姓名：</td><td><%if(lpoj.getFirstname()!=null)out.print(lpoj.getFirstname());%></td></tr>
    <tr><td nowrap="nowrap">联系电话：</td><td><%if(lpoj.getTel()!=null)out.print(lpoj.getTel());%></td></tr>
    <tr><td nowrap="nowrap">身份证号码：</td><td><%if(lpoj.getCard()!=null)out.print(lpoj.getCard());%></td></tr>
    <%
    if(lpoj.getPath()!=null)
    {
      %>
      <tr><td>作品显示：</td><td><img alt="" src="<%=lpoj.getPath()%>" /></td>
      </tr>

      <%
    }
    %>
</table>
</form>
<%}%>

</body>
</html>
