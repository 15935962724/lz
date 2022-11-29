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
<h1><%=r.getString(teasession._nLanguage, "CBBidPrices")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" value="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr id="Tableonetr">
    <td> <%=r.getString(teasession._nLanguage, "BidPrices")%></td>
  </tr>
  <tr ID=Tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Currency")%></td>
    <td><%=r.getString(teasession._nLanguage, "BidPSupply")%></td>
    <td><%=r.getString(teasession._nLanguage, "BidPList")%></td>
    <td><%=r.getString(teasession._nLanguage, "BidPAsk")%></td>
    <td><%=r.getString(teasession._nLanguage, "BidPReserve")%></td>
    <td><%=r.getString(teasession._nLanguage, "BidPIncrement")%></td>
  </tr>
  <%
                for(Enumeration enumeration = BidPrice.find(teasession._nNode); enumeration.hasMoreElements();)
                {
                    int i = ((Integer)enumeration.nextElement()).intValue();
                    BidPrice bidprice = BidPrice.find(teasession._nNode, i);%>
  <tr>
    <td><%=r.getString(teasession._nLanguage, Common.CURRENCY[i])%></td>
    <td><%=bidprice.getSupply().toString()%></td>
    <td><%=bidprice.getList().toString()%></td>
    <td><%=bidprice.getAsk().toString()%></td>
    <td><%=bidprice.getReserve().toString()%></td>
    <td><%=bidprice.getIncrement().toString()%></td>
    <td><A href="/servlet/DeleteBidPrice?node=<%=teasession._nNode%>&Currency=<%=i%>" onClick="return(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'));"><%=r.getCommandImg(teasession._nLanguage, "Delete")%></td>
    <td><A href="/servlet/EditBidPrice?node=<%=teasession._nNode%>&Currency=<%=i%>"><%=r.getCommandImg(teasession._nLanguage, "Edit")%></A> </td>
  </tr>
</table>
<%               }%>
<tr>
  <td> <input type=button onclick="window.open('/servlet/EditBidPrice?node=<%=teasession._nNode%>', '_self')" value=<%=r.getString(teasession._nLanguage, "CBNew")%>>
    <FORM name=foEdit METHOD=POST action="/servlet/BidPrices">
      <input type='hidden' name=Node VALUE="<%=Integer.toString(teasession._nNode)%>">
      </table>
      <P ALIGN=CENTER>
        <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
        <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
      </P>
    </FORM>
	<div id="head6"><img height="6" src="about:blank"></div>
    <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
    <%----%>
</body>
</html>

