<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@page import="tea.entity.*"%><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);


int listingid= h.getInt("Listing");
int realnode = Listing.find(listingid).getNode();
Node n = Node.find(realnode);


Resource r=new Resource("/tea/resource/Report");

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(listingid,113,h.language);



%><!DOCTYPE html>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1>视频细节</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=n.getAncestor(h.language)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type="hidden" name="ListingType" value="113"/>
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
    <th>标题:</th>
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
    <th>视频:</th>
    <td>
    <select name="player">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("player"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="player_1" value="<%=MT.f(ld.getBeforeItem("player"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="player_2" value="<%=MT.f(ld.getAfterItem("player"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="player_3" value="<%=ld.getSequence("player")%>" mask="int" maxlength="3" size="4"/>
    <select name="player_4"><%=h.options(Player.PLAY_TYPE,ld.getAnchor("player"))%></select>
    宽度:<input name="player_5" value="<%=ld.getQuantity("player")%>" dv="640" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <th>图片:</th>
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
    <th>小图:</th>
    <td>
    <select name="picture3">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("picture3"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="picture3_1" value="<%=MT.f(ld.getBeforeItem("picture3"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="picture3_2" value="<%=MT.f(ld.getAfterItem("picture3"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="picture3_3" value="<%=ld.getSequence("picture3")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="picture3_4" <%if(0!=ld.getAnchor("picture3"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
    <%=r.getString(h.language, "Quantity")%>:<input name="picture3_5" value="<%=ld.getQuantity("picture3")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <th>时长:</th>
    <td>
    <select name="duration">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("duration"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="duration_1" value="<%=MT.f(ld.getBeforeItem("duration"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="duration_2" value="<%=MT.f(ld.getAfterItem("duration"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="duration_3" value="<%=ld.getSequence("duration")%>" mask="int" maxlength="3" size="4"/>
    <input id=CHECKBOX type="checkbox" name="duration_4" <%if(0!=ld.getAnchor("duration"))out.print(" checked='true'");%>><%=r.getString(h.language, "Anchor")%>
    <%=r.getString(h.language, "Quantity")%>:<input name="duration_5" value="<%=ld.getQuantity("duration")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <th>内容:</th>
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
    <th>发生日期:</th>
    <td>
    <select name="starttime">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("starttime"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(h.language, "Before")%><input name="starttime_1" value="<%=MT.f(ld.getBeforeItem("starttime"))%>" mask="max"/>
    <%=r.getString(h.language, "After")%><input name="starttime_2" value="<%=MT.f(ld.getAfterItem("starttime"))%>" mask="max"/>
    <%=r.getString(h.language, "Sequence")%>:<input name="starttime_3" value="<%=ld.getSequence("starttime")%>" mask="int" maxlength="3" size="4"/>
    <!--
    <input id=CHECKBOX type="checkbox" name="starttime_4" value="2" <%if(2==ld.getAnchor("starttime"))out.print(" checked='true'");%>>英文
    -->
    <%=r.getString(h.language, "Quantity")%>:<input name="starttime_5" value="<%=ld.getQuantity("starttime")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <th>列表:</th>
    <td>
      <select name="correlation113">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("correlation113"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(h.language, "Before")%><input name="correlation113_1" class="edit_input" mask="max" value="<%=MT.f(ld.getBeforeItem("correlation113"))%>" type="text"/>
      <%=r.getString(h.language, "After")%><input name="correlation113_2" class="edit_input" mask="max" value="<%=MT.f(ld.getAfterItem("correlation113"))%>" type="text"/>
      <%=r.getString(h.language, "Sequence")%>:<input name="correlation113_3" class="edit_input" type="text" value="<%=ld.getSequence("correlation113")%>" mask="int" maxlength="3" size="4"/>
      <!--input  id=CHECKBOX type="CHECKBOX" name="correlation113_4" value="2"  <%if(0!=ld.getAnchor("correlation113"))out.print(" checked='true'");%>><%=r.getString(h.language, "Time")%>-->
      <%=r.getString(h.language, "Quantity")%>:<input name="correlation113_5" class="edit_input" type="text" value="<%=ld.getQuantity("correlation113")%>" mask="int" maxlength="3" size="4"/>
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
