<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.ui.TeaSession" %><%

request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);

int type=h.getInt("type");

int id=h.getInt("id");


%><html>

<frameset cols="250,*"  border="1" framespacing="0">
  <frame src="/jsp/site/HelpLists.jsp?community=<%=h.community%>&type=<%=type%>&id=<%=id%>" name="leftFrame" scrolling="No"  />
  <frame src="/jsp/site/HelpContent.jsp?community=<%=h.community%>&help=0" name="help_content" id="mainFrame" title="mainFrame" />
</frameset><noframes></noframes>

</html>
