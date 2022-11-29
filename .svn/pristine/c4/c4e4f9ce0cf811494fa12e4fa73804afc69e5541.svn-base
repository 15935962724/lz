<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/node/type/buy/EditCommodity");
r.add("/tea/ui/node/type/buy/EditBuyPrice");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
if(!node.isCreator(teasession._rv)&&AccessMember.find(teasession._nNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;
ListingDetail subject=ListingDetail.find(iListing,4,"subject",teasession._nLanguage);
ListingDetail supplier=ListingDetail.find(iListing,4,"supplier",teasession._nLanguage);
ListingDetail sku=ListingDetail.find(iListing,4,"sku",teasession._nLanguage);
ListingDetail serialNumber=ListingDetail.find(iListing,4,"serialNumber",teasession._nLanguage);
ListingDetail goods=ListingDetail.find(iListing,4,"goods",teasession._nLanguage);
ListingDetail quality=ListingDetail.find(iListing,4,"quality",teasession._nLanguage);
ListingDetail inventory=ListingDetail.find(iListing,4,"inventory",teasession._nLanguage);
ListingDetail minQuantity=ListingDetail.find(iListing,4,"minQuantity",teasession._nLanguage);
ListingDetail maxQuantity=ListingDetail.find(iListing,4,"maxQuantity",teasession._nLanguage);
ListingDetail delta=ListingDetail.find(iListing,4,"delta",teasession._nLanguage);
ListingDetail weight=ListingDetail.find(iListing,4,"weight",teasession._nLanguage);
ListingDetail volume=ListingDetail.find(iListing,4,"volume",teasession._nLanguage);
ListingDetail currency=ListingDetail.find(iListing,4,"currency",teasession._nLanguage);
ListingDetail supply=ListingDetail.find(iListing,4,"supply",teasession._nLanguage);
ListingDetail list=ListingDetail.find(iListing,4,"list",teasession._nLanguage);
ListingDetail ourPrice=ListingDetail.find(iListing,4,"ourPrice",teasession._nLanguage);
ListingDetail point=ListingDetail.find(iListing,4,"point",teasession._nLanguage);
ListingDetail convertCurrency=ListingDetail.find(iListing,4,"convertCurrency",teasession._nLanguage);
ListingDetail quantity=ListingDetail.find(iListing,4,"quantity",teasession._nLanguage);
ListingDetail atsc=ListingDetail.find(iListing,4,"atsc",teasession._nLanguage);//放入购物车按扭
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ATSCAlert")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM NAME=formBuy METHOD=POST  action="/servlet/EditListingDetail">
  <input type='hidden' name="Node" value="<%=iNode%>">
  <input type="hidden" name="ListingType" value="4"/>
  <%if(!flag){%>
  <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
  <%        }else{%>
  <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
  <%}%>
  <input type="hidden" name="Listing" value="<%=iListing%>"/>
  <TABLE CELLSPACING=0 CELLPADDING=0 border="0" id="tablecenter">
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
      <TD> <input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Supplier")%>:</TD>
      <TD> <input  id="CHECKBOX" type="CHECKBOX" name="supplier" value="checkbox"  <%=getCheck(ld.getIstype("supplier"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="supplier_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("supplier"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="supplier_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("supplier"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="supplier_3" type="text" class="edit_input" value="<%=ld.getSequence("supplier")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="supplier_4"   <%=getCheck(ld.getAnchor("supplier"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    </TR>
     <TR>
      <TD><%=r.getString(teasession._nLanguage, "SKU")%>:</TD>
      <TD> <input  id="CHECKBOX" type="CHECKBOX" name="sku" value="checkbox"  <%=getCheck(ld.getIstype("sku"))%>>
         <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
         <input name="sku_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sku"))%>" type="text" class="edit_input">
         <%=r.getString(teasession._nLanguage, "After")%>
         <input name="sku_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sku"))%>" type="text" class="edit_input">
         <%=r.getString(teasession._nLanguage, "Sequence")%>:
         <input name="sku_3" type="text" class="edit_input" value="<%=ld.getSequence("sku")%>" maxlength="3" size="4">
         <input  id=CHECKBOX type="CHECKBOX" name="sku_4"   <%=getCheck(ld.getAnchor("sku"))%>>
         <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "SerialNumber")%>:</TD>
      <TD> <input  id="CHECKBOX" type="CHECKBOX" name="serialNumber" value="checkbox"  <%=getCheck(ld.getIstype("serialNumber"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="serialNumber_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("serialNumber"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="serialNumber_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("serialNumber"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="serialNumber_3" type="text" class="edit_input" value="<%=ld.getSequence("serialNumber")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="serialNumber_4"   <%=getCheck(ld.getAnchor("serialNumber"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Goods")%>:</TD>
      <TD> <input  id="CHECKBOX" type="CHECKBOX" name="goods" value="checkbox"  <%=getCheck(ld.getIstype("goods"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="goods_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("goods"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="goods_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("goods"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="goods_3" type="text" class="edit_input" value="<%=ld.getSequence("goods")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="goods_4"   <%=getCheck(ld.getAnchor("goods"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td width="26" ID=RowHeader><%=r.getString(teasession._nLanguage, "Inventory")%>:</TD>
      <TD width="516"><input  id="CHECKBOX" type="CHECKBOX" name="inventory" value="checkbox"  <%=getCheck(ld.getIstype("inventory"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input   value="<%=HtmlElement.htmlToText(ld.getBeforeItem("inventory" value="checkbox"  <%=getCheck(ld.getIstype("
        <%=r.getString(teasession._nLanguage, "))%>>
        <%=r.getString(teasession."))%>" type="text" class="edit_input"  name="inventory_1">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input   value="<%=HtmlElement.htmlToText(ld.getAfterItem("inventory"))%>" type="text" class="edit_input" name="inventory_2">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="inventory_3" type="text" class="edit_input" value="<%=ld.getSequence("inventory")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="inventory_4"   <%=getCheck(ld.getAnchor("inventory"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "MinQuantity")%>:</TD>
      <TD> <input  id="CHECKBOX" type="CHECKBOX" name="minQuantity" value="checkbox"  <%=getCheck(ld.getIstype("minQuantity"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="minQuantity_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("minQuantity"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="minQuantity_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("minQuantity"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="minQuantity_3" type="text" class="edit_input" value="<%=ld.getSequence("minQuantity")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="minQuantity_4"   <%=getCheck(ld.getAnchor("minQuantity"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "MaxQuantity")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="maxQuantity" value="checkbox"  <%=getCheck(ld.getIstype("maxQuantity"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="maxQuantity_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("maxQuantity"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="maxQuantity_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("maxQuantity"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="maxQuantity_3" type="text" class="edit_input" value="<%=ld.getSequence("maxQuantity")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="maxQuantity_4"   <%=getCheck(ld.getAnchor("maxQuantity"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Delta")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="delta" value="checkbox"  <%=getCheck(ld.getIstype("delta"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="delta_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("delta"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="delta_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("delta"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="delta_3" type="text" class="edit_input" value="<%=ld.getSequence("delta")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="delta_4"   <%=getCheck(ld.getAnchor("delta"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Weight")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="weight" value="checkbox"  <%=getCheck(ld.getIstype("weight"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="weight_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("weight"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="weight_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("weight"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="weight_3" type="text" class="edit_input" value="<%=ld.getSequence("weight")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="weight_4"   <%=getCheck(ld.getAnchor("weight"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Volume")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="volume" value="checkbox"  <%=getCheck(ld.getIstype("volume"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="volume_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("volume"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="volume_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("volume"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="volume_3" type="text" class="edit_input" value="<%=ld.getSequence("volume")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="volume_4"   <%=getCheck(ld.getAnchor("volume"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr>
      <td colspan="2"><hr></td>
    </tr>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Currency")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="currency" value="checkbox"  <%=getCheck(ld.getIstype("currency"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="currency_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("currency"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="currency_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("currency"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="currency_3" type="text" class="edit_input" value="<%=ld.getSequence("currency")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="currency_4"   <%=getCheck(ld.getAnchor("currency"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Supply")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="supply" value="checkbox"  <%=getCheck(ld.getIstype("supply"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="supply_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("supply"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="supply_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("supply"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="supply_3" type="text" class="edit_input" value="<%=ld.getSequence("supply")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="supply_4"   <%=getCheck(ld.getAnchor("supply"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "List")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="list" value="checkbox"  <%=getCheck(ld.getIstype("list"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="list_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("list"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="list_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("list"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="list_3" type="text" class="edit_input" value="<%=ld.getSequence("list")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="list_4"   <%=getCheck(ld.getAnchor("list"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "OurPrice")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="ourPrice" value="checkbox"  <%=getCheck(ld.getIstype("ourPrice"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="ourPrice_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ourPrice"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="ourPrice_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ourPrice"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="ourPrice_3" type="text" class="edit_input" value="<%=ld.getSequence("ourPrice")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="ourPrice_4"   <%=getCheck(ld.getAnchor("ourPrice"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Point")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="point" value="checkbox"  <%=getCheck(ld.getIstype("point"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="point_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("point"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="point_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("point"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="point_3" type="text" class="edit_input" value="<%=ld.getSequence("point")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="point_4"   <%=getCheck(ld.getAnchor("point"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "ConvertCurrency")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="convertCurrency" value="checkbox"  <%=getCheck(ld.getIstype("convertCurrency"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="convertCurrency_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("convertCurrency"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="convertCurrency_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("convertCurrency"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="convertCurrency_3" type="text" class="edit_input" value="<%=ld.getSequence("convertCurrency")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="convertCurrency_4"   <%=getCheck(ld.getAnchor("convertCurrency"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Quantity")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="quantity" value="checkbox"  <%=getCheck(ld.getIstype("quantity"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="quantity_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("quantity"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="quantity_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("quantity"))%>" type="text" class="edit_input">
        <input name="quantity_3" type="hidden" value="255">
        <%--
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="quantity_3" type="text" class="edit_input" value="<%=ld.getSequence("quantity")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="quantity_4"   <%=getCheck(ld.getAnchor("quantity"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>--%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "CBAddToShoppingCart")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="atsc" value="checkbox"  <%=getCheck(ld.getIstype("atsc"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="atsc_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("atsc"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="atsc_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("atsc"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="atsc_3" type="text" class="edit_input" value="<%=ld.getSequence("atsc")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="atsc_4"   <%=getCheck(ld.getAnchor("atsc"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
  </table>
  <center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </center>
</form>
<script>
  function fshowBuy()
  {
      for(var counter=0;counter<formBuy.elements.length;counter++)
      {
          if(formBuy.elements[counter].type=="checkbox"&&formBuy.elements[counter].name.substring(formBuy.elements[counter].name.length-2)!="_4")
          {
              formBuy.elements[counter].checked=formBuy.elements["objshow"].checked;
          }
      }
  }function fafterBuy()
  {
      for(var counter=0;counter<formBuy.elements.length;counter++)
      {
          if(formBuy.elements[counter].type=="text"&&formBuy.elements[counter].name.substring(formBuy.elements[counter].name.length-1)=="2")
          {
              formBuy.elements[counter].value=formBuy.elements["objafter2"].value;
          }
      }
  }

  function fbeforeBuy()
  {
      for(var counter=0;counter<formBuy.elements.length;counter++)
      {
          if(formBuy.elements[counter].type=="text"&&formBuy.elements[counter].name.substring(formBuy.elements[counter].name.length-1)=="1")
          {
              formBuy.elements[counter].value=formBuy.elements["objbefore1"].value;
          }
      }
  }

  function fanchorBuy()
  {
      for(var counter=0;counter<formBuy.elements.length;counter++)
      {
          if(formBuy.elements[counter].type=="checkbox"&&formBuy.elements[counter].name.substring(formBuy.elements[counter].name.length-2)=="_4")
          {
              formBuy.elements[counter].checked=formBuy.elements["objanchor_4"].checked;
          }
      }
  }
  function fsequBuy()
  {
    var paramvalue=0;
      for(var counter=0;counter<formBuy.elements.length;counter++)
      {
          if(formBuy.elements[counter].type=="text"&&formBuy.elements[counter].name.substring(formBuy.elements[counter].name.length-2)=="_3")
          {
              formBuy.elements[counter].value=++paramvalue*10;
          }
      }
  }
<%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.formBuy.subject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

