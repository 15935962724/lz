<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession=new TeaSession(request);
Node node =Node.find(teasession._nNode);
AccessMember am=AccessMember.find(teasession._nNode,teasession._rv);
if(!node.isCreator(teasession._rv)&&am.getPurview()<1)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Http h=new Http(request,response);



Resource r=new Resource("/tea/ui/node/listed/Listeds");





%>
<html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<%=tea.ui.node.general.NodeServlet.getButton(node,h, am,request)%>
<h1><%=r.getString(teasession._nLanguage, "CBListeds")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Listing")%></td>
    <td><%=r.getString(teasession._nLanguage, "ListingNode")%></td>
    <td><%=r.getString(teasession._nLanguage, "Style")%></td>
    <td><%=r.getString(teasession._nLanguage, "StopTime")%></td>
    <td></td>
    <td></td>
  </tr>
  <%
            int i = Listed.countListeds(teasession._nNode);
            if(i != 0)
            {
                //table.setTitle(super.r.getString(teasession._nLanguage, "Listing") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "ListingNode") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Style") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "StopTime") + "\n");
                for(Enumeration enumeration = Listed.findListeds(teasession._nNode); enumeration.hasMoreElements(); )
                {
                    int j = ((Integer)enumeration.nextElement()).intValue();
                    Listed listed = Listed.find(j);

                    int k = listed.getListing();
                    Listing listing = Listing.find(k);%>
  <tr>
    <td><%=listing.getName(teasession._nLanguage)%> </td>
    <td><%=Node.find(listing.getNode()).getAnchor(teasession._nLanguage)%> </td>
    <td><%=r.getString(teasession._nLanguage, Section.APPLY_STYLE[listing.getStyle()])%></td>
    <td><%=listed.getStopTimeToString()%></td>
    <td><input name="BUTTON" type=BUTTON class=CB id=CBEdit onClick="window.open('/jsp/listing/EditListed.jsp?node=<%=teasession._nNode%>&Listed=<%=j%>', '_self');" value=<%=r.getString(teasession._nLanguage, "CBEdit")%>>
      <input name="BUTTON" type=BUTTON class="CB" id="CBDelete" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteListed?node=<%=teasession._nNode%>&Listed=<%=j%>', '_self');}" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>">
      <%
		}
	}
%> </td>
  </tr>
</table>

<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/jsp/listing/NewListed.jsp?node=<%=teasession._nNode%>', '_self');">

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

