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

r.add("/tea/resource/Contribute");
ListingDetail ld=ListingDetail.find(iListing,74,teasession._nLanguage);

%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ContributeDetail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
            <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="74"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
             <TR>
              <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%> ><%=r.getString(teasession._nLanguage, "Anchor")%>
<%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4">
               </TD>            </TR>

                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Project")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="project" value="checkbox"  <%=getCheck(ld.getIstype("project"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="project_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("project"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="project_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("project"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="project_3" type="text" class="edit_input" value="<%=ld.getSequence("project")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="project_4"   <%=getCheck(ld.getAnchor("project"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
               <TR>
              <TD><%=r.getString(teasession._nLanguage, "MoneyCount")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="moneycount" value="checkbox"  <%=getCheck(ld.getIstype("moneycount"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="moneycount_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("moneycount"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="moneycount_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("moneycount"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="moneycount_3" type="text" class="edit_input" value="<%=ld.getSequence("moneycount")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="moneycount_4"   <%=getCheck(ld.getAnchor("moneycount"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                            <TR>
              <TD><%=r.getString(teasession._nLanguage, "Time")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="time" value="checkbox"  <%=getCheck(ld.getIstype("time"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="time_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("time"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="time_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("time"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="time_3" type="text" class="edit_input" value="<%=ld.getSequence("time")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="time_4"   <%=getCheck(ld.getAnchor("time")==1)%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Photo")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="photo" value="checkbox"  <%=getCheck(ld.getIstype("photo"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="photo_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("photo"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="photo_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("photo"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="photo_3" type="text" class="edit_input" value="<%=ld.getSequence("photo")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="photo_4"   <%=getCheck(ld.getAnchor("photo"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Linkman")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="linkman" value="checkbox"  <%=getCheck(ld.getIstype("linkman"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="linkman_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("linkman"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="linkman_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("linkman"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="linkman_3" type="text" class="edit_input" value="<%=ld.getSequence("linkman")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="linkman_4"   <%=getCheck(ld.getAnchor("linkman"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Phone")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="phone" value="checkbox"  <%=getCheck(ld.getIstype("phone"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="phone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("phone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="phone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("phone"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="phone_3" type="text" class="edit_input" value="<%=ld.getSequence("phone")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="phone_4"   <%=getCheck(ld.getAnchor("phone"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Linkman")%>2:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="linkman2" value="checkbox"  <%=getCheck(ld.getIstype("linkman2"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="linkman2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("linkman2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="linkman2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("linkman2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="linkman2_3" type="text" class="edit_input" value="<%=ld.getSequence("linkman2")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="linkman2_4"   <%=getCheck(ld.getAnchor("linkman2"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                    <TR>
              <TD><%=r.getString(teasession._nLanguage, "Phone")%>2:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="phone2" value="checkbox"  <%=getCheck(ld.getIstype("phone2"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="phone2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("phone2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="phone2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("phone2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="phone2_3" type="text" class="edit_input" value="<%=ld.getSequence("phone2")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="phone2_4"   <%=getCheck(ld.getAnchor("phone2"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

        <TR>
              <TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="address" value="checkbox"  <%=getCheck(ld.getIstype("address"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="address_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="address_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("address"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="address_3" type="text" class="edit_input" value="<%=ld.getSequence("address")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="address_4"   <%=getCheck(ld.getAnchor("address"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
          </TD>            </TR>
      <TR>
              <TD><%=r.getString(teasession._nLanguage, "Address")%>2:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="address2" value="checkbox"  <%=getCheck(ld.getIstype("address2"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="address2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("address2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="address2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("address2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="address2_3" type="text" class="edit_input" value="<%=ld.getSequence("address2")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="address2_4"   <%=getCheck(ld.getAnchor("address2"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
        </TD>            </TR>
                   <TR>
              <TD><%=r.getString(teasession._nLanguage, "Postalcode")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="postalcode" value="checkbox"  <%=getCheck(ld.getIstype("postalcode"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="postalcode_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("postalcode"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="postalcode_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("postalcode"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="postalcode_3" type="text" class="edit_input" value="<%=ld.getSequence("postalcode")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="postalcode_4"   <%=getCheck(ld.getAnchor("postalcode"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                      <TR>
              <TD><%=r.getString(teasession._nLanguage, "Postalcode")%>2:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="postalcode2" value="checkbox"  <%=getCheck(ld.getIstype("postalcode2"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="postalcode2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("postalcode2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="postalcode2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("postalcode2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="postalcode2_3" type="text" class="edit_input" value="<%=ld.getSequence("postalcode2")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="postalcode2_4"   <%=getCheck(ld.getAnchor("postalcode2"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                      <TR>
              <TD>E-Mail:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="email" value="checkbox"  <%=getCheck(ld.getIstype("email"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="email_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("email"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="email_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("email"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="email_3" type="text" class="edit_input" value="<%=ld.getSequence("email")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="email_4"   <%=getCheck(ld.getAnchor("email"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                         <TR>  <TD>E-Mail2:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="email2" value="checkbox"  <%=getCheck(ld.getIstype("email2"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="email2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("email2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="email2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("email2"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="email2_3" type="text" class="edit_input" value="<%=ld.getSequence("email2")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="email2_4"   <%=getCheck(ld.getAnchor("email2"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
  <TR>  <TD><%=r.getString(teasession._nLanguage, "Classes")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="classes" value="checkbox"  <%=getCheck(ld.getIstype("classes"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="classes_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("classes"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="classes_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("classes"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="classes_3" type="text" class="edit_input" value="<%=ld.getSequence("classes")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="classes_4"   <%=getCheck(ld.getAnchor("classes"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
      </TD>            </TR>
             <TR>  <TD><%=r.getString(teasession._nLanguage, "Belong")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="belong" value="checkbox"  <%=getCheck(ld.getIstype("belong"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="belong_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("belong"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="belong_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("belong"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="belong_3" type="text" class="edit_input" value="<%=ld.getSequence("belong")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="belong_4"   <%=getCheck(ld.getAnchor("belong"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
               </TD>            </TR>
                             <TR>  <TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>  ><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" type="text" class="edit_input" value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>  ><%=r.getString(teasession._nLanguage, "Anchor")%>
  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="text_5" class="edit_input" type="text" value="<%=ld.getQuantity("text")%>" maxlength="3" size="4">

                </TD>            </TR>

  <!--tr>
      <td>
      </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onclick="fshow()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input   class="edit_input" name="objbefore1"  mask="max" onfocus="fbefore()"  onchange="fbefore()" value="" type="text">
              <%=r.getString(teasession._nLanguage, "After")%><input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onchange="fafter()" value="" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<a href="#" onclick="fsequ()"  ><%=r.getString(teasession._nLanguage, "Default")%></a>
    <input  id="CHECKBOX" type="CHECKBOX" name="objanchor_4" onclick="fanchor()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
                                                </td>
                      </tr-->
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
          if(form1.elements[counter].type=="linkman2"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)=="2")
          {
              form1.elements[counter].value=form1.elements["objafter2"].value;
          }
      }
  }

  function fbefore()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="linkman2"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)=="1")
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
          if(form1.elements[counter].type=="linkman2"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)=="_3")
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

