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

r.add("/tea/resource/GreenManufacture");

ListingDetail ld=ListingDetail.find(iListing,76,teasession._nLanguage);


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "GreenManufacture")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
  <input type='hidden' name="Node" value="<%=iNode%>">
  <input type="hidden" name="ListingType" value="76"/>
  <%if(!flag){%>
  <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
  <%        }else{%>
  <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
  <%   }%>
  <input type="hidden" name="Listing" value="<%=iListing%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
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
      <TD><%=r.getString(teasession._nLanguage, "Faren")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="faren" value="checkbox"  <%=getCheck(ld.getIstype("faren"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="faren_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("faren"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="faren_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("faren"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="faren_3" type="text" class="edit_input" value="<%=ld.getSequence("faren")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="faren_4"   <%=getCheck(ld.getAnchor("faren"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Postalcode")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="postalcode" value="checkbox"  <%=getCheck(ld.getIstype("postalcode"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="postalcode_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("postalcode"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="postalcode_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("postalcode"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="postalcode_3" type="text" class="edit_input" value="<%=ld.getSequence("postalcode")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="postalcode_4"   <%=getCheck(ld.getAnchor("postalcode"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "CompanyAdd")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="companyadd" value="checkbox"  <%=getCheck(ld.getIstype("companyadd"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="companyadd_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("companyadd"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="companyadd_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("companyadd"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="companyadd_3" type="text" class="edit_input" value="<%=ld.getSequence("companyadd")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="companyadd_4"   <%=getCheck(ld.getAnchor("companyadd"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Fax")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="fax" value="checkbox"  <%=getCheck(ld.getIstype("fax"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="fax_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fax"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="fax_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fax"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="fax_3" type="text" class="edit_input" value="<%=ld.getSequence("fax")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="fax_4"   <%=getCheck(ld.getAnchor("fax"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Phone")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="phone" value="checkbox"  <%=getCheck(ld.getIstype("phone"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="phone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("phone"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="phone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("phone"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="phone_3" type="text" class="edit_input" value="<%=ld.getSequence("phone")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="phone_4"   <%=getCheck(ld.getAnchor("phone"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Quality")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="quality" value="checkbox"  <%=getCheck(ld.getIstype("quality"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="quality_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("quality"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="quality_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("quality"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="quality_3" type="text" class="edit_input" value="<%=ld.getSequence("quality")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="quality_4"   <%=getCheck(ld.getAnchor("quality"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "EP")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="ep" value="checkbox"  <%=getCheck(ld.getIstype("ep"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="ep_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ep"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="ep_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ep"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="ep_3" type="text" class="edit_input" value="<%=ld.getSequence("ep")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="ep_4"   <%=getCheck(ld.getAnchor("ep"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="text_3" type="text" class="edit_input" value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="text_5" class="edit_input" type="text" value="<%=ld.getQuantity("text")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Medal")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="medal" value="checkbox"  <%=getCheck(ld.getIstype("medal"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="medal_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("medal"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="medal_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("medal"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="medal_3" type="text" class="edit_input" value="<%=ld.getSequence("medal")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="medal_4"   <%=getCheck(ld.getAnchor("medal"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Attestation")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="attestation" value="checkbox"  <%=getCheck(ld.getIstype("attestation"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="attestation_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("attestation"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="attestation_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("attestation"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="attestation_3" type="text" class="edit_input" value="<%=ld.getSequence("attestation")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="attestation_4"   <%=getCheck(ld.getAnchor("attestation"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Company")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="company" value="checkbox"  <%=getCheck(ld.getIstype("company"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="company_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("company"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="company_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("company"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="company_3" type="text" class="edit_input" value="<%=ld.getSequence("company")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="company_4"   <%=getCheck(ld.getAnchor("company"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Content")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="content" value="checkbox"  <%=getCheck(ld.getIstype("content"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="content_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("content"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="content_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("content"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="content_3" type="text" class="edit_input" value="<%=ld.getSequence("content")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="content_4"   <%=getCheck(ld.getAnchor("content"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Linkman")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="linkman" value="checkbox"  <%=getCheck(ld.getIstype("linkman"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="linkman_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("linkman"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="linkman_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("linkman"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="linkman_3" type="text" class="edit_input" value="<%=ld.getSequence("linkman")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD>E-Mail:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="email" value="checkbox"  <%=getCheck(ld.getIstype("email"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="email_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("email"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="email_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("email"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="email_3" type="text" class="edit_input" value="<%=ld.getSequence("email")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Remark")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="remark" value="checkbox"  <%=getCheck(ld.getIstype("remark"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="remark_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("remark"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="remark_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("remark"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="remark_3" type="text" class="edit_input" value="<%=ld.getSequence("remark")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Brand")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="brand" value="checkbox"  <%=getCheck(ld.getIstype("brand"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="brand_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("brand"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="brand_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("brand"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="brand_3" type="text" class="edit_input" value="<%=ld.getSequence("brand")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>>
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
<SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.subject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

