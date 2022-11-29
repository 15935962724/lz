<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/Expert");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
    response.sendError(403);
    return;
}
boolean flag=request.getParameter("PickNode")==null;
Classified classified = Classified.find(teasession._nNode);

ListingDetail ld=ListingDetail.find(iListing,28,teasession._nLanguage);


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Expert")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
     <div id="head6"><img height="6" src="about:blank"></div>
   <br>
     <FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
       <input type='hidden' name="node" value="<%=iNode%>">
         <input type="hidden" name="ListingType" value="28"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

         <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr>
              <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
              <td>
<input  id="CHECKBOX" type="CHECKBOX" name="Name" value="checkbox"  <%=getCheck(ld.getIstype("Name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Name"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Name"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Name_3" type="text" class="edit_input" value="<%=ld.getSequence("Name")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Name_4"   <%=getCheck(ld.getAnchor("Name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="Name_5" class="edit_input" type="text" value="<%=ld.getQuantity("Name")%>" mask="int" maxlength="3" size="4"/>
                </td>
            </tr>

              <tr>
              <td><%=r.getString(teasession._nLanguage, "Intro")%>:</td>
              <td>
<input  id="CHECKBOX" type="CHECKBOX" name="Intro" value="checkbox"  <%=getCheck(ld.getIstype("Intro"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Intro_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Intro"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Intro_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Intro"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Intro_3" type="text" class="edit_input" value="<%=ld.getSequence("Intro")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Intro_4"   <%=getCheck(ld.getAnchor("Intro"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="Intro_5" class="edit_input" type="text" value="<%=ld.getQuantity("Intro")%>" mask="int" maxlength="3" size="4"/>
                </td>
            </tr>
                      <tr>
              <td><%=r.getString(teasession._nLanguage, "Sex")%>:</td>
              <td>
<input  id="CHECKBOX" type="CHECKBOX" name="sex" value="checkbox"  <%=getCheck(ld.getIstype("sex"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="sex_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sex"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="sex_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sex"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="sex_3" type="text" class="edit_input" value="<%=ld.getSequence("sex")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="sex_4"   <%=getCheck(ld.getAnchor("sex"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>
            </tr>
                      <tr>
              <td><%=r.getString(teasession._nLanguage, "Birthday")%>:</td>
              <td>
<input  id="CHECKBOX" type="CHECKBOX" name="birthday" value="checkbox"  <%=getCheck(ld.getIstype("birthday"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="birthday_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("birthday"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="birthday_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("birthday"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="birthday_3" type="text" class="edit_input" value="<%=ld.getSequence("birthday")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="birthday_4"   <%=getCheck(ld.getAnchor("birthday"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>
            </tr>                      <tr>
              <td><%=r.getString(teasession._nLanguage, "Photo")%>:</td>
              <td>
<input  id="CHECKBOX" type="CHECKBOX" name="photo" value="checkbox"  <%=getCheck(ld.getIstype("photo"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="photo_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("photo"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="photo_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("photo"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="photo_3" type="text" class="edit_input" value="<%=ld.getSequence("photo")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="photo_4"   <%=getCheck(ld.getAnchor("photo"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>
            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Contact")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="Contact" value="checkbox"  <%=getCheck(ld.getIstype("Contact"))%>><%=r.getString(teasession._nLanguage, "Show")%>
                <%=r.getString(teasession._nLanguage, "Before")%><input  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Contact"))%>" type="text" class="edit_input"  name="Contact_1">
                  <%=r.getString(teasession._nLanguage, "After")%><input  mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Contact"))%>" type="text" class="edit_input" name="Contact_2">
                    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Contact_3" type="text" class="edit_input" value="<%=ld.getSequence("Contact")%>" maxlength="3" size="4">
                      <input  id=CHECKBOX type="CHECKBOX" name="Contact_4"   <%=getCheck(ld.getAnchor("Contact"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
              </td> </tr>
              <tr>
              <td><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
              <td>
<input  id="CHECKBOX" type="CHECKBOX" name="EmailAddress" value="checkbox"  <%=getCheck(ld.getIstype("EmailAddress"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="EmailAddress_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("EmailAddress"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="EmailAddress_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("EmailAddress"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="EmailAddress_3" type="text" class="edit_input" value="<%=ld.getSequence("EmailAddress")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="EmailAddress_4"   <%=getCheck(ld.getAnchor("EmailAddress"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>
            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Organization")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="Organization" value="checkbox"  <%=getCheck(ld.getIstype("Organization"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Organization_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Organization"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Organization_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Organization"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Organization_3" type="text" class="edit_input" value="<%=ld.getSequence("Organization")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Organization_4"   <%=getCheck(ld.getAnchor("Organization"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>


 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="Organization_5" class="edit_input" type="text" value="<%=ld.getQuantity("Organization")%>" mask="int" maxlength="3" size="4"/>
                </td>            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="Address" value="checkbox"  <%=getCheck(ld.getIstype("Address"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Address_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Address_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Address_3" type="text" class="edit_input" value="<%=ld.getSequence("Address")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Address_4"   <%=getCheck(ld.getAnchor("Address"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "City")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="City" value="checkbox"  <%=getCheck(ld.getIstype("City"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="City_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("City"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="City_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("City"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="City_3" type="text" class="edit_input" value="<%=ld.getSequence("City")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="City_4"   <%=getCheck(ld.getAnchor("City"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "State")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="State" value="checkbox"  <%=getCheck(ld.getIstype("State"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="State_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("State"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="State_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("State"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="State_3" type="text" class="edit_input" value="<%=ld.getSequence("State")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="State_4"   <%=getCheck(ld.getAnchor("State"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Zip")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="Zip" value="checkbox"  <%=getCheck(ld.getIstype("Zip"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Zip_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Zip"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Zip_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Zip"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Zip_3" type="text" class="edit_input" value="<%=ld.getSequence("Zip")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Zip_4"   <%=getCheck(ld.getAnchor("Zip"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>

            <tr>
              <td><%=r.getString(teasession._nLanguage, "Country")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="Country" value="checkbox"  <%=getCheck(ld.getIstype("Country"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Country_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Country"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Country_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Country"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Country_3" type="text" class="edit_input" value="<%=ld.getSequence("Country")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Country_4"   <%=getCheck(ld.getAnchor("Country"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="Telephone" value="checkbox"  <%=getCheck(ld.getIstype("Telephone"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Telephone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Telephone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Telephone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Telephone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Telephone_3" type="text" class="edit_input" value="<%=ld.getSequence("Telephone")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Telephone_4"   <%=getCheck(ld.getAnchor("Telephone"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Fax")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="Fax" value="checkbox"  <%=getCheck(ld.getIstype("Fax"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Fax_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Fax"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Fax_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Fax"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Fax_3" type="text" class="edit_input" value="<%=ld.getSequence("Fax")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Fax_4"   <%=getCheck(ld.getAnchor("Fax"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "WebPage")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="WebPage" value="checkbox"  <%=getCheck(ld.getIstype("WebPage"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="WebPage_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("WebPage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="WebPage_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("WebPage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="WebPage_3" type="text" class="edit_input" value="<%=ld.getSequence("WebPage")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="WebPage_4"   <%=getCheck(ld.getAnchor("WebPage"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Stature")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="WebLanguage" value="checkbox"  <%=getCheck(ld.getIstype("WebLanguage"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="WebLanguage_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("WebLanguage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="WebLanguage_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("WebLanguage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="WebLanguage_3" type="text" class="edit_input" value="<%=ld.getSequence("WebLanguage")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="WebLanguage_4"   <%=getCheck(ld.getAnchor("WebLanguage"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Place")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="place" value="checkbox"  <%=getCheck(ld.getIstype("place"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="place_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("place"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="place_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("place"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="place_3" type="text" class="edit_input" value="<%=ld.getSequence("place")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="place_4"   <%=getCheck(ld.getAnchor("place"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
                            <tr>
              <td><%=r.getString(teasession._nLanguage, "LanguageClass")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="languageclass" value="checkbox"  <%=getCheck(ld.getIstype("languageclass"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="languageclass_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("languageclass"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="languageclass_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("languageclass"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="languageclass_3" type="text" class="edit_input" value="<%=ld.getSequence("languageclass")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="languageclass_4"   <%=getCheck(ld.getAnchor("languageclass"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
                 <tr>
              <td><%=r.getString(teasession._nLanguage, "Photo")%><%=r.getString(teasession._nLanguage, "Big")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="photobig" value="checkbox"  <%=getCheck(ld.getIstype("photobig"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="photobig_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("photobig"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="photobig_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("photobig"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="photobig_3" type="text" class="edit_input" value="<%=ld.getSequence("photobig")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="photobig_4"   <%=getCheck(ld.getAnchor("photobig"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>

                  <tr>
              <td><%=r.getString(teasession._nLanguage, "Alias")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="alias" value="checkbox"  <%=getCheck(ld.getIstype("alias"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="alias_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("alias"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="alias_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("alias"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="alias_3" type="text" class="edit_input" value="<%=ld.getSequence("alias")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="alias_4"   <%=getCheck(ld.getAnchor("alias"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
                   <tr>
              <td><%=r.getString(teasession._nLanguage, "Matriculation")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="matriculation" value="checkbox"  <%=getCheck(ld.getIstype("matriculation"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="matriculation_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("matriculation"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="matriculation_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("matriculation"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="matriculation_3" type="text" class="edit_input" value="<%=ld.getSequence("matriculation")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="matriculation_4"   <%=getCheck(ld.getAnchor("matriculation"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
                 <tr>
              <td><%=r.getString(teasession._nLanguage, "Folk")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="folk" value="checkbox"  <%=getCheck(ld.getIstype("folk"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="folk_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("folk"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="folk_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("folk"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="folk_3" type="text" class="edit_input" value="<%=ld.getSequence("folk")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="folk_4"   <%=getCheck(ld.getAnchor("folk"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
                  <tr>
              <td><%=r.getString(teasession._nLanguage, "Classes")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="classes" value="checkbox"  <%=getCheck(ld.getIstype("classes"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="classes_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("classes"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="classes_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("classes"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="classes_3" type="text" class="edit_input" value="<%=ld.getSequence("classes")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="classes_4"   <%=getCheck(ld.getAnchor("classes"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr><tr>
              <td><%=r.getString(teasession._nLanguage, "Graduate")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="graduate" value="checkbox"  <%=getCheck(ld.getIstype("graduate"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="graduate_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("graduate"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="graduate_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("graduate"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="graduate_3" type="text" class="edit_input" value="<%=ld.getSequence("graduate")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="graduate_4"   <%=getCheck(ld.getAnchor("graduate"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr><tr>
              <td><%=r.getString(teasession._nLanguage, "Aim")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="aim" value="checkbox"  <%=getCheck(ld.getIstype("aim"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="aim_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("aim"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="aim_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("aim"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="aim_3" type="text" class="edit_input" value="<%=ld.getSequence("aim")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="aim_4"   <%=getCheck(ld.getAnchor("aim"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr><tr>
              <td><%=r.getString(teasession._nLanguage, "Duty")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="duty" value="checkbox"  <%=getCheck(ld.getIstype("duty"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="duty_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("duty"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="duty_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("duty"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="duty_3" type="text" class="edit_input" value="<%=ld.getSequence("duty")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="duty_4"   <%=getCheck(ld.getAnchor("duty"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr><tr>
              <td><%=r.getString(teasession._nLanguage, "Technical")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="technical" value="checkbox"  <%=getCheck(ld.getIstype("technical"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="technical_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("technical"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="technical_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("technical"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="technical_3" type="text" class="edit_input" value="<%=ld.getSequence("technical")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="technical_4"   <%=getCheck(ld.getAnchor("technical"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr><tr>
              <td><%=r.getString(teasession._nLanguage, "HomePhone")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="homephone" value="checkbox"  <%=getCheck(ld.getIstype("homephone"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="homephone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("homephone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="homephone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("homephone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="homephone_3" type="text" class="edit_input" value="<%=ld.getSequence("homephone")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="homephone_4"   <%=getCheck(ld.getAnchor("homephone"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr><tr>
              <td><%=r.getString(teasession._nLanguage, "Handset")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="handset" value="checkbox"  <%=getCheck(ld.getIstype("handset"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="handset_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("handset"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="handset_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("handset"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="handset_3" type="text" class="edit_input" value="<%=ld.getSequence("handset")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="handset_4"   <%=getCheck(ld.getAnchor("handset"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr><tr>
              <td>MSN:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="msn" value="checkbox"  <%=getCheck(ld.getIstype("msn"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="msn_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("msn"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="msn_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("msn"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="msn_3" type="text" class="edit_input" value="<%=ld.getSequence("msn")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="msn_4"   <%=getCheck(ld.getAnchor("msn"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
                <tr>
              <td>QQ:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="qq" value="checkbox"  <%=getCheck(ld.getIstype("qq"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="qq_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("qq"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="qq_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("qq"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="qq_3" type="text" class="edit_input" value="<%=ld.getSequence("qq")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="qq_4"   <%=getCheck(ld.getAnchor("qq"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr><tr>
              <td><%=r.getString(teasession._nLanguage, "LeaveWord")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="leaveword" value="checkbox"  <%=getCheck(ld.getIstype("leaveword"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="leaveword_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("leaveword"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="leaveword_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("leaveword"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="leaveword_3" type="text" class="edit_input" value="<%=ld.getSequence("leaveword")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="leaveword_4"   <%=getCheck(ld.getAnchor("leaveword"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
                
                <tr>
              <td><%=r.getString(teasession._nLanguage, "rfield")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="rfield" value="checkbox"  <%=getCheck(ld.getIstype("rfield"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="rfield_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("rfield"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="rfield_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("rfield"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="rfield_3" type="text" class="edit_input" value="<%=ld.getSequence("rfield")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="rfield_4"   <%=getCheck(ld.getAnchor("rfield"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>           
                 </tr>
               
                <tr>
              <td><%=r.getString(teasession._nLanguage, "mrr")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="mrr" value="checkbox"  <%=getCheck(ld.getIstype("mrr"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="mrr_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mrr"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="mrr_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mrr"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mrr_3" type="text" class="edit_input" value="<%=ld.getSequence("mrr")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="mrr_4"   <%=getCheck(ld.getAnchor("mrr"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
                
                 <tr>
              <td><%=r.getString(teasession._nLanguage, "mrrs")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="mrrs" value="checkbox"  <%=getCheck(ld.getIstype("mrrs"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="mrrs_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mrrs"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="mrrs_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mrrs"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mrrs_3" type="text" class="edit_input" value="<%=ld.getSequence("mrrs")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="mrrs_4"   <%=getCheck(ld.getAnchor("mrrs"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
                <tr>
              <td><%=r.getString(teasession._nLanguage, "oci")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="oci" value="checkbox"  <%=getCheck(ld.getIstype("oci"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="oci_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("oci"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="oci_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("oci"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="oci_3" type="text" class="edit_input" value="<%=ld.getSequence("oci")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="oci_4"   <%=getCheck(ld.getAnchor("oci"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </td>            </tr>
<!--tr>
    <td colspan="2"><hr size="1"></td>
</tr>
 <tr>
      <td>
      </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onclick="fshow()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input   class="edit_input" name="objbefore1"  mask="max" onfocus="fbefore()"  onchange="fbefore()" value="" type="text">
              <%=r.getString(teasession._nLanguage, "After")%><input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onchange="fafter()" value="" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<a href="#" onclick="fsequ()"  ><%=r.getString(teasession._nLanguage, "Default")%></a>
    <input  id="CHECKBOX" type="CHECKBOX" name="objanchor_4" onclick="fanchor()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
                                                </td>
                      </tr-->
</table><center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
      </center>
  </form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
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
  <SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.Name_1.focus();</SCRIPT>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</DIV>
</body>
</html>

