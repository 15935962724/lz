<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.resource.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


int listingid= h.getInt("Listing");
int realnode = Listing.find(listingid).getNode();
Node n = Node.find(realnode);


Resource r=new Resource("/tea/resource/Report");
boolean flag=request.getParameter("PickNode")==null;
ListingDetail ld=ListingDetail.find(listingid, 97, h.language);


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>细节</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=n.getAncestor(h.language)%></div>

<form name="form1" action="/servlet/EditListingDetail" method="post">
<input type="hidden" name="ListingType" value="97"/>
<input type="hidden" name="Listing" value="<%=listingid%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<%
if(!flag)
{
  out.print("<input type='hidden' name='PickNode' value="+h.get("PickNode")+" />");
}else
{
  out.print("<input type='hidden' name='PickManual' value="+h.get("PickManual")+" />");
}
if(h.getBool("Edit"))
{
  out.print("<input type='hidden' name='Edit' value="+request.getParameter("Edit")+" />");
}
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="right">主题:</td>
  <td>
  <select name="subject">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("subject"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="subject_1" value="<%=MT.f(ld.getBeforeItem("subject"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="subject_2" value="<%=MT.f(ld.getAfterItem("subject"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="subject_3" value="<%=ld.getSequence("subject")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="subject_4" <%if(0!=ld.getAnchor("subject"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="subject_5" value="<%=ld.getQuantity("subject")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">内容:</td>
  <td>
  <select name="content">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("content"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="content_1" value="<%=MT.f(ld.getBeforeItem("content"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="content_2" value="<%=MT.f(ld.getAfterItem("content"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="content_3" value="<%=ld.getSequence("content")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="content_4" <%if(0!=ld.getAnchor("content"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="content_5" value="<%=ld.getQuantity("content")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">图片:</td>
  <td>
  <select name="picture">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("picture"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="picture_1" value="<%=MT.f(ld.getBeforeItem("picture"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="picture_2" value="<%=MT.f(ld.getAfterItem("picture"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="picture_3" value="<%=ld.getSequence("picture")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="picture_4" <%if(0!=ld.getAnchor("picture"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="picture_5" value="<%=ld.getQuantity("picture")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">视频:</td>
  <td>
  <select name="voice">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("voice"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="voice_1" value="<%=MT.f(ld.getBeforeItem("voice"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="voice_2" value="<%=MT.f(ld.getAfterItem("voice"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="voice_3" value="<%=ld.getSequence("voice")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="voice_4" <%if(0!=ld.getAnchor("voice"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="voice_5" value="<%=ld.getQuantity("voice")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
<tr>
  <td align="right">发生时间:</td>
  <td>
  <select name="otime">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("otime"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="otime_1" value="<%=MT.f(ld.getBeforeItem("otime"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="otime_2" value="<%=MT.f(ld.getAfterItem("otime"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="otime_3" value="<%=ld.getSequence("otime")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="otime_4" <%if(0!=ld.getAnchor("otime"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="otime_5" value="<%=ld.getQuantity("otime")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>



<tr>
  <td align="right">来源出处:</td>
  <td>
  <select name="source">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("source"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="source_1" value="<%=MT.f(ld.getBeforeItem("source"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="source_2" value="<%=MT.f(ld.getAfterItem("source"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="source_3" value="<%=ld.getSequence("source")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="source_4" <%if(0!=ld.getAnchor("source"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="source_5" value="<%=ld.getQuantity("source")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">来源出处说明:</td>
  <td>
  <select name="sourcedesc">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("sourcedesc"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="sourcedesc_1" value="<%=MT.f(ld.getBeforeItem("sourcedesc"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="sourcedesc_2" value="<%=MT.f(ld.getAfterItem("sourcedesc"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="sourcedesc_3" value="<%=ld.getSequence("sourcedesc")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="sourcedesc_4" <%if(0!=ld.getAnchor("sourcedesc"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="sourcedesc_5" value="<%=ld.getQuantity("sourcedesc")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
<%--
<tr>
  <td align="right">分享人:</td>
  <td>
  <select name="smember">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("smember"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="smember_1" value="<%=MT.f(ld.getBeforeItem("smember"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="smember_2" value="<%=MT.f(ld.getAfterItem("smember"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="smember_3" value="<%=ld.getSequence("smember")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="smember_4" <%if(0!=ld.getAnchor("smember"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="smember_5" value="<%=ld.getQuantity("smember")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
--%>
<tr>
  <td align="right">上传时间:</td>
  <td>
  <select name="time">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("time"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="time_1" value="<%=MT.f(ld.getBeforeItem("time"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="time_2" value="<%=MT.f(ld.getAfterItem("time"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="time_3" value="<%=ld.getSequence("time")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="time_4" <%if(0!=ld.getAnchor("time"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="time_5" value="<%=ld.getQuantity("time")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
<tr><td colspan="3"><h2>微博</h2></td>
<tr>
  <td align="right">微博姓名:</td>
  <td>
  <select name="mname">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("mname"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="mname_1" value="<%=MT.f(ld.getBeforeItem("mname"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="mname_2" value="<%=MT.f(ld.getAfterItem("mname"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="mname_3" value="<%=ld.getSequence("mname")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="mname_4" <%if(0!=ld.getAnchor("mname"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="mname_5" value="<%=ld.getQuantity("mname")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">头像:</td>
  <td>
  <select name="avatar">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("avatar"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="avatar_1" value="<%=MT.f(ld.getBeforeItem("avatar"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="avatar_2" value="<%=MT.f(ld.getAfterItem("avatar"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="avatar_3" value="<%=ld.getSequence("avatar")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="avatar_4" <%if(0!=ld.getAnchor("avatar"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="avatar_5" value="<%=ld.getQuantity("avatar")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
<%--
<tr>
  <td align="right">是否已认证:</td>
  <td>
  <select name="verified">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("verified"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="verified_1" value="<%=MT.f(ld.getBeforeItem("verified"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="verified_2" value="<%=MT.f(ld.getAfterItem("verified"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="verified_3" value="<%=ld.getSequence("verified")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="verified_4" <%if(0!=ld.getAnchor("verified"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="verified_5" value="<%=ld.getQuantity("verified")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">微博ID:</td>
  <td>
  <select name="micro">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("micro"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="micro_1" value="<%=MT.f(ld.getBeforeItem("micro"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="micro_2" value="<%=MT.f(ld.getAfterItem("micro"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="micro_3" value="<%=ld.getSequence("micro")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="micro_4" <%if(0!=ld.getAnchor("micro"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="micro_5" value="<%=ld.getQuantity("micro")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">微博的用户ID:</td>
  <td>
  <select name="muser">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("muser"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="muser_1" value="<%=MT.f(ld.getBeforeItem("muser"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="muser_2" value="<%=MT.f(ld.getAfterItem("muser"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="muser_3" value="<%=ld.getSequence("muser")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="muser_4" <%if(0!=ld.getAnchor("muser"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="muser_5" value="<%=ld.getQuantity("muser")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
--%>
<tr>
  <td align="right">转发数:</td>
  <td>
  <select name="redirect">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("redirect"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="redirect_1" value="<%=MT.f(ld.getBeforeItem("redirect"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="redirect_2" value="<%=MT.f(ld.getAfterItem("redirect"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="redirect_3" value="<%=ld.getSequence("redirect")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="redirect_4" <%if(0!=ld.getAnchor("redirect"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="redirect_5" value="<%=ld.getQuantity("redirect")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">评论数:</td>
  <td>
  <select name="comments">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("comments"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="comments_1" value="<%=MT.f(ld.getBeforeItem("comments"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="comments_2" value="<%=MT.f(ld.getAfterItem("comments"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="comments_3" value="<%=ld.getSequence("comments")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="comments_4" <%if(0!=ld.getAnchor("comments"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="comments_5" value="<%=ld.getQuantity("comments")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
<tr>
  <td align="right">微博内容:</td>
  <td>
  <select name="mtext">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("mtext"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="mtext_1" value="<%=MT.f(ld.getBeforeItem("mtext"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="mtext_2" value="<%=MT.f(ld.getAfterItem("mtext"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="mtext_3" value="<%=ld.getSequence("mtext")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="mtext_4" <%if(0!=ld.getAnchor("mtext"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="mtext_5" value="<%=ld.getQuantity("mtext")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
<tr>
  <td align="right">分享时间:</td>
  <td>
  <select name="stime">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("stime"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="stime_1" value="<%=MT.f(ld.getBeforeItem("stime"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="stime_2" value="<%=MT.f(ld.getAfterItem("stime"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="stime_3" value="<%=ld.getSequence("stime")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="stime_4" <%if(0!=ld.getAnchor("stime"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="stime_5" value="<%=ld.getQuantity("stime")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
</table>


<input type="submit" class="edit_button" name="GoBack" value="<%=r.getString(h.language, "GoBack")%>">
<input type="submit" class="edit_button" value="<%=r.getString(h.language, "Submit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
