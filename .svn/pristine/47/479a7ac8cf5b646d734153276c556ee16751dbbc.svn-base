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

r.add("/tea/ui/node/type/category/EditCategory");

ListingDetail ld=ListingDetail.find(iListing,0,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
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
</head>
<body onLoad="<%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.getSubject_1.focus();">
<h1>  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div></h1>
       <div id="head6"><img height="6" src="about:blank"></div>
   <br>
  <FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
    <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="0"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
    <%        }else{%>
    <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
    <%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
        <TD nowrap><input  id="CHECKBOX" type="CHECKBOX" name="getSubject" value="checkbox"  <%=getCheck(ld.getIstype("getSubject"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="getSubject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSubject"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="getSubject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSubject"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="getSubject_3" type="text" class="edit_input" value="<%=ld.getSequence("getSubject")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="getSubject_4"   <%=getCheck(ld.getAnchor("getSubject"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
          <input name="getSubject_5" class="edit_input" type="text" value="<%=ld.getQuantity("getSubject")%>" maxlength="3" size="4">
        </TD>
      </TR>


      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Quantity")%>:</TD>
        <TD nowrap><input  id="CHECKBOX" type="CHECKBOX" name="countSons" value="checkbox"  <%=getCheck(ld.getIstype("countSons"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="countSons_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("countSons"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="countSons_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("countSons"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="countSons_3" type="text" class="edit_input" value="<%=ld.getSequence("countSons")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="countSons_4"   <%=getCheck(ld.getAnchor("countSons"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
<TR>
        <TD><%=r.getString(teasession._nLanguage, "AllSonQuantity")%>:</TD>
        <TD nowrap><input  id="CHECKBOX" type="CHECKBOX" name="countByPath" value="checkbox"  <%=getCheck(ld.getIstype("countByPath"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="countByPath_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("countByPath"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="countByPath_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("countByPath"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="countByPath_3" type="text" class="edit_input" value="<%=ld.getSequence("countByPath")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="countByPath_4"   <%=getCheck(ld.getAnchor("countByPath"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
    </table>
    <center >
      <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
      <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
    </center>
  </form>

<div id="head6"><img height="6" alt=""></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

