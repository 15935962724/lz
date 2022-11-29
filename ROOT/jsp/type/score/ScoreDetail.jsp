<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Score");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
                response.sendError(403);
                return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,64,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ScoreDetail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
            <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="64"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

          <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
             <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Info")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="info" value="checkbox"  <%=getCheck(ld.getIstype("info"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="info_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("info"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="info_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("info"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="info_3" type="text" class="edit_input" value="<%=ld.getSequence("info")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="info_4"   <%=getCheck(ld.getAnchor("info"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "History")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="history" value="checkbox"  <%=getCheck(ld.getIstype("history"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="history_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("history"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="history_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("history"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="history_3" type="text" class="edit_input" value="<%=ld.getSequence("history")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="history_4"   <%=getCheck(ld.getAnchor("history"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Grade")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="grade" value="checkbox"  <%=getCheck(ld.getIstype("grade"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="grade_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("grade"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="grade_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("grade"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="grade_3" type="text" class="edit_input" value="<%=ld.getSequence("grade")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="grade_4"   <%=getCheck(ld.getAnchor("grade"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Manage")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="manage" value="checkbox"  <%=getCheck(ld.getIstype("manage"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="manage_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("manage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="manage_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("manage"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="manage_3" type="text" class="edit_input" value="<%=ld.getSequence("manage")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="manage_4"   <%=getCheck(ld.getAnchor("manage"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Query")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="query" value="checkbox"  <%=getCheck(ld.getIstype("query"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="query_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("query"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="query_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("query"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="query_3" type="text" class="edit_input" value="<%=ld.getSequence("query")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="query_4"   <%=getCheck(ld.getAnchor("query"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
  <tr>
    <td colspan="2"><hr></td>
</tr>
  <tr>
      <td>
      </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onClick="fshow()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input   class="edit_input" name="objbefore1"  mask="max" onFocus="fbefore()"  onchange="fbefore()" value="" type="text">
              <%=r.getString(teasession._nLanguage, "After")%><input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onChange="fafter()" value="" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<a href="#" onClick="fsequ()"  ><%=r.getString(teasession._nLanguage, "Default")%></a>
    <input  id="CHECKBOX" type="CHECKBOX" name="objanchor_4" onClick="fanchor()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
                                                </td>
                      </tr>
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
  <SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.info_1.focus();</SCRIPT>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

