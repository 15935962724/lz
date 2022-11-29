<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.RV.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.html.*" %>
<%@ page import="tea.htmlx.*" %>
<%
	Http h=new Http(request,response);
	int listing=h.getInt("Listing");
	int nodeid=Listing.find(listing).getNode();
	Node node=Node.find(h.node);
	Profile p=Profile.find(h.member);
	if(!node.isCreator(new RV(p.getMember()))&&AccessMember.find(nodeid, p.getMember()).getPurview()<2){
		response.sendError(403);
		return;
	}
	boolean flag=h.get("PickNode")==null;
	ListingDetail ld=ListingDetail.find(listing, 109, h.language);
	Resource r = new Resource();

%>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
String getCheck(int value)
{
	return value!=0?" CHECKED ":" ";
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(h.language, "Subjects")%><%=r.getString(h.language, "Detail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(h.language)%></div>


<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
<input type='hidden' name="node" value="<%=nodeid%>">
<input type="hidden" name="ListingType" value="109"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=h.get("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=h.get("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=listing%>"/>
 <div id="head6"><img height="6" src="about:blank"></div>
 
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 
  <TR>
    <td ID=RowHeader><%=r.getString(h.language, "SubjectName")%>:</TD>
    <TD>
      <input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>><%=r.getString(h.language, "Show")%>
      <%=r.getString(h.language, "Before")%><input name="name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "After")%><input name="name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "Sequence")%>:<input name="name_3" type="text" class="edit_input" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="name_4"   <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(h.language, "Anchor")%>
    </TD>
  </TR>
  
  
    <TR>
    <td ID=RowHeader><%=r.getString(h.language, "Keywords")%>:</TD>
    <TD>
      <input  id="CHECKBOX" type="CHECKBOX" name="keywords" value="checkbox"  <%=getCheck(ld.getIstype("keywords"))%>><%=r.getString(h.language, "Show")%>
      <%=r.getString(h.language, "Before")%><input name="keywords_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("keywords"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "After")%><input name="keywords_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("keywords"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "Sequence")%>:<input name="keywords_3" type="text" class="edit_input" value="<%=ld.getSequence("keywords")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="keywords_4"   <%=getCheck(ld.getAnchor("keywords"))%>><%=r.getString(h.language, "Anchor")%>
    </TD>
  </TR>
  
  
    <TR>
    <td ID=RowHeader><%=r.getString(h.language, "Abstract")%>:</TD>
    <TD>
      <input  id="CHECKBOX" type="CHECKBOX" name="abstract" value="checkbox"  <%=getCheck(ld.getIstype("abstract"))%>><%=r.getString(h.language, "Show")%>
      <%=r.getString(h.language, "Before")%><input name="abstract_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("abstract"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "After")%><input name="abstract_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("abstract"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "Sequence")%>:<input name="abstract_3" type="text" class="edit_input" value="<%=ld.getSequence("abstract")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="abstract_4"   <%=getCheck(ld.getAnchor("abstract"))%>><%=r.getString(h.language, "Anchor")%>
    </TD>
  </TR>
  
  
  
    <TR>
    <td ID=RowHeader><%=r.getString(h.language, "SubjectUnit")%>:</TD>
    <TD>
      <input  id="CHECKBOX" type="CHECKBOX" name="unit" value="checkbox"  <%=getCheck(ld.getIstype("unit"))%>><%=r.getString(h.language, "Show")%>
      <%=r.getString(h.language, "Before")%><input name="unit_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("unit"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "After")%><input name="unit_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("unit"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "Sequence")%>:<input name="unit_3" type="text" class="edit_input" value="<%=ld.getSequence("unit")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="unit_4"   <%=getCheck(ld.getAnchor("unit"))%>><%=r.getString(h.language, "Anchor")%>
    </TD>
  </TR>
  
  
    <TR>
    <td ID=RowHeader><%=r.getString(h.language, "MembersOfTheTeam")%>:</TD>
    <TD>
      <input  id="CHECKBOX" type="CHECKBOX" name="team" value="checkbox"  <%=getCheck(ld.getIstype("team"))%>><%=r.getString(h.language, "Show")%>
      <%=r.getString(h.language, "Before")%><input name="team_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("team"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "After")%><input name="team_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("team"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "Sequence")%>:<input name="team_3" type="text" class="edit_input" value="<%=ld.getSequence("team")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="team_4"   <%=getCheck(ld.getAnchor("team"))%>><%=r.getString(h.language, "Anchor")%>
    </TD>
  </TR>
  
    <TR>
    <td ID=RowHeader><%=r.getString(h.language, "MainBody")%>:</TD>
    <TD>
      <input  id="CHECKBOX" type="CHECKBOX" name="mainbody" value="checkbox"  <%=getCheck(ld.getIstype("mainbody"))%>><%=r.getString(h.language, "Show")%>
      <%=r.getString(h.language, "Before")%><input name="mainbody_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("mainbody"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "After")%><input name="mainbody_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("mainbody"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "Sequence")%>:<input name="mainbody_3" type="text" class="edit_input" value="<%=ld.getSequence("mainbody")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="mainbody_4"   <%=getCheck(ld.getAnchor("mainbody"))%>><%=r.getString(h.language, "Anchor")%>
    </TD>
  </TR>
  
  <TR>
    <td ID=RowHeader><%=r.getString(h.language, "Attachment")%>:</TD>
    <TD>
      <input  id="CHECKBOX" type="CHECKBOX" name="attachment" value="checkbox"  <%=getCheck(ld.getIstype("attachment"))%>><%=r.getString(h.language, "Show")%>
      <%=r.getString(h.language, "Before")%><input name="attachment_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("attachment"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "After")%><input name="attachment_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("attachment"))%>" type="text" class="edit_input">
      <%=r.getString(h.language, "Sequence")%>:<input name="attachment_3" type="text" class="edit_input" value="<%=ld.getSequence("attachment")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="attachment_4"   <%=getCheck(ld.getAnchor("attachment"))%>><%=r.getString(h.language, "Anchor")%>
    </TD>
  </TR>
  
  </table><center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(h.language, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(h.language, "Submit")%>">
      </center>
  </form>

  <SCRIPT>
  function fsequ()
  {
    var paramvalue=0;
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="text"&&form1.elements[counter].ld.substring(form1.elements[counter].ld.length-2)=="_3")
          {
              form1.elements[counter].value=++paramvalue*10;
          }
      }
  }
  <%if(h.get("edit")==null)out.println("fsequ();");%>document.form1.name_1.focus();</SCRIPT>
  <br>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(h.language,request)%></div>

</body>
</html>