<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
response.sendRedirect("/servlet/EditNode?Type=70&node="+teasession._nNode);
%>

