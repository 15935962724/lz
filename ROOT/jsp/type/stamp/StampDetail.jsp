<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@page import="tea.entity.*"%><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);


int listingid= h.getInt("Listing");
int realnode = Listing.find(listingid).getNode();
Node n = Node.find(realnode);


Resource r=new Resource("/tea/resource/Report");

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(listingid, 11, h.language);



%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1>邮票细节</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=n.getAncestor(h.language)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type="hidden" name="ListingType" value="11"/>
<input type="hidden" name="Listing" value="<%=listingid%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<%
if(!flag)
{
  out.print("<input type='hidden' name='PickNode' value="+request.getParameter("PickNode")+" />");
}else
{
  out.print("<input type='hidden' name='PickManual' value="+request.getParameter("PickManual")+" />");
}
if(request.getParameter("Edit")!=null)
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
    <td align="right">邮票照片:</td>
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
    <td align="right">推荐图片:</td>
    <td>
    <select name="recommend">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("recommend"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="recommend_1" value="<%=MT.f(ld.getBeforeItem("recommend"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="recommend_2" value="<%=MT.f(ld.getAfterItem("recommend"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="recommend_3" value="<%=ld.getSequence("recommend")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="recommend_4" <%if(0!=ld.getAnchor("recommend"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
    <%=r.getString(h.language, "Quantity")%>:<input name="recommend_5" value="<%=ld.getQuantity("recommend")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right">发行张数:</td>
    <td>
    <select name="inumber">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("inumber"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="inumber_1" value="<%=MT.f(ld.getBeforeItem("inumber"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="inumber_2" value="<%=MT.f(ld.getAfterItem("inumber"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="inumber_3" value="<%=ld.getSequence("inumber")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="inumber_4" <%if(0!=ld.getAnchor("inumber"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
    <%=r.getString(h.language, "Quantity")%>:<input name="inumber_5" value="<%=ld.getQuantity("inumber")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right">面额:</td>
    <td>
    <select name="denomination">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("denomination"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="denomination_1" value="<%=MT.f(ld.getBeforeItem("denomination"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="denomination_2" value="<%=MT.f(ld.getAfterItem("denomination"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="denomination_3" value="<%=ld.getSequence("denomination")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="denomination_4" <%if(0!=ld.getAnchor("denomination"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
    <%=r.getString(h.language, "Quantity")%>:<input name="denomination_5" value="<%=ld.getQuantity("denomination")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right">设计师:</td>
    <td>
    <select name="designer">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("designer"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="designer_1" value="<%=MT.f(ld.getBeforeItem("designer"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="designer_2" value="<%=MT.f(ld.getAfterItem("designer"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="designer_3" value="<%=ld.getSequence("designer")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="designer_4" <%if(0!=ld.getAnchor("designer"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
    <%=r.getString(h.language, "Quantity")%>:<input name="designer_5" value="<%=ld.getQuantity("designer")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right">尺寸:</td>
    <td>
    <select name="dimension">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("dimension"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="dimension_1" value="<%=MT.f(ld.getBeforeItem("dimension"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="dimension_2" value="<%=MT.f(ld.getAfterItem("dimension"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="dimension_3" value="<%=ld.getSequence("dimension")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="dimension_4" <%if(0!=ld.getAnchor("dimension"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
    <%=r.getString(h.language, "Quantity")%>:<input name="dimension_5" value="<%=ld.getQuantity("dimension")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right">齿孔:</td>
    <td>
    <select name="perforation">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("perforation"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="perforation_1" value="<%=MT.f(ld.getBeforeItem("perforation"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="perforation_2" value="<%=MT.f(ld.getAfterItem("perforation"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="perforation_3" value="<%=ld.getSequence("perforation")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="perforation_4" <%if(0!=ld.getAnchor("perforation"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
    <%=r.getString(h.language, "Quantity")%>:<input name="perforation_5" value="<%=ld.getQuantity("perforation")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right">邮票组成:</td>
    <td>
    <select name="part">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("part"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="part_1" value="<%=MT.f(ld.getBeforeItem("part"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="part_2" value="<%=MT.f(ld.getAfterItem("part"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="part_3" value="<%=ld.getSequence("part")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="part_4" <%if(0!=ld.getAnchor("part"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
    <%=r.getString(h.language, "Quantity")%>:<input name="part_5" value="<%=ld.getQuantity("part")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right">印刷商:</td>
    <td>
    <select name="printers">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("printers"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="printers_1" value="<%=MT.f(ld.getBeforeItem("printers"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="printers_2" value="<%=MT.f(ld.getAfterItem("printers"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="printers_3" value="<%=ld.getSequence("printers")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="printers_4" <%if(0!=ld.getAnchor("printers"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
    <%=r.getString(h.language, "Quantity")%>:<input name="printers_5" value="<%=ld.getQuantity("printers")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right">印刷工艺:</td>
    <td>
    <select name="printing">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("printing"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="printing_1" value="<%=MT.f(ld.getBeforeItem("printing"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="printing_2" value="<%=MT.f(ld.getAfterItem("printing"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="printing_3" value="<%=ld.getSequence("printing")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="printing_4" <%if(0!=ld.getAnchor("printing"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
    <%=r.getString(h.language, "Quantity")%>:<input name="printing_5" value="<%=ld.getQuantity("printing")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right">邮票简介:</td>
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
    <td align="right">发行日期:</td>
    <td>
    <select name="rtime">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("rtime"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="rtime_1" value="<%=MT.f(ld.getBeforeItem("rtime"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="rtime_2" value="<%=MT.f(ld.getAfterItem("rtime"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="rtime_3" value="<%=ld.getSequence("rtime")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="rtime_4" value="2" <%if(2==ld.getAnchor("rtime"))out.print(" checked='true'");%>>英文
    <%=r.getString(h.language, "Quantity")%>:<input name="rtime_5" value="<%=ld.getQuantity("rtime")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
</table>


<input type="submit" class="edit_button" name="GoBack" value="<%=r.getString(h.language, "GoBack")%>">
<input type="submit" class="edit_button" value="<%=r.getString(h.language, "Submit")%>">
</form>



<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>

</body>
</html>
