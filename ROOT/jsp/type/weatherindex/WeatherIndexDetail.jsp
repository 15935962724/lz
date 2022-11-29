<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.RV.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.html.*" %>
<%@ page import="tea.htmlx.*" %>
<%@ page import="tea.ui.*" %>
<%
	//Http h=new Http(request,response);

	TeaSession teasession=new TeaSession(request);
	//teasession.getParameter
	int listing=Integer.parseInt(teasession.getParameter("Listing"));
	int nodeid=Listing.find(listing).getNode();
	Node node=Node.find(teasession._nNode);
	Profile p=Profile.find(teasession._rv._strR);
	if(!node.isCreator(new RV(p.getMember()))&&AccessMember.find(nodeid, p.getMember()).getPurview()<2){
		response.sendError(403);
		return;
	}
	boolean flag=teasession.getParameter("PickNode")==null;
	ListingDetail ld=ListingDetail.find(listing, 110, teasession._nLanguage);
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
<h1><%=r.getString(teasession._nLanguage, "Subjects")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>


<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
<input type='hidden' name="node" value="<%=nodeid%>">
<input type="hidden" name="ListingType" value="110"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=teasession.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=teasession.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=listing%>"/>
 <div id="head6"><img height="6" src="about:blank"></div>
 
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 
  <TR>
    <td ID=RowHeader><%=r.getString(teasession._nLanguage, "SubjectName")%>:</TD>
    <TD>
      <input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text" class="edit_input">
      <%=r.getString(teasession._nLanguage, "After")%><input name="name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text" class="edit_input">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" type="text" class="edit_input" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="name_4"   <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </TD>
  </TR>
  
  <%
  	for(int i=0;i<WeatherIndex.WI.length;i++){
  		String wii=WeatherIndex.WI[i];%>
  		
  		<TR>
    <td ID=RowHeader><%=r.getString(teasession._nLanguage,wii)%>:</TD>
    <TD>
      <input  id="CHECKBOX" type="CHECKBOX" name="<%= wii%>" value="checkbox"  <%=getCheck(ld.getIstype(wii))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="<%= wii%>_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem(wii))%>" type="text" class="edit_input">
      <%=r.getString(teasession._nLanguage, "After")%><input name="<%= wii%>_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem(wii))%>" type="text" class="edit_input">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="<%= wii%>_3" type="text" class="edit_input" value="<%=ld.getSequence(wii)%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="<%= wii%>_4"   <%=getCheck(ld.getAnchor(wii))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      
       <input  id=CHECKBOX type="CHECKBOX" name="<%= wii%>_7"  value="100" <%if(ld.getOptions(wii).indexOf("/100/")!=-1)out.print("checked");%>><%=r.getString(teasession._nLanguage, "图片")%>
     <!-- <input  id=CHECKBOX type="CHECKBOX" name="<%= wii%>_7"  value="101"  <%if(ld.getOptions(wii).indexOf("/101/")!=-1)out.print("checked");%>><%=r.getString(teasession._nLanguage, "范围（0-1）")%>
      <input  id=CHECKBOX type="CHECKBOX" name="<%= wii%>_7"   value="102"  <%if(ld.getOptions(wii).indexOf("/102/")!=-1)out.print("checked");%>><%=r.getString(teasession._nLanguage, "等级（1，2，3）")%>
      <input  id=CHECKBOX type="CHECKBOX" name="<%= wii%>_7"   value="104"  <%if(ld.getOptions(wii).indexOf("/104/")!=-1)out.print("checked");%>><%=r.getString(teasession._nLanguage, " 对人体可能影响（正常）")%> -->
      <input  id=CHECKBOX type="CHECKBOX" name="<%= wii%>_7"   value="103"  <%if(ld.getOptions(wii).indexOf("/103/")!=-1)out.print("checked");%>><%=r.getString(teasession._nLanguage, "等级（最弱，弱）")%>
      <input  id=CHECKBOX type="CHECKBOX" name="<%= wii%>_7"   value="105"  <%if(ld.getOptions(wii).indexOf("/105/")!=-1)out.print("checked");%>><%=r.getString(teasession._nLanguage, "详细")%>
    </TD>
  </TR>
  	<%} %>
    
  
  
  
  
  </table><center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
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
  <%if(teasession.getParameter("edit")==null)out.println("fsequ();");%>document.form1.name_1.focus();</SCRIPT>
  <br>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>