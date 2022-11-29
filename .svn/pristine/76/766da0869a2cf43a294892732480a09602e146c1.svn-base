<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%@page import="java.io.*" %>

<%

int iListing= Integer.parseInt(teasession.getParameter("Listing"));
int iNode = Listing.find(iListing).getNode();
Node node = Node.find(iNode);
if(!node.isCreator(teasession._rv)&&AccessMember.find(iNode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}

r.add("/tea/resource/Supply");

boolean flag=request.getParameter("PickNode")==null;


ListingDetail ld=ListingDetail.find(iListing, 32,teasession._nLanguage);



%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Supply.SupplyNewsDetailed")%><%=r.getString(teasession._nLanguage, "Detail")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type="hidden" name="ListingType" value="32"/>
    <%if(!flag){%>
    <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
<%        }else{%>
<input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
<%   }%>
    <input type="hidden" name="Listing" value="<%=iListing%>"/>
    <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<%        if(request.getParameter("Edit")!=null)
{%><input type="hidden" name="Edit" value="<%=request.getParameter("Edit")%>"/>
<%}  %>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td><!--主题-->
    <td><input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox" <%=getCheck(ld.getIstype("name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="name_1" class="edit_input"   value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="name_2" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="name_3" class="edit_input" type="text" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="name_4" value="1"  <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>

    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Supply.SupplyNewsType")%>:</td><!--供应信息类型-->
    <td><input  id="CHECKBOX" type="CHECKBOX" name="NewsType" value="checkbox" <%=getCheck(ld.getIstype("NewsType"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="NewsType_1" class="edit_input"   value="<%=HtmlElement.htmlToText(ld.getBeforeItem("NewsType"))%>" type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="NewsType_2" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getAfterItem("NewsType"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="NewsType_3" class="edit_input" type="text" value="<%=ld.getSequence("NewsType")%>" maxlength="3" size="4">

    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Supply.Industry")%>:</td><!--所属行业-->
    <td><input  id="CHECKBOX" type="CHECKBOX" name="IndustryType1" value="checkbox" <%=getCheck(ld.getIstype("IndustryType1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="IndustryType1_1" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getBeforeItem("IndustryType1"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "After")%><input name="IndustryType1_2" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getAfterItem("IndustryType1"))%>" type="text">
      <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="IndustryType1_3" class="edit_input" type="text" value="<%=ld.getSequence("IndustryType1")%>" maxlength="3" size="4">

    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Supply.Area")%>:</td><!--所属地区-->
    <td><input  id="CHECKBOX" type="CHECKBOX" name="City" value="checkbox"  <%=getCheck(ld.getIstype("City"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="City_1" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getBeforeItem("City"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="City_2" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getAfterItem("City"))%>" type="text">
            <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="City_3" class="edit_input" type="text" value="<%=ld.getSequence("City")%>" maxlength="3" size="4">

    </td>
  </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "Supply.PeriodOfValidity")%>:</td><!--有效期-->
    <td><input  id="CHECKBOX" type="CHECKBOX" name="Term" value="checkbox"  <%=getCheck(ld.getIstype("Term"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <%=r.getString(teasession._nLanguage, "Before")%><input name="Term_1" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Term"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "After")%><input name="Term_2" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getAfterItem("Term"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Term_3" class="edit_input" type="text" value="<%=ld.getSequence("Term")%>" maxlength="3" size="4">

    </td></tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "Supply.Picture")%>:</td><!--图片-->
    <td><input  id="CHECKBOX" type="CHECKBOX" name="PicPath" value="checkbox"  <%=getCheck(ld.getIstype("PicPath"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="PicPath_1"  class="edit_input"     value="<%=HtmlElement.htmlToText(ld.getBeforeItem("PicPath"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="PicPath_2" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getAfterItem("PicPath"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="PicPath_3" class="edit_input" type="text" value="<%=ld.getSequence("PicPath")%>" maxlength="3" size="4">
  <input  id=CHECKBOX type="CHECKBOX" name="PicPath_4" value="2" <%=getCheck(ld.getAnchor("PicPath"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>

  </td></tr>



  <tr>
    <td><%=r.getString(teasession._nLanguage, "Supply.InternetSite")%>:</td><!--连接网站-->
    <td><input  id="CHECKBOX" type="CHECKBOX" name="WebSite" value="checkbox"  <%=getCheck(ld.getIstype("WebSite"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="WebSite_1" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getBeforeItem("WebSite"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="WebSite_2" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getAfterItem("WebSite"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="WebSite_3" class="edit_input" type="text" value="<%=ld.getSequence("WebSite")%>" maxlength="3" size="4">


  </td></tr>
<tr>
    <td><%=r.getString(teasession._nLanguage, "Supply.Content")%>:</td><!--内容-->
    <td><input  id="CHECKBOX" type="CHECKBOX" name="Content" value="checkbox"  <%=getCheck(ld.getIstype("Content"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="Content_1" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Content"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Content_2" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getAfterItem("Content"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Content_3" class="edit_input" type="text" value="<%=ld.getSequence("Content")%>" maxlength="3" size="4">
        <%-- <input  id=CHECKBOX type="CHECKBOX" name="Content_4"  <%=getCheck(ld.getAnchor("Content"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> --%>
    <%--  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="Content_5" class="edit_input" type="text" value="<%=ld.getQuantity("Content")%>" maxlength="3" size="4">--%>
  </td></tr>
<tr>
    <td><%=r.getString(teasession._nLanguage, "Supply.Company")%>:</td><!--公司-->
    <td><input  id="CHECKBOX" type="CHECKBOX" name="Company" value="checkbox"  <%=getCheck(ld.getIstype("Company"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <%=r.getString(teasession._nLanguage, "Before")%><input name="Company_1" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getBeforeItem("Company"))%>" type="text">
          <%=r.getString(teasession._nLanguage, "After")%><input name="Company_2" class="edit_input"    value="<%=HtmlElement.htmlToText(ld.getAfterItem("Company"))%>" type="text">
        <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="Company_3" class="edit_input" type="text" value="<%=ld.getSequence("Company")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="Company_4" value="3"  <%=getCheck(ld.getAnchor("Company"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
    <%--  <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="Content_5" class="edit_input" type="text" value="<%=ld.getQuantity("Content")%>" maxlength="3" size="4">--%>
  </td></tr>
</table>



<INPUT TYPE=SUBMIT class="edit_button"  NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>



  <script>
  function fshow()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)!="4")
          {
              form1.elements[counter].checked=form1.elements["objshow"].checked;
          }
      }
  }function fafter()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="text"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)=="2")
          {
              form1.elements[counter].value=form1.elements["objafter2"].value;
          }
      }
  }

  function fbefore()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="text"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)=="1")
          {
              form1.elements[counter].value=form1.elements["objbefore1"].value;
          }
      }
  }

  function fanchor()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-1)=="4")
          {
              form1.elements[counter].checked=form1.elements["objanchor4"].checked;
          }
      }
  }
</script>
</DIV>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

