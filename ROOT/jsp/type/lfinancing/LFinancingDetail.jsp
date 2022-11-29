<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Financing");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
   response.sendError(403);
   return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,53,teasession._nLanguage);


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "LFinancing")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"> <%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
  <input type='hidden' name="Node" VALUE="<%=iNode%>">
  <input type="hidden" name="ListingType" value="53"/>
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
        <input  id=CHECKBOX type="CHECKBOX" name="code_4"   <%=getCheck(ld.getAnchor("code"))%>>        </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Name")%>: </td>
      <td> <input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="name_3" type="text" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="name_4"   <%=getCheck(ld.getAnchor("name"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:        <input name="name_5" class="edit_input" type="text" value="<%=ld.getQuantity("name")%>" maxlength="3" size="4"> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Essence")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="essence" value="checkbox"  <%=getCheck(ld.getIstype("essence"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="essence_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("essence"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="essence_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("essence"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="essence_3" type="text" value="<%=ld.getSequence("essence")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="essence_4"   <%=getCheck(ld.getAnchor("essence"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Reside")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="reside" value="checkbox"  <%=getCheck(ld.getIstype("reside"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="reside_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("reside"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="reside_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("reside"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="reside_3" type="text" value="<%=ld.getSequence("reside")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="reside_4"   <%=getCheck(ld.getAnchor("reside"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Area")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="area" value="checkbox"  <%=getCheck(ld.getIstype("area"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="area_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("area"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="area_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("area"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="area_3" type="text" value="<%=ld.getSequence("area")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="area_4"   <%=getCheck(ld.getAnchor("area"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Synopsis")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="synopsis" value="checkbox"  <%=getCheck(ld.getIstype("synopsis"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="synopsis_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("synopsis"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="synopsis_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("synopsis"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="synopsis_3" type="text" value="<%=ld.getSequence("synopsis")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="synopsis_4"   <%=getCheck(ld.getAnchor("synopsis"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:        <input name="synopsis_5" class="edit_input" type="text" value="<%=ld.getQuantity("synopsis")%>" maxlength="3" size="4"> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Future")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="future" value="checkbox"  <%=getCheck(ld.getIstype("future"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="future_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("future"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="future_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("future"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="future_3" type="text" value="<%=ld.getSequence("future")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="future_4"   <%=getCheck(ld.getAnchor("future"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "AllMoney")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="allmoney" value="checkbox"  <%=getCheck(ld.getIstype("allmoney"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="allmoney_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("allmoney"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="allmoney_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("allmoney"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="allmoney_3" type="text" value="<%=ld.getSequence("allmoney")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="allmoney_4"   <%=getCheck(ld.getAnchor("allmoney"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "FinancingMoney")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="financingmoney" value="checkbox"  <%=getCheck(ld.getIstype("financingmoney"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="financingmoney_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("financingmoney"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="financingmoney_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("financingmoney"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="financingmoney_3" type="text" value="<%=ld.getSequence("financingmoney")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="financingmoney_4"   <%=getCheck(ld.getAnchor("financingmoney"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "InvestCallback")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="investcallback" value="checkbox"  <%=getCheck(ld.getIstype("investcallback"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="investcallback_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("investcallback"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="investcallback_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("investcallback"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="investcallback_3" type="text" value="<%=ld.getSequence("investcallback")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="investcallback_4"   <%=getCheck(ld.getAnchor("investcallback"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Redound")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="redound" value="checkbox"  <%=getCheck(ld.getIstype("redound"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="redound_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("redound"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="redound_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("redound"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="redound_3" type="text" value="<%=ld.getSequence("redound")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="redound_4"   <%=getCheck(ld.getAnchor("redound"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "YearRestrict")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="yearrestrict" value="checkbox"  <%=getCheck(ld.getIstype("yearrestrict"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="yearrestrict_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("yearrestrict"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="yearrestrict_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("yearrestrict"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="yearrestrict_3" type="text" value="<%=ld.getSequence("yearrestrict")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="yearrestrict_4"   <%=getCheck(ld.getAnchor("yearrestrict"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fashion")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fashion" value="checkbox"  <%=getCheck(ld.getIstype("fashion"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fashion_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fashion"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fashion_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fashion"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fashion_3" type="text" value="<%=ld.getSequence("fashion")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fashion_4"   <%=getCheck(ld.getAnchor("fashion"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "UnitName")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="unitname" value="checkbox"  <%=getCheck(ld.getIstype("unitname"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="unitname_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("unitname"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="unitname_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("unitname"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="unitname_3" type="text" value="<%=ld.getSequence("unitname")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="unitname_4"   <%=getCheck(ld.getAnchor("unitname"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "UnitEssence")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="unitessence" value="checkbox"  <%=getCheck(ld.getIstype("unitessence"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="unitessence_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("unitessence"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="unitessence_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("unitessence"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="unitessence_3" type="text" value="<%=ld.getSequence("unitessence")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="unitessence_4"   <%=getCheck(ld.getAnchor("unitessence"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "UnitSynopsis")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="unitsynopsis" value="checkbox"  <%=getCheck(ld.getIstype("unitsynopsis"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="unitsynopsis_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("unitsynopsis"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="unitsynopsis_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("unitsynopsis"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="unitsynopsis_3" type="text" value="<%=ld.getSequence("unitsynopsis")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="unitsynopsis_4"   <%=getCheck(ld.getAnchor("unitsynopsis"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Linkman")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="linkman" value="checkbox"  <%=getCheck(ld.getIstype("linkman"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="linkman_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("linkman"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="linkman_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("linkman"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="linkman_3" type="text" value="<%=ld.getSequence("linkman")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="linkman_4"   <%=getCheck(ld.getAnchor("linkman"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Phone")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="phone" value="checkbox"  <%=getCheck(ld.getIstype("phone"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="phone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("phone"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="phone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("phone"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="phone_3" type="text" value="<%=ld.getSequence("phone")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="phone_4"   <%=getCheck(ld.getAnchor("phone"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "mobile")%>: </td>
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
      <td><%=r.getString(teasession._nLanguage, "Fax")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="fax"    <%=getCheck(ld.getIstype("fax"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fax_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fax"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fax_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fax"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fax_3" type="text" value="<%=ld.getSequence("fax")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fax_4"   <%=getCheck(ld.getAnchor("fax"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "E-mail")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="email"    <%=getCheck(ld.getIstype("email"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="email_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("email"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="email_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("email"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="email_3" type="text" value="<%=ld.getSequence("email")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="email_4"   <%=getCheck(ld.getAnchor("email"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Postalcode")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="postalcode"    <%=getCheck(ld.getIstype("postalcode"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="postalcode_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("postalcode"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="postalcode_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("postalcode"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="postalcode_3" type="text" value="<%=ld.getSequence("postalcode")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="postalcode_4"   <%=getCheck(ld.getAnchor("postalcode"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Address")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="address"    <%=getCheck(ld.getIstype("address"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="address_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("address"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="address_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("address"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="address_3" type="text" value="<%=ld.getSequence("address")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="address_4"   <%=getCheck(ld.getAnchor("address"))%>>
      <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "IssueTime")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="issuetime"    <%=getCheck(ld.getIstype("issuetime"))%>>
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
      <td><hr></td>
    </tr>
    <tr>
      <td> </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onClick="fshow()"  >
        <%=r.getString(teasession._nLanguage, "SelectAll")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input   class="edit_input" name="objbefore1"  mask="max" onFocus="fbefore()"  onchange="fbefore()" value="" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>        <input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onChange="fafter()" value="" type="text">
&nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
        <input  id="CHECKBOX" type="CHECKBOX" name="objanchor4" onClick="fanchor()"  >        <%=r.getString(teasession._nLanguage, "SelectAll")%> </td>
    </tr>
  </table>
  <%=r.getString(teasession._nLanguage, "Anchor")%>
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

