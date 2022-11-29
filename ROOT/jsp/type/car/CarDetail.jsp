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

ListingDetail ld=ListingDetail.find(iListing,90,teasession._nLanguage);

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
    <input type="hidden" name="ListingType" value="90"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
    <%        }else{%>
    <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
    <%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

    <TABLE border="0" CELLPADDING="0" CELLSPACING="0"  id="tablecenter">
    <tr>
    <td><%=r.getString(teasession._nLanguage, "CarName")%>:</td>
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
    <td><%=r.getString(teasession._nLanguage, "carpic")%>:</td>
    <td>
      <select name="carpic">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("carpic"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="carpic_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("carpic"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="carpic_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("carpic"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="carpic_3" class="edit_input" type="text" value="<%=ld.getSequence("carpic")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="carpic_4"  <%=getCheck(ld.getAnchor("carpic"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
      <tr>
    <td><%=r.getString(teasession._nLanguage, "carstatic")%>:</td>
    <td>
      <select name="carstatic">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("carstatic"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="carstatic_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("carstatic"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="carstatic_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("carstatic"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="carstatic_3" class="edit_input" type="text" value="<%=ld.getSequence("carstatic")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="carstatic_4"  <%=getCheck(ld.getAnchor("carstatic"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "carclass")%>:</td>
    <td>
      <select name="carclass">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("carclass"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="carclass_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("carclass"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="carclass_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("carclass"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="carclass_3" class="edit_input" type="text" value="<%=ld.getSequence("carclass")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="carclass_4"  <%=getCheck(ld.getAnchor("carclass"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "carbrand")%>:</td>
    <td>
      <select name="carbrand">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("carbrand"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="carbrand_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("carbrand"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="carbrand_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("carbrand"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="carbrand_3" class="edit_input" type="text" value="<%=ld.getSequence("carbrand")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="carbrand_4"  <%=getCheck(ld.getAnchor("carbrand"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "cartype")%>:</td>
    <td>
      <select name="cartype">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("cartype"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="cartype_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("cartype"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="cartype_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("cartype"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="cartype_3" class="edit_input" type="text" value="<%=ld.getSequence("cartype")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="cartype_4"  <%=getCheck(ld.getAnchor("cartype"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
<tr>
    <td><%=r.getString(teasession._nLanguage, "carmiles")%>:</td>
    <td>
      <select name="carmiles">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("carmiles"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="carmiles_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("carmiles"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="carmiles_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("carmiles"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="carmiles_3" class="edit_input" type="text" value="<%=ld.getSequence("carmiles")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="carmiles_4"  <%=getCheck(ld.getAnchor("carmiles"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "caroil")%>:</td>
    <td>
      <select name="caroil">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("caroil"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="caroil_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("caroil"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="caroil_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("caroil"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="caroil_3" class="edit_input" type="text" value="<%=ld.getSequence("caroil")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="caroil_4"  <%=getCheck(ld.getAnchor("caroil"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "caremission")%>:</td>
    <td>
      <select name="caremission">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("caremission"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="caremission_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("caremission"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="caremission_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("caremission"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="caremission_3" class="edit_input" type="text" value="<%=ld.getSequence("caremission")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="caremission_4"  <%=getCheck(ld.getAnchor("caremission"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "carshape")%>:</td>
    <td>
      <select name="carshape">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("carshape"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="carshape_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("carshape"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="carshape_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("carshape"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="carshape_3" class="edit_input" type="text" value="<%=ld.getSequence("carshape")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="carshape_4"  <%=getCheck(ld.getAnchor("carshape"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "wheelbase")%>:</td>
    <td>
      <select name="wheelbase">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("wheelbase"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="wheelbase_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("wheelbase"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="wheelbase_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("wheelbase"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="wheelbase_3" class="edit_input" type="text" value="<%=ld.getSequence("wheelbase")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="wheelbase_4"  <%=getCheck(ld.getAnchor("wheelbase"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "maxoutput")%>:</td>
    <td>
      <select name="maxoutput">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("maxoutput"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="maxoutput_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("maxoutput"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="maxoutput_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("maxoutput"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="maxoutput_3" class="edit_input" type="text" value="<%=ld.getSequence("maxoutput")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="maxoutput_4"  <%=getCheck(ld.getAnchor("maxoutput"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "outcapacity")%>:</td>
    <td>
      <select name="outcapacity">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("outcapacity"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="outcapacity_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("outcapacity"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="outcapacity_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("outcapacity"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="outcapacity_3" class="edit_input" type="text" value="<%=ld.getSequence("outcapacity")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="outcapacity_4"  <%=getCheck(ld.getAnchor("outcapacity"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "engine")%>:</td>
    <td>
      <select name="engine">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("engine"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="engine_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("engine"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="engine_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("engine"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="engine_3" class="edit_input" type="text" value="<%=ld.getSequence("engine")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="engine_4"  <%=getCheck(ld.getAnchor("engine"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "acrotorque")%>:</td>
    <td>
      <select name="acrotorque">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("acrotorque"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="acrotorque_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("acrotorque"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="acrotorque_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("acrotorque"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="acrotorque_3" class="edit_input" type="text" value="<%=ld.getSequence("acrotorque")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="acrotorque_4"  <%=getCheck(ld.getAnchor("acrotorque"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "speedchanger")%>:</td>
    <td>
      <select name="speedchanger">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("speedchanger"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="speedchanger_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("speedchanger"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="speedchanger_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("speedchanger"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="speedchanger_3" class="edit_input" type="text" value="<%=ld.getSequence("speedchanger")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="speedchanger_4"  <%=getCheck(ld.getAnchor("speedchanger"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "drive")%>:</td>
    <td>
      <select name="drive">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("drive"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="drive_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("drive"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="drive_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("drive"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="drive_3" class="edit_input" type="text" value="<%=ld.getSequence("drive")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="drive_4"  <%=getCheck(ld.getAnchor("drive"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "volume")%>:</td>
    <td>
      <select name="volume">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("volume"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="volume_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("volume"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="volume_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("volume"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="volume_3" class="edit_input" type="text" value="<%=ld.getSequence("volume")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="volume_4"  <%=getCheck(ld.getAnchor("volume"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr><tr>
    <td><%=r.getString(teasession._nLanguage, "production")%>:</td>
    <td>
      <select name="production">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("production"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="production_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("production"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="production_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("production"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="production_3" class="edit_input" type="text" value="<%=ld.getSequence("production")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="production_4"  <%=getCheck(ld.getAnchor("production"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
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
    <td><%=r.getString(teasession._nLanguage, "carprice")%>:</td>
    <td>
      <select name="carprice">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("carprice"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="carprice_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("carprice"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="carprice_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("carprice"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="carprice_3" class="edit_input" type="text" value="<%=ld.getSequence("carprice")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="carprice_4"  <%=getCheck(ld.getAnchor("carprice"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
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

