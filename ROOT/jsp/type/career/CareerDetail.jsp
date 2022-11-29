<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/node/type/career/EditCareer");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,29,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Career")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
            <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="29"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

             <TR>
              <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
<input type=checkbox name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
<%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4">
                </TD>            </TR>

                <TR>
              <TD><%=r.getString(teasession._nLanguage, "TimeType")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="timetype" value="checkbox"  <%=getCheck(ld.getIstype("timetype"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="timetype_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("timetype"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="timetype_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("timetype"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="timetype_3" type="text" class="edit_input" value="<%=ld.getSequence("timetype")%>" maxlength="3" size="4">
<input type=checkbox name="timetype_4"   <%=getCheck(ld.getAnchor("timetype"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Salary")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="salary" value="checkbox"  <%=getCheck(ld.getIstype("salary"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="salary_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("salary"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="salary_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("salary"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="salary_3" type="text" class="edit_input" value="<%=ld.getSequence("salary")%>" maxlength="3" size="4">
<input type=checkbox name="salary_4"   <%=getCheck(ld.getAnchor("salary"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>

                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Location")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="location" value="checkbox"  <%=getCheck(ld.getIstype("location"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="location_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("location"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="location_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("location"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="location_3" type="text" class="edit_input" value="<%=ld.getSequence("location")%>" maxlength="3" size="4">
<input type=checkbox name="location_4"   <%=getCheck(ld.getAnchor("location"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR><TR>
              <TD><%=r.getString(teasession._nLanguage, "Skill")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="skill" value="checkbox"  <%=getCheck(ld.getIstype("skill"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="skill_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("skill"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="skill_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("skill"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="skill_3" type="text" class="edit_input" value="<%=ld.getSequence("skill")%>" maxlength="3" size="4">
<input type=checkbox name="skill_4"   <%=getCheck(ld.getAnchor("skill"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
                                <TR>
              <TD><%=r.getString(teasession._nLanguage, "Target")%>:</TD>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="target" value="checkbox"  <%=getCheck(ld.getIstype("target"))%> id="radio"><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="target_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("target"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="target_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("target"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="target_3" type="text" class="edit_input" value="<%=ld.getSequence("target")%>" maxlength="3" size="4">
<input type=checkbox name="target_4"   <%=getCheck(ld.getAnchor("target"))%> id="radio"><%=r.getString(teasession._nLanguage, "Anchor")%>
                </TD>            </TR>
  <tr>
    <td colspan="2"><hr size="1"></td>
</tr>
  <tr>
      <td>
      </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onclick="fshow()"  id="radio"><%=r.getString(teasession._nLanguage, "SelectAll")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input   class="edit_input" name="objbefore1"  mask="max" onFocus="fbefore()"  onchange="fbefore()" value="" type="text">
              <%=r.getString(teasession._nLanguage, "After")%><input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onChange="fafter()" value="" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<a href="#" onClick="fsequ()"  ><%=r.getString(teasession._nLanguage, "Default")%></a>
    <input  id="CHECKBOX" type="CHECKBOX" name="objanchor_4" onclick="fanchor()"  id="radio"><%=r.getString(teasession._nLanguage, "SelectAll")%>
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

