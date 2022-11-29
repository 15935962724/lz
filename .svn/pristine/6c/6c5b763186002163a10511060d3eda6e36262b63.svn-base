<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>


<%

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
      response.sendError(403);
      return;
}
  r.add("/tea/resource/Flight");
boolean flag=request.getParameter("PickNode")==null;


ListingDetail ld=ListingDetail.find(iListing,49,teasession._nLanguage);


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "FlightDetail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
       <input type="hidden" name="ListingType" value="49"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
    <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="name_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "AfterItem")%><input name="name_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" type="text" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="name_4"  <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Logo")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="logo" value="checkbox"  <%=getCheck(ld.getIstype("logo"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="logo_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("logo"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="logo_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("logo"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="logo_3" type="text" value="<%=ld.getSequence("logo")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="logo_4"  <%=getCheck(ld.getAnchor("logo"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Flight")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getMark" value="checkbox"  <%=getCheck(ld.getIstype("getMark"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getMark_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getMark"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getMark_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getMark"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getMark_3" type="text" value="<%=ld.getSequence("getMark")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="getMark_4"  <%=getCheck(ld.getAnchor("getMark"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td></tr>

   <tr>
    <td><%=r.getString(teasession._nLanguage, "AeronefType")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getTypes" value="checkbox"  <%=getCheck(ld.getIstype("getTypes"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getTypes_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getTypes"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getTypes_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getTypes"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getTypes_3" type="text" value="<%=ld.getSequence("getTypes")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="getTypes_4"  <%=getCheck(ld.getAnchor("getTypes"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td></tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Start")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getStart" value="checkbox"  <%=getCheck(ld.getIstype("getStart"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getStart_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getStart"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getStart_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getStart"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getStart_3" type="text" value="<%=ld.getSequence("getStart")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="getStart_4"  <%=getCheck(ld.getAnchor("getStart"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td></tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Terminus")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getTerminus" value="checkbox"  <%=getCheck(ld.getIstype("getTerminus"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getTerminus_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getTerminus"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getTerminus_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getTerminus"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getTerminus_3" type="text" value="<%=ld.getSequence("getTerminus")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="getTerminus_4"  <%=getCheck(ld.getAnchor("getTerminus"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td></tr>


  <tr>
    <td><%=r.getString(teasession._nLanguage, "Takeoff")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getTakeoffToString" value="checkbox"  <%=getCheck(ld.getIstype("getTakeoffToString"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getTakeoffToString_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getTakeoffToString"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name=getTakeoffToString_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getTakeoffToString"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getTakeoffToString_3" type="text" value="<%=ld.getSequence("getTakeoffToString")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getTakeoffToString_4"  <%=getCheck(ld.getAnchor("getTakeoffToString"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Descent")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getDescentToString" value="checkbox"  <%=getCheck(ld.getIstype("getDescentToString"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getDescentToString_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getDescentToString"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getDescentToString_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getDescentToString"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getDescentToString_3" type="text" value="<%=ld.getSequence("getDescentToString")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getDescentToString_4"  <%=getCheck(ld.getAnchor("getDescentToString"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Eat")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getEat" value="checkbox"  <%=getCheck(ld.getIstype("getEat"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getEat_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getEat"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getEat_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getEat"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getEat_3" type="text" value="<%=ld.getSequence("getEat")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getEat_4"  <%=getCheck(ld.getAnchor("getEat"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
      <tr>
    <td><%=r.getString(teasession._nLanguage, "Remark")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getRemark" value="checkbox"  <%=getCheck(ld.getIstype("getRemark"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getRemark_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getRemark"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getRemark_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getRemark"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getRemark_3" type="text" value="<%=ld.getSequence("getRemark")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getRemark_4"  <%=getCheck(ld.getAnchor("getRemark"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
        <tr>
    <td><%=r.getString(teasession._nLanguage, "Price")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getPrice" value="checkbox"  <%=getCheck(ld.getIstype("getPrice"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getPrice_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPrice"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getPrice_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPrice"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPrice_3" type="text" value="<%=ld.getSequence("getPrice")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getPrice_4"  <%=getCheck(ld.getAnchor("getPrice"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
          <tr>
    <td><%=r.getString(teasession._nLanguage, "Tax")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getTax" value="checkbox"  <%=getCheck(ld.getIstype("getTax"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getTax_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getTax"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getTax_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getTax"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getTax_3" type="text" value="<%=ld.getSequence("getTax")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getTax_4"  <%=getCheck(ld.getAnchor("getTax"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
            <tr>
    <td><%=r.getString(teasession._nLanguage, "Startaerodrome")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getStartaerodrome" value="checkbox"  <%=getCheck(ld.getIstype("getStartaerodrome"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getStartaerodrome_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getStartaerodrome"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getStartaerodrome_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getStartaerodrome"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getStartaerodrome_3" type="text" value="<%=ld.getSequence("getStartaerodrome")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getStartaerodrome_4"  <%=getCheck(ld.getAnchor("getStartaerodrome"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
              <tr>
    <td><%=r.getString(teasession._nLanguage, "Terminusaerodrome")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getTerminusaerodrome" value="checkbox"  <%=getCheck(ld.getIstype("getTerminusaerodrome"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getTerminusaerodrome_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getTerminusaerodrome"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getTerminusaerodrome_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getTerminusaerodrome"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getTerminusaerodrome_3" type="text" value="<%=ld.getSequence("getTerminusaerodrome")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getTerminusaerodrome_4"  <%=getCheck(ld.getAnchor("getTerminusaerodrome"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
                <tr>
    <td><%=r.getString(teasession._nLanguage, "Company")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getCompany" value="checkbox"  <%=getCheck(ld.getIstype("getCompany"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getCompany_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getCompany"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getCompany_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getCompany"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getCompany_3" type="text" value="<%=ld.getSequence("getCompany")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getCompany_4"  <%=getCheck(ld.getAnchor("getCompany"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
                  <tr>
    <td><%=r.getString(teasession._nLanguage, "Nonstop")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="isNonstop" value="checkbox"  <%=getCheck(ld.getIstype("isNonstop"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="isNonstop_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("isNonstop"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="isNonstop_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("isNonstop"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="isNonstop_3" type="text" value="<%=ld.getSequence("isNonstop")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="isNonstop_4"  <%=getCheck(ld.getAnchor("isNonstop"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
            <tr>
    <td><%=r.getString(teasession._nLanguage, "FlyType")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getFly" value="checkbox"  <%=getCheck(ld.getIstype("getFly"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="getFly_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFly"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="getFly_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFly"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFly_3" type="text" value="<%=ld.getSequence("getFly")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getFly_4"  <%=getCheck(ld.getAnchor("getFly"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
  <tr><td colspan="20"><hr size="1" /></td>
  </tr>
      <tr>
    <td><%=r.getString(teasession._nLanguage, "Berth")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="b_getName" value="checkbox"  <%=getCheck(ld.getIstype("b_getName"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="b_getName_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("b_getName"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="b_getName_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("b_getName"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="b_getName_3" type="text" value="<%=ld.getSequence("b_getName")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="b_getName_4"  <%=getCheck(ld.getAnchor("b_getName"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Aagio")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="b_getAagio" value="checkbox"  <%=getCheck(ld.getIstype("b_getAagio"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="b_getAagio_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("b_getAagio"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="b_getAagio_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("b_getAagio"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="b_getAagio_3" type="text" value="<%=ld.getSequence("b_getAagio")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="b_getAagio_4"  <%=getCheck(ld.getAnchor("b_getAagio"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Price")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="b_getPrice" value="checkbox"  <%=getCheck(ld.getIstype("b_getPrice"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="b_getPrice_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("b_getPrice"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="b_getPrice_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("b_getPrice"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="b_getPrice_3" type="text" value="<%=ld.getSequence("b_getPrice")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="b_getPrice_4"  <%=getCheck(ld.getAnchor("b_getPrice"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
</table>
<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

