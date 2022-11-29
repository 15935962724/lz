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
ListingDetail ld=ListingDetail.find(listingid, 106, h.language);


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
<input type="hidden" name="ListingType" value="106"/>
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

<%--
<tr>
  <td align="right">本名:</td>
  <td>
  <select name="name">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("name"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="name_1" value="<%=MT.f(ld.getBeforeItem("name"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="name_2" value="<%=MT.f(ld.getAfterItem("name"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="name_3" value="<%=ld.getSequence("name")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="name_4" <%if(0!=ld.getAnchor("name"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="name_5" value="<%=ld.getQuantity("name")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
--%>

<tr>
  <td align="right">采收加工:</td>
  <td>
  <select name="harvesting">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("harvesting"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="harvesting_1" value="<%=MT.f(ld.getBeforeItem("harvesting"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="harvesting_2" value="<%=MT.f(ld.getAfterItem("harvesting"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="harvesting_3" value="<%=ld.getSequence("harvesting")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="harvesting_4" <%if(0!=ld.getAnchor("harvesting"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="harvesting_5" value="<%=ld.getQuantity("harvesting")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">参考文献:</td>
  <td>
  <select name="reference">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("reference"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="reference_1" value="<%=MT.f(ld.getBeforeItem("reference"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="reference_2" value="<%=MT.f(ld.getAfterItem("reference"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="reference_3" value="<%=ld.getSequence("reference")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="reference_4" <%if(0!=ld.getAnchor("reference"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="reference_5" value="<%=ld.getQuantity("reference")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">出处:</td>
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
  <td align="right">分类:</td>
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
  <td align="right">粉末特征:</td>
  <td>
  <select name="characteristic">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("characteristic"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="characteristic_1" value="<%=MT.f(ld.getBeforeItem("characteristic"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="characteristic_2" value="<%=MT.f(ld.getAfterItem("characteristic"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="characteristic_3" value="<%=ld.getSequence("characteristic")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="characteristic_4" <%if(0!=ld.getAnchor("characteristic"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="characteristic_5" value="<%=ld.getQuantity("characteristic")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">附方:</td>
  <td>
  <select name="prescript">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("prescript"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="prescript_1" value="<%=MT.f(ld.getBeforeItem("prescript"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="prescript_2" value="<%=MT.f(ld.getAfterItem("prescript"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="prescript_3" value="<%=ld.getSequence("prescript")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="prescript_4" <%if(0!=ld.getAnchor("prescript"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="prescript_5" value="<%=ld.getQuantity("prescript")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">附注:</td>
  <td>
  <select name="note">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("note"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="note_1" value="<%=MT.f(ld.getBeforeItem("note"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="note_2" value="<%=MT.f(ld.getAfterItem("note"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="note_3" value="<%=ld.getSequence("note")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="note_4" <%if(0!=ld.getAnchor("note"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="note_5" value="<%=ld.getQuantity("note")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">功能与主治:</td>
  <td>
  <select name="functions">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("functions"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="functions_1" value="<%=MT.f(ld.getBeforeItem("functions"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="functions_2" value="<%=MT.f(ld.getAfterItem("functions"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="functions_3" value="<%=ld.getSequence("functions")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="functions_4" <%if(0!=ld.getAnchor("functions"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="functions_5" value="<%=ld.getQuantity("functions")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">化学成分:</td>
  <td>
  <select name="composition">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("composition"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="composition_1" value="<%=MT.f(ld.getBeforeItem("composition"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="composition_2" value="<%=MT.f(ld.getAfterItem("composition"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="composition_3" value="<%=ld.getSequence("composition")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="composition_4" <%if(0!=ld.getAnchor("composition"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="composition_5" value="<%=ld.getQuantity("composition")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">集解:</td>
  <td>
  <select name="recipes">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("recipes"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="recipes_1" value="<%=MT.f(ld.getBeforeItem("recipes"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="recipes_2" value="<%=MT.f(ld.getAfterItem("recipes"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="recipes_3" value="<%=ld.getSequence("recipes")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="recipes_4" <%if(0!=ld.getAnchor("recipes"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="recipes_5" value="<%=ld.getQuantity("recipes")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">禁忌:</td>
  <td>
  <select name="taboo">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("taboo"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="taboo_1" value="<%=MT.f(ld.getBeforeItem("taboo"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="taboo_2" value="<%=MT.f(ld.getAfterItem("taboo"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="taboo_3" value="<%=ld.getSequence("taboo")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="taboo_4" <%if(0!=ld.getAnchor("taboo"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="taboo_5" value="<%=ld.getQuantity("taboo")%>" mask="int" maxlength="3" size="4"/>
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
  <td align="right">来源:</td>
  <td>
  <select name="quarry">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("quarry"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="quarry_1" value="<%=MT.f(ld.getBeforeItem("quarry"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="quarry_2" value="<%=MT.f(ld.getAfterItem("quarry"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="quarry_3" value="<%=ld.getSequence("quarry")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="quarry_4" <%if(0!=ld.getAnchor("quarry"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="quarry_5" value="<%=ld.getQuantity("quarry")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">理化鉴别:</td>
  <td>
  <select name="identify">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("identify"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="identify_1" value="<%=MT.f(ld.getBeforeItem("identify"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="identify_2" value="<%=MT.f(ld.getAfterItem("identify"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="identify_3" value="<%=ld.getSequence("identify")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="identify_4" <%if(0!=ld.getAnchor("identify"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="identify_5" value="<%=ld.getQuantity("identify")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">炮制:</td>
  <td>
  <select name="processing">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("processing"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="processing_1" value="<%=MT.f(ld.getBeforeItem("processing"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="processing_2" value="<%=MT.f(ld.getAfterItem("processing"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="processing_3" value="<%=ld.getSequence("processing")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="processing_4" <%if(0!=ld.getAnchor("processing"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="processing_5" value="<%=ld.getQuantity("processing")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">品质标志:</td>
  <td>
  <select name="quality">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("quality"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="quality_1" value="<%=MT.f(ld.getBeforeItem("quality"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="quality_2" value="<%=MT.f(ld.getAfterItem("quality"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="quality_3" value="<%=ld.getSequence("quality")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="quality_4" <%if(0!=ld.getAnchor("quality"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="quality_5" value="<%=ld.getQuantity("quality")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">品种考证:</td>
  <td>
  <select name="textual">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("textual"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="textual_1" value="<%=MT.f(ld.getBeforeItem("textual"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="textual_2" value="<%=MT.f(ld.getAfterItem("textual"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="textual_3" value="<%=ld.getSequence("textual")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="textual_4" <%if(0!=ld.getAnchor("textual"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="textual_5" value="<%=ld.getQuantity("textual")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">商品规格:</td>
  <td>
  <select name="specification">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("specification"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="specification_1" value="<%=MT.f(ld.getBeforeItem("specification"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="specification_2" value="<%=MT.f(ld.getAfterItem("specification"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="specification_3" value="<%=ld.getSequence("specification")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="specification_4" <%if(0!=ld.getAnchor("specification"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="specification_5" value="<%=ld.getQuantity("specification")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">使用注意:</td>
  <td>
  <select name="precaution">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("precaution"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="precaution_1" value="<%=MT.f(ld.getBeforeItem("precaution"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="precaution_2" value="<%=MT.f(ld.getAfterItem("precaution"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="precaution_3" value="<%=ld.getSequence("precaution")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="precaution_4" <%if(0!=ld.getAnchor("precaution"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="precaution_5" value="<%=ld.getQuantity("precaution")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">释名:</td>
  <td>
  <select name="shiming">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("shiming"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="shiming_1" value="<%=MT.f(ld.getBeforeItem("shiming"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="shiming_2" value="<%=MT.f(ld.getAfterItem("shiming"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="shiming_3" value="<%=ld.getSequence("shiming")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="shiming_4" <%if(0!=ld.getAnchor("shiming"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="shiming_5" value="<%=ld.getQuantity("shiming")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">显微鉴别:</td>
  <td>
  <select name="microscopic">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("microscopic"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="microscopic_1" value="<%=MT.f(ld.getBeforeItem("microscopic"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="microscopic_2" value="<%=MT.f(ld.getAfterItem("microscopic"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="microscopic_3" value="<%=ld.getSequence("microscopic")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="microscopic_4" <%if(0!=ld.getAnchor("microscopic"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="microscopic_5" value="<%=ld.getQuantity("microscopic")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">现代临床研究:</td>
  <td>
  <select name="clinical">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("clinical"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="clinical_1" value="<%=MT.f(ld.getBeforeItem("clinical"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="clinical_2" value="<%=MT.f(ld.getAfterItem("clinical"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="clinical_3" value="<%=ld.getSequence("clinical")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="clinical_4" <%if(0!=ld.getAnchor("clinical"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="clinical_5" value="<%=ld.getQuantity("clinical")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">性味:</td>
  <td>
  <select name="flavour">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("flavour"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="flavour_1" value="<%=MT.f(ld.getBeforeItem("flavour"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="flavour_2" value="<%=MT.f(ld.getAfterItem("flavour"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="flavour_3" value="<%=ld.getSequence("flavour")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="flavour_4" <%if(0!=ld.getAnchor("flavour"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="flavour_5" value="<%=ld.getQuantity("flavour")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">药材及产销:</td>
  <td>
  <select name="medicinal">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("medicinal"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="medicinal_1" value="<%=MT.f(ld.getBeforeItem("medicinal"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="medicinal_2" value="<%=MT.f(ld.getAfterItem("medicinal"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="medicinal_3" value="<%=ld.getSequence("medicinal")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="medicinal_4" <%if(0!=ld.getAnchor("medicinal"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="medicinal_5" value="<%=ld.getQuantity("medicinal")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">药材鉴别:</td>
  <td>
  <select name="identification">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("identification"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="identification_1" value="<%=MT.f(ld.getBeforeItem("identification"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="identification_2" value="<%=MT.f(ld.getAfterItem("identification"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="identification_3" value="<%=ld.getSequence("identification")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="identification_4" <%if(0!=ld.getAnchor("identification"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="identification_5" value="<%=ld.getQuantity("identification")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">药理:</td>
  <td>
  <select name="pharmacology">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("pharmacology"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="pharmacology_1" value="<%=MT.f(ld.getBeforeItem("pharmacology"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="pharmacology_2" value="<%=MT.f(ld.getAfterItem("pharmacology"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="pharmacology_3" value="<%=ld.getSequence("pharmacology")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="pharmacology_4" <%if(0!=ld.getAnchor("pharmacology"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="pharmacology_5" value="<%=ld.getQuantity("pharmacology")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">药论:</td>
  <td>
  <select name="theory">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("theory"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="theory_1" value="<%=MT.f(ld.getBeforeItem("theory"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="theory_2" value="<%=MT.f(ld.getAfterItem("theory"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="theory_3" value="<%=ld.getSequence("theory")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="theory_4" <%if(0!=ld.getAnchor("theory"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="theory_5" value="<%=ld.getQuantity("theory")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">异名:</td>
  <td>
  <select name="synonym">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("synonym"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="synonym_1" value="<%=MT.f(ld.getBeforeItem("synonym"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="synonym_2" value="<%=MT.f(ld.getAfterItem("synonym"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="synonym_3" value="<%=ld.getSequence("synonym")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="synonym_4" <%if(0!=ld.getAnchor("synonym"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="synonym_5" value="<%=ld.getQuantity("synonym")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">饮片性状:</td>
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
  <td align="right">应用与配伍:</td>
  <td>
  <select name="compatibility">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("compatibility"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="compatibility_1" value="<%=MT.f(ld.getBeforeItem("compatibility"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="compatibility_2" value="<%=MT.f(ld.getAfterItem("compatibility"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="compatibility_3" value="<%=ld.getSequence("compatibility")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="compatibility_4" <%if(0!=ld.getAnchor("compatibility"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="compatibility_5" value="<%=ld.getQuantity("compatibility")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">用法用量:</td>
  <td>
  <select name="dosage">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("dosage"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="dosage_1" value="<%=MT.f(ld.getBeforeItem("dosage"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="dosage_2" value="<%=MT.f(ld.getAfterItem("dosage"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="dosage_3" value="<%=ld.getSequence("dosage")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="dosage_4" <%if(0!=ld.getAnchor("dosage"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="dosage_5" value="<%=ld.getQuantity("dosage")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">原生长形态:</td>
  <td>
  <select name="morphology">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("morphology"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="morphology_1" value="<%=MT.f(ld.getBeforeItem("morphology"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="morphology_2" value="<%=MT.f(ld.getAfterItem("morphology"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="morphology_3" value="<%=ld.getSequence("morphology")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="morphology_4" <%if(0!=ld.getAnchor("morphology"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="morphology_5" value="<%=ld.getQuantity("morphology")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">制法:</td>
  <td>
  <select name="method">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("method"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="method_1" value="<%=MT.f(ld.getBeforeItem("method"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="method_2" value="<%=MT.f(ld.getAfterItem("method"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="method_3" value="<%=ld.getSequence("method")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="method_4" <%if(0!=ld.getAnchor("method"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="method_5" value="<%=ld.getQuantity("method")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">制剂:</td>
  <td>
  <select name="preparation">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("preparation"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="preparation_1" value="<%=MT.f(ld.getBeforeItem("preparation"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="preparation_2" value="<%=MT.f(ld.getAfterItem("preparation"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="preparation_3" value="<%=ld.getSequence("preparation")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="preparation_4" <%if(0!=ld.getAnchor("preparation"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="preparation_5" value="<%=ld.getQuantity("preparation")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">中文科名:</td>
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
  <td align="right">中文种名:</td>
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
  <td align="right">药性:</td>
  <td>
  <select name="potency">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("potency"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="potency_1" value="<%=MT.f(ld.getBeforeItem("potency"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="potency_2" value="<%=MT.f(ld.getAfterItem("potency"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="potency_3" value="<%=ld.getSequence("potency")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="potency_4" <%if(0!=ld.getAnchor("potency"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="potency_5" value="<%=ld.getQuantity("potency")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

</table>


<input type="submit" class="edit_button" name="GoBack" value="<%=r.getString(h.language, "GoBack")%>">
<input type="submit" class="edit_button" value="<%=r.getString(h.language, "Submit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
