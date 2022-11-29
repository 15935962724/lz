<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/node/type/buy/EditBuyPrice");
      String nexturl=request.getParameter("nexturl");
      int commodity=Integer.parseInt(request.getParameter("commodity"));

      if(nexturl!=null)
nexturl="&nexturl="+nexturl;
else
nexturl="";
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "BuyPrices")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<h2><%=r.getString(teasession._nLanguage, "BuyPrices")%></h2>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr ID=Tableonetr>
    <td id="huobiid"><%=r.getString(teasession._nLanguage, "Currency")%></td>
    <td><%=r.getString(teasession._nLanguage, "Supply")%></td>
    <td  id="List"><%=r.getString(teasession._nLanguage, "进货价")%></td>
    <td><%=r.getString(teasession._nLanguage, "OurPrice")%></td>
    <td><%=r.getString(teasession._nLanguage, "Point")%></td>
    <td id="tdRelationid"><%=r.getString(teasession._nLanguage, "Relation")%></td>
    <td id="tdConvertCurrencyid"><%=r.getString(teasession._nLanguage, "ConvertCurrency")%></td>
    <td></td>
  </tr>
  <%
for(Enumeration enumeration = BuyPrice.find(commodity); enumeration.hasMoreElements(); )
{
  int i = ((Integer)enumeration.nextElement()).intValue();
  BuyPrice buyprice = BuyPrice.find(commodity, i);
%>
<tr onmouseover="bgColor='#BCD1E9';" onMouseOut="bgColor='';" >
    <td  id="huobiid"><%=r.getString(teasession._nLanguage, Common.CURRENCY[i])%></td>
    <td><%=buyprice.getSupply()%></td>
    <td  id="List"><%=buyprice.getList()%></td>
    <td><%=buyprice.getPrice()%></td>
    <td><%=buyprice.getPoint()%></td>
    <td id="tdRelationid"><%
    int j = buyprice.getOptions();
    if(j == 0)
    {
      out.print(r.getString(teasession._nLanguage, "BaseOnRelation"));
    }else
    if(j == 1)
    {
      out.print(r.getString(teasession._nLanguage, "BaseOnAmount"));
    }
 %>
    <td id="tdConvertCurrencyid"><%=r.getString(teasession._nLanguage, Common.CURRENCY[buyprice.getConvertCurrency()])%>
    <td><input type=button onclick="window.open('/jsp/type/buy/EditBuyPrice.jsp?node=<%=teasession._nNode%>&commodity=<%=commodity%>&Currency=<%=i%><%=nexturl%>','_self')" value="<%=r.getString(teasession._nLanguage, "Edit")%>">
   <input type=button onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))window.open('/servlet/DeleteBuyPrice?node=<%=teasession._nNode%>&commodity=<%=commodity%>&Currency=<%=i%><%=nexturl%>','_self');" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/> </td>
  </tr>
  <%                }
%>
</table>
<input type=button onclick="window.open('/servlet/EditBuyPrice?node=<%=teasession._nNode%>&commodity=<%=commodity%><%=nexturl%>', '_self')" value="<%=r.getString(teasession._nLanguage, "CBNew")%>">
<FORM name=foEdit METHOD=POST action="/servlet/BuyPrices">
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">

  <P ALIGN=CENTER>
    <input type="button" name="GoBack" id="edit_GoBack" onclick="window.open('/jsp/type/buy/EditBuy.jsp?node=<%=teasession._nNode%>&commodity=<%=commodity%><%=nexturl%>','_self');" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <input type=button name="GoFinish" ID="edit_GoFinish" onclick="window.open('/jsp/type/buy/Buys.jsp?node=<%=teasession._nNode%><%=nexturl%>','_self');" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
  </P>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

