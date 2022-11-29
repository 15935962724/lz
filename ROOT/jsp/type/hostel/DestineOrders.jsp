<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/Hostel");

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "DestineOrders")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div ID=PathDiv><%=ts.hrefGlance(teasession._rv)%> ><%=r.getString(teasession._nLanguage, "DestineOrders")%></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
java.util.Enumeration enumer=Destine.findByMember(teasession._strCommunity,teasession._rv.toString());
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  Destine obj=Destine.find(id);

    %>
<tr><TD><%=obj.getRoomcount()%></TD>
  <TD><%=obj.getLinkmanname(teasession._nLanguage)%></TD>
<td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="edit_button" onClick="window.open('EditDestine.jsp?node=<%=obj.getNode()%>&destine=<%=id%>&roomprice=<%=obj.getRoomcount()%>&edit=ON', '_self');">
      <%
}
%>
</table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

