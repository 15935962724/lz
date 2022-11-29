<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Hostel");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,48,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Hostel")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv">
<%=node.getAncestor(teasession._nLanguage)%></div>
<div id="Layer1" style="position:absolute; left:120px; top:300px; width:214px; height:168px; z-index:1; background-color: #FFFFFF; layer-background-color: #FFFFFF; overflow: 隐藏; visibility: hidden;">
  <textarea name="textarea" cols="50" rows="10"></textarea>
  <input type="reset"  class="edit_button" name="Submit" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onClick="javascript:hideMax();" >
  <input type="button"  class="edit_button" name="Submit2" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onClick="javascript:hideMax(true);">
</div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="Node" VALUE="<%=iNode%>">
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="ListingType" value="48"/>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Name")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="Name" value="checkbox"  <%=getCheck(ld.getIstype("Name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="Name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Name"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="Name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Name"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Name_3" type="text" value="<%=ld.getSequence("Name")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="Name_4"   <%=getCheck(ld.getAnchor("Name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "City")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getCity" value="checkbox"  <%=getCheck(ld.getIstype("getCity"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getCity_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getCity"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getCity_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getCity"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getCity_3" type="text" value="<%=ld.getSequence("getCity")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getCity_4"   <%=getCheck(ld.getAnchor("getCity"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getAddress" value="checkbox"  <%=getCheck(ld.getIstype("getAddress"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getAddress_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getAddress")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getAddress_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getAddress")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getAddress_3" type="text" value="<%=ld.getSequence("getAddress")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getAddress_4"   <%=getCheck(ld.getAnchor("getAddress"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Map")%>:</td>
  <td><input  id="CHECKBOX" type="CHECKBOX" name="map" value="checkbox"  <%=getCheck(ld.getIstype("map"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="map_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("map")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="map_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("map")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="map_3" type="text" value="<%=ld.getSequence("map")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="map_4"   <%=getCheck(ld.getAnchor("map"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>

  </tr>
    <tr>
    <td>Logo:</td>
  <td><input  id="CHECKBOX" type="CHECKBOX" name="logo" value="checkbox"  <%=getCheck(ld.getIstype("logo"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="logo_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("logo")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="logo_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("logo")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="logo_3" type="text" value="<%=ld.getSequence("logo")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="logo_4"   <%=getCheck(ld.getAnchor("logo"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>

  </tr>
      <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
  <td><input  id="CHECKBOX" type="CHECKBOX" name="bp" value="checkbox"  <%=getCheck(ld.getIstype("bp"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="bp_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("bp")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="bp_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("bp")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="bp_3" type="text" value="<%=ld.getSequence("bp")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="bp_4"   <%=getCheck(ld.getAnchor("bp"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>

  </tr>
        <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
  <td><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("text")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("text")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" type="text" value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>

  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Contact")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getContact" value="checkbox"  <%=getCheck(ld.getIstype("getContact"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getContact_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getContact")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getContact_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getContact")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getContact_3" type="text" value="<%=ld.getSequence("getContact")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getContact_4"   <%=getCheck(ld.getAnchor("getContact"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getPhone" value="checkbox"  <%=getCheck(ld.getIstype("getPhone"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getPhone_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getPhone")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getPhone_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getPhone")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPhone_3" type="text" value="<%=ld.getSequence("getPhone")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getPhone_4"   <%=getCheck(ld.getAnchor("getPhone"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Fax")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getFax" value="checkbox"  <%=getCheck(ld.getIstype("getFax"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getFax_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getFax")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getFax_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getFax")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFax_3" type="text" value="<%=ld.getSequence("getFax")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getFax_4"   <%=getCheck(ld.getAnchor("getFax"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Zip")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getPostalcode" value="checkbox"  <%=getCheck(ld.getIstype("getPostalcode"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getPostalcode_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getPostalcode")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getPostalcode_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getPostalcode")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPostalcode_3" type="text" value="<%=ld.getSequence("getPostalcode")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getPostalcode_4"   <%=getCheck(ld.getAnchor("getPostalcode"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Intro")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getIntro" value="checkbox"  <%=getCheck(ld.getIstype("getIntro"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getIntro_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getIntro")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getIntro_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getIntro")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getIntro_3" type="text" value="<%=ld.getSequence("getIntro")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getIntro_4"   <%=getCheck(ld.getAnchor("getIntro"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "StarClass")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getStarClass" value="checkbox"  <%=getCheck(ld.getIstype("getStarClass"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getStarClass_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getStarClass")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getStarClass_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getStarClass")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getStarClass_3" type="text" value="<%=ld.getSequence("getStarClass")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getStarClass_4"   <%=getCheck(ld.getAnchor("getStarClass"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

    <tr>
    <td><%=r.getString(teasession._nLanguage, "Price")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="getPrice" value="checkbox"  <%=getCheck(ld.getIstype("getPrice"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getPrice_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("getPrice")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getPrice_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("getPrice")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPrice_3" type="text" value="<%=ld.getSequence("getPrice")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getPrice_4"   <%=getCheck(ld.getAnchor("getPrice"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="Picture" value="checkbox"  <%=getCheck(ld.getIstype("Picture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="Picture_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("Picture")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="Picture_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("Picture")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Picture_3" type="text" value="<%=ld.getSequence("Picture")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="Picture_4"   <%=getCheck(ld.getAnchor("Picture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "PictureName")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="PictureName" value="checkbox"  <%=getCheck(ld.getIstype("PictureName"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="PictureName_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("PictureName")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="PictureName_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("PictureName")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="PictureName_3" type="text" value="<%=ld.getSequence("PictureName")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="PictureName_4"   <%=getCheck(ld.getAnchor("PictureName"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <%--
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>2: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="Picture2"    <%=getCheck(ld.getIstype("Picture2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="Picture2_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("Picture2")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="Picture2_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("Picture2")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Picture2_3" type="text" value="<%=ld.getSequence("Picture2")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="Picture2_4"   <%=getCheck(ld.getAnchor("Picture2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "PictureName")%>2: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="PictureName2"    <%=getCheck(ld.getIstype("PictureName2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="PictureName2_1" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getBeforeItem("PictureName2")))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="PictureName2_2" mask="max" value="<%=HtmlElement.htmlToText(getNull(ld.getAfterItem("PictureName2")))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="PictureName2_3" type="text" value="<%=ld.getSequence("PictureName2")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="PictureName2_4"   <%=getCheck(ld.getAnchor("PictureName2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>3: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="Picture3"    <%=getCheck(ld.getIstype("Picture3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="Picture3_1" mask="max" value="<%=getNull(ld.getBeforeItem("Picture3"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="Picture3_2" mask="max" value="<%=getNull(ld.getAfterItem("Picture3"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Picture3_3" type="text" value="<%=ld.getSequence("Picture3")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="Picture3_4"   <%=getCheck(ld.getAnchor("Picture3"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "PictureName")%>3: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="PictureName3"    <%=getCheck(ld.getIstype("PictureName3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="PictureName3_1" mask="max" value="<%=getNull(ld.getBeforeItem("PictureName3"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="PictureName3_2" mask="max" value="<%=getNull(ld.getAfterItem("PictureName3"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="PictureName3_3" type="text" value="<%=ld.getSequence("PictureName3")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="PictureName3_4"   <%=getCheck(ld.getAnchor("PictureName3"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "OtherPicture")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="OtherPicture"    <%=getCheck(ld.getIstype("OtherPicture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="OtherPicture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("OtherPicture"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="OtherPicture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("OtherPicture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="OtherPicture_3" type="text" value="<%=ld.getSequence("OtherPicture")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="OtherPicture_4"   <%=getCheck(ld.getAnchor("OtherPicture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "OtherPictureName")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="OtherPictureName"    <%=getCheck(ld.getIstype("OtherPictureName"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="OtherPictureName_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("OtherPictureName"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="OtherPictureName_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("OtherPictureName"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="OtherPictureName_3" type="text" value="<%=ld.getSequence("OtherPictureName")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="OtherPictureName_4"   <%=getCheck(ld.getAnchor("OtherPictureName"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>--%>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "RoomPrice")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="RoomPrice"    <%=getCheck(ld.getIstype("RoomPrice"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="RoomPrice_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("RoomPrice"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="RoomPrice_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("RoomPrice"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="RoomPrice_3" type="text" value="<%=ld.getSequence("RoomPrice")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="RoomPrice_4"   <%=getCheck(ld.getAnchor("RoomPrice"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

</table>
    <input type=SUBMIT name="GoBack" class="edit_button"  value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

