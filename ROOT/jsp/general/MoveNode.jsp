<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%>
<%@page import="tea.ui.*" import="tea.entity.node.*" import="tea.html.*" import="tea.db.*" import="tea.entity.site.*" import="tea.resource.*" import="java.util.*" import="java.io.*"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
AccessMember am =AccessMember.find(teasession._nNode, teasession._rv);
if(am.getPurview()<3)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
	return;
}

Http h=new Http(request,response);


Resource r=new Resource("/tea/ui/node/general/MoveNode");

String title=r.getString(teasession._nLanguage, "MoveNode");

Node node =Node.find(teasession._nNode);

%><html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<title><%=title%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.NewFather.focus();">
<%=tea.ui.node.general.NodeServlet.getButton(node,h, am,request)%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" METHOD=POST action="/servlet/MoveNode" onSubmit="return(submitInteger(this.NewFather, '<%=r.getString(teasession._nLanguage, "InvalidNewFather")%>'));">
<input type='hidden' name='node' VALUE="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "NewFather")%>:</td>
    <td>
      <input type="text" class="edit_input" name="NewFather" mask="int">
      <input type="checkbox" name="flag" id="flag" /><label for="flag">只移动子节点</label>
      <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
    </td>
  </tr>
  </table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
