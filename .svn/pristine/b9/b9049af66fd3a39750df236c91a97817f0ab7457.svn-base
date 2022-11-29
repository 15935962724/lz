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

ListingDetail ld=ListingDetail.find(listingid, 93, teasession._nLanguage);////////

//String arr[]={"name","MediaName", "MediaLogo", "ClassName", "Picture", "Locus", "Logograph", "text", "getSubhead", "getAuthor", "IssueTime", "correlation39", "correlation44"};

String title=r.getString(teasession._nLanguage, "商标")+r.getString(teasession._nLanguage, "Detail");

%><html>
<head>
<title><%=title%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type="hidden" name="ListingType" value="93"/>
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
    <td><%=r.getString(teasession._nLanguage, "商标类别")%>:</td>
    <td>
    <select name="logotype">
    <%
    for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
    {
      out.print("<option value='"+st+"'");
      if(st==ld.getIstype("logotype"))out.print(" selected=''");
      out.print(">"+ListingDetail.SHOW_TYPE[st]);
    }
    %>
    </select>
    <%=r.getString(teasession._nLanguage, "Before")%><input name="logotype_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("logotype"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "After")%><input name="logotype_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("logotype"))%>" type="text"/>
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="logotype_3" class="edit_input" type="text" value="<%=ld.getSequence("logotype")%>" mask="int" maxlength="3" size="4"/>
    <input  id=CHECKBOX type="CHECKBOX" name="logotype_4"  <%if(0!=ld.getAnchor("logotype"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

    </td>
  </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "商标名称")%>:</td>
    <td>
      <select name="logoname">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("logoname"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="logoname_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("logoname"))%>" type="text"/>
      <%=r.getString(teasession._nLanguage, "After")%><input name="logoname_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("logoname"))%>" type="text"/>
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="logoname_3" class="edit_input" type="text" value="<%=ld.getSequence("logoname")%>" mask="int" maxlength="3" size="4"/>
      <input  id=CHECKBOX type="CHECKBOX" name="logoname_4" <%if(0!=ld.getAnchor("logoname"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
       <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="logoname_5" class="edit_input" type="text" value="<%=ld.getQuantity("logoname")%>" mask="int" maxlength="3" size="4"/>
       </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "商标图形")%>:</td>
    <td>
            <select name="logoimage">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("logoimage"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="logoimage_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("logoimage"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="logoimage_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("logoimage"))%>" type="text"/>
            <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="logoimage_3" class="edit_input" type="text" value="<%=ld.getSequence("logoimage")%>" mask="int" maxlength="3" size="4"/>
          <input  id=CHECKBOX type="CHECKBOX" name="logoimage_4"  <%if(0!=ld.getAnchor("logoimage"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "核定使用商标")%>:</td>
    <td>
            <select name="logouse">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("logouse"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="logouse_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("logouse"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="logouse_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("logouse"))%>" type="text"/>
            <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="logouse_3" class="edit_input" type="text" value="<%=ld.getSequence("logouse")%>" mask="int" maxlength="3" size="4"/>
          <input  id=CHECKBOX type="CHECKBOX" name="logouse_4"  <%if(0!=ld.getAnchor("logouse"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "注册号")%>:</td>
    <td>
            <select name="regnum">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("regnum"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="regnum_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("regnum"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="regnum_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("regnum"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="regnum_3" class="edit_input" type="text" value="<%=ld.getSequence("regnum")%>" mask="int" maxlength="3" size="4"/>
        <input  id=CHECKBOX type="CHECKBOX" name="regnum_4"  <%if(0!=ld.getAnchor("regnum"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td></tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "详细介绍")%>:</td>
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
      <%=r.getString(teasession._nLanguage, "Before")%><input name="text_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="text_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="text_3" class="edit_input" type="text" value="<%=ld.getSequence("text")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="text_4"  <%if(0!=ld.getAnchor("text"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="text_5" class="edit_input" type="text" value="<%=ld.getQuantity("text")%>" mask="int" maxlength="3" size="4"/>
  </td></tr>

<!--注册时间-->
   <tr>
    <td><%=r.getString(teasession._nLanguage, "注册时间")%>:</td>
    <td>      <select name="regdate">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("regdate"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="regdate_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("regdate"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="regdate_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("regdate"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="regdate_3" class="edit_input" type="text" value="<%=ld.getSequence("regdate")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="regdate_4"  <%if(0!=ld.getAnchor("regdate"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

  </td></tr>
</table>



<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>


</DIV>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

</body>
</html>

