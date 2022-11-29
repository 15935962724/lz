<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

r.add("/tea/ui/node/type/buy/EditCommodity");
String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl="/jsp/type/goods/GoodsMemberList.jsp?node="+teasession._nNode;
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Commodity")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<h2><%=r.getString(teasession._nLanguage, "Buy")%></h2>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr ID=Tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Supplier")%></td>
     <td id= MinQuantityid><%=r.getString(teasession._nLanguage, "数量")%></td>
   <td id="tdskuid">SKU</td>
    <td id="tdSerialNumberid"><%=r.getString(teasession._nLanguage, "SerialNumber")%></td>   <td></td>
  </tr>
  <%
  for(Enumeration enumeration = tea.entity.node.Commodity.findByGoods(teasession._nNode); enumeration.hasMoreElements(); )
  {
    int i = ((Integer)enumeration.nextElement()).intValue();
    tea.entity.node.Commodity buyprice = tea.entity.node.Commodity.find(i);

%>

<tr onmouseover="javascript:this.bgColor='#BCD1E9';" onmouseout="javascript:this.bgColor='';" >
    <td><%=tea.entity.admin.Supplier.find(buyprice.getSupplier()).getName(teasession._nLanguage)%></td>
    <td id= MinQuantityid><%=buyprice.getMinQuantity()%></td>
    <td id="tdskuid"><%=buyprice.getSKU()%></td>
    <td id="tdSerialNumberid"><%=buyprice.getSerialNumber()%></td>
   <FORM name=foEdit METHOD=POST action="/servlet/EditBuy">
   <input type="hidden" name="delete" value="ON"/>
   <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
   <input type="hidden" name="commodity" value="<%=i%>"/>
   <td><input type=button onclick="window.open('/jsp/type/buy/EditBuy.jsp?node=<%=teasession._nNode%>&commodity=<%=i%>','_self')" value="<%=r.getString(teasession._nLanguage, "Edit")%>">
     <input type=submit onclick="return (confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'));" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/>
</td></form>
  </tr>
  <% }
%>
</table>
<input type=button onclick="window.open('/jsp/type/buy/EditBuy.jsp?node=<%=teasession._nNode%><%if(nexturl!=null)out.print("&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));%>', '_self')" value="<%=r.getString(teasession._nLanguage, "CBNew")%>">

  <%

      %>
      <P ALIGN=CENTER>
        <input type="submit" onclick="window.open('/jsp/type/goods/EditGoods.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
        <input type=SUBMIT onclick="window.open('<%=nexturl%>','_self');"  name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
      </P>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

