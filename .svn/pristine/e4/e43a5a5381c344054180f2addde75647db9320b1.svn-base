<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/resource/Investor");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,51,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "InvestorDetail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="Node" VALUE="<%=iNode%>">
    <input type="hidden" name="ListingType" value="51"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Code")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="getId" value="checkbox"  <%=getCheck(ld.getIstype("getId"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getId_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getId"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getId_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getId"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getId_3" type="text" value="<%=ld.getSequence("getId")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getId_4"   <%=getCheck(ld.getAnchor("getId"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Fundname")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="getFundname" value="checkbox"  <%=getCheck(ld.getIstype("getFundname"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundname_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundname"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundname_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundname"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundname_3" type="text" value="<%=ld.getSequence("getFundname")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundname_4"   <%=getCheck(ld.getAnchor("getFundname"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
<%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getFundname_5" class="edit_input" type="text" value="<%=ld.getQuantity("getFundname")%>" maxlength="3" size="4">
     </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Fundinfo")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundinfo" value="checkbox"  <%=getCheck(ld.getIstype("getFundinfo"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundinfo_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundinfo"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundinfo_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundinfo"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundinfo_3" type="text" value="<%=ld.getSequence("getFundinfo")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundinfo_4"   <%=getCheck(ld.getAnchor("getFundinfo"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Fundsum")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundsum" value="checkbox"  <%=getCheck(ld.getIstype("getFundsum"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundsum_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundsum"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundsum_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundsum"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundsum_3" type="text" value="<%=ld.getSequence("getFundsum")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundsum_4"   <%=getCheck(ld.getAnchor("getFundsum"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Fundsumload")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundsumloadToString" value="checkbox"  <%=getCheck(ld.getIstype("getFundsumloadToString"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundsumloadToString_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundsumloadToString"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundsumloadToString_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundsumloadToString"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundsumloadToString_3" type="text" value="<%=ld.getSequence("getFundsumloadToString")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundsumloadToString_4"   <%=getCheck(ld.getAnchor("getFundsumloadToString"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Fundarea")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundarea" value="checkbox"  <%=getCheck(ld.getIstype("getFundarea"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundarea_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundarea"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundarea_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundarea"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundarea_3" type="text" value="<%=ld.getSequence("getFundarea")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundarea_4"   <%=getCheck(ld.getAnchor("getFundarea"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Fundtrade")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundtrade" value="checkbox"  <%=getCheck(ld.getIstype("getFundtrade"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundtrade_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundtrade"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundtrade_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundtrade"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundtrade_3" type="text" value="<%=ld.getSequence("getFundtrade")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundtrade_4"   <%=getCheck(ld.getAnchor("getFundtrade"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Fundsymbiosis")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundsymbiosis" value="checkbox"  <%=getCheck(ld.getIstype("getFundsymbiosis"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundsymbiosis_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundsymbiosis"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundsymbiosis_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundsymbiosis"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundsymbiosis_3" type="text" value="<%=ld.getSequence("getFundsymbiosis")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundsymbiosis_4"   <%=getCheck(ld.getAnchor("getFundsymbiosis"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getFundsymbiosis_5" class="edit_input" type="text" value="<%=ld.getQuantity("getFundsymbiosis")%>" maxlength="3" size="4">
        </td>
  </tr>
  <tr> <td><%=r.getString(teasession._nLanguage, "Fundwill")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundwill" value="checkbox"  <%=getCheck(ld.getIstype("getFundwill"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundwill_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundwill"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundwill_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundwill"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundwill_3" type="text" value="<%=ld.getSequence("getFundwill")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="getFundwill_4"   <%=getCheck(ld.getAnchor("getFundwill"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    <tr> <td><%=r.getString(teasession._nLanguage, "Fundwebsite")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundwebsite" value="checkbox"  <%=getCheck(ld.getIstype("getFundwebsite"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundwebsite_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundwebsite"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundwebsite_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundwebsite"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundwebsite_3" type="text" value="<%=ld.getSequence("getFundwebsite")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getFundwebsite_4"   <%=getCheck(ld.getAnchor("getFundwebsite"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    <tr> <td><%=r.getString(teasession._nLanguage, "Fundperiod")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundperiod" value="checkbox"  <%=getCheck(ld.getIstype("getFundperiod"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundperiod_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundperiod"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundperiod_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundperiod"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundperiod_3" type="text" value="<%=ld.getSequence("getFundperiod")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getFundperiod_4"   <%=getCheck(ld.getAnchor("getFundperiod"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
      <tr>   <td><%=r.getString(teasession._nLanguage, "Fundlocal")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundlocal" value="checkbox"  <%=getCheck(ld.getIstype("getFundlocal"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundlocal_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundlocal"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundlocal_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundlocal"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundlocal_3" type="text" value="<%=ld.getSequence("getFundlocal")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundlocal_4"   <%=getCheck(ld.getAnchor("getFundlocal"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>   <td><%=r.getString(teasession._nLanguage, "Fundidcard")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundidcard" value="checkbox"  <%=getCheck(ld.getIstype("getFundidcard"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundidcard_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundidcard"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundidcard_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundidcard"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundidcard_3" type="text" value="<%=ld.getSequence("getFundidcard")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundidcard_4"   <%=getCheck(ld.getAnchor("getFundidcard"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>   <td><%=r.getString(teasession._nLanguage, "Fundlinkman")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundlinkman" value="checkbox"  <%=getCheck(ld.getIstype("getFundlinkman"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundlinkman_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundlinkman"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundlinkman_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundlinkman"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundlinkman_3" type="text" value="<%=ld.getSequence("getFundlinkman")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundlinkman_4"   <%=getCheck(ld.getAnchor("getFundlinkman"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
      <tr>  <td><%=r.getString(teasession._nLanguage, "Fundtel")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundtel" value="checkbox"  <%=getCheck(ld.getIstype("getFundtel"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundtel_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundtel"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundtel_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundtel"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundtel_3" type="text" value="<%=ld.getSequence("getFundtel")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundtel_4"   <%=getCheck(ld.getAnchor("getFundtel"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


        <tr>  <td><%=r.getString(teasession._nLanguage, "Fundfax")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundfax" value="checkbox"  <%=getCheck(ld.getIstype("getFundfax"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundfax_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundfax"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundfax_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundfax"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundfax_3" type="text" value="<%=ld.getSequence("getFundfax")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundfax_4"   <%=getCheck(ld.getAnchor("getFundfax"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

        <tr>  <td><%=r.getString(teasession._nLanguage, "Fundmail")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundmail" value="checkbox"  <%=getCheck(ld.getIstype("getFundmail"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundmail_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundmail"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundmail_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundmail"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundmail_3" type="text" value="<%=ld.getSequence("getFundmail")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundmail_4"   <%=getCheck(ld.getAnchor("getFundmail"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
        <tr>  <td><%=r.getString(teasession._nLanguage, "Fundpostcode")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundpostcode" value="checkbox"  <%=getCheck(ld.getIstype("getFundpostcode"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundpostcode_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundpostcode"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundpostcode_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundpostcode"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundpostcode_3" type="text" value="<%=ld.getSequence("getFundpostcode")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundpostcode_4"   <%=getCheck(ld.getAnchor("getFundpostcode"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
        <tr>  <td><%=r.getString(teasession._nLanguage, "Fundaddress")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getFundaddress" value="checkbox"  <%=getCheck(ld.getIstype("getFundaddress"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getFundaddress_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFundaddress"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getFundaddress_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFundaddress"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFundaddress_3" type="text" value="<%=ld.getSequence("getFundaddress")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFundaddress_4"   <%=getCheck(ld.getAnchor("getFundaddress"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
        <tr>  <td><%=r.getString(teasession._nLanguage, "IssueTime")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="issuetime" value="checkbox"  <%=getCheck(ld.getIstype("issuetime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="issuetime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("issuetime"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="issuetime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("issuetime"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="issuetime_3" type="text" value="<%=ld.getSequence("issuetime")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="issuetime_4"   <%=getCheck(ld.getAnchor("issuetime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
      <td>
      </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onClick="fshow()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input   class="edit_input" name="objbefore1"  mask="max" onFocus="fbefore()"  onchange="fbefore()" value="" type="text">
              <%=r.getString(teasession._nLanguage, "After")%><input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onChange="fafter()" value="" type="text">
    &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;   <input  id="CHECKBOX" type="CHECKBOX" name="objanchor4" onClick="fanchor()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
                                                </td>
                      </tr>
</table>
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>

  <script>
  function fshow()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)!="4")
          {
              form1.elements[counter].checked=form1.elements["objshow"].checked;
          }
      }
  }function fafter()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="text"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)=="2")
          {
              form1.elements[counter].value=form1.elements["objafter2"].value;
          }
      }
  }

  function fbefore()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="text"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)=="1")
          {
              form1.elements[counter].value=form1.elements["objbefore1"].value;
          }
      }
  }

  function fanchor()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)=="4")
          {
              form1.elements[counter].checked=form1.elements["objanchor4"].checked;
          }
      }
  }
</script>

<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

