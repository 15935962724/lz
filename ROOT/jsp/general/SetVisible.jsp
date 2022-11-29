<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%>
<%@page import="tea.ui.*" import="tea.entity.node.*" import="tea.html.*" import="tea.db.*" import="tea.entity.site.*" import="tea.resource.*" import="java.util.*" import="java.io.*"%>
<%
TeaSession teasession=new TeaSession(request);

AccessMember am = AccessMember.find(teasession._nNode, teasession._rv);

Node node = Node.find(teasession._nNode);
Resource r=new Resource();
boolean flag = teasession._rv!=null&&teasession._rv.isOrganizer(node.getCommunity());
boolean flag1 = Node.find(node.getFather()).isCreator(teasession._rv);

String[] nodes = request.getParameterValues("nodes");
if (!am.isAuditing()&&!flag && !flag1 && (!node.isCreator(teasession._rv) || node.isHidden()) )
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Http h=new Http(request,response);


String title=r.getString(teasession._nLanguage, "CBSetVisible");

%>
<html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%=tea.ui.node.general.NodeServlet.getButton(node,h, am,request)%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <FORM name=foSet METHOD=POST action="/servlet/SetVisible" onsubmit="this.submit.disabled=true;">
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <input type="hidden" name="nodes" value="<%=nodes%>">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr><td>
    <input  id="CHECKBOX" type="CHECKBOX" name=NodeOHidden value=null <%if(node.isHidden())out.print(" checked='true'");%>>
    <%=r.getString(teasession._nLanguage, "NodeOHidden")%>
    <input type="submit" name="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="window.history.back();">
    </td></tr>
    </table>

  </FORM>

<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
