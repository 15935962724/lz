<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
 response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
 return;
}

String index=request.getParameter("index");
String field=request.getParameter("field");

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
<br/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

                <%
                java.util.Enumeration enumer=tea.entity.node.SMSGroup.findByMember(teasession._strCommunity,teasession._rv.toString());
                while(enumer.hasMoreElements())
                {
                  int id=((Integer)enumer.nextElement()).intValue() ;
                  tea.entity.node.SMSGroup smsg=tea.entity.node.SMSGroup.find(id);

                %>
               <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                  <td  align=center><A href="/jsp/sms/psmanagement/UserList6.jsp?node=<%=teasession._nNode%>&groupid=<%=id%>&index=<%=index%>&field=<%=field%>" title="<%=smsg.getDiscript()%>" target="framegu_mainframe"><%=smsg.getName()+" ("+SMSPhoneBook.countByGroup(id)+")"%></A></td>
                </tr>
               <%}%>
                <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                  <td  align=center ><A href="/jsp/sms/psmanagement/UserList6.jsp?node=<%=teasession._nNode%>&groupid=0&index=<%=index%>&field=<%=field%>" title="" target="framegu_mainframe"><%=r.getString(teasession._nLanguage,"Other")+" ("+SMSPhoneBook.count(teasession._rv._strV,teasession._strCommunity," AND groupid=0")+")"%></A></td>
                </tr>
</table>



<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

