<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*"%>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/BBS");
int listing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(listing).getNode();
if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
   response.sendError(403);
   return;
}
boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(listing,57,teasession._nLanguage);


%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Detail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM NAME=form1 METHOD=POST  action="/servlet/EditListingDetail">
  <input type='hidden' name="node" value="<%=iNode%>">
  <input type="hidden" name="ListingType" value="57"/>
  <%
  if(!flag)
  {
   out.print("<input type=hidden name=PickNode value="+request.getParameter("PickNode")+">");
  }else
  {
   out.print("<input type=hidden name=PickManual value="+request.getParameter("PickManual")+">");
  }
  %>
  <input type="hidden" name="Listing" value="<%=listing%>"/>
  <TABLE CELLSPACING=0 CELLPADDING=0 border="0" id="tablecenter">
     <tr>
     <td><%=r.getString(teasession._nLanguage, "新回复")%>:</td>
     <td>
        <input id="CHECKBOX" type="CHECKBOX" name="news" value="checkbox" <%=getCheck(ld.getIstype("news"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="news_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("news"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="news_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("news"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="news_3" type="text" class="edit_input" value="<%=ld.getSequence("news")%>" maxlength="3" size="4" mask="int">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "访问量")%>:</td>
      <td>
        <input id="CHECKBOX" type="CHECKBOX" name="hits" value="checkbox" <%=getCheck(ld.getIstype("hits"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="hits_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("hits"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="hits_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("hits"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="hits_3" type="text" class="edit_input" value="<%=ld.getSequence("hits")%>" maxlength="3" size="4" mask="int">
        <input id=CHECKBOX type="CHECKBOX" name="hits_4" <%=getCheck(ld.getAnchor("hits"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      </td>
    </tr>
     <tr>
      <td><%=r.getString(teasession._nLanguage, "Hint")%>:</td>
      <td>
        <input id="CHECKBOX" type="CHECKBOX" name="hint" value="checkbox"  <%=getCheck(ld.getIstype("hint"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="hint_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("hint"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="hint_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("hint"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="hint_3" type="text" class="edit_input" value="<%=ld.getSequence("hint") %>" maxlength="3" size="4" mask="int">
        <input id=CHECKBOX type="CHECKBOX" name="hint_4" <%=getCheck(ld.getAnchor("hint"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
      <td>
        <input id="CHECKBOX" type="CHECKBOX" name="subject" value="checkbox"  <%=getCheck(ld.getIstype("subject"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subject"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subject_3" type="text" class="edit_input" value="<%=ld.getSequence("subject")%>" maxlength="3" size="4" mask="int">
        <input id=CHECKBOX type="CHECKBOX" name="subject_4" <%=getCheck(ld.getAnchor("subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subject_5" class="edit_input" type="text" value="<%=ld.getQuantity("subject")%>" maxlength="3" size="4" mask="int"> </td>
    </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage, "Creator")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="creator" value="checkbox"  <%=getCheck(ld.getIstype("creator"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="creator_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("creator"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="creator_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("creator"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="creator_3" type="text" class="edit_input" value="<%=ld.getSequence("creator")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="creator_4"   <%=getCheck(ld.getAnchor("creator"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <!--发贴人会员ID-->
      <tr>
      <td><%=r.getString(teasession._nLanguage, "会员ID号")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="memberid" value="checkbox"  <%=getCheck(ld.getIstype("memberid"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="memberid_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("memberid"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="memberid_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("memberid"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="memberid_3" type="text" class="edit_input" value="<%=ld.getSequence("memberid")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="memberid_4"   <%=getCheck(ld.getAnchor("memberid"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage, "Sex")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="sex" value="checkbox"  <%=getCheck(ld.getIstype("sex"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="sex_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sex"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="sex_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sex"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="sex_3" type="text" class="edit_input" value="<%=ld.getSequence("sex")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="sex_4"   <%=getCheck(ld.getAnchor("sex"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Count")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="count" value="checkbox"  <%=getCheck(ld.getIstype("count"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="count_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("count"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="count_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("count"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="count_3" type="text" class="edit_input" value="<%=ld.getSequence("count")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="count_4"   <%=getCheck(ld.getAnchor("count"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Register")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="register" value="checkbox"  <%=getCheck(ld.getIstype("register"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="register_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("register"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="register_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("register"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="register_3" type="text" class="edit_input" value="<%=ld.getSequence("register")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="register_4"   <%=getCheck(ld.getAnchor("register"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Photo")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="photo" value="checkbox"  <%=getCheck(ld.getIstype("photo"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="photo_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("photo"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="photo_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("photo"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="photo_3" type="text" class="edit_input" value="<%=ld.getSequence("photo")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="photo_4"   <%=getCheck(ld.getAnchor("photo"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "BBSLevel")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="level" value="checkbox"  <%=getCheck(ld.getIstype("level"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="level_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("level"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="level_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("level"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="level_3" type="text" class="edit_input" value="<%=ld.getSequence("level")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="level_4"   <%=getCheck(ld.getAnchor("level"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "积分")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="point" value="checkbox"  <%=getCheck(ld.getIstype("point"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%><input name="point_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("point"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="point_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("point"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="point_3" type="text" class="edit_input" value="<%=ld.getSequence("point")%>" maxlength="3" size="4" mask="int">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "勋章")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="medal" value="checkbox"  <%=getCheck(ld.getIstype("medal"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%><input name="medal_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("medal"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="medal_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("medal"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="medal_3" type="text" class="edit_input" value="<%=ld.getSequence("medal")%>" maxlength="3" size="4" mask="int">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "职务")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="position" value="checkbox"  <%=getCheck(ld.getIstype("position"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%><input name="position_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("position"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="position_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("position"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="position_3" type="text" class="edit_input" value="<%=ld.getSequence("position")%>" maxlength="3" size="4" mask="int">
      </td>
    </tr>
    <!--tr>   <td><%=r.getString(teasession._nLanguage, "Floor")%>:</td>
              <td><input  id="CHECKBOX" type="CHECKBOX" name="floor" value="checkbox"  <%=getCheck(ld.getIstype("floor"))%>><%=r.getString(teasession._nLanguage, "Show")%>
 <%=r.getString(teasession._nLanguage, "Before")%><input name="floor_1"  value="<%=HtmlElement.htmlToText(ld.getBeforeItem("floor"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "After")%><input name="floor_2"  value="<%=HtmlElement.htmlToText(ld.getAfterItem("floor"))%>" type="text" class="edit_input">
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="floor_3" type="text" class="edit_input" value="<%=ld.getSequence("floor")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="floor_4"   <%=getCheck(ld.getAnchor("floor"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
   </td>
   </TR-->
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="text_3" type="text" class="edit_input" value="<%=ld.getSequence("text")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "ReplyCount")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="replycount" value="checkbox"  <%=getCheck(ld.getIstype("replycount"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="replycount_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("replycount"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="replycount_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("replycount"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="replycount_3" type="text" class="edit_input" value="<%=ld.getSequence("replycount")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="replycount_4"   <%=getCheck(ld.getAnchor("replycount"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "ReplyButton")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="replybutton" value="checkbox"  <%=getCheck(ld.getIstype("replybutton"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="replybutton_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("replybutton"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="replybutton_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("replybutton"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="replybutton_3" type="text" class="edit_input" value="<%=ld.getSequence("replybutton")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="replybutton_4"   <%=getCheck(ld.getAnchor("replybutton"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "LastReplyMember")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="lastreplymember" value="checkbox"  <%=getCheck(ld.getIstype("lastreplymember"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="lastreplymember_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("lastreplymember"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="lastreplymember_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("lastreplymember"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="lastreplymember_3" type="text" class="edit_input" value="<%=ld.getSequence("lastreplymember")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="lastreplymember_4"   <%=getCheck(ld.getAnchor("lastreplymember"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>

          <input  id=CHECKBOX type="radio" name="lastreplymember_7"  value="1"   <%if(ld.getOptions("lastreplymember").indexOf("/1/")!=-1){out.println("  checked='true'");} %>>回复人姓名
        <input  id=CHECKBOX type="radio" name="lastreplymember_7" value="2"   <%if(ld.getOptions("lastreplymember").indexOf("/2/")!=-1){out.println("  checked='true'");} %>>回复人昵称
         <input  id=CHECKBOX type="radio" name="lastreplymember_7"  value="3"   <%if(ld.getOptions("lastreplymember").indexOf("/3/")!=-1){out.println("  checked='true'");} %>>回复人ID
    </td>

    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "LastReplyTime")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="lastreplytime" value="checkbox"  <%=getCheck(ld.getIstype("lastreplytime"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="lastreplytime_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("lastreplytime"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="lastreplytime_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("lastreplytime"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="lastreplytime_3" type="text" class="edit_input" value="<%=ld.getSequence("lastreplytime")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="lastreplytime_4"   <%=getCheck(ld.getAnchor("lastreplytime"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "IssueTime")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="issue" value="checkbox"  <%=getCheck(ld.getIstype("issue"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="issue_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("issue"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="issue_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("issue"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="issue_3" type="text" class="edit_input" value="<%=ld.getSequence("issue")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="issue_4"   <%=getCheck(ld.getAnchor("issue"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "BBSHost")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="bbshost" value="checkbox"  <%=getCheck(ld.getIstype("bbshost"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="bbshost_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bbshost"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="bbshost_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bbshost"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="bbshost_3" type="text" class="edit_input" value="<%=ld.getSequence("bbshost")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="bbshost_4"   <%=getCheck(ld.getAnchor("bbshost"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <input  id=CHECKBOX type="radio" name="bbshost_7"  value="1"   <%if(ld.getOptions("bbshost").indexOf("/1/")!=-1){out.println("  checked='true'");} %>>版主ID
        <input  id=CHECKBOX type="radio" name="bbshost_7" value="2"   <%if(ld.getOptions("bbshost").indexOf("/2/")!=-1){out.println("  checked='true'");} %>>版主昵称

   </td>
    </tr>
    <tr>
      <td>IP:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="ip" value="checkbox"  <%=getCheck(ld.getIstype("ip"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="ip_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ip"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="ip_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ip"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ip_3" type="text" class="edit_input" value="<%=ld.getSequence("ip")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="ip_4"   <%=getCheck(ld.getAnchor("ip"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
<!--    -->
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="getName" value="checkbox"  <%=getCheck(ld.getIstype("getName"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getName_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getName"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="getName_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getName"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getName_3" type="text" class="edit_input" value="<%=ld.getSequence("getName")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="getName_4"   <%=getCheck(ld.getAnchor("getName"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Phone")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="getPhone" value="checkbox"  <%=getCheck(ld.getIstype("getPhone"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getPhone_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPhone"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="getPhone_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPhone"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getPhone_3" type="text" class="edit_input" value="<%=ld.getSequence("getPhone")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="getPhone_4"   <%=getCheck(ld.getAnchor("getPhone"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td>E-Mail:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="getEmail" value="checkbox"  <%=getCheck(ld.getIstype("getEmail"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getEmail_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getEmail"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="getEmail_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getEmail"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getEmail_3" type="text" class="edit_input" value="<%=ld.getSequence("getEmail")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="getEmail_4"   <%=getCheck(ld.getAnchor("getEmail"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Area")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="getArea" value="checkbox"  <%=getCheck(ld.getIstype("getArea"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getArea_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getArea"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="getArea_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getArea"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getArea_3" type="text" class="edit_input" value="<%=ld.getSequence("getArea")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="getArea_4"   <%=getCheck(ld.getAnchor("getArea"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="getAddress" value="checkbox"  <%=getCheck(ld.getIstype("getAddress"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getAddress_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getAddress"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="getAddress_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getAddress"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getAddress_3" type="text" class="edit_input" value="<%=ld.getSequence("getAddress")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="getAddress_4"   <%=getCheck(ld.getAnchor("getAddress"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Title")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="getTitle" value="checkbox"  <%=getCheck(ld.getIstype("getTitle"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getTitle_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getTitle"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="getTitle_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getTitle"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getTitle_3" type="text" class="edit_input" value="<%=ld.getSequence("getTitle")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="getTitle_4"   <%=getCheck(ld.getAnchor("getTitle"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "加为好友")%>:</td>
      <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="friend" value="checkbox" <%=getCheck(ld.getIstype("friend"))%>> <%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%> <input name="friend_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("friend"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%> <input name="friend_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("friend"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="friend_3" type="text" class="edit_input" value="<%=ld.getSequence("friend")%>" maxlength="3" size="4" mask="int">
	 </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Signature")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="getSignature" value="checkbox"  <%=getCheck(ld.getIstype("getSignature"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="getSignature_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSignature"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="getSignature_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSignature"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getSignature_3" type="text" class="edit_input" value="<%=ld.getSequence("getSignature")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="getSignature_4"   <%=getCheck(ld.getAnchor("getSignature"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Edit")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="delete" value="checkbox"  <%=getCheck(ld.getIstype("delete"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="delete_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("delete"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="delete_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("delete"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="delete_3" type="text" class="edit_input" value="<%=ld.getSequence("delete")%>" maxlength="3" size="4" mask="int">
	 </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "BBS.nmark")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="nmark" value="checkbox"  <%=getCheck(ld.getIstype("nmark"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="nmark_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("nmark"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="nmark_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("nmark"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="nmark_3" type="text" class="edit_input" value="<%=ld.getSequence("nmark")%>" maxlength="3" size="4" mask="int">
	 </td>
    </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage, "回复/引用")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="quote" value="checkbox"  <%=getCheck(ld.getIstype("quote"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="quote_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("quote"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="quote_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("quote"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="quote_3" type="text" class="edit_input" value="<%=ld.getSequence("quote")%>" maxlength="3" size="4" mask="int">
	 </td>
    </tr>


    <tr>
      <td colspan="2"><hr size="1"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Creator")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_creator" value="checkbox"  <%=getCheck(ld.getIstype("r_creator"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_creator_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_creator"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_creator_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_creator"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_creator_3" type="text" class="edit_input" value="<%=ld.getSequence("r_creator")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_creator_4"   <%=getCheck(ld.getAnchor("r_creator"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>

     <!--回帖人会员ID-->
      <tr>
      <td><%=r.getString(teasession._nLanguage, "回帖人会员ID号")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_memberid" value="checkbox"  <%=getCheck(ld.getIstype("r_memberid"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_memberid_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_memberid"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_memberid_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_memberid"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_memberid_3" type="text" class="edit_input" value="<%=ld.getSequence("r_memberid")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_memberid_4"   <%=getCheck(ld.getAnchor("r_memberid"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Sex")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_sex" value="checkbox"  <%=getCheck(ld.getIstype("r_sex"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_sex_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_sex"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_sex_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_sex"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_sex_3" type="text" class="edit_input" value="<%=ld.getSequence("r_sex")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_sex_4"   <%=getCheck(ld.getAnchor("r_sex"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Count")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_count" value="checkbox"  <%=getCheck(ld.getIstype("r_count"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_count_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_count"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_count_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_count"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_count_3" type="text" class="edit_input" value="<%=ld.getSequence("r_count")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_count_4"   <%=getCheck(ld.getAnchor("r_count"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Register")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_register" value="checkbox"  <%=getCheck(ld.getIstype("r_register"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_register_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_register"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_register_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_register"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_register_3" type="text" class="edit_input" value="<%=ld.getSequence("r_register")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_register_4"   <%=getCheck(ld.getAnchor("r_register"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Photo")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_photo" value="checkbox"  <%=getCheck(ld.getIstype("r_photo"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_photo_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_photo"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_photo_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_photo"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_photo_3" type="text" class="edit_input" value="<%=ld.getSequence("r_photo")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_photo_4"   <%=getCheck(ld.getAnchor("r_photo"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "BBSLevel")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_level" value="checkbox"  <%=getCheck(ld.getIstype("r_level"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_level_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_level"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_level_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_level"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_level_3" type="text" class="edit_input" value="<%=ld.getSequence("r_level")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_level_4"   <%=getCheck(ld.getAnchor("r_level"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "积分")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_point" value="checkbox"  <%=getCheck(ld.getIstype("r_point"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%><input name="r_point_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_point"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="r_point_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_point"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="r_point_3" type="text" class="edit_input" value="<%=ld.getSequence("r_point")%>" maxlength="3" size="4" mask="int">
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "勋章")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_medal" value="checkbox"  <%=getCheck(ld.getIstype("r_medal"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%><input name="r_medal_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_medal"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="r_medal_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_medal"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="r_medal_3" type="text" class="edit_input" value="<%=ld.getSequence("r_medal")%>" maxlength="3" size="4" mask="int">
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "职务")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_position" value="checkbox"  <%=getCheck(ld.getIstype("r_position"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%><input name="r_position_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_position"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%><input name="r_position_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_position"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="r_position_3" type="text" class="edit_input" value="<%=ld.getSequence("r_position")%>" maxlength="3" size="4" mask="int">
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Floor")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_floor" value="checkbox"  <%=getCheck(ld.getIstype("r_floor"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_floor_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_floor"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_floor_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_floor"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_floor_3" type="text" class="edit_input" value="<%=ld.getSequence("r_floor")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_floor_4"   <%=getCheck(ld.getAnchor("r_floor"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_subject" value="checkbox"  <%=getCheck(ld.getIstype("r_subject"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_subject_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_subject"))%>" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_subject_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_subject"))%>" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_subject_3" type="text" class="edit_input" value="<%=ld.getSequence("r_subject")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_subject_4"   <%=getCheck(ld.getAnchor("r_subject"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_text" value="checkbox"  <%=getCheck(ld.getIstype("r_text"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_text"))%>" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_text"))%>" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_text_3" type="text" class="edit_input" value="<%=ld.getSequence("r_text")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_text_4"   <%=getCheck(ld.getAnchor("r_text"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "IssueTime")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_issue" value="checkbox"  <%=getCheck(ld.getIstype("r_issue"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_issue_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_issue"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_issue_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_issue"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_issue_3" type="text" class="edit_input" value="<%=ld.getSequence("r_issue")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_issue_4"   <%=getCheck(ld.getAnchor("r_issue"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td>IP:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_ip" value="checkbox"  <%=getCheck(ld.getIstype("r_ip"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_ip_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_ip"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_ip_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_ip"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_ip_3" type="text" class="edit_input" value="<%=ld.getSequence("r_ip")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_ip_4"   <%=getCheck(ld.getAnchor("r_ip"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "CBSetVisible")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_visible" value="checkbox"  <%=getCheck(ld.getIstype("r_visible"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_visible_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_visible"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_visible_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_visible"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_visible_3" type="text" class="edit_input" value="<%=ld.getSequence("r_visible")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_visible_4"   <%=getCheck(ld.getAnchor("r_visible"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Delete")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_delete" value="checkbox"  <%=getCheck(ld.getIstype("r_delete"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_delete_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_delete"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_delete_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_delete"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_delete_3" type="text" class="edit_input" value="<%=ld.getSequence("r_delete")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_delete_4"   <%=getCheck(ld.getAnchor("r_delete"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Title")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_getTitle" value="checkbox"  <%=getCheck(ld.getIstype("r_getTitle"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_getTitle_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_getTitle"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_getTitle_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_getTitle"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_getTitle_3" type="text" class="edit_input" value="<%=ld.getSequence("r_getTitle")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_getTitle_4"   <%=getCheck(ld.getAnchor("r_getTitle"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "加为好友")%>:</td>
      <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="r_friend" value="checkbox" <%=getCheck(ld.getIstype("r_friend"))%>> <%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%> <input name="r_friend_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_friend"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%> <input name="r_friend_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_friend"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="r_friend_3" type="text" class="edit_input" value="<%=ld.getSequence("r_friend")%>" maxlength="3" size="4" mask="int">
	 </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Signature")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_getSignature" value="checkbox"  <%=getCheck(ld.getIstype("r_getSignature"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_getSignature_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_getSignature"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_getSignature_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_getSignature"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_getSignature_3" type="text" class="edit_input" value="<%=ld.getSequence("r_getSignature")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_getSignature_4"   <%=getCheck(ld.getAnchor("r_getSignature"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>


        <tr>
      <td><%=r.getString(teasession._nLanguage, "Divide")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_pagination" value="checkbox"  <%=getCheck(ld.getIstype("r_pagination"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_pagination_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_pagination"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_pagination_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_pagination"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="r_pagination_3" type="text" class="edit_input" value="<%=ld.getSequence("r_pagination")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="r_pagination_4"   <%=getCheck(ld.getAnchor("r_pagination"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage, "回复/引用")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="r_quote" value="checkbox"  <%=getCheck(ld.getIstype("r_quote"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="r_quote_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("r_quote"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="r_quote_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("r_quote"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="r_quote_3" type="text" class="edit_input" value="<%=ld.getSequence("r_quote")%>" maxlength="3" size="4" mask="int">
	 </td>
    </tr>

    <tr>
      <td colspan="2"><hr size="1"></td>
    </tr>



    <tr>
      <td><%=r.getString(teasession._nLanguage, "Celerity")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="celerity" value="checkbox"  <%=getCheck(ld.getIstype("celerity"))%>>
        <%=r.getString(teasession._nLanguage, "Show")%> <%=r.getString(teasession._nLanguage, "Before")%>
        <input name="celerity_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("celerity"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "After")%>
        <input name="celerity_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("celerity"))%>" type="text" class="edit_input">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:
        <input name="celerity_3" type="text" class="edit_input" value="<%=ld.getSequence("celerity")%>" maxlength="3" size="4" mask="int">
        <input  id=CHECKBOX type="CHECKBOX" name="celerity_4"   <%=getCheck(ld.getAnchor("celerity"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
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
<SCRIPT><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.subject_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

