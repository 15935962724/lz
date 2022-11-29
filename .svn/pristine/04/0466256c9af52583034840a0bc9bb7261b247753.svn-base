<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Resume");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
      response.sendError(403);
      return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,52,teasession._nLanguage);


%>
<HTML>
<HEAD>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage, "ResumeDelite")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<DIV ID="edit_BodyDiv"><div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
       <input type="hidden" name="ListingType" value="52"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
<%   }%>
<input type="hidden" name="Listing" value="<%=iListing%>"/>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<%        if(request.getParameter("Edit")!=null)
{%><input type="hidden" name="Edit" value="<%=request.getParameter("Edit")%>"/>
<%}  %>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="name_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="name_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" class="edit_input" type="text" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="name_4"  <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%--=r.getString(teasession._nLanguage, "Quantity")%>:<input name="name_5" class="edit_input" type="text" value="<%=ld.getQuantity("name")%>" maxlength="3" size="4">--%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Sex")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="Sex" value="checkbox"  <%=getCheck(ld.getIstype("Sex"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="Sex_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Sex"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="Sex_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("Sex"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Sex_3" class="edit_input" type="text" value="<%=ld.getSequence("Sex")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="Sex_4"  <%=getCheck(ld.getAnchor("Sex"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Birth")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="Birth" value="checkbox"  <%=getCheck(ld.getIstype("Birth"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="Birth_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Birth"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "After")%><input name="Birth_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("Birth"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Birth_3" class="edit_input" type="text" value="<%=ld.getSequence("Birth")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="Birth_4"  <%=getCheck(ld.getAnchor("Birth"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "State")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="State" value="checkbox"  <%=getCheck(ld.getIstype("State"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="State_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("State"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="State_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("State"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="State_3" class="edit_input" type="text" value="<%=ld.getSequence("State")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="State_4"  <%=getCheck(ld.getAnchor("State"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td></tr>

   <tr>
    <td><%=r.getString(teasession._nLanguage, "Degree")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="Degree" value="checkbox"  <%=getCheck(ld.getIstype("Degree"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="Degree_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Degree"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Degree_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("Degree"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Degree_3" class="edit_input" type="text" value="<%=ld.getSequence("Degree")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="Degree_4"  <%=getCheck(ld.getAnchor("Degree"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td></tr>

<tr>
    <td><%=r.getString(teasession._nLanguage, "ExpectCity")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="ExpectCity" value="checkbox"  <%=getCheck(ld.getIstype("ExpectCity"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="ExpectCity_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ExpectCity"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="ExpectCity_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("ExpectCity"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ExpectCity_3" class="edit_input" type="text" value="<%=ld.getSequence("ExpectCity")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="ExpectCity_4"  <%=getCheck(ld.getAnchor("ExpectCity"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "MajorCategory")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="MajorCategory" value="checkbox"  <%=getCheck(ld.getIstype("MajorCategory"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="MajorCategory_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("MajorCategory"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="MajorCategory_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("MajorCategory"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="MajorCategory_3" class="edit_input" type="text" value="<%=ld.getSequence("MajorCategory")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="MajorCategory_4"  <%=getCheck(ld.getAnchor("MajorCategory"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>

    <tr>
    <td><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="EmailAddress" value="checkbox"  <%=getCheck(ld.getIstype("EmailAddress"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="EmailAddress_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("EmailAddress"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="EmailAddress_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("EmailAddress"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="EmailAddress_3" class="edit_input" type="text" value="<%=ld.getSequence("EmailAddress")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="EmailAddress_4"  <%=getCheck(ld.getAnchor("EmailAddress"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>

    <tr>
    <td><%=r.getString(teasession._nLanguage, "Checkbox")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="Checkbox" value="checkbox"  <%=getCheck(ld.getIstype("Checkbox"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="Checkbox_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Checkbox"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="Checkbox_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("Checkbox"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Checkbox_3" class="edit_input" type="text" value="<%=ld.getSequence("Checkbox")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="Checkbox_4"  <%=getCheck(ld.getAnchor("Checkbox"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>

    <tr>
    <td><%=r.getString(teasession._nLanguage, "Mobile")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="Mobile" value="checkbox"  <%=getCheck(ld.getIstype("Mobile"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="Mobile_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Mobile"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="Mobile_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("Mobile"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Mobile_3" class="edit_input" type="text" value="<%=ld.getSequence("Mobile")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="Mobile_4"  <%=getCheck(ld.getAnchor("Mobile"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "Photo")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="Photo" value="checkbox"  <%=getCheck(ld.getIstype("Photo"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="Photo_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Photo"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="Photo_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("Photo"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Photo_3" class="edit_input" type="text" value="<%=ld.getSequence("Photo")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="Photo_4"  <%=getCheck(ld.getAnchor("Photo"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="Address" value="checkbox"  <%=getCheck(ld.getIstype("Address"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="Address_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Address"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="Address_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("Address"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Address_3" class="edit_input" type="text" value="<%=ld.getSequence("Address")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="Address_4"  <%=getCheck(ld.getAnchor("Address"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "NowTrade")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="NowTrade" value="checkbox"  <%=getCheck(ld.getIstype("NowTrade"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="NowTrade_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("NowTrade"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="NowTrade_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("NowTrade"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="NowTrade_3" class="edit_input" type="text" value="<%=ld.getSequence("NowTrade")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="NowTrade_4"  <%=getCheck(ld.getAnchor("NowTrade"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "NowMainCareer")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="NowMainCareer" value="checkbox"  <%=getCheck(ld.getIstype("NowMainCareer"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="NowMainCareer_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("NowMainCareer"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="NowMainCareer_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("NowMainCareer"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="NowMainCareer_3" class="edit_input" type="text" value="<%=ld.getSequence("NowMainCareer")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="NowMainCareer_4"  <%=getCheck(ld.getAnchor("NowMainCareer"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
     <tr>
    <td><%=r.getString(teasession._nLanguage, "NowCareerLevel")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="NowCareerLevel" value="checkbox"  <%=getCheck(ld.getIstype("NowCareerLevel"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="NowCareerLevel_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("NowCareerLevel"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="NowCareerLevel_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("NowCareerLevel"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="NowCareerLevel_3" class="edit_input" type="text" value="<%=ld.getSequence("NowCareerLevel")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="NowCareerLevel_4"  <%=getCheck(ld.getAnchor("NowCareerLevel"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
     <tr>
    <td><%=r.getString(teasession._nLanguage, "Experience")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="Experience" value="checkbox"  <%=getCheck(ld.getIstype("Experience"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="Experience_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Experience"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="Experience_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("Experience"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Experience_3" class="edit_input" type="text" value="<%=ld.getSequence("Experience")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="Experience_4"  <%=getCheck(ld.getAnchor("Experience"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "HasAbroad")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="HasAbroad" value="checkbox"  <%=getCheck(ld.getIstype("HasAbroad"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="HasAbroad_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("HasAbroad"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="HasAbroad_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("HasAbroad"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="HasAbroad_3" class="edit_input" type="text" value="<%=ld.getSequence("HasAbroad")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="HasAbroad_4"  <%=getCheck(ld.getAnchor("HasAbroad"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "SalarySum")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="SalarySum" value="checkbox"  <%=getCheck(ld.getIstype("SalarySum"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="SalarySum_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("SalarySum"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="SalarySum_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("SalarySum"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="SalarySum_3" class="edit_input" type="text" value="<%=ld.getSequence("SalarySum")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="SalarySum_4"  <%=getCheck(ld.getAnchor("SalarySum"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
      <tr>
    <td><%=r.getString(teasession._nLanguage, "ExpectWorkKind")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="ExpectWorkKind" value="checkbox"  <%=getCheck(ld.getIstype("ExpectWorkKind"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="ExpectWorkKind_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ExpectWorkKind"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="ExpectWorkKind_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("ExpectWorkKind"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ExpectWorkKind_3" class="edit_input" type="text" value="<%=ld.getSequence("ExpectWorkKind")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="ExpectWorkKind_4"  <%=getCheck(ld.getAnchor("ExpectWorkKind"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
       <tr>
    <td><%=r.getString(teasession._nLanguage, "ExpectTrade")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="ExpectTrade" value="checkbox"  <%=getCheck(ld.getIstype("ExpectTrade"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="ExpectTrade_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ExpectTrade"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="ExpectTrade_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("ExpectTrade"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ExpectTrade_3" class="edit_input" type="text" value="<%=ld.getSequence("ExpectTrade")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="ExpectTrade_4"  <%=getCheck(ld.getAnchor("ExpectTrade"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
        <tr>
    <td><%=r.getString(teasession._nLanguage, "ExpectCareer")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="ExpectCareer" value="checkbox"  <%=getCheck(ld.getIstype("ExpectCareer"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="ExpectCareer_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ExpectCareer"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="ExpectCareer_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("ExpectCareer"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ExpectCareer_3" class="edit_input" type="text" value="<%=ld.getSequence("ExpectCareer")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="ExpectCareer_4"  <%=getCheck(ld.getAnchor("ExpectCareer"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
          <tr>
    <td><%=r.getString(teasession._nLanguage, "ExpectSalarySum")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="ExpectSalarySum" value="checkbox"  <%=getCheck(ld.getIstype("ExpectSalarySum"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="ExpectSalarySum_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ExpectSalarySum"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="ExpectSalarySum_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("ExpectSalarySum"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ExpectSalarySum_3" class="edit_input" type="text" value="<%=ld.getSequence("ExpectSalarySum")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="ExpectSalarySum_4"  <%=getCheck(ld.getAnchor("ExpectSalarySum"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
          <tr>
    <td><%=r.getString(teasession._nLanguage, "JoinDateType")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="JoinDateType" value="checkbox"  <%=getCheck(ld.getIstype("JoinDateType"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="JoinDateType_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("JoinDateType"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="JoinDateType_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("JoinDateType"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="JoinDateType_3" class="edit_input" type="text" value="<%=ld.getSequence("JoinDateType")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="JoinDateType_4"  <%=getCheck(ld.getAnchor("JoinDateType"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
            <tr>
    <td><%=r.getString(teasession._nLanguage, "SelfValue")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="SelfValue" value="checkbox"  <%=getCheck(ld.getIstype("SelfValue"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="SelfValue_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("SelfValue"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="SelfValue_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("SelfValue"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="SelfValue_3" class="edit_input" type="text" value="<%=ld.getSequence("SelfValue")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="SelfValue_4"  <%=getCheck(ld.getAnchor("SelfValue"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
              <tr>
    <td><%=r.getString(teasession._nLanguage, "SelfAim")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="SelfAim" value="checkbox"  <%=getCheck(ld.getIstype("SelfAim"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="SelfAim_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("SelfAim"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="SelfAim_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("SelfAim"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="SelfAim_3" class="edit_input" type="text" value="<%=ld.getSequence("SelfAim")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="SelfAim_4"  <%=getCheck(ld.getAnchor("SelfAim"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>

</table>
<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</DIV>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div></body></HTML>

