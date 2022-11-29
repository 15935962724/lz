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
ListingDetail ld=ListingDetail.find(listingid, 105, h.language);


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
<input type="hidden" name="ListingType" value="105"/>
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
  <td align="right">组图:</td>
  <td>
  <select name="pictures">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("pictures"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="pictures_1" value="<%=MT.f(ld.getBeforeItem("pictures"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="pictures_2" value="<%=MT.f(ld.getAfterItem("pictures"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="pictures_3" value="<%=ld.getSequence("pictures")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="pictures_4" <%if(0!=ld.getAnchor("pictures"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="pictures_5" value="<%=ld.getQuantity("pictures")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>


<tr>
  <td align="right">保存单位及其标本馆:</td>
  <td>
  <select name="unit">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("unit"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="unit_1" value="<%=MT.f(ld.getBeforeItem("unit"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="unit_2" value="<%=MT.f(ld.getAfterItem("unit"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="unit_3" value="<%=ld.getSequence("unit")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="unit_4" <%if(0!=ld.getAnchor("unit"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="unit_5" value="<%=ld.getQuantity("unit")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">标本馆代码:</td>
  <td>
  <select name="bbgdm">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("bbgdm"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="bbgdm_1" value="<%=MT.f(ld.getBeforeItem("bbgdm"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="bbgdm_2" value="<%=MT.f(ld.getAfterItem("bbgdm"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="bbgdm_3" value="<%=ld.getSequence("bbgdm")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="bbgdm_4" <%if(0!=ld.getAnchor("bbgdm"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="bbgdm_5" value="<%=ld.getQuantity("bbgdm")%>" mask="int" maxlength="3" size="4"/>
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
  <td align="right">纲:</td>
  <td>
  <select name="class1">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("class1"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="class1_1" value="<%=MT.f(ld.getBeforeItem("class1"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="class1_2" value="<%=MT.f(ld.getAfterItem("class1"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="class1_3" value="<%=ld.getSequence("class1")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="class1_4" <%if(0!=ld.getAnchor("class1"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="class1_5" value="<%=ld.getQuantity("class1")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">目:</td>
  <td>
  <select name="order0">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("order0"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="order0_1" value="<%=MT.f(ld.getBeforeItem("order0"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="order0_2" value="<%=MT.f(ld.getAfterItem("order0"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="order0_3" value="<%=ld.getSequence("order0")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="order0_4" <%if(0!=ld.getAnchor("order0"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="order0_5" value="<%=ld.getQuantity("order0")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">科:</td>
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
  <td align="right">属:</td>
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
  <td align="right">校对后种名(英):</td>
  <td>
  <select name="speciesup0">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("speciesup0"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="speciesup0_1" value="<%=MT.f(ld.getBeforeItem("speciesup0"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="speciesup0_2" value="<%=MT.f(ld.getAfterItem("speciesup0"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="speciesup0_3" value="<%=ld.getSequence("speciesup0")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="speciesup0_4" <%if(0!=ld.getAnchor("speciesup0"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="speciesup0_5" value="<%=ld.getQuantity("speciesup0")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">校对后种名(中):</td>
  <td>
  <select name="speciesup1">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("speciesup1"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="speciesup1_1" value="<%=MT.f(ld.getBeforeItem("speciesup1"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="speciesup1_2" value="<%=MT.f(ld.getAfterItem("speciesup1"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="speciesup1_3" value="<%=ld.getSequence("speciesup1")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="speciesup1_4" <%if(0!=ld.getAnchor("speciesup1"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="speciesup1_5" value="<%=ld.getQuantity("speciesup1")%>" mask="int" maxlength="3" size="4"/>
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
  <td align="right">标本号:</td>
  <td>
  <select name="snumber">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("snumber"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="snumber_1" value="<%=MT.f(ld.getBeforeItem("snumber"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="snumber_2" value="<%=MT.f(ld.getAfterItem("snumber"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="snumber_3" value="<%=ld.getSequence("snumber")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="snumber_4" <%if(0!=ld.getAnchor("snumber"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="snumber_5" value="<%=ld.getQuantity("snumber")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">采集人:</td>
  <td>
  <select name="cperson">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("cperson"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="cperson_1" value="<%=MT.f(ld.getBeforeItem("cperson"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="cperson_2" value="<%=MT.f(ld.getAfterItem("cperson"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="cperson_3" value="<%=ld.getSequence("cperson")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="cperson_4" <%if(0!=ld.getAnchor("cperson"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="cperson_5" value="<%=ld.getQuantity("cperson")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">采集时间:</td>
  <td>
  <select name="ctime">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("ctime"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="ctime_1" value="<%=MT.f(ld.getBeforeItem("ctime"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="ctime_2" value="<%=MT.f(ld.getAfterItem("ctime"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="ctime_3" value="<%=ld.getSequence("ctime")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="ctime_4" <%if(0!=ld.getAnchor("ctime"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="ctime_5" value="<%=ld.getQuantity("ctime")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">采集号:</td>
  <td>
  <select name="cnumber">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("cnumber"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="cnumber_1" value="<%=MT.f(ld.getBeforeItem("cnumber"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="cnumber_2" value="<%=MT.f(ld.getAfterItem("cnumber"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="cnumber_3" value="<%=ld.getSequence("cnumber")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="cnumber_4" <%if(0!=ld.getAnchor("cnumber"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="cnumber_5" value="<%=ld.getQuantity("cnumber")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">采集地（保护区小地名）:</td>
  <td>
  <select name="csite">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("csite"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="csite_1" value="<%=MT.f(ld.getBeforeItem("csite"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="csite_2" value="<%=MT.f(ld.getAfterItem("csite"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="csite_3" value="<%=ld.getSequence("csite")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="csite_4" <%if(0!=ld.getAnchor("csite"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="csite_5" value="<%=ld.getQuantity("csite")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">保护区名称:</td>
  <td>
  <select name="rname">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("rname"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="rname_1" value="<%=MT.f(ld.getBeforeItem("rname"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="rname_2" value="<%=MT.f(ld.getAfterItem("rname"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="rname_3" value="<%=ld.getSequence("rname")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="rname_4" <%if(0!=ld.getAnchor("rname"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="rname_5" value="<%=ld.getQuantity("rname")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">保护区代码:</td>
  <td>
  <select name="rcode">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("rcode"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="rcode_1" value="<%=MT.f(ld.getBeforeItem("rcode"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="rcode_2" value="<%=MT.f(ld.getAfterItem("rcode"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="rcode_3" value="<%=ld.getSequence("rcode")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="rcode_4" <%if(0!=ld.getAnchor("rcode"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="rcode_5" value="<%=ld.getQuantity("rcode")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">国家:</td>
  <td>
  <select name="country">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("country"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="country_1" value="<%=MT.f(ld.getBeforeItem("country"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="country_2" value="<%=MT.f(ld.getAfterItem("country"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="country_3" value="<%=ld.getSequence("country")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="country_4" <%if(0!=ld.getAnchor("country"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="country_5" value="<%=ld.getQuantity("country")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">省:</td>
  <td>
  <select name="province">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("province"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="province_1" value="<%=MT.f(ld.getBeforeItem("province"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="province_2" value="<%=MT.f(ld.getAfterItem("province"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="province_3" value="<%=ld.getSequence("province")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="province_4" <%if(0!=ld.getAnchor("province"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="province_5" value="<%=ld.getQuantity("province")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">经度:</td>
  <td>
  <select name="longitude">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("longitude"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="longitude_1" value="<%=MT.f(ld.getBeforeItem("longitude"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="longitude_2" value="<%=MT.f(ld.getAfterItem("longitude"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="longitude_3" value="<%=ld.getSequence("longitude")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="longitude_4" <%if(0!=ld.getAnchor("longitude"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="longitude_5" value="<%=ld.getQuantity("longitude")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">纬度:</td>
  <td>
  <select name="latitude">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("latitude"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="latitude_1" value="<%=MT.f(ld.getBeforeItem("latitude"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="latitude_2" value="<%=MT.f(ld.getAfterItem("latitude"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="latitude_3" value="<%=ld.getSequence("latitude")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="latitude_4" <%if(0!=ld.getAnchor("latitude"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="latitude_5" value="<%=ld.getQuantity("latitude")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">海拔:</td>
  <td>
  <select name="elevation">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("elevation"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="elevation_1" value="<%=MT.f(ld.getBeforeItem("elevation"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="elevation_2" value="<%=MT.f(ld.getAfterItem("elevation"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="elevation_3" value="<%=ld.getSequence("elevation")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="elevation_4" <%if(0!=ld.getAnchor("elevation"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="elevation_5" value="<%=ld.getQuantity("elevation")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">植被类型:</td>
  <td>
  <select name="vegetation">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("vegetation"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="vegetation_1" value="<%=MT.f(ld.getBeforeItem("vegetation"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="vegetation_2" value="<%=MT.f(ld.getAfterItem("vegetation"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="vegetation_3" value="<%=ld.getSequence("vegetation")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="vegetation_4" <%if(0!=ld.getAnchor("vegetation"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="vegetation_5" value="<%=ld.getQuantity("vegetation")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">生境:</td>
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
  <td align="right">寄主:</td>
  <td>
  <select name="host">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("host"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="host_1" value="<%=MT.f(ld.getBeforeItem("host"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="host_2" value="<%=MT.f(ld.getAfterItem("host"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="host_3" value="<%=ld.getSequence("host")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="host_4" <%if(0!=ld.getAnchor("host"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="host_5" value="<%=ld.getQuantity("host")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">性别:</td>
  <td>
  <select name="sexual">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("sexual"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="sexual_1" value="<%=MT.f(ld.getBeforeItem("sexual"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="sexual_2" value="<%=MT.f(ld.getAfterItem("sexual"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="sexual_3" value="<%=ld.getSequence("sexual")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="sexual_4" <%if(0!=ld.getAnchor("sexual"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="sexual_5" value="<%=ld.getQuantity("sexual")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">年龄:</td>
  <td>
  <select name="old">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("old"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="old_1" value="<%=MT.f(ld.getBeforeItem("old"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="old_2" value="<%=MT.f(ld.getAfterItem("old"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="old_3" value="<%=ld.getSequence("old")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="old_4" <%if(0!=ld.getAnchor("old"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="old_5" value="<%=ld.getQuantity("old")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">标本属性:</td>
  <td>
  <select name="property">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("property"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="property_1" value="<%=MT.f(ld.getBeforeItem("property"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="property_2" value="<%=MT.f(ld.getAfterItem("property"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="property_3" value="<%=ld.getSequence("property")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="property_4" <%if(0!=ld.getAnchor("property"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="property_5" value="<%=ld.getQuantity("property")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">标本状态:</td>
  <td>
  <select name="status">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("status"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="status_1" value="<%=MT.f(ld.getBeforeItem("status"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="status_2" value="<%=MT.f(ld.getAfterItem("status"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="status_3" value="<%=ld.getSequence("status")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="status_4" <%if(0!=ld.getAnchor("status"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="status_5" value="<%=ld.getQuantity("status")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">保藏方式:</td>
  <td>
  <select name="preserve">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("preserve"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="preserve_1" value="<%=MT.f(ld.getBeforeItem("preserve"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="preserve_2" value="<%=MT.f(ld.getAfterItem("preserve"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="preserve_3" value="<%=ld.getSequence("preserve")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="preserve_4" <%if(0!=ld.getAnchor("preserve"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="preserve_5" value="<%=ld.getQuantity("preserve")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">实物状态:</td>
  <td>
  <select name="conlive">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("conlive"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="conlive_1" value="<%=MT.f(ld.getBeforeItem("conlive"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="conlive_2" value="<%=MT.f(ld.getAfterItem("conlive"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="conlive_3" value="<%=ld.getSequence("conlive")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="conlive_4" <%if(0!=ld.getAnchor("conlive"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="conlive_5" value="<%=ld.getQuantity("conlive")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">共享方式:</td>
  <td>
  <select name="share">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("share"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="share_1" value="<%=MT.f(ld.getBeforeItem("share"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="share_2" value="<%=MT.f(ld.getAfterItem("share"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="share_3" value="<%=ld.getSequence("share")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="share_4" <%if(0!=ld.getAnchor("share"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="share_5" value="<%=ld.getQuantity("share")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">获取途径:</td>
  <td>
  <select name="getway">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("getway"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="getway_1" value="<%=MT.f(ld.getBeforeItem("getway"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="getway_2" value="<%=MT.f(ld.getAfterItem("getway"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="getway_3" value="<%=ld.getSequence("getway")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="getway_4" <%if(0!=ld.getAnchor("getway"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="getway_5" value="<%=ld.getQuantity("getway")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">描述:</td>
  <td>
  <select name="discribe">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("discribe"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="discribe_1" value="<%=MT.f(ld.getBeforeItem("discribe"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="discribe_2" value="<%=MT.f(ld.getAfterItem("discribe"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="discribe_3" value="<%=ld.getSequence("discribe")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="discribe_4" <%if(0!=ld.getAnchor("discribe"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="discribe_5" value="<%=ld.getQuantity("discribe")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">用户名称:</td>
  <td>
  <select name="uuser">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("uuser"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="uuser_1" value="<%=MT.f(ld.getBeforeItem("uuser"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="uuser_2" value="<%=MT.f(ld.getAfterItem("uuser"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="uuser_3" value="<%=ld.getSequence("uuser")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="uuser_4" <%if(0!=ld.getAnchor("uuser"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="uuser_5" value="<%=ld.getQuantity("uuser")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">用户ID:</td>
  <td>
  <select name="uid">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("uid"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="uid_1" value="<%=MT.f(ld.getBeforeItem("uid"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="uid_2" value="<%=MT.f(ld.getAfterItem("uid"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="uid_3" value="<%=ld.getSequence("uid")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="uid_4" <%if(0!=ld.getAnchor("uid"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="uid_5" value="<%=ld.getQuantity("uid")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">物种类型:</td>
  <td>
  <select name="speciestype">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("speciestype"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="speciestype_1" value="<%=MT.f(ld.getBeforeItem("speciestype"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="speciestype_2" value="<%=MT.f(ld.getAfterItem("speciestype"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="speciestype_3" value="<%=ld.getSequence("speciestype")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="speciestype_4" <%if(0!=ld.getAnchor("speciestype"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="speciestype_5" value="<%=ld.getQuantity("speciestype")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">标本入库时间:</td>
  <td>
  <select name="enterdbdate">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("enterdbdate"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="enterdbdate_1" value="<%=MT.f(ld.getBeforeItem("enterdbdate"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="enterdbdate_2" value="<%=MT.f(ld.getAfterItem("enterdbdate"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="enterdbdate_3" value="<%=ld.getSequence("enterdbdate")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="enterdbdate_4" <%if(0!=ld.getAnchor("enterdbdate"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="enterdbdate_5" value="<%=ld.getQuantity("enterdbdate")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">资源一级分类:</td>
  <td>
  <select name="firstlevel">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("firstlevel"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="firstlevel_1" value="<%=MT.f(ld.getBeforeItem("firstlevel"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="firstlevel_2" value="<%=MT.f(ld.getAfterItem("firstlevel"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="firstlevel_3" value="<%=ld.getSequence("firstlevel")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="firstlevel_4" <%if(0!=ld.getAnchor("firstlevel"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="firstlevel_5" value="<%=ld.getQuantity("firstlevel")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">资源二级分类:</td>
  <td>
  <select name="secondlevel">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("secondlevel"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="secondlevel_1" value="<%=MT.f(ld.getBeforeItem("secondlevel"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="secondlevel_2" value="<%=MT.f(ld.getAfterItem("secondlevel"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="secondlevel_3" value="<%=ld.getSequence("secondlevel")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="secondlevel_4" <%if(0!=ld.getAnchor("secondlevel"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="secondlevel_5" value="<%=ld.getQuantity("secondlevel")%>" mask="int" maxlength="3" size="4"/>
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
  <td align="right">签定信息:</td>
  <td>
  <select name="identify" onchange="mt.ntb(this)">
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
<tbody style="display:none;background-color:#EEE">
<tr>
  <td align="right">鉴定人:</td>
  <td>
  <select name="i_person">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("i_person"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="i_person_1" value="<%=MT.f(ld.getBeforeItem("i_person"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="i_person_2" value="<%=MT.f(ld.getAfterItem("i_person"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="i_person_3" value="<%=ld.getSequence("i_person")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="i_person_4" <%if(0!=ld.getAnchor("i_person"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="i_person_5" value="<%=ld.getQuantity("i_person")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
<tr>
  <td align="right">鉴定时间:</td>
  <td>
  <select name="i_year">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("i_year"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="i_year_1" value="<%=MT.f(ld.getBeforeItem("i_year"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="i_year_2" value="<%=MT.f(ld.getAfterItem("i_year"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="i_year_3" value="<%=ld.getSequence("i_year")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="i_year_4" <%if(0!=ld.getAnchor("i_year"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="i_year_5" value="<%=ld.getQuantity("i_year")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>
</tbody>
</table>

<input type="submit" class="edit_button" name="GoBack" value="<%=r.getString(h.language, "GoBack")%>">
<input type="submit" class="edit_button" value="<%=r.getString(h.language, "Submit")%>">
</form>

<script>
mt.ntb=function(a)
{
  var n=a;
  while(n.tagName!='TBODY')n=n.parentNode;
  (n.nextElementSibling||n.nextSibling).style.display=a.selectedIndex==0?'none':'';
};
form1.identify.onchange();
</script>
<a href="javascript:mt.detail()">填写</a>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
