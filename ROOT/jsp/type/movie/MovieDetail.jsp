<%@page contentType="text/html;charset=UTF-8"  %>
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

r.add("/tea/resource/Interlocution");

ListingDetail ld=ListingDetail.find(iListing,89,teasession._nLanguage);
String title=r.getString(teasession._nLanguage, "Movie")+r.getString(teasession._nLanguage, "Detail");

ld.isExists("name");
%><html>
<head>
<title><%=title%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function f_seq()
{
  var is=document.getElementsByTagName("INPUT");
  for(var i=0,j=0;i<is.length;i++)
  {
    if(is[i].name.indexOf("_3")!=-1)
    {
      is[i].value=j++*10;
    }
  }
}
</script>
</head>
<body
<%
if(!ld.isExists("name"))
{

out.print("onload=\"f_seq();\"");
}
%>>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type="hidden" name="ListingType" value="89"/>
<input type="hidden" name="Listing" value="<%=iListing%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<%
if(!flag)
{
  out.print("<input type='hidden' name='PickNode' value="+request.getParameter("PickNode")+" />");
}else
{
  out.print("<input type='hidden' name='PickManual' value="+request.getParameter("PickManual")+" />");
}
if(request.getParameter("Edit")!=null)
{
  out.print("<input type='hidden' name='Edit' value="+request.getParameter("Edit")+" />");
}
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
    <td>
    <select name="name">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("name"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="name_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text"/>
      <%=r.getString(teasession._nLanguage, "After")%><input name="name_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" class="edit_input" type="text" value="<%=ld.getSequence("name")%>" mask="int" maxlength="3" size="4"/>
          <input  id=CHECKBOX type="CHECKBOX" name="name_4"  <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
          <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="name_5" class="edit_input" type="text" value="<%=ld.getQuantity("name")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
<!--添加-->
  <tr>
    <td><%=r.getString(teasession._nLanguage, "mvpic")%>:</td>
    <td>
      <select name="mvpic">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("mvpic"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="mvpic_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mvpic"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="mvpic_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mvpic"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mvpic_3" class="edit_input" type="text" value="<%=ld.getSequence("mvpic")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="mvpic_4"  <%=getCheck(ld.getAnchor("mvpic"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "performer")%>:</td>
    <td>
      <select name="performer">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("performer"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="performer_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("performer"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="performer_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("performer"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="performer_3" class="edit_input" type="text" value="<%=ld.getSequence("performer")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="performer_4"  <%=getCheck(ld.getAnchor("performer"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "direct")%>:</td>
    <td>
      <select name="direct">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("direct"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="direct_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("direct"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="direct_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("direct"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="direct_3" class="edit_input" type="text" value="<%=ld.getSequence("direct")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="direct_4"  <%=getCheck(ld.getAnchor("direct"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "mvcountry")%>:</td>
    <td>
      <select name="country">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("country"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="country_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("country"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="country_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("country"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="country_3" class="edit_input" type="text" value="<%=ld.getSequence("country")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="country_4"  <%=getCheck(ld.getAnchor("country"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "mvtype")%>:</td>
    <td>
      <select name="mvtype">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("mvtype"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="mvtype_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mvtype"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="mvtype_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mvtype"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mvtype_3" class="edit_input" type="text" value="<%=ld.getSequence("mvtype")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="mvtype_4"  <%=getCheck(ld.getAnchor("mvtype"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "mvmaking")%>:</td>
    <td>
      <select name="mvmaking">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("mvmaking"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="mvmaking_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mvmaking"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="mvmaking_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mvmaking"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mvmaking_3" class="edit_input" type="text" value="<%=ld.getSequence("mvmaking")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="mvmaking_4"  <%=getCheck(ld.getAnchor("mvmaking"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "mvgrade")%>:</td>
    <td>
      <select name="mvgrade">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("mvgrade"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="mvgrade_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mvgrade"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="mvgrade_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mvgrade"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mvgrade_3" class="edit_input" type="text" value="<%=ld.getSequence("mvgrade")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="mvgrade_4"  <%=getCheck(ld.getAnchor("mvgrade"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "publisher")%>:</td>
    <td>
      <select name="publisher">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("publisher"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="publisher_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("publisher"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="publisher_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("publisher"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="publisher_3" class="edit_input" type="text" value="<%=ld.getSequence("publisher")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="publisher_4"  <%=getCheck(ld.getAnchor("publisher"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "mvyear")%>:</td>
    <td>
      <select name="mvyear">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("mvyear"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="mvyear_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mvyear"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="mvyear_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mvyear"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mvyear_3" class="edit_input" type="text" value="<%=ld.getSequence("mvyear")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="mvyear_4"  <%=getCheck(ld.getAnchor("mvyear"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "mvaward")%>:</td>
    <td>
      <select name="mvaward">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("mvaward"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="mvaward_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mvaward"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="mvaward_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mvaward"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mvaward_3" class="edit_input" type="text" value="<%=ld.getSequence("mvaward")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="mvaward_4"  <%=getCheck(ld.getAnchor("mvaward"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "mvcontent")%>:</td>
    <td>
      <select name="mvcontent">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("mvcontent"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="mvcontent_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mvcontent"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="mvcontent_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mvcontent"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mvcontent_3" class="edit_input" type="text" value="<%=ld.getSequence("mvcontent")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="mvcontent_4"  <%=getCheck(ld.getAnchor("mvcontent"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "behindcontent")%>:</td>
    <td>
      <select name="behindcontent">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("behindcontent"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="behindcontent_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("behindcontent"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="behindcontent_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("behindcontent"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="behindcontent_3" class="edit_input" type="text" value="<%=ld.getSequence("behindcontent")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="behindcontent_4"  <%=getCheck(ld.getAnchor("behindcontent"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "languagetype")%>:</td>
    <td>
      <select name="languagetype">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("languagetype"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="languagetype_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("languagetype"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="languagetype_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("languagetype"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="languagetype_3" class="edit_input" type="text" value="<%=ld.getSequence("languagetype")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="languagetype_4"  <%=getCheck(ld.getAnchor("languagetype"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "mvprice")%>:</td>
    <td>
      <select name="mvprice">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("mvprice"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="mvprice_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mvprice"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="mvprice_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mvprice"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mvprice_3" class="edit_input" type="text" value="<%=ld.getSequence("mvprice")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="mvprice_4"  <%=getCheck(ld.getAnchor("mvprice"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
      <tr>
    <td><%=r.getString(teasession._nLanguage, "mvpath")%>:</td>
    <td>
      <select name="mvpath">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("mvpath"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="mvpath_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mvpath"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="mvpath_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mvpath"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="mvpath_3" class="edit_input" type="text" value="<%=ld.getSequence("mvpath")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="mvpath_4"  <%=getCheck(ld.getAnchor("mvpath"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "IssueTime")%>:</td>
    <td>      <select name="IssueTime">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("IssueTime"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="IssueTime_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("IssueTime"))%>" type="text"/>
       <%=r.getString(teasession._nLanguage, "After")%><input name="IssueTime_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("IssueTime"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="IssueTime_3" class="edit_input" type="text" value="<%=ld.getSequence("IssueTime")%>" mask="int" maxlength="3" size="4"/>
    <input  id=CHECKBOX type="CHECKBOX" name="IssueTime_4"  <%=getCheck(ld.getAnchor("IssueTime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
  </tr>
</table>
<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>
</DIV>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>
