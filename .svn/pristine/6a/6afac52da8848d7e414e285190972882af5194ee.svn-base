<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Volunteer");
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
      response.sendError(403);
      return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,96,teasession._nLanguage);


%>
<HTML>
<HEAD>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage, "Volunteer")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<DIV ID="edit_BodyDiv"><div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
       <input type="hidden" name="ListingType" value="96"/>
		<input type="hidden" name="Listing" value="<%=iListing%>"/>
		<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
    <%}else{%>
	<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
	<%   }%>
	<%if(request.getParameter("Edit")!=null)
	{%><input type="hidden" name="Edit" value="<%=request.getParameter("Edit")%>"/>
	<%}  %>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


  <tr>
    <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="vname" value="checkbox"  <%=getCheck(ld.getIstype("vname"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="vname_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vname"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="vname_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("vname"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vname_3" class="edit_input" type="text" value="<%=ld.getSequence("vname")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="vname_4"  <%=getCheck(ld.getAnchor("vname"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Sex")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="vsex" value="checkbox"  <%=getCheck(ld.getIstype("vsex"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="vsex_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vsex"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="vsex_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("vsex"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vsex_3" class="edit_input" type="text" value="<%=ld.getSequence("vsex")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="vsex_4"  <%=getCheck(ld.getAnchor("vsex"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Vnation")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="vnation" value="checkbox"  <%=getCheck(ld.getIstype("vnation"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="vnation_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vnation"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="vnation_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("vnation"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vnation_3" class="edit_input" type="text" value="<%=ld.getSequence("vnation")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="vnation_4"  <%=getCheck(ld.getAnchor("vnation"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  
  
  
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Province")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="vprovince" value="checkbox"  <%=getCheck(ld.getIstype("vprovince"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="vprovince_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vprovince"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="vprovince_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("vprovince"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vprovince_3" class="edit_input" type="text" value="<%=ld.getSequence("vprovince")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="vprovince_4"  <%=getCheck(ld.getAnchor("vprovince"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="vuwork" value="checkbox"  <%=getCheck(ld.getIstype("vuwork"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="vuwork_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vuwork"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="vuwork_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("vuwork"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vuwork_3" class="edit_input" type="text" value="<%=ld.getSequence("vuwork")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="vuwork_4"  <%=getCheck(ld.getAnchor("vuwork"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Time")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="vtime" value="checkbox"  <%=getCheck(ld.getIstype("vtime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="vtime_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vtime"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="vtime_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("vtime"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vtime_3" class="edit_input" type="text" value="<%=ld.getSequence("vtime")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="vtime_4"  <%=getCheck(ld.getAnchor("vtime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Vtype")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="vtype" value="checkbox"  <%=getCheck(ld.getIstype("vtype"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="vtype_1"  class="edit_input"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("vtype"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="vtype_2" class="edit_input"  mask="max"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("vtype"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="vtype_3" class="edit_input" type="text" value="<%=ld.getSequence("vtype")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="vtype_4"  <%=getCheck(ld.getAnchor("vtype"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>
</table>
<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</DIV>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div></body></HTML>

