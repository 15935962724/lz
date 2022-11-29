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

r.add("/tea/resource/EarthKavass");

ListingDetail ld=ListingDetail.find(iListing,77,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EarthKavass")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
            <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="77"/>
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
              <TD><%=r.getString(teasession._nLanguage, "Name")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" type="text" class="edit_input" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="name_4"   <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="address" value="checkbox"  <%=getCheck(ld.getIstype("address"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="address_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="address_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="address_3" type="text" class="edit_input" value="<%=ld.getSequence("address")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="address_4"   <%=getCheck(ld.getAnchor("address"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="zip" value="checkbox"  <%=getCheck(ld.getIstype("zip"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="zip_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("zip"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="zip_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("zip"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="zip_3" type="text" class="edit_input" value="<%=ld.getSequence("zip")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="zip_4"   <%=getCheck(ld.getAnchor("zip"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Phone")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="phone" value="checkbox"  <%=getCheck(ld.getIstype("phone"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="phone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("phone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="phone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("phone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="phone_3" type="text" class="edit_input" value="<%=ld.getSequence("phone")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="phone_4"   <%=getCheck(ld.getAnchor("phone"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
        <TR>
              <TD><%=r.getString(teasession._nLanguage, "Fax")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="fax" value="checkbox"  <%=getCheck(ld.getIstype("fax"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="fax_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fax"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="fax_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fax"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="fax_3" type="text" class="edit_input" value="<%=ld.getSequence("fax")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="fax_4"   <%=getCheck(ld.getAnchor("fax"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>


      <TR>
              <TD>E-Mail:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="email" value="checkbox"  <%=getCheck(ld.getIstype("email"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="email_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("email"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="email_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("email"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="email_3" type="text" class="edit_input" value="<%=ld.getSequence("email")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="email_4"   <%=getCheck(ld.getAnchor("email"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
 <TR>
              <TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" type="text" class="edit_input" value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="text_5" class="edit_input" type="text" value="<%=ld.getQuantity("text")%>" maxlength="3" size="4">
                </TD>            </TR>
</table><center >
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
   <div id="head6"><img height="6" src="about:blank"></div> <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

