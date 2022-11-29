<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/resource/SOrder");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
    response.sendError(403);
    return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,66,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "SOrderDetail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="Node" VALUE="<%=iNode%>">
    <input type="hidden" name="ListingType" value="66"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td ><%=r.getString(teasession._nLanguage, "Code")%>: </td>
    <td >
        <input  id="CHECKBOX" type="CHECKBOX" name="code" value="checkbox"  <%=getCheck(ld.getIstype("code"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<td ><%=r.getString(teasession._nLanguage, "Before")%><input name="code_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("code"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="code_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("code"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="code_3" type="text" value="<%=ld.getSequence("code")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="code_4"   <%=getCheck(ld.getAnchor("code"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>: </td>
    <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="Subject" value="checkbox"  <%=getCheck(ld.getIstype("Subject"))%>><%=r.getString(teasession._nLanguage, "Show")%></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="Subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Subject"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="Subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Subject"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Subject_3" type="text" value="<%=ld.getSequence("Subject")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="Subject_4"   <%=getCheck(ld.getAnchor("Subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "Phone")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="phone" value="checkbox"  <%=getCheck(ld.getIstype("phone"))%>><%=r.getString(teasession._nLanguage, "Show")%></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="phone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("phone"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="phone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("phone"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="phone_3" type="text" value="<%=ld.getSequence("phone")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="phone_4"   <%=getCheck(ld.getAnchor("phone"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="address" value="checkbox"  <%=getCheck(ld.getIstype("address"))%>><%=r.getString(teasession._nLanguage, "Show")%></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="address_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("address"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="address_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("address"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="address_3" type="text" value="<%=ld.getSequence("address")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="address_4"   <%=getCheck(ld.getAnchor("address"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Bespeak")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="bespeak" value="checkbox"  <%=getCheck(ld.getIstype("bespeak"))%>><%=r.getString(teasession._nLanguage, "Show")%></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="bespeak_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bespeak"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="bespeak_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bespeak"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="bespeak_3" type="text" value="<%=ld.getSequence("bespeak")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="bespeak_4"   <%=getCheck(ld.getAnchor("bespeak"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Total")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="total" value="checkbox"  <%=getCheck(ld.getIstype("total"))%>><%=r.getString(teasession._nLanguage, "Show")%></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="total_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("total"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="total_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("total"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="total_3" type="text" value="<%=ld.getSequence("total")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="total_4"   <%=getCheck(ld.getAnchor("total"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Service")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="service" value="checkbox"  <%=getCheck(ld.getIstype("service"))%>><%=r.getString(teasession._nLanguage, "Show")%></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="service_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("service"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="service_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("service"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="service_3" type="text" value="<%=ld.getSequence("service")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="service_4"   <%=getCheck(ld.getAnchor("service"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td>期望作业员<%//=r.getString(teasession._nLanguage, "exwaiter")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="exwaiter" value="checkbox"  <%=getCheck(ld.getIstype("exwaiter"))%>><%=r.getString(teasession._nLanguage, "Show")%></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="exwaiter_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("exwaiter"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="exwaiter_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("exwaiter"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="exwaiter_3" type="text" value="<%=ld.getSequence("exwaiter")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="exwaiter_4"   <%=getCheck(ld.getAnchor("exwaiter"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
     <tr>
    <td>客户意见<%//=r.getString(teasession._nLanguage, "exwaiter")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="idea" value="checkbox"  <%=getCheck(ld.getIstype("idea"))%>><%=r.getString(teasession._nLanguage, "Show")%></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="idea_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("idea"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="idea_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("idea"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="idea_3" type="text" value="<%=ld.getSequence("idea")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="idea_4"   <%=getCheck(ld.getAnchor("idea"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
       <tr>
    <td>客户反馈<%//=r.getString(teasession._nLanguage, "exwaiter")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="feedback" value="checkbox"  <%=getCheck(ld.getIstype("feedback"))%>><%=r.getString(teasession._nLanguage, "Show")%></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="feedback_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("feedback"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="feedback_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("feedback"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="feedback_3" type="text" value="<%=ld.getSequence("feedback")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="feedback_4"   <%=getCheck(ld.getAnchor("feedback"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td>完成日期<%//=r.getString(teasession._nLanguage, "exwaiter")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="signtime" value="checkbox"  <%=getCheck(ld.getIstype("signtime"))%>><%=r.getString(teasession._nLanguage, "Show")%></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="signtime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("signtime"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="signtime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("signtime"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="signtime_3" type="text" value="<%=ld.getSequence("signtime")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="signtime_4"   <%=getCheck(ld.getAnchor("signtime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>     <tr>
      <td colspan="20"><hr size="1" />
      </td></tr>
  <tr>
      <td>
      </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onClick="fshow()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%><td>
          <%=r.getString(teasession._nLanguage, "Before")%><input   class="edit_input" name="objbefore1"  mask="max" onFocus="fbefore()"  onchange="fbefore()" value="" type="text">
              <%=r.getString(teasession._nLanguage, "After")%><input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onChange="fafter()" value="" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<a href="#" onClick="fsequ()"  ><%=r.getString(teasession._nLanguage, "Default")%></a>   <input  id="CHECKBOX" type="CHECKBOX" name="objanchor4" onClick="fanchor()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
                                                </td>
                      </tr>
</table><center>
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</center>  </form>

  <script>
  function fshow()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)!="4")
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
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)=="4")
          {
              form1.elements[counter].checked=form1.elements["objanchor4"].checked;
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
 <SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.Subject_1.focus();</SCRIPT>
 <div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

