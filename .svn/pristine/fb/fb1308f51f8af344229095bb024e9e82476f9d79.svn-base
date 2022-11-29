<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/Sound");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,41,teasession._nLanguage);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "FilesDetail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv">
<%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="Node" value="<%=iNode%>">
    <input type="hidden" name="ListingType" value="41"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" value="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "所属分类")%>:</td>
    <td>
       <input  id="checkbox" type="checkbox" name="classes" value="checkbox"  <%=getCheck(ld.getIstype("classes"))%>><%=r.getString(teasession._nLanguage, "Show")%>
       <%=r.getString(teasession._nLanguage, "Before")%><input name="classes_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("classes"))%>" class="edit_input"  type="text">
       <%=r.getString(teasession._nLanguage, "After")%><input name="classes_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("classes"))%>" class="edit_input"  type="text">
       <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="classes_3" class="edit_input"  value="<%=ld.getSequence("classes")%>" maxlength="3" size="4">
    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "课件名称")%>:</td>
    <td><input  id="checkbox" type="checkbox" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" class="edit_input"  type="text">
        <%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" class="edit_input"  type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" class="edit_input"  value="<%=ld.getSequence("subject")%>" maxlength="3" size="4">
      <input  id=checkbox type="checkbox" name="subject_4"   <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subject_5" class="edit_input" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4" mask="int">
    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "课件编号")%>: </td>
    <td><input  id="checkbox" type="checkbox" name="code" value="checkbox"  <%=getCheck(ld.getIstype("code"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="code_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("code"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="code_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("code"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="code_3" class="edit_input"  value="<%=ld.getSequence("code")%>" maxlength="3" size="4">
	<input  id=checkbox type="checkbox" name="code_4" <%=getCheck(ld.getAnchor("code"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "关键字")%>: </td>
    <td><input  id="checkbox" type="checkbox" name="keyword" value="checkbox"  <%=getCheck(ld.getIstype("keyword"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="keyword_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("keyword"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="keyword_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("keyword"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="keyword_3" class="edit_input"  value="<%=ld.getSequence("keyword")%>" maxlength="3" size="4">
    </td>
  </tr>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "课件大小")%>: </td>
    <td><input  id="checkbox" type="checkbox" name="filesize" value="checkbox"  <%=getCheck(ld.getIstype("filesize"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="filesize_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("filesize"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="filesize_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("filesize"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="filesize_3" class="edit_input"  value="<%=ld.getSequence("filesize")%>" maxlength="3" size="4">
    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "课件评级")%>: </td>
    <td><input  id="checkbox" type="checkbox" name="grade" value="checkbox"  <%=getCheck(ld.getIstype("grade"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="grade_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("grade"))%>" class="edit_input"  type="text">
        <%=r.getString(teasession._nLanguage, "After")%><input name="grade_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("grade"))%>" class="edit_input"  type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="grade_3" class="edit_input"  value="<%=ld.getSequence("grade")%>" maxlength="3" size="4">
    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "积分限制")%>: </td>
    <td><input  id="checkbox" type="checkbox" name="pointlimit" value="checkbox"  <%=getCheck(ld.getIstype("pointlimit"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="pointlimit_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pointlimit"))%>" class="edit_input"  type="text">
        <%=r.getString(teasession._nLanguage, "After")%><input name="pointlimit_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pointlimit"))%>" class="edit_input"  type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="pointlimit_3" class="edit_input"  value="<%=ld.getSequence("pointlimit")%>" maxlength="3" size="4">
    </td>
  </tr>

  <tr>
    <td align="right">图片: </td>
    <td><input  id="checkbox" type="checkbox" name="picture" value="checkbox" <%=getCheck(ld.getIstype("picture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="picture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("picture"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="picture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("picture"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="picture_3" class="edit_input"  value="<%=ld.getSequence("picture")%>" maxlength="3" size="4">
	<input  id=checkbox type="checkbox" name="picture_4" <%=getCheck(ld.getAnchor("picture"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "上传文件")%>:</td>
        <td><input  id="checkbox" type="checkbox" name="file" value="checkbox"  <%=getCheck(ld.getIstype("file"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="file_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("file"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="file_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("file"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="file_3" class="edit_input"  value="<%=ld.getSequence("file")%>" maxlength="3" size="4">
    <input  id=checkbox type="checkbox" name="file_4" <%=getCheck(ld.getAnchor("file"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>


  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "课件作者")%>:</td>
        <td><input  id="checkbox" type="checkbox" name="author" value="checkbox"  <%=getCheck(ld.getIstype("author"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="author_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("author"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="author_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("author"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="author_3" class="edit_input"  value="<%=ld.getSequence("author")%>" maxlength="3" size="4">
	<input  id=checkbox type="checkbox" name="author_4"   <%=getCheck(ld.getAnchor("author"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "所属单位")%>:</td>
        <td><input  id="checkbox" type="checkbox" name="unitname" value="checkbox"  <%=getCheck(ld.getIstype("unitname"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="unitname_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("unitname"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="unitname_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("unitname"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="unitname_3" class="edit_input"  value="<%=ld.getSequence("unitname")%>" maxlength="3" size="4">
	<input  id=checkbox type="checkbox" name="unitname_4"   <%=getCheck(ld.getAnchor("unitname"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "课件来源")%>:</td>
        <td><input  id="checkbox" type="checkbox" name="linkurl" value="checkbox"  <%=getCheck(ld.getIstype("linkurl"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="linkurl_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("linkurl"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "After")%><input name="linkurl_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("linkurl"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="linkurl_3" class="edit_input"  value="<%=ld.getSequence("linkurl")%>" maxlength="3" size="4">
    <input  id=checkbox type="checkbox" name="linkurl_4"   <%=getCheck(ld.getAnchor("linkurl"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>


  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "课件简介")%>:</td>
    <td><input  id="checkbox" type="checkbox" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" class="edit_input"  value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
	<input  id=checkbox type="checkbox" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "备注")%>: </td>
    <td><input  id="checkbox" type="checkbox" name="note" value="checkbox"  <%=getCheck(ld.getIstype("note"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="note_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("note"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="note_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("note"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="note_3" class="edit_input"  value="<%=ld.getSequence("note")%>" maxlength="3" size="4">
	<input  id=checkbox type="checkbox" name="note_4"   <%=getCheck(ld.getAnchor("note"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <!--
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Time")%>: </td>
    <td><input  id="checkbox" type="checkbox" name="issue" value="checkbox"  <%=getCheck(ld.getIstype("issue"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="issue_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("issue"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="issue_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("issue"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="issue_3" class="edit_input"  value="<%=ld.getSequence("issue")%>" maxlength="3" size="4">
	<input  id=checkbox type="checkbox" name="issue_4"   <%=getCheck(ld.getAnchor("issue"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  -->
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "下载(扣分)")%>: </td>
    <td>
      <input id="checkbox" type="checkbox" name="download" value="checkbox" <%=getCheck(ld.getIstype("download"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="download_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("download"))%>" class="edit_input"  type="text">
        <%=r.getString(teasession._nLanguage, "After")%><input name="download_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("download"))%>" class="edit_input"  type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="download_3" class="edit_input"  value="<%=ld.getSequence("download")%>" maxlength="3" size="4">
            <input  id=checkbox type="checkbox" name="download_4"   <%=getCheck(ld.getAnchor("download"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    </td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage,"下载")%>: </td>
    <td>
      <input id="checkbox" type="checkbox" name="down" value="checkbox" <%=getCheck(ld.getIstype("down"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="down_1" mask="max" value="<%=MT.f(ld.getBeforeItem("down"))%>">
      <%=r.getString(teasession._nLanguage, "After")%><input name="down_2" mask="max" value="<%=MT.f(ld.getAfterItem("down"))%>">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="down_3"  value="<%=ld.getSequence("down")%>" maxlength="3" size="4">
      <!--<input  id=checkbox type="checkbox" name="down_4" <%=getCheck(ld.getAnchor("down"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>-->
    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "下载次数")%>: </td>
    <td>
      <input id="checkbox" type="checkbox" name="hits" value="checkbox" <%=getCheck(ld.getIstype("hits"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="hits_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("hits"))%>" class="edit_input"  type="text">
        <%=r.getString(teasession._nLanguage, "After")%><input name="hits_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("hits"))%>" class="edit_input"  type="text">
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="hits_3" class="edit_input"  value="<%=ld.getSequence("hits")%>" maxlength="3" size="4">
    </td>
  </tr>

    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "父节点标题")%>:</td>
        <td><input  id="checkbox" type="checkbox" name="fathername" value="checkbox"  <%=getCheck(ld.getIstype("fathername"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="fathername_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("fathername"))%>" class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="fathername_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("fathername"))%>" class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="fathername_3" class="edit_input"  value="<%=ld.getSequence("fathername")%>" maxlength="3" size="4">
	<input  id=checkbox type="checkbox" name="fathername_4"   <%=getCheck(ld.getAnchor("fathername"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "在线浏览")%>: </td>
    <td>
      <input id="checkbox" type="checkbox" name="read" value="checkbox" <%=getCheck(ld.getIstype("read"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="read_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("read"))%>" class="edit_input"  type="text">
      <%=r.getString(teasession._nLanguage, "After")%><input name="read_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("read"))%>" class="edit_input"  type="text">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="read_3" class="edit_input"  value="<%=ld.getSequence("read")%>" maxlength="3" size="4">
      宽度:<input name="read_5" class="edit_input" value="<%=ld.getQuantity("read")%>" maxlength="3" size="4" mask="int">
    </td>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "背景音乐")%>: </td>
    <td>
      <input id="checkbox" type="checkbox" name="voice" value="checkbox" <%=getCheck(ld.getIstype("voice"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="voice_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("voice"))%>" class="edit_input"  type="text">
      <%=r.getString(teasession._nLanguage, "After")%><input name="voice_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("voice"))%>" class="edit_input"  type="text">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="voice_3" class="edit_input"  value="<%=ld.getSequence("voice")%>" maxlength="3" size="4">
    </td>
</table>
<center >
  <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
  <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</center>
</form>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
