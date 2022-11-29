<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/request/Requests").add("/tea/ui/member/request/NodeRequests");
/*
if(AccessMember.find(teasession._nNode,teasession._rv._strV).isAuditing())
{
    response.sendError(403);
    return;
}
*/
String s = request.getParameter("pos");
int i = s != null ? Integer.parseInt(s) : 0;
int j = Node.countRequests(teasession._nNode);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "NodeRequests")+"("+j+")"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<!--<div id="pathdiv"> <%=ts.hrefGlance(teasession._rv)%> ><A href="/servlet/Requests"><%=r.getString(teasession._nLanguage, "Requests")%></A> ><A href="/servlet/NodeRequestNodes"><%=r.getString(teasession._nLanguage, "NodeRequestNodes")%></A> ><%=r.getString(teasession._nLanguage, "NodeRequests")%></div>-->

<FORM NAME=form1 METHOD=POST action="/servlet/GrantNodeRequests">
<INPUT TYPE=HIDDEN NAME=node VALUE="<%=teasession._nNode%>">
<INPUT TYPE=HIDDEN NAME=pos VALUE="<%=i%>">

<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<%
for(Enumeration enumeration = Node.findRequests(teasession._nNode, i, 25); enumeration.hasMoreElements(); )
{
  int k = ((Integer)enumeration.nextElement()).intValue();
  Node node1 = Node.find(k);
  %>	
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';">
    <TD><INPUT  id=CHECKBOX type="CHECKBOX" NAME="nodes" VALUE="<%=k%>" CHECKED></TD>
      <!--TD><%=(node1.getAncestor(teasession._nLanguage, "_blank"))%></td-->
     <!-- <TD><a href="/servlet/Node?node=<%=(node1._nNode)%>"><%=(node1.getSubject(teasession._nLanguage))%></a></td>-->
       <TD><%=(node1.getSubject(teasession._nLanguage))%></td>
      <td><%=node1.getCreator()%> </TD>
      <td><A href="/jsp/request/NodePreview.jsp?node=<%=k%>" target="_blank"><%=r.getString(teasession._nLanguage, "Preview")%></a></td>
</TR>
<%
}
%>
<tr>
<td><input id=CHECKBOX type="checkbox" checked onClick="selectAll(form1.nodes,checked)"></td>
<td><%=r.getString(teasession._nLanguage,"全选")%><%=new FPNL(teasession._nLanguage, "?node=" + teasession._nNode + "&pos=", i, j)%></td>
<td>&nbsp;</td>
</tr>
</table>

<input class="edit_button" type=SUBMIT name="Grant" value="<%=r.getString(teasession._nLanguage, "Grant")%>">
<input class="edit_button" type=SUBMIT name="Deny" value="<%=r.getString(teasession._nLanguage, "Deny")%>">
<input class="edit_button" type=Button onClick="window.open('/servlet/Node?node=<%=teasession._nNode%>','_self')" value="<%=r.getString(teasession._nLanguage, "CBBack")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
