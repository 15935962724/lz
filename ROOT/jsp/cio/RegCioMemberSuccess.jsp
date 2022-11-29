<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();

String member=teasession._rv._strV;
Profile p=Profile.find(member);
String pwd=p.getPassword();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="qiyelog">
<div id="qiyelog_01">
<div id="qiyelog_02">
<div id="title_01"></div>
<div id="title_02">
  <h1>地方企业参会注册</h1>
</div>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<h2>您以注册成功</h2>
<table>
  <tr>
    <td>您的用户名:<%=member%> 密码:<%=pwd%></td>
    </tr>
  <tr>
    <td>请您牢记此用户名密码,以便下次登陆管理您的参会信息!</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    </tr>
  <tr>
    <td>您现在可以马上提交您的参会报名表了:</td>
  </tr>
  <tr>
    <td><a href="/jsp/cio/EditCioCompany.jsp?community=<%=teasession._strCommunity%>"><img src="/res/cavendishgroup/u/0810/081011517.jpg" border="0" /></a></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>如遇问题请马上联系<br/>010-61392325</td>
  </tr>
</table>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</div>
</div>
</body>
</html>
