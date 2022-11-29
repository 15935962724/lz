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

ListingDetail ld=ListingDetail.find(iListing,54,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "LInvestor")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
  <input type='hidden' name="Node" VALUE="<%=iNode%>">
  <input type="hidden" name="ListingType" value="54"/>
  <%if(!flag){%>
  <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
  <%        }else{%>
  <input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
  <%   }%>
  <input type="hidden" name="Listing" value="<%=iListing%>"/>
  <table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Code")%>: </td>
      <td> <input  id="CHECKBOX" type="CHECKBOX" name="code" value="checkbox"  <%=getCheck(ld.getIstype("code"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="code_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("code"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="code_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("code"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="code_3" type="text" value="<%=ld.getSequence("code")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="code_4"   <%=getCheck(ld.getAnchor("code"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundname")%>: </td>
      <td> <input  id="CHECKBOX" type="CHECKBOX" name="fundname" value="checkbox"  <%=getCheck(ld.getIstype("fundname"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundname_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundname"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundname_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundname"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundname_3" type="text" value="<%=ld.getSequence("fundname")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundname_4"   <%=getCheck(ld.getAnchor("fundname"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="fundname_5" class="edit_input" type="text" value="<%=ld.getQuantity("fundname")%>" maxlength="3" size="4"> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundinfo")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundinfo" value="checkbox"  <%=getCheck(ld.getIstype("fundinfo"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundinfo_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundinfo"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundinfo_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundinfo"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundinfo_3" type="text" value="<%=ld.getSequence("fundinfo")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundinfo_4"   <%=getCheck(ld.getAnchor("fundinfo"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundsum")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundsum" value="checkbox"  <%=getCheck(ld.getIstype("fundsum"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundsum_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundsum"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundsum_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundsum"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundsum_3" type="text" value="<%=ld.getSequence("fundsum")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundsum_4"   <%=getCheck(ld.getAnchor("fundsum"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundsumload")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundsumload" value="checkbox"  <%=getCheck(ld.getIstype("fundsumload"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundsumload_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundsumload"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundsumload_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundsumload"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundsumload_3" type="text" value="<%=ld.getSequence("fundsumload")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundsumload_4"   <%=getCheck(ld.getAnchor("fundsumload"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundarea")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundarea" value="checkbox"  <%=getCheck(ld.getIstype("fundarea"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundarea_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundarea"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundarea_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundarea"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundarea_3" type="text" value="<%=ld.getSequence("fundarea")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundarea_4"   <%=getCheck(ld.getAnchor("fundarea"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundtrade")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundtrade" value="checkbox"  <%=getCheck(ld.getIstype("fundtrade"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundtrade_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundtrade"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundtrade_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundtrade"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundtrade_3" type="text" value="<%=ld.getSequence("fundtrade")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundtrade_4"   <%=getCheck(ld.getAnchor("fundtrade"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundsymbiosis")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundsymbiosis" value="checkbox"  <%=getCheck(ld.getIstype("fundsymbiosis"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundsymbiosis_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundsymbiosis"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundsymbiosis_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundsymbiosis"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundsymbiosis_3" type="text" value="<%=ld.getSequence("fundsymbiosis")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundsymbiosis_4"   <%=getCheck(ld.getAnchor("fundsymbiosis"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="fundsymbiosis_5" class="edit_input" type="text" value="<%=ld.getQuantity("fundsymbiosis")%>" maxlength="3" size="4"> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundwill")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundwill" value="checkbox"  <%=getCheck(ld.getIstype("fundwill"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundwill_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundwill"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundwill_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundwill"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundwill_3" type="text" value="<%=ld.getSequence("fundwill")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundwill_4"   <%=getCheck(ld.getAnchor("fundwill"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundwebsite")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundwebsite" value="checkbox"  <%=getCheck(ld.getIstype("fundwebsite"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundwebsite_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundwebsite"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundwebsite_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundwebsite"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundwebsite_3" type="text" value="<%=ld.getSequence("fundwebsite")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundwebsite_4"   <%=getCheck(ld.getAnchor("fundwebsite"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundperiod")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundperiod" value="checkbox"  <%=getCheck(ld.getIstype("fundperiod"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundperiod_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundperiod"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundperiod_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundperiod"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundperiod_3" type="text" value="<%=ld.getSequence("fundperiod")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundperiod_4"   <%=getCheck(ld.getAnchor("fundperiod"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundlocal")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundlocal" value="checkbox"  <%=getCheck(ld.getIstype("fundlocal"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundlocal_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundlocal"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundlocal_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundlocal"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundlocal_3" type="text" value="<%=ld.getSequence("fundlocal")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundlocal_4"   <%=getCheck(ld.getAnchor("fundlocal"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundidcard")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundidcard" value="checkbox"  <%=getCheck(ld.getIstype("fundidcard"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundidcard_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundidcard"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundidcard_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundidcard"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundidcard_3" type="text" value="<%=ld.getSequence("fundidcard")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundidcard_4"   <%=getCheck(ld.getAnchor("fundidcard"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundlinkman")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundlinkman" value="checkbox"  <%=getCheck(ld.getIstype("fundlinkman"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundlinkman_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundlinkman"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundlinkman_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundlinkman"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundlinkman_3" type="text" value="<%=ld.getSequence("fundlinkman")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundlinkman_4"   <%=getCheck(ld.getAnchor("fundlinkman"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundtel")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundtel" value="checkbox"  <%=getCheck(ld.getIstype("fundtel"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundtel_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundtel"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundtel_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundtel"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundtel_3" type="text" value="<%=ld.getSequence("fundtel")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundtel_4"   <%=getCheck(ld.getAnchor("fundtel"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "mobile")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="mobile" value="checkbox"  <%=getCheck(ld.getIstype("mobile"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="mobile_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mobile"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="mobile_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mobile"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="mobile_3" type="text" value="<%=ld.getSequence("mobile")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="mobile_4"   <%=getCheck(ld.getAnchor("mobile"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundfax")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundfax" value="checkbox"  <%=getCheck(ld.getIstype("fundfax"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundfax_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundfax"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundfax_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundfax"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundfax_3" type="text" value="<%=ld.getSequence("fundfax")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundfax_4"   <%=getCheck(ld.getAnchor("fundfax"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundmail")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundmail" value="checkbox"  <%=getCheck(ld.getIstype("fundmail"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundmail_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundmail"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundmail_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundmail"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundmail_3" type="text" value="<%=ld.getSequence("fundmail")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundmail_4"   <%=getCheck(ld.getAnchor("fundmail"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundpostcode")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundpostcode" value="checkbox"  <%=getCheck(ld.getIstype("fundpostcode"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundpostcode_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundpostcode"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundpostcode_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundpostcode"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundpostcode_3" type="text" value="<%=ld.getSequence("fundpostcode")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundpostcode_4"   <%=getCheck(ld.getAnchor("fundpostcode"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fundaddress")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fundaddress" value="checkbox"  <%=getCheck(ld.getIstype("fundaddress"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fundaddress_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fundaddress"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fundaddress_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fundaddress"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fundaddress_3" type="text" value="<%=ld.getSequence("fundaddress")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fundaddress_4"   <%=getCheck(ld.getAnchor("fundaddress"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "IssueTime")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="issuetime" value="checkbox"  <%=getCheck(ld.getIstype("issuetime"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="issuetime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("issuetime"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="issuetime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("issuetime"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="issuetime_3" type="text" value="<%=ld.getSequence("issuetime")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="issuetime_4"   <%=getCheck(ld.getAnchor("issuetime"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><hr> </td>
    </tr>
    <tr>
      <td> </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onClick="fshow()"  >
        <%=r.getString(teasession._nLanguage, "SelectAll")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input   class="edit_input" name="objbefore1"  mask="max" onFocus="fbefore()"  onchange="fbefore()" value="" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onChange="fafter()" value="" type="text">
&nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
        <input  id="CHECKBOX" type="CHECKBOX" name="objanchor4" onClick="fanchor()"  >
        <%=r.getString(teasession._nLanguage, "SelectAll")%> </td>
    </tr>
  </table>
  <center>
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </center>
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

