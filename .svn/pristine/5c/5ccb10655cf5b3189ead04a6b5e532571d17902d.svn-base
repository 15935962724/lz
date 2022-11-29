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

ListingDetail ld=ListingDetail.find(iListing,88,teasession._nLanguage);

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
    <input type="hidden" name="ListingType" value="88"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
    <%        }else{%>
    <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
    <%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

    <TABLE border="0" CELLPADDING="0" CELLSPACING="0"  id="tablecenter">
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
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

      <!--后添加的元素-->
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Primarydata")%>:</td>
    <td>
      <select name="_nPrimarydata">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("_nPrimarydata"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="_nPrimarydata_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("_nPrimarydata"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="_nPrimarydata_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("_nPrimarydata"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="_nPrimarydata_3" class="edit_input" type="text" value="<%=ld.getSequence("_nPrimarydata")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="_nPrimarydata_4"  <%=getCheck(ld.getAnchor("_nPrimarydata"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Cuisines")%>:</td>
    <td>
      <select name="_nCuisines">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("_nCuisines"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="_nCuisines_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("_nCuisines"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="_nCuisines_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("_nCuisines"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="_nCuisines_3" class="edit_input" type="text" value="<%=ld.getSequence("_nCuisines")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="_nCuisines_4"  <%=getCheck(ld.getAnchor("_nCuisines"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Taste")%>:</td>
    <td>
      <select name="_nTaste">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("_nTaste"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="_nTaste_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("_nTaste"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="_nTaste_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("_nTaste"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="_nTaste_3" class="edit_input" type="text" value="<%=ld.getSequence("_nTaste")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="_nTaste_4"  <%=getCheck(ld.getAnchor("_nTaste"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "country")%>:</td>
    <td>
      <select name="_ncountry">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("_ncountry"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="_ncountry_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("_ncountry"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="_ncountry_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("_ncountry"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="_ncountry_3" class="edit_input" type="text" value="<%=ld.getSequence("_ncountry")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="_ncountry_4"  <%=getCheck(ld.getAnchor("_ncountry"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Nutrient")%>:</td>
    <td>
      <select name="_nNutrient">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("_nNutrient"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="_nNutrient_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("_nNutrient"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="_nNutrient_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("_nNutrient"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="_nNutrient_3" class="edit_input" type="text" value="<%=ld.getSequence("_nNutrient")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="_nNutrient_4"  <%=getCheck(ld.getAnchor("_nNutrient"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Efficacity")%>:</td>
    <td>
      <select name="_nEfficacity">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("_nEfficacity"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="_nEfficacity_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("_nEfficacity"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="_nEfficacity_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("_nEfficacity"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="_nEfficacity_3" class="edit_input" type="text" value="<%=ld.getSequence("_nEfficacity")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="_nEfficacity_4"  <%=getCheck(ld.getAnchor("_nEfficacity"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "method")%>:</td>
    <td>
      <select name="_nmethod">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("_nmethod"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="_nmethod_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("_nmethod"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="_nmethod_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("_nmethod"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="_nmethod_3" class="edit_input" type="text" value="<%=ld.getSequence("_nmethod")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="_nmethod_4"  <%=getCheck(ld.getAnchor("_nmethod"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>


    <tr>
    <td><%=r.getString(teasession._nLanguage, "picture")%>:</td>
    <td>
      <select name="picture">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("picture"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="picture_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("picture"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="picture_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("picture"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="picture_3" class="edit_input" type="text" value="<%=ld.getSequence("picture")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="picture_4"  <%=getCheck(ld.getAnchor("picture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "mouthfeel")%>:</td>
    <td>
      <select name="_mouthfeel">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("_mouthfeel"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="_mouthfeel_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("_mouthfeel"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="_mouthfeel_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("_mouthfeel"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="_mouthfeel_3" class="edit_input" type="text" value="<%=ld.getSequence("_mouthfeel")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="_mouthfeel_4"  <%=getCheck(ld.getAnchor("_mouthfeel"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
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
    <td><%=r.getString(teasession._nLanguage, "dishprice")%>:</td>
    <td>
      <select name="dishprice">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("dishprice"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="dishprice_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("dishprice"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="dishprice_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("dishprice"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="dishprice_3" class="edit_input" type="text" value="<%=ld.getSequence("dishprice")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="dishprice_4"  <%=getCheck(ld.getAnchor("dishprice"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
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

