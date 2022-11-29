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

            //DropDown dropdown = new DropDown("Format", book.getFormat());

ListingDetail ld=ListingDetail.find(iListing,111,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
 <h1><%=r.getString(teasession._nLanguage, "Detail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
<input type='hidden' name="Node" value="<%=iNode%>">
<input type="hidden" name="ListingType" value="111"/>
<%if(!flag){%>
<input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
<input type="hidden" name="Listing" value="<%=iListing%>"/>
  <INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">
  <TABLE  CELLSPACING=0 CELLPADDING=0 border="0" id="tablecenter">
    <TR>
      <Td><%=r.getString(teasession._nLanguage, "Subject")%>:</Td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <Td><%=r.getString(teasession._nLanguage, "公司简称")%>:</Td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="name_3" type="text" class="edit_input" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="name_4"   <%=getCheck(ld.getAnchor("name"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="name_5" class="edit_input" type="text" value="<%=ld.getQuantity("name")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <Td><%=r.getString(teasession._nLanguage, "成立时间")%>:</Td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="time" value="checkbox"  <%=getCheck(ld.getIstype("time"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="time_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("time"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="time_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("time"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="time_3" type="text" class="edit_input" value="<%=ld.getSequence("time")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="time_4"   <%=getCheck(ld.getAnchor("time"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="time_5" class="edit_input" type="text" value="<%=ld.getQuantity("time")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <Td><%=r.getString(teasession._nLanguage, "地区")%>:</Td>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="city" value="checkbox"  <%=getCheck(ld.getIstype("city"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="city_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("city"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="city_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("city"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="city_3" type="text" class="edit_input" value="<%=ld.getSequence("city")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="city_4"   <%=getCheck(ld.getAnchor("city"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="city_5" class="edit_input" type="text" value="<%=ld.getQuantity("city")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "注册资本")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="regMoney" value="checkbox"  <%=getCheck(ld.getIstype("regMoney"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="regMoney_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("regMoney"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="regMoney_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("regMoney"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="regMoney_3" type="text" class="edit_input" value="<%=ld.getSequence("regMoney")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="regMoney_4"   <%=getCheck(ld.getAnchor("regMoney"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="regMoney_5" class="edit_input" type="text" value="<%=ld.getQuantity("regMoney")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "法人代表")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="legalPerson" value="checkbox"  <%=getCheck(ld.getIstype("legalPerson"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="legalPerson_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("legalPerson"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="legalPerson_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("legalPerson"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="legalPerson_3" type="text" class="edit_input" value="<%=ld.getSequence("legalPerson")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="legalPerson_4"   <%=getCheck(ld.getAnchor("legalPerson"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="legalPerson_5" class="edit_input" type="text" value="<%=ld.getQuantity("legalPerson")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "董事长")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="chairman" value="checkbox"  <%=getCheck(ld.getIstype("chairman"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="chairman_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("chairman"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="chairman_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("chairman"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="chairman_3" type="text" class="edit_input" value="<%=ld.getSequence("chairman")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="chairman_4"   <%=getCheck(ld.getAnchor("chairman"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="chairman_5" class="edit_input" type="text" value="<%=ld.getQuantity("chairman")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "大股东")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="bigShareholders" value="checkbox"  <%=getCheck(ld.getIstype("bigShareholders"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="bigShareholders_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bigShareholders"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="bigShareholders_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bigShareholders"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="bigShareholders_3" type="text" class="edit_input" value="<%=ld.getSequence("bigShareholders")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="bigShareholders_4"   <%=getCheck(ld.getAnchor("bigShareholders"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="bigShareholders_5" class="edit_input" type="text" value="<%=ld.getQuantity("bigShareholders")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "经营范围")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="scopeOf" value="checkbox"  <%=getCheck(ld.getIstype("scopeOf"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="scopeOf_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("scopeOf"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="scopeOf_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("scopeOf"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="scopeOf_3" type="text" class="edit_input" value="<%=ld.getSequence("scopeOf")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="scopeOf_4"   <%=getCheck(ld.getAnchor("scopeOf"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="scopeOf_5" class="edit_input" type="text" value="<%=ld.getQuantity("scopeOf")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "是否上市")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="isListed" value="checkbox"  <%=getCheck(ld.getIstype("isListed"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="isListed_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("isListed"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="isListed_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("isListed"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="isListed_3" type="text" class="edit_input" value="<%=ld.getSequence("isListed")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="isListed_4"   <%=getCheck(ld.getAnchor("isListed"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="isListed_5" class="edit_input" type="text" value="<%=ld.getQuantity("isListed")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "股东背景")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="background" value="checkbox"  <%=getCheck(ld.getIstype("background"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="background_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("background"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="background_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("background"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="background_3" type="text" class="edit_input" value="<%=ld.getSequence("background")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="background_4"   <%=getCheck(ld.getAnchor("background"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="background_5" class="edit_input" type="text" value="<%=ld.getQuantity("background")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "图片")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="logo" value="checkbox"  <%=getCheck(ld.getIstype("logo"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="logo_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("logo"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="logo_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("logo"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="logo_3" type="text" class="edit_input" value="<%=ld.getSequence("logo")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="logo_4"   <%=getCheck(ld.getAnchor("logo"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="logo_5" class="edit_input" type="text" value="<%=ld.getQuantity("logo")%>" maxlength="3" size="4"> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "收益率")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="yield" value="checkbox"  <%=getCheck(ld.getIstype("yield"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="yield_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("yield"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="yield_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("yield"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="yield_3" type="text" class="edit_input" value="<%=ld.getSequence("yield")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="yield_4"   <%=getCheck(ld.getAnchor("yield"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="yield_5" class="edit_input" type="text" value="<%=ld.getQuantity("yield")%>" maxlength="3" size="4"> </TD>
    </TR>
    
    
  </TABLE>
  <INPUT TYPE=SUBMIT NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
  <INPUT TYPE=SUBMIT NAME="GoFinish" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
</FORM>
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
</body></html>

