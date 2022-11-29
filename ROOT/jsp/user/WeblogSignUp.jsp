<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import = "tea.entity.site.Community" %>
<%@ page import = "tea.entity.node.Node" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import="tea.ui.TeaServlet"%>
<%
        TeaSession teasession = new TeaSession(request);

        String comm=Node.find(teasession._nNode).getCommunity();
        if(comm==null)
        {
          response.sendError(404);
          return;
        }
        Resource r = new Resource("/tea/ui/util/SignUp");
        Community community = Community.find(comm);
            String ss = community.getTerm(teasession._nLanguage);


%>
<html>
<head>
<link href="/tea/CssJs/<%=comm%>.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ServerArticle")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <fieldset>
 
  <%=ss%>
    <input type='hidden' name=NextUrl VALUE="/servlet/Node?node=<%=teasession._nNode%>">
          <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <input type=button class="edit_button" VALUE="关闭" onClick="window.close();">
  </fieldset>
 <div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

