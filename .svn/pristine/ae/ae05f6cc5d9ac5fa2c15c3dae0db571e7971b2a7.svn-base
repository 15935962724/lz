<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("tea/ui/member/request/Requests").add("tea/ui/member/request/NodeRequests");
if(!node.isCreator(teasession._rv)&&!AccessMember.find(teasession._nNode,teasession._rv._strV).isAuditing())
{
    response.sendError(403);
    return;
}
String nexturl = request.getRequestURI()+"?node="+teasession._nNode;
String s = request.getParameter("pos");
int i = s != null ? Integer.parseInt(s) : 0;//设置pos的值 分页
int j = Node.countRequests(teasession._nNode);

%>
<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage, "NodeRequests")+"("+j+")"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<!--<div id="pathdiv"> <%=ts.hrefGlance(teasession._rv)%> ><A href="/servlet/Requests"><%=r.getString(teasession._nLanguage, "Requests")%></A> ><A href="/servlet/NodeRequestNodes"><%=r.getString(teasession._nLanguage, "NodeRequestNodes")%></A> ><%=r.getString(teasession._nLanguage, "NodeRequests")%></div>-->
<!--/servlet/GrantNodeRequests-->
<FORM NAME=form1 METHOD=POST action="/jsp/request/NodeRequestsShow.jsp">
<INPUT TYPE=HIDDEN NAME=node VALUE="<%=teasession._nNode%>">
<INPUT TYPE=HIDDEN NAME=pos VALUE="<%=i%>">


<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<tr id=tableonetr>

<td>公司名称</td>
<td>用户名</td>
<td>操作</td>
</tr>
<%
for(Enumeration enumeration = Node.findRequests(teasession._nNode, i, 25); enumeration.hasMoreElements(); )
{
  int k = ((Integer)enumeration.nextElement()).intValue();
  Node node1 = Node.find(k);
  %>
  <tr  onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';">

      <%--TD><%=(node1.getAncestor(teasession._nLanguage, "_blank"))%></td
      <TD><a href="/servlet/Node?node=<%=(node1._nNode)%>"><%=(node1.getSubject(teasession._nLanguage))%></a></td>--%>
       <td><a href="/servlet/Node?node=<%=(node1._nNode)%>"><%=(node1.getSubject(teasession._nLanguage))%></a></td>
      <td><%=node1.getCreator()%> </TD>
      <%--<td><A href="/jsp/request/NodePreview.jsp?node=<%=k%>" target="_blank"><%=r.getString(teasession._nLanguage, "Preview")%></a></td>--%>
      <td><input type="button" value="审核" onclick="window.open('/jsp/request/NodeRequestsShow.jsp?node=<%=k%>&nexturl=<%=nexturl%>','_self');" /></td>
</TR>
<%
}
%>

</table>
<%--
<input class="edit_button" type=SUBMIT name="Grant" value="<%=r.getString(teasession._nLanguage, "Grant")%>">
<input class="edit_button" type=SUBMIT name="Deny" value="<%=r.getString(teasession._nLanguage, "Deny")%>">
<input class="edit_button" type=Button onClick="window.open('/servlet/Node?node=<%=teasession._nNode%>','_self')" value="<%=r.getString(teasession._nLanguage, "CBBack")%>">--%>
</form>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</HTML>
