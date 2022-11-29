<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;


%>

<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">

 <tr id="tableonetr"> 
      <td nowrap >1分</td>
       <td nowrap><div style="width:<%=Eventregistration.getMembericon(teasession._strCommunity,teasession._nNode,Eventregistration.Count(teasession._strCommunity," and node="+teasession._nNode+" and score =1 ")) %>;background:#1874CD;height:5px"></div></td>
</tr>
<tr id="tableonetr">
  
      <td nowrap >2分</td> 
       <td nowrap ><div style="width:<%=Eventregistration.getMembericon(teasession._strCommunity,teasession._nNode,Eventregistration.Count(teasession._strCommunity," and node="+teasession._nNode+" and score =2 ")) %>;background:#1874CD;height:5px"></div></td>
</tr>
<tr id="tableonetr">
 
      <td nowrap >3分</td>
       <td nowrap ><div style="width:<%=Eventregistration.getMembericon(teasession._strCommunity,teasession._nNode,Eventregistration.Count(teasession._strCommunity," and node="+teasession._nNode+" and score =3 ")) %>;background:#1874CD;height:5px"></div></td>
</tr>
<tr id="tableonetr">
 
      <td nowrap >4分</td>
       <td nowrap ><div style="width:<%=Eventregistration.getMembericon(teasession._strCommunity,teasession._nNode,Eventregistration.Count(teasession._strCommunity," and node="+teasession._nNode+" and score =4 ")) %>;background:#1874CD;height:5px"></div></td>
</tr>
<tr id="tableonetr">
 
      <td nowrap >5分</td>
       <td nowrap ><div style="width:<%=Eventregistration.getMembericon(teasession._strCommunity,teasession._nNode,Eventregistration.Count(teasession._strCommunity," and node="+teasession._nNode+" and score =5 ")) %>;background:#1874CD;height:5px"></div></td>
</tr>
 
</table>
