<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.member.*" %>
<%
TeaSession teasession=new TeaSession(request);
ProfileBBS bbs = ProfileBBS.find(teasession._strCommunity,teasession._rv.toString());
if(bbs.isValidate()||teasession._rv._strV.equals("webmaster"))
{
%>
<a href="/jsp/type/bbs/EditBBSReply.jsp?Node=<%=teasession._nNode%>">
<img src="/res/redribbon/u/0902/090264245.gif"></a>
<%
}
%>





