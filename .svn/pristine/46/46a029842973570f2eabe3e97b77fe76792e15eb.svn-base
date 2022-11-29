<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/resource/Service");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int nodeid  = Listing.find(iListing).getNode();
Node node = Node.find(nodeid);

if(!node.isCreator(teasession._rv)&&AccessMember.find(nodeid,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,65,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ServiceDetail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="node" VALUE="<%=nodeid%>">
<input type="hidden" name="Listing" value="<%=iListing%>">
<input type="hidden" name="ListingType" value="65"/>
<%
if(!flag)
{
  out.print("<input type=hidden name=PickNode value="+request.getParameter("PickNode")+">");
}else
{
  out.print("<input type=hidden name=PickManual value="+request.getParameter("PickManual")+">");
}
%>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td ><%=r.getString(teasession._nLanguage, "Code")%>: </td>
    <td >      <select name="code">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("code")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<td ><%=r.getString(teasession._nLanguage, "Before")%><input name="code_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("code"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="code_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("code"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="code_3" type="text" value="<%=ld.getSequence("code")%>" mask="int" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="code_4"   <%=getCheck(ld.getAnchor("code"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>: </td>
    <td>      <select name="Subject">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("Subject")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<td><%=r.getString(teasession._nLanguage, "Before")%><input name="Subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Subject"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="Subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Subject"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Subject_3" type="text" value="<%=ld.getSequence("Subject")%>" mask="int" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="Subject_4"   <%=getCheck(ld.getAnchor("Subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
     </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Unit")%>:</td>
        <td>      <select name="unit">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("unit")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="unit_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("unit"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="unit_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("unit"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="unit_3" type="text" value="<%=ld.getSequence("unit")%>" mask="int" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="unit_4"   <%=getCheck(ld.getAnchor("unit"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Synopsis")%>:</td>
        <td>      <select name="synopsis">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("synopsis")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td>
      <td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="synopsis_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("synopsis"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="synopsis_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("synopsis"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="synopsis_3" type="text" value="<%=ld.getSequence("synopsis")%>" mask="int" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="synopsis_4"   <%=getCheck(ld.getAnchor("synopsis"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Price")%>:</td>
        <td>      <select name="price">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("price")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="price_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="price_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="price_3" type="text" value="<%=ld.getSequence("price")%>" mask="int" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="price_4"   <%=getCheck(ld.getAnchor("price"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Quality")%>:</td>
        <td>      <select name="quality">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("quality")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td>
      <td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="quality_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("quality"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="quality_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("quality"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="quality_3" type="text" value="<%=ld.getSequence("quality")%>" mask="int" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="quality_4"   <%=getCheck(ld.getAnchor("quality"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Point")%>:</td>
        <td>      <select name="point">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("point")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="point_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("point"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="point_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("point"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="point_3" type="text" value="<%=ld.getSequence("point")%>" mask="int" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="point_4"   <%=getCheck(ld.getAnchor("point"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
        <td>      <select name="picture">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("picture")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="picture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("picture"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="picture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("picture"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="picture_3" type="text" value="<%=ld.getSequence("picture")%>" mask="int" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="picture_4"   <%=getCheck(ld.getAnchor("picture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>2:</td>
        <td>      <select name="picture2">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("picture2")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="picture2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("picture2"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="picture2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("picture2"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="picture2_3" type="text" value="<%=ld.getSequence("picture2")%>" mask="int" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="picture2_4"   <%=getCheck(ld.getAnchor("picture2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr> <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
        <td>      <select name="text">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("text")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" type="text" value="<%=ld.getSequence("text")%>" mask="int" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    <tr> <td><%=r.getString(teasession._nLanguage, "Time")%>:</td>
        <td>      <select name="time">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("time")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="time_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("time"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="time_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("time"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="time_3" type="text" value="<%=ld.getSequence("time")%>" mask="int" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="time_4"   <%=getCheck(ld.getAnchor("time"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    <tr> <td><%=r.getString(teasession._nLanguage, "Type")%>:</td>
        <td>      <select name="type">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("type")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="type_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("type"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="type_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("type"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="type_3" type="text" value="<%=ld.getSequence("type")%>" mask="int" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="type_4"   <%=getCheck(ld.getAnchor("type"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
      <tr>   <td><%=r.getString(teasession._nLanguage, "Thing")%>:</td>
        <td>      <select name="thing">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("thing")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="thing_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("thing"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="thing_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("thing"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="thing_3" type="text" value="<%=ld.getSequence("thing")%>" mask="int" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="thing_4"   <%=getCheck(ld.getAnchor("thing"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr>   <td><%=r.getString(teasession._nLanguage, "Tools")%>:</td>
        <td>      <select name="tools">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("tools")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td><td>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="tools_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("tools"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="tools_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("tools"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="tools_3" type="text" value="<%=ld.getSequence("tools")%>" mask="int" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="tools_4"   <%=getCheck(ld.getAnchor("tools"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>  <tr>   <td><%=r.getString(teasession._nLanguage, "Destine")%>:</td>
        <td>      <select name="destine">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(ld.getIstype("destine")==st)out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select></td><td>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="destine_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("destine"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%><input name="destine_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("destine"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="destine_3" type="text" value="<%=ld.getSequence("destine")%>" mask="int" mask="int" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="destine_4"   <%=getCheck(ld.getAnchor("destine"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>

</table>

    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>

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

