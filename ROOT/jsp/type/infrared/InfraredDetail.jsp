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
ListingDetail ld=ListingDetail.find(listingid, 107, h.language);


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>细节——红外相机</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=n.getAncestor(h.language)%></div>

<form name="form1" action="/servlet/EditListingDetail" method="post">
<input type="hidden" name="ListingType" value="107"/>
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
  <td align="right">小图:</td>
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
  <td align="right">物种鉴定人:</td>
  <td>
  <select name="wzjdr">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("wzjdr"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="wzjdr_1" value="<%=MT.f(ld.getBeforeItem("wzjdr"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="wzjdr_2" value="<%=MT.f(ld.getAfterItem("wzjdr"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="wzjdr_3" value="<%=ld.getSequence("wzjdr")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="wzjdr_4" <%if(0!=ld.getAnchor("wzjdr"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="wzjdr_5" value="<%=ld.getQuantity("wzjdr")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">备注说明:</td>
  <td>
  <select name="remark">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("remark"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="remark_1" value="<%=MT.f(ld.getBeforeItem("remark"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="remark_2" value="<%=MT.f(ld.getAfterItem("remark"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="remark_3" value="<%=ld.getSequence("remark")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="remark_4" <%if(0!=ld.getAnchor("remark"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="remark_5" value="<%=ld.getQuantity("remark")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">照片名称:</td>
  <td>
  <select name="pname">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("pname"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="pname_1" value="<%=MT.f(ld.getBeforeItem("pname"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="pname_2" value="<%=MT.f(ld.getAfterItem("pname"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="pname_3" value="<%=ld.getSequence("pname")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="pname_4" <%if(0!=ld.getAnchor("pname"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="pname_5" value="<%=ld.getQuantity("pname")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">拍摄时间:</td>
  <td>
  <select name="pstime">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("pstime"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="pstime_1" value="<%=MT.f(ld.getBeforeItem("pstime"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="pstime_2" value="<%=MT.f(ld.getAfterItem("pstime"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="pstime_3" value="<%=ld.getSequence("pstime")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="pstime_4" <%if(0!=ld.getAnchor("pstime"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="pstime_5" value="<%=ld.getQuantity("pstime")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">对象类别:</td>
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
  <td align="right">物种名称:</td>
  <td>
  <select name="wzname">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("wzname"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="wzname_1" value="<%=MT.f(ld.getBeforeItem("wzname"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="wzname_2" value="<%=MT.f(ld.getAfterItem("wzname"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="wzname_3" value="<%=ld.getSequence("wzname")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="wzname_4" <%if(0!=ld.getAnchor("wzname"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="wzname_5" value="<%=ld.getQuantity("wzname")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">动物数量:</td>
  <td>
  <select name="num">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("num"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="num_1" value="<%=MT.f(ld.getBeforeItem("num"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="num_2" value="<%=MT.f(ld.getAfterItem("num"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="num_3" value="<%=ld.getSequence("num")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="num_4" <%if(0!=ld.getAnchor("num"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="num_5" value="<%=ld.getQuantity("num")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">动物性别:</td>
  <td>
  <select name="gender">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("gender"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="gender_1" value="<%=MT.f(ld.getBeforeItem("gender"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="gender_2" value="<%=MT.f(ld.getAfterItem("gender"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="gender_3" value="<%=ld.getSequence("gender")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="gender_4" <%if(0!=ld.getAnchor("gender"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="gender_5" value="<%=ld.getQuantity("gender")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">备注:</td>
  <td>
  <select name="remark2">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("remark2"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="remark2_1" value="<%=MT.f(ld.getBeforeItem("remark2"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="remark2_2" value="<%=MT.f(ld.getAfterItem("remark2"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="remark2_3" value="<%=ld.getSequence("remark2")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="remark2_4" <%if(0!=ld.getAnchor("remark2"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="remark2_5" value="<%=ld.getQuantity("remark2")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">布设位点编号:</td>
  <td>
  <select name="bswdnum">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("bswdnum"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="bswdnum_1" value="<%=MT.f(ld.getBeforeItem("bswdnum"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="bswdnum_2" value="<%=MT.f(ld.getAfterItem("bswdnum"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="bswdnum_3" value="<%=ld.getSequence("bswdnum")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="bswdnum_4" <%if(0!=ld.getAnchor("bswdnum"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="bswdnum_5" value="<%=ld.getQuantity("bswdnum")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">相机编号:</td>
  <td>
  <select name="camnum">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("camnum"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="camnum_1" value="<%=MT.f(ld.getBeforeItem("camnum"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="camnum_2" value="<%=MT.f(ld.getAfterItem("camnum"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="camnum_3" value="<%=ld.getSequence("camnum")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="camnum_4" <%if(0!=ld.getAnchor("camnum"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="camnum_5" value="<%=ld.getQuantity("camnum")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">存储卡编号:</td>
  <td>
  <select name="sdnum">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("sdnum"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="sdnum_1" value="<%=MT.f(ld.getBeforeItem("sdnum"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="sdnum_2" value="<%=MT.f(ld.getAfterItem("sdnum"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="sdnum_3" value="<%=ld.getSequence("sdnum")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="sdnum_4" <%if(0!=ld.getAnchor("sdnum"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="sdnum_5" value="<%=ld.getQuantity("sdnum")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">日期:</td>
  <td>
  <select name="thedate">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("thedate"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="thedate_1" value="<%=MT.f(ld.getBeforeItem("thedate"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="thedate_2" value="<%=MT.f(ld.getAfterItem("thedate"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="thedate_3" value="<%=ld.getSequence("thedate")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="thedate_4" <%if(0!=ld.getAnchor("thedate"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="thedate_5" value="<%=ld.getQuantity("thedate")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">天气:</td>
  <td>
  <select name="weather">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("weather"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="weather_1" value="<%=MT.f(ld.getBeforeItem("weather"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="weather_2" value="<%=MT.f(ld.getAfterItem("weather"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="weather_3" value="<%=ld.getSequence("weather")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="weather_4" <%if(0!=ld.getAnchor("weather"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="weather_5" value="<%=ld.getQuantity("weather")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">放置时间:</td>
  <td>
  <select name="storagetime">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("storagetime"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="storagetime_1" value="<%=MT.f(ld.getBeforeItem("storagetime"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="storagetime_2" value="<%=MT.f(ld.getAfterItem("storagetime"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="storagetime_3" value="<%=ld.getSequence("storagetime")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="storagetime_4" <%if(0!=ld.getAnchor("storagetime"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="storagetime_5" value="<%=ld.getQuantity("storagetime")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">小地名:</td>
  <td>
  <select name="placenames">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("placenames"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="placenames_1" value="<%=MT.f(ld.getBeforeItem("placenames"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="placenames_2" value="<%=MT.f(ld.getAfterItem("placenames"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="placenames_3" value="<%=ld.getSequence("placenames")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="placenames_4" <%if(0!=ld.getAnchor("placenames"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="placenames_5" value="<%=ld.getQuantity("placenames")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">参加人员:</td>
  <td>
  <select name="participants">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("participants"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="participants_1" value="<%=MT.f(ld.getBeforeItem("participants"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="participants_2" value="<%=MT.f(ld.getAfterItem("participants"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="participants_3" value="<%=ld.getSequence("participants")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="participants_4" <%if(0!=ld.getAnchor("participants"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="participants_5" value="<%=ld.getQuantity("participants")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">填表人:</td>
  <td>
  <select name="fillin">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("fillin"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="fillin_1" value="<%=MT.f(ld.getBeforeItem("fillin"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="fillin_2" value="<%=MT.f(ld.getAfterItem("fillin"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="fillin_3" value="<%=ld.getSequence("fillin")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="fillin_4" <%if(0!=ld.getAnchor("fillin"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="fillin_5" value="<%=ld.getQuantity("fillin")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">东经:</td>
  <td>
  <select name="eastlongitude">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("eastlongitude"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="eastlongitude_1" value="<%=MT.f(ld.getBeforeItem("eastlongitude"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="eastlongitude_2" value="<%=MT.f(ld.getAfterItem("eastlongitude"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="eastlongitude_3" value="<%=ld.getSequence("eastlongitude")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="eastlongitude_4" <%if(0!=ld.getAnchor("eastlongitude"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="eastlongitude_5" value="<%=ld.getQuantity("eastlongitude")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">北纬:</td>
  <td>
  <select name="northlatitude">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("northlatitude"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="northlatitude_1" value="<%=MT.f(ld.getBeforeItem("northlatitude"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="northlatitude_2" value="<%=MT.f(ld.getAfterItem("northlatitude"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="northlatitude_3" value="<%=ld.getSequence("northlatitude")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="northlatitude_4" <%if(0!=ld.getAnchor("northlatitude"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="northlatitude_5" value="<%=ld.getQuantity("northlatitude")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">海拔:</td>
  <td>
  <select name="poster">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("poster"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="poster_1" value="<%=MT.f(ld.getBeforeItem("poster"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="poster_2" value="<%=MT.f(ld.getAfterItem("poster"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="poster_3" value="<%=ld.getSequence("poster")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="poster_4" <%if(0!=ld.getAnchor("poster"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="poster_5" value="<%=ld.getQuantity("poster")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">坡度:</td>
  <td>
  <select name="slope">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("slope"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="slope_1" value="<%=MT.f(ld.getBeforeItem("slope"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="slope_2" value="<%=MT.f(ld.getAfterItem("slope"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="slope_3" value="<%=ld.getSequence("slope")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="slope_4" <%if(0!=ld.getAnchor("slope"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="slope_5" value="<%=ld.getQuantity("slope")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">坡向:</td>
  <td>
  <select name="slopedirection">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("slopedirection"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="slopedirection_1" value="<%=MT.f(ld.getBeforeItem("slopedirection"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="slopedirection_2" value="<%=MT.f(ld.getAfterItem("slopedirection"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="slopedirection_3" value="<%=ld.getSequence("slopedirection")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="slopedirection_4" <%if(0!=ld.getAnchor("slopedirection"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="slopedirection_5" value="<%=ld.getQuantity("slopedirection")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">生境类型:</td>
  <td>
  <select name="sjlx">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("sjlx"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="sjlx_1" value="<%=MT.f(ld.getBeforeItem("sjlx"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="sjlx_2" value="<%=MT.f(ld.getAfterItem("sjlx"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="sjlx_3" value="<%=ld.getSequence("sjlx")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="sjlx_4" <%if(0!=ld.getAnchor("sjlx"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="sjlx_5" value="<%=ld.getQuantity("sjlx")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">森林起源:</td>
  <td>
  <select name="slqy">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("slqy"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="slqy_1" value="<%=MT.f(ld.getBeforeItem("slqy"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="slqy_2" value="<%=MT.f(ld.getAfterItem("slqy"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="slqy_3" value="<%=ld.getSequence("slqy")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="slqy_4" <%if(0!=ld.getAnchor("slqy"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="slqy_5" value="<%=ld.getQuantity("slqy")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">小生境:</td>
  <td>
  <select name="xsj">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("xsj"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="xsj_1" value="<%=MT.f(ld.getBeforeItem("xsj"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="xsj_2" value="<%=MT.f(ld.getAfterItem("xsj"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="xsj_3" value="<%=ld.getSequence("xsj")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="xsj_4" <%if(0!=ld.getAnchor("xsj"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="xsj_5" value="<%=ld.getQuantity("xsj")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">乔木高度/米:</td>
  <td>
  <select name="qmgd">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("qmgd"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="qmgd_1" value="<%=MT.f(ld.getBeforeItem("qmgd"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="qmgd_2" value="<%=MT.f(ld.getAfterItem("qmgd"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="qmgd_3" value="<%=ld.getSequence("qmgd")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="qmgd_4" <%if(0!=ld.getAnchor("qmgd"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="qmgd_5" value="<%=ld.getQuantity("qmgd")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">郁闭度:</td>
  <td>
  <select name="ybd">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("ybd"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="ybd_1" value="<%=MT.f(ld.getBeforeItem("ybd"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="ybd_2" value="<%=MT.f(ld.getAfterItem("ybd"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="ybd_3" value="<%=ld.getSequence("ybd")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="ybd_4" <%if(0!=ld.getAnchor("ybd"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="ybd_5" value="<%=ld.getQuantity("ybd")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">胸径/cm:</td>
  <td>
  <select name="xj">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("xj"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="xj_1" value="<%=MT.f(ld.getBeforeItem("xj"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="xj_2" value="<%=MT.f(ld.getAfterItem("xj"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="xj_3" value="<%=ld.getSequence("xj")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="xj_4" <%if(0!=ld.getAnchor("xj"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="xj_5" value="<%=ld.getQuantity("xj")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">优势树种:</td>
  <td>
  <select name="yssz">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("yssz"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="yssz_1" value="<%=MT.f(ld.getBeforeItem("yssz"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="yssz_2" value="<%=MT.f(ld.getAfterItem("yssz"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="yssz_3" value="<%=ld.getSequence("yssz")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="yssz_4" <%if(0!=ld.getAnchor("yssz"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="yssz_5" value="<%=ld.getQuantity("yssz")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">灌木高度/米:</td>
  <td>
  <select name="gmgd">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("gmgd"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="gmgd_1" value="<%=MT.f(ld.getBeforeItem("gmgd"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="gmgd_2" value="<%=MT.f(ld.getAfterItem("gmgd"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="gmgd_3" value="<%=ld.getSequence("gmgd")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="gmgd_4" <%if(0!=ld.getAnchor("gmgd"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="gmgd_5" value="<%=ld.getQuantity("gmgd")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">灌木郁闭度:</td>
  <td>
  <select name="gmymd">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("gmymd"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="gmymd_1" value="<%=MT.f(ld.getBeforeItem("gmymd"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="gmymd_2" value="<%=MT.f(ld.getAfterItem("gmymd"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="gmymd_3" value="<%=ld.getSequence("gmymd")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="gmymd_4" <%if(0!=ld.getAnchor("gmymd"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="gmymd_5" value="<%=ld.getQuantity("gmymd")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">干扰类型:</td>
  <td>
  <select name="grlx">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("grlx"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="grlx_1" value="<%=MT.f(ld.getBeforeItem("grlx"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="grlx_2" value="<%=MT.f(ld.getAfterItem("grlx"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="grlx_3" value="<%=ld.getSequence("grlx")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="grlx_4" <%if(0!=ld.getAnchor("grlx"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="grlx_5" value="<%=ld.getQuantity("grlx")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">干扰强度:</td>
  <td>
  <select name="grqd">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("grqd"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="grqd_1" value="<%=MT.f(ld.getBeforeItem("grqd"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="grqd_2" value="<%=MT.f(ld.getAfterItem("grqd"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="grqd_3" value="<%=ld.getSequence("grqd")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="grqd_4" <%if(0!=ld.getAnchor("grqd"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="grqd_5" value="<%=ld.getQuantity("grqd")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">干扰频率:</td>
  <td>
  <select name="grpl">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("grpl"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="grpl_1" value="<%=MT.f(ld.getBeforeItem("grpl"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="grpl_2" value="<%=MT.f(ld.getAfterItem("grpl"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="grpl_3" value="<%=ld.getSequence("grpl")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="grpl_4" <%if(0!=ld.getAnchor("grpl"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="grpl_5" value="<%=ld.getQuantity("grpl")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
</table>

<h2>动物1</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="right">动物名称1:</td>
  <td>
  <select name="animalnameone">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("animalnameone"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="animalnameone_1" value="<%=MT.f(ld.getBeforeItem("animalnameone"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="animalnameone_2" value="<%=MT.f(ld.getAfterItem("animalnameone"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="animalnameone_3" value="<%=ld.getSequence("animalnameone")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="animalnameone_4" <%if(0!=ld.getAnchor("animalnameone"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="animalnameone_5" value="<%=ld.getQuantity("animalnameone")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">痕迹类型1:</td>
  <td>
  <select name="hjlxone">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("hjlxone"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="hjlxone_1" value="<%=MT.f(ld.getBeforeItem("hjlxone"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="hjlxone_2" value="<%=MT.f(ld.getAfterItem("hjlxone"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="hjlxone_3" value="<%=ld.getSequence("hjlxone")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="hjlxone_4" <%if(0!=ld.getAnchor("hjlxone"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="hjlxone_5" value="<%=ld.getQuantity("hjlxone")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">备注1:</td>
  <td>
  <select name="aremarkone">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("aremarkone"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="aremarkone_1" value="<%=MT.f(ld.getBeforeItem("aremarkone"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="aremarkone_2" value="<%=MT.f(ld.getAfterItem("aremarkone"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="aremarkone_3" value="<%=ld.getSequence("aremarkone")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="aremarkone_4" <%if(0!=ld.getAnchor("aremarkone"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="aremarkone_5" value="<%=ld.getQuantity("aremarkone")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
</table>

<h2>动物2</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="right">动物名称2:</td>
  <td>
  <select name="animalnametwo">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("animalnametwo"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="animalnametwo_1" value="<%=MT.f(ld.getBeforeItem("animalnametwo"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="animalnametwo_2" value="<%=MT.f(ld.getAfterItem("animalnametwo"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="animalnametwo_3" value="<%=ld.getSequence("animalnametwo")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="animalnametwo_4" <%if(0!=ld.getAnchor("animalnametwo"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="animalnametwo_5" value="<%=ld.getQuantity("animalnametwo")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">痕迹类型2:</td>
  <td>
  <select name="hjlxtwo">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("hjlxtwo"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="hjlxtwo_1" value="<%=MT.f(ld.getBeforeItem("hjlxtwo"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="hjlxtwo_2" value="<%=MT.f(ld.getAfterItem("hjlxtwo"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="hjlxtwo_3" value="<%=ld.getSequence("hjlxtwo")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="hjlxtwo_4" <%if(0!=ld.getAnchor("hjlxtwo"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="hjlxtwo_5" value="<%=ld.getQuantity("hjlxtwo")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">备注2:</td>
  <td>
  <select name="aremarktwo">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("aremarktwo"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="aremarktwo_1" value="<%=MT.f(ld.getBeforeItem("aremarktwo"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="aremarktwo_2" value="<%=MT.f(ld.getAfterItem("aremarktwo"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="aremarktwo_3" value="<%=ld.getSequence("aremarktwo")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="aremarktwo_4" <%if(0!=ld.getAnchor("aremarktwo"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="aremarktwo_5" value="<%=ld.getQuantity("aremarktwo")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
</table>

<h2>动物3</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="right">动物名称3:</td>
  <td>
  <select name="animalnamethree">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("animalnamethree"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="animalnamethree_1" value="<%=MT.f(ld.getBeforeItem("animalnamethree"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="animalnamethree_2" value="<%=MT.f(ld.getAfterItem("animalnamethree"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="animalnamethree_3" value="<%=ld.getSequence("animalnamethree")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="animalnamethree_4" <%if(0!=ld.getAnchor("animalnamethree"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="animalnamethree_5" value="<%=ld.getQuantity("animalnamethree")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">痕迹类型3:</td>
  <td>
  <select name="hjlxthree">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("hjlxthree"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="hjlxthree_1" value="<%=MT.f(ld.getBeforeItem("hjlxthree"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="hjlxthree_2" value="<%=MT.f(ld.getAfterItem("hjlxthree"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="hjlxthree_3" value="<%=ld.getSequence("hjlxthree")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="hjlxthree_4" <%if(0!=ld.getAnchor("hjlxthree"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="hjlxthree_5" value="<%=ld.getQuantity("hjlxthree")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">备注3:</td>
  <td>
  <select name="aremarkthree">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("aremarkthree"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="aremarkthree_1" value="<%=MT.f(ld.getBeforeItem("aremarkthree"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="aremarkthree_2" value="<%=MT.f(ld.getAfterItem("aremarkthree"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="aremarkthree_3" value="<%=ld.getSequence("aremarkthree")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="aremarkthree_4" <%if(0!=ld.getAnchor("aremarkthree"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="aremarkthree_5" value="<%=ld.getQuantity("aremarkthree")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
</table>

<h2>动物4</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="right">动物名称4:</td>
  <td>
  <select name="animalnamefour">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("animalnamefour"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="animalnamefour_1" value="<%=MT.f(ld.getBeforeItem("animalnamefour"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="animalnamefour_2" value="<%=MT.f(ld.getAfterItem("animalnamefour"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="animalnamefour_3" value="<%=ld.getSequence("animalnamefour")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="animalnamefour_4" <%if(0!=ld.getAnchor("animalnamefour"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="animalnamefour_5" value="<%=ld.getQuantity("animalnamefour")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">痕迹类型4:</td>
  <td>
  <select name="hjlxfour">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("hjlxfour"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="hjlxfour_1" value="<%=MT.f(ld.getBeforeItem("hjlxfour"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="hjlxfour_2" value="<%=MT.f(ld.getAfterItem("hjlxfour"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="hjlxfour_3" value="<%=ld.getSequence("hjlxfour")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="hjlxfour_4" <%if(0!=ld.getAnchor("hjlxfour"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="hjlxfour_5" value="<%=ld.getQuantity("hjlxfour")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">备注4:</td>
  <td>
  <select name="aremarkfour">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("aremarkfour"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="aremarkfour_1" value="<%=MT.f(ld.getBeforeItem("aremarkfour"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="aremarkfour_2" value="<%=MT.f(ld.getAfterItem("aremarkfour"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="aremarkfour_3" value="<%=ld.getSequence("aremarkfour")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="aremarkfour_4" <%if(0!=ld.getAnchor("aremarkfour"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="aremarkfour_5" value="<%=ld.getQuantity("aremarkfour")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
</table>

<h2>动物5</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="right">动物名称5:</td>
  <td>
  <select name="animalnamefive">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("animalnamefive"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="animalnamefive_1" value="<%=MT.f(ld.getBeforeItem("animalnamefive"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="animalnamefive_2" value="<%=MT.f(ld.getAfterItem("animalnamefive"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="animalnamefive_3" value="<%=ld.getSequence("animalnamefive")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="animalnamefive_4" <%if(0!=ld.getAnchor("animalnamefive"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="animalnamefive_5" value="<%=ld.getQuantity("animalnamefive")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">痕迹类型5:</td>
  <td>
  <select name="hjlxfive">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("hjlxfive"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="hjlxfive_1" value="<%=MT.f(ld.getBeforeItem("hjlxfive"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="hjlxfive_2" value="<%=MT.f(ld.getAfterItem("hjlxfive"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="hjlxfive_3" value="<%=ld.getSequence("hjlxfive")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="hjlxfive_4" <%if(0!=ld.getAnchor("hjlxfive"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="hjlxfive_5" value="<%=ld.getQuantity("hjlxfive")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">备注5:</td>
  <td>
  <select name="aremarkfive">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("aremarkfive"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="aremarkfive_1" value="<%=MT.f(ld.getBeforeItem("aremarkfive"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="aremarkfive_2" value="<%=MT.f(ld.getAfterItem("aremarkfive"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="aremarkfive_3" value="<%=ld.getSequence("aremarkfive")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="aremarkfive_4" <%if(0!=ld.getAnchor("aremarkfive"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="aremarkfive_5" value="<%=ld.getQuantity("aremarkfive")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">备注:</td>
  <td>
  <select name="remarkend">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("remarkend"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="remarkend_1" value="<%=MT.f(ld.getBeforeItem("remarkend"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="remarkend_2" value="<%=MT.f(ld.getAfterItem("remarkend"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="remarkend_3" value="<%=ld.getSequence("remarkend")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="remarkend_4" <%if(0!=ld.getAnchor("remarkend"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="remarkend_5" value="<%=ld.getQuantity("remarkend")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">自然保护区名称:</td>
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
<%--
<tr>
  <td align="right">自然保护区编号:</td>
  <td>
  <select name="bhqnum">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("bhqnum"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="bhqnum_1" value="<%=MT.f(ld.getBeforeItem("bhqnum"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="bhqnum_2" value="<%=MT.f(ld.getAfterItem("bhqnum"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="bhqnum_3" value="<%=ld.getSequence("bhqnum")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="bhqnum_4" <%if(0!=ld.getAnchor("bhqnum"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="bhqnum_5" value="<%=ld.getQuantity("bhqnum")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
--%>
<tr>
  <td align="right">最终编号:</td>
  <td>
  <select name="lastnum">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("lastnum"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="lastnum_1" value="<%=MT.f(ld.getBeforeItem("lastnum"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="lastnum_2" value="<%=MT.f(ld.getAfterItem("lastnum"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="lastnum_3" value="<%=ld.getSequence("lastnum")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="lastnum_4" <%if(0!=ld.getAnchor("lastnum"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="lastnum_5" value="<%=ld.getQuantity("lastnum")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
</table>


<input type="submit" class="edit_button" name="GoBack" value="<%=r.getString(h.language, "GoBack")%>">
<input type="submit" class="edit_button" value="<%=r.getString(h.language, "Submit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
