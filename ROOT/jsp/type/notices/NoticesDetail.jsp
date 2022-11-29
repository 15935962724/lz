<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Notices");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
      response.sendError(403);
      return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,99,teasession._nLanguage);


%>
<HTML>
<HEAD>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage, "Notices")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<DIV ID="edit_BodyDiv"><div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
       <input type="hidden" name="ListingType" value="99"/>
		<input type="hidden" name="Listing" value="<%=iListing%>"/>
		<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
    <%}else{%>
	<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
	<%   }%>
	<%if(request.getParameter("Edit")!=null)
	{%><input type="hidden" name="Edit" value="<%=request.getParameter("Edit")%>"/>
	<%}  %>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


  <tr>
    <td><%=r.getString(teasession._nLanguage, "ProjectNumber")%>:</td>
    <td>			<input  id="CHECKBOX" type="CHECKBOX" name="ProjectNumber" value="checkbox"  <%=getCheck(ld.getIstype("ProjectNumber"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="ProjectNumber_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ProjectNumber"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="ProjectNumber_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("ProjectNumber"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ProjectNumber_3" class="edit_input" type="text" value="<%=ld.getSequence("ProjectNumber")%>" maxlength="3" size="4">
							<input  id=CHECKBOX type="CHECKBOX" name="ProjectNumber_4"  <%=getCheck(ld.getAnchor("ProjectNumber"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "ProjectName")%>:</td>
    <td>			<input  id="CHECKBOX" type="CHECKBOX" name="ProjectName" value="checkbox"  <%=getCheck(ld.getIstype("ProjectName"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="ProjectName_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ProjectName"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="ProjectName_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("ProjectName"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ProjectName_3" class="edit_input" type="text" value="<%=ld.getSequence("ProjectName")%>" maxlength="3" size="4">
							<input  id=CHECKBOX type="CHECKBOX" name="ProjectName_4"  <%=getCheck(ld.getAnchor("ProjectName"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "ProjectAddresss")%>:</td>
    <td>			<input  id="CHECKBOX" type="CHECKBOX" name="ProjectAddresss" value="checkbox"  <%=getCheck(ld.getIstype("ProjectAddresss"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="ProjectAddresss_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ProjectAddresss"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="ProjectAddresss_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("ProjectAddresss"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ProjectAddresss_3" class="edit_input" type="text" value="<%=ld.getSequence("ProjectAddresss")%>" maxlength="3" size="4">
							<input  id=CHECKBOX type="CHECKBOX" name="ProjectAddresss_4"  <%=getCheck(ld.getAnchor("ProjectAddresss"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "OwnerName")%>:</td>
    <td>			<input  id="CHECKBOX" type="CHECKBOX" name="OwnerName" value="checkbox"  <%=getCheck(ld.getIstype("OwnerName"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="OwnerName_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("OwnerName"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="OwnerName_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("OwnerName"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="OwnerName_3" class="edit_input" type="text" value="<%=ld.getSequence("OwnerName")%>" maxlength="3" size="4">
							<input  id=CHECKBOX type="CHECKBOX" name="OwnerName_4"  <%=getCheck(ld.getAnchor("OwnerName"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "PackageName")%>:</td>
    <td>			<input  id="CHECKBOX" type="CHECKBOX" name="PackageName" value="checkbox"  <%=getCheck(ld.getIstype("PackageName"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="PackageName_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("PackageName"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="PackageName_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("PackageName"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="PackageName_3" class="edit_input" type="text" value="<%=ld.getSequence("PackageName")%>" maxlength="3" size="4">
							<input  id=CHECKBOX type="CHECKBOX" name="PackageName_4"  <%=getCheck(ld.getAnchor("PackageName"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "EditPerson")%>:</td>
    <td>			<input  id="CHECKBOX" type="CHECKBOX" name="EditPerson" value="checkbox"  <%=getCheck(ld.getIstype("EditPerson"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="EditPerson_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("EditPerson"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="EditPerson_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("EditPerson"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="EditPerson_3" class="edit_input" type="text" value="<%=ld.getSequence("EditPerson")%>" maxlength="3" size="4">
							<input  id=CHECKBOX type="CHECKBOX" name="EditPerson_4"  <%=getCheck(ld.getAnchor("EditPerson"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Content")%>:</td>
    <td>			<input  id="CHECKBOX" type="CHECKBOX" name="Content" value="checkbox"  <%=getCheck(ld.getIstype("Content"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="Content_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Content"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="Content_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("Content"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Content_3" class="edit_input" type="text" value="<%=ld.getSequence("Content")%>" maxlength="3" size="4">
							<input  id=CHECKBOX type="CHECKBOX" name="Content_4"  <%=getCheck(ld.getAnchor("Content"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "ReleaseTime")%>:</td>
    <td>			<input  id="CHECKBOX" type="CHECKBOX" name="ReleaseTime" value="checkbox"  <%=getCheck(ld.getIstype("ReleaseTime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="ReleaseTime_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ReleaseTime"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="ReleaseTime_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("ReleaseTime"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ReleaseTime_3" class="edit_input" type="text" value="<%=ld.getSequence("ReleaseTime")%>" maxlength="3" size="4">
							<input  id=CHECKBOX type="CHECKBOX" name="ReleaseTime_4"  <%=getCheck(ld.getAnchor("ReleaseTime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  

</table>
<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</DIV>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div></body></HTML>

