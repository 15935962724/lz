<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/resource/Perform");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
	response.sendError(403);
	return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,55,teasession._nLanguage);


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Perform")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>


<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="55"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Perform.Subject")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" class="edit_input"  type="text">
        <%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" class="edit_input"  type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" class="edit_input"  type="text" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
            <input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Perform.Sort")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="sort"    <%=getCheck(ld.getIstype("sort"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="sort_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sort"))%>" class="edit_input"  type="text">
        <%=r.getString(teasession._nLanguage, "After")%><input name="sort_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sort"))%>" class="edit_input"  type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="sort_3" class="edit_input"  type="text" value="<%=ld.getSequence("sort")%>" maxlength="3" size="4">
            <input  id=CHECKBOX type="CHECKBOX" name="sort_4"   <%=getCheck(ld.getAnchor("sort"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Perform.Text")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="intro" value="checkbox"  <%=getCheck(ld.getIstype("intro"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="intro_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("intro"))%>" class="edit_input"  type="text">
        <%=r.getString(teasession._nLanguage, "After")%><input name="intro_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("intro"))%>" class="edit_input"  type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="intro_3" class="edit_input"  type="text" value="<%=ld.getSequence("intro")%>" maxlength="3" size="4">
            <input  id=CHECKBOX type="CHECKBOX" name="intro_4"   <%=getCheck(ld.getAnchor("intro"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Perform.Organise")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="organise" value="checkbox"  <%=getCheck(ld.getIstype("organise"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="organise_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("organise"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="organise_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("organise"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="organise_3" class="edit_input"  type="text" value="<%=ld.getSequence("organise")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="organise_4"   <%=getCheck(ld.getAnchor("organise"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
     <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Perform.Linkman")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="linkman" value="checkbox"  <%=getCheck(ld.getIstype("linkman"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="linkman_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("linkman"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="linkman_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("linkman"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="linkman_3" class="edit_input"  type="text" value="<%=ld.getSequence("linkman")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="linkman_4"   <%=getCheck(ld.getAnchor("linkman"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Perform.Corp")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="corp" value="checkbox"  <%=getCheck(ld.getIstype("corp"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="corp_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("corp"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="corp_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("corp"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="corp_3" class="edit_input"  type="text" value="<%=ld.getSequence("corp")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="corp_4"   <%=getCheck(ld.getAnchor("corp"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Perform.IntroPicture")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="introPicture" value="checkbox"  <%=getCheck(ld.getIstype("introPicture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="introPicture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("introPicture"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="introPicture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("introPicture"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="introPicture_3" class="edit_input"  type="text" value="<%=ld.getSequence("introPicture")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="introPicture_4"   <%=getCheck(ld.getAnchor("introPicture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Perform.Direct")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="direct" value="checkbox"  <%=getCheck(ld.getIstype("direct"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="direct_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("direct"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="direct_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("direct"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="direct_3" class="edit_input"  type="text" value="<%=ld.getSequence("direct")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="direct_4"   <%=getCheck(ld.getAnchor("direct"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
   <tr><!-- 演出时间 -->
    <td align="right"><%=r.getString(teasession._nLanguage, "Perform.pftime")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="pftime" value="checkbox"  <%=getCheck(ld.getIstype("pftime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="pftime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pftime"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="pftime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pftime"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="pftime_3" class="edit_input"  type="text" value="<%=ld.getSequence("pftime")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="pftime_4"   <%=getCheck(ld.getAnchor("pftime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

   <tr><!-- 演出场次 -->
    <td align="right"><%=r.getString(teasession._nLanguage, "PerformStreak.pfStreak")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="pfStreak" value="checkbox"  <%=getCheck(ld.getIstype("pfStreak"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="pfStreak_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pfStreak"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="pfStreak_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pfStreak"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="pfStreak_3" class="edit_input"  type="text" value="<%=ld.getSequence("pfStreak")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="pfStreak_4"   <%=getCheck(ld.getAnchor("pfStreak"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr><!-- 演出票价 -->
    <td align="right"><%=r.getString(teasession._nLanguage, "Perform.price")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="price" value="checkbox"  <%=getCheck(ld.getIstype("price"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="price_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="price_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="price_3" class="edit_input"  type="text" value="<%=ld.getSequence("price")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="price_4"   <%=getCheck(ld.getAnchor("price"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

 

</table><center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
      </center>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>

 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

