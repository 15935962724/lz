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

ListingDetail ld=ListingDetail.find(iListing,12,teasession._nLanguage);

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
<input type="hidden" name="ListingType" value="12"/>
<%if(!flag){%>
<input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
<input type="hidden" name="Listing" value="<%=iListing%>"/>
<FORM NAME=foEdit METHOD=POST action="/servlet/EditBook" onSubmit="return(submitText(this.ISBN, '<%=r.getString(teasession._nLanguage, "InvalidISBN")%>')&&submitInteger(this.AmountWord, '<%=r.getString(teasession._nLanguage, "InvalidAmountWord")%>')&&submitInteger(this.AmountPage, '<%=r.getString(teasession._nLanguage, "InvalidAmountPage")%>')&&submitFloat(this.Price, '<%=r.getString(teasession._nLanguage, "InvalidPrice")%>')&&submitInteger(this.Reprint, '<%=r.getString(teasession._nLanguage, "InvalidReprint")%>')&&submitText(this.Publisher, '<%=r.getString(teasession._nLanguage, "InvalidPublisher")%>'));">
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
      <Td><%=r.getString(teasession._nLanguage, "ISBN")%>:</Td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="isbn" value="checkbox"  <%=getCheck(ld.getIstype("isbn"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="isbn_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("isbn"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="isbn_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("isbn"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="isbn_3" type="text" class="edit_input" value="<%=ld.getSequence("isbn")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="isbn_4"   <%=getCheck(ld.getAnchor("isbn"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="isbn_5" class="edit_input" type="text" value="<%=ld.getQuantity("isbn")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <Td><%=r.getString(teasession._nLanguage, "Format")%>:</Td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="format" value="checkbox"  <%=getCheck(ld.getIstype("format"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="format_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("format"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="format_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("format"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="format_3" type="text" class="edit_input" value="<%=ld.getSequence("format")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="format_4"   <%=getCheck(ld.getAnchor("format"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="format_5" class="edit_input" type="text" value="<%=ld.getQuantity("format")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <Td><%=r.getString(teasession._nLanguage, "Binding")%>:</Td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="binding" value="checkbox"  <%=getCheck(ld.getIstype("binding"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="binding_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("binding"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="binding_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("binding"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="binding_3" type="text" class="edit_input" value="<%=ld.getSequence("binding")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="binding_4"   <%=getCheck(ld.getAnchor("binding"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="binding_5" class="edit_input" type="text" value="<%=ld.getQuantity("binding")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "AmountWord")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="amountword" value="checkbox"  <%=getCheck(ld.getIstype("amountword"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="amountword_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("amountword"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="amountword_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("amountword"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="amountword_3" type="text" class="edit_input" value="<%=ld.getSequence("amountword")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="amountword_4"   <%=getCheck(ld.getAnchor("amountword"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="amountword_5" class="edit_input" type="text" value="<%=ld.getQuantity("amountword")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "AmountPage")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="amountpage" value="checkbox"  <%=getCheck(ld.getIstype("amountpage"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="amountpage_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("amountpage"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="amountpage_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("amountpage"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="amountpage_3" type="text" class="edit_input" value="<%=ld.getSequence("amountpage")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="amountpage_4"   <%=getCheck(ld.getAnchor("amountpage"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="amountpage_5" class="edit_input" type="text" value="<%=ld.getQuantity("amountpage")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Price")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="price" value="checkbox"  <%=getCheck(ld.getIstype("price"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="price_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="price_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="price_3" type="text" class="edit_input" value="<%=ld.getSequence("price")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="price_4"   <%=getCheck(ld.getAnchor("price"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="price_5" class="edit_input" type="text" value="<%=ld.getQuantity("price")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "PublishDate")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="publishdate" value="checkbox"  <%=getCheck(ld.getIstype("publishdate"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="publishdate_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("publishdate"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="publishdate_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("publishdate"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="publishdate_3" type="text" class="edit_input" value="<%=ld.getSequence("publishdate")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="publishdate_4"   <%=getCheck(ld.getAnchor("publishdate"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="publishdate_5" class="edit_input" type="text" value="<%=ld.getQuantity("publishdate")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Reprint")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="reprint" value="checkbox"  <%=getCheck(ld.getIstype("reprint"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="reprint_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("reprint"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="reprint_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("reprint"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="reprint_3" type="text" class="edit_input" value="<%=ld.getSequence("reprint")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="reprint_4"   <%=getCheck(ld.getAnchor("reprint"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="reprint_5" class="edit_input" type="text" value="<%=ld.getQuantity("reprint")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "SubTitle")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="subtitle" value="checkbox"  <%=getCheck(ld.getIstype("subtitle"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="subtitle_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subtitle"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="subtitle_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subtitle"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="subtitle_3" type="text" class="edit_input" value="<%=ld.getSequence("subtitle")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="subtitle_4"   <%=getCheck(ld.getAnchor("subtitle"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="subtitle_5" class="edit_input" type="text" value="<%=ld.getQuantity("subtitle")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><A href="/servlet/Search?Type=23" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Publisher")%>:</A></TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="publisher" value="checkbox"  <%=getCheck(ld.getIstype("publisher"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="publisher_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("publisher"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="publisher_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("publisher"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="publisher_3" type="text" class="edit_input" value="<%=ld.getSequence("publisher")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="publisher_4"   <%=getCheck(ld.getAnchor("publisher"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="publisher_5" class="edit_input" type="text" value="<%=ld.getQuantity("publisher")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "CIPI")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="cipi" value="checkbox"  <%=getCheck(ld.getIstype("cipi"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="cipi_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("cipi"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="cipi_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("cipi"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="cipi_3" type="text" class="edit_input" value="<%=ld.getSequence("cipi")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="cipi_4"   <%=getCheck(ld.getAnchor("cipi"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="cipi_5" class="edit_input" type="text" value="<%=ld.getQuantity("cipi")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "CIPII")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="cipii" value="checkbox"  <%=getCheck(ld.getIstype("cipii"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="cipii_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("cipii"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="cipii_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("cipii"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="cipii_3" type="text" class="edit_input" value="<%=ld.getSequence("cipii")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="cipii_4"   <%=getCheck(ld.getAnchor("cipii"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="cipii_5" class="edit_input" type="text" value="<%=ld.getQuantity("cipii")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "CIPIIV")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="cipiiv" value="checkbox"  <%=getCheck(ld.getIstype("cipiiv"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="cipiiv_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("cipiiv"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="cipiiv_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("cipiiv"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="cipiiv_3" type="text" class="edit_input" value="<%=ld.getSequence("cipiiv")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="cipiiv_4"   <%=getCheck(ld.getAnchor("cipiiv"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="cipiiv_5" class="edit_input" type="text" value="<%=ld.getQuantity("cipiiv")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Reader")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="reader" value="checkbox"  <%=getCheck(ld.getIstype("reader"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="reader_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("reader"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="reader_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("reader"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="reader_3" type="text" class="edit_input" value="<%=ld.getSequence("reader")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="reader_4"   <%=getCheck(ld.getAnchor("reader"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="reader_5" class="edit_input" type="text" value="<%=ld.getQuantity("reader")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Collection")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="collection" value="checkbox"  <%=getCheck(ld.getIstype("collection"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="collection_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("collection"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="collection_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("collection"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="collection_3" type="text" class="edit_input" value="<%=ld.getSequence("collection")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="collection_4"   <%=getCheck(ld.getAnchor("collection"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="collection_5" class="edit_input" type="text" value="<%=ld.getQuantity("collection")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Annotation")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="annotation" value="checkbox"  <%=getCheck(ld.getIstype("annotation"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="annotation_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("annotation"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="annotation_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("annotation"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="annotation_3" type="text" class="edit_input" value="<%=ld.getSequence("annotation")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="annotation_4"   <%=getCheck(ld.getAnchor("annotation"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="annotation_5" class="edit_input" type="text" value="<%=ld.getQuantity("annotation")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "SmallPicture")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="smallpicture" value="checkbox"  <%=getCheck(ld.getIstype("smallpicture"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="smallpicture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("smallpicture"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="smallpicture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("smallpicture"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="smallpicture_3" type="text" class="edit_input" value="<%=ld.getSequence("smallpicture")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="smallpicture_4"   <%=getCheck(ld.getAnchor("smallpicture"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="smallpicture_5" class="edit_input" type="text" value="<%=ld.getQuantity("smallpicture")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "BigPicture")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="bigpicture" value="checkbox"  <%=getCheck(ld.getIstype("bigpicture"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="bigpicture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bigpicture"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="bigpicture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bigpicture"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="bigpicture_3" type="text" class="edit_input" value="<%=ld.getSequence("bigpicture")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="bigpicture_4"   <%=getCheck(ld.getAnchor("bigpicture"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="bigpicture_5" class="edit_input" type="text" value="<%=ld.getQuantity("bigpicture")%>" maxlength="3" size="4"> </TD>
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

