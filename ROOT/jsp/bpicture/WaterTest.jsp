<%@ page contentType="text/html; charset=UTF-8" %>
<%
tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
tea.entity.site.Watermark.mark(teasession._strCommunity,new java.io.File("C:/Documents and Settings/Administrator/My Documents/My Pictures/2198305.jpg"));
%>
