<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

Http h=new Http(request,response);



Node node=Node.find(teasession._nNode);
tea.entity.node.AccessMember am = null;
if (teasession._rv != null)
{

  am = tea.entity.node.AccessMember.find(teasession._nNode, teasession._rv._strV);

}


String nr = tea.ui.node.general.NodeServlet.getButton(node,h, am,request);

String community=node.getCommunity();

if(!teasession._rv.isOrganizer(node.getCommunity()) && !teasession._rv.isWebMaster())
{
  response.sendError(403);
  return;
}

RV rv = node.getCreator();

Resource r=new Resource("/tea/ui/node/general/ReplaceCreator");

String title=r.getString(teasession._nLanguage, "InsteadAuthor");
%>
<html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<title><%=title%></title>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<%=nr%>
<body onload="document.foReplace.MemberId.focus();">
  <h1><%=title%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <form name=foReplace METHOD=POST action="/servlet/ReplaceCreator" onSubmit="return(submitText(this.MemberId, '<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&(this.submit.disabled=true) );">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr><td><input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <%=tea.http.RequestHelper.format(r.getString(teasession._nLanguage, "InfReplaceCreator"), "<A href=/jsp/access/Glance.jsp?Member="+rv+" >"+rv+"</A>")%>
    <input type="TEXT" class="edit_input"  name=MemberId>
    </td></tr>
    <tr>
    <td><input  id="radio" type="radio" name=ApplyTo VALUE=ThisNode CHECKED><%=r.getString(teasession._nLanguage, "ApplyToThisNode")%>
    <input  id="radio" type="radio" name=ApplyTo VALUE=ThisTree><%=r.getString(teasession._nLanguage, "ApplyToThisTree")%>
    <input  id="radio" type="radio" name=ApplyTo VALUE=ThisCommunity><%=r.getString(teasession._nLanguage, "ApplyToThisCommunity")%>
	</td>
	</tr>
    <tr>
    <td>
    <input type="submit" name="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="window.history.back();">
	</td>
	</tr>
	</table>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
    <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

