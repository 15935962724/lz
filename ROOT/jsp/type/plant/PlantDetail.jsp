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
<h1>细节——植物</h1>
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
  <td class="th">图片:</td>
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
  <td align="right">种名(中):</td>
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
  <td align="right">种名(英):</td>
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
  <td align="right">命名人:</td>
  <td>
  <select name="author">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("author"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="author_1" value="<%=MT.f(ld.getBeforeItem("author"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="author_2" value="<%=MT.f(ld.getAfterItem("author"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="author_3" value="<%=ld.getSequence("author")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="author_4" <%if(0!=ld.getAnchor("author"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="author_5" value="<%=ld.getQuantity("author")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">拉丁名:</td>
  <td>
  <select name="latin">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("latin"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="latin_1" value="<%=MT.f(ld.getBeforeItem("latin"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="latin_2" value="<%=MT.f(ld.getAfterItem("latin"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="latin_3" value="<%=ld.getSequence("latin")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="latin_4" <%if(0!=ld.getAnchor("latin"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="latin_5" value="<%=ld.getQuantity("latin")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">濒危:</td>
  <td>
  <select name="endangered">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("endangered"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="endangered_1" value="<%=MT.f(ld.getBeforeItem("endangered"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="endangered_2" value="<%=MT.f(ld.getAfterItem("endangered"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="endangered_3" value="<%=ld.getSequence("endangered")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="endangered_4" <%if(0!=ld.getAnchor("endangered"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="endangered_5" value="<%=ld.getQuantity("endangered")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">濒危因素:</td>
  <td>
  <select name="endanger">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("endanger"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="endanger_1" value="<%=MT.f(ld.getBeforeItem("endanger"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="endanger_2" value="<%=MT.f(ld.getAfterItem("endanger"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="endanger_3" value="<%=ld.getSequence("endanger")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="endanger_4" <%if(0!=ld.getAnchor("endanger"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="endanger_5" value="<%=ld.getQuantity("endanger")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">国内分布:</td>
  <td>
  <select name="ndistribution">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("ndistribution"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="ndistribution_1" value="<%=MT.f(ld.getBeforeItem("ndistribution"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="ndistribution_2" value="<%=MT.f(ld.getAfterItem("ndistribution"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="ndistribution_3" value="<%=ld.getSequence("ndistribution")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="ndistribution_4" <%if(0!=ld.getAnchor("ndistribution"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="ndistribution_5" value="<%=ld.getQuantity("ndistribution")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">国外分布:</td>
  <td>
  <select name="idistribution">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("idistribution"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="idistribution_1" value="<%=MT.f(ld.getBeforeItem("idistribution"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="idistribution_2" value="<%=MT.f(ld.getAfterItem("idistribution"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="idistribution_3" value="<%=ld.getSequence("idistribution")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="idistribution_4" <%if(0!=ld.getAnchor("idistribution"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="idistribution_5" value="<%=ld.getQuantity("idistribution")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">高度:</td>
  <td>
  <select name="altitude">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("altitude"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="altitude_1" value="<%=MT.f(ld.getBeforeItem("altitude"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="altitude_2" value="<%=MT.f(ld.getAfterItem("altitude"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="altitude_3" value="<%=ld.getSequence("altitude")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="altitude_4" <%if(0!=ld.getAnchor("altitude"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="altitude_5" value="<%=ld.getQuantity("altitude")%>" mask="int" maxlength="3" size="4"/>
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

<tr>
  <td align="right">标本列表:</td>
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
  <td align="right">地理分布:</td>
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
  <input id=CHECKBOX type="checkbox" name="map_4" <%if(0!=ld.getAnchor("map"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="map_5" value="<%=ld.getQuantity("map")%>" mask="int" maxlength="3" size="4"/>
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
