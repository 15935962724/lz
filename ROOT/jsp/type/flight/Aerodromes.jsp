<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/include/Header.jsp"%>


<%
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Aerodromes")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap>ID</td>
      <td><%=r.getString(teasession._nLanguage, "Name")%></td>
      <td></td>
    </tr>
<%
java.util.Enumeration enumer=  tea.entity.site.Aerodrome.findByCommunity(node.getCommunity());
while(enumer.hasMoreElements())
{
int id=((Integer)enumer.nextElement()).intValue();
tea.entity.site.Aerodrome obj=tea.entity.site.Aerodrome.find(id);%>

    <tr>
      <td><%=id%></td>
      <td><%=obj.getName(teasession._nLanguage)%></td>
      <td><input type="button"  value="<%=r.getString(teasession._nLanguage, "Edit")%>" onclick="location='/jsp/type/flight/EditAerodrome.jsp?node=<%=teasession._nNode%>&aerodrome=<%=id%>';"/>
        <input type="button" value="<%=r.getString(teasession._nLanguage, "Delete")%>" onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){location='/servlet/EditAerodrome?node=<%=teasession._nNode%>&aerodrome=<%=id%>&delete=ON';}"/>
</td>
    </tr>
<%
}
%>

</table>
  <INPUT TYPE=button  VALUE="<%=r.getString(teasession._nLanguage, "New")%>" onclick="location='/jsp/type/flight/EditAerodrome.jsp?node=<%=teasession._nNode%>&aerodrome=0'">
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>

</body>
</html>

