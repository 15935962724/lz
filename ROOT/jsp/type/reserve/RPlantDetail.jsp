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
ListingDetail ld=ListingDetail.find(listingid, 104, h.language);


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
<input type="hidden" name="ListingType" value="104"/>
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
  <td align="right">保护区:</td>
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
  <td align="right">拉丁名:</td>
  <td>
  <select name="species0">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("species0"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="species0_1" value="<%=MT.f(ld.getBeforeItem("species0"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="species0_2" value="<%=MT.f(ld.getAfterItem("species0"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="species0_3" value="<%=ld.getSequence("species0")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="species0_4" <%if(0!=ld.getAnchor("species0"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="species0_5" value="<%=ld.getQuantity("species0")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">中文名:</td>
  <td>
  <select name="species1">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("species1"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="species1_1" value="<%=MT.f(ld.getBeforeItem("species1"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="species1_2" value="<%=MT.f(ld.getAfterItem("species1"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="species1_3" value="<%=ld.getSequence("species1")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="species1_4" <%if(0!=ld.getAnchor("species1"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="species1_5" value="<%=ld.getQuantity("species1")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">科名(英):</td>
  <td>
  <select name="family0">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("family0"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="family0_1" value="<%=MT.f(ld.getBeforeItem("family0"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="family0_2" value="<%=MT.f(ld.getAfterItem("family0"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="family0_3" value="<%=ld.getSequence("family0")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="family0_4" <%if(0!=ld.getAnchor("family0"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="family0_5" value="<%=ld.getQuantity("family0")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">科名(中):</td>
  <td>
  <select name="family1">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("family1"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="family1_1" value="<%=MT.f(ld.getBeforeItem("family1"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="family1_2" value="<%=MT.f(ld.getAfterItem("family1"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="family1_3" value="<%=ld.getSequence("family1")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="family1_4" <%if(0!=ld.getAnchor("family1"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="family1_5" value="<%=ld.getQuantity("family1")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">属名:</td>
  <td>
  <select name="genus">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("genus"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="genus_1" value="<%=MT.f(ld.getBeforeItem("genus"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="genus_2" value="<%=MT.f(ld.getAfterItem("genus"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="genus_3" value="<%=ld.getSequence("genus")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="genus_4" <%if(0!=ld.getAnchor("genus"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="genus_5" value="<%=ld.getQuantity("genus")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">种名作者:</td>
  <td>
  <select name="speciesauthor">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("speciesauthor"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="speciesauthor_1" value="<%=MT.f(ld.getBeforeItem("speciesauthor"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="speciesauthor_2" value="<%=MT.f(ld.getAfterItem("speciesauthor"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="speciesauthor_3" value="<%=ld.getSequence("speciesauthor")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="speciesauthor_4" <%if(0!=ld.getAnchor("speciesauthor"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="speciesauthor_5" value="<%=ld.getQuantity("speciesauthor")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">种下名称:</td>
  <td>
  <select name="mutation">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("mutation"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="mutation_1" value="<%=MT.f(ld.getBeforeItem("mutation"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="mutation_2" value="<%=MT.f(ld.getAfterItem("mutation"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="mutation_3" value="<%=ld.getSequence("mutation")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="mutation_4" <%if(0!=ld.getAnchor("mutation"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="mutation_5" value="<%=ld.getQuantity("mutation")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">种下名称作者:</td>
  <td>
  <select name="mutationauthor">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("mutationauthor"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="mutationauthor_1" value="<%=MT.f(ld.getBeforeItem("mutationauthor"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="mutationauthor_2" value="<%=MT.f(ld.getAfterItem("mutationauthor"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="mutationauthor_3" value="<%=ld.getSequence("mutationauthor")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="mutationauthor_4" <%if(0!=ld.getAnchor("mutationauthor"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="mutationauthor_5" value="<%=ld.getQuantity("mutationauthor")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">分布:</td>
  <td>
  <select name="areas">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("areas"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="areas_1" value="<%=MT.f(ld.getBeforeItem("areas"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="areas_2" value="<%=MT.f(ld.getAfterItem("areas"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="areas_3" value="<%=ld.getSequence("areas")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="areas_4" <%if(0!=ld.getAnchor("areas"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="areas_5" value="<%=ld.getQuantity("areas")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

</table>


<input type="submit" class="edit_button" name="GoBack" value="<%=r.getString(h.language, "GoBack")%>">
<input type="submit" class="edit_button" value="<%=r.getString(h.language, "Submit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
