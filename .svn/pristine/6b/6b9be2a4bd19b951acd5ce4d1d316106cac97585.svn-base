<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/resource/Golf");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
    response.sendError(403);
    return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,62,teasession._nLanguage);


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CourtDetail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
    <input type="hidden" name="ListingType" value="62"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
    <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
      <td width="13%"><%=r.getString(teasession._nLanguage, "Code")%>:</td>
      <td width="89%"><input  id="CHECKBOX" type="CHECKBOX" name="NightShopCode" <%=getCheck(ld.getIstype("NightShopCode"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="NightShopCode_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("NightShopCode"))%>">
        <%=r.getString(teasession._nLanguage, "After")%><input type="text" name="NightShopCode_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("NightShopCode"))%>" mask="max" >
		<%=r.getString(teasession._nLanguage, "Sequence")%><input name="NightShopCode_3" type="text" value="<%=ld.getSequence("NightShopCode")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="NightShopCode_4" <%=getCheck(ld.getAnchor("NightShopCode")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Name" <%=getCheck(ld.getIstype("Name"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Name_1"	   mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Name"))%>">
              <%=r.getString(teasession._nLanguage, "After")%><input type="text" name="Name_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Name"))%>"         mask="max" >
		<%=r.getString(teasession._nLanguage, "Sequence")%><input name="Name_3" type="text" value="<%=ld.getSequence("Name")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Name_4" <%=getCheck(ld.getAnchor("Name")==1)%> ><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="Name_5" class="edit_input" type="text" value="<%=ld.getQuantity("Name")%>" mask="int" maxlength="3" size="4"/>
      </td>
    </tr>
    <tr>
      <td>Logo:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Logo" value="checkbox" <%=getCheck(ld.getIstype("Logo"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Logo_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Logo"))%>"		 mask="max" >
<%=r.getString(teasession._nLanguage, "After")%><input type="text" name="Logo_2"          mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Logo"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Logo_3" type="text" value="<%=ld.getSequence("Logo")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Logo_4"  <%=getCheck(ld.getAnchor("Logo")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Type")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Type" value="checkbox" <%=getCheck(ld.getIstype("Type"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input type="text"   mask="max"  name="Type_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Type"))%>">
 <%=r.getString(teasession._nLanguage, "After")%><input type="text" name="Type_2"	   mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Type"))%>">
	  <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Type_3" type="text" value="<%=ld.getSequence("Type")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Type_4"  <%=getCheck(ld.getAnchor("Type")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Area")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Area" value="checkbox" <%=getCheck(ld.getIstype("Area"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input type="text"	   mask="max"  name="Area_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Area"))%>">
<%=r.getString(teasession._nLanguage, "After")%><input type="text"	   mask="max"  name="Area_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Area"))%>">
	  <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Area_3" type="text" value="<%=ld.getSequence("Area")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Area_4"  <%=getCheck(ld.getAnchor("Area")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "MusicType")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="MusicType" value="checkbox" <%=getCheck(ld.getIstype("MusicType"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input type="text"		 mask="max"  name="MusicType_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("MusicType"))%>">
<%=r.getString(teasession._nLanguage, "After")%><input type="text"         mask="max"  name="MusicType_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("MusicType"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="MusicType_3" type="text" value="<%=ld.getSequence("MusicType")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="MusicType_4"  <%=getCheck(ld.getAnchor("MusicType")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "DeilStyle")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="DeilStyle" value="checkbox" <%=getCheck(ld.getIstype("DeilStyle"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="DeilStyle_1"	   mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("DeilStyle"))%>">
<%=r.getString(teasession._nLanguage, "After")%><input type="text" name="DeilStyle_2"         mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("DeilStyle"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="DeilStyle_3" type="text" value="<%=ld.getSequence("DeilStyle")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="DeilStyle_4"  <%=getCheck(ld.getAnchor("DeilStyle")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Circumstance")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Circumstance" value="checkbox" <%=getCheck(ld.getIstype("Circumstance"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input type="text" 	 mask="max" name="Circumstance_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Circumstance"))%>">
		<%=r.getString(teasession._nLanguage, "After")%><input type="text" name="Circumstance_2"  mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Circumstance"))%>">
		<%=r.getString(teasession._nLanguage, "Sequence")%><input name="Circumstance_3" type="text" value="<%=ld.getSequence("Circumstance")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Circumstance_4"  <%=getCheck(ld.getAnchor("Circumstance")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "BusinessHours")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="BusinessHours" value="checkbox" <%=getCheck(ld.getIstype("BusinessHours"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	 <%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="BusinessHours_1"   mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("BusinessHours"))%>">
        <%=r.getString(teasession._nLanguage, "After")%><input type="text" name="BusinessHours_2" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("BusinessHours"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="BusinessHours_3" type="text" value="<%=ld.getSequence("BusinessHours")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="BusinessHours_4" <%=getCheck(ld.getAnchor("BusinessHours")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Depot")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Depot" value="checkbox" <%=getCheck(ld.getIstype("Depot"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Depot_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Depot"))%>">
        <%=r.getString(teasession._nLanguage, "After")%><input type="text"  mask="max" name="Depot_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Depot"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Depot_3" type="text" value="<%=ld.getSequence("Depot")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Depot_4"  <%=getCheck(ld.getAnchor("Depot")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Ticket")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Ticket" value="checkbox" <%=getCheck(ld.getIstype("Ticket"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Ticket_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Ticket"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input type="text" name="Ticket_2"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("Ticket"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Ticket_3" type="text" value="<%=ld.getSequence("Ticket")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Ticket_4"  <%=getCheck(ld.getAnchor("Ticket")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "DayOpenBusiness")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="DayOpenBusiness" value="checkbox" <%=getCheck(ld.getIstype("DayOpenBusiness"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text"  mask="max" name="DayOpenBusiness_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("DayOpenBusiness"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input type="text"   mask="max" name="DayOpenBusiness_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("DayOpenBusiness"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="DayOpenBusiness_3" type="text" value="<%=ld.getSequence("DayOpenBusiness")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="DayOpenBusiness_4"  <%=getCheck(ld.getAnchor("DayOpenBusiness")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "ElectroTicket")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="ElectroTicket" value="checkbox" <%=getCheck(ld.getIstype("ElectroTicket"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text"  mask="max" name="ElectroTicket_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ElectroTicket"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input type="text"   mask="max" name="ElectroTicket_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ElectroTicket"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="ElectroTicket_3" type="text" value="<%=ld.getSequence("ElectroTicket")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="ElectroTicket_4" <%=getCheck(ld.getAnchor("ElectroTicket")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>



    <tr>
      <td><%=r.getString(teasession._nLanguage, "Synopsis")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Synopsis" value="checkbox" <%=getCheck(ld.getIstype("Synopsis"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Synopsis_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Synopsis"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input type="text"   mask="max" name="Synopsis_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Synopsis"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Synopsis_3" type="text" value="<%=ld.getSequence("Synopsis")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Synopsis_4"  <%=getCheck(ld.getAnchor("Synopsis")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Capability")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Capability" value="checkbox" <%=getCheck(ld.getIstype("Capability"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text"  mask="max" name="Capability_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Capability"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input type="text"   mask="max" name="Capability_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Capability"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Capability_3" type="text" value="<%=ld.getSequence("Capability")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Capability_4" <%=getCheck(ld.getAnchor("Capability")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Payment")%>:</td>
      <td> <input  id="CHECKBOX" type="CHECKBOX" name="Payment" value="checkbox" <%=getCheck(ld.getIstype("Payment"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Payment_1" mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Payment"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input type="text"  mask="max"  name="Payment_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Payment"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Payment_3" type="text" value="<%=ld.getSequence("Payment")%>" maxlength="3" size="4" mask="int">
		<input  id=CHECKBOX type="CHECKBOX" name="Payment_4" <%=getCheck(ld.getAnchor("Payment")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Intro")%>: </td>
      <td> <input  id="CHECKBOX" type="CHECKBOX" name="Intro" value="checkbox" <%=getCheck(ld.getIstype("Intro"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text"  mask="max" name="Intro_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Intro"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input type="text"   mask="max"  name="Intro_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Intro"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Intro_3" type="text" value="<%=ld.getSequence("Intro")%>" maxlength="3" size="4" mask="int">
		<input  id=CHECKBOX type="CHECKBOX" name="Intro_4"  <%=getCheck(ld.getAnchor("Intro")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>


    <tr>
      <td><%=r.getString(teasession._nLanguage, "Trait")%>: </td>
      <td> <input  id="CHECKBOX" type="CHECKBOX" name="Trait" value="checkbox" <%=getCheck(ld.getIstype("Trait"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text" mask="max"  name="Trait_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Trait"))%>">
        <%=r.getString(teasession._nLanguage, "After")%><input type="text"  mask="max" name="Trait_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Trait"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Trait_3" type="text" value="<%=ld.getSequence("Trait")%>" maxlength="3" size="4" mask="int">
	   <input  id=CHECKBOX type="CHECKBOX" name="Trait_4" <%=getCheck(ld.getAnchor("Trait")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Grade")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Grade" value="checkbox" <%=getCheck(ld.getIstype("Grade"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text" mask="max"  name="Grade_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Grade"))%>">
        <%=r.getString(teasession._nLanguage, "After")%><input type="text"  mask="max" name="Grade_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Grade"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Grade_3" type="text" value="<%=ld.getSequence("Grade")%>" maxlength="3" size="4" mask="int">
		<input  id=CHECKBOX type="CHECKBOX" name="Grade_4"  <%=getCheck(ld.getAnchor("Grade")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Depreciate")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Depreciate" value="checkbox" <%=getCheck(ld.getIstype("Depreciate"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input  mask="max" type="text" name="Depreciate_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Depreciate"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="Depreciate_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Depreciate"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Depreciate_3" type="text" value="<%=ld.getSequence("Depreciate")%>" maxlength="3" size="4" mask="int">
		<input  id=CHECKBOX type="CHECKBOX" name="Depreciate_4"  <%=getCheck(ld.getAnchor("Depreciate")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "PracticeHours")%>: </td>
      <td> <input  id="CHECKBOX" type="CHECKBOX" name="PracticeHours" value="checkbox" <%=getCheck(ld.getIstype("PracticeHours"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="PracticeHours_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("PracticeHours"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input type="text"   mask="max" name="PracticeHours_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("PracticeHours"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="PracticeHours_3" type="text" value="<%=ld.getSequence("PracticeHours")%>" maxlength="3" size="4" mask="int">
		<input  id=CHECKBOX type="CHECKBOX" name="PracticeHours_4"  <%=getCheck(ld.getAnchor("PracticeHours")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
      <td> <input  id="CHECKBOX" type="CHECKBOX" name="Address" value="checkbox" <%=getCheck(ld.getIstype("Address"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Address_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Address"))%>">
     <%=r.getString(teasession._nLanguage, "After")%><input type="text"    mask="max"  name="Address_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Address"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Address_3" type="text" value="<%=ld.getSequence("Address")%>" maxlength="3" size="4" mask="int">
		<input  id=CHECKBOX type="CHECKBOX" name="Address_4"  <%=getCheck(ld.getAnchor("Address")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr><%--
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Picture")%>: </td>
      <td> <input  id="CHECKBOX" type="CHECKBOX" name="Picture" value="checkbox" <%=getCheck(ld.getIstype("Picture"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		 mask="max" <%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Picture_1" value="<%=(ld.getBeforeItem("Picture"))%>">
         mask="max" <%=r.getString(teasession._nLanguage, "After")%><input type="text" name="Picture_2" value="<%=(ld.getAfterItem("Picture"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Picture_3" type="text" value="<%=ld.getSequence("Picture")%>" maxlength="3" size="4" mask="int">
          <input  id=CHECKBOX type="CHECKBOX" name="Picture_4" <%=getCheck(ld.getAnchor("Picture")==1)%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>--%>


  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>1: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="Picture" value="checkbox"  <%=getCheck(ld.getIstype("Picture"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="Picture_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Picture"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input  mask="max" name="Picture_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Picture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Picture_3" type="text" value="<%=ld.getSequence("Picture")%>" maxlength="3" size="4" mask="int">
	<%-- %><input  id=CHECKBOX type="CHECKBOX" name="Picture_4"   <%=getCheck(ld.getAnchor("Picture")==1)%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <input  id=CHECKBOX type="CHECKBOX" name="Picture_5"   <%=getCheck(ld.getAnchor("Picture")==1)%>><%=r.getString(teasession._nLanguage, "Anchor")%>--%>
        <select name="Picture_4">
  <option value="0" Selected>无</option>
  <option value="1" <%=getSelect(ld.getAnchor("Picture")==1)%>>节点</option>
  <option value="2" <%=getSelect(ld.getAnchor("Picture")==2)%>>大图</option>
</select><%=r.getString(teasession._nLanguage, "Anchor")%>

    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "PictureName")%>1: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="PictureName" value="checkbox"  <%=getCheck(ld.getIstype("PictureName"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="PictureName_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("PictureName"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="PictureName_2"  mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("PictureName"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%><input name="PictureName_3" type="text" value="<%=ld.getSequence("PictureName")%>" maxlength="3" size="4" mask="int">
	<select name="PictureName_4">
  <option value="0" Selected>无</option>
  <option value="1" <%=getSelect(ld.getAnchor("PictureName")==1)%>>节点</option>
  <option value="2" <%=getSelect(ld.getAnchor("PictureName")==2)%>>大图</option>
</select><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>2: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="Picture2"    <%=getCheck(ld.getIstype("Picture2"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="Picture2_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Picture2"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="Picture2_2"  mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Picture2"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Picture2_3" type="text" value="<%=ld.getSequence("Picture2")%>" maxlength="3" size="4" mask="int">
	<select name="Picture2_4">
  <option value="0" Selected>无</option>
  <option value="1" <%=getSelect(ld.getAnchor("Picture2")==1)%>>节点</option>
  <option value="2" <%=getSelect(ld.getAnchor("Picture2")==2)%>>大图</option>
</select><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "PictureName")%>2: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="PictureName2"    <%=getCheck(ld.getIstype("PictureName2"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="PictureName2_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("PictureName2"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="PictureName2_2"  mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("PictureName2"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%><input name="PictureName2_3" type="text" value="<%=ld.getSequence("PictureName2")%>" maxlength="3" size="4" mask="int">
	<select name="PictureName2_4">
  <option value="0" Selected>无</option>
  <option value="1" <%=getSelect(ld.getAnchor("PictureName2")==1)%>>节点</option>
  <option value="2" <%=getSelect(ld.getAnchor("PictureName2")==2)%>>大图</option>
</select><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "OtherPicture")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="OtherPicture"    <%=getCheck(ld.getIstype("OtherPicture"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="OtherPicture_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("OtherPicture"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="OtherPicture_2"  mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("OtherPicture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%><input name="OtherPicture_3" type="text" value="<%=ld.getSequence("OtherPicture")%>" maxlength="3" size="4" mask="int">
	<select name="OtherPicture_4">
  <option value="0" Selected>无</option>
  <option value="1" <%=getSelect(ld.getAnchor("OtherPicture")==1)%>>节点</option>
  <option value="2" <%=getSelect(ld.getAnchor("OtherPicture")==2)%>>大图</option>
</select><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "OtherPictureName")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="OtherPictureName"    <%=getCheck(ld.getIstype("OtherPictureName"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input  mask="max" name="OtherPictureName_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("OtherPictureName"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="OtherPictureName_2"  mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("OtherPictureName"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%><input name="OtherPictureName_3" type="text" value="<%=ld.getSequence("OtherPictureName")%>" maxlength="3" size="4" mask="int">
	<select name="OtherPictureName_4">
  <option value="0" Selected>无</option>
  <option value="1" <%=getSelect(ld.getAnchor("OtherPictureName")==1)%>>节点</option>
  <option value="2" <%=getSelect(ld.getAnchor("OtherPictureName")==2)%>>大图</option>
</select><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage, "Principal")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Principal" value="checkbox" <%=getCheck(ld.getIstype("Principal"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Principal_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Principal"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input type="text"    mask="max" name="Principal_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Principal"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Principal_3" type="text" value="<%=ld.getSequence("Principal")%>" maxlength="3" size="4" mask="int">
          <input  id=CHECKBOX type="CHECKBOX" name="Principal_4" <%=getCheck(ld.getAnchor("Principal")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Phone")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Phone" value="checkbox" <%=getCheck(ld.getIstype("Phone"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input  mask="max" type="text" name="Phone_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Phone"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input    mask="max" type="text" name="Phone_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Phone"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Phone_3" type="text" value="<%=ld.getSequence("Phone")%>" maxlength="3" size="4" mask="int">
          <input  id=CHECKBOX type="CHECKBOX" name="Phone_4"  <%=getCheck(ld.getAnchor("Phone")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>


    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fax")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Fax" value="checkbox" <%=getCheck(ld.getIstype("Fax"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text" mask="max"  name="Fax_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Fax"))%>">
  <%=r.getString(teasession._nLanguage, "After")%><input type="text"        mask="max" name="Fax_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Fax"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Fax_3" type="text" value="<%=ld.getSequence("Fax")%>" maxlength="3" size="4" mask="int">
          <input  id=CHECKBOX type="CHECKBOX" name="Fax_4"  <%=getCheck(ld.getAnchor("Fax")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Postalcode")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Postalcode" value="checkbox" <%=getCheck(ld.getIstype("Postalcode"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input type="text" 	 mask="max" name="Postalcode_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Postalcode"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input    mask="max" type="text" name="Postalcode_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Postalcode"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Postalcode_3" type="text" value="<%=ld.getSequence("Postalcode")%>" maxlength="3" size="4" mask="int">
		<input  id=CHECKBOX type="CHECKBOX" name="Postalcode_4" <%=getCheck(ld.getAnchor("Postalcode")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Cooperate")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Cooperate" value="checkbox" <%=getCheck(ld.getIstype("Cooperate"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
		<%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Cooperate_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Cooperate"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input type="text"    mask="max" name="Cooperate_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Cooperate"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Cooperate_3" type="text" value="<%=ld.getSequence("Cooperate")%>" maxlength="3" size="4" mask="int">
		<input  id=CHECKBOX type="CHECKBOX" name="Cooperate_4"  <%=getCheck(ld.getAnchor("Cooperate")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Sponsor")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Sponsor" value="checkbox" <%=getCheck(ld.getIstype("Sponsor"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Sponsor_1"	 mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Sponsor"))%>">
     <%=r.getString(teasession._nLanguage, "After")%><input type="text"     mask="max" name="Sponsor_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Sponsor"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Sponsor_3" type="text" value="<%=ld.getSequence("Sponsor")%>" maxlength="3" size="4" mask="int">
		<input  id=CHECKBOX type="CHECKBOX" name="Sponsor_4"  <%=getCheck(ld.getAnchor("Sponsor")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>


    <tr>
      <td><%=r.getString(teasession._nLanguage, "Acreage")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Acreage" value="checkbox" <%=getCheck(ld.getIstype("Acreage"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Acreage_1"    mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Acreage"))%>">
    <%=r.getString(teasession._nLanguage, "After")%><input type="text" name="Acreage_2"      mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Acreage"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Acreage_3" type="text" value="<%=ld.getSequence("Acreage")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Acreage_4"  <%=getCheck(ld.getAnchor("Acreage")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "AverageConsume")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="AverageConsume" value="checkbox" <%=getCheck(ld.getIstype("AverageConsume"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
   <%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="AverageConsume_1"      mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("AverageConsume"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input type="text"    mask="max" name="AverageConsume_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("AverageConsume"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="AverageConsume_3" type="text" value="<%=ld.getSequence("AverageConsume")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="AverageConsume_4"  <%=getCheck(ld.getAnchor("AverageConsume")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Consume")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Consume" value="checkbox" <%=getCheck(ld.getIstype("Consume"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input type="text" name="Consume_1"    mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Consume"))%>">
     <%=r.getString(teasession._nLanguage, "After")%><input type="text"    mask="max"  name="Consume_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Consume"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Consume_3" type="text" value="<%=ld.getSequence("Consume")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Consume_4"  <%=getCheck(ld.getAnchor("Consume")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "Price")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Price" value="checkbox" <%=getCheck(ld.getIstype("Price"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input type="text" mask="max"  name="Price_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Price"))%>">
     <%=r.getString(teasession._nLanguage, "After")%><input type="text"     mask="max" name="Price_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Price"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Price_3" type="text" value="<%=ld.getSequence("Price")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Price_4"  <%=getCheck(ld.getAnchor("Price")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "Among")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Among" value="checkbox" <%=getCheck(ld.getIstype("Among"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
       <%=r.getString(teasession._nLanguage, "Before")%><input   mask="max" type="text" name="Among_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Among"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="Among_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Among"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Among_3" type="text" value="<%=ld.getSequence("Among")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Among_4"  <%=getCheck(ld.getAnchor("Among")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "Operation")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Operation" value="checkbox" <%=getCheck(ld.getIstype("Operation"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input  mask="max" type="text" name="Operation_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Operation"))%>">
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max" type="text" name="Operation_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Operation"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Operation_3" type="text" value="<%=ld.getSequence("Operation")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Operation_4"  <%=getCheck(ld.getAnchor("Operation")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "Loo")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Loo" value="checkbox" <%=getCheck(ld.getIstype("Loo"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max"type="text" name="Loo_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Loo"))%>">
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max" type="text" name="Loo_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Loo"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Loo_3" type="text" value="<%=ld.getSequence("Loo")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Loo_4"  <%=getCheck(ld.getAnchor("Loo")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>        <tr>
      <td><%=r.getString(teasession._nLanguage, "Destine")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Destine" value="checkbox" <%=getCheck(ld.getIstype("Destine"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="Destine_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Destine"))%>">
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max" type="text" name="Destine_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Destine"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Destine_3" type="text" value="<%=ld.getSequence("Destine")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Destine_4"  <%=getCheck(ld.getAnchor("Destine")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr> <tr>
      <td><%=r.getString(teasession._nLanguage, "Block")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Block" value="checkbox" <%=getCheck(ld.getIstype("Block"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max"type="text" name="Block_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Block"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="Block_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Block"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Block_3" type="text" value="<%=ld.getSequence("Block")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Block_4"  <%=getCheck(ld.getAnchor("Block")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr><tr>
      <td><%=r.getString(teasession._nLanguage, "CoverCharge")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="CoverCharge" value="checkbox" <%=getCheck(ld.getIstype("CoverCharge"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "After")%><input    mask="max"type="text" name="CoverCharge_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("CoverCharge"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input    mask="max" type="text" name="CoverCharge_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("CoverCharge"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="CoverCharge_3" type="text" value="<%=ld.getSequence("CoverCharge")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="CoverCharge_4"  <%=getCheck(ld.getAnchor("CoverCharge")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr><tr>
      <td><%=r.getString(teasession._nLanguage, "Member")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Member" value="checkbox" <%=getCheck(ld.getIstype("Member"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max"type="text" name="Member_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Member"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input    mask="max" type="text" name="Member_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Member"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Member_3" type="text" value="<%=ld.getSequence("Member")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Member_4"  <%=getCheck(ld.getAnchor("Member")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr><tr>
      <td><%=r.getString(teasession._nLanguage, "Browse")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Browse" value="checkbox" <%=getCheck(ld.getIstype("Browse"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max"type="text" name="Browse_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Browse"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input    mask="max" type="text" name="Browse_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Browse"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Browse_3" type="text" value="<%=ld.getSequence("Browse")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Browse_4"  <%=getCheck(ld.getAnchor("Browse")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td>Email:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Email" value="checkbox" <%=getCheck(ld.getIstype("Email"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="Email_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Email"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="Email_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Email"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Email_3" type="text" value="<%=ld.getSequence("Email")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Email_4"  <%=getCheck(ld.getAnchor("Email")==1)%> ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "GradeTarget")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="GradeTarget" value="checkbox" <%=getCheck(ld.getIstype("GradeTarget"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="GradeTarget_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("GradeTarget"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="GradeTarget_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("GradeTarget"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="GradeTarget_3" type="text" value="<%=ld.getSequence("GradeTarget")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="GradeTarget_4"  <%=getCheck(ld.getAnchor("GradeTarget")==1)%> ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Result")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Result" value="checkbox" <%=getCheck(ld.getIstype("Result"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="Result_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Result"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="Result_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Result"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Result_3" type="text" value="<%=ld.getSequence("Result")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="Result_4"  <%=getCheck(ld.getAnchor("Result")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "ResultButton")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="ResultButton" value="checkbox" <%=getCheck(ld.getIstype("ResultButton"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="ResultButton_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ResultButton"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="ResultButton_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ResultButton"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="ResultButton_3" type="text" value="<%=ld.getSequence("ResultButton")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="ResultButton_4"  <%=getCheck(ld.getAnchor("ResultButton")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "GradeButton")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="GradeButton" value="checkbox" <%=getCheck(ld.getIstype("GradeButton"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="GradeButton_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("GradeButton"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="GradeButton_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("GradeButton"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="GradeButton_3" type="text" value="<%=ld.getSequence("GradeButton")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="GradeButton_4"  <%=getCheck(ld.getAnchor("GradeButton")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>

        <tr>
      <td><%=r.getString(teasession._nLanguage, "Map")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="map" value="checkbox" <%=getCheck(ld.getIstype("map"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="map_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("map"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="map_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("map"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="map_3" type="text" value="<%=ld.getSequence("map")%>" maxlength="3" size="4" mask="int">
        <select name="map_4">
        <option value="0">---------</option>
        <option value="1">按钮</option>
        </select><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>

 <tr>
      <td><%=r.getString(teasession._nLanguage, "Stylist")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="stylist" value="checkbox" <%=getCheck(ld.getIstype("stylist"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="stylist_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("stylist"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="stylist_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("stylist"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="stylist_3" type="text" value="<%=ld.getSequence("stylist")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="stylist_4"  <%=getCheck(ld.getAnchor("stylist")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
     <tr>
      <td><%=r.getString(teasession._nLanguage, "Cavity")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="cavity" value="checkbox" <%=getCheck(ld.getIstype("cavity"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="cavity_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("cavity"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="cavity_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("cavity"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="cavity_3" type="text" value="<%=ld.getSequence("cavity")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="cavity_4"  <%=getCheck(ld.getAnchor("cavity")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Haulm")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="haulm" value="checkbox" <%=getCheck(ld.getIstype("haulm"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="haulm_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("haulm"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="haulm_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("haulm"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="haulm_3" type="text" value="<%=ld.getSequence("haulm")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="haulm_4"  <%=getCheck(ld.getAnchor("haulm")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
   <tr>
      <td><%=r.getString(teasession._nLanguage, "PLength")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="plength" value="checkbox" <%=getCheck(ld.getIstype("plength"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="plength_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("plength"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="plength_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("plength"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="plength_3" type="text" value="<%=ld.getSequence("plength")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="plength_4"  <%=getCheck(ld.getAnchor("plength")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "PGrass")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="pgrass" value="checkbox" <%=getCheck(ld.getIstype("pgrass"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="pgrass_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pgrass"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="pgrass_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pgrass"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="pgrass_3" type="text" value="<%=ld.getSequence("pgrass")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="pgrass_4"  <%=getCheck(ld.getAnchor("pgrass")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr><tr>
      <td><%=r.getString(teasession._nLanguage, "CGrass")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="cgrass" value="checkbox" <%=getCheck(ld.getIstype("cgrass"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="cgrass_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("cgrass"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="cgrass_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("cgrass"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="cgrass_3" type="text" value="<%=ld.getSequence("cgrass")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="cgrass_4"  <%=getCheck(ld.getAnchor("cgrass")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Difficulty")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="difficulty" value="checkbox" <%=getCheck(ld.getIstype("difficulty"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="difficulty_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("difficulty"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="difficulty_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("difficulty"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="difficulty_3" type="text" value="<%=ld.getSequence("difficulty")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="difficulty_4"  <%=getCheck(ld.getAnchor("difficulty")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Gradient")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="gradient" value="checkbox" <%=getCheck(ld.getIstype("gradient"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="gradient_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("gradient"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="gradient_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("gradient"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="gradient_3" type="text" value="<%=ld.getSequence("gradient")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="gradient_4"  <%=getCheck(ld.getAnchor("gradient")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "Standard")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="standard" value="checkbox" <%=getCheck(ld.getIstype("standard"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="standard_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("standard"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="standard_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("standard"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="standard_3" type="text" value="<%=ld.getSequence("standard")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="standard_4"  <%=getCheck(ld.getAnchor("standard")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
            <tr>
      <td><%=r.getString(teasession._nLanguage, "Hole")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="hole" value="checkbox" <%=getCheck(ld.getIstype("hole"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="hole_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("hole"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="hole_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("hole"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="hole_3" type="text" value="<%=ld.getSequence("hole")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="hole_4"  <%=getCheck(ld.getAnchor("hole")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "PriceList")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="pricelist" value="checkbox" <%=getCheck(ld.getIstype("pricelist"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "After")%><input  mask="max"type="text" name="pricelist_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pricelist"))%>">
       <%=r.getString(teasession._nLanguage, "After")%><input   mask="max" type="text" name="pricelist_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pricelist"))%>">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="pricelist_3" type="text" value="<%=ld.getSequence("pricelist")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="pricelist_4"  <%=getCheck(ld.getAnchor("pricelist")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
  </table>
 <INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT class="edit_button"  VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
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
<div id="language"><%=new Languages(teasession._nLanguage,request)%>

  </div>
</body>
</html>

