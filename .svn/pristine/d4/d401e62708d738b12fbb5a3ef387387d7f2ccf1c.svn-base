<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

            //DropDown dropdown = new DropDown("Format", book.getFormat());

ListingDetail ld=ListingDetail.find(iListing,110,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
 <h1><%=r.getString(teasession._nLanguage, "Detail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
<input type='hidden' name="Node" value="<%=iNode%>">
<input type="hidden" name="ListingType" value="110"/>
<%if(!flag){%>
<input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
<input type="hidden" name="Listing" value="<%=iListing%>"/>
  <INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">
  <TABLE  CELLSPACING=0 CELLPADDING=0 border="0" id="tablecenter">
    <TR>
      <Td><%=r.getString(teasession._nLanguage, "Subject")%>:</Td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <Td><%=r.getString(teasession._nLanguage, "发行机构")%>:</Td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="companyName" value="checkbox"  <%=getCheck(ld.getIstype("companyName"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="companyName_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("companyName"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="companyName_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("companyName"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="companyName_3" type="text" class="edit_input" value="<%=ld.getSequence("companyName")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="companyName_4"   <%=getCheck(ld.getAnchor("companyName"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="companyName_5" class="edit_input" type="text" value="<%=ld.getQuantity("companyName")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <Td><%=r.getString(teasession._nLanguage, "发行时间")%>:</Td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="releaseTime" value="checkbox"  <%=getCheck(ld.getIstype("releaseTime"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="releaseTime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("releaseTime"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="releaseTime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("releaseTime"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="releaseTime_3" type="text" class="edit_input" value="<%=ld.getSequence("releaseTime")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="releaseTime_4"   <%=getCheck(ld.getAnchor("releaseTime"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="releaseTime_5" class="edit_input" type="text" value="<%=ld.getQuantity("releaseTime")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <Td><%=r.getString(teasession._nLanguage, "发行地区")%>:</Td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="city" value="checkbox"  <%=getCheck(ld.getIstype("city"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="city_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("city"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="city_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("city"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="city_3" type="text" class="edit_input" value="<%=ld.getSequence("city")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="city_4"   <%=getCheck(ld.getAnchor("city"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="city_5" class="edit_input" type="text" value="<%=ld.getQuantity("city")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "产品期限")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="timeLimit" value="checkbox"  <%=getCheck(ld.getIstype("timeLimit"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="timeLimit_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("timeLimit"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="timeLimit_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("timeLimit"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="timeLimit_3" type="text" class="edit_input" value="<%=ld.getSequence("timeLimit")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="timeLimit_4"   <%=getCheck(ld.getAnchor("timeLimit"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="timeLimit_5" class="edit_input" type="text" value="<%=ld.getQuantity("timeLimit")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "投资规模")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="sizeOf" value="checkbox"  <%=getCheck(ld.getIstype("sizeOf"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="sizeOf_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sizeOf"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="sizeOf_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sizeOf"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="sizeOf_3" type="text" class="edit_input" value="<%=ld.getSequence("sizeOf")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="sizeOf_4"   <%=getCheck(ld.getAnchor("sizeOf"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="sizeOf_5" class="edit_input" type="text" value="<%=ld.getQuantity("sizeOf")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "投资门槛")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="threshold" value="checkbox"  <%=getCheck(ld.getIstype("threshold"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="threshold_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("threshold"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="threshold_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("threshold"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="threshold_3" type="text" class="edit_input" value="<%=ld.getSequence("threshold")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="threshold_4"   <%=getCheck(ld.getAnchor("threshold"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="threshold_5" class="edit_input" type="text" value="<%=ld.getQuantity("threshold")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "预期年化收入")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="income" value="checkbox"  <%=getCheck(ld.getIstype("income"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="income_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("income"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="income_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("income"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="income_3" type="text" class="edit_input" value="<%=ld.getSequence("income")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="income_4"   <%=getCheck(ld.getAnchor("income"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="income_5" class="edit_input" type="text" value="<%=ld.getQuantity("income")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "资金投向")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="field" value="checkbox"  <%=getCheck(ld.getIstype("field"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="field_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("field"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="field_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("field"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="field_3" type="text" class="edit_input" value="<%=ld.getSequence("field")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="field_4"   <%=getCheck(ld.getAnchor("field"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="field_5" class="edit_input" type="text" value="<%=ld.getQuantity("field")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "投资方式")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="investmentWay" value="checkbox"  <%=getCheck(ld.getIstype("investmentWay"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="investmentWay_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("investmentWay"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="investmentWay_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("investmentWay"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="investmentWay_3" type="text" class="edit_input" value="<%=ld.getSequence("investmentWay")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="investmentWay_4"   <%=getCheck(ld.getAnchor("investmentWay"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="investmentWay_5" class="edit_input" type="text" value="<%=ld.getQuantity("investmentWay")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "收效分配")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="distribution" value="checkbox"  <%=getCheck(ld.getIstype("distribution"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="distribution_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("distribution"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="distribution_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("distribution"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="distribution_3" type="text" class="edit_input" value="<%=ld.getSequence("distribution")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="distribution_4"   <%=getCheck(ld.getAnchor("distribution"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="distribution_5" class="edit_input" type="text" value="<%=ld.getQuantity("distribution")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "监管机构")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="regulatory" value="checkbox"  <%=getCheck(ld.getIstype("regulatory"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="regulatory_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("regulatory"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="regulatory_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("regulatory"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="regulatory_3" type="text" class="edit_input" value="<%=ld.getSequence("regulatory")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="regulatory_4"   <%=getCheck(ld.getAnchor("regulatory"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="regulatory_5" class="edit_input" type="text" value="<%=ld.getQuantity("regulatory")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "托管银行")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="bankName" value="checkbox"  <%=getCheck(ld.getIstype("bankName"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="bankName_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bankName"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="bankName_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bankName"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="bankName_3" type="text" class="edit_input" value="<%=ld.getSequence("bankName")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="bankName_4"   <%=getCheck(ld.getAnchor("bankName"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="bankName_5" class="edit_input" type="text" value="<%=ld.getQuantity("bankName")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "银行账户")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="bankNum" value="checkbox"  <%=getCheck(ld.getIstype("bankNum"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="bankNum_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bankNum"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="bankNum_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bankNum"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="bankNum_3" type="text" class="edit_input" value="<%=ld.getSequence("bankNum")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="bankNum_4"   <%=getCheck(ld.getAnchor("bankNum"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="bankNum_5" class="edit_input" type="text" value="<%=ld.getQuantity("bankNum")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "收益详情")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="earnings" value="checkbox"  <%=getCheck(ld.getIstype("earnings"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="earnings_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("earnings"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="earnings_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("earnings"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="earnings_3" type="text" class="edit_input" value="<%=ld.getSequence("earnings")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="earnings_4"   <%=getCheck(ld.getAnchor("earnings"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="earnings_5" class="edit_input" type="text" value="<%=ld.getQuantity("earnings")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "产品类型")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="type" value="checkbox"  <%=getCheck(ld.getIstype("type"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="type_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("type"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="type_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("type"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="type_3" type="text" class="edit_input" value="<%=ld.getSequence("type")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="type_4"   <%=getCheck(ld.getAnchor("type"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="type_5" class="edit_input" type="text" value="<%=ld.getQuantity("type")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "产品状态")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="state" value="checkbox"  <%=getCheck(ld.getIstype("state"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="state_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("state"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="state_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("state"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="state_3" type="text" class="edit_input" value="<%=ld.getSequence("state")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="state_4"   <%=getCheck(ld.getAnchor("state"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="state_5" class="edit_input" type="text" value="<%=ld.getQuantity("state")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "收益类型")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="earningsType" value="checkbox"  <%=getCheck(ld.getIstype("earningsType"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="earningsType_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("earningsType"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="earningsType_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("earningsType"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="earningsType_3" type="text" class="edit_input" value="<%=ld.getSequence("earningsType")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="earningsType_4"   <%=getCheck(ld.getAnchor("earningsType"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="earningsType_5" class="edit_input" type="text" value="<%=ld.getQuantity("earningsType")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "资金用途")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="maneyUse" value="checkbox"  <%=getCheck(ld.getIstype("maneyUse"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="maneyUse_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("maneyUse"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="maneyUse_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("maneyUse"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="maneyUse_3" type="text" class="edit_input" value="<%=ld.getSequence("maneyUse")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="maneyUse_4"   <%=getCheck(ld.getAnchor("maneyUse"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="maneyUse_5" class="edit_input" type="text" value="<%=ld.getQuantity("maneyUse")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "风控措施")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="measures" value="checkbox"  <%=getCheck(ld.getIstype("measures"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="measures_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("measures"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="measures_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("measures"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="measures_3" type="text" class="edit_input" value="<%=ld.getSequence("measures")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="measures_4"   <%=getCheck(ld.getAnchor("measures"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="measures_5" class="edit_input" type="text" value="<%=ld.getQuantity("measures")%>" maxlength="3" size="4"> </TD>
    </TR>
    
  </TABLE>
  <INPUT TYPE=SUBMIT NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
  <INPUT TYPE=SUBMIT NAME="GoFinish" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
</FORM>
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
<SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.subject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body></html>

