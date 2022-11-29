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

Resource r=new Resource("/tea/resource/Venues");

boolean flag=request.getParameter("PickNode")==null;

ListingDetail ld=ListingDetail.find(listingid, 92, teasession._nLanguage);

//String arr[]={"name","MediaName", "MediaLogo", "ClassName", "Picture", "Locus", "Logograph", "text", "getSubhead", "getAuthor", "IssueTime", "correlation39", "correlation44"};

String title=r.getString(teasession._nLanguage, "Venues")+r.getString(teasession._nLanguage, "Detail");

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
<input type="hidden" name="ListingType" value="92"/>
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
    <td align="right"><%=r.getString(teasession._nLanguage, "Venues.name")%>:</td>
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

    <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="name_5" class="edit_input" type="text" value="<%=ld.getQuantity("name")%>" mask="int" maxlength="3" size="4"/>
    </td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Venues.address")%>:</td>
    <td>
      <select name="address">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("address"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="address_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("address"))%>" type="text"/>
	<%=r.getString(teasession._nLanguage, "After")%><input name="address_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("address"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="address_3" class="edit_input" type="text" value="<%=ld.getSequence("address")%>" mask="int" maxlength="3" size="4"/>
	<input  id=CHECKBOX type="CHECKBOX" name="address_4"  <%if(0!=ld.getAnchor("address"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>

<tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Venues.text")%>:</td>
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
  </td></tr>



  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Venues.linkman")%>:</td>
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
          <input  id=CHECKBOX type="CHECKBOX" name="linkman_4"  <%if(0!=ld.getAnchor("linkman"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Venues.contactway")%>:</td>
    <td>
            <select name="contactway">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("contactway"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="contactway_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("contactway"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="contactway_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("contactway"))%>" type="text"/>
            <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="contactway_3" class="edit_input" type="text" value="<%=ld.getSequence("contactway")%>" mask="int" maxlength="3" size="4"/>
          <input  id=CHECKBOX type="CHECKBOX" name="contactway_4"  <%if(0!=ld.getAnchor("ClassName2"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>

  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Venues.aunit")%>:</td>
    <td>      <select name="aunit">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("aunit"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="aunit_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("aunit"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="aunit_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("aunit"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="aunit_3" class="edit_input" type="text" value="<%=ld.getSequence("aunit")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="aunit_4"  <%if(0!=ld.getAnchor("aunit"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

  </td></tr>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Venues.intropic")%>:</td>
    <td>
            <select name="intropic">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("intropic"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="intropic_1" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("intropic"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "After")%><input name="intropic_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("intropic"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="intropic_3" class="edit_input" type="text" value="<%=ld.getSequence("intropic")%>" mask="int" maxlength="3" size="4"/>
        <input  id=CHECKBOX type="CHECKBOX" name="intropic_4"  <%if(0!=ld.getAnchor("intropic"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
   </tr>


   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Venues.seating")%>:</td>
    <td>      <select name="seating">
      <%
      for(int st=0;st<ListingDetail.SHOW_TYPE.length;st++)
      {
        out.print("<option value='"+st+"'");
        if(st==ld.getIstype("seating"))out.print(" selected=''");
        out.print(">"+ListingDetail.SHOW_TYPE[st]);
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="seating_1"  class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("seating"))%>" type="text"/>
          <%=r.getString(teasession._nLanguage, "After")%><input name="seating_2" class="edit_input" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("seating"))%>" type="text"/>
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="seating_3" class="edit_input" type="text" value="<%=ld.getSequence("seating")%>" mask="int" maxlength="3" size="4"/>
  <input  id=CHECKBOX type="CHECKBOX" name="seating_4"  <%if(0!=ld.getAnchor("seating"))out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "Anchor")%>

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
