<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Weather");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = tea.entity.node.Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail  ld=ListingDetail.find(iListing,14,teasession._nLanguage);


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Weather")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name=form1 method=post  action="/servlet/EditListingDetail">
  <input type='hidden' name="Node" value="<%=iNode%>">
  <input type="hidden" name="ListingType" value="14"/>
  <%if(!flag){%>
  <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
  <%        }else{%>
  <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
  <%   }%>
  <input type="hidden" name="Listing" value="<%=iListing%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
  for(int i=0;i<Weather.DAY_TYPE.length;i++)
  {
//    ListingDetail subject=ListingDetail.find(iListing,14,"Subject"+i,teasession._nLanguage);
//    ListingDetail date=ListingDetail.find(iListing,14,"Date"+i,teasession._nLanguage);
//    ListingDetail type=ListingDetail.find(iListing,14,"Type"+i,teasession._nLanguage);
//    ListingDetail legenda=ListingDetail.find(iListing,14,"Legenda"+i,teasession._nLanguage);
//    ListingDetail legend=ListingDetail.find(iListing,14,"Legend"+i,teasession._nLanguage);
//    ListingDetail low=ListingDetail.find(iListing,14,"Low"+i,teasession._nLanguage);
//    ListingDetail high=ListingDetail.find(iListing,14,"High"+i,teasession._nLanguage);
//    ListingDetail wind=ListingDetail.find(iListing,14,"Wind"+i,teasession._nLanguage);


  %>
  <tr><th ><%=r.getString(teasession._nLanguage, Weather.DAY_TYPE[i])%><td ><hr size="1" /></td></tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Subject<%=i%>" value="checkbox"  <%=getCheck(ld.getIstype("Subject"+i))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Subject<%=i%>_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Subject"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="Subject<%=i%>_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Subject"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Subject<%=i%>_3" type="text" class="edit_input" value="<%=ld.getSequence("Subject"+i)%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="Subject<%=i%>_4"   <%=getCheck(ld.getAnchor("Subject"+i))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%=r.getString(teasession._nLanguage, "Quantity")%><input name="Subject<%=i%>_5" class="edit_input" type="text" value="<%=ld.getQuantity("Subject"+i)%>" maxlength="3" size="4">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Time")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Date<%=i%>" value="checkbox"  <%=getCheck(ld.getIstype("Date"+i))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Date<%=i%>_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Date"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="Date<%=i%>_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Date"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Date<%=i%>_3" type="text" class="edit_input" value="<%=ld.getSequence("Date"+i)%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="Date<%=i%>_4"   <%=getCheck(ld.getAnchor("Date"+i))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Legend")%>(70x65):</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Legenda<%=i%>" value="checkbox"  <%=getCheck(ld.getIstype("Legenda"+i))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Legenda<%=i%>_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Legenda"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="Legenda<%=i%>_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Legenda"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Legenda<%=i%>_3" type="text" class="edit_input" value="<%=ld.getSequence("Legenda"+i)%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="Legenda<%=i%>_4"   <%=getCheck(ld.getAnchor("Legenda"+i))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Legend")%>(20x20):</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Legend<%=i%>" value="checkbox"  <%=getCheck(ld.getIstype("Legend"+i))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Legend<%=i%>_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Legend"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="Legend<%=i%>_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Legend"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Legend<%=i%>_3" type="text" class="edit_input" value="<%=ld.getSequence("Legend"+i)%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="Legend<%=i%>_4"   <%=getCheck(ld.getAnchor("Legend"+i))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Type")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Type<%=i%>" value="checkbox"  <%=getCheck(ld.getIstype("Type"+i))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Type<%=i%>_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Type"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="Type<%=i%>_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Type"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Type<%=i%>_3" type="text" class="edit_input" value="<%=ld.getSequence("Type"+i)%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="Type<%=i%>_4"   <%=getCheck(ld.getAnchor("Type"+i))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "LowTemp")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Low<%=i%>" value="checkbox"  <%=getCheck(ld.getIstype("Low"+i))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Low<%=i%>_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Low"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="Low<%=i%>_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Low"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Low<%=i%>_3" type="text" class="edit_input" value="<%=ld.getSequence("Low"+i)%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="Low<%=i%>_4"   <%=getCheck(ld.getAnchor("Low"+i))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "HighTemp")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="High<%=i%>" value="checkbox"  <%=getCheck(ld.getIstype("High"+i))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="High<%=i%>_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("High"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="High<%=i%>_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("High"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="High<%=i%>_3" type="text" class="edit_input" value="<%=ld.getSequence("High"+i)%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="High<%=i%>_4"   <%=getCheck(ld.getAnchor("High"+i))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Wind")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Wind<%=i%>" value="checkbox"  <%=getCheck(ld.getIstype("Wind"+i))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Wind<%=i%>_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Wind"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="Wind<%=i%>_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Wind"+i))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Wind<%=i%>_3" type="text" class="edit_input" value="<%=ld.getSequence("Wind"+i)%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="Wind<%=i%>_4"   <%=getCheck(ld.getAnchor("Wind"+i))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <%}%>

    <tr><td colspan="2"><hr size="1" /></td></tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.pollute1")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Pollute1" value="checkbox"  <%=getCheck(ld.getIstype("Pollute1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Pollute1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Pollute1"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Pollute1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Pollute1"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Pollute1_3" type="text" class="edit_input" value="<%=ld.getSequence("Pollute1")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Pollute1_4"   <%=getCheck(ld.getAnchor("Pollute1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.pollute2")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Pollute2" value="checkbox"  <%=getCheck(ld.getIstype("Pollute2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Pollute2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Pollute2"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Pollute2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Pollute2"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Pollute2_3" type="text" class="edit_input" value="<%=ld.getSequence("Pollute2")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Pollute2_4"   <%=getCheck(ld.getAnchor("Pollute2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.ultraviolet1")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Ultraviolet1" value="checkbox"  <%=getCheck(ld.getIstype("Ultraviolet1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Ultraviolet1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Ultraviolet1"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Ultraviolet1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Ultraviolet1"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Ultraviolet1_3" type="text" class="edit_input" value="<%=ld.getSequence("Ultraviolet1")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Ultraviolet1_4"   <%=getCheck(ld.getAnchor("Ultraviolet1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.ultraviolet2")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Ultraviolet2" value="checkbox"  <%=getCheck(ld.getIstype("Ultraviolet2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Ultraviolet2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Ultraviolet2"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Ultraviolet2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Ultraviolet2"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Ultraviolet2_3" type="text" class="edit_input" value="<%=ld.getSequence("Ultraviolet2")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Ultraviolet2_4"   <%=getCheck(ld.getAnchor("Ultraviolet2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
            <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.comfort1")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Comfort1" value="checkbox"  <%=getCheck(ld.getIstype("Comfort1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Comfort1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Comfort1"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Comfort1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Comfort1"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Comfort1_3" type="text" class="edit_input" value="<%=ld.getSequence("Comfort1")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Comfort1_4"   <%=getCheck(ld.getAnchor("Comfort1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.comfort2")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Comfort2" value="checkbox"  <%=getCheck(ld.getIstype("Comfort2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Comfort2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Comfort2"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Comfort2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Comfort2"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Comfort2_3" type="text" class="edit_input" value="<%=ld.getSequence("Comfort2")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Comfort2_4"   <%=getCheck(ld.getAnchor("Comfort2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.feel1")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Feel1" value="checkbox"  <%=getCheck(ld.getIstype("Feel1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Feel1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Feel1"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Feel1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Feel1"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Feel1_3" type="text" class="edit_input" value="<%=ld.getSequence("Feel1")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Feel1_4"   <%=getCheck(ld.getAnchor("Feel1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.feel2")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Feel2" value="checkbox"  <%=getCheck(ld.getIstype("Feel2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Feel2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Feel2"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Feel2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Feel2"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Feel2_3" type="text" class="edit_input" value="<%=ld.getSequence("Feel2")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Feel2_4"   <%=getCheck(ld.getAnchor("Feel2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
          <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.ac1")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Ac1" value="checkbox"  <%=getCheck(ld.getIstype("Ac1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Ac1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Ac1"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Ac1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Ac1"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Ac1_3" type="text" class="edit_input" value="<%=ld.getSequence("Ac1")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Ac1_4"   <%=getCheck(ld.getAnchor("Ac1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.ac2")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Ac2" value="checkbox"  <%=getCheck(ld.getIstype("Ac2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Ac2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Ac2"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Ac2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Ac2"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Ac2_3" type="text" class="edit_input" value="<%=ld.getSequence("Ac2")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Ac2_4"   <%=getCheck(ld.getAnchor("Ac2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
              <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.carwash1")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Carwash1" value="checkbox"  <%=getCheck(ld.getIstype("Carwash1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Carwash1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Carwash1"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Carwash1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Carwash1"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Carwash1_3" type="text" class="edit_input" value="<%=ld.getSequence("Carwash1")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Carwash1_4"   <%=getCheck(ld.getAnchor("Carwash1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.carwash2")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Carwash2" value="checkbox"  <%=getCheck(ld.getIstype("Carwash2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Carwash2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Carwash2"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Carwash2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Carwash2"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Carwash2_3" type="text" class="edit_input" value="<%=ld.getSequence("Carwash2")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Carwash2_4"   <%=getCheck(ld.getAnchor("Carwash2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
                  <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.cold1")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Cold1" value="checkbox"  <%=getCheck(ld.getIstype("Cold1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Cold1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Cold1"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Cold1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Cold1"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Cold1_3" type="text" class="edit_input" value="<%=ld.getSequence("Cold1")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Cold1_4"   <%=getCheck(ld.getAnchor("Cold1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.cold2")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Cold2" value="checkbox"  <%=getCheck(ld.getIstype("Cold2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Cold2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Cold2"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Cold2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Cold2"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Cold2_3" type="text" class="edit_input" value="<%=ld.getSequence("Cold2")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Cold2_4"   <%=getCheck(ld.getAnchor("Cold2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
                      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.cold3")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Cold3" value="checkbox"  <%=getCheck(ld.getIstype("Cold3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Cold3_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Cold3"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Cold3_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Cold3"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Cold3_3" type="text" class="edit_input" value="<%=ld.getSequence("Cold3")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Cold3_4"   <%=getCheck(ld.getAnchor("Cold3"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
                  <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.sunscreen1")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Sunscreen1" value="checkbox"  <%=getCheck(ld.getIstype("Sunscreen1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Sunscreen1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Sunscreen1"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Sunscreen1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Sunscreen1"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Sunscreen1_3" type="text" class="edit_input" value="<%=ld.getSequence("Sunscreen1")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Sunscreen1_4"   <%=getCheck(ld.getAnchor("Sunscreen1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.sunscreen2")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Sunscreen2" value="checkbox"  <%=getCheck(ld.getIstype("Sunscreen2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Sunscreen2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Sunscreen2"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Sunscreen2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Sunscreen2"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Sunscreen2_3" type="text" class="edit_input" value="<%=ld.getSequence("Sunscreen2")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Sunscreen2_4"   <%=getCheck(ld.getAnchor("Sunscreen2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.sunscreen3")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Sunscreen3" value="checkbox"  <%=getCheck(ld.getIstype("Sunscreen3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Sunscreen3_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Sunscreen3"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Sunscreen3_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Sunscreen3"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Sunscreen3_3" type="text" class="edit_input" value="<%=ld.getSequence("Sunscreen3")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Sunscreen3_4"   <%=getCheck(ld.getAnchor("Sunscreen3"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
<tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.calenture1")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Calenture1" value="checkbox"  <%=getCheck(ld.getIstype("Calenture1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Calenture1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Calenture1"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Calenture1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Calenture1"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Calenture1_3" type="text" class="edit_input" value="<%=ld.getSequence("Calenture1")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Calenture1_4"   <%=getCheck(ld.getAnchor("Calenture1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.calenture2")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Calenture2" value="checkbox"  <%=getCheck(ld.getIstype("Calenture2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Calenture2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Calenture2"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Calenture2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Calenture2"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Calenture2_3" type="text" class="edit_input" value="<%=ld.getSequence("Calenture2")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Calenture2_4"   <%=getCheck(ld.getAnchor("Calenture2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.calenture3")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Calenture3" value="checkbox"  <%=getCheck(ld.getIstype("Calenture3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Calenture3_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Calenture3"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Calenture3_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Calenture3"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Calenture3_3" type="text" class="edit_input" value="<%=ld.getSequence("Calenture3")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Calenture3_4"   <%=getCheck(ld.getAnchor("Calenture3"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
<tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.dressing1")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Dressing1" value="checkbox"  <%=getCheck(ld.getIstype("Dressing1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Dressing1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Dressing1"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Dressing1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Dressing1"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Dressing1_3" type="text" class="edit_input" value="<%=ld.getSequence("Dressing1")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Dressing1_4"   <%=getCheck(ld.getAnchor("Dressing1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.dressing2")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Dressing2" value="checkbox"  <%=getCheck(ld.getIstype("Dressing2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Dressing2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Dressing2"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Dressing2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Dressing2"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Dressing2_3" type="text" class="edit_input" value="<%=ld.getSequence("Dressing2")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Dressing2_4"   <%=getCheck(ld.getAnchor("Dressing2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.dressing3")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Dressing3" value="checkbox"  <%=getCheck(ld.getIstype("Dressing3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Dressing3_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Dressing3"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Dressing3_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Dressing3"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Dressing3_3" type="text" class="edit_input" value="<%=ld.getSequence("Dressing3")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Dressing3_4"   <%=getCheck(ld.getAnchor("Dressing3"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.angling1")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Angling1" value="checkbox"  <%=getCheck(ld.getIstype("Angling1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Angling1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Angling1"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Angling1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Angling1"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Angling1_3" type="text" class="edit_input" value="<%=ld.getSequence("Angling1")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Angling1_4"   <%=getCheck(ld.getAnchor("Angling1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.angling2")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Angling2" value="checkbox"  <%=getCheck(ld.getIstype("Angling2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Angling2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Angling2"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Angling2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Angling2"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Angling2_3" type="text" class="edit_input" value="<%=ld.getSequence("Angling2")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Angling2_4"   <%=getCheck(ld.getAnchor("Angling2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Weather.angling3")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="Angling3" value="checkbox"  <%=getCheck(ld.getIstype("Angling3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Angling3_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Angling3"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Angling3_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Angling3"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%><input name="Angling3_3" type="text" class="edit_input" value="<%=ld.getSequence("Angling3")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="Angling3_4"   <%=getCheck(ld.getAnchor("Angling3"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>


  </table>
  <center >
    <input type=SUBMIT name="GoBanglingk"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
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
<SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.Subject0_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
