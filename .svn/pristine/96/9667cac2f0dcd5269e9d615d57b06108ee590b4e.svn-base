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
<h1><%=r.getString(teasession._nLanguage, "Classesfied")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
            <input type='hidden' name="node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="21"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

         <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <TR>
              <TD><%=r.getString(teasession._nLanguage, "Name")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="Name" value="checkbox"  <%=getCheck(ld.getIstype("Name"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Name"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Name"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Name_3" type="text" class="edit_input" value="<%=ld.getSequence("Name")%>" maxlength="3" size="4">
<input type=checkbox name="Name_4"   <%=getCheck(ld.getAnchor("Name"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>

              <TR>
              <TD><%=r.getString(teasession._nLanguage, "Intro")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="Intro" value="checkbox"  <%=getCheck(ld.getIstype("Intro"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Intro_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Intro"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Intro_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Intro"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Intro_3" type="text" class="edit_input" value="<%=ld.getSequence("Intro")%>" maxlength="3" size="4">
<input type=checkbox name="Intro_4"   <%=getCheck(ld.getAnchor("Intro"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>
                      <TR>
              <TD><%=r.getString(teasession._nLanguage, "CorpJob")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="CorpJob" value="checkbox"  <%=getCheck(ld.getIstype("CorpJob"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="CorpJob_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("CorpJob"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="CorpJob_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("CorpJob"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="CorpJob_3" type="text" class="edit_input" value="<%=ld.getSequence("CorpJob")%>" maxlength="3" size="4">
<%--<input type=checkbox name="CorpJob_4"   <%=getCheck(ld.getAnchor("CorpJob"))%>><%=r.getString(teasession._nLanguage, "Anchor")--%>
                </TD>
            </TR>
                      <TR>
              <TD><%=r.getString(teasession._nLanguage, "CorpJobButton")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="CorpJobButton" value="checkbox"  <%=getCheck(ld.getIstype("CorpJobButton"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="CorpJobButton_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("CorpJobButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="CorpJobButton_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("CorpJobButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="CorpJobButton_3" type="text" class="edit_input" value="<%=ld.getSequence("CorpJobButton")%>" maxlength="3" size="4">
<%--<input type=checkbox name="CorpJobButton_4"   <%=getCheck(ld.getAnchor("CorpJobButton"))%>><%=r.getString(teasession._nLanguage, "Anchor")--%>
                </TD>
            </TR>                      <TR>
              <TD><%=r.getString(teasession._nLanguage, "EditButton")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="EditButton" value="checkbox"  <%=getCheck(ld.getIstype("EditButton"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="EditButton_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("EditButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="EditButton_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("EditButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="EditButton_3" type="text" class="edit_input" value="<%=ld.getSequence("EditButton")%>" maxlength="3" size="4">
<%--<input type=checkbox name="EditButton_4"   <%=getCheck(ld.getAnchor("EditButton"))%>><%=r.getString(teasession._nLanguage, "Anchor")--%>
              </TD>
            </TR>                      <TR>
              <TD><%=r.getString(teasession._nLanguage, "DeleteButton")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="DeleteButton" value="checkbox"  <%=getCheck(ld.getIstype("DeleteButton"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="DeleteButton_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("DeleteButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="DeleteButton_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("DeleteButton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="DeleteButton_3" type="text" class="edit_input" value="<%=ld.getSequence("DeleteButton")%>" maxlength="3" size="4">
<%--<input type=checkbox name="DeleteButton_4"   <%=getCheck(ld.getAnchor("DeleteButton"))%>><%=r.getString(teasession._nLanguage, "Anchor")--%>
              </TD>
            </TR>
            <TR>
              <TD><%=r.getString(teasession._nLanguage, "Contact")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Contact" value="checkbox"  <%=getCheck(ld.getIstype("Contact"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
			  	<%=r.getString(teasession._nLanguage, "Before")%><input  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Contact" value="checkbox"  <%=getCheck(ld.getIstype("d="))%> id="radio"><%=r.getString(teasession."))%>" type="text" class="edit_input"  name="Contact_1">
                <%=r.getString(teasession._nLanguage, "After")%><input  mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Contact"))%>" type="text" class="edit_input" name="Contact_2">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Contact_3" type="text" class="edit_input" value="<%=ld.getSequence("Contact")%>" maxlength="3" size="4">
	<input type=checkbox name="Contact_4"   <%=getCheck(ld.getAnchor("Contact"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
           </TD> </TR>
            <TR>
              <TD><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="EmailAddress" value="checkbox"  <%=getCheck(ld.getIstype("EmailAddress"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="EmailAddress_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("EmailAddress"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="EmailAddress_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("EmailAddress"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="EmailAddress_3" type="text" class="edit_input" value="<%=ld.getSequence("EmailAddress")%>" maxlength="3" size="4">
<input type=checkbox name="EmailAddress_4"   <%=getCheck(ld.getAnchor("EmailAddress"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>
            </TR>
            <TR>
              <TD><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Organization" value="checkbox"  <%=getCheck(ld.getIstype("Organization"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Organization_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Organization"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Organization_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Organization"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Organization_3" type="text" class="edit_input" value="<%=ld.getSequence("Organization")%>" maxlength="3" size="4">
<input type=checkbox name="Organization_4"   <%=getCheck(ld.getAnchor("Organization"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>            </TR>
            <TR>
              <TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Address" value="checkbox"  <%=getCheck(ld.getIstype("Address"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Address_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Address_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Address_3" type="text" class="edit_input" value="<%=ld.getSequence("Address")%>" maxlength="3" size="4">
<input type=checkbox name="Address_4"   <%=getCheck(ld.getAnchor("Address"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>            </TR>
            <TR>
              <TD><%=r.getString(teasession._nLanguage, "City")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="City" value="checkbox"  <%=getCheck(ld.getIstype("City"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="City_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("City"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="City_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("City"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="City_3" type="text" class="edit_input" value="<%=ld.getSequence("City")%>" maxlength="3" size="4">
<input type=checkbox name="City_4"   <%=getCheck(ld.getAnchor("City"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>            </TR>
            <TR>
              <TD><%=r.getString(teasession._nLanguage, "State")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="State" value="checkbox"  <%=getCheck(ld.getIstype("State"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="State_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("State"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="State_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("State"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="State_3" type="text" class="edit_input" value="<%=ld.getSequence("State")%>" maxlength="3" size="4">
<input type=checkbox name="State_4"   <%=getCheck(ld.getAnchor("State"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>            </TR>
            <TR>
              <TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Zip" value="checkbox"  <%=getCheck(ld.getIstype("Zip"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Zip_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Zip"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Zip_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Zip"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Zip_3" type="text" class="edit_input" value="<%=ld.getSequence("Zip")%>" maxlength="3" size="4">
<input type=checkbox name="Zip_4"   <%=getCheck(ld.getAnchor("Zip"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>            </TR>

            <TR>
              <TD><%=r.getString(teasession._nLanguage, "Country")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Country" value="checkbox"  <%=getCheck(ld.getIstype("Country"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Country_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Country"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Country_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Country"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Country_3" type="text" class="edit_input" value="<%=ld.getSequence("Country")%>" maxlength="3" size="4">
<input type=checkbox name="Country_4"   <%=getCheck(ld.getAnchor("Country"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>            </TR>
            <TR>
              <TD><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Telephone" value="checkbox"  <%=getCheck(ld.getIstype("Telephone"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Telephone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Telephone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Telephone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Telephone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Telephone_3" type="text" class="edit_input" value="<%=ld.getSequence("Telephone")%>" maxlength="3" size="4">
<input type=checkbox name="Telephone_4"   <%=getCheck(ld.getAnchor("Telephone"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>            </TR>
            <TR>
              <TD><%=r.getString(teasession._nLanguage, "Fax")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Fax" value="checkbox"  <%=getCheck(ld.getIstype("Fax"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Fax_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Fax"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Fax_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Fax"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Fax_3" type="text" class="edit_input" value="<%=ld.getSequence("Fax")%>" maxlength="3" size="4">
<input type=checkbox name="Fax_4"   <%=getCheck(ld.getAnchor("Fax"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>            </TR>
            <TR>
              <TD><%=r.getString(teasession._nLanguage, "WebPage")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="WebPage" value="checkbox"  <%=getCheck(ld.getIstype("WebPage"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="WebPage_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("WebPage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="WebPage_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("WebPage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="WebPage_3" type="text" class="edit_input" value="<%=ld.getSequence("WebPage")%>" maxlength="3" size="4">
<input type=checkbox name="WebPage_4"   <%=getCheck(ld.getAnchor("WebPage"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>            </TR>
            <TR>
              <TD><%=r.getString(teasession._nLanguage, "WebLanguage")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="WebLanguage" value="checkbox"  <%=getCheck(ld.getIstype("WebLanguage"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="WebLanguage_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("WebLanguage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="WebLanguage_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("WebLanguage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="WebLanguage_3" type="text" class="edit_input" value="<%=ld.getSequence("WebLanguage")%>" maxlength="3" size="4">
<input type=checkbox name="WebLanguage_4"   <%=getCheck(ld.getAnchor("WebLanguage"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>            </TR>
          </TABLE>

<input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
        </FORM>
  <SCRIPT>document.form1.Name_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

