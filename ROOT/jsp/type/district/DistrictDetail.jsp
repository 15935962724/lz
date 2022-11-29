<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.resource.*"%>
<%@include file="/jsp/Header.jsp"%>

<%
Resource r = new Resource();
r.add("/tea/resource/District");
int _nListing= Integer.parseInt(teasession.getParameter("Listing"));
int _nNode  = Listing.find(_nListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(_nNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(_nListing,83,teasession._nLanguage);

%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "District")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
  <input type='hidden' name="Node" value="<%=_nNode%>">
  <input type="hidden" name="Listing" value="<%=_nListing%>"/>
  <input type="hidden" name="ListingType" value="83"/>
  <%
  if(!flag)
  {
	  out.print("<input type=hidden name=PickNode value="+request.getParameter("PickNode")+" >");
  }else
  {
	  out.print("<input type=hidden name=PickManual value="+request.getParameter("PickManual")+" >");
  }
  %>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
      <TD>
        <input id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Street")%>:</TD>
      <TD>
        <input id="CHECKBOX" type="CHECKBOX" name="street" value="checkbox"  <%=getCheck(ld.getIstype("street"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="street_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("street"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="street_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("street"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="street_3" type="text" class="edit_input" value="<%=ld.getSequence("street")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="street_4"   <%=getCheck(ld.getAnchor("street"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
      <TD>
        <input id="CHECKBOX" type="CHECKBOX" name="content" value="checkbox"  <%=getCheck(ld.getIstype("content"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="content_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("content"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="content_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("content"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="content_3" type="text" class="edit_input" value="<%=ld.getSequence("content")%>" maxlength="3" size="4">
        <input id=CHECKBOX type="CHECKBOX" name="content_4" <%=getCheck(ld.getAnchor("content"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      </TD>
    </TR>

  </table>
  <center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </center>
</form>
<script>
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
