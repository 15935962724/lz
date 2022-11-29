<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.resource.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}


int listingid= h.getInt("Listing");
int realnode = Listing.find(listingid).getNode();
Node n = Node.find(realnode);


Resource r=new Resource("/tea/resource/Report");
boolean flag=request.getParameter("PickNode")==null;
ListingDetail ld=ListingDetail.find(listingid, 108, h.language);


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>细节</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=n.getAncestor(h.language)%></div>

<form name="form1" action="/servlet/EditListingDetail" method="post">
<input type="hidden" name="ListingType" value="108"/>
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
  <td align="right">主题词:</td>
  <td>
  <select name="keywords">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("keywords"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="keywords_1" value="<%=MT.f(ld.getBeforeItem("keywords"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="keywords_2" value="<%=MT.f(ld.getAfterItem("keywords"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="keywords_3" value="<%=ld.getSequence("keywords")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="keywords_4" <%if(0!=ld.getAnchor("keywords"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="keywords_5" value="<%=ld.getQuantity("keywords")%>" mask="int" maxlength="3" size="4"/>
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
  <td align="right">缩略图:</td>
  <td>
  <select name="thumbs">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("thumbs"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="thumbs_1" value="<%=MT.f(ld.getBeforeItem("thumbs"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="thumbs_2" value="<%=MT.f(ld.getAfterItem("thumbs"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="thumbs_3" value="<%=ld.getSequence("thumbs")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="thumbs_4" <%if(0!=ld.getAnchor("thumbs"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="thumbs_5" value="<%=ld.getQuantity("thumbs")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
<tr>
  <td align="right">标本图片:</td>
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
  <td align="right">拍摄时间:</td>
  <td>
  <select name="starttime">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("starttime"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="starttime_1" value="<%=MT.f(ld.getBeforeItem("starttime"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="starttime_2" value="<%=MT.f(ld.getAfterItem("starttime"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="starttime_3" value="<%=ld.getSequence("starttime")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="starttime_4" <%if(0!=ld.getAnchor("starttime"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="starttime_5" value="<%=ld.getQuantity("starttime")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">标本名称:</td>
  <td>
  <select name="specimen">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("specimen"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="specimen_1" value="<%=MT.f(ld.getBeforeItem("specimen"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="specimen_2" value="<%=MT.f(ld.getAfterItem("specimen"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="specimen_3" value="<%=ld.getSequence("specimen")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="specimen_4" <%if(0!=ld.getAnchor("specimen"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="specimen_5" value="<%=ld.getQuantity("specimen")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">保护区名称:</td>
  <td>
  <select name="reserve">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("reserve"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="reserve_1" value="<%=MT.f(ld.getBeforeItem("reserve"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="reserve_2" value="<%=MT.f(ld.getAfterItem("reserve"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="reserve_3" value="<%=ld.getSequence("reserve")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="reserve_4" <%if(0!=ld.getAnchor("reserve"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="reserve_5" value="<%=ld.getQuantity("reserve")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>


<tr>
  <td align="right">多媒体类型:</td>
  <td>
  <select name="multype">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("multype"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="multype_1" value="<%=MT.f(ld.getBeforeItem("multype"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="multype_2" value="<%=MT.f(ld.getAfterItem("multype"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="multype_3" value="<%=ld.getSequence("multype")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="multype_4" <%if(0!=ld.getAnchor("multype"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="multype_5" value="<%=ld.getQuantity("multype")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">版权人:</td>
  <td>
  <select name="copyrightowner">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("copyrightowner"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="copyrightowner_1" value="<%=MT.f(ld.getBeforeItem("copyrightowner"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="copyrightowner_2" value="<%=MT.f(ld.getAfterItem("copyrightowner"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="copyrightowner_3" value="<%=ld.getSequence("copyrightowner")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="copyrightowner_4" <%if(0!=ld.getAnchor("copyrightowner"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="copyrightowner_5" value="<%=ld.getQuantity("copyrightowner")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">资源归类码:</td>
  <td>
  <select name="zyglm">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("zyglm"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="zyglm_1" value="<%=MT.f(ld.getBeforeItem("zyglm"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="zyglm_2" value="<%=MT.f(ld.getAfterItem("zyglm"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="zyglm_3" value="<%=ld.getSequence("zyglm")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="zyglm_4" <%if(0!=ld.getAnchor("zyglm"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="zyglm_5" value="<%=ld.getQuantity("zyglm")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

</table>


<input type="submit" class="edit_button" name="GoBack" value="<%=r.getString(h.language, "GoBack")%>">
<input type="submit" class="edit_button" value="<%=r.getString(h.language, "Submit")%>">
</form>

<a href="javascript:mt.detail()">填写</a>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
