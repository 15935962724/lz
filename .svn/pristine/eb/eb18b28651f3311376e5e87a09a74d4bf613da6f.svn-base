<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Community community=Community.find(teasession._strCommunity);
//if(teasession._rv.toString()==null)
//{
//  response.sendRedirect("/jsp/user/StartLogin.jsp");
//  return ;
//}
String member = request.getParameter("member");
System.out.print("member: "+member);
Profile obj = Profile.find(member);
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=obj.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body id="bodynone">
<h1>会员详细资料</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<form action="">
<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="tablebgnone" class="register">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <TD>会员ID：</TD>
    <td><font color="#DF451C"><strong><%=obj.getMember()%></strong></font></td>
  </tr>
    <tr>
    <TD>姓名：</td>
    <td><%=obj.getFirstName(teasession._nLanguage) %></TD>
    </tr>
    <tr>
    <TD>性别：</td>
    <td><%=obj.isSex()?"男":"女"%></TD>
  </tr>
  <tr>
    <TD>电子邮箱：</TD>
    <td><%=obj.getEmail() %> </td>
  </tr>
  <tr>
    <TD>移动电话：</TD>
    <td><%=obj.getMobile() %> </td>
  </tr>
  <tr>
    <TD>证件类型：</TD>
   <td><%=Common.CARDT_TYPE[obj.getCardType()] %></td>
  </tr>
  <tr>
    <TD>证件号码：</TD>
    <td><%=obj.getCard() %></td>
  </tr>
</table>
</div>
<center>
<input type=button value="返回" onClick="javascript:history.back()">
</center>
</form>
<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
</body>
</html>
