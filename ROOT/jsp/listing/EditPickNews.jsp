<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
int listing=Integer.parseInt(request.getParameter("listing"));
int picknews=Integer.parseInt(request.getParameter("picknews"));

int j = 0;
if(picknews>0)
{
  PickNews obj = PickNews.find(picknews);
  listing=obj.listing;
  j = obj.issueTerm;
}

int realnode = Listing.find(listing).getNode();
if(realnode>0&&!Node.find(realnode).isCreator(teasession._rv)&&AccessMember.find(realnode,teasession._rv).getPurview()<2)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Node node = Node.find(teasession._nNode);

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onLoad="foEdit.IssueTerm.focus();">
<h1><%=r.getString(teasession._nLanguage, "PickNews")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM name=foEdit METHOD=POST action="/servlet/EditPickNews" onSubmit="return(submitInteger(this.IssueTerm,'<%=r.getString(teasession._nLanguage, "InvalidIssueTerm")%>'))">
  <input type='hidden' name='node' VALUE="<%=teasession._nNode%>">
  <input type='hidden' name='listing' VALUE="<%=listing%>">
  <input type='hidden' name='picknews' value="<%=picknews%>">

  <h2><%=r.getString(teasession._nLanguage, "IssueTerm")%></h2>
  <input type="TEXT" class="edit_input"  name=IssueTerm VALUE="<%=j%>"><%=r.getString(teasession._nLanguage, "Hours")%>

  <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div>
</body>
</html>

