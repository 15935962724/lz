<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/node/access/AccessPrices");
if(!node.isCreator(teasession._rv))
{
  response.sendError(403);
  return;
}
tea.entity.node.AccessMember am = null;
if (teasession._rv != null)
{

  am = tea.entity.node.AccessMember.find(teasession._nNode, teasession._rv._strV);

}

Http h=new Http(request,response);



tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
String nr = tea.ui.node.general.NodeServlet.getButton(node,h, am,request);
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
<%=nr%>
<h1><%=r.getString(teasession._nLanguage, "CBPrice")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Currency")%></td>
    <td><%=r.getString(teasession._nLanguage, "Price")%></td>
    <td></td>
  </tr>
  <%
  for(java.util.Enumeration enumeration = AccessPrice.find(teasession._nNode); enumeration.hasMoreElements();)
  {
    int i = ((Integer)enumeration.nextElement()).intValue();
    AccessPrice accessprice = AccessPrice.find(teasession._nNode, i);
%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
    <td><%=r.getString(teasession._nLanguage, Common.CURRENCY[i])%></td>
    <td><%=accessprice.getPrice().toString()%></td>
    <td><input type=BUTTON value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" id="CBEdit" class="CB" onClick="window.open('/servlet/EditAccessPrice?node=<%=teasession._nNode%>&Currency=<%=i%>', '_self');">
      <input type=BUTTON value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" id="CBDelete" class="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteAccessPrice?node=<%=teasession._nNode%>&Currency=<%=i%>', '_self'); this.disabled=true; }"></td>
  </tr>
  <%}%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/servlet/EditAccessPrice?node=<%=teasession._nNode%>', '_self');">
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>



