<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/resource/Meeting");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
	response.sendError(403);
	return;
}

boolean flag=request.getParameter("PickNode")==null;


ListingDetail ld=ListingDetail.find(iListing,114,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Meeting")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv">
<%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="114"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议名称")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" type="text" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="name_4"   <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议副标题")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="subtitle" value="checkbox"  <%=getCheck(ld.getIstype("subtitle"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="subtitle_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subtitle"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="subtitle_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subtitle"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subtitle_3" type="text" value="<%=ld.getSequence("subtitle")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="subtitle_4"   <%=getCheck(ld.getAnchor("subtitle"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>


   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "导语")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="lead" value="checkbox"  <%=getCheck(ld.getIstype("lead"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="lead_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("lead"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="lead_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("lead"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="lead_3" type="text" value="<%=ld.getSequence("lead")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="lead_4"   <%=getCheck(ld.getAnchor("lead"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>
  
    <tr >
    <td align="right"><%=r.getString(teasession._nLanguage, "报名开始时间")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="rstarttime" value="checkbox"  <%=getCheck(ld.getIstype("rstarttime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="rstarttime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("rstarttime"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="rstarttime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("rstarttime"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="rstarttime_3" type="text" value="<%=ld.getSequence("rstarttime")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="rstarttime_4"   <%=getCheck(ld.getAnchor("time"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  
  <tr >
    <td align="right"><%=r.getString(teasession._nLanguage, "报名结束时间")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="rstoptime" value="checkbox"  <%=getCheck(ld.getIstype("rstoptime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="rstoptime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("rstoptime"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="rstoptime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("rstoptime"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="rstoptime_3" type="text" value="<%=ld.getSequence("rstoptime")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="rstoptime_4"   <%=getCheck(ld.getAnchor("time"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议开始时间")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="time" value="checkbox"  <%=getCheck(ld.getIstype("time"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="time_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("time"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="time_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("time"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="time_3" type="text" value="<%=ld.getSequence("time")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="time_4"   <%=getCheck(ld.getAnchor("time"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr >
    <td align="right"><%=r.getString(teasession._nLanguage, "会议结束时间")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="TimeStop" value="checkbox"  <%=getCheck(ld.getIstype("TimeStop"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="TimeStop_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("TimeStop"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="TimeStop_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("TimeStop"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="TimeStop_3" type="text" value="<%=ld.getSequence("TimeStop")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="TimeStop_4"   <%=getCheck(ld.getAnchor("time"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议举行时间")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="hold" value="checkbox"  <%=getCheck(ld.getIstype("hold"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="hold_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("hold"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="hold_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("hold"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="hold_3" type="text" value="<%=ld.getSequence("hold")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="hold_4"   <%=getCheck(ld.getAnchor("hold"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议省")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="province" value="checkbox"  <%=getCheck(ld.getIstype("province"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="province_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("province"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="province_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("province"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="province_3" type="text" value="<%=ld.getSequence("province")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="province_4"   <%=getCheck(ld.getAnchor("province"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>

   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议市")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="city2" value="checkbox"  <%=getCheck(ld.getIstype("city2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="city2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("city2"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="city2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("city2"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="city2_3" type="text" value="<%=ld.getSequence("city2")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="city2_4"   <%=getCheck(ld.getAnchor("city2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>

   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议详细地址")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="address" value="checkbox"  <%=getCheck(ld.getIstype("address"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="address_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("address"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="address_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("address"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="address_3" type="text" value="<%=ld.getSequence("address")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="address_4"   <%=getCheck(ld.getAnchor("address"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>


 <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议类别")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="eventtype" value="checkbox"  <%=getCheck(ld.getIstype("eventtype"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="eventtype_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("eventtype"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="eventtype_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("eventtype"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="eventtype_3" type="text" value="<%=ld.getSequence("eventtype")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="eventtype_4"   <%=getCheck(ld.getAnchor("eventtype"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议积分")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="integral" value="checkbox"  <%=getCheck(ld.getIstype("integral"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="integral_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("integral"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="integral_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("integral"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="integral_3" type="text" value="<%=ld.getSequence("integral")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="integral_4"   <%=getCheck(ld.getAnchor("integral"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>
 <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "特殊规定(参会资格)")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="prescribe" value="checkbox"  <%=getCheck(ld.getIstype("prescribe"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="prescribe_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("prescribe"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="prescribe_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("prescribe"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="prescribe_3" type="text" value="<%=ld.getSequence("prescribe")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="prescribe_4"   <%=getCheck(ld.getAnchor("prescribe"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "内容简介(node)")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="content" value="checkbox"  <%=getCheck(ld.getIstype("content"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="content_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("content"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="content_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("content"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="content_3" type="text" value="<%=ld.getSequence("content")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="content_4"   <%=getCheck(ld.getAnchor("content"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "议题")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="issue" value="checkbox"  <%=getCheck(ld.getIstype("issue"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="issue_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("issue"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="issue_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("issue"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="issue_3" type="text" value="<%=ld.getSequence("issue")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="issue_4"   <%=getCheck(ld.getAnchor("issue"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>

<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "介绍图片(大图)")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="introPicture" value="checkbox"  <%=getCheck(ld.getIstype("introPicture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="introPicture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("introPicture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="introPicture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("introPicture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="introPicture_3" type="text" value="<%=ld.getSequence("introPicture")%>" maxlength="3" size="4">
    <select name="introPicture_4">
      <option value="0"><%=r.getString(teasession._nLanguage, "None")%></option>
      <option <%=getSelect(ld.getAnchor("introPicture")==1)%> value="1"><%=r.getString(teasession._nLanguage, "Node")%></option>
      <option <%=getSelect(ld.getAnchor("introPicture")==3)%> value="3"><%=r.getString(teasession._nLanguage, "BigPicture")%></option>
    </select>
        </td>
  </tr>

 <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "小图")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="smallPicture" value="checkbox"  <%=getCheck(ld.getIstype("smallPicture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="smallPicture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("smallPicture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="smallPicture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("smallPicture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="smallPicture_3" type="text" value="<%=ld.getSequence("smallPicture")%>" maxlength="3" size="4">
    <select name="smallPicture_4">
      <option value="0"><%=r.getString(teasession._nLanguage, "None")%></option>
      <option <%=getSelect(ld.getAnchor("smallPicture")==1)%> value="1"><%=r.getString(teasession._nLanguage, "Node")%></option>
      <option <%=getSelect(ld.getAnchor("smallPicture")==2)%> value="2"><%=r.getString(teasession._nLanguage, "IntroPicture")%></option>
      <option <%=getSelect(ld.getAnchor("smallPicture")==3)%> value="3"><%=r.getString(teasession._nLanguage, "BigPicture")%></option>
    </select>
</td>
  </tr>

   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "组织者所属公司(组织单位 )")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="corp" value="checkbox"  <%=getCheck(ld.getIstype("corp"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="corp_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("corp"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="corp_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("corp"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="corp_3" type="text" value="<%=ld.getSequence("corp")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="corp_4"   <%=getCheck(ld.getAnchor("corp"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>




  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "举行会议夜店名称")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="nightShop" value="checkbox"  <%=getCheck(ld.getIstype("nightShop"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="nightShop_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("nightShop"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="nightShop_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("nightShop"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="nightShop_3" type="text" value="<%=ld.getSequence("nightShop")%>" maxlength="3" size="4">
    <select name="nightShop_4">
      <option value="0"><%=r.getString(teasession._nLanguage, "None")%></option>
      <option <%=getSelect(ld.getAnchor("nightShop")==1)%> value="1"><%=r.getString(teasession._nLanguage, "Node")%></option>
      <option <%=getSelect(ld.getAnchor("nightShop")==4)%> value="4">链接到夜店</option>
    </select>
        </td>
  </tr>

   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "组织人(负责人)")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="organise" value="checkbox"  <%=getCheck(ld.getIstype("organise"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="organise_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("organise"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="organise_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("organise"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="organise_3" type="text" value="<%=ld.getSequence("organise")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="organise_4"   <%=getCheck(ld.getAnchor("organise"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "组织者联系方式(联系电话)")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="linkman" value="checkbox"  <%=getCheck(ld.getIstype("linkman"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="linkman_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("linkman"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="linkman_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("linkman"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="linkman_3" type="text" value="<%=ld.getSequence("linkman")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="linkman_4"   <%=getCheck(ld.getAnchor("linkman"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "门票价格(会议预算)")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="carfare" value="checkbox"  <%=getCheck(ld.getIstype("carfare"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="carfare_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("carfare"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="carfare_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("carfare"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="carfare_3" type="text" value="<%=ld.getSequence("carfare")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="carfare_4"   <%=getCheck(ld.getAnchor("carfare"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "特色(参会个人需缴纳的费用)")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="feature" value="checkbox"  <%=getCheck(ld.getIstype("feature"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="feature_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("feature"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="feature_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("feature"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="feature_3" type="text" value="<%=ld.getSequence("feature")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="feature_4"   <%=getCheck(ld.getAnchor("feature"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "是否安排餐饮")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="catering" value="checkbox"  <%=getCheck(ld.getIstype("catering"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="catering_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("catering"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="catering_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("catering"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="catering_3" type="text" value="<%=ld.getSequence("catering")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="catering_4"   <%=getCheck(ld.getAnchor("catering"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "是否安排住宿")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="stay" value="checkbox"  <%=getCheck(ld.getIstype("stay"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="stay_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("stay"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="stay_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("stay"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="stay_3" type="text" value="<%=ld.getSequence("stay")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="stay_4"   <%=getCheck(ld.getAnchor("stay"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

      <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "是否安排接送")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="shuttle" value="checkbox"  <%=getCheck(ld.getIstype("shuttle"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="shuttle_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("shuttle"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="shuttle_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("shuttle"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="shuttle_3" type="text" value="<%=ld.getSequence("shuttle")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="shuttle_4"   <%=getCheck(ld.getAnchor("shuttle"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

     <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "地图")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="map" value="checkbox"  <%=getCheck(ld.getIstype("map"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="map_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("map"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="map_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("map"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="map_3" type="text" value="<%=ld.getSequence("map")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="map_4"   <%=getCheck(ld.getAnchor("map"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "报名状态")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="auditstatus" value="checkbox"  <%=getCheck(ld.getIstype("auditstatus"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="auditstatus_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("auditstatus"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="auditstatus_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("auditstatus"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="auditstatus_3" type="text" value="<%=ld.getSequence("auditstatus")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="auditstatus_4"   <%=getCheck(ld.getAnchor("auditstatus"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "我要报名(需要登录)")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="audit" value="checkbox"  <%=getCheck(ld.getIstype("audit"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="audit_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("audit"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="audit_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("audit"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="audit_3" type="text" value="<%=ld.getSequence("audit")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="audit_4"   <%=getCheck(ld.getAnchor("audit"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
<%-- <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "我要报名(无需登陆)")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="audit1" value="checkbox"  <%=getCheck(ld.getIstype("audit1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="audit1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("audit1"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="audit1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("audit1"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="audit1_3" type="text" value="<%=ld.getSequence("audit1")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="audit1_4"   <%=getCheck(ld.getAnchor("audit1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr> --%>



    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议评价")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="score" value="checkbox"  <%=getCheck(ld.getIstype("score"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="score_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("score"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="score_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("score"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="score_3" type="text" value="<%=ld.getSequence("score")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="score_4"   <%=getCheck(ld.getAnchor("score"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

    <tr><td colspan="2"><hr size="1"></td></tr>


    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议关联组图")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="album" value="checkbox"  <%=getCheck(ld.getIstype("album"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="album_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("album"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="album_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("album"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="album_3" type="text" value="<%=ld.getSequence("album")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="album_4"   <%=getCheck(ld.getAnchor("album"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议关联组图主题")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="album_subject" value="checkbox"  <%=getCheck(ld.getIstype("album_subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="album_subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("album_subject"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="album_subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("album_subject"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="album_subject_3" type="text" value="<%=ld.getSequence("album_subject")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="album_subject_4"   <%=getCheck(ld.getAnchor("album_subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议关联组图内容")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="album_text" value="checkbox"  <%=getCheck(ld.getIstype("album_text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="album_text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("album_text"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="album_text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("album_text"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="album_text_3" type="text" value="<%=ld.getSequence("album_text")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="album_text_4"   <%=getCheck(ld.getAnchor("album_text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


      <tr><td colspan="2"><hr size="1"></td></tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "会议要求")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="request" value="checkbox"  <%=getCheck(ld.getIstype("request"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="request_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("request"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="request_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("request"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="request_3" type="text" value="<%=ld.getSequence("request")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="request_4"   <%=getCheck(ld.getAnchor("request"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
 <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "简介")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="synopsis" value="checkbox"  <%=getCheck(ld.getIstype("synopsis"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="synopsis_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("synopsis"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="synopsis_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("synopsis"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="synopsis_3" type="text" value="<%=ld.getSequence("synopsis")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="synopsis_4"   <%=getCheck(ld.getAnchor("synopsis"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>


  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "介绍")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="intro" value="checkbox"  <%=getCheck(ld.getIstype("intro"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="intro_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("intro"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="intro_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("intro"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="intro_3" type="text" value="<%=ld.getSequence("intro")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="intro_4"   <%=getCheck(ld.getAnchor("intro"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>








  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "BigPicture")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="bigPicture" value="checkbox"  <%=getCheck(ld.getIstype("bigPicture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="bigPicture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bigPicture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="bigPicture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bigPicture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="bigPicture_3" type="text" value="<%=ld.getSequence("bigPicture")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="bigPicture_4"   <%=getCheck(ld.getAnchor("bigPicture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "flyer资料")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="flyerData" value="checkbox"  <%=getCheck(ld.getIstype("flyerData"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="flyerData_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("flyerData"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="flyerData_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("flyerData"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="flyerData_3" type="text" value="<%=ld.getSequence("flyerData")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="flyerData_4"   <%=getCheck(ld.getAnchor("flyerData"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
<%--
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="Picture" value="checkbox"  <%=getCheck(ld.getIstype("Picture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="Picture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Picture"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="Picture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Picture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Picture_3" type="text" value="<%=ld.getSequence("Picture")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="Picture_4"   <%=getCheck(ld.getAnchor("Picture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "PictureName")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="PictureName" value="checkbox"  <%=getCheck(ld.getIstype("PictureName"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="PictureName_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("PictureName"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="PictureName_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("PictureName"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="PictureName_3" type="text" value="<%=ld.getSequence("PictureName")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="PictureName_4"   <%=getCheck(ld.getAnchor("PictureName"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  --%>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "IssueTime")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="issueTime"    <%=getCheck(ld.getIstype("issueTime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="issueTime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("issueTime"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="issueTime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("issueTime"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="issueTime_3" type="text" value="<%=ld.getSequence("issueTime")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="issueTime_4"   <%=getCheck(ld.getAnchor("issueTime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "分类")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="sort"    <%=getCheck(ld.getIstype("sort"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="sort_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sort"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="sort_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sort"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="sort_3" type="text" value="<%=ld.getSequence("sort")%>" maxlength="3" size="4">
    <input  id=CHECKBOX type="CHECKBOX" name="sort_4"   <%=getCheck(ld.getAnchor("sort"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr><td colspan="2"><hr size="1"></td></tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "现场图片")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="TPicture" value="checkbox"  <%=getCheck(ld.getIstype("TPicture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="TPicture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("TPicture"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="TPicture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("TPicture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="TPicture_3" type="text" value="<%=ld.getSequence("TPicture")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="TPicture_4"   <%=getCheck(ld.getAnchor("TPicture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <%--
  <tr>
    <td><%=r.getString(teasession._nLanguage, "TPictureName")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="TPictureName" value="checkbox"  <%=getCheck(ld.getIstype("TPictureName"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="TPictureName_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("TPictureName"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="TPictureName_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("TPictureName"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="TPictureName_3" type="text" value="<%=ld.getSequence("TPictureName")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="TPictureName_4"   <%=getCheck(ld.getAnchor("TPictureName"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  --%>
</table>
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>
 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
