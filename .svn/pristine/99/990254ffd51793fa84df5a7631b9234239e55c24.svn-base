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
ListingDetail ld=ListingDetail.find(listingid, 102, h.language);


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
<input type="hidden" name="ListingType" value="102"/>
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
  <td align="right">编号:</td>
  <td>
  <select name="code">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("code"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="code_1" value="<%=MT.f(ld.getBeforeItem("code"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="code_2" value="<%=MT.f(ld.getAfterItem("code"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="code_3" value="<%=ld.getSequence("code")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="code_4" <%if(0!=ld.getAnchor("code"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="code_5" value="<%=ld.getQuantity("code")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">级别:</td>
  <td>
  <select name="level">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("level"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="level_1" value="<%=MT.f(ld.getBeforeItem("level"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="level_2" value="<%=MT.f(ld.getAfterItem("level"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="level_3" value="<%=ld.getSequence("level")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="level_4" <%if(0!=ld.getAnchor("level"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="level_5" value="<%=ld.getQuantity("level")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">类型:</td>
  <td>
  <select name="type">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("type"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="type_1" value="<%=MT.f(ld.getBeforeItem("type"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="type_2" value="<%=MT.f(ld.getAfterItem("type"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="type_3" value="<%=ld.getSequence("type")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="type_4" <%if(0!=ld.getAnchor("type"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="type_5" value="<%=ld.getQuantity("type")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">所属部门:</td>
  <td>
  <select name="dept">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("dept"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="dept_1" value="<%=MT.f(ld.getBeforeItem("dept"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="dept_2" value="<%=MT.f(ld.getAfterItem("dept"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="dept_3" value="<%=ld.getSequence("dept")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="dept_4" <%if(0!=ld.getAnchor("dept"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="dept_5" value="<%=ld.getQuantity("dept")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">地区:</td>
  <td>
  <select name="city">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("city"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="city_1" value="<%=MT.f(ld.getBeforeItem("city"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="city_2" value="<%=MT.f(ld.getAfterItem("city"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="city_3" value="<%=ld.getSequence("city")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="city_4" <%if(0!=ld.getAnchor("city"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="city_5" value="<%=ld.getQuantity("city")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">行政区域:</td>
  <td>
  <select name="adminarea">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("adminarea"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="adminarea_1" value="<%=MT.f(ld.getBeforeItem("adminarea"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="adminarea_2" value="<%=MT.f(ld.getAfterItem("adminarea"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="adminarea_3" value="<%=ld.getSequence("adminarea")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="adminarea_4" <%if(0!=ld.getAnchor("adminarea"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="adminarea_5" value="<%=ld.getQuantity("adminarea")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">主要保护对象:</td>
  <td>
  <select name="protect">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("protect"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="protect_1" value="<%=MT.f(ld.getBeforeItem("protect"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="protect_2" value="<%=MT.f(ld.getAfterItem("protect"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="protect_3" value="<%=ld.getSequence("protect")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="protect_4" <%if(0!=ld.getAnchor("protect"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="protect_5" value="<%=ld.getQuantity("protect")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">总面积:</td>
  <td>
  <select name="area">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("area"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="area_1" value="<%=MT.f(ld.getBeforeItem("area"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="area_2" value="<%=MT.f(ld.getAfterItem("area"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="area_3" value="<%=ld.getSequence("area")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="area_4" <%if(0!=ld.getAnchor("area"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="area_5" value="<%=ld.getQuantity("area")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">批建时间:</td>
  <td>
  <select name="years">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("years"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="years_1" value="<%=MT.f(ld.getBeforeItem("years"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="years_2" value="<%=MT.f(ld.getAfterItem("years"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="years_3" value="<%=ld.getSequence("years")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="years_4" <%if(0!=ld.getAnchor("years"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="years_5" value="<%=ld.getQuantity("years")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
<tr>
  <td align="right">地图:</td>
  <td>
  <select name="map">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("map"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="map_1" value="<%=MT.f(ld.getBeforeItem("map"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="map_2" value="<%=MT.f(ld.getAfterItem("map"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="map_3" value="<%=ld.getSequence("map")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="years_4" <%if(0!=ld.getAnchor("map"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="map_5" value="<%=ld.getQuantity("map")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
<tr>
    <td align="right">保护区关联组图:</td>
  <td>
  <select name="album">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("album"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
    
    
    <%=r.getString(h.language, "Before")%><input name="album_1" mask="max" value="<%=MT.f(ld.getBeforeItem("album"))%>" type="text">
    <%=r.getString(h.language, "After")%><input name="album_2" mask="max" value="<%=MT.f(ld.getAfterItem("album"))%>" type="text">
    <%=r.getString(h.language, "Sequence")%>:<input name="album_3" type="text" value="<%=ld.getSequence("album")%>" maxlength="3" size="4">
    <input id=CHECKBOX type="checkbox" name="album_4" <%if(0!=ld.getAnchor("album"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="album_5" value="<%=ld.getQuantity("album")%>" mask="int" maxlength="3" size="4"/>
  </tr>
</table>


<input type="submit" class="edit_button" name="GoBack" value="<%=r.getString(h.language, "GoBack")%>">
<input type="submit" class="edit_button" value="<%=r.getString(h.language, "Submit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
