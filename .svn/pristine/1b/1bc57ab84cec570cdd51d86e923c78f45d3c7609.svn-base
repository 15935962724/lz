<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

r.add("/tea/resource/Environmental");

ListingDetail ld=ListingDetail.find(iListing,75,teasession._nLanguage);



%>

<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Environmental")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
            <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="75"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

         <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
             <TR>
              <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
<%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4">
                </TD>            </TR>

                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Classes")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="classes" value="checkbox"  <%=getCheck(ld.getIstype("classes"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="classes_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("classes"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="classes_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("classes"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="classes_3" type="text" class="edit_input" value="<%=ld.getSequence("classes")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="classes_4"   <%=getCheck(ld.getAnchor("classes"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Postalcode")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="postalcode" value="checkbox"  <%=getCheck(ld.getIstype("postalcode"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="postalcode_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("postalcode"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="postalcode_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("postalcode"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="postalcode_3" type="text" class="edit_input" value="<%=ld.getSequence("postalcode")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="postalcode_4"   <%=getCheck(ld.getAnchor("postalcode"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD><%=r.getString(teasession._nLanguage, "PolyName")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="polyname" value="checkbox"  <%=getCheck(ld.getIstype("polyname"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="polyname_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("polyname"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="polyname_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("polyname"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="polyname_3" type="text" class="edit_input" value="<%=ld.getSequence("polyname")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="polyname_4"   <%=getCheck(ld.getAnchor("polyname"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Fax")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="fax" value="checkbox"  <%=getCheck(ld.getIstype("fax"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="fax_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fax"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="fax_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fax"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="fax_3" type="text" class="edit_input" value="<%=ld.getSequence("fax")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="fax_4"   <%=getCheck(ld.getAnchor("fax"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                    <TR>
              <TD><%=r.getString(teasession._nLanguage, "Type")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="type" value="checkbox"  <%=getCheck(ld.getIstype("type"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="type_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("type"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="type_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("type"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="type_3" type="text" class="edit_input" value="<%=ld.getSequence("type")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="type_4"   <%=getCheck(ld.getAnchor("type"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

        <TR>
              <TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="address" value="checkbox"  <%=getCheck(ld.getIstype("address"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="address_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="address_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="address_3" type="text" class="edit_input" value="<%=ld.getSequence("address")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="address_4"   <%=getCheck(ld.getAnchor("address"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
      <TR>
              <TD><%=r.getString(teasession._nLanguage, "PloyAdd")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="ployadd" value="checkbox"  <%=getCheck(ld.getIstype("ployadd"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="ployadd_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ployadd"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="ployadd_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ployadd"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ployadd_3" type="text" class="edit_input" value="<%=ld.getSequence("ployadd")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="ployadd_4"   <%=getCheck(ld.getAnchor("ployadd"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                   <TR>
              <TD><%=r.getString(teasession._nLanguage, "PloyTime")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="ploytime" value="checkbox"  <%=getCheck(ld.getIstype("ploytime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="ploytime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ploytime"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="ploytime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ploytime"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ploytime_3" type="text" class="edit_input" value="<%=ld.getSequence("ploytime")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="ploytime_4"   <%=getCheck(ld.getAnchor("ploytime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                      <TR>
              <TD><%=r.getString(teasession._nLanguage, "PloyCon")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" type="text" class="edit_input" value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="text_5" class="edit_input" type="text" value="<%=ld.getQuantity("text")%>" maxlength="3" size="4">

              </TD>            </TR>
                      <TR>
              <TD><%=r.getString(teasession._nLanguage, "Ploy")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="ploy" value="checkbox"  <%=getCheck(ld.getIstype("ploy"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="ploy_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ploy"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="ploy_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ploy"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ploy_3" type="text" class="edit_input" value="<%=ld.getSequence("ploy")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="ploy_4"   <%=getCheck(ld.getAnchor("ploy"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                         <TR>  <TD><%=r.getString(teasession._nLanguage, "Point")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="point" value="checkbox"  <%=getCheck(ld.getIstype("point"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="point_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("point"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="point_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("point"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="point_3" type="text" class="edit_input" value="<%=ld.getSequence("point")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="point_4"   <%=getCheck(ld.getAnchor("point"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
  <TR>  <TD><%=r.getString(teasession._nLanguage, "Object")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="object" value="checkbox"  <%=getCheck(ld.getIstype("object"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="object_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("object"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="object_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("object"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="object_3" type="text" class="edit_input" value="<%=ld.getSequence("object")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="object_4"   <%=getCheck(ld.getAnchor("object"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
             <TR>  <TD><%=r.getString(teasession._nLanguage, "Sponsor")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="sponsor" value="checkbox"  <%=getCheck(ld.getIstype("sponsor"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="sponsor_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sponsor"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="sponsor_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sponsor"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="sponsor_3" type="text" class="edit_input" value="<%=ld.getSequence("sponsor")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="sponsor_4"   <%=getCheck(ld.getAnchor("sponsor"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                             <TR>  <TD><%=r.getString(teasession._nLanguage, "Vemark")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vemark" value="checkbox"  <%=getCheck(ld.getIstype("vemark"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vemark_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vemark"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vemark_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vemark"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vemark_3" type="text" class="edit_input" value="<%=ld.getSequence("vemark")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="vemark_5" class="edit_input" type="text" value="<%=ld.getQuantity("vemark")%>" maxlength="3" size="4">
                </TD>            </TR>
                  <TR>  <TD><%=r.getString(teasession._nLanguage, "Vemark2")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vemark2" value="checkbox"  <%=getCheck(ld.getIstype("vemark2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vemark2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vemark2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vemark2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vemark2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vemark2_3" type="text" class="edit_input" value="<%=ld.getSequence("vemark2")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="vemark2_5" class="edit_input" type="text" value="<%=ld.getQuantity("vemark2")%>" maxlength="3" size="4">
                </TD>            </TR>
                  <TR>  <TD><%=r.getString(teasession._nLanguage, "Vemark3")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vemark3" value="checkbox"  <%=getCheck(ld.getIstype("vemark3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vemark3_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vemark3"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vemark3_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vemark3"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vemark3_3" type="text" class="edit_input" value="<%=ld.getSequence("vemark3")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="vemark3_5" class="edit_input" type="text" value="<%=ld.getQuantity("vemark3")%>" maxlength="3" size="4">
                </TD>            </TR>
                   <TR>  <TD><%=r.getString(teasession._nLanguage, "Vemark4")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vemark4" value="checkbox"  <%=getCheck(ld.getIstype("vemark4"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vemark4_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vemark4"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vemark4_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vemark4"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vemark4_3" type="text" class="edit_input" value="<%=ld.getSequence("vemark4")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="vemark4_5" class="edit_input" type="text" value="<%=ld.getQuantity("vemark4")%>" maxlength="3" size="4">
                </TD>            </TR>
                  <TR>  <TD><%=r.getString(teasession._nLanguage, "Vemark5")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vemark5" value="checkbox"  <%=getCheck(ld.getIstype("vemark5"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vemark5_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vemark5"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vemark5_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vemark5"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vemark5_3" type="text" class="edit_input" value="<%=ld.getSequence("vemark5")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="vemark5_5" class="edit_input" type="text" value="<%=ld.getQuantity("vemark5")%>" maxlength="3" size="4">
                </TD>            </TR>
        <TR>  <TD><%=r.getString(teasession._nLanguage, "Vemark6")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vemark6" value="checkbox"  <%=getCheck(ld.getIstype("vemark6"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vemark6_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vemark6"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vemark6_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vemark6"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vemark6_3" type="text" class="edit_input" value="<%=ld.getSequence("vemark6")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="vemark6_5" class="edit_input" type="text" value="<%=ld.getQuantity("vemark6")%>" maxlength="3" size="4">
                </TD>            </TR>
                 <TR>  <TD><%=r.getString(teasession._nLanguage, "Vemark7")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vemark7" value="checkbox"  <%=getCheck(ld.getIstype("vemark7"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vemark7_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vemark7"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vemark7_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vemark7"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vemark7_3" type="text" class="edit_input" value="<%=ld.getSequence("vemark7")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="vemark7_5" class="edit_input" type="text" value="<%=ld.getQuantity("vemark7")%>" maxlength="3" size="4">
                </TD>            </TR>


               <TR>  <TD><%=r.getString(teasession._nLanguage, "Name")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vouchname" value="checkbox"  <%=getCheck(ld.getIstype("vouchname"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vouchname_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vouchname"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vouchname_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vouchname"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vouchname_3" type="text" class="edit_input" value="<%=ld.getSequence("vouchname")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                 </TD>            </TR>
                 <TR>  <TD><%=r.getString(teasession._nLanguage, "VouchCom")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vouchcom" value="checkbox"  <%=getCheck(ld.getIstype("vouchcom"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vouchcom_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vouchcom"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vouchcom_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vouchcom"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vouchcom_3" type="text" class="edit_input" value="<%=ld.getSequence("vouchcom")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                  <TR>  <TD><%=r.getString(teasession._nLanguage, "VouchDuty")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vouchduty" value="checkbox"  <%=getCheck(ld.getIstype("vouchduty"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vouchduty_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vouchduty"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vouchduty_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vouchduty"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vouchduty_3" type="text" class="edit_input" value="<%=ld.getSequence("vouchduty")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                 </TD>            </TR>
                 <TR>  <TD><%=r.getString(teasession._nLanguage, "VouchTele")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vouchtele" value="checkbox"  <%=getCheck(ld.getIstype("vouchtele"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vouchtele_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vouchtele"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vouchtele_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vouchtele"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vouchtele_3" type="text" class="edit_input" value="<%=ld.getSequence("vouchtele")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                     <TR>  <TD><%=r.getString(teasession._nLanguage, "Comm")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="comm" value="checkbox"  <%=getCheck(ld.getIstype("comm"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="comm_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("comm"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="comm_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("comm"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="comm_3" type="text" class="edit_input" value="<%=ld.getSequence("comm")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                 </TD>            </TR>
                 <TR>  <TD><%=r.getString(teasession._nLanguage, "Phone")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="comtele" value="checkbox"  <%=getCheck(ld.getIstype("comtele"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="comtele_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("comtele"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="comtele_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("comtele"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="comtele_3" type="text" class="edit_input" value="<%=ld.getSequence("comtele")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                  <TR>  <TD><%=r.getString(teasession._nLanguage, "Linkman")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="conname" value="checkbox"  <%=getCheck(ld.getIstype("conname"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="conname_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("conname"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="conname_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("conname"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="conname_3" type="text" class="edit_input" value="<%=ld.getSequence("conname")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                 </TD>            </TR>
                 <TR>  <TD><%=r.getString(teasession._nLanguage, "Vouch")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="vouch" value="checkbox"  <%=getCheck(ld.getIstype("vouch"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="vouch_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vouch"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="vouch_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("vouch"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vouch_3" type="text" class="edit_input" value="<%=ld.getSequence("vouch")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
</table><center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
      </center>
  </form>

  <script type="">
  function fshow()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)!="_4")
          {
              form1.elements[counter].checked=form1.elements["objshow"].checked;
          }
      }
  }
  function fafter()
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
  function fsequ()
  {
    var paramvalue=0;
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="text"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)=="_3")
          {
              form1.elements[counter].value=++paramvalue*10;
          }
      }
  }
</script>
  <SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.subject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

