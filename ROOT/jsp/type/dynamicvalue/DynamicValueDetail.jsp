<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.resource.*"%>
<%@include file="/jsp/Header.jsp"%>

<%

Resource r = new Resource();
int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = tea.entity.node.Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

r.add("/tea/resource/Dynamic");

int type=Integer.parseInt(request.getParameter("Type"));

ListingDetail ld=ListingDetail.find(iListing,type,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "DynamicValueDetail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
  <input type='hidden' name="Node" value="<%=iNode%>">
  <input type="hidden" name="ListingType" value="<%=type%>"/>
  <%if(!flag){%>
  <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
  <%        }else{%>
  <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
  <%   }%>
  <input type="hidden" name="Listing" value="<%=iListing%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
      <TD nowrap>
        <input id="CHECKBOX" type="CHECKBOX" name="getSubject" value="checkbox"  <%=getCheck(ld.getIstype("getSubject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="getSubject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSubject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="getSubject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSubject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getSubject_3" type="text" class="edit_input" value="<%=ld.getSequence("getSubject")%>" maxlength="3" size="4">
        <input id=CHECKBOX type="CHECKBOX" name="getSubject_4" <%=getCheck(ld.getAnchor("getSubject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getSubject_5" class="edit_input" type="text" value="<%=ld.getQuantity("getSubject")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
      <TD nowrap>
        <input  id="CHECKBOX" type="CHECKBOX" name="getText" value="checkbox"  <%=getCheck(ld.getIstype("getText"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="getText_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getText"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="getText_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getText"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getText_3" type="text" class="edit_input" value="<%=ld.getSequence("getText")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getText_4" <%=getCheck(ld.getAnchor("getText"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getText_5" class="edit_input" type="text" value="<%=ld.getQuantity("getText")%>" maxlength="3" size="4">
      </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Time")%>:</TD>
      <TD nowrap>
        <input  id="CHECKBOX" type="CHECKBOX" name="getTime" value="checkbox"  <%=getCheck(ld.getIstype("getTime"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="getTime_1" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getTime"))%>" type="text" class="edit_input" mask="max">
        <%=r.getString(teasession._nLanguage, "After")%><input name="getTime_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getTime"))%>" type="text" class="edit_input" mask="max">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getTime_3" type="text" class="edit_input" value="<%=ld.getSequence("getTime")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getTime_4" <%=getCheck(ld.getAnchor("getTime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <%
    java.util.Enumeration enumeration=DynamicType.findByDynamic(type);
    while(enumeration.hasMoreElements())
    {
      int id=((Integer)enumeration.nextElement()).intValue();
      DynamicType obj=DynamicType.find(id);
      String before=ld.getBeforeItem("00"+id),after=ld.getAfterItem("00"+id);
      before=HtmlElement.htmlToText(before);
      after=HtmlElement.htmlToText(after);
    %>
    <tr>
      <td><%=obj.getName(teasession._nLanguage)%>:</td>
      <td nowrap>
        <input id="CHECKBOX" type="CHECKBOX" name="00<%=id%>" value="checkbox" <%=getCheck(ld.getIstype("00"+id))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="00<%=id%>_1" value="<%=before%>" type="text" class="edit_input" mask="max">
        <%=r.getString(teasession._nLanguage, "After")%><input name="00<%=id%>_2" value="<%=after%>" type="text" class="edit_input" mask="max">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="00<%=id%>_3" type="text" class="edit_input" value="<%=ld.getSequence("00"+id)%>" maxlength="3" size="4">
        <input id=CHECKBOX type="CHECKBOX" name="00<%=id%>_4" <%=getCheck(ld.getAnchor("00"+id))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="00<%=id%>_5" class="edit_input" type="text" value="<%=ld.getQuantity("00"+id)%>" maxlength="3" size="4">
      </td>
    </tr>
    <%}%>
  </table>
  <center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </center>
</form>

<SCRIPT>document.form1.getSubject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
