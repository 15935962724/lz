<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/node/type/stock/EditStock");
int listing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(listing).getNode();
if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(listing,15,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "StockDetail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
  <input type='hidden' name="node" value="<%=iNode%>">
  <input type="hidden" name="ListingType" value="15"/>
  <%if(!flag){%>
  <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
  <%        }else{%>
  <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
  <%   }%>
  <input type="hidden" name="Listing" value="<%=listing%>"/>
  <TABLE border="0" cellspacing="0" cellpadding="0" id="tablecenter">
    <TR>
      <td ><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TR>
      <td ><%=r.getString(teasession._nLanguage, "stock.code")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="code" value="checkbox"  <%=getCheck(ld.getIstype("code"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="code_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("code"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="code_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("code"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="code_3" type="text" class="edit_input" value="<%=ld.getSequence("code")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="code_4"   <%=getCheck(ld.getAnchor("code"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td ><%=r.getString(teasession._nLanguage, "CurrentPrice")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="price" value="checkbox"  <%=getCheck(ld.getIstype("price"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="price_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="price_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="price_3" type="text" class="edit_input" value="<%=ld.getSequence("price")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="price_4"   <%=getCheck(ld.getAnchor("price"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td ><%=r.getString(teasession._nLanguage, "Date")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="date" value="checkbox"  <%=getCheck(ld.getIstype("date"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="date_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("date"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="date_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("date"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="date_3" type="text" class="edit_input" value="<%=ld.getSequence("date")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="date_4"   <%=getCheck(ld.getAnchor("date"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td ><%=r.getString(teasession._nLanguage, "Previous<br>Closing")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="closing" value="checkbox"  <%=getCheck(ld.getIstype("closing"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="closing_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("closing"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="closing_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("closing"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="closing_3" type="text" class="edit_input" value="<%=ld.getSequence("closing")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="closing_4"   <%=getCheck(ld.getAnchor("closing"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td ><%=r.getString(teasession._nLanguage, "Opening<br>Price")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="opening" value="checkbox"  <%=getCheck(ld.getIstype("opening"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="opening_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("opening"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="opening_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("opening"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="opening_3" type="text" class="edit_input" value="<%=ld.getSequence("opening")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="opening_4"   <%=getCheck(ld.getAnchor("opening"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td ><%=r.getString(teasession._nLanguage, "High<br>price")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="high" value="checkbox"  <%=getCheck(ld.getIstype("high"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="high_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("high"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="high_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("high"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="high_3" type="text" class="edit_input" value="<%=ld.getSequence("high")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="high_4"   <%=getCheck(ld.getAnchor("high"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td ><%=r.getString(teasession._nLanguage, "Low<br>price")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="low" value="checkbox"  <%=getCheck(ld.getIstype("low"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="low_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("low"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="low_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("low"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="low_3" type="text" class="edit_input" value="<%=ld.getSequence("low")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="low_4"   <%=getCheck(ld.getAnchor("low"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td ><%=r.getString(teasession._nLanguage, "change")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="change" value="checkbox"  <%=getCheck(ld.getIstype("change"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="change_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("change"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="change_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("change"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="change_3" type="text" class="edit_input" value="<%=ld.getSequence("change")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="change_4"   <%=getCheck(ld.getAnchor("change"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr>
    <td ><%=r.getString(teasession._nLanguage, "Volume")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="volume" value="checkbox"  <%=getCheck(ld.getIstype("volume"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="volume_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("volume"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="volume_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("volume"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="volume_3" type="text" class="edit_input" value="<%=ld.getSequence("volume")%>" maxlength="3" size="4">
       </TD>
    </TR>
    <tr>
    <td ><%=r.getString(teasession._nLanguage, "Turnover")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="turnover" value="checkbox"  <%=getCheck(ld.getIstype("turnover"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="turnover_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("turnover"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="turnover_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("turnover"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="turnover_3" type="text" class="edit_input" value="<%=ld.getSequence("turnover")%>" maxlength="3" size="4">
       </TD>
    </TR>
    <tr>
    <td ><%=r.getString(teasession._nLanguage, "MarketValue")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="market" value="checkbox"  <%=getCheck(ld.getIstype("market"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="market_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("market"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="market_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("market"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="market_3" type="text" class="edit_input" value="<%=ld.getSequence("market")%>" maxlength="3" size="4">
       </TD>
    </TR>
    <tr>
    <td ><%=r.getString(teasession._nLanguage, "Amplitude")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="amplitude" value="checkbox"  <%=getCheck(ld.getIstype("amplitude"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="amplitude_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("amplitude"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="amplitude_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("amplitude"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="amplitude_3" type="text" class="edit_input" value="<%=ld.getSequence("amplitude")%>" maxlength="3" size="4">
       </TD>
    </TR>
    <tr>
    <td ><%=r.getString(teasession._nLanguage, "stock.pe")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="pe" value="checkbox"  <%=getCheck(ld.getIstype("pe"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="pe_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pe"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="pe_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pe"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="pe_3" type="text" class="edit_input" value="<%=ld.getSequence("pe")%>" maxlength="3" size="4">
       </TD>
    </TR>


    <tr><td colspan="3"><h2>A股</h2></td>
    <tr>
    <td ><%=r.getString(teasession._nLanguage, "Handover")%>:</TD>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="handover" value="checkbox"  <%=getCheck(ld.getIstype("handover"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="handover_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("handover"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="handover_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("handover"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="handover_3" type="text" class="edit_input" value="<%=ld.getSequence("handover")%>" maxlength="3" size="4">
       </td>
    </tr>
    <tr>
    <td ><%=r.getString(teasession._nLanguage, "DailyLimit")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="daily" value="checkbox"  <%=getCheck(ld.getIstype("daily"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="daily_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("daily"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="daily_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("daily"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="daily_3" type="text" class="edit_input" value="<%=ld.getSequence("daily")%>" maxlength="3" size="4">
       </TD>
    </TR>
    <tr>
    <td ><%=r.getString(teasession._nLanguage, "DownLimit")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="down" value="checkbox"  <%=getCheck(ld.getIstype("down"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="down_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("down"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="down_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("down"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="down_3" type="text" class="edit_input" value="<%=ld.getSequence("down")%>" maxlength="3" size="4">
       </TD>
    </TR>

    <tr><td colspan="3"><h2>H股</h2></td>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "周息率(%)")%>:</TD>
      <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="dividend" value="checkbox"  <%=getCheck(ld.getIstype("dividend"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="dividend_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("dividend"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="dividend_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("dividend"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="dividend_3" type="text" class="edit_input" value="<%=ld.getSequence("dividend")%>" maxlength="3" size="4">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "52周最高")%>:</TD>
      <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="h52w" value="checkbox"  <%=getCheck(ld.getIstype("h52w"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="h52w_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("h52w"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="h52w_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("h52w"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="h52w_3" type="text" class="edit_input" value="<%=ld.getSequence("h52w")%>" maxlength="3" size="4">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "52周最低")%>:</TD>
      <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="l52w" value="checkbox"  <%=getCheck(ld.getIstype("l52w"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="l52w_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("l52w"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="l52w_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("l52w"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="l52w_3" type="text" class="edit_input" value="<%=ld.getSequence("l52w")%>" maxlength="3" size="4">
      </td>
    </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage, "GraphHour")%>:</TD>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="graphhour" value="checkbox"  <%=getCheck(ld.getIstype("graphhour"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="graphhour_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("graphhour"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="graphhour_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("graphhour"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="graphhour_3" type="text" class="edit_input" value="<%=ld.getSequence("graphhour")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="graphhour_4"   <%=getCheck(ld.getAnchor("graphhour"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </tr>
    <tr>
      <td ><%=r.getString(teasession._nLanguage, "GraphDay")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="graphday" value="checkbox"  <%=getCheck(ld.getIstype("graphday"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="graphday_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("graphday"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="graphday_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("graphday"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="graphday_3" type="text" class="edit_input" value="<%=ld.getSequence("graphday")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="graphday_4"   <%=getCheck(ld.getAnchor("graphday"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr>
      <td ><%=r.getString(teasession._nLanguage, "GraphWeek")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="graphweek" value="checkbox"  <%=getCheck(ld.getIstype("graphweek"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="graphweek_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("graphweek"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="graphweek_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("graphweek"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="graphweek_3" type="text" class="edit_input" value="<%=ld.getSequence("graphweek")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="graphweek_4"   <%=getCheck(ld.getAnchor("graphweek"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr>
      <td ><%=r.getString(teasession._nLanguage, "GraphMonth")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="graphmonth" value="checkbox"  <%=getCheck(ld.getIstype("graphmonth"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="graphmonth_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("graphmonth"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="graphmonth_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("graphmonth"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="graphmonth_3" type="text" class="edit_input" value="<%=ld.getSequence("graphmonth")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="graphmonth_4"   <%=getCheck(ld.getAnchor("graphmonth"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
<%--
    <tr>
      <td ><%=r.getString(teasession._nLanguage, "GraphYear")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="graphyear" value="checkbox"  <%=getCheck(ld.getIstype("graphyear"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="graphyear_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("graphyear"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="graphyear_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("graphyear"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="graphyear_3" type="text" class="edit_input" value="<%=ld.getSequence("graphyear")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="graphyear_4"   <%=getCheck(ld.getAnchor("graphyear"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr>
      <td ><%=r.getString(teasession._nLanguage, "GraphYet")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="graphyet" value="checkbox"  <%=getCheck(ld.getIstype("graphyet"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="graphyet_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("graphyet"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="graphyet_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("graphyet"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="graphyet_3" type="text" class="edit_input" value="<%=ld.getSequence("graphyet")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="graphyet_4"   <%=getCheck(ld.getAnchor("graphyet"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
--%>
    <tr>
      <td ><%=r.getString(teasession._nLanguage, "stock.handicap")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="handicap" value="checkbox"  <%=getCheck(ld.getIstype("handicap"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="handicap_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("handicap"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="handicap_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("handicap"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="handicap_3" type="text" class="edit_input" value="<%=ld.getSequence("handicap")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="handicap_4"   <%=getCheck(ld.getAnchor("handicap"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>

    <tr>
      <td ><%=r.getString(teasession._nLanguage, "Search")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="search" value="checkbox"  <%=getCheck(ld.getIstype("search"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="search_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("search"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="search_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("search"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="search_3" type="text" class="edit_input" value="<%=ld.getSequence("search")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="search_4"   <%=getCheck(ld.getAnchor("search"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
  </table>
  <center>
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </center>
</form>
<script>
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
</body>
</html>

