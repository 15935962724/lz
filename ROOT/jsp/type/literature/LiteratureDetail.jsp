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
boolean bNew=request.getParameter("edit")==null;
r.add("/tea/resource/Literature");

ListingDetail ld=ListingDetail.find(iListing,80,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body onLoad="document.form1.getSubject_1.focus();">
<h1><%=r.getString(teasession._nLanguage, "Literature")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail?node=<%=iNode%>">
    <input type="hidden" name="ListingType" value="80"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

          <TABLE CELLSPACING="0" CELLPADDING="0" border="0" id="tablecenter">
             <TR>
              <td><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="getSubject" value="checkbox"  <%=getCheck(ld.getIstype("getSubject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="getSubject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSubject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="getSubject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSubject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getSubject_3" type="text" class="edit_input" value="<%=ld.getSequence("getSubject")%>" maxlength="3" size="3" title="0:无链接,1:链接到节点,XXXX:列举号">
<%=r.getString(teasession._nLanguage, "Anchor")%>
</td><td nowrap>
<%=r.getString(teasession._nLanguage, "Quantity")%>:</td>
<td><input name="getSubject_5" class="edit_input" type="text" value="<%=ld.getQuantity("getSubject")%>" maxlength="3" size="3">
               </TD>            </TR>

                <TR>
              <td><%=r.getString(teasession._nLanguage, "Subhead")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="getSubhead" value="checkbox"  <%=getCheck(ld.getIstype("getSubhead"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="getSubhead_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSubhead"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="getSubhead_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSubhead"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getSubhead_3" type="text" class="edit_input" value="<%=ld.getSequence("getSubhead")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="getSubhead_4"   <%=getCheck(ld.getAnchor("getSubhead"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
            </td><td>
<%=r.getString(teasession._nLanguage, "Quantity")%>:</td>
            <td><input name="getSubhead_5" class="edit_input" type="text" value="<%=ld.getQuantity("getSubhead")%>" maxlength="3" size="3">
                </TD>            </TR>



                <TR>
              <td><%=r.getString(teasession._nLanguage, "Chapter")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="getChapter" value="checkbox"  <%=getCheck(ld.getIstype("getChapter"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="getChapter_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getChapter"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="getChapter_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getChapter"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getChapter_3" type="text" class="edit_input" value="<%=ld.getSequence("getChapter")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="getChapter_4"   <%=getCheck(ld.getAnchor("getChapter"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                            <TR>
              <td><%=r.getString(teasession._nLanguage, "Section")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="getSection" value="checkbox"  <%=getCheck(ld.getIstype("getSection"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="getSection_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSection"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="getSection_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSection"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getSection_3" type="text" class="edit_input" value="<%=ld.getSequence("getSection")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX"  name="getSection_4"   <%=getCheck(ld.getAnchor("getSection"))%> ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <td><%=r.getString(teasession._nLanguage, "Pos")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="getPos" value="checkbox"  <%=getCheck(ld.getIstype("getPos"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="getPos_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPos"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="getPos_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPos"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPos_3" type="text" class="edit_input" value="<%=ld.getSequence("getPos")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="getPos_4"   <%=getCheck(ld.getAnchor("getPos"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                           <TR>
              <td><%=r.getString(teasession._nLanguage, "Author")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="getAuthor" value="checkbox"  <%=getCheck(ld.getIstype("getAuthor"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="getAuthor_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getAuthor"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="getAuthor_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getAuthor"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getAuthor_3" type="text" class="edit_input" value="<%=ld.getSequence("getAuthor")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="getAuthor_4"   <%=getCheck(ld.getAnchor("getAuthor"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <td><%=r.getString(teasession._nLanguage, "Cname")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="getCname" value="checkbox"  <%=getCheck(ld.getIstype("getCname"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="getCname_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getCname"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="getCname_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getCname"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getCname_3" type="text" class="edit_input" value="<%=ld.getSequence("getCname")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="getCname_4"   <%=getCheck(ld.getAnchor("getCname"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                                <TR>
              <td><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="getText2" value="checkbox"  <%=getCheck(ld.getIstype("getText2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="getText2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getText2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="getText2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getText2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getText2_3" type="text" class="edit_input" value="<%=ld.getSequence("getText2")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="getText2_4"   <%=getCheck(ld.getAnchor("getText2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
</td><td>
<%=r.getString(teasession._nLanguage, "Quantity")%>:</td>
<td><input name="getText2_5" class="edit_input" type="text" value="<%=ld.getQuantity("getText2")%>" maxlength="3" size="3">
                </TD>            </TR>

				           <TR>
              <td>Flash:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="getFlash" value="checkbox"  <%=getCheck(ld.getIstype("getFlash"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="getFlash_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFlash"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="getFlash_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFlash"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFlash_3" type="text" class="edit_input" value="<%=ld.getSequence("getFlash")%>" maxlength="3" size="4">
<input type=hidden name="getFlash_4" value="0">
                </TD>            </TR>
            <tr>
                              <td><%=r.getString(teasession._nLanguage, "Sname")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="getSname" value="checkbox"  <%=getCheck(ld.getIstype("getSname"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="getSname_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSname"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="getSname_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSname"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getSname_3" type="text" class="edit_input" value="<%=ld.getSequence("getSname")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="getSname_4"   <%=getCheck(ld.getAnchor("getSname"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
</td>          </TR>
            <tr>
                              <td><%=r.getString(teasession._nLanguage, "getDivide")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="getDivide" value="checkbox"  <%=getCheck(ld.getIstype("getDivide"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="getDivide_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getDivide"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="getDivide_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getDivide"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getDivide_3" type="text" class="edit_input" value="<%=ld.getSequence("getDivide")%>" maxlength="3" size="4">
<input type=hidden name="getDivide_4" value="0">
</td>          </TR>

</table><center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
      </center>
  </form>

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
  <SCRIPT type="text/javascript"><%if(bNew)out.println("fsequ();");%></SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

