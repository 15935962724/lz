<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/node/type/friend/EditFriend");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,31,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "FriendDetail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
    <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="31"/>
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
        <TD><%=r.getString(teasession._nLanguage, "Gender")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="gender" value="checkbox"  <%=getCheck(ld.getIstype("gender"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="gender_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("gender"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="gender_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("gender"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="gender_3" type="text" class="edit_input" value="<%=ld.getSequence("gender")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="gender_4"   <%=getCheck(ld.getAnchor("gender"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "PrefGender")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="prefgender" value="checkbox"  <%=getCheck(ld.getIstype("prefgender"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="prefgender_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("prefgender"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="prefgender_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("prefgender"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="prefgender_3" type="text" class="edit_input" value="<%=ld.getSequence("prefgender")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="prefgender_4"   <%=getCheck(ld.getAnchor("prefgender"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Relationship")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="relationship" value="checkbox"  <%=getCheck(ld.getIstype("relationship"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="relationship_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("relationship"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="relationship_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("relationship"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="relationship_3" type="text" class="edit_input" value="<%=ld.getSequence("relationship")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="relationship_4"   <%=getCheck(ld.getAnchor("relationship"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Ethnicity")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="ethnicity" value="checkbox"  <%=getCheck(ld.getIstype("ethnicity"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="ethnicity_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ethnicity"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="ethnicity_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ethnicity"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="ethnicity_3" type="text" class="edit_input" value="<%=ld.getSequence("ethnicity")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="ethnicity_4"   <%=getCheck(ld.getAnchor("ethnicity"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Education")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="education" value="checkbox"  <%=getCheck(ld.getIstype("education"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="education_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("education"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="education_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("education"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="education_3" type="text" class="edit_input" value="<%=ld.getSequence("education")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="education_4"   <%=getCheck(ld.getAnchor("education"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Employment")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="employment" value="checkbox"  <%=getCheck(ld.getIstype("employment"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="employment_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("employment"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="employment_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("employment"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="employment_3" type="text" class="edit_input" value="<%=ld.getSequence("employment")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="employment_4"   <%=getCheck(ld.getAnchor("employment"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Religion")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="religion" value="checkbox"  <%=getCheck(ld.getIstype("religion"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="religion_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("religion"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="religion_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("religion"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="religion_3" type="religion" class="edit_input" value="<%=ld.getSequence("religion")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="religion_4"   <%=getCheck(ld.getAnchor("religion"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
          <input name="religion_5" class="edit_input" type="text" value="<%=ld.getQuantity("religion")%>" maxlength="3" size="4">
        </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Hobbies")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="hobbies" value="checkbox"  <%=getCheck(ld.getIstype("hobbies"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="hobbies_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("hobbies"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="hobbies_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("hobbies"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="hobbies_3" type="text" class="edit_input" value="<%=ld.getSequence("hobbies")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="hobbies_4"   <%=getCheck(ld.getAnchor("hobbies"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
      <TD><%=r.getString(teasession._nLanguage, "BodyType")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="bodytype" value="checkbox"  <%=getCheck(ld.getIstype("bodytype"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="bodytype_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bodytype"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="bodytype_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bodytype"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="bodytype_3" type="text" class="edit_input" value="<%=ld.getSequence("bodytype")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="bodytype_4"   <%=getCheck(ld.getAnchor("bodytype"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
          <input name="bodytype_5" class="edit_input" type="text" value="<%=ld.getQuantity("bodytype")%>" maxlength="3" size="4">
        </TD>
      </TR>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Age")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="age" value="checkbox"  <%=getCheck(ld.getIstype("age"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="age_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("age"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="age_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("age"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="age_3" type="text" class="edit_input" value="<%=ld.getSequence("age")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="age_4"   <%=getCheck(ld.getAnchor("age"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
          <input name="age_5" class="edit_input" type="text" value="<%=ld.getQuantity("age")%>" maxlength="3" size="4">
        </TD>
      </TR>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Height")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="height" value="checkbox"  <%=getCheck(ld.getIstype("height"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="height_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("height"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="height_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("height"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="height_3" type="text" class="edit_input" value="<%=ld.getSequence("height")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="height_4"   <%=getCheck(ld.getAnchor("height"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
          <input name="height_5" class="edit_input" type="text" value="<%=ld.getQuantity("height")%>" maxlength="3" size="4">
        </TD>
      </TR>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Smoke")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="smoke" value="checkbox"  <%=getCheck(ld.getIstype("smoke"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="smoke_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("smoke"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="smoke_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("smoke"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="smoke_3" type="text" class="edit_input" value="<%=ld.getSequence("smoke")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="smoke_4"   <%=getCheck(ld.getAnchor("smoke"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
          <input name="smoke_5" class="edit_input" type="text" value="<%=ld.getQuantity("smoke")%>" maxlength="3" size="4">
        </TD>
      </TR>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Drink")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="drink" value="checkbox"  <%=getCheck(ld.getIstype("drink"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="drink_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("drink"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="drink_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("drink"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="drink_3" type="text" class="edit_input" value="<%=ld.getSequence("drink")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="drink_4"   <%=getCheck(ld.getAnchor("drink"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
          <input name="drink_5" class="edit_input" type="text" value="<%=ld.getQuantity("drink")%>" maxlength="3" size="4">
        </TD>
      </TR>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Children")%>:</TD>
        <TD><input  id="CHECKBOX" type="CHECKBOX" name="children" value="checkbox"  <%=getCheck(ld.getIstype("children"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="children_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("children"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="children_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("children"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="children_3" type="text" class="edit_input" value="<%=ld.getSequence("children")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="children_4"   <%=getCheck(ld.getAnchor("children"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
          <input name="children_5" class="edit_input" type="text" value="<%=ld.getQuantity("children")%>" maxlength="3" size="4">
        </TD>
      </TR>
      <!--tr>
        <td colspan="2"><hr size="1"></td>
      </tr>
      <tr>
        <td></td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onclick="fshow()"  >
          <%=r.getString(teasession._nLanguage, "SelectAll")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input   class="edit_input" name="objbefore1"  mask="max" onfocus="fbefore()"  onchange="fbefore()" value="" type="text">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onchange="fafter()" value="" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<a href="#" onclick="fsequ()"  ><%=r.getString(teasession._nLanguage, "Default")%></a>
          <input  id="CHECKBOX" type="CHECKBOX" name="objanchor_4" onclick="fanchor()"  >
          <%=r.getString(teasession._nLanguage, "SelectAll")%> </td>
      </tr-->
    </table>
    <center >
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

