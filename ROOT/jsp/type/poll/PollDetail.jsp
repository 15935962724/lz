<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/resource/Poll");

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode  = Listing.find(iListing).getNode();
Node node = Node.find(iNode);

if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(iListing,3,teasession._nLanguage);



%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Poll")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type='hidden' name="Node" VALUE="<%=iNode%>">
    <input type="hidden" name="ListingType" value="3"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "投票主题")%>:</td>
    <td>
    <select name="getSubject">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("getSubject"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="getSubject_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getSubject"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="getSubject_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getSubject"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="getSubject_3" class="edit_input" type="text" value="<%=ld.getSequence("getSubject")%>" mask="int" maxlength="3" size="4"/>
   <%=r.getString(teasession._nLanguage, "Anchor")%>
          <input  id=CHECKBOX type="CHECKBOX" value="1" name="getSubject_4"  <%if(0!=ld.getAnchor("getSubject"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>


    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="getSubject_5" class="edit_input" type="text" value="<%=ld.getQuantity("getSubject")%>" mask="int" maxlength="3" size="4"/>
    </td>
</tr>

<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "简介图片")%>:</td>
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
    <%=r.getString(teasession._nLanguage, "Before")%><input name="picture_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("picture"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="picture_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("picture"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="picture_3" class="edit_input" type="text" value="<%=ld.getSequence("picture")%>" mask="int" maxlength="3" size="4"/>
   <%=r.getString(teasession._nLanguage, "Anchor")%>
          <input  id=CHECKBOX type="CHECKBOX" value="1" name="picture_4"  <%if(0!=ld.getAnchor("picture"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>


    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="picture_5" class="edit_input" type="text" value="<%=ld.getQuantity("picture")%>" mask="int" maxlength="3" size="4"/>
    </td>
</tr>


<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "显示月份图片")%>:</td>
    <td>
    <select name="filename">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("filename"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="filename_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("filename"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="filename_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("filename"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="filename_3" class="edit_input" type="text" value="<%=ld.getSequence("filename")%>" mask="int" maxlength="3" size="4"/>
   <%=r.getString(teasession._nLanguage, "Anchor")%>
          <input  id=CHECKBOX type="CHECKBOX" value="1" name="filename_4"  <%if(0!=ld.getAnchor("filename"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>


    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="filename_5" class="edit_input" type="text" value="<%=ld.getQuantity("filename")%>" mask="int" maxlength="3" size="4"/>
    </td>
</tr>
<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "相关图片")%>:</td>
    <td>
    <select name="repic">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("repic"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="repic_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("repic"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="repic_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("repic"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="repic_3" class="edit_input" type="text" value="<%=ld.getSequence("repic")%>" mask="int" maxlength="3" size="4"/>
   <%=r.getString(teasession._nLanguage, "Anchor")%>
          <input  id=CHECKBOX type="CHECKBOX" value="1" name="repic_4"  <%if(0!=ld.getAnchor("repic"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>


    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="repic_5" class="edit_input" type="text" value="<%=ld.getQuantity("repic")%>" mask="int" maxlength="3" size="4"/>
    </td>
</tr>

<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "截止日期")%>:</td>
    <td>
    <select name="stoptime">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("stoptime"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="stoptime_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("stoptime"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="stoptime_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("stoptime"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="stoptime_3" class="edit_input" type="text" value="<%=ld.getSequence("stoptime")%>" mask="int" maxlength="3" size="4"/>
   <%=r.getString(teasession._nLanguage, "Anchor")%>
          <input  id=CHECKBOX type="CHECKBOX" value="1" name="stoptime_4"  <%if(0!=ld.getAnchor("stoptime"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>


    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="stoptime_5" class="edit_input" type="text" value="<%=ld.getQuantity("stoptime")%>" mask="int" maxlength="3" size="4"/>
    </td>
</tr>

<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "简介")%>:</td>
    <td>
    <select name="subcontent">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("subcontent"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="subcontent_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("subcontent"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="subcontent_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("subcontent"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="subcontent_3" class="edit_input" type="text" value="<%=ld.getSequence("subcontent")%>" mask="int" maxlength="3" size="4"/>
   <%=r.getString(teasession._nLanguage, "Anchor")%>
          <input  id=CHECKBOX type="CHECKBOX" value="1" name="subcontent_4"  <%if(0!=ld.getAnchor("subcontent"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>


    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="subcontent_5" class="edit_input" type="text" value="<%=ld.getQuantity("subcontent")%>" mask="int" maxlength="3" size="4"/>
    </td>
</tr>



<tr>
  <td colspan="5"><hr size="1" /></td>
</tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "投票问题")%>:</td>
    <td>
    <select name="question">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("question"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="question_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("question"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="question_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("question"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="question_3" class="edit_input" type="text" value="<%=ld.getSequence("question")%>" mask="int" maxlength="3" size="4"/>
      <input  id=CHECKBOX type="CHECKBOX" value="1" name="question_4"  <%if(0!=ld.getAnchor("question"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="question_5" class="edit_input" type="text" value="<%=ld.getQuantity("question")%>" mask="int" maxlength="3" size="4"/>
    </td>

  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "日期(总显示)")%>:</td>
    <td>
      <select name="date">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("date"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="date_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("date"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="date_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("date"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="date_3" class="edit_input" type="text" value="<%=ld.getSequence("date")%>" mask="int" maxlength="3" size="4"/>
            <select name="date_4">
              <option value="0"><%=r.getString(teasession._nLanguage, "yyyy-MM-dd")%></option>
              <option value="1" <%=getSelect(ld.getAnchor("date")==1)%>><%=r.getString(teasession._nLanguage, "MM-dd-yyyy")%></option>
              <option value="2" <%=getSelect(ld.getAnchor(">><%=r.getString(teasession.")==2)%>><%=r.getString(teasession._nLanguage, "dd-MM-yyyy")%></option>
              <option value="3" <%=getSelect(ld.getAnchor(">><%=r.getString(teasession.")==3)%> ><%=r.getString(teasession._nLanguage, "yyyy.MM.dd")%></option>
              <option value="4" <%=getSelect(ld.getAnchor("> ><%=r.getString(teasession.")==4)%>><%=r.getString(teasession._nLanguage, "MM.dd.yyyy")%></option>
              <option value="5" <%=getSelect(ld.getAnchor(">><%=r.getString(teasession.")==5)%>><%=r.getString(teasession._nLanguage, "dd.MM.yyyy")%></option>
            </select>

    </td>
  </tr>

   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "日期(月显示)")%>:</td>
    <td>
      <select name="dateMonth">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("dateMonth"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="dateMonth_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("dateMonth"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="dateMonth_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("dateMonth"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="dateMonth_3" class="edit_input" type="text" value="<%=ld.getSequence("dateMonth")%>" mask="int" maxlength="3" size="4"/>
            <select name="dateMonth_4">
              <option value="0"><%=r.getString(teasession._nLanguage, "yyyy-MM-dd")%></option>
              <option value="1" <%=getSelect(ld.getAnchor("dateMonth")==1)%>><%=r.getString(teasession._nLanguage, "MM-dd-yyyy")%></option>
              <option value="2" <%=getSelect(ld.getAnchor(">><%=r.getString(teasession.")==2)%>><%=r.getString(teasession._nLanguage, "dd-MM-yyyy")%></option>
              <option value="3" <%=getSelect(ld.getAnchor(">><%=r.getString(teasession.")==3)%> ><%=r.getString(teasession._nLanguage, "yyyy.MM.dd")%></option>
              <option value="4" <%=getSelect(ld.getAnchor("> ><%=r.getString(teasession.")==4)%>><%=r.getString(teasession._nLanguage, "MM.dd.yyyy")%></option>
              <option value="5" <%=getSelect(ld.getAnchor(">><%=r.getString(teasession.")==5)%>><%=r.getString(teasession._nLanguage, "dd.MM.yyyy")%></option>
            </select>

    </td>
  </tr>

   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "日期(周显示)")%>:</td>
    <td>
      <select name="dateWeek">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("dateWeek"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="dateWeek_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("dateWeek"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="dateWeek_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("dateWeek"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="dateWeek_3" class="edit_input" type="text" value="<%=ld.getSequence("dateWeek")%>" mask="int" maxlength="3" size="4"/>
            <select name="dateWeek_4">
              <option value="0"><%=r.getString(teasession._nLanguage, "yyyy-MM-dd")%></option>
              <option value="1" <%=getSelect(ld.getAnchor("dateWeek")==1)%>><%=r.getString(teasession._nLanguage, "MM-dd-yyyy")%></option>
              <option value="2" <%=getSelect(ld.getAnchor(">><%=r.getString(teasession.")==2)%>><%=r.getString(teasession._nLanguage, "dd-MM-yyyy")%></option>
              <option value="3" <%=getSelect(ld.getAnchor(">><%=r.getString(teasession.")==3)%> ><%=r.getString(teasession._nLanguage, "yyyy.MM.dd")%></option>
              <option value="4" <%=getSelect(ld.getAnchor("> ><%=r.getString(teasession.")==4)%>><%=r.getString(teasession._nLanguage, "MM.dd.yyyy")%></option>
              <option value="5" <%=getSelect(ld.getAnchor(">><%=r.getString(teasession.")==5)%>><%=r.getString(teasession._nLanguage, "dd.MM.yyyy")%></option>
            </select>

    </td>
  </tr>
<tr>
  <td colspan="5"><hr size="1" /></td>
</tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "选项编号")%>:</td>
    <td>
      <select name="choice">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("choice"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="choice_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("choice"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="choice_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("choice"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="choice_3" class="edit_input" type="text" value="<%=ld.getSequence("choice")%>" mask="int" maxlength="3" size="4"/>

    </td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "选项名称")%>:</td>
    <td>
      <select name="titles">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("titles"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="titles_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("titles"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="titles_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("titles"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="titles_3" class="edit_input" type="text" value="<%=ld.getSequence("titles")%>" mask="int" maxlength="3" size="4"/>

         <input  id=CHECKBOX type="CHECKBOX" value="1" name="titles_4"  <%if(0!=ld.getAnchor("titles"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
            <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="titles_5" class="edit_input" type="text" value="<%=ld.getQuantity("titles")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>


  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "作者")%>:</td>
    <td>
      <select name="firstname">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("firstname"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="firstname_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("firstname"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="firstname_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("firstname"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="firstname_3" class="edit_input" type="text" value="<%=ld.getSequence("firstname")%>" mask="int" maxlength="3" size="4"/>

    </td>
  </tr>


   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "选项导语")%>:</td>
    <td>
      <select name="memberinfo">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("memberinfo"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="memberinfo_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("memberinfo"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="memberinfo_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("memberinfo"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="memberinfo_3" class="edit_input" type="text" value="<%=ld.getSequence("memberinfo")%>" mask="int" maxlength="3" size="4"/>


                 <input  id=CHECKBOX type="CHECKBOX" value="1" name="memberinfo_4"  <%if(0!=ld.getAnchor("memberinfo"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

            <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="memberinfo_5" class="edit_input" type="text" value="<%=ld.getQuantity("memberinfo")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "联系方式")%>:</td>
    <td>
      <select name="linkman">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("linkman"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="linkman_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("linkman"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="linkman_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("linkman"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="linkman_3" class="edit_input" type="text" value="<%=ld.getSequence("linkman")%>" mask="int" maxlength="3" size="4"/>

    </td>
  </tr>


  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "大图")%>:</td>
    <td>
      <select name="bigPicture">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("bigPicture"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="bigPicture_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bigPicture"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="bigPicture_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bigPicture"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="bigPicture_3" class="edit_input" type="text" value="<%=ld.getSequence("bigPicture")%>" mask="int" maxlength="3" size="4"/>
              <%=r.getString(teasession._nLanguage, "Anchor")%>
            <select name="bigPicture_4">
              <option value="0">-----</option>
              <option value="1" <%=getSelect(ld.getAnchor("bigPicture")==1)%>><%=r.getString(teasession._nLanguage, "本节点")%></option>
              <option value="2" <%=getSelect(ld.getAnchor("bigPicture")==2)%>><%=r.getString(teasession._nLanguage, "其他节点")%></option>
            </select>

    </td>
  </tr>

 <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "小图")%>:</td>
    <td>
      <select name="smallPicture">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("smallPicture"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="smallPicture_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("smallPicture"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="smallPicture_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("smallPicture"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="smallPicture_3" class="edit_input" type="text" value="<%=ld.getSequence("smallPicture")%>" mask="int" maxlength="3" size="4"/>
              <%=r.getString(teasession._nLanguage, "Anchor")%>
            <select name="smallPicture_4">
              <option value="0">-----</option>
              <option value="1" <%=getSelect(ld.getAnchor("smallPicture")==1)%>><%=r.getString(teasession._nLanguage, "本节点")%></option>
              <option value="2" <%=getSelect(ld.getAnchor("smallPicture")==2)%>><%=r.getString(teasession._nLanguage, "其他节点")%></option>
            </select>

    </td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "选项简介")%>:</td>
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
      <%=r.getString(teasession._nLanguage, "Before")%><input name="content_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("content"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="content_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("content"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="content_3" class="edit_input" type="text" value="<%=ld.getSequence("content")%>" mask="int" maxlength="3" size="4"/>
      <input  id=CHECKBOX type="CHECKBOX" value="1" name="content_4"  <%if(0!=ld.getAnchor("content"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

            <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="content_5" class="edit_input" type="text" value="<%=ld.getQuantity("content")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "结果(总显示)")%>:</td>
    <td>
      <select name="result">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("result"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="result_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("result"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="result_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("result"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="result_3" class="edit_input" type="text" value="<%=ld.getSequence("result")%>" mask="int" maxlength="3" size="4"/>

    </td>
  </tr>


  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "结果(月显示)")%>:</td>
    <td>
      <select name="resultMonth">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("resultMonth"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="resultMonth_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("resultMonth"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="resultMonth_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("resultMonth"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="resultMonth_3" class="edit_input" type="text" value="<%=ld.getSequence("resultMonth")%>" mask="int" maxlength="3" size="4"/>

    </td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "结果(周显示)")%>:</td>
    <td>
      <select name="resultWeek">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("resultWeek"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="resultWeek_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("resultWeek"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="resultWeek_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("resultWeek"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="resultWeek_3" class="edit_input" type="text" value="<%=ld.getSequence("resultWeek")%>" mask="int" maxlength="3" size="4"/>

    </td>
  </tr>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "单个投票提交按钮")%>:</td>
    <td>
      <select name="singlepollButton">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("singlepollButton"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="singlepollButton_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("singlepollButton"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="singlepollButton_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("singlepollButton"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="singlepollButton_3" class="edit_input" type="text" value="<%=ld.getSequence("singlepollButton")%>" mask="int" maxlength="3" size="4"/>

    </td>
  </tr>

<tr>
  <td colspan="5"><hr size="1" /></td>
</tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "投票提交按钮")%>:</td>
    <td>
      <select name="pollButton">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("pollButton"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="pollButton_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pollButton"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="pollButton_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pollButton"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="pollButton_3" class="edit_input" type="text" value="<%=ld.getSequence("pollButton")%>" mask="int" maxlength="3" size="4"/>

    </td>
  </tr>
<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "查看结果")%>:</td>
    <td>
    <select name="resultview">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("resultview"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="resultview_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("resultview"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="resultview_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("resultview"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="resultview_3" class="edit_input" type="text" value="<%=ld.getSequence("resultview")%>" mask="int" maxlength="3" size="4"/>
    </td>
</tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "按投票排序")%>:</td>
    <td>
      <select name="sorting">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("sorting"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="sorting_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sorting"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="sorting_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sorting"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="sorting_3" class="edit_input" type="text" value="<%=ld.getSequence("sorting")%>" mask="int" maxlength="3" size="4"/>
            <%=r.getString(teasession._nLanguage, "排序字段")%>:
            <select name="sorting_4">
               <option value="1" <%if(ld.getAnchor("sorting")==1)out.print(" selected ");%>>选项顺序</option>
               <option value="2" <%if(ld.getAnchor("sorting")==2)out.print(" selected ");%>>投票结果</option>
               <option value="3" <%if(ld.getAnchor("sorting")==3)out.print(" selected ");%>>选项时间</option>
            </select>



    </td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "投票问题分页")%>:</td>
    <td>
      <select name="pollpage">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("pollpage"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="pollpage_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pollpage"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="pollpage_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pollpage"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "分页数量")%>:<input name="pollpage_3" class="edit_input" type="text" value="<%=ld.getSequence("pollpage")%>" mask="int" maxlength="3" size="4"/>

    </td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "投票选项分页")%>:</td>
    <td>
      <select name="PollChoiceSize">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("PollChoiceSize"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="PollChoiceSize_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("PollChoiceSize"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="PollChoiceSize_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("PollChoiceSize"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "分页数量")%>:<input name="PollChoiceSize_3" class="edit_input" type="text" value="<%=ld.getSequence("PollChoiceSize")%>" mask="int" maxlength="3" size="4"/>

    </td>
  </tr>
<tr>
  <td colspan="5"><hr size="1" /></td>
</tr>


<tr>
<td align="right">投票对问题名称的搜索代码：</td><td>（使用方法：在前台创建一个段落或列举即可）</td>
</tr>
<tr>
<td></td>
<td >
  <textarea cols="60" rows="5">

<script src="/tea/layer.js" type="text/javascript"></script>
<script>
function f_formsearch()
{
	 openNewDiv('newDiv');//打开层
	  formsearch.submit();
}
</script>

<form name="formsearch" method="GET" action/html/folder/136697-1.htm" onsubmit="return f_formsearch();" >
<input type=text name="question" value="" >
<input type=submit value="搜索">
</form>
<script>
var n = getParameter('question');
if(n!=null && n!='null')
{
   formsearch.question.value=n;
}

</script>


</textarea></td>
</tr>

<tr>
<td align="right">投票对选项名称的搜索代码：</td><td>（使用方法：在前台创建一个段落或列举即可）</td>
</tr>
<tr>
<td></td>
<td >
  <textarea cols="60" rows="5">

<script src="/tea/layer.js" type="text/javascript"></script>
<script>
function f_formsearch()
{
	 openNewDiv('newDiv');//打开层
	formsearch.submit();
}
</script>

<form name="formsearch" method="GET" action/html/folder/136697-1.htm" onsubmit="return f_formsearch();" >
<input type=text name="SearchName" value="" >
<input type=submit value="搜索">
</form>
<script>

var n = getParameter('SearchName');
if(n!=null && n!='null')
{
   formsearch.SearchName.value=n;
}

</script>


</textarea></td>
</tr>



<!--结果按扭:
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "ResultButton")%>:</TD>
        <td nowrap><input  id="CHECKBOX" type="CHECKBOX" name="resultButton" value="checkbox"  <%=getCheck(ld.getIstype("resultButton"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="resultButton_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("resultButton"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="resultButton_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("resultButton"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="resultButton_3" type="text" value="<%=ld.getSequence("resultButton")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="resultButton_4"   <%=getCheck(ld.getAnchor("resultButton"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>




      <tr>   <TD><%=r.getString(teasession._nLanguage, "SumBallot(All)")%>:</TD>
        <td nowrap><input  id="CHECKBOX" type="CHECKBOX" name="sumBallot" value="checkbox"  <%=getCheck(ld.getIstype("sumBallot"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="sumBallot_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sumBallot"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="sumBallot_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sumBallot"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="sumBallot_3" type="text" value="<%=ld.getSequence("sumBallot")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="sumBallot_4"   <%=getCheck(ld.getAnchor("sumBallot"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>      <tr>   <TD><%=r.getString(teasession._nLanguage, "SumBallot(Month)")%>:</TD>
        <td nowrap><input  id="CHECKBOX" type="CHECKBOX" name="sumBallotMonth" value="checkbox"  <%=getCheck(ld.getIstype("sumBallotMonth"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="sumBallotMonth_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sumBallotMonth"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="sumBallotMonth_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sumBallotMonth"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="sumBallotMonth_3" type="text" value="<%=ld.getSequence("sumBallotMonth")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="sumBallotMonth_4"   <%=getCheck(ld.getAnchor("sumBallotMonth"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>      <tr>   <TD><%=r.getString(teasession._nLanguage, "SumBallot(Week)")%>:</TD>
        <td nowrap><input  id="CHECKBOX" type="CHECKBOX" name="sumBallotWeek" value="checkbox"  <%=getCheck(ld.getIstype("sumBallotWeek"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="sumBallotWeek_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sumBallotWeek"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="sumBallotWeek_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sumBallotWeek"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="sumBallotWeek_3" type="text" value="<%=ld.getSequence("sumBallotWeek")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="sumBallotWeek_4"   <%=getCheck(ld.getAnchor("sumBallotWeek"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
      <tr>  <TD><%=r.getString(teasession._nLanguage, "Ballot")%>:</TD>
        <td nowrap><input  id="CHECKBOX" type="CHECKBOX" name="ballot" value="checkbox"  <%=getCheck(ld.getIstype("ballot"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="ballot_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ballot"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="ballot_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ballot"))%>" type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="ballot_3" type="text" value="<%=ld.getSequence("ballot")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="ballot_4"   <%=getCheck(ld.getAnchor("ballot"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
    -->


</table>
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>
    <div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

