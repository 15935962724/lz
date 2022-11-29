<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.resource.*"%><%

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
ListingDetail ld=ListingDetail.find(listingid, 101, h.language);


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<input type="hidden" name="ListingType" value="101"/>
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
  <td align="right" title="无描述时,取内容并过滤HTML">描述:</td>
  <td>
  <select name="description">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("description"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="description_1" value="<%=MT.f(ld.getBeforeItem("description"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="description_2" value="<%=MT.f(ld.getAfterItem("description"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="description_3" value="<%=ld.getSequence("description")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="description_4" <%if(0!=ld.getAnchor("description"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="description_5" value="<%=ld.getQuantity("description")%>" mask="int" maxlength="3" size="4"/>
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
  <td align="right">培训开始时间:</td>
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
  <td align="right">培训结束时间:</td>
  <td>
  <select name="stoptime">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("stoptime"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="stoptime_1" value="<%=MT.f(ld.getBeforeItem("stoptime"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="stoptime_2" value="<%=MT.f(ld.getAfterItem("stoptime"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="stoptime_3" value="<%=ld.getSequence("stoptime")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="stoptime_4" <%if(0!=ld.getAnchor("stoptime"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="stoptime_5" value="<%=ld.getQuantity("stoptime")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>


<tr>
  <td align="right">培训机构:</td>
  <td>
  <select name="org">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("org"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="org_1" value="<%=MT.f(ld.getBeforeItem("org"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="org_2" value="<%=MT.f(ld.getAfterItem("org"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="org_3" value="<%=ld.getSequence("org")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="org_4" <%if(0!=ld.getAnchor("org"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="org_5" value="<%=ld.getQuantity("org")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">培训地址:</td>
  <td>
  <select name="address">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("address"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="address_1" value="<%=MT.f(ld.getBeforeItem("address"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="address_2" value="<%=MT.f(ld.getAfterItem("address"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="address_3" value="<%=ld.getSequence("address")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="address_4" <%if(0!=ld.getAnchor("address"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="address_5" value="<%=ld.getQuantity("address")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">联系电话:</td>
  <td>
  <select name="tel">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("tel"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="tel_1" value="<%=MT.f(ld.getBeforeItem("tel"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="tel_2" value="<%=MT.f(ld.getAfterItem("tel"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="tel_3" value="<%=ld.getSequence("tel")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="tel_4" <%if(0!=ld.getAnchor("tel"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="tel_5" value="<%=ld.getQuantity("tel")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">培训费用:</td>
  <td>
  <select name="price">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("price"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="price_1" value="<%=MT.f(ld.getBeforeItem("price"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="price_2" value="<%=MT.f(ld.getAfterItem("price"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="price_3" value="<%=ld.getSequence("price")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="price_4" <%if(0!=ld.getAnchor("price"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="price_5" value="<%=ld.getQuantity("price")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">报名截止时间:</td>
  <td>
  <select name="regstop">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("regstop"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="regstop_1" value="<%=MT.f(ld.getBeforeItem("regstop"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="regstop_2" value="<%=MT.f(ld.getAfterItem("regstop"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="regstop_3" value="<%=ld.getSequence("regstop")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="regstop_4" <%if(0!=ld.getAnchor("regstop"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="regstop_5" value="<%=ld.getQuantity("regstop")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">报名人数:</td>
  <td>
  <select name="quantity">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("quantity"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="quantity_1" value="<%=MT.f(ld.getBeforeItem("quantity"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="quantity_2" value="<%=MT.f(ld.getAfterItem("quantity"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="quantity_3" value="<%=ld.getSequence("quantity")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="quantity_4" <%if(0!=ld.getAnchor("quantity"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="quantity_5" value="<%=ld.getQuantity("quantity")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">我要报名:</td>
  <td>
  <select name="planadd">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("planadd"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="planadd_1" value="<%=MT.f(ld.getBeforeItem("planadd"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="planadd_2" value="<%=MT.f(ld.getAfterItem("planadd"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="planadd_3" value="<%=ld.getSequence("planadd")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">课件_视频:</td>
  <td>
  <select name="video">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("video"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="video_1" value="<%=MT.f(ld.getBeforeItem("video"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="video_2" value="<%=MT.f(ld.getAfterItem("video"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="video_3" value="<%=ld.getSequence("video")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">课件_文档:</td>
  <td>
  <select name="paper">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("paper"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="paper_1" value="<%=MT.f(ld.getBeforeItem("paper"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="paper_2" value="<%=MT.f(ld.getAfterItem("paper"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="paper_3" value="<%=ld.getSequence("paper")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
</table>


<input type="submit" class="edit_button" name="GoBack" value="<%=r.getString(h.language, "GoBack")%>">
<input type="submit" class="edit_button" value="<%=r.getString(h.language, "Submit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
