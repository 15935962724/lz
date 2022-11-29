<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}


int listingid= h.getInt("Listing");
int realnode = Listing.find(listingid).getNode();
Node n = Node.find(realnode);


boolean flag=request.getParameter("PickNode")==null;
ListingDetail ld=ListingDetail.find(listingid, 100, h.language);


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>细节——校外机构</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=n.getAncestor(h.language)%></div>

<form name="form1" action="/servlet/EditListingDetail" method="post">
<input type="hidden" name="ListingType" value="100"/>
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
  之前<input name="subject_1" value="<%=MT.f(ld.getBeforeItem("subject"))%>" mask="max"/>
  之后<input name="subject_2" value="<%=MT.f(ld.getAfterItem("subject"))%>" mask="max"/>
  顺序:<input name="subject_3" value="<%=ld.getSequence("subject")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="subject_4" <%if(0!=ld.getAnchor("subject"))out.print(" checked='true'");%>>链接
  数量:<input name="subject_5" value="<%=ld.getQuantity("subject")%>" mask="int" maxlength="3" size="4"/>
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
  之前<input name="content_1" value="<%=MT.f(ld.getBeforeItem("content"))%>" mask="max"/>
  之后<input name="content_2" value="<%=MT.f(ld.getAfterItem("content"))%>" mask="max"/>
  顺序:<input name="content_3" value="<%=ld.getSequence("content")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="content_4" <%if(0!=ld.getAnchor("content"))out.print(" checked='true'");%>>链接
  数量:<input name="content_5" value="<%=ld.getQuantity("content")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">城市:</td>
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
  之前<input name="city_1" value="<%=MT.f(ld.getBeforeItem("city"))%>" mask="max"/>
  之后<input name="city_2" value="<%=MT.f(ld.getAfterItem("city"))%>" mask="max"/>
  顺序:<input name="city_3" value="<%=ld.getSequence("city")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="city_4" <%if(0!=ld.getAnchor("city"))out.print(" checked='true'");%>>链接
  数量:<input name="city_5" value="<%=ld.getQuantity("city")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">网址:</td>
  <td>
  <select name="website">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("website"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  之前<input name="website_1" value="<%=MT.f(ld.getBeforeItem("website"))%>" mask="max"/>
  之后<input name="website_2" value="<%=MT.f(ld.getAfterItem("website"))%>" mask="max"/>
  顺序:<input name="website_3" value="<%=ld.getSequence("website")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="website_4" <%if(0!=ld.getAnchor("website"))out.print(" checked='true'");%>>链接
  数量:<input name="website_5" value="<%=ld.getQuantity("website")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">电话:</td>
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
  之前<input name="tel_1" value="<%=MT.f(ld.getBeforeItem("tel"))%>" mask="max"/>
  之后<input name="tel_2" value="<%=MT.f(ld.getAfterItem("tel"))%>" mask="max"/>
  顺序:<input name="tel_3" value="<%=ld.getSequence("tel")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="tel_4" <%if(0!=ld.getAnchor("tel"))out.print(" checked='true'");%>>链接
  数量:<input name="tel_5" value="<%=ld.getQuantity("tel")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">qq:</td>
  <td>
  <select name="qq">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("qq"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  之前<input name="qq_1" value="<%=MT.f(ld.getBeforeItem("qq"))%>" mask="max"/>
  之后<input name="qq_2" value="<%=MT.f(ld.getAfterItem("qq"))%>" mask="max"/>
  顺序:<input name="qq_3" value="<%=ld.getSequence("qq")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="qq_4" <%if(0!=ld.getAnchor("qq"))out.print(" checked='true'");%>>链接
  数量:<input name="qq_5" value="<%=ld.getQuantity("qq")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">地址:</td>
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
  之前<input name="address_1" value="<%=MT.f(ld.getBeforeItem("address"))%>" mask="max"/>
  之后<input name="address_2" value="<%=MT.f(ld.getAfterItem("address"))%>" mask="max"/>
  顺序:<input name="address_3" value="<%=ld.getSequence("address")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="address_4" <%if(0!=ld.getAnchor("address"))out.print(" checked='true'");%>>链接
  数量:<input name="address_5" value="<%=ld.getQuantity("address")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">乘车路线:</td>
  <td>
  <select name="bus">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("bus"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  之前<input name="bus_1" value="<%=MT.f(ld.getBeforeItem("bus"))%>" mask="max"/>
  之后<input name="bus_2" value="<%=MT.f(ld.getAfterItem("bus"))%>" mask="max"/>
  顺序:<input name="bus_3" value="<%=ld.getSequence("bus")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="bus_4" <%if(0!=ld.getAnchor("bus"))out.print(" checked='true'");%>>链接
  数量:<input name="bus_5" value="<%=ld.getQuantity("bus")%>" mask="int" maxlength="3" size="4"/>
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
  之前<input name="map_1" value="<%=MT.f(ld.getBeforeItem("map"))%>" mask="max"/>
  之后<input name="map_2" value="<%=MT.f(ld.getAfterItem("map"))%>" mask="max"/>
  顺序:<input name="map_3" value="<%=ld.getSequence("map")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="map_4" <%if(0!=ld.getAnchor("map"))out.print(" checked='true'");%>>链接
  数量:<input name="map_5" value="<%=ld.getQuantity("map")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

</table>


<input type="submit" name="GoBack" value="返回">
<input type="submit" value="提交">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
