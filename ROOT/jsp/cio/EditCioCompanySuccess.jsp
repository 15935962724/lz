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

int ciocompany=Integer.parseInt(request.getParameter("ciocompany"));
CioCompany cc=CioCompany.find(ciocompany);

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
  <h1>地方企业参会申请</h1>
</div>
<div id="head6"><img height="6" src="about:blank"></div>
<table>
  <tr>
    <td><b>您的参会申请以成功提交,请等候我们的确认,并给您发送参会回执</b></td>
  </tr>
  <tr>
    <td>您的<%=cc.isCentral()?"企业序号":"用户名"%>:<%=member%> 密码:<%=pwd%></td>
  </tr>
  <tr>
    <td>请您牢记此用户名密码,以便下次登陆管理您的参会信息!</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>您的参会信息如需修改请进入:</td>
  </tr>
  <tr>
    <td><a href="/jsp/cio/EditCioCompany.jsp?community=<%=teasession._strCommunity%>"><img src="/res/cavendishgroup/u/0810/081011523.jpg" border="0" /></a></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>了解会议其它信息请<a href="/">回会议首页</a></td>
  </tr>
  <tr>
    <td>如遇问题请马上联系<br/>
      010-61392325</td>
  </tr>
</table>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</div>
<div class="banq_xx">管理维护：国资委信息中心　　　　国资委地址：北京市宣武西大街26号（10053）京ICP备030066号</div>
</div>
</body>
</html>
