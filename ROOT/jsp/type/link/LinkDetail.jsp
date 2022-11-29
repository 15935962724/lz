<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%><%

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv.toString()).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

r.add("/tea/resource/AmityLink");
ListingDetail ld=ListingDetail.find(iListing,78,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "AmityLink")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
  <input type='hidden' name="node" value="<%=iNode%>">
  <input type="hidden" name="ListingType" value="78"/>
  <%if(!flag){%>
  <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
  <%        }else{%>
  <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
  <%   }%>
  <input type="hidden" name="Listing" value="<%=iListing%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="getSubject" value="checkbox"  <%=getCheck(ld.getIstype("getSubject"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getSubject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSubject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="getSubject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSubject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="getSubject_3" type="text" class="edit_input" value="<%=ld.getSequence("getSubject")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getSubject_4"   <%=getCheck(ld.getAnchor("getSubject"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="getSubject_5" class="edit_input" type="text" value="<%=ld.getQuantity("getSubject")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TR>
      <td><%=r.getString(teasession._nLanguage, "LinkType")%>:</td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="isType" value="checkbox"  <%=getCheck(ld.getIstype("isType"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="isType_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("isType"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="isType_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("isType"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="isType_3" type="text" class="edit_input" value="<%=ld.getSequence("isType")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="isType_4"   <%=getCheck(ld.getAnchor("isType"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="getName" value="checkbox"  <%=getCheck(ld.getIstype("getName"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getName_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getName"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="getName_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getName"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="getName_3" type="text" class="edit_input" value="<%=ld.getSequence("getName")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getName_4"   <%=getCheck(ld.getAnchor("getName"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td>E-Mail:</td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="getEmail" value="checkbox"  <%=getCheck(ld.getIstype("getEmail"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getEmail_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getEmail"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="getEmail_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getEmail"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="getEmail_3" type="text" class="edit_input" value="<%=ld.getSequence("getEmail")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getEmail_4"   <%=getCheck(ld.getAnchor("getEmail"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td>Logo:</td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="getLogo" value="checkbox"  <%=getCheck(ld.getIstype("getLogo"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getLogo_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getLogo"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="getLogo_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getLogo"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="getLogo_3" type="text" class="edit_input" value="<%=ld.getSequence("getLogo")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getLogo_4"   <%=getCheck(ld.getAnchor("getLogo"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td><%=r.getString(teasession._nLanguage, "Anchor")%>:</td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="getLink" value="checkbox"  <%=getCheck(ld.getIstype("getLink"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getLink_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getLink"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="getLink_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getLink"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="getLink_3" type="text" class="edit_input" value="<%=ld.getSequence("getLink")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getLink_4"   <%=getCheck(ld.getAnchor("getLink"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td><%=r.getString(teasession._nLanguage, "网址")%>:</td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="url" value="checkbox"  <%=getCheck(ld.getIstype("url"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="url_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("url"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="url_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("url"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="url_3" type="text" class="edit_input" value="<%=ld.getSequence("url")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="url_4"   <%=getCheck(ld.getAnchor("url"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="getText2" value="checkbox"  <%=getCheck(ld.getIstype("getText2"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getText2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getText2"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="getText2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getText2"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="getText2_3" type="text" class="edit_input" value="<%=ld.getSequence("getText2")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getText2_4"   <%=getCheck(ld.getAnchor("getText2"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
  </table>
  <center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </center>
</form>
<script type="">
  function fshow()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)!="_4")
          {
              form1.elements[counter].checked=form1.elements["objshow"].checked;
          }
      }
  }
  function fafter()
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
<SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.getSubject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

