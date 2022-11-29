<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.entity.node.Node"%>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community=Node.find(teasession._nNode).getCommunity();
%>
<SELECT NAME="orgid" STYLE="WIDTH: 292px">
<OPTION VALUE="">--请选择招聘机构--</OPTION>
<%java.util.Enumeration enumeration=tea.entity.node.Node.findByType(21,community);int nodeCode;
while(enumeration.hasMoreElements()){
   nodeCode =((Integer)enumeration.nextElement()).intValue();
%>
<OPTION VALUE="<%=nodeCode%>"><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></OPTION>
<%}enumeration=tea.entity.node.Node.findByType(18,community);
while(enumeration.hasMoreElements()){
     nodeCode =((Integer)enumeration.nextElement()).intValue();
%>
<OPTION VALUE="<%=nodeCode%>" ><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></OPTION>
<%}%>
</SELECT>

