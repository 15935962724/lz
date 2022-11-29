<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%><%@page import="tea.resource.*"%>
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


Resource r=new Resource("/tea/resource/Report");
boolean flag=request.getParameter("PickNode")==null;
ListingDetail ld=ListingDetail.find(listingid, 98, h.language);


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
<input type="hidden" name="ListingType" value="98"/>
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
  <td align="right">姓名:</td>
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
  <td align="right">简介:</td>
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
  <td align="right">性别:</td>
  <td>
  <select name="sex">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("sex"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="sex_1" value="<%=MT.f(ld.getBeforeItem("sex"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="sex_2" value="<%=MT.f(ld.getAfterItem("sex"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="sex_3" value="<%=ld.getSequence("sex")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="sex_4" <%if(0!=ld.getAnchor("sex"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="sex_5" value="<%=ld.getQuantity("sex")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">单位名称:</td>
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
  <td align="right">职务:</td>
  <td>
  <select name="job">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("job"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="job_1" value="<%=MT.f(ld.getBeforeItem("job"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="job_2" value="<%=MT.f(ld.getAfterItem("job"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="job_3" value="<%=ld.getSequence("job")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="job_4" <%if(0!=ld.getAnchor("job"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="job_5" value="<%=ld.getQuantity("job")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">手机:</td>
  <td>
  <select name="mobile">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("mobile"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="mobile_1" value="<%=MT.f(ld.getBeforeItem("mobile"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="mobile_2" value="<%=MT.f(ld.getAfterItem("mobile"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="mobile_3" value="<%=ld.getSequence("mobile")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="mobile_4" <%if(0!=ld.getAnchor("mobile"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="mobile_5" value="<%=ld.getQuantity("mobile")%>" mask="int" maxlength="3" size="4"/>
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
  <%=r.getString(h.language, "Before")%><input name="tel_1" value="<%=MT.f(ld.getBeforeItem("tel"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="tel_2" value="<%=MT.f(ld.getAfterItem("tel"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="tel_3" value="<%=ld.getSequence("tel")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="tel_4" <%if(0!=ld.getAnchor("tel"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="tel_5" value="<%=ld.getQuantity("tel")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">电子邮箱:</td>
  <td>
  <select name="email">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("email"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="email_1" value="<%=MT.f(ld.getBeforeItem("email"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="email_2" value="<%=MT.f(ld.getAfterItem("email"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="email_3" value="<%=ld.getSequence("email")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="email_4" <%if(0!=ld.getAnchor("email"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="email_5" value="<%=ld.getQuantity("email")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">头像:</td>
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
  <td align="right">国籍:</td>
  <td>
  <select name="nationality">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("nationality"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="nationality_1" value="<%=MT.f(ld.getBeforeItem("nationality"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="nationality_2" value="<%=MT.f(ld.getAfterItem("nationality"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="nationality_3" value="<%=ld.getSequence("nationality")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="nationality_4" <%if(0!=ld.getAnchor("nationality"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="nationality_5" value="<%=ld.getQuantity("nationality")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">出生年月:</td>
  <td>
  <select name="birth">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("birth"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="birth_1" value="<%=MT.f(ld.getBeforeItem("birth"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="birth_2" value="<%=MT.f(ld.getAfterItem("birth"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="birth_3" value="<%=ld.getSequence("birth")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="birth_4" <%if(0!=ld.getAnchor("birth"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="birth_5" value="<%=ld.getQuantity("birth")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">籍贯:</td>
  <td>
  <select name="place">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("place"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="place_1" value="<%=MT.f(ld.getBeforeItem("place"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="place_2" value="<%=MT.f(ld.getAfterItem("place"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="place_3" value="<%=ld.getSequence("place")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="place_4" <%if(0!=ld.getAnchor("place"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="place_5" value="<%=ld.getQuantity("place")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">学历:</td>
  <td>
  <select name="degree">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("degree"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="degree_1" value="<%=MT.f(ld.getBeforeItem("degree"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="degree_2" value="<%=MT.f(ld.getAfterItem("degree"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="degree_3" value="<%=ld.getSequence("degree")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="degree_4" <%if(0!=ld.getAnchor("degree"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="degree_5" value="<%=ld.getQuantity("degree")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

<tr>
  <td align="right">毕业院校:</td>
  <td>
  <select name="school">
  <%
  for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
  {
    out.print("<option value='"+st+"'");
    if(st==ld.getIstype("school"))out.print(" selected=''");
    out.print(">"+ListingDetail.SHOW_TYPE[st]);
  }
  %>
  </select>
  <%=r.getString(h.language, "Before")%><input name="school_1" value="<%=MT.f(ld.getBeforeItem("school"))%>" mask="max"/>
  <%=r.getString(h.language, "After")%><input name="school_2" value="<%=MT.f(ld.getAfterItem("school"))%>" mask="max"/>
  <%=r.getString(h.language, "Sequence")%>:<input name="school_3" value="<%=ld.getSequence("school")%>" mask="int" maxlength="3" size="4"/>
  <input id=CHECKBOX type="checkbox" name="school_4" <%if(0!=ld.getAnchor("school"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
  <%=r.getString(h.language, "Quantity")%>:<input name="school_5" value="<%=ld.getQuantity("school")%>" mask="int" maxlength="3" size="4"/>
  </td>
</tr>

</table>


<input type="submit" class="edit_button" name="GoBack" value="<%=r.getString(h.language, "GoBack")%>">
<input type="submit" class="edit_button" value="<%=r.getString(h.language, "Submit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
