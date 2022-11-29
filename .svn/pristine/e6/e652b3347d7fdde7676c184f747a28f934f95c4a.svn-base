<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
    //  r.add("/tea/resource/Expert");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
//int iNode  = Listing.find(iListing).getNode();
int iNode  = Listing.find(iListing).getNode();
if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
	response.sendError(403);
	return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,40,teasession._nLanguage);


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Picture")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>


<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
<input type='hidden' name="node" value="<%=iNode%>">
<input type="hidden" name="ListingType" value="40"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
 <div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <td ID=RowHeader><%=r.getString(teasession._nLanguage, "index")%>:</TD>
    <TD>
      <input  id="CHECKBOX" type="CHECKBOX" name="index" value="checkbox"  <%=getCheck(ld.getIstype("index"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="index_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("index"))%>" type="text" class="edit_input">
      <%=r.getString(teasession._nLanguage, "After")%><input name="index_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("index"))%>" type="text" class="edit_input">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="index_3" type="text" class="edit_input" value="<%=ld.getSequence("index")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="index_4"   <%=getCheck(ld.getAnchor("index"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </TD>
  </TR>
  <TR>
    <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Name")%>:</TD>
    <TD>
      <input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%><input name="name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text" class="edit_input">
            <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" type="text" class="edit_input" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
              <input  id=CHECKBOX type="CHECKBOX" name="name_4"   <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </TD>
  </TR>

              <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Author")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="author" value="checkbox"  <%=getCheck(ld.getIstype("author"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="author_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("author"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="author_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("author"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="author_3" type="text" class="edit_input" value="<%=ld.getSequence("author")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="author_4"   <%=getCheck(ld.getAnchor("author"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>
                      <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Date")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="date" value="checkbox"  <%=getCheck(ld.getIstype("date"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="date_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("date"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="date_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("date"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="date_3" type="text" class="edit_input" value="<%=ld.getSequence("date")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="date_4"   <%=getCheck(ld.getAnchor("date"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>
                      <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" type="text" class="edit_input" value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>                      <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="address" value="checkbox"  <%=getCheck(ld.getIstype("address"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="address_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="address_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="address_3" type="text" class="edit_input" value="<%=ld.getSequence("address")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="address_4"   <%=getCheck(ld.getAnchor("address"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>
            <TR>
              <td width="26" ID=RowHeader><%=r.getString(teasession._nLanguage, "Classes")%>:</TD>
              <TD width="516"><input  id="CHECKBOX" type="CHECKBOX" name="classes" value="checkbox"  <%=getCheck(ld.getIstype("classes"))%>><%=r.getString(teasession._nLanguage, "Show")%>
			  	<%=r.getString(teasession._nLanguage, "Before")%><input  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("classes"))%>" type="text" class="edit_input"  name="classes_1">
                <%=r.getString(teasession._nLanguage, "After")%><input  mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("classes"))%>" type="text" class="edit_input" name="classes_2">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="classes_3" type="text" class="edit_input" value="<%=ld.getSequence("classes")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="classes_4"   <%=getCheck(ld.getAnchor("classes"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
           </TD> </TR>
            <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "save")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="savepic" value="checkbox"  <%=getCheck(ld.getIstype("savepic"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="savepic_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("savepic"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="savepic_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("savepic"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="savepic_3" type="text" class="edit_input" value="<%=ld.getSequence("savepic")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="savepic_4"   <%=getCheck(ld.getAnchor("savepic"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>
             <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Picture")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="picture" value="checkbox"  <%=getCheck(ld.getIstype("picture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="picture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("picture"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="picture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("picture"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="picture_3" type="text" class="edit_input" value="<%=ld.getSequence("picture")%>" maxlength="3" size="4">
  <select name="picture_4">
    <option value="0">-----</option>
        <option value="1" <%=getSelect(ld.getAnchor("picture")==1)%>><%=r.getString(teasession._nLanguage, "Node")%></option>
                <option value="2" <%=getSelect(ld.getAnchor("picture")==2)%>><%=r.getString(teasession._nLanguage, "Picture")%></option>
  </select>

<%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>
            <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "SmallPicture")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="small" value="checkbox"  <%=getCheck(ld.getIstype("small"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="small_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("small"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="small_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("small"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="small_3" type="text" class="edit_input" value="<%=ld.getSequence("small")%>" maxlength="3" size="4">
  <select name="small_4">
    <option value="0">-----</option>
        <option value="1" <%=getSelect(ld.getAnchor("small")==1)%>><%=r.getString(teasession._nLanguage, "Node")%></option>
                <option value="2" <%=getSelect(ld.getAnchor("small")==2)%>><%=r.getString(teasession._nLanguage, "Picture")%></option>
  </select>
  <%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>
            <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Note")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="note" value="checkbox"  <%=getCheck(ld.getIstype("note"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="note_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("note"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="note_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("note"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="note_3" type="text" class="edit_input" value="<%=ld.getSequence("note")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="note_4"   <%=getCheck(ld.getAnchor("note"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>
            </TR>
             <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Size")%>:</TD>
              <TD>
<input  id="CHECKBOX" type="CHECKBOX" name="size" value="checkbox"  <%=getCheck(ld.getIstype("size"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="size_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("size"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="size_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("size"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="size_3" type="text" class="edit_input" value="<%=ld.getSequence("size")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="size_4"   <%=getCheck(ld.getAnchor("size"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
              </TD>
             </TR>
             <TR>
               <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Price")%>:</TD>
               <TD>
                 <input  id="CHECKBOX" type="CHECKBOX" name="price" value="checkbox"  <%=getCheck(ld.getIstype("price"))%>><%=r.getString(teasession._nLanguage, "Show")%>
                 <%=r.getString(teasession._nLanguage, "Before")%><input name="price_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price"))%>" type="text" class="edit_input">
                   <%=r.getString(teasession._nLanguage, "After")%><input name="price_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price"))%>" type="text" class="edit_input">
                     <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="price_3" type="text" class="edit_input" value="<%=ld.getSequence("price")%>" maxlength="3" size="4">
                       <input  id=CHECKBOX type="CHECKBOX" name="price_4"   <%=getCheck(ld.getAnchor("price"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
               </TD>
             </TR>

</table><center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
      </center>
  </form>

  <SCRIPT>
  function fsequ()
  {
    var paramvalue=0;
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="text"&&form1.elements[counter].ld.substring(form1.elements[counter].ld.length-2)=="_3")
          {
              form1.elements[counter].value=++paramvalue*10;
          }
      }
  }
  <%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.name_1.focus();</SCRIPT>
  <br>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

