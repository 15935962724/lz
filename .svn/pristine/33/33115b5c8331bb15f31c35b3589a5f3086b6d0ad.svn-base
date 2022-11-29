<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>


<%

int listingid= Integer.parseInt(teasession.getParameter("Listing"));
int nodeid  = Listing.find(listingid).getNode();
Node node = Node.find(nodeid);
if(!node.isCreator(teasession._rv)&&AccessMember.find(nodeid,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
r.add("/tea/resource/AdminList");

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(listingid,86,teasession._nLanguage);

%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, Node.NODE_TYPE[86])%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<%
if(!flag)
{
  out.print("<input type=hidden name=PickNode value="+request.getParameter("PickNode")+">");
}else
{
  out.print("<input type=hidden name=PickManual value="+request.getParameter("PickManual")+">");
}
if(request.getParameter("Edit")!=null)
{
  out.print("<input type=hidden name=Edit value="+request.getParameter("Edit")+">");
}
%>
<input type="hidden" name="Listing" value="<%=listingid%>">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="ListingType" value="86">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
    <td>
      <input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" class="edit_input" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" class="edit_input" type="text" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="subject_4"  <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4">
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Tender.media")%>:</td>
    <td>
      <input  id="CHECKBOX" type="CHECKBOX" name="media" value="checkbox"  <%=getCheck(ld.getIstype("media"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="media_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("media"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input name="media_2" class="edit_input" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("media"))%>">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="media_3" class="edit_input" type="text" value="<%=ld.getSequence("media")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="media_4"  <%=getCheck(ld.getAnchor("media"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Node.father")%>:</td>
    <td>
      <input  id="CHECKBOX" type="CHECKBOX" name="father" value="checkbox"  <%=getCheck(ld.getIstype("father"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="father_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("father"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input name="father_2" class="edit_input" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("father"))%>">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="father_3" class="edit_input" type="text" value="<%=ld.getSequence("father")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="father_4"  <%=getCheck(ld.getAnchor("father"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "Tender.locus")%>:</td>
    <td>
      <input  id="CHECKBOX" type="CHECKBOX" name="locus" value="checkbox"  <%=getCheck(ld.getIstype("locus"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="locus_1"  class="edit_input"   mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("locus"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "After")%><input name="locus_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("locus"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="locus_3" class="edit_input" type="text" value="<%=ld.getSequence("locus")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="locus_4"  <%=getCheck(ld.getAnchor("locus"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="locus_5" class="edit_input" type="text" value="<%=ld.getQuantity("locus")%>" maxlength="3" size="4">
    </td>
   </tr>

<!--副标题-->
   <tr>
    <td><%=r.getString(teasession._nLanguage, "Tender.subhead")%>:</td>
    <td>
      <input  id="CHECKBOX" type="CHECKBOX" name="subhead" value="checkbox"  <%=getCheck(ld.getIstype("subhead"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="subhead_1"  class="edit_input"   mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subhead"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "After")%><input name="subhead_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("subhead"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subhead_3" class="edit_input" type="text" value="<%=ld.getSequence("subhead")%>" maxlength="3" size="4">
      <input id=CHECKBOX type="CHECKBOX" name="subhead_4"  <%=getCheck(ld.getAnchor("subhead"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subhead_5" class="edit_input" type="text" value="<%=ld.getQuantity("subhead")%>" maxlength="3" size="4">
    </td>
   </tr>

<!--作者-->
   <tr>
    <td><%=r.getString(teasession._nLanguage, "Tender.author")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="author" value="checkbox"  <%=getCheck(ld.getIstype("author"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="author_1"  class="edit_input"   mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("author"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "After")%><input name="author_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("author"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="author_3" class="edit_input" type="text" value="<%=ld.getSequence("author")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="author_4"  <%=getCheck(ld.getAnchor("author"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="author_5" class="edit_input" type="text" value="<%=ld.getQuantity("author")%>" maxlength="3" size="4">
    </td>
   </tr>

   <tr>
    <td><%=r.getString(teasession._nLanguage, "Creator")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="creator" value="checkbox"  <%=getCheck(ld.getIstype("creator"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="creator_1"  class="edit_input"   mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("creator"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "After")%><input name="creator_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("creator"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="creator_3" class="edit_input" type="text" value="<%=ld.getSequence("creator")%>" maxlength="3" size="4">
      <input id=CHECKBOX type="CHECKBOX" name="creator_4"  <%=getCheck(ld.getAnchor("creator"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
   </tr>
   <tr>
     <td><%=r.getString(teasession._nLanguage, "Tender.file")%>:</td>
     <td><input  id="CHECKBOX" type="CHECKBOX" name="file" value="checkbox"  <%=getCheck(ld.getIstype("file"))%>><%=r.getString(teasession._nLanguage, "Show")%>
       <%=r.getString(teasession._nLanguage, "Before")%><input name="file_1"  class="edit_input"   mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("file"))%>" type="text">
         <%=r.getString(teasession._nLanguage, "After")%><input name="file_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("file"))%>" type="text">
           <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="file_3" class="edit_input" type="text" value="<%=ld.getSequence("file")%>" maxlength="3" size="4">
             <input  id=CHECKBOX type="CHECKBOX" name="file_4"  <%=getCheck(ld.getAnchor("file"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
             <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="file_5" class="edit_input" type="text" value="<%=ld.getQuantity("file")%>" maxlength="3" size="4">
     </td>
   </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "Tender.logograph")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="logograph" value="checkbox"  <%=getCheck(ld.getIstype("logograph"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="logograph_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("logograph"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="logograph_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("logograph"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="logograph_3" class="edit_input" type="text" value="<%=ld.getSequence("logograph")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="logograph_4"  <%=getCheck(ld.getAnchor("logograph"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="logograph_5" class="edit_input" type="text" value="<%=ld.getQuantity("logograph")%>" maxlength="3" size="4">
  </td></tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
    <td>
      <input  id="CHECKBOX" type="CHECKBOX" name="content" value="checkbox"  <%=getCheck(ld.getIstype("content"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="content_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("content"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input name="content_2" class="edit_input" mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("content"))%>">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="content_3" class="edit_input" type="text" value="<%=ld.getSequence("content")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="content_4"  <%=getCheck(ld.getAnchor("content"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "Tender.time")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="time" value="checkbox"  <%=getCheck(ld.getIstype("time"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="time_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("time"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="time_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("time"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="time_3" class="edit_input" type="text" value="<%=ld.getSequence("time")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="time_4"  <%=getCheck(ld.getAnchor("time"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "StopTime")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="stoptime" value="checkbox"  <%=getCheck(ld.getIstype("stoptime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="stoptime_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("stoptime"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%><input name="stoptime_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("stoptime"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="stoptime_3" class="edit_input" type="text" value="<%=ld.getSequence("stoptime")%>" maxlength="3" size="4">
            <input  id=CHECKBOX type="CHECKBOX" name="stoptime_4"  <%=getCheck(ld.getAnchor("stoptime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Correlation")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="correlation" value="checkbox"  <%=getCheck(ld.getIstype("correlation"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="correlation_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("correlation"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="correlation_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("correlation"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="correlation_3" class="edit_input" type="text" value="<%=ld.getSequence("correlation")%>" maxlength="3" size="4">
    <!--input  id=CHECKBOX type="CHECKBOX" name="correlation_4" value="2"  <%=getCheck(ld.getAnchor("correlation"))%>><%=r.getString(teasession._nLanguage, "Time")%>-->
 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="correlation_5" class="edit_input" type="text" value="<%=ld.getQuantity("correlation")%>" maxlength="3" size="4">
  </td></tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Correlation")%><%=r.getString(teasession._nLanguage, "NewsPaper")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="correlationNP" value="checkbox"  <%=getCheck(ld.getIstype("correlationNP"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="correlationNP_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("correlationNP"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="correlationNP_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("correlationNP"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="correlationNP_3" class="edit_input" type="text" value="<%=ld.getSequence("correlationNP")%>" maxlength="3" size="4">
    <!--input  id=CHECKBOX type="CHECKBOX" name="correlationNP_4" value="2" <%=getCheck(ld.getAnchor("correlationNP"))%>><%=r.getString(teasession._nLanguage, "Time")%>-->
 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="correlationNP_5" class="edit_input" type="text" value="<%=ld.getQuantity("correlationNP")%>" maxlength="3" size="4">
  </td>
  </tr>
</table>


<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
