<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/resource/Travel");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
      response.sendError(403);
      return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,79,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "TravelDetail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
       <input type="hidden" name="ListingType" value="79"/>
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
    <td><%=r.getString(teasession._nLanguage, "Subject")%>:<!--主题--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getSubject" value="checkbox"  <%=getCheck(ld.getIstype("getSubject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getSubject_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSubject"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getSubject_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSubject"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getSubject_3" class="edit_input" type="text" value="<%=ld.getSequence("getSubject")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getSubject_4"  <%=getCheck(ld.getAnchor("getSubject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getSubject_5" class="edit_input" type="text" value="<%=ld.getQuantity("getSubject")%>" maxlength="3" size="4">
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Text")%>:<!--内容--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getText" value="checkbox"  <%=getCheck(ld.getIstype("getText"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="getText_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getText"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="getText_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getText"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getText_3" class="edit_input" type="text" value="<%=ld.getSequence("getText")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="getText_4"  <%=getCheck(ld.getAnchor("getText"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Leavetime")%>:<!--发团时间--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getLeavetext" value="checkbox"  <%=getCheck(ld.getIstype("getLeavetext"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getLeavetext_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getLeavetext"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "After")%><input name="getLeavetext_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getLeavetext"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getLeavetext_3" class="edit_input" type="text" value="<%=ld.getSequence("getLeavetext")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getLeavetext_4"  <%=getCheck(ld.getAnchor("getLeavetext"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
  	<td><%=r.getString(teasession._nLanguage,"Jiezhitime")%>:<!--截至时间--></td>
  	<td>
  		<input id="CHECKBOX" type="CHECKBOX" name="getStoptime" value="checkbox" <%=getCheck(ld.getIstype("getStoptime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
  		<%=r.getString(teasession._nLanguage, "Before")%><input name="getStoptime_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getStoptime"))%>" type="text">
      	<%=r.getString(teasession._nLanguage, "After")%><input name="getStoptime_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getStoptime"))%>" type="text">
      	<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getStoptime_3" class="edit_input" type="text" value="<%=ld.getSequence("getStoptime")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getStoptime_4"  <%=getCheck(ld.getAnchor("getStoptime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  	</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Counts")%>:<!--人数--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getCounts" value="checkbox"  <%=getCheck(ld.getIstype("getCounts"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getCounts_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getCounts"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="getCounts_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getCounts"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getCounts_3" class="edit_input" type="text" value="<%=ld.getSequence("getCounts")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="getCounts_4"  <%=getCheck(ld.getAnchor("getCounts"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td></tr>

   <tr>
    <td><%=r.getString(teasession._nLanguage, "Price")%>:<!--单价 --></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getPriceToString" value="checkbox"  <%=getCheck(ld.getIstype("getPriceToString"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getPriceToString_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPriceToString"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="getPriceToString_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPriceToString"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPriceToString_3" class="edit_input" type="text" value="<%=ld.getSequence("getPriceToString")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="getPriceToString_4"  <%=getCheck(ld.getAnchor("getPriceToString"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td></tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Leixing")%>:<!--类型--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getLeixing" value="checkbox"  <%=getCheck(ld.getIstype("getLeixing"))%>><%=r.getString(teasession._nLanguage, "Show")%>
     	<%=r.getString(teasession._nLanguage, "Before")%><input name="getLeixing_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getLeixing"))%>" type="text">
     	 <%=r.getString(teasession._nLanguage, "After")%><input name="getLeixing_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getLeixing"))%>" type="text">
      	 <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getLeixing_3" class="edit_input" type="text" value="<%=ld.getSequence("getLeixing")%>" maxlength="3" size="4">
    	<input  id=CHECKBOX type="CHECKBOX" name="getLeixing_4"  <%=getCheck(ld.getAnchor("getLeixing"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  	 </td>
   </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "Zhoubie")%>:<!--洲别--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getZhoubie" value="checkbox"  <%=getCheck(ld.getIstype("getZhoubie"))%>><%=r.getString(teasession._nLanguage, "Show")%>
     	<%=r.getString(teasession._nLanguage, "Before")%><input name="getZhoubie_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getZhoubie"))%>" type="text">
     	 <%=r.getString(teasession._nLanguage, "After")%><input name="getZhoubie_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getZhoubie"))%>" type="text">
      	 <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getZhoubie_3" class="edit_input" type="text" value="<%=ld.getSequence("getZhoubie")%>" maxlength="3" size="4">
    	<input  id=CHECKBOX type="CHECKBOX" name="getZhoubie_4"  <%=getCheck(ld.getAnchor("getZhoubie"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  	 </td>
   </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "Tujing")%>--<%=r.getString(teasession._nLanguage, "Guojia")%>:<!--途径国家--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getTj_guojia" value="checkbox"  <%=getCheck(ld.getIstype("getTj_guojia"))%>><%=r.getString(teasession._nLanguage, "Show")%>
     	<%=r.getString(teasession._nLanguage, "Before")%><input name="getTj_guojia_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getTj"))%>" type="text">
     	 <%=r.getString(teasession._nLanguage, "After")%><input name="getTj_guojia_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getTj"))%>" type="text">
      	 <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getTj_guojia_3" class="edit_input" type="text" value="<%=ld.getSequence("getTj")%>" maxlength="3" size="4">
    	<input  id=CHECKBOX type="CHECKBOX" name="getTj_guojia_4"  <%=getCheck(ld.getAnchor("getTj"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  	 </td>
   </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "Tujing")%>--<%=r.getString(teasession._nLanguage, "Chengshi")%>:<!--途径城市--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getTj_chengshi" value="checkbox"  <%=getCheck(ld.getIstype("getTj_chengshi"))%>><%=r.getString(teasession._nLanguage, "Show")%>
     	<%=r.getString(teasession._nLanguage, "Before")%><input name="getTj_chengshi_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getTj"))%>" type="text">
     	 <%=r.getString(teasession._nLanguage, "After")%><input name="getTj_chengshi_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getTj"))%>" type="text">
      	 <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getTj_chengshi_3" class="edit_input" type="text" value="<%=ld.getSequence("getTj")%>" maxlength="3" size="4">
    	<input  id=CHECKBOX type="CHECKBOX" name="getTj_chengshi_4"  <%=getCheck(ld.getAnchor("getTj"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  	 </td>
   </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Tujing")%>--<%=r.getString(teasession._nLanguage, "Jingdian")%>:<!--途径景点--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getTj_jingdian" value="checkbox"  <%=getCheck(ld.getIstype("getTj_jingdian"))%>><%=r.getString(teasession._nLanguage, "Show")%>
     	<%=r.getString(teasession._nLanguage, "Before")%><input name="getTj_jingdian_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getTj"))%>" type="text">
     	 <%=r.getString(teasession._nLanguage, "After")%><input name="getTj_jingdian_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getTj"))%>" type="text">
      	 <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getTj_jingdian_3" class="edit_input" type="text" value="<%=ld.getSequence("getTj")%>" maxlength="3" size="4">
    	<input  id=CHECKBOX type="CHECKBOX" name="getTj_jingdian_4"  <%=getCheck(ld.getAnchor("getTj"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  	 </td>
   </tr>

   <tr>
    <td><%=r.getString(teasession._nLanguage, "Locu")%>:<!--出发地点--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getLocu" value="checkbox"  <%=getCheck(ld.getIstype("getLocu"))%>><%=r.getString(teasession._nLanguage, "Show")%>
     	<%=r.getString(teasession._nLanguage, "Before")%><input name="getLocu_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getLocu"))%>" type="text">
     	 <%=r.getString(teasession._nLanguage, "After")%><input name="getLocu_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getLocu"))%>" type="text">
      	 <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getLocu_3" class="edit_input" type="text" value="<%=ld.getSequence("getLocu")%>" maxlength="3" size="4">
    	<input  id=CHECKBOX type="CHECKBOX" name="getLocu_4"  <%=getCheck(ld.getAnchor("getLocu"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  	 </td>
   </tr>

    <tr>
    <td><%=r.getString(teasession._nLanguage, "Daycount")%>:<!--航程天数--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getDaycount" value="checkbox"  <%=getCheck(ld.getIstype("getDaycount"))%>><%=r.getString(teasession._nLanguage, "Show")%>
     	<%=r.getString(teasession._nLanguage, "Before")%><input name="getDaycount_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getDaycount"))%>" type="text">
     	 <%=r.getString(teasession._nLanguage, "After")%><input name="getDaycount_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getDaycount"))%>" type="text">
      	 <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getDaycount_3" class="edit_input" type="text" value="<%=ld.getSequence("getDaycount")%>" maxlength="3" size="4">
    	<input  id=CHECKBOX type="CHECKBOX" name="getDaycount_4"  <%=getCheck(ld.getAnchor("getDaycount"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  	 </td>
   </tr>

   <tr>
    <td><%=r.getString(teasession._nLanguage, "Airways")%>:<!--航空公司--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getAirways" value="checkbox"  <%=getCheck(ld.getIstype("getAirways"))%>><%=r.getString(teasession._nLanguage, "Show")%>
     	<%=r.getString(teasession._nLanguage, "Before")%><input name="getAirways_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getAirways"))%>" type="text">
     	 <%=r.getString(teasession._nLanguage, "After")%><input name="getAirways_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getAirways"))%>" type="text">
      	 <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getAirways_3" class="edit_input" type="text" value="<%=ld.getSequence("getAirways")%>" maxlength="3" size="4">
    	<input  id=CHECKBOX type="CHECKBOX" name="getAirways_4"  <%=getCheck(ld.getAnchor("getAirways"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  	 </td>
   </tr>

   <tr>
    <td><%=r.getString(teasession._nLanguage, "Keywords")%>:<!--关键字--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getKeywords" value="checkbox"  <%=getCheck(ld.getIstype("getKeywords"))%>><%=r.getString(teasession._nLanguage, "Show")%>
     	<%=r.getString(teasession._nLanguage, "Before")%><input name="getKeywords_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getKeywords"))%>" type="text">
     	 <%=r.getString(teasession._nLanguage, "After")%><input name="getKeywords_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getKeywords"))%>" type="text">
      	 <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getKeywords_3" class="edit_input" type="text" value="<%=ld.getSequence("getKeywords")%>" maxlength="3" size="4">
    	<input  id=CHECKBOX type="CHECKBOX" name="getKeywords_4"  <%=getCheck(ld.getAnchor("getKeywords"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  	 </td>
   </tr>






   <tr>
    <td><%=r.getString(teasession._nLanguage, "Priceexplain")%>:<!--价格说明--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getPriceexplain" value="checkbox"  <%=getCheck(ld.getIstype("getPriceexplain"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getPriceexplain_1"  class="edit_input"   mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPriceexplain"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="getPriceexplain_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPriceexplain"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPriceexplain_3" class="edit_input" type="text" value="<%=ld.getSequence("getPriceexplain")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="getPriceexplain_4"  <%=getCheck(ld.getAnchor("getPriceexplain"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getPriceexplain_5" class="edit_input" type="text" value="<%=ld.getQuantity("getPriceexplain")%>" maxlength="3" size="4">
  </td></tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "Priceinclude")%>:<!--报价包含--></td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getPriceinclude" value="checkbox"  <%=getCheck(ld.getIstype("getPriceinclude"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getPriceinclude_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPriceinclude"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="getPriceinclude_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPriceinclude"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPriceinclude_3" class="edit_input" type="text" value="<%=ld.getSequence("getPriceinclude")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="getPriceinclude_4"  <%=getCheck(ld.getAnchor("getPriceinclude"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getPriceinclude_5" class="edit_input" type="text" value="<%=ld.getQuantity("getPriceinclude")%>" maxlength="3" size="4">
  </td></tr>
<tr>
    <td><%=r.getString(teasession._nLanguage, "Pricenone")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getPricenone" value="checkbox"  <%=getCheck(ld.getIstype("getPricenone"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getPricenone_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPricenone"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="getPricenone_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPricenone"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPricenone_3" class="edit_input" type="text" value="<%=ld.getSequence("getPricenone")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="getPricenone_4"  <%=getCheck(ld.getAnchor("getPricenone"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getPricenone_5" class="edit_input" type="text" value="<%=ld.getQuantity("getPricenone")%>" maxlength="3" size="4">
  </td></tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "Routing")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getRouting" value="checkbox"  <%=getCheck(ld.getIstype("getRouting"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getRouting_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getRouting"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="getRouting_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getRouting"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getRouting_3" class="edit_input" type="text" value="<%=ld.getSequence("getRouting")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getRouting_4"  <%=getCheck(ld.getAnchor("getRouting"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Service")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getService" value="checkbox"  <%=getCheck(ld.getIstype("getService"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getService_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getService"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="getService_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getService"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getService_3" class="edit_input" type="text" value="<%=ld.getSequence("getService")%>" maxlength="3" size="4">
    <!--input  id=CHECKBOX type="CHECKBOX" name="getService_4"  <%=getCheck(ld.getAnchor("getService"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> -->
 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getService_5" class="edit_input" type="text" value="<%=ld.getQuantity("getService")%>" maxlength="3" size="4">
  </td></tr>


  <tr>
    <td><%=r.getString(teasession._nLanguage, "Explain")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getExplain" value="checkbox"  <%=getCheck(ld.getIstype("getExplain"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getExplain_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getExplain"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="getExplain_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getExplain"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getExplain_3" class="edit_input" type="text" value="<%=ld.getSequence("getExplain")%>" maxlength="3" size="4">
    <!--input  id=CHECKBOX type="CHECKBOX" name="getExplain_4"  <%=getCheck(ld.getAnchor("getExplain"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> -->
 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getExplain_5" class="edit_input" type="text" value="<%=ld.getQuantity("getExplain")%>" maxlength="3" size="4">
  </td></tr>


    <tr>
    <td><%=r.getString(teasession._nLanguage, "Hostel")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getHostelToString" value="checkbox"  <%=getCheck(ld.getIstype("getHostelToString"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getHostelToString_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getHostelToString"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="getHostelToString_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getHostelToString"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getHostelToString_3" class="edit_input" type="text" value="<%=ld.getSequence("getHostelToString")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getHostelToString_4"  <%=getCheck(ld.getAnchor("getHostelToString"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getHostelToString_5" class="edit_input" type="text" value="<%=ld.getQuantity("getHostelToString")%>" maxlength="3" size="4">
  </td></tr>
      <tr>
    <td><%=r.getString(teasession._nLanguage, "Flight")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getFlightToString" value="checkbox"  <%=getCheck(ld.getIstype("getFlightToString"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getFlightToString_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFlightToString"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="getFlightToString_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFlightToString"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFlightToString_3" class="edit_input" type="text" value="<%=ld.getSequence("getFlightToString")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getFlightToString_4"  <%=getCheck(ld.getAnchor("getFlightToString"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getFlightToString_5" class="edit_input" type="text" value="<%=ld.getQuantity("getFlightToString")%>" maxlength="3" size="4">
  </td></tr>
        <tr>
    <td><%=r.getString(teasession._nLanguage, "Principal")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getPrincipal" value="checkbox"  <%=getCheck(ld.getIstype("getPrincipal"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getPrincipal_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPrincipal"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="getPrincipal_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPrincipal"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPrincipal_3" class="edit_input" type="text" value="<%=ld.getSequence("getPrincipal")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getPrincipal_4"  <%=getCheck(ld.getAnchor("getPrincipal"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getPrincipal_5" class="edit_input" type="text" value="<%=ld.getQuantity("getPrincipal")%>" maxlength="3" size="4">
  </td></tr>
          <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getPicture" value="checkbox"  <%=getCheck(ld.getIstype("getPicture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getPicture_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPicture"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="getPicture_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPicture"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPicture_3" class="edit_input" type="text" value="<%=ld.getSequence("getPicture")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getPicture_4"  <%=getCheck(ld.getAnchor("getPicture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  </td></tr>

  <tr>
    <td>大<%=r.getString(teasession._nLanguage, "Picture")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getPicture1" value="checkbox"  <%=getCheck(ld.getIstype("getPicture1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getPicture1_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPicture1"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="getPicture1_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPicture1"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPicture1_3" class="edit_input" type="text" value="<%=ld.getSequence("getPicture1")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="getPicture1_4"  <%=getCheck(ld.getAnchor("getPicture1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  </td></tr>


      <tr>
    <td><%=r.getString(teasession._nLanguage, "Buybutton")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="getBuybutton" value="checkbox"  <%=getCheck(ld.getIstype("getBuybutton"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getBuybutton_1" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getBuybutton"))%>" type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="getBuybutton_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("getBuybutton"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getBuybutton_3" class="edit_input" type="text" value="<%=ld.getSequence("getBuybutton")%>" maxlength="3" size="4">
    <!--input  id=CHECKBOX type="CHECKBOX" name="getBuybutton_4"  <%=getCheck(ld.getAnchor("getBuybutton"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> -->
 <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getBuybutton_5" class="edit_input" type="text" value="<%=ld.getQuantity("getBuybutton")%>" maxlength="3" size="4">
  </td></tr>
</table>



<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
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

 <SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.getSubject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

