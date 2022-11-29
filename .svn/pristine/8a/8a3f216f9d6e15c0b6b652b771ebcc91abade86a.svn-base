<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%


int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = tea.entity.node.Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

r.add("/tea/resource/Weblog");

ListingDetail ld=ListingDetail.find(iListing,82,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAddToBriefcase")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
    <input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="82"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
    <%        }else{%>
    <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
    <%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <TR>
        <td><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
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
        <td><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
        <TD nowrap><input  id="CHECKBOX" type="CHECKBOX" name="getText" value="checkbox"  <%=getCheck(ld.getIstype("getText"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="getText_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getText"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="getText_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getText"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="getText_3" type="text" class="edit_input" value="<%=ld.getSequence("getText")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="getText_4"   <%=getCheck(ld.getAnchor("getText"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> <%=r.getString(teasession._nLanguage, "Quantity")%>:
          <input name="getText_5" class="edit_input" type="text" value="<%=ld.getQuantity("getText")%>" maxlength="3" size="4">
        </TD>
      </TR>
      <TR>
        <td><%=r.getString(teasession._nLanguage, "Time")%>:</TD>
        <TD nowrap><input  id="CHECKBOX" type="CHECKBOX" name="getTime" value="checkbox"  <%=getCheck(ld.getIstype("getTime"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="getTime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getTime"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="getTime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getTime"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="getTime_3" type="text" class="edit_input" value="<%=ld.getSequence("getTime")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="getTime_4"   <%=getCheck(ld.getAnchor("getTime"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
      <TR>
        <td><%=r.getString(teasession._nLanguage, "Anchor")%>:</TD>
        <TD nowrap><input  id="CHECKBOX" type="CHECKBOX" name="getAnchor" value="checkbox"  <%=getCheck(ld.getIstype("getAnchor"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="getAnchor_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getAnchor"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="getAnchor_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getAnchor"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="getAnchor_3" type="text" class="edit_input" value="<%=ld.getSequence("getAnchor")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="getAnchor_4"   <%=getCheck(ld.getAnchor("getAnchor"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
      <TR>
        <td><%=r.getString(teasession._nLanguage, "Footer")%>:</TD>
        <TD nowrap><input  id="CHECKBOX" type="CHECKBOX" name="getFooter" value="checkbox"  <%=getCheck(ld.getIstype("getFooter"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="getFooter_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFooter"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="getFooter_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFooter"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="getFooter_3" type="text" class="edit_input" value="<%=ld.getSequence("getFooter")%>" maxlength="3" size="4">
          <!--input  id=CHECKBOX type="CHECKBOX" name="getFooter_4"   <%=getCheck(ld.getAnchor("getFooter"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%>--> </TD>
      </TR>
      <tr>
        <td colspan="2"><hr size="1"></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Picture")%>: </TD>
        <td nowrap><input  id="CHECKBOX" type="CHECKBOX" name="getPicture" value="checkbox"  <%=getCheck(ld.getIstype("getPicture"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="getPicture_1"  mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPicture"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input  mask="max" name="getPicture_2" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPicture"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>
          <input name="getPicture_3" type="text" value="<%=ld.getSequence("getPicture")%>" maxlength="3" size="4">
          <select name="getPicture_4">
            <option value="0" Selected>无</option>
            <option value="1" <%=getSelect(ld.getAnchor("getPicture")==1)%>>节点</option>
            <option value="2" <%=getSelect(ld.getAnchor("getPicture")==2)%>>大图</option>
          </select>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
      </tr>
      <TR>
        <td><%=r.getString(teasession._nLanguage, "PictureName")%>:</TD>
        <TD nowrap><input  id="CHECKBOX" type="CHECKBOX" name="getPictureName" value="checkbox"  <%=getCheck(ld.getIstype("getPictureName"))%>>
          <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
          <input name="getPictureName_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPictureName"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "After")%>
          <input name="getPictureName_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPictureName"))%>" type="text" class="edit_input">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:
          <input name="getPictureName_3" type="text" class="edit_input" value="<%=ld.getSequence("getPictureName")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="getPictureName_4"   <%=getCheck(ld.getAnchor("getPictureName"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
      </TR>
      <!--tr>
    <td colspan="2"><hr size="1"></td>
</tr>
  <tr>
      <td>
      </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="objshow" onclick="fshow()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
          <%=r.getString(teasession._nLanguage, "Before")%><input   class="edit_input" name="objbefore1"  mask="max" onfocus="fbefore()"  onchange="fbefore()" value="" type="text">
              <%=r.getString(teasession._nLanguage, "After")%><input   class="edit_input" name="objafter2"  onfocus="fafter()"  mask="max" onchange="fafter()" value="" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<a href="#" onclick="fsequ()"  ><%=r.getString(teasession._nLanguage, "Default")%></a>
    <input  id="CHECKBOX" type="CHECKBOX" name="objanchor_4" onclick="fanchor()"  ><%=r.getString(teasession._nLanguage, "SelectAll")%>
                                                </td>
                      </tr-->
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
  <SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.getSubject_1.focus();</SCRIPT>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

