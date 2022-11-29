<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/node/briefcase/AddToBriefcase");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAddToBriefcase")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
<div id="pathdiv"><%=Node.find(teasession._nNode).getAncestor(teasession._nLanguage)%></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td style="text-align:center; "><%=r.getString(teasession._nLanguage, "Name") %></td>
    <td style="text-align:center; "><%=r.getString(teasession._nLanguage, "ListingNode") %></td>
    <td style="text-align:center; "><%=r.getString(teasession._nLanguage, "Style") %></td>
    <td style="text-align:center; "><%=r.getString(teasession._nLanguage, "Quantity") %> </td>
    <td></td>
  </tr>
  <%
  for(Enumeration enumeration = Listing.findBriefcase(teasession._rv); enumeration.hasMoreElements(); )
                {
                    int j = ((Integer)enumeration.nextElement()).intValue();
                    Listing listing1 = Listing.find(j);%>
  <tr>
    <td><%=listing1.getName(teasession._nLanguage)%> </td>
    <td><%=Node.find(listing1.getNode()).getAnchor(teasession._nLanguage)%> </td>
    <td><%=r.getString(teasession._nLanguage, Section.APPLY_STYLE[listing1.getStyle()])%> </td>
    <td><%=Integer.toString(listing1.getQuantity())%>
      <%    out.print(("<td><input type='button' value="+r.getString(teasession._nLanguage, "CBContinue")+" ID=CBContinue CLASS=CB onClick=\"window.open('/servlet/AddToBriefcase1?Listing=" + j + "&node=" + teasession._nNode + "', '_self');\">"));
  //   row.add(new Cell(new Button(1, "CB", "CBContinue", r.getString(teasession._nLanguage, "CBContinue"), "window.open('AddToBriefcase1?Listing=" + j + "&node=" + teasession._nNode + "', '_self');")));
                }
%>
    </td>
  </tr>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>



