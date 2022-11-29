<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/resource/Sound");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
   response.sendError(403);
   return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,56,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "SoundDetail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv">
<%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="56"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" class="edit_input"  type="text" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Bigtype")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="bigtype" value="checkbox"  <%=getCheck(ld.getIstype("bigtype"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="bigtype_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bigtype"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="bigtype_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bigtype"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="bigtype_3" class="edit_input"  type="text" value="<%=ld.getSequence("bigtype")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="bigtype_4"   <%=getCheck(ld.getAnchor("bigtype"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Smalltype")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="smalltype" value="checkbox"  <%=getCheck(ld.getIstype("smalltype"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="smalltype_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("smalltype"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="smalltype_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("smalltype"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="smalltype_3" class="edit_input"  type="text" value="<%=ld.getSequence("smalltype")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="smalltype_4"   <%=getCheck(ld.getAnchor("smalltype"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "Pingpai")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="pingpai" value="checkbox"  <%=getCheck(ld.getIstype("pingpai"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="pingpai_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pingpai"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="pingpai_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pingpai"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="pingpai_3" class="edit_input"  type="text" value="<%=ld.getSequence("pingpai")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="pingpai_4"   <%=getCheck(ld.getAnchor("pingpai"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Code")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="code" value="checkbox"  <%=getCheck(ld.getIstype("code"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="code_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("code"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="code_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("code"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="code_3" class="edit_input"  type="text" value="<%=ld.getSequence("code")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="code_4"   <%=getCheck(ld.getAnchor("code"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Medium")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="medium" value="checkbox"  <%=getCheck(ld.getIstype("medium"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="medium_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("medium"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="medium_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("medium"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="medium_3" class="edit_input"  type="text" value="<%=ld.getSequence("medium")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="medium_4"   <%=getCheck(ld.getAnchor("medium"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "Types")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="types" value="checkbox"  <%=getCheck(ld.getIstype("types"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="types_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("types"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="types_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("types"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="types_3" class="edit_input"  type="text" value="<%=ld.getSequence("types")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="types_4"   <%=getCheck(ld.getAnchor("types"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Polt")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="polt" value="checkbox"  <%=getCheck(ld.getIstype("polt"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="polt_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("polt"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="polt_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("polt"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="polt_3" class="edit_input"  type="text" value="<%=ld.getSequence("polt")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="polt_4"   <%=getCheck(ld.getAnchor("polt"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Trait")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="trait" value="checkbox"  <%=getCheck(ld.getIstype("trait"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="trait_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("trait"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="trait_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("trait"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="trait_3" class="edit_input"  type="text" value="<%=ld.getSequence("trait")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="trait_4"   <%=getCheck(ld.getAnchor("trait"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "Synopsis")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="synopsis" value="checkbox"  <%=getCheck(ld.getIstype("synopsis"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="synopsis_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("synopsis"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="synopsis_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("synopsis"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="synopsis_3" class="edit_input"  type="text" value="<%=ld.getSequence("synopsis")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="synopsis_4"   <%=getCheck(ld.getAnchor("synopsis"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Player")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="player" value="checkbox"  <%=getCheck(ld.getIstype("player"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="player_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("player"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="player_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("player"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="player_3" class="edit_input"  type="text" value="<%=ld.getSequence("player")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="player_4"   <%=getCheck(ld.getAnchor("player"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Direct")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="direct" value="checkbox"  <%=getCheck(ld.getIstype("direct"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="direct_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("direct"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="direct_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("direct"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="direct_3" class="edit_input"  type="text" value="<%=ld.getSequence("direct")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="direct_4"   <%=getCheck(ld.getAnchor("direct"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Produce")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="produce" value="checkbox"  <%=getCheck(ld.getIstype("produce"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="produce_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("produce"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="produce_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("produce"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="produce_3" class="edit_input"  type="text" value="<%=ld.getSequence("produce")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="produce_4"   <%=getCheck(ld.getAnchor("produce"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Area")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="area" value="checkbox"  <%=getCheck(ld.getIstype("area"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="area_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("area"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="area_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("area"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="area_3" class="edit_input"  type="text" value="<%=ld.getSequence("area")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="area_4"   <%=getCheck(ld.getAnchor("area"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


    <tr>
    <td><%=r.getString(teasession._nLanguage, "Caption")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="caption" value="checkbox"  <%=getCheck(ld.getIstype("caption"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="caption_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("caption"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="caption_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("caption"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="caption_3" class="edit_input"  type="text" value="<%=ld.getSequence("caption")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="caption_4"   <%=getCheck(ld.getAnchor("caption"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
      <tr>
    <td>ISRC: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="isrc" value="checkbox"  <%=getCheck(ld.getIstype("isrc"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="isrc_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("isrc"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="isrc_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("isrc"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="isrc_3" class="edit_input"  type="text" value="<%=ld.getSequence("isrc")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="isrc_4"   <%=getCheck(ld.getAnchor("isrc"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


    <tr>
    <td><%=r.getString(teasession._nLanguage, "IssueTime")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="IssueTime" value="checkbox"  <%=getCheck(ld.getIstype("IssueTime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="IssueTime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("IssueTime"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="IssueTime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("IssueTime"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="IssueTime_3" class="edit_input"  type="text" value="<%=ld.getSequence("IssueTime")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="IssueTime_4"   <%=getCheck(ld.getAnchor("IssueTime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>



    <tr>
    <td><%=r.getString(teasession._nLanguage, "Text")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" class="edit_input"  type="text" value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>



    <tr>
    <td><%=r.getString(teasession._nLanguage, "Price")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="price" value="checkbox"  <%=getCheck(ld.getIstype("price"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="price_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="price_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="price_3" class="edit_input"  type="text" value="<%=ld.getSequence("price")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="price_4"   <%=getCheck(ld.getAnchor("price"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


    <tr>
    <td><%=r.getString(teasession._nLanguage, "Price")%>2: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="price2" value="checkbox"  <%=getCheck(ld.getIstype("price2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="price2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price2"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="price2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price2"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="price2_3" class="edit_input"  type="text" value="<%=ld.getSequence("price2")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="price2_4"   <%=getCheck(ld.getAnchor("price2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
     <tr>
    <td><%=r.getString(teasession._nLanguage, "Price")%>3: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="price3" value="checkbox"  <%=getCheck(ld.getIstype("price3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="price3_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price3"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="price3_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price3"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="price3_3" class="edit_input"  type="text" value="<%=ld.getSequence("price3")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="price3_4"   <%=getCheck(ld.getAnchor("price3"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


    <tr>
    <td><%=r.getString(teasession._nLanguage, "Integral")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="integral" value="checkbox"  <%=getCheck(ld.getIstype("integral"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="integral_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("integral"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="integral_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("integral"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="integral_3" class="edit_input"  type="text" value="<%=ld.getSequence("integral")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="integral_4"   <%=getCheck(ld.getAnchor("integral"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
     <tr>
    <td><%=r.getString(teasession._nLanguage, "Other")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="other" value="checkbox"  <%=getCheck(ld.getIstype("other"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="other_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("other"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="other_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("other"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="other_3" class="edit_input"  type="text" value="<%=ld.getSequence("other")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="other_4"   <%=getCheck(ld.getAnchor("other"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>




  <!--tr>
    <td colspan="2"><hr></td>
</tr>
  <tr>
      <td>
      </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onclick="fshow()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input   class="edit_input" name="objbefore1"  mask="max" onfocus="fbefore()"  onchange="fbefore()" value="" type="text">
              <%=r.getString(teasession._nLanguage, "After")%><input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onchange="fafter()" value="" type="text">
    &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;   <input  id="CHECKBOX" type="CHECKBOX" name="objanchor_4" onclick="fanchor()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
                                                </td>
                      </tr-->
</table><center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
      </center>
  </form>

  <script>
  function fshow()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)!="_4")
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
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)=="_4")
          {
              form1.elements[counter].checked=form1.elements["objanchor_4"].checked;
          }
      }
  }
</script>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

