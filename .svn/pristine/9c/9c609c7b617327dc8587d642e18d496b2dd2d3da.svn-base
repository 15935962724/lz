<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%
request.setCharacterEncoding("UTF-8");

Resource r = new Resource("tea/htmlx/HtmlX");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl = teasession.getParameter("nexturl");//request.getRequestURI()+"?"+request.getContextPath();
String member = teasession.getParameter("member");


Profile pobj = Profile.find(member);



%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>

<body bgcolor="#ffffff">

<h1>作者信息</h1>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
   <td align="right"><font color="red">*</font>&nbsp;会员ID：</td>
   <td><%=member %></td>
  </tr>
  <tr>
   <td align="right"><font color="red">*</font>&nbsp;昵称：</td>
   <td><%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)%></td>
  </tr>
  <tr>
   <td align="right"><font color="red">*</font>&nbsp;联系电话：</td>
   <td><%=pobj.getTelephone(teasession._nLanguage)%></td>
  </tr>
  <tr> 
   <td align="right"><font color="red">*</font>&nbsp;性别：</td>
   <td><%if(!pobj.isSex()){out.print("男");} %>  <%if(pobj.isSex()){out.print("女");} %></td>
  </tr>
  <tr>
   <td align="right"><font color="red">*</font>&nbsp;国籍：</td>
   <td><%=r.getString(teasession._nLanguage,"Country."+pobj.getCountry(teasession._nLanguage))%></td>
  </tr>

 <tr>
   <td align="right"><font color="red">*</font>&nbsp;现居住城市：</td>
   <td><%=pobj.getAddress(teasession._nLanguage)%></td>
 </tr>
</table>


</body>
</html>
