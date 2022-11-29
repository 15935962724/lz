<%@page contentType="text/html;charset=gbk" %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/resource/Job");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
   response.sendError(403);
   return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,50,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Detail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv">
<%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="Node" VALUE="<%=iNode%>">
    <input type="hidden" name="ListingType" value="50"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
    <table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "JobCode")%>: </td>
        <td> <input  id="CHECKBOX" type="CHECKBOX" name="JobCode" value="checkbox"  <%=getCheck(ld.getIstype("JobCode"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="JobCode_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("JobCode"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="JobCode_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("JobCode"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="JobCode_3" type="text" value="<%=ld.getSequence("JobCode")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="JobCode_4"   <%=getCheck(ld.getAnchor("JobCode"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
      </tr>
            <tr>
        <td><%=r.getString(teasession._nLanguage, "JobName")%>: </td>
        <td> <input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="name_3" type="text" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="name_4"   <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
      </tr>

      <tr>
        <td><%=r.getString(teasession._nLanguage, "OrgId")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="OrgId" value="checkbox"  <%=getCheck(ld.getIstype("OrgId"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="OrgId_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("OrgId"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="OrgId_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("OrgId"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="OrgId_3" type="text" value="<%=ld.getSequence("OrgId")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="OrgId_4"   <%=getCheck(ld.getAnchor("OrgId"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "JobType")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="JobType" value="checkbox"  <%=getCheck(ld.getIstype("JobType"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="JobType_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("JobType"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="JobType_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("JobType"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="JobType_3" type="text" value="<%=ld.getSequence("JobType")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="JobType_4"   <%=getCheck(ld.getAnchor("JobType"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "OccClass")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="OccClass" value="checkbox"  <%=getCheck(ld.getIstype("OccClass"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="OccClass_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("OccClass"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="OccClass_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("OccClass"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="OccClass_3" type="text" value="<%=ld.getSequence("OccClass")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="OccClass_4"   <%=getCheck(ld.getAnchor("OccClass"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "HeadCount")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="HeadCount" value="checkbox"  <%=getCheck(ld.getIstype("HeadCount"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="HeadCount_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("HeadCount"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="HeadCount_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("HeadCount"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="HeadCount_3" type="text" value="<%=ld.getSequence("HeadCount")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="HeadCount_4"   <%=getCheck(ld.getAnchor("HeadCount"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "SalaryId")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="SalaryId" value="checkbox"  <%=getCheck(ld.getIstype("SalaryId"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="SalaryId_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("SalaryId"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="SalaryId_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("SalaryId"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="SalaryId_3" type="text" value="<%=ld.getSequence("SalaryId")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="SalaryId_4"   <%=getCheck(ld.getAnchor("SalaryId"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "ProvinceId")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="ProvinceId" value="checkbox"  <%=getCheck(ld.getIstype("ProvinceId"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="ProvinceId_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ProvinceId"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="ProvinceId_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ProvinceId"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="ProvinceId_3" type="text" value="<%=ld.getSequence("ProvinceId")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="ProvinceId_4"   <%=getCheck(ld.getAnchor("ProvinceId"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "ReqWyearId")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="ReqWyearId" value="checkbox"  <%=getCheck(ld.getIstype("ReqWyearId"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="ReqWyearId_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ReqWyearId"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="ReqWyearId_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ReqWyearId"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="ReqWyearId_3" type="text" value="<%=ld.getSequence("ReqWyearId")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="ReqWyearId_4"   <%=getCheck(ld.getAnchor("ReqWyearId"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "ReqDegId")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="ReqDegId" value="checkbox"  <%=getCheck(ld.getIstype("ReqDegId"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="ReqDegId_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ReqDegId"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="ReqDegId_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ReqDegId"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="ReqDegId_3" type="text" value="<%=ld.getSequence("ReqDegId")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="ReqDegId_4"   <%=getCheck(ld.getAnchor("ReqDegId"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Resume")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="Resume" value="checkbox"  <%=getCheck(ld.getIstype("Resume"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="Resume_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Resume"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="Resume_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Resume"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="Resume_3" type="text" value="<%=ld.getSequence("Resume")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="Resume_4"   <%=getCheck(ld.getAnchor("Resume"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Alter/Copy")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="AlterCopy" value="checkbox"  <%=getCheck(ld.getIstype("AlterCopy"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="AlterCopy_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("AlterCopy"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="AlterCopy_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("AlterCopy"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="AlterCopy_3" type="text" value="<%=ld.getSequence("AlterCopy")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="AlterCopy_4"   <%=getCheck(ld.getAnchor("AlterCopy"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
      </tr>
            <tr>
        <td><%=r.getString(teasession._nLanguage, "Delete")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="Delete" value="checkbox"  <%=getCheck(ld.getIstype("Delete"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="Delete_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Delete"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="Delete_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Delete"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="Delete_3" type="text" value="<%=ld.getSequence("Delete")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="Delete_4"   <%=getCheck(ld.getAnchor("Delete"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
      </tr>
            <tr>
        <td><%=r.getString(teasession._nLanguage, "IssueTime")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="issuetime" value="checkbox"  <%=getCheck(ld.getIstype("issuetime"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="issuetime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("issuetime"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="issuetime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("issuetime"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="issuetime_3" type="text" value="<%=ld.getSequence("issuetime")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="issuetime_4"   <%=getCheck(ld.getAnchor("issuetime"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Validity")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="validity" value="checkbox"  <%=getCheck(ld.getIstype("validity"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="validity_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("validity"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="validity_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("validity"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="validity_3" type="text" value="<%=ld.getSequence("validity")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="validity_4"   <%=getCheck(ld.getAnchor("validity"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Count")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="count" value="checkbox"  <%=getCheck(ld.getIstype("count"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="count_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("count"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="count_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("count"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="count_3" type="text" value="<%=ld.getSequence("count")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="count_4"   <%=getCheck(ld.getAnchor("count"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
      </tr>

            <tr>
        <td><%=r.getString(teasession._nLanguage, "Intro")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="text_3" type="text" value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
      </tr>

                  <tr>
        <td><%=r.getString(teasession._nLanguage, "ApplyJob")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="ApplyJob" value="checkbox"  <%=getCheck(ld.getIstype("ApplyJob"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="ApplyJob_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ApplyJob"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="ApplyJob_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ApplyJob"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="ApplyJob_3" type="text" value="<%=ld.getSequence("ApplyJob")%>" maxlength="3" size="4">
          <%--<input  id=CHECKBOX type="CHECKBOX" name="ApplyJob_4"   <%=getCheck(ld.getAnchor("ApplyJob"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;---%></td>
      </tr>

                  <tr>
        <td><%=r.getString(teasession._nLanguage, "CorpJob")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="CorpJob" value="checkbox"  <%=getCheck(ld.getIstype("CorpJob"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="CorpJob_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("CorpJob"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%> <input name="CorpJob_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("CorpJob"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>: <input name="CorpJob_3" type="text" value="<%=ld.getSequence("CorpJob")%>" maxlength="3" size="4">
          <%-- %><input  id=CHECKBOX type="CHECKBOX" name="CorpJob_4"   <%=getCheck(ld.getAnchor("CorpJob"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;--%></td>
      </tr>
    </table>
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

