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
ListingDetail ld=ListingDetail.find(listingid, 103, h.language);


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
<input type="hidden" name="ListingType" value="103"/>
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
  <td class="th">主题:</td>
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
  <td class="th">内容:</td>
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
  <td class="th">种类:</td>
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
  <td class="th">物种代码:</td>
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
  <td class="th">拉丁名字:</td>
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
  <td class="th">中国动物CITES公约名录等级:</td>
  <td>
  <select name="cites">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("cites"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="cites_1" value="<%=MT.f(ld.getBeforeItem("cites"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="cites_2" value="<%=MT.f(ld.getAfterItem("cites"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="cites_3" value="<%=ld.getSequence("cites")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="cites_4" <%if(0!=ld.getAnchor("cites"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="cites_5" value="<%=ld.getQuantity("cites")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td class="th">世界自然保护联盟:</td>
  <td>
  <select name="iucn">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("iucn"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="iucn_1" value="<%=MT.f(ld.getBeforeItem("iucn"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="iucn_2" value="<%=MT.f(ld.getAfterItem("iucn"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="iucn_3" value="<%=ld.getSequence("iucn")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="iucn_4" <%if(0!=ld.getAnchor("iucn"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="iucn_5" value="<%=ld.getQuantity("iucn")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td class="th">保护级别:</td>
  <td>
  <select name="alevel">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("alevel"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="alevel_1" value="<%=MT.f(ld.getBeforeItem("alevel"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="alevel_2" value="<%=MT.f(ld.getAfterItem("alevel"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="alevel_3" value="<%=ld.getSequence("alevel")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="alevel_4" <%if(0!=ld.getAnchor("alevel"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="alevel_5" value="<%=ld.getQuantity("alevel")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td class="th">红色名录等级:</td>
  <td>
  <select name="rlevel">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("rlevel"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="rlevel_1" value="<%=MT.f(ld.getBeforeItem("rlevel"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="rlevel_2" value="<%=MT.f(ld.getAfterItem("rlevel"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="rlevel_3" value="<%=ld.getSequence("rlevel")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="rlevel_4" <%if(0!=ld.getAnchor("rlevel"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="rlevel_5" value="<%=ld.getQuantity("rlevel")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td class="th">分布省份:</td>
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
  <td class="th">保护区分布:</td>
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
  <td class="th">分布山脉:</td>
  <td>
  <select name="range">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("range"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="range_1" value="<%=MT.f(ld.getBeforeItem("range"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="range_2" value="<%=MT.f(ld.getAfterItem("range"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="range_3" value="<%=ld.getSequence("range")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="range_4" <%if(0!=ld.getAnchor("range"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="range_5" value="<%=ld.getQuantity("range")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td class="th">濒危因素:</td>
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
  <td class="th">生长环境:</td>
  <td>
  <select name="environment">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("environment"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="environment_1" value="<%=MT.f(ld.getBeforeItem("environment"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="environment_2" value="<%=MT.f(ld.getAfterItem("environment"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="environment_3" value="<%=ld.getSequence("environment")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="environment_4" <%if(0!=ld.getAnchor("environment"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="environment_5" value="<%=ld.getQuantity("environment")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td class="th">特征:</td>
  <td>
  <select name="feature">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("feature"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="feature_1" value="<%=MT.f(ld.getBeforeItem("feature"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="feature_2" value="<%=MT.f(ld.getAfterItem("feature"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="feature_3" value="<%=ld.getSequence("feature")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="feature_4" <%if(0!=ld.getAnchor("feature"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="feature_5" value="<%=ld.getQuantity("feature")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td class="th">属名:</td>
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
  <td class="th">科名:</td>
  <td>
  <select name="family">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("family"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="family_1" value="<%=MT.f(ld.getBeforeItem("family"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="family_2" value="<%=MT.f(ld.getAfterItem("family"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="family_3" value="<%=ld.getSequence("family")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="family_4" <%if(0!=ld.getAnchor("family"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="family_5" value="<%=ld.getQuantity("family")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td class="th">目名:</td>
  <td>
  <select name="order1">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("order1"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="order1_1" value="<%=MT.f(ld.getBeforeItem("order1"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="order1_2" value="<%=MT.f(ld.getAfterItem("order1"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="order1_3" value="<%=ld.getSequence("order1")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="order1_4" <%if(0!=ld.getAnchor("order1"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="order1_5" value="<%=ld.getQuantity("order1")%>" mask="int" maxlength="3" size="4"/>
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
  <td align="right">红外相机列表:</td>
  <td>
  <select name="infrared">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("infrared"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="infrared_1" value="<%=MT.f(ld.getBeforeItem("infrared"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="infrared_2" value="<%=MT.f(ld.getAfterItem("infrared"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="infrared_3" value="<%=ld.getSequence("infrared")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="infrared_4" <%if(0!=ld.getAnchor("infrared"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="infrared_5" value="<%=ld.getQuantity("infrared")%>" mask="int" maxlength="3" size="4"/>
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
<tr>
    <td align="right">动物关联组图:</td>
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

<a href="javascript:mt.detail()">填写</a>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
