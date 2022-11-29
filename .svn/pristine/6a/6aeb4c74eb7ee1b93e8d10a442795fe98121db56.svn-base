<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %>
<%@include file="/jsp/Header.jsp"%>

<%

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv.toString()).getPurview()<2)
{
  response.sendError(403);
  return;
}
boolean flag=request.getParameter("PickNode")==null;

r.add("/tea/resource/Album");
ListingDetail ld=ListingDetail.find(iListing,95,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Album")%></h1>
<div id="head6"><img height="6" src="about:blank"></div> 
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
  <input type='hidden' name="node" value="<%=iNode%>">
  <input type="hidden" name="ListingType" value="95"/>
  <%if(!flag){%>
  <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
  <%        }else{%>
  <input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
  <%   }%>
  <input type="hidden" name="Listing" value="<%=iListing%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
      <td><input id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=MT.f(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=MT.f(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="subject_4" <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Content")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="content" value="checkbox"  <%=getCheck(ld.getIstype("content"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="content_1" mask="max" value="<%=MT.f(ld.getBeforeItem("content"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="content_2" mask="max" value="<%=MT.f(ld.getAfterItem("content"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="content_3" type="text" class="edit_input" value="<%=ld.getSequence("content")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="content_4"   <%=getCheck(ld.getAnchor("content"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "作者")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="author" value="checkbox"  <%=getCheck(ld.getIstype("author"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="author_1" mask="max" value="<%=MT.f(ld.getBeforeItem("author"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="author_2" mask="max" value="<%=MT.f(ld.getAfterItem("author"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="author_3" type="text" class="edit_input" value="<%=ld.getSequence("author")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="author_4"   <%=getCheck(ld.getAnchor("author"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "副标题")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="subtitle" value="checkbox"  <%=getCheck(ld.getIstype("subtitle"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="subtitle_1" mask="max" value="<%=MT.f(ld.getBeforeItem("subtitle"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="subtitle_2" mask="max" value="<%=MT.f(ld.getAfterItem("subtitle"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subtitle_3" type="text" class="edit_input" value="<%=ld.getSequence("subtitle")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="subtitle_4"   <%=getCheck(ld.getAnchor("subtitle"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "新闻编辑")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="editor" value="checkbox"  <%=getCheck(ld.getIstype("editor"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="editor_1" mask="max" value="<%=MT.f(ld.getBeforeItem("editor"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="editor_2" mask="max" value="<%=MT.f(ld.getAfterItem("editor"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="editor_3" type="text" class="edit_input" value="<%=ld.getSequence("editor")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="editor_4"   <%=getCheck(ld.getAnchor("editor"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "关键词")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="keywords" value="checkbox"  <%=getCheck(ld.getIstype("keywords"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="keywords_1" mask="max" value="<%=MT.f(ld.getBeforeItem("keywords"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="keywords_2" mask="max" value="<%=MT.f(ld.getAfterItem("keywords"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="keywords_3" type="text" class="edit_input" value="<%=ld.getSequence("keywords")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="keywords_4"   <%=getCheck(ld.getAnchor("keywords"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "来源")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="source" value="checkbox"  <%=getCheck(ld.getIstype("source"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="source_1" mask="max" value="<%=MT.f(ld.getBeforeItem("source"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="source_2" mask="max" value="<%=MT.f(ld.getAfterItem("source"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="source_3" type="text" class="edit_input" value="<%=ld.getSequence("source")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="source_4"   <%=getCheck(ld.getAnchor("source"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "预览图")%>:</td>
      <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="picture" value="checkbox"  <%=getCheck(ld.getIstype("picture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="picture_1" mask="max" value="<%=MT.f(ld.getBeforeItem("picture"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="picture_2" mask="max" value="<%=MT.f(ld.getAfterItem("picture"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="picture_3" type="text" class="edit_input" value="<%=ld.getSequence("picture")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="picture_4"   <%=getCheck(ld.getAnchor("picture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Album.module")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="module" value="checkbox" <%=getCheck(ld.getIstype("module"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="module_1" mask="max" value="<%=MT.f(ld.getBeforeItem("module"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="module_2" mask="max" value="<%=MT.f(ld.getAfterItem("module"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="module_3" type="text" class="edit_input" value="<%=ld.getSequence("module")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="module_4" <%=getCheck(ld.getAnchor("module"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Album.module")%>2:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="module2" value="checkbox" <%=getCheck(ld.getIstype("module2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="module2_1" mask="max" value="<%=MT.f(ld.getBeforeItem("module2"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="module2_2" mask="max" value="<%=MT.f(ld.getAfterItem("module2"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="module2_3" type="text" class="edit_input" value="<%=ld.getSequence("module2")%>" maxlength="3" size="4">
       </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "手机组图")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="module3" value="checkbox" <%=getCheck(ld.getIstype("module3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="module3_1" mask="max" value="<%=MT.f(ld.getBeforeItem("module3"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="module3_2" mask="max" value="<%=MT.f(ld.getAfterItem("module3"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="module3_3" type="text" class="edit_input" value="<%=ld.getSequence("module3")%>" maxlength="3" size="4">
       </td>
    </tr>
   <tr>
      <td><%=r.getString(teasession._nLanguage, "图片列表")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="list" value="checkbox" <%=getCheck(ld.getIstype("list"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="list_1" mask="max" value="<%=MT.f(ld.getBeforeItem("list"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="list_2" mask="max" value="<%=MT.f(ld.getAfterItem("list"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="list_3" type="text" class="edit_input" value="<%=ld.getSequence("list")%>" maxlength="3" size="4">
        <select name="list_5">
        <option value="0">原图</option>
        <option value="1">大图</option>
        <option value="2">小图</option>
        </select>
      </td>
    </tr>
  </table>
  <center >
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </center>
</form>
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
<SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.subject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
