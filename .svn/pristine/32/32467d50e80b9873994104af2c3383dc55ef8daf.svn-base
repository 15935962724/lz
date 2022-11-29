<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession=new TeaSession(request);
Node node =Node.find(teasession._nNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(node._nNode,teasession._rv).getPurview()<2)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
}

String s =  request.getParameter("Listed");

boolean flag = s == null;
int i = 1;
String listings[]=null;
if(!flag)
{
    int j = Integer.parseInt(s);
    Listed listed = Listed.find(j);
    i = listed.getListing();
    listings=new String[1];
    listings[0]=String.valueOf(i);
} else
{
   listings =  request.getParameterValues("Listing");
}


Resource r=new Resource("/tea/ui/node/listed/Listeds");

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ListedTerm")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM name=foEdit METHOD=POST action="/servlet/EditListed" onSubmit="return(submitInteger(this.Term,'<%=r.getString(teasession._nLanguage, "InvalidTerm")%>'));">
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <%
if(!flag)
{
    out.println("<input type=hidden name=Listed VALUE="+s+">");
}
for(int index=0;index<listings.length;index++)
{
  int id=Integer.parseInt(listings[index]);
  Listing listing = Listing.find(id);
  Node obj= Node.find(listing.getNode());
  obj.setHot();


  out.println("<input type=hidden name=Listing VALUE="+listings[index]+">");
%>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
      <td><%=listing.getName(teasession._nLanguage)%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "ListingNode")%>:</td>
      <td><%=obj.getAnchor(teasession._nLanguage)%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Style")%>:</td>
      <td><%=r.getString(teasession._nLanguage, Section.APPLY_STYLE[listing.getStyle()])%></td>
    </tr>
    <%  }%>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "ListedTerm")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Term value="">
        <%=r.getString(teasession._nLanguage, "Days")%></td>
    </tr>
  </table>
  <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div>
</body>
</html>

