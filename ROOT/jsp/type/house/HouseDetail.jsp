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

r.add("/tea/resource/Interlocution");

ListingDetail ld=ListingDetail.find(iListing,91,teasession._nLanguage);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Interlocution")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
    <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="91"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
    <%        }else{%>
    <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
    <%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

    <TABLE border="0" CELLPADDING="0" CELLSPACING="0"  id="tablecenter">
    <tr>
    <td><%=r.getString(teasession._nLanguage, "HouseName")%>:</td>
    <td>
      <select name="subject">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("subject"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" class="edit_input" type="text" value="<%=ld.getSequence("subject")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="subject_4"  <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
<tr>
    <td><%=r.getString(teasession._nLanguage, "huxing")%>:</td>
    <td>
      <select name="huxing">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("huxing"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="huxing_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("huxing"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="huxing_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("huxing"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="huxing_3" class="edit_input" type="text" value="<%=ld.getSequence("huxing")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="huxing_4"  <%=getCheck(ld.getAnchor("huxing"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "housesizes")%>:</td>
    <td>
      <select name="sizes">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("sizes"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="sizes_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sizes"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="sizes_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sizes"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="sizes_3" class="edit_input" type="text" value="<%=ld.getSequence("sizes")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="sizes_4"  <%=getCheck(ld.getAnchor("sizes"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "toward")%>:</td>
    <td>
      <select name="toward">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("toward"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="toward_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("toward"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="toward_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("toward"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="toward_3" class="edit_input" type="text" value="<%=ld.getSequence("toward")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="toward_4"  <%=getCheck(ld.getAnchor("toward"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "floor")%>:</td>
    <td>
      <select name="floor">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("floor"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="floor_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("floor"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="floor_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("floor"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="floor_3" class="edit_input" type="text" value="<%=ld.getSequence("floor")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="floor_4"  <%=getCheck(ld.getAnchor("floor"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "address")%>:</td>
    <td>
      <select name="address">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("address"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="address_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("address"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="address_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("address"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="address_3" class="edit_input" type="text" value="<%=ld.getSequence("address")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="address_4"  <%=getCheck(ld.getAnchor("address"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "houseprice")%>:</td>
    <td>
      <select name="price">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("price"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="price_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="price_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="price_3" class="edit_input" type="text" value="<%=ld.getSequence("price")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="price_4"  <%=getCheck(ld.getAnchor("price"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "average")%>:</td>
    <td>
      <select name="average">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("average"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="average_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("average"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="average_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("average"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="average_3" class="edit_input" type="text" value="<%=ld.getSequence("average")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="average_4"  <%=getCheck(ld.getAnchor("average"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "huxingpic")%>:</td>
    <td>
      <select name="huxingpic">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("huxingpic"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="huxingpic_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("huxingpic"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="huxingpic_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("huxingpic"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="huxingpic_3" class="edit_input" type="text" value="<%=ld.getSequence("huxingpic")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="huxingpic_4"  <%=getCheck(ld.getAnchor("huxingpic"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "impactpic")%>:</td>
    <td>
      <select name="impactpic">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("impactpic"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="impactpic_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("impactpic"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="impactpic_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("impactpic"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="impactpic_3" class="edit_input" type="text" value="<%=ld.getSequence("impactpic")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="impactpic_4"  <%=getCheck(ld.getAnchor("impactpic"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "facilities")%>:</td>
    <td>
      <select name="facilities">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("facilities"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="facilities_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("facilities"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="facilities_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("facilities"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="facilities_3" class="edit_input" type="text" value="<%=ld.getSequence("facilities")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="facilities_4"  <%=getCheck(ld.getAnchor("facilities"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "xiaoqu")%>:</td>
    <td>
      <select name="xiaoqu">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("xiaoqu"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="xiaoqu_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("xiaoqu"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="xiaoqu_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("xiaoqu"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="xiaoqu_3" class="edit_input" type="text" value="<%=ld.getSequence("xiaoqu")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="xiaoqu_4"  <%=getCheck(ld.getAnchor("xiaoqu"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
<tr>
    <td><%=r.getString(teasession._nLanguage, "content")%>:</td>
    <td>
      <select name="content">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("content"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="content_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("content"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="content_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("content"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="content_3" class="edit_input" type="text" value="<%=ld.getSequence("content")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="content_4"  <%=getCheck(ld.getAnchor("content"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
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

