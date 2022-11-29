<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
if(!node.isCreator(teasession._rv))
{
                response.sendError(403);
                return;
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Bargain")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
</A>
<h2 COLSPAN=10><%=r.getString(teasession._nLanguage, "BargainPrices")%></h2>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr id="TableCaption"> </tr>
  <tr ID=Tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Currency")%></td>
    <td><%=r.getString(teasession._nLanguage, "BargainSupply")%></td>
    <td><%=r.getString(teasession._nLanguage, "BargainList")%></td>
    <td><%=r.getString(teasession._nLanguage, "BargainAsk")%></td>
  </tr>
  <%       for(Enumeration enumeration = BargainPrice.find(teasession._nNode); enumeration.hasMoreElements();)
         {
                    int i = ((Integer)enumeration.nextElement()).intValue();
                    BargainPrice bargainprice = BargainPrice.find(teasession._nNode, i);%>
  <tr>
    <td><%=r.getString(teasession._nLanguage, Common.CURRENCY[i])%></td>
    <td><%=bargainprice.getSupply().toString()%></td>
    <td><%=bargainprice.getList().toString()%></td>
    <td><%=bargainprice.getAsk().toString()%></td>
    <td><A href="/servlet/DeleteBargainPrice?node=<%=teasession._nNode%>&Currency=<%=i%>" onClick="return(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'));"><%=r.getCommandImg(teasession._nLanguage, "Delete")%></A> </td>
    <td><A href="/servlet/EditBargainPrice?node=<%=teasession._nNode%>&Currency=<%=i%>"><%=r.getCommandImg(teasession._nLanguage, "Edit")%></A> </td>
  </tr>
  <%        }
%>
</table>
<input type=button onclick="window.open('/servlet/EditBargainPrice?node=<%=teasession._nNode%>', '_self')" value=<%=r.getString(teasession._nLanguage, "CBNew")%>>
<FORM name=foEdit METHOD=POST action="/servlet/BargainPrices">
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
  <P ALIGN=CENTER>
    <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
  </P>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

