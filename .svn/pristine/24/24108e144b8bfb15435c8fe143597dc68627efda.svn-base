<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/node/type/classified/EditClassified");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;
Classified classified = Classified.find(teasession._nNode);

ListingDetail ld=ListingDetail.find(iListing,21,teasession._nLanguage);


%>

<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Company")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
            <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="21"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Name")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="Name" value="checkbox"  <%=getCheck(ld.getIstype("Name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Name"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Name"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Name_3" type="text" class="edit_input" value="<%=ld.getSequence("Name")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Name_4"   <%=getCheck(ld.getAnchor("Name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>

              <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Intro")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="Intro" value="checkbox"  <%=getCheck(ld.getIstype("Intro"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Intro_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Intro"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Intro_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Intro"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Intro_3" type="text" class="edit_input" value="<%=ld.getSequence("Intro")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Intro_4"   <%=getCheck(ld.getAnchor("Intro"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>
                      <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "CorpJob")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="CorpJob" value="checkbox"  <%=getCheck(ld.getIstype("CorpJob"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="CorpJob_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("CorpJob"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="CorpJob_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("CorpJob"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="CorpJob_3" type="text" class="edit_input" value="<%=ld.getSequence("CorpJob")%>" maxlength="3" size="4">
<%--<input  id=CHECKBOX type="CHECKBOX" name="CorpJob_4"   <%=getCheck(ld.getAnchor("CorpJob"))%>><%=r.getString(teasession._nLanguage, "Anchor")--%>
                </TD>
            </TR>
                      <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "CorpJobButton")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="CorpJobButton" value="checkbox"  <%=getCheck(ld.getIstype("CorpJobButton"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="CorpJobButton_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("CorpJobButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="CorpJobButton_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("CorpJobButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="CorpJobButton_3" type="text" class="edit_input" value="<%=ld.getSequence("CorpJobButton")%>" maxlength="3" size="4">
<%--<input  id=CHECKBOX type="CHECKBOX" name="CorpJobButton_4"   <%=getCheck(ld.getAnchor("CorpJobButton"))%>><%=r.getString(teasession._nLanguage, "Anchor")--%>
                </TD>
            </TR>                      <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "EditButton")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="EditButton" value="checkbox"  <%=getCheck(ld.getIstype("EditButton"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="EditButton_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("EditButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="EditButton_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("EditButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="EditButton_3" type="text" class="edit_input" value="<%=ld.getSequence("EditButton")%>" maxlength="3" size="4">
<%--<input  id=CHECKBOX type="CHECKBOX" name="EditButton_4"   <%=getCheck(ld.getAnchor("EditButton"))%>><%=r.getString(teasession._nLanguage, "Anchor")--%>
                </TD>
            </TR>                      <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "DeleteButton")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="DeleteButton" value="checkbox"  <%=getCheck(ld.getIstype("DeleteButton"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="DeleteButton_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("DeleteButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="DeleteButton_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("DeleteButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="DeleteButton_3" type="text" class="edit_input" value="<%=ld.getSequence("DeleteButton")%>" maxlength="3" size="4">
<%--<input  id=CHECKBOX type="CHECKBOX" name="DeleteButton_4"   <%=getCheck(ld.getAnchor("DeleteButton"))%>><%=r.getString(teasession._nLanguage, "Anchor")--%>
                </TD>
            </TR>
            <TR>
              <TD width="26" ID=RowHeader><%=r.getString(teasession._nLanguage, "Contact")%>:</TD>
              <TD width="516"><input  id="CHECKBOX" type="CHECKBOX" name="Contact" value="checkbox"  <%=getCheck(ld.getIstype("Contact"))%>><%=r.getString(teasession._nLanguage, "Show")%>
			  	<%=r.getString(teasession._nLanguage, "Before")%><input  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Contact"))%>" type="text" class="edit_input"  name="Contact_1">
                <%=r.getString(teasession._nLanguage, "After")%><input  mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Contact"))%>" type="text" class="edit_input" name="Contact_2">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Contact_3" type="text" class="edit_input" value="<%=ld.getSequence("Contact")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="Contact_4"   <%=getCheck(ld.getAnchor("Contact"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
           </TD> </TR>
            <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="EmailAddress" value="checkbox"  <%=getCheck(ld.getIstype("EmailAddress"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="EmailAddress_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("EmailAddress"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="EmailAddress_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("EmailAddress"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="EmailAddress_3" type="text" class="edit_input" value="<%=ld.getSequence("EmailAddress")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="EmailAddress_4"   <%=getCheck(ld.getAnchor("EmailAddress"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>
            <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Organization" value="checkbox"  <%=getCheck(ld.getIstype("Organization"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Organization_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Organization"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Organization_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Organization"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Organization_3" type="text" class="edit_input" value="<%=ld.getSequence("Organization")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Organization_4"   <%=getCheck(ld.getAnchor("Organization"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
            <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Address" value="checkbox"  <%=getCheck(ld.getIstype("Address"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Address_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Address_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Address_3" type="text" class="edit_input" value="<%=ld.getSequence("Address")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Address_4"   <%=getCheck(ld.getAnchor("Address"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
            <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "City")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="City" value="checkbox"  <%=getCheck(ld.getIstype("City"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="City_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("City"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="City_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("City"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="City_3" type="text" class="edit_input" value="<%=ld.getSequence("City")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="City_4"   <%=getCheck(ld.getAnchor("City"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
            <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "State")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="State" value="checkbox"  <%=getCheck(ld.getIstype("State"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="State_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("State"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="State_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("State"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="State_3" type="text" class="edit_input" value="<%=ld.getSequence("State")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="State_4"   <%=getCheck(ld.getAnchor("State"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
            <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Zip" value="checkbox"  <%=getCheck(ld.getIstype("Zip"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Zip_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Zip"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Zip_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Zip"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Zip_3" type="text" class="edit_input" value="<%=ld.getSequence("Zip")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Zip_4"   <%=getCheck(ld.getAnchor("Zip"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

            <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Country")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Country" value="checkbox"  <%=getCheck(ld.getIstype("Country"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Country_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Country"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Country_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Country"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Country_3" type="text" class="edit_input" value="<%=ld.getSequence("Country")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Country_4"   <%=getCheck(ld.getAnchor("Country"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
            <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Telephone" value="checkbox"  <%=getCheck(ld.getIstype("Telephone"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Telephone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Telephone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Telephone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Telephone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Telephone_3" type="text" class="edit_input" value="<%=ld.getSequence("Telephone")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Telephone_4"   <%=getCheck(ld.getAnchor("Telephone"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
            <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Fax")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Fax" value="checkbox"  <%=getCheck(ld.getIstype("Fax"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Fax_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Fax"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Fax_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Fax"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Fax_3" type="text" class="edit_input" value="<%=ld.getSequence("Fax")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Fax_4"   <%=getCheck(ld.getAnchor("Fax"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
            <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "WebPage")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="WebPage" value="checkbox"  <%=getCheck(ld.getIstype("WebPage"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="WebPage_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("WebPage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="WebPage_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("WebPage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="WebPage_3" type="text" class="edit_input" value="<%=ld.getSequence("WebPage")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="WebPage_4"   <%=getCheck(ld.getAnchor("WebPage"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
            <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "WebLanguage")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="WebLanguage" value="checkbox"  <%=getCheck(ld.getIstype("WebLanguage"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="WebLanguage_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("WebLanguage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="WebLanguage_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("WebLanguage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="WebLanguage_3" type="text" class="edit_input" value="<%=ld.getSequence("WebLanguage")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="WebLanguage_4"   <%=getCheck(ld.getAnchor("WebLanguage"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

             <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "License")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="license" value="checkbox"  <%=getCheck(ld.getIstype("license"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="license_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("license"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="license_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("license"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="license_3" type="text" class="edit_input" value="<%=ld.getSequence("license")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="license_4"   <%=getCheck(ld.getAnchor("license"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Property")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="property" value="checkbox"  <%=getCheck(ld.getIstype("property"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="property_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("property"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="property_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("property"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="property_3" type="text" class="edit_input" value="<%=ld.getSequence("property")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="property_4"   <%=getCheck(ld.getAnchor("property"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Size")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="size" value="checkbox"  <%=getCheck(ld.getIstype("size"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="size_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("size"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="size_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("size"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="size_3" type="text" class="edit_input" value="<%=ld.getSequence("size")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="size_4"   <%=getCheck(ld.getAnchor("size"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Calling")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="calling" value="checkbox"  <%=getCheck(ld.getIstype("calling"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="calling_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("calling"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="calling_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("calling"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="calling_3" type="text" class="edit_input" value="<%=ld.getSequence("calling")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="calling_4"   <%=getCheck(ld.getAnchor("calling"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Mode")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="mode" value="checkbox"  <%=getCheck(ld.getIstype("mode"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="mode_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mode"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="mode_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mode"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mode_3" type="text" class="edit_input" value="<%=ld.getSequence("mode")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="mode_4"   <%=getCheck(ld.getAnchor("mode"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                                <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Enrol")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="enrol" value="checkbox"  <%=getCheck(ld.getIstype("enrol"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="enrol_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("enrol"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="enrol_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("enrol"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="enrol_3" type="text" class="edit_input" value="<%=ld.getSequence("enrol")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="enrol_4"   <%=getCheck(ld.getAnchor("enrol"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>                                <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Product")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="product" value="checkbox"  <%=getCheck(ld.getIstype("product"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="product_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("product"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="product_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("product"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="product_3" type="text" class="edit_input" value="<%=ld.getSequence("product")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="product_4"   <%=getCheck(ld.getAnchor("product"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                                       <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Enroladd")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="enroladd" value="checkbox"  <%=getCheck(ld.getIstype("enroladd"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="enroladd_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("enroladd"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="enroladd_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("enroladd"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="enroladd_3" type="text" class="edit_input" value="<%=ld.getSequence("enroladd")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="enroladd_4"   <%=getCheck(ld.getAnchor("enroladd"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>  <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Fareadd")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="fareadd" value="checkbox"  <%=getCheck(ld.getIstype("fareadd"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="fareadd_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fareadd"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="fareadd_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fareadd"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="fareadd_3" type="text" class="edit_input" value="<%=ld.getSequence("fareadd")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="fareadd_4"   <%=getCheck(ld.getAnchor("fareadd"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR> <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Birth")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="birth" value="checkbox"  <%=getCheck(ld.getIstype("birth"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="birth_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("birth"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="birth_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("birth"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="birth_3" type="text" class="edit_input" value="<%=ld.getSequence("birth")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="birth_4"   <%=getCheck(ld.getAnchor("birth"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Brand")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="brand" value="checkbox"  <%=getCheck(ld.getIstype("brand"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="brand_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("brand"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="brand_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("brand"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="brand_3" type="text" class="edit_input" value="<%=ld.getSequence("brand")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="brand_4"   <%=getCheck(ld.getAnchor("brand"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Principal")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="principal" value="checkbox"  <%=getCheck(ld.getIstype("principal"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="principal_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("principal"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="principal_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("principal"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="principal_3" type="text" class="edit_input" value="<%=ld.getSequence("principal")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="principal_4"   <%=getCheck(ld.getAnchor("principal"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Turnover")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="turnover" value="checkbox"  <%=getCheck(ld.getIstype("turnover"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="turnover_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("turnover"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="turnover_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("turnover"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="turnover_3" type="text" class="edit_input" value="<%=ld.getSequence("turnover")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="turnover_4"   <%=getCheck(ld.getAnchor("turnover"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Agora")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="agora" value="checkbox"  <%=getCheck(ld.getIstype("agora"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="agora_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("agora"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="agora_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("agora"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="agora_3" type="text" class="edit_input" value="<%=ld.getSequence("agora")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="agora_4"   <%=getCheck(ld.getAnchor("agora"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Client")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="client" value="checkbox"  <%=getCheck(ld.getIstype("client"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="client_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("client"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="client_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("client"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="client_3" type="text" class="edit_input" value="<%=ld.getSequence("client")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="client_4"   <%=getCheck(ld.getAnchor("client"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Export")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="export" value="checkbox"  <%=getCheck(ld.getIstype("export"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="export_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("export"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="export_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("export"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="export_3" type="text" class="edit_input" value="<%=ld.getSequence("export")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="export_4"   <%=getCheck(ld.getAnchor("export"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Imports")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="imports" value="checkbox"  <%=getCheck(ld.getIstype("imports"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="imports_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("imports"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="imports_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("imports"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="imports_3" type="text" class="edit_input" value="<%=ld.getSequence("imports")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="imports_4"   <%=getCheck(ld.getAnchor("imports"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Attestation")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="attestation" value="checkbox"  <%=getCheck(ld.getIstype("attestation"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="attestation_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("attestation"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="attestation_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("attestation"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="attestation_3" type="text" class="edit_input" value="<%=ld.getSequence("attestation")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="attestation_4"   <%=getCheck(ld.getAnchor("attestation"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Bank")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="bank" value="checkbox"  <%=getCheck(ld.getIstype("bank"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="bank_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bank"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="bank_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bank"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="bank_3" type="text" class="edit_input" value="<%=ld.getSequence("bank")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="bank_4"   <%=getCheck(ld.getAnchor("bank"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Accounts")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="accounts" value="checkbox"  <%=getCheck(ld.getIstype("accounts"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="accounts_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("accounts"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="accounts_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("accounts"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="accounts_3" type="text" class="edit_input" value="<%=ld.getSequence("accounts")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="accounts_4"   <%=getCheck(ld.getAnchor("accounts"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Oem")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="oem" value="checkbox"  <%=getCheck(ld.getIstype("oem"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="oem_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("oem"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="oem_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("oem"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="oem_3" type="text" class="edit_input" value="<%=ld.getSequence("oem")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="oem_4"   <%=getCheck(ld.getAnchor("oem"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Developer")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="developer" value="checkbox"  <%=getCheck(ld.getIstype("developer"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="developer_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("developer"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="developer_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("developer"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="developer_3" type="text" class="edit_input" value="<%=ld.getSequence("developer")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="developer_4"   <%=getCheck(ld.getAnchor("developer"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Turnout")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="turnout" value="checkbox"  <%=getCheck(ld.getIstype("turnout"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="turnout_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("turnout"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="turnout_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("turnout"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="turnout_3" type="text" class="edit_input" value="<%=ld.getSequence("turnout")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="turnout_4"   <%=getCheck(ld.getAnchor("turnout"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Acreage")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="acreage" value="checkbox"  <%=getCheck(ld.getIstype("acreage"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="acreage_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("acreage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="acreage_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("acreage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="acreage_3" type="text" class="edit_input" value="<%=ld.getSequence("acreage")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="acreage_4"   <%=getCheck(ld.getAnchor("acreage"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Mass")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="mass" value="checkbox"  <%=getCheck(ld.getIstype("mass"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="mass_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mass"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="mass_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mass"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mass_3" type="text" class="edit_input" value="<%=ld.getSequence("mass")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="mass_4"   <%=getCheck(ld.getAnchor("mass"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Branch")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="branch" value="checkbox"  <%=getCheck(ld.getIstype("branch"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="branch_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("branch"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="branch_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("branch"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="branch_3" type="text" class="edit_input" value="<%=ld.getSequence("branch")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="branch_4"   <%=getCheck(ld.getAnchor("branch"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Job")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="job" value="checkbox"  <%=getCheck(ld.getIstype("job"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="job_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("job"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="job_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("job"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="job_3" type="text" class="edit_input" value="<%=ld.getSequence("job")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="job_4"   <%=getCheck(ld.getAnchor("job"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD ID=RowHeader>Logo:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="logo" value="checkbox"  <%=getCheck(ld.getIstype("logo"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="logo_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("logo"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="logo_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("logo"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="logo_3" type="text" class="edit_input" value="<%=ld.getSequence("logo")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="logo_4"   <%=getCheck(ld.getAnchor("logo"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                 <TR>
              <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Picture")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="picture" value="checkbox"  <%=getCheck(ld.getIstype("picture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="picture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("picture"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="picture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("picture"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="picture_3" type="text" class="edit_input" value="<%=ld.getSequence("picture")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="picture_4"   <%=getCheck(ld.getAnchor("picture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
                  <TD ID=RowHeader><%=r.getString(teasession._nLanguage, "Goods")%>:</TD>
                  <TD><input  id="CHECKBOX" type="CHECKBOX" name="goods" value="checkbox"  <%=getCheck(ld.getIstype("goods"))%>><%=r.getString(teasession._nLanguage, "Show")%>
                    <%=r.getString(teasession._nLanguage, "Before")%><input name="goods_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("goods"))%>" type="text" class="edit_input">
                      <%=r.getString(teasession._nLanguage, "After")%><input name="goods_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("goods"))%>" type="text" class="edit_input">
                        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="goods_3" type="text" class="edit_input" value="<%=ld.getSequence("goods")%>" maxlength="3" size="4">
                  </TD>            </TR>
  <!--tr>
    <td colspan="2"><hr></td>
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
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

