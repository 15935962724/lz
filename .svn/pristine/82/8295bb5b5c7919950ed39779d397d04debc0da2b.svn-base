<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
int purview=node.isCreator(teasession._rv)?3:AccessMember.find(iNode,teasession._rv._strV).getPurview();
if(purview<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,42,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAddToBriefcase")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
  <input type='hidden' name="node" value="<%=iNode%>">
  <input type="hidden" name="ListingType" value="42"/>
  <%if(!flag){%>
  <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
  <%        }else{%>
  <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
  <%   }%>
  <input type="hidden" name="Listing" value="<%=iListing%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Name")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="xm" value="checkbox"  <%=getCheck(ld.getIstype("xm"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="xm_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("xm"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="xm_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("xm"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="xm_3" type="text" class="edit_input" value="<%=ld.getSequence("xm")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="xm_4"   <%=getCheck(ld.getAnchor("xm"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="xm_5" class="edit_input" type="text" value="<%=ld.getQuantity("xm")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Sex")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="xb" value="checkbox"  <%=getCheck(ld.getIstype("xb"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="xb_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("xb"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="xb_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("xb"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="xb_3" type="text" class="edit_input" value="<%=ld.getSequence("xb")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="xb_4"   <%=getCheck(ld.getAnchor("xb"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "csny1")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="csny" value="checkbox"  <%=getCheck(ld.getIstype("csny"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="csny_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("csny"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="csny_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("csny"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="csny_3" type="text" class="edit_input" value="<%=ld.getSequence("csny")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="csny_4"   <%=getCheck(ld.getAnchor("csny"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "xl1")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="xl" value="checkbox"  <%=getCheck(ld.getIstype("xl"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="xl_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("xl"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="xl_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("xl"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="xl_3" type="text" class="edit_input" value="<%=ld.getSequence("xl")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="xl_4"   <%=getCheck(ld.getAnchor("xl"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "xw")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="xw" value="checkbox"  <%=getCheck(ld.getIstype("xw"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="xw_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("xw"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="xw_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("xw"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="xw_3" type="text" class="edit_input" value="<%=ld.getSequence("xw")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="xw_4"   <%=getCheck(ld.getAnchor("xw"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "zw")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="zw" value="checkbox"  <%=getCheck(ld.getIstype("zw"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="zw_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("zw"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="zw_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("zw"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="zw_3" type="text" class="edit_input" value="<%=ld.getSequence("zw")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="zw_4"   <%=getCheck(ld.getAnchor("zw"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "csny")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="cjgzsj" value="checkbox"  <%=getCheck(ld.getIstype("cjgzsj"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="cjgzsj_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("cjgzsj"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="cjgzsj_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("cjgzsj"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="cjgzsj_3" type="text" class="edit_input" value="<%=ld.getSequence("cjgzsj")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="cjgzsj_4"   <%=getCheck(ld.getAnchor("cjgzsj"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "xdw")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="xdw" value="checkbox"  <%=getCheck(ld.getIstype("xdw"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="xdw_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("xdw"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="xdw_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("xdw"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="xdw_3" type="text" class="edit_input" value="<%=ld.getSequence("xdw")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="xdw_4"   <%=getCheck(ld.getAnchor("xdw"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="xdw_5" class="edit_input" type="xdw" value="<%=ld.getQuantity("xdw")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "xbw")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="xbm" value="checkbox"  <%=getCheck(ld.getIstype("xbm"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="xbm_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("xbm"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="xbm_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("xbm"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="xbm_3" type="text" class="edit_input" value="<%=ld.getSequence("xbm")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="xbm_4"   <%=getCheck(ld.getAnchor("xbm"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TD><%=r.getString(teasession._nLanguage, "xgw")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="xgw" value="checkbox"  <%=getCheck(ld.getIstype("xgw"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="xgw_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("xgw"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="xgw_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("xgw"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="xgw_3" type="text" class="edit_input" value="<%=ld.getSequence("xgw")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="xgw_4"   <%=getCheck(ld.getAnchor("xgw"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="xgw_5" class="edit_input" type="text" value="<%=ld.getQuantity("xgw")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TD><%=r.getString(teasession._nLanguage, "phone")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="phone" value="checkbox"  <%=getCheck(ld.getIstype("phone"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="phone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("phone"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="phone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("phone"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="phone_3" type="text" class="edit_input" value="<%=ld.getSequence("phone")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="phone_4"   <%=getCheck(ld.getAnchor("phone"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="phone_5" class="edit_input" type="text" value="<%=ld.getQuantity("phone")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TD><%=r.getString(teasession._nLanguage, "mobile")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="mobile" value="checkbox"  <%=getCheck(ld.getIstype("mobile"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="mobile_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mobile"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="mobile_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mobile"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="mobile_3" type="text" class="edit_input" value="<%=ld.getSequence("mobile")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="mobile_4"   <%=getCheck(ld.getAnchor("mobile"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="mobile_5" class="edit_input" type="text" value="<%=ld.getQuantity("mobile")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TD><%=r.getString(teasession._nLanguage, "sqrq")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="sqrq" value="checkbox"  <%=getCheck(ld.getIstype("sqrq"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="sqrq_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sqrq"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="sqrq_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sqrq"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="sqrq_3" type="text" class="edit_input" value="<%=ld.getSequence("sqrq")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="sqrq_4"   <%=getCheck(ld.getAnchor("sqrq"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="sqrq_5" class="edit_input" type="text" value="<%=ld.getQuantity("sqrq")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TD><%=r.getString(teasession._nLanguage, "email")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="email" value="checkbox"  <%=getCheck(ld.getIstype("email"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="email_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("email"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="email_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("email"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="email_3" type="text" class="edit_input" value="<%=ld.getSequence("email")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="email_4"   <%=getCheck(ld.getAnchor("email"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="email_5" class="edit_input" type="text" value="<%=ld.getQuantity("email")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TD><%=r.getString(teasession._nLanguage, "File")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="file" value="checkbox"  <%=getCheck(ld.getIstype("file"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="file_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("file"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="file_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("file"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="file_3" type="text" class="edit_input" value="<%=ld.getSequence("file")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="file_4"   <%=getCheck(ld.getAnchor("file"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
        <input name="file_5" class="edit_input" type="text" value="<%=ld.getQuantity("file")%>" maxlength="3" size="4">
      </TD>
    </tr>
    <tr>
      <td colspan="2"><hr size="1"></td>
    </tr>
    <tr>
      <td></td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onClick="fshow()"  >
        <%=r.getString(teasession._nLanguage, "SelectAll")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input   class="edit_input" name="objbefore1"  mask="max" onFocus="fbefore()"  onchange="fbefore()" value="" type="text">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onChange="fafter()" value="" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<a href="#" onClick="fsequ()"  ><%=r.getString(teasession._nLanguage, "Default")%></a>
        <input  id="CHECKBOX" type="CHECKBOX" name="objanchor_4" onClick="fanchor()"  >
        <%=r.getString(teasession._nLanguage, "SelectAll")%> </td>
    </tr>
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
<SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.xm_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
