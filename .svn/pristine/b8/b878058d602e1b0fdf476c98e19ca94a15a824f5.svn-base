<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/node/type/newspaper/EditNewsPaper");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,44,teasession._nLanguage);

%>

<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "NewsPaperDetail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
            <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="44"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

          <TABLE border="0" CELLPADDING="0" CELLSPACING="0"  id="tablecenter">
             <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
               </TD>            </TR>

                <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "SubTitle")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="SubTitle" value="checkbox"  <%=getCheck(ld.getIstype("SubTitle"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="SubTitle_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("SubTitle"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="SubTitle_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("SubTitle"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="SubTitle_3" type="text" class="edit_input" value="<%=ld.getSequence("SubTitle")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="SubTitle_4"   <%=getCheck(ld.getAnchor("SubTitle"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Content")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Content" value="checkbox"  <%=getCheck(ld.getIstype("Content"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Content_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Content"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Content_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Content"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Content_3" type="text" class="edit_input" value="<%=ld.getSequence("Content")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Content_4"   <%=getCheck(ld.getAnchor("Content"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Qihao")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Qihao" value="checkbox"  <%=getCheck(ld.getIstype("Qihao"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Qihao_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Qihao"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Qihao_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Qihao"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Qihao_3" type="text" class="edit_input" value="<%=ld.getSequence("Qihao")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Qihao_4"   <%=getCheck(ld.getAnchor("Qihao"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Edition")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Edition" value="checkbox"  <%=getCheck(ld.getIstype("Edition"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Edition_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Edition"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Edition_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Edition"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Edition_3" type="text" class="edit_input" value="<%=ld.getSequence("Edition")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Edition_4"   <%=getCheck(ld.getAnchor("Edition"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                           <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Lanmu")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Lanmu" value="checkbox"  <%=getCheck(ld.getIstype("Lanmu"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Lanmu_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Lanmu"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Lanmu_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Lanmu"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Lanmu_3" type="text" class="edit_input" value="<%=ld.getSequence("Lanmu")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Lanmu_4"   <%=getCheck(ld.getAnchor("Lanmu"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "PubDate")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="PubDate" value="checkbox"  <%=getCheck(ld.getIstype("PubDate"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="PubDate_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("PubDate"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="PubDate_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("PubDate"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="PubDate_3" type="text" class="edit_input" value="<%=ld.getSequence("PubDate")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="PubDate_4"   <%=getCheck(ld.getAnchor("PubDate"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                                <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Author")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Author" value="checkbox"  <%=getCheck(ld.getIstype("Author"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Author_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Author"))%>" type="Author" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Author_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Author"))%>" type="Author" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Author_3" type="Author" class="edit_input" value="<%=ld.getSequence("Author")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Author_4"   <%=getCheck(ld.getAnchor("Author"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
<%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="Author_5" class="edit_input" type="Author" value="<%=ld.getQuantity("Author")%>" maxlength="3" size="4">
                </TD>            </TR>                                <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Editor")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="Editor" value="checkbox"  <%=getCheck(ld.getIstype("Editor"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="Editor_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Editor"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="Editor_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Editor"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Editor_3" type="text" class="edit_input" value="<%=ld.getSequence("Editor")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="Editor_4"   <%=getCheck(ld.getAnchor("Editor"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

</table><center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
      </center>
  </form>
<script type="">
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

