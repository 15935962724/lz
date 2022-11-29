<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
int listingid= Integer.parseInt(teasession.getParameter("Listing"));
int realnode = Listing.find(listingid).getNode();
Node node = Node.find(realnode);
if(realnode>0&&!node.isCreator(teasession._rv)&&AccessMember.find(realnode,teasession._rv).getPurview()<2)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Report");

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(listingid, 39, teasession._nLanguage);

//String arr[]={"name","MediaName", "MediaLogo", "ClassName", "Picture", "Locus", "Logograph", "text", "getSubhead", "getAuthor", "IssueTime", "correlation39", "correlation44"};

String title=r.getString(teasession._nLanguage, "Report")+r.getString(teasession._nLanguage, "Detail");

%><html>
<head>
<title><%=title%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail" onsubmit="mt.storage(this,true);mt.show(null,0);mt.check(this);">
<input type="hidden" name="ListingType" value="39"/>
<input type="hidden" name="Listing" value="<%=listingid%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
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
    <td align="right"><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
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
    <%=r.getString(teasession._nLanguage, "Before")%><input name="name_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="name_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" class="edit_input" type="text" value="<%=ld.getSequence("name")%>" mask="int" maxlength="3" size="4"/>
    <input  id=CHECKBOX type="CHECKBOX" name="name_4"  <%if(0!=ld.getAnchor("name"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    <input  id=CHECKBOX type="CHECKBOX" name="name_7" value="5" <%if(ld.getOptions("name").indexOf("/5/")!=-1)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "图示")%>
    <input  id=CHECKBOX type="CHECKBOX" name="name_7" value="6" <%if(ld.getOptions("name").indexOf("/6/")!=-1)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "NEW图")%>

    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="name_5" class="edit_input" type="text" value="<%=ld.getQuantity("name")%>" mask="int" maxlength="3" size="4"/>
       <input  id=CHECKBOX type="CHECKBOX" name="name_7" value="7" <%if(ld.getOptions("name").indexOf("/7/")!=-1)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "英文数量")%>

    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Report.media")%>:</td>
    <td>
      <select name="MediaName">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("MediaName"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="MediaName_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("MediaName"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="MediaName_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("MediaName"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="MediaName_3" class="edit_input" type="text" value="<%=ld.getSequence("MediaName")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="MediaName_4"  <%if(0!=ld.getAnchor("MediaName"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Report.media_logo")%>:</td>
    <td>
      <select name="MediaLogo">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("MediaLogo"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="MediaLogo_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("MediaLogo"))%>" type="text"/>
      <%=r.getString(teasession._nLanguage, "After")%><input name="MediaLogo_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("MediaLogo"))%>" type="text"/>
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="MediaLogo_3" class="edit_input" type="text" value="<%=ld.getSequence("MediaLogo")%>" mask="int" maxlength="3" size="4"/>
      <input  id=CHECKBOX type="CHECKBOX" name="MediaLogo_4" <%if(0!=ld.getAnchor("MediaLogo"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Report.classes")%>:</td>
    <td>
            <select name="ClassName">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("ClassName"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="ClassName_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ClassName"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="ClassName_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ClassName"))%>" type="text"/>
            <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ClassName_3" class="edit_input" type="text" value="<%=ld.getSequence("ClassName")%>" mask="int" maxlength="3" size="4"/>
          <input  id=CHECKBOX type="CHECKBOX" name="ClassName_4"  <%if(0!=ld.getAnchor("ClassName"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "子类名称")%>:</td>
    <td>
            <select name="ClassName2">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("ClassName2"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="ClassName2_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ClassName2"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="ClassName2_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ClassName2"))%>" type="text"/>
            <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ClassName2_3" class="edit_input" type="text" value="<%=ld.getSequence("ClassName2")%>" mask="int" maxlength="3" size="4"/>
          <input  id=CHECKBOX type="CHECKBOX" name="ClassName2_4"  <%if(0!=ld.getAnchor("ClassName2"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
    <td>
            <select name="Picture">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("Picture"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Picture_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Picture"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="Picture_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Picture"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Picture_3" class="edit_input" type="text" value="<%=ld.getSequence("Picture")%>" mask="int" maxlength="3" size="4"/>
        <input  id=CHECKBOX type="CHECKBOX" name="Picture_4"  <%if(0!=ld.getAnchor("Picture"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td></tr>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Report.locus")%>:</td>
    <td>      <select name="Locus">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("Locus"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="Locus_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Locus"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="Locus_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Locus"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Locus_3" class="edit_input" type="text" value="<%=ld.getSequence("Locus")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="Locus_4"  <%if(0!=ld.getAnchor("Locus"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="Locus_5" class="edit_input" type="text" value="<%=ld.getQuantity("Locus")%>" mask="int" maxlength="3" size="4"/>
  </td></tr>

<!--副标题-->
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Report.subhead")%>:</td>
    <td>      <select name="getSubhead">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("getSubhead"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getSubhead_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSubhead"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="getSubhead_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSubhead"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getSubhead_3" class="edit_input" type="text" value="<%=ld.getSequence("getSubhead")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="getSubhead_4"  <%if(0!=ld.getAnchor("getSubhead"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getSubhead_5" class="edit_input" type="text" value="<%=ld.getQuantity("getSubhead")%>" mask="int" maxlength="3" size="4"/>
  </td></tr>

<!--作者-->
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Report.author")%>:</td>
    <td>      <select name="getAuthor">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("getAuthor"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getAuthor_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getAuthor"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="getAuthor_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getAuthor"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getAuthor_3" class="edit_input" type="text" value="<%=ld.getSequence("getAuthor")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="getAuthor_4"  <%if(0!=ld.getAnchor("getAuthor"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getAuthor_5" class="edit_input" type="text" value="<%=ld.getQuantity("getAuthor")%>" mask="int" maxlength="3" size="4"/>
  </td></tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Report.logograph")%>:</td>
    <td>      <select name="Logograph">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("Logograph"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="Logograph_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Logograph"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="Logograph_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("Logograph"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Logograph_3" class="edit_input" type="text" value="<%=ld.getSequence("Logograph")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="Logograph_4"  <%if(0!=ld.getAnchor("Logograph"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="Logograph_5" class="edit_input" type="text" value="<%=ld.getQuantity("Logograph")%>" mask="int" maxlength="3" size="4"/>

      <input  id=CHECKBOX type="CHECKBOX" name="Logograph_7" value="7" <%if(ld.getOptions("Logograph").indexOf("/7/")!=-1)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "英文数量")%>
  </td></tr>
<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Text")%>:</td>
    <td>      <select name="text">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("text"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="text_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="text_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" class="edit_input" type="text" value="<%=ld.getSequence("text")%>" mask="int" maxlength="3" size="4"/>
          <input  id=CHECKBOX type="CHECKBOX" name="text_4"  <%if(0!=ld.getAnchor("text"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="text_5" class="edit_input" type="text" value="<%=ld.getQuantity("text")%>" mask="int" maxlength="3" size="4"/>
      <input  id=CHECKBOX type="CHECKBOX" name="text_7" value="7" <%if(ld.getOptions("text").indexOf("/7/")!=-1)out.print(" checked='true'");%>>
      <%=r.getString(teasession._nLanguage, "内容英文分页")%>
  </td></tr>

  <tr><!-- 发生时间 -->
    <td align="right"><%=r.getString(teasession._nLanguage, "Report.issuetime")%>:</td>
    <td>      <select name="IssueTime">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("IssueTime"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="IssueTime_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("IssueTime"))%>" type="text"/>
       <%=r.getString(teasession._nLanguage, "After")%><input name="IssueTime_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("IssueTime"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="IssueTime_3" class="edit_input" type="text" value="<%=ld.getSequence("IssueTime")%>" mask="int" maxlength="3" size="4"/>
    <input  id=CHECKBOX type="CHECKBOX" name="IssueTime_4"  <%if(0!=ld.getAnchor("IssueTime"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
                <%=r.getString(teasession._nLanguage, "选项")%>
            <select name="IssueTime_5">
              <option value="0" <%if(ld.getQuantity("IssueTime")==0)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "所有")%></option>
              <option value="20" <%if(ld.getQuantity("IssueTime")==20)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "月日")%></option>
              <option value="21" <%if(ld.getQuantity("IssueTime")==21)out.print(" selected ");%>>年月日时分</option>
            </select>
            <input  id=CHECKBOX type="CHECKBOX" name="IssueTime_7" value="7" <%if(ld.getOptions("IssueTime").indexOf("/7/")!=-1)out.print(" checked='true'");%>>
       <%=r.getString(teasession._nLanguage, "英文格式 ")%>
  </td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Correlation")%>:</td>
    <td>
      <select name="correlation39">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("correlation39"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="correlation39_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("correlation39"))%>" type="text"/>
      <%=r.getString(teasession._nLanguage, "After")%><input name="correlation39_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("correlation39"))%>" type="text"/>
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="correlation39_3" class="edit_input" type="text" value="<%=ld.getSequence("correlation39")%>" mask="int" maxlength="3" size="4"/>
      <!--input  id=CHECKBOX type="CHECKBOX" name="correlation39_4" value="2"  <%if(0!=ld.getAnchor("correlation39"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Time")%>-->
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="correlation39_5" class="edit_input" type="text" value="<%=ld.getQuantity("correlation39")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Correlation")%><%=r.getString(teasession._nLanguage, "NewsPaper")%>:</td>
    <td>
      <select name="correlation44">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("correlation44"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="correlation44_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("correlation44"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="correlation44_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("correlation44"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="correlation44_3" class="edit_input" type="text" value="<%=ld.getSequence("correlation44")%>" mask="int" maxlength="3" size="4"/>
    <!--input  id=CHECKBOX type="CHECKBOX" name="correlation44_4" value="2" <%if(0!=ld.getAnchor("correlation44"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Time")%>-->
    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="correlation44_5" class="edit_input" type="text" value="<%=ld.getQuantity("correlation44")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>

 <tr>
    <td align="right">父亲节点主题:</td>
    <td>      <select name="getFathername">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("getFathername"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="getFathername_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getFathername"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="getFathername_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getFathername"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getFathername_3" class="edit_input" type="text" value="<%=ld.getSequence("getFathername")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="getFathername_4"  <%if(0!=ld.getAnchor("getFathername"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getFathername_5" class="edit_input" type="text" value="<%=ld.getQuantity("getFathername")%>" mask="int" maxlength="3" size="4"/>
  </td>
  </tr>

<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "引题")%>:</td>
    <td>      <select name="kicker">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("kicker"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="kicker_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("kicker"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="kicker_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("kicker"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="kicker_3" class="edit_input" type="text" value="<%=ld.getSequence("kicker")%>" mask="int" maxlength="3" size="4"/>
          <input  id=CHECKBOX type="CHECKBOX" name="kicker_4"  <%if(0!=ld.getAnchor("kicker"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="kicker_5" class="edit_input" type="text" value="<%=ld.getQuantity("kicker")%>" mask="int" maxlength="3" size="4"/>
  </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "新闻语录")%>:</td>
    <td>      <select name="newquota">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("newquota"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="newquota_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("newquota"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="newquota_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("newquota"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="newquota_3" class="edit_input" type="text" value="<%=ld.getSequence("newquota")%>" mask="int" maxlength="3" size="4"/>
          <input  id=CHECKBOX type="CHECKBOX" name="newquota_4"  <%if(0!=ld.getAnchor("newquota"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="newquota_5" class="edit_input" type="text" value="<%=ld.getQuantity("newquota")%>" mask="int" maxlength="3" size="4"/>
  </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "语录出处")%>:</td>
    <td>      <select name="quotasource">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("quotasource"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="quotasource_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("quotasource"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="quotasource_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("quotasource"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="quotasource_3" class="edit_input" type="text" value="<%=ld.getSequence("quotasource")%>" mask="int" maxlength="3" size="4"/>
          <input  id=CHECKBOX type="CHECKBOX" name="quotasource_4"  <%if(0!=ld.getAnchor("quotasource"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="quotasource_5" class="edit_input" type="text" value="<%=ld.getQuantity("quotasource")%>" mask="int" maxlength="3" size="4"/>
  </td>
  </tr>
  <!--新闻编辑-->
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "新闻编辑")%>:</td>
    <td>      <select name="editmember">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("editmember"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="editmember_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("editmember"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="editmember_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("editmember"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="editmember_3" class="edit_input" type="text" value="<%=ld.getSequence("editmember")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="editmember_4"  <%if(0!=ld.getAnchor("editmember"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="editmember_5" class="edit_input" type="text" value="<%=ld.getQuantity("editmember")%>" mask="int" maxlength="3" size="4"/>
  </td></tr>


    <!--新闻编辑-->
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "稿件类别")%>:</td>
    <td>      <select name="manuscripttype">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("manuscripttype"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="manuscripttype_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("manuscripttype"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="manuscripttype_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("manuscripttype"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="manuscripttype_3" class="edit_input" type="text" value="<%=ld.getSequence("manuscripttype")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="manuscripttype_4"  <%if(0!=ld.getAnchor("manuscripttype"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

  </td>
  </tr>
  <!-- 主题图片 -->
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "主题图片")%>:</td>
    <td>      <select name="subjectfilename">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("subjectfilename"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="subjectfilename_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subjectfilename"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="subjectfilename_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subjectfilename"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subjectfilename_3" class="edit_input" type="text" value="<%=ld.getSequence("subjectfilename")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="subjectfilename_4"  <%if(0!=ld.getAnchor("subjectfilename"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

  </td>
  </tr>
    <!-- 副标题图片 -->
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "副标题图片")%>:</td>
    <td>      <select name="subheadfilename">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("subheadfilename"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="subheadfilename_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subheadfilename"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="subheadfilename_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subheadfilename"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subheadfilename_3" class="edit_input" type="text" value="<%=ld.getSequence("subheadfilename")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="subheadfilename_4"  <%if(0!=ld.getAnchor("subheadfilename"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

  </td>
  </tr>

      <!-- 作者图片 -->
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "作者图片")%>:</td>
    <td>      <select name="authorfilename">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("authorfilename"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="authorfilename_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("authorfilename"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="authorfilename_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("authorfilename"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="authorfilename_3" class="edit_input" type="text" value="<%=ld.getSequence("authorfilename")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="authorfilename_4"  <%if(0!=ld.getAnchor("authorfilename"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

  </td>
  </tr>

  </tr>

      <!-- 评论数 -->
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "评论数")%>:</td>
    <td>      <select name="comments">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("comments"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="comments_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("comments"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="comments_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("comments"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="comments_3" class="edit_input" type="text" value="<%=ld.getSequence("comments")%>" mask="int" maxlength="3" size="4"/>


  </td>
  </tr>

  <!-- 本文署名 -->
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "本文署名")%>:</td>
    <td>      <select name="signature">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("signature"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="signature_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("signature"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="signature_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("signature"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="signature_3" class="edit_input" type="text" value="<%=ld.getSequence("signature")%>" mask="int" maxlength="3" size="4"/>
          <input  id=CHECKBOX type="CHECKBOX" name="signature_4"  <%if(0!=ld.getAnchor("signature"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
      <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="signature_5" class="edit_input" type="text" value="<%=ld.getQuantity("signature")%>" mask="int" maxlength="3" size="4"/>
    <br/><a href="javascript:mt.storage(form1,true)">保存数据</a> <a href="javascript:mt.storage(form1,false)">恢复数据</a>
  </td>
  </tr>
</table>



<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>


</DIV>

<script>
mt.check=function(f)
{
  var arr=f.elements;
  for(var i=0;i<arr.length;i++)
  {
    if(arr[i].type!='text')continue;
    mt.enc(arr[i]);
  }
};
</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
