<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.*" %>
<%request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
 response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
 return;
}

Resource r=new Resource("/tea/resource/Group");
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage,"SelectGroup")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <%
 java.util.Enumeration enumer=AdminUnit.findByCommunity(teasession._strCommunity,"");
 while(enumer.hasMoreElements())
 {
   AdminUnit au_obj=(AdminUnit)enumer.nextElement();
   int id=au_obj.getId();

 %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   <td  align=center><A href="/jsp/sms/psmanagement/UserList5.jsp?node=<%=teasession._nNode%>&groupid=<%=id%>&index=<%=request.getParameter("index")%>&field=<%=request.getParameter("field")%>" target="framegu_mainframe"><%=au_obj.getName()+" ("+AdminUsrRole.count(teasession._strCommunity," AND DATALENGTH(role)>1 AND unit="+id)+")"%></A></td>
 </tr>
<%}%>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   <td  align=center ><A href="/jsp/sms/psmanagement/UserList5.jsp?node=<%=teasession._nNode%>&groupid=0&index=<%=request.getParameter("index")%>&field=<%=request.getParameter("field")%>" title="" target="framegu_mainframe"><%=r.getString(teasession._nLanguage,"Other")+" ("+AdminUsrRole.count(teasession._strCommunity," AND DATALENGTH(role)>1 AND unit=0")+")"%></A></td>
 </tr>
</table>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
