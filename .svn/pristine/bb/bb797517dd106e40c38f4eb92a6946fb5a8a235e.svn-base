<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Indict");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,71,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "IndictDetail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
            <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="71"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
             <TR>
              <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
<%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4">
                </TD>            </TR>

                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Appellee")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="appellee" value="checkbox"  <%=getCheck(ld.getIstype("appellee"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="appellee_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("appellee"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="appellee_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("appellee"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="appellee_3" type="text" class="edit_input" value="<%=ld.getSequence("appellee")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="appellee_4"   <%=getCheck(ld.getAnchor("appellee"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                <TR>
              <TD><%=r.getString(teasession._nLanguage, "SOrder")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="sorder" value="checkbox"  <%=getCheck(ld.getIstype("sorder"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="sorder_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sorder"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="sorder_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sorder"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="sorder_3" type="text" class="edit_input" value="<%=ld.getSequence("sorder")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="sorder_4"   <%=getCheck(ld.getAnchor("sorder"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
  <TR>
              <TD><%=r.getString(teasession._nLanguage, "Plaintiff")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="plaintiff" value="checkbox"  <%=getCheck(ld.getIstype("plaintiff"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="plaintiff_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("plaintiff"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="plaintiff_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("plaintiff"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="plaintiff_3" type="text" class="edit_input" value="<%=ld.getSequence("plaintiff")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="plaintiff_4"   <%=getCheck(ld.getAnchor("plaintiff"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Handler")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="handler" value="checkbox"  <%=getCheck(ld.getIstype("handler"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="handler_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("handler"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="handler_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("handler"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="handler_3" type="text" class="edit_input" value="<%=ld.getSequence("handler")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="handler_4"   <%=getCheck(ld.getAnchor("handler"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Result")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="result" value="checkbox"  <%=getCheck(ld.getIstype("result"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="result_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("result"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="result_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("result"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="result_3" type="text" class="edit_input" value="<%=ld.getSequence("result")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="result_4"   <%=getCheck(ld.getAnchor("result"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                           <TR>
              <TD><%=r.getString(teasession._nLanguage, "Time")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="time" value="checkbox"  <%=getCheck(ld.getIstype("time"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="time_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("time"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="time_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("time"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="time_3" type="text" class="edit_input" value="<%=ld.getSequence("time")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="time_4"   <%=getCheck(ld.getAnchor("time"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD><%=r.getString(teasession._nLanguage, "HandlerTime")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="handlertime" value="checkbox"  <%=getCheck(ld.getIstype("handlertime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="handlertime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("handlertime"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="handlertime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("handlertime"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="handlertime_3" type="text" class="edit_input" value="<%=ld.getSequence("handlertime")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="handlertime_4"   <%=getCheck(ld.getAnchor("handlertime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" type="text" class="edit_input" value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
<%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="text_5" class="edit_input" type="text" value="<%=ld.getQuantity("text")%>"  maxlength="3" size="4">
                </TD>            </TR>
                 <TR>
              <TD><%=r.getString(teasession._nLanguage, "HandlerButton")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="handlerbutton" value="checkbox"  <%=getCheck(ld.getIstype("handlerbutton"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="handlerbutton_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("handlerbutton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="handlerbutton_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("handlerbutton"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="handlerbutton_3" type="text" class="edit_input" value="<%=ld.getSequence("handlerbutton")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="handlerbutton_4"   <%=getCheck(ld.getAnchor("handlerbutton"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
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
  <SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.subject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

