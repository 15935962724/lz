<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.html.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%!

String getCheck(int value)
{
  return value!=0?" CHECKED ":" ";
}
String getCheck(boolean value)
{
  return value?" CHECKED ":" ";
}
%><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int listingid= Integer.parseInt(teasession.getParameter("Listing"));
int realnode = Listing.find(listingid).getNode();
Node node = Node.find(realnode);
if(realnode>0&&!node.isCreator(teasession._rv)&&AccessMember.find(realnode,teasession._rv._strV).getPurview()<2)
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/resource/Goods").add("/tea/ui/node/type/buy/EditBuyPrice").add("/tea/ui/node/type/buy/EditCommodity");

boolean flag=request.getParameter("PickNode")==null;


ListingDetail ld=ListingDetail.find(listingid,34,teasession._nLanguage);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBNewGoods")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"> <%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" method="post" action="/servlet/EditListingDetail">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="ListingType" value="34"/>
  <%if(!flag){%>
  <input type="hidden" name="PickNode" value="<%=request.getParameter("PickNode")%>"/>
  <%        }else{%>
  <input type='hidden' name="PickManual" VALUE="<%=request.getParameter("PickManual")%>">
  <%   }%>
  <input type="hidden" name="Listing" value="<%=listingid%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td ><%=r.getString(teasession._nLanguage, "Code")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="code" value="checkbox"  <%=getCheck(ld.getIstype("code"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <td><%=r.getString(teasession._nLanguage, "Before")%><input name="code_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("code"))%>"  class="edit_input"  type="text">
      <td><%=r.getString(teasession._nLanguage, "After")%><input name="code_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("code"))%>"  class="edit_input"  type="text">
      <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="code_3"  class="edit_input"  type="text" value="<%=ld.getSequence("code")%>" maxlength="3" size="4">
      <input  id=CHECKBOX type="CHECKBOX" name="code_4"   <%=getCheck(ld.getAnchor("code"))%>><%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Brand")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="brand" value="checkbox"  <%=getCheck(ld.getIstype("brand"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="brand_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("brand"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="brand_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("brand"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="brand_3"  class="edit_input"  type="text" value="<%=ld.getSequence("brand")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="brand_4"   <%=getCheck(ld.getAnchor("brand"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Name")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="name" value="checkbox"  <%=getCheck(ld.getIstype("name"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="name_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("name"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="name_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("name"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="name_3"  class="edit_input"  type="text" value="<%=ld.getSequence("name")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="name_4"   <%=getCheck(ld.getAnchor("name"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>
        <%=r.getString(teasession._nLanguage, "Quantity")%>:<input name="name_5" class="edit_input" type="text" value="<%=ld.getQuantity("name")%>" maxlength="3" size="4">
        </td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Goods.measure")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="measure" value="checkbox"  <%=getCheck(ld.getIstype("measure"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="measure_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("measure"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="measure_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("measure"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="measure_3"  class="edit_input"  type="text" value="<%=ld.getSequence("measure")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="measure_4"   <%=getCheck(ld.getAnchor("measure"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Goods.spec")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="spec" value="checkbox"  <%=getCheck(ld.getIstype("spec"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="spec_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("spec"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="spec_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("spec"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="spec_3"  class="edit_input"  type="text" value="<%=ld.getSequence("spec")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="spec_4"   <%=getCheck(ld.getAnchor("spec"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <%--
  <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
    <td><%=r.getString(teasession._nLanguage, "PriceSay")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="pricesay" value="checkbox"  <%=getCheck(ld.getIstype("pricesay"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="pricesay_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pricesay"))%>"  class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="pricesay_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pricesay"))%>"  class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="pricesay_3"  class="edit_input"  type="text" value="<%=pricesayOrder%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="pricesay_4"   <%=getCheck(ld.getAnchor("pricesay"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
  </tr>
  <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
    <td><%=r.getString(teasession._nLanguage, "Price")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="price" value="checkbox"  <%=getCheck(ld.getIstype("price"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="price_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price"))%>"  class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="price_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price"))%>"  class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="price_3"  class="edit_input"  type="text" value="<%=priceOrder%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="price_4"   <%=getCheck(ld.getAnchor("price"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>

--%>


<%--
    <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "PriceSay")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="pricesay" value="checkbox"  <%=getCheck(ld.getIstype("pricesay"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="pricesay_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pricesay"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="pricesay_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pricesay"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="pricesay_3"  class="edit_input"  type="text" value="<%=pricesayOrder%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="pricesay_4"   <%=getCheck(ld.getAnchor("pricesay"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
--%>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "OurPrice")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="price" value="checkbox"  <%=getCheck(ld.getIstype("price"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="price_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="price_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="price_3"  class="edit_input"  type="text" value="<%=ld.getSequence("price")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="price_4"   <%=getCheck(ld.getAnchor("price"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
<%--
    <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "PriceSay")%>2:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="pricesay2" value="checkbox"  <%=getCheck(ld.getIstype("pricesay2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="pricesay2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pricesay2"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="pricesay2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pricesay2"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="pricesay2_3"  class="edit_input"  type="text" value="<%=pricesay2Order%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="pricesay2_4"   <%=getCheck(ld.getAnchor("pricesay2"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
--%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
  <td><%=r.getString(teasession._nLanguage, "Supply")%>:</td>
  <td><input  id="CHECKBOX" type="CHECKBOX" name="price2" value="checkbox"  <%=getCheck(ld.getIstype("price2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
    <td><%=r.getString(teasession._nLanguage, "Before")%><input name="price2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price2"))%>"  class="edit_input"  type="text">
      <td><%=r.getString(teasession._nLanguage, "After")%><input name="price2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price2"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="price2_3"  class="edit_input"  type="text" value="<%=ld.getSequence("price2")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="price2_4"   <%=getCheck(ld.getAnchor("price2"))%>>
          <%=r.getString(teasession._nLanguage, "Anchor")%></td>
</tr>
<%--
    <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "PriceSay")%>3:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="pricesay3" value="checkbox"  <%=getCheck(ld.getIstype("pricesay3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="pricesay3_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pricesay3"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="pricesay3_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pricesay3"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="pricesay3_3"  class="edit_input"  type="text" value="<%=pricesay3Order%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="pricesay3_4"   <%=getCheck(ld.getAnchor("pricesay3"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
--%>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "List")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="price3" value="checkbox"  <%=getCheck(ld.getIstype("price3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="price3_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price3"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="price3_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price3"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="price3_3"  class="edit_input"  type="text" value="<%=ld.getSequence("price3")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="price3_4"   <%=getCheck(ld.getAnchor("price3"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
<%--
    <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "PriceSay")%>4:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="pricesay4" value="checkbox"  <%=getCheck(ld.getIstype("pricesay4"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="pricesay4_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pricesay4"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="pricesay4_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pricesay4"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="pricesay4_3"  class="edit_input"  type="text" value="<%=pricesay4Order%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="pricesay4_4"   <%=getCheck(ld.getAnchor("pricesay4"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
--%>

<%--
    <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Price")%>4:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="price4" value="checkbox"  <%=getCheck(ld.getIstype("price4"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="price4_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price4"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="price4_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price4"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="price4_3"  class="edit_input"  type="text" value="<%=price4Order%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="price4_4"   <%=getCheck(ld.getAnchor("price4"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    --%>

    <%--
    <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "PriceSay")%>5:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="pricesay5" value="checkbox"  <%=getCheck(ld.getIstype("pricesay5"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="pricesay5_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("pricesay5"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="pricesay5_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("pricesay5"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="pricesay5_3"  class="edit_input"  type="text" value="<%=pricesay5Order%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="pricesay5_4"   <%=getCheck(ld.getAnchor("pricesay5"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>

    <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Price")%>5:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="price5" value="checkbox"  <%=getCheck(ld.getIstype("price5"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="price5_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("price5"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="price5_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("price5"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="price5_3"  class="edit_input"  type="text" value="<%=price5Order%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="price5_4"   <%=getCheck(ld.getAnchor("price5"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
     --%>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "SmallPicture")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="smallpicture" value="checkbox"  <%=getCheck(ld.getIstype("smallpicture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="smallpicture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("smallpicture"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="smallpicture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("smallpicture"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="smallpicture_3"  class="edit_input"  type="text" value="<%=ld.getSequence("smallpicture")%>" maxlength="3" size="4">
        <select name="smallpicture_4"  >
          <option value="0" selected="selected">-------
          <option value="1" <%if(ld.getAnchor("smallpicture")==1)out.print(" SELECTED ");%>><%=r.getString(teasession._nLanguage, "Node")%>
          <option value="2" <%if(ld.getAnchor("smallpicture")==2)out.print(" SELECTED ");%>><%=r.getString(teasession._nLanguage, "BigPicture")%></option>
          <option value="3" <%if(ld.getAnchor("smallpicture")==3)out.print(" SELECTED ");%>><%=r.getString(teasession._nLanguage, "RecommendPicture")%></option>
        </select>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "BigPicture")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="bigpicture" value="checkbox"  <%=getCheck(ld.getIstype("bigpicture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <td><%=r.getString(teasession._nLanguage, "Before")%><input name="bigpicture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("bigpicture"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="bigpicture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("bigpicture"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="bigpicture_3"  class="edit_input"  type="text" value="<%=ld.getSequence("bigpicture")%>" maxlength="3" size="4">
        <select name="bigpicture_4"  >
          <option value="0" selected="selected">-------
          <option value="1" <%if(ld.getAnchor("bigpicture")==1)out.print(" SELECTED ");%>><%=r.getString(teasession._nLanguage, "Node")%>
          <option value="2" <%if(ld.getAnchor("bigpicture")==2)out.print(" SELECTED ");%>><%=r.getString(teasession._nLanguage, "BigPicture")%></option>
          <option value="3" <%if(ld.getAnchor("bigpicture")==3)out.print(" SELECTED ");%>><%=r.getString(teasession._nLanguage, "RecommendPicture")%></option>
        </select>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <%--
  <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
    <td><%=r.getString(teasession._nLanguage, "FinancingMoney")%>: </td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="financingmoney" value="checkbox"  <%=getCheck(ld.getIstype("financingmoney"))%>><%=r.getString(teasession._nLanguage, "Show")%>
	<%=r.getString(teasession._nLanguage, "Before")%><input name="financingmoney_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("financingmoney"))%>"  class="edit_input"  type="text">
	<%=r.getString(teasession._nLanguage, "After")%><input name="financingmoney_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("financingmoney"))%>"  class="edit_input"  type="text">
    <%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="financingmoney_3"  class="edit_input"  type="text" value="<%=financingmoneyOrder%>" maxlength="3" size="4">
	<input  id=CHECKBOX type="CHECKBOX" name="financingmoney_4"   <%=getCheck(ld.getAnchor("financingmoney"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
  </tr>--%>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Goods.commendpicture")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="recommendpicture" value="checkbox"  <%=getCheck(ld.getIstype("recommendpicture"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <td><%=r.getString(teasession._nLanguage, "Before")%><input name="recommendpicture_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("recommendpicture"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="recommendpicture_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("recommendpicture"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="recommendpicture_3"  class="edit_input"  type="text" value="<%=ld.getSequence("recommendpicture")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="recommendpicture_4"   <%=getCheck(ld.getAnchor("recommendpicture"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <%--
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Status")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="status" value="checkbox"  <%=getCheck(ld.getIstype("status"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <td><%=r.getString(teasession._nLanguage, "Before")%><input name="status_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("status"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="status_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("status"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="status_3"  class="edit_input"  type="text" value="<%=ld.getSequence("status")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="status_4"   <%=getCheck(ld.getAnchor("status"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
     --%>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "产品状态")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="status2" value="checkbox"  <%=getCheck(ld.getIstype("status2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <td><%=r.getString(teasession._nLanguage, "Before")%><input name="status2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("status2"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="status2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("status2"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="status2_3"  class="edit_input"  type="text" value="<%=ld.getSequence("status2")%>" maxlength="3" size="4">
          <input  id=CHECKBOX type="CHECKBOX" name="status2_4"   <%=getCheck(ld.getAnchor("status2"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>



    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Goods.correspond")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="correspond" value="checkbox"  <%=getCheck(ld.getIstype("correspond"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="correspond_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("correspond"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="correspond_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("correspond"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="correspond_3"  class="edit_input"  type="text" value="<%=ld.getSequence("correspond")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="correspond_4"   <%=getCheck(ld.getAnchor("correspond"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Goods.correspond2")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="correspond2" value="checkbox"  <%=getCheck(ld.getIstype("correspond2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="correspond2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("correspond2"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="correspond2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("correspond2"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="correspond2_3"  class="edit_input"  type="text" value="<%=ld.getSequence("correspond2")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="correspond2_4"   <%=getCheck(ld.getAnchor("correspond2"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Goods.correspond")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="correspond3" value="checkbox"  <%=getCheck(ld.getIstype("correspond3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="correspond3_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("correspond3"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="correspond3_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("correspond3"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="correspond3_3"  class="edit_input"  type="text" value="<%=ld.getSequence("correspond3")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="correspond3_4"   <%=getCheck(ld.getAnchor("correspond3"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Goods.correspond4")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="correspond4" value="checkbox"  <%=getCheck(ld.getIstype("correspond4"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="correspond4_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("correspond4"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="correspond4_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("correspond4"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="correspond4_3"  class="edit_input"  type="text" value="<%=ld.getSequence("correspond4")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="correspond4_4"   <%=getCheck(ld.getAnchor("correspond4"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Goods.correspond5")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="correspond5" value="checkbox"  <%=getCheck(ld.getIstype("correspond5"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="correspond5_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("correspond5"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="correspond5_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("correspond5"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="correspond5_3"  class="edit_input"  type="text" value="<%=ld.getSequence("correspond5")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="correspond5_4"   <%=getCheck(ld.getAnchor("correspond5"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Goods.correspond6")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="correspond6" value="checkbox"  <%=getCheck(ld.getIstype("correspond6"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="correspond6_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("correspond6"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="correspond6_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("correspond6"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="correspond6_3"  class="edit_input"  type="text" value="<%=ld.getSequence("correspond6")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="correspond6_4"   <%=getCheck(ld.getAnchor("correspond6"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Goods.capability")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="capability" value="checkbox"  <%=getCheck(ld.getIstype("capability"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <td><%=r.getString(teasession._nLanguage, "Before")%><input name="capability_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("capability"))%>"  class="edit_input"  type="text">
          <td><%=r.getString(teasession._nLanguage, "After")%><input name="capability_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("capability"))%>"  class="edit_input"  type="text">
            <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="capability_3"  class="edit_input"  type="text" value="<%=ld.getSequence("capability")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="capability_4"   <%=getCheck(ld.getAnchor("capability"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Text")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="text" value="checkbox"  <%=getCheck(ld.getIstype("text"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="text_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("text"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="text_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("text"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="text_3"  class="edit_input"  type="text" value="<%=ld.getSequence("text")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="text_4"   <%=getCheck(ld.getAnchor("text"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Company")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="company" value="checkbox"  <%=getCheck(ld.getIstype("company"))%>><%=r.getString(teasession._nLanguage, "Show")%>
        <td><%=r.getString(teasession._nLanguage, "Before")%><input name="company_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("company"))%>"  class="edit_input"  type="text">
          <td><%=r.getString(teasession._nLanguage, "After")%><input name="company_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("company"))%>"  class="edit_input"  type="text">
            <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="company_3"  class="edit_input"  type="text" value="<%=ld.getSequence("company")%>" maxlength="3" size="4">
            </td>
    </tr>





<%
java.util.Enumeration enumeration=Attribute.findByGoodstype(GoodsType.getRootId(teasession._strCommunity));
int id=0;
int attributeOrder=300;
while(enumeration.hasMoreElements())
{
  id=((Integer)enumeration.nextElement()).intValue();
  Attribute obj=Attribute.find(id);
  ListingDetail attribute=ListingDetail.find(listingid,34,teasession._nLanguage);
%>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td ><%=obj.getName(teasession._nLanguage)%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="attribute<%=id%>" value="checkbox"  <%=getCheck(attribute.getIstype("attribute"+id))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <td><%=r.getString(teasession._nLanguage, "Before")%><input name="attribute<%=id%>_1" mask="max" value="<%=HtmlElement.htmlToText(attribute.getBeforeItem("attribute"+id))%>"  class="edit_input"  type="text">
      <td><%=r.getString(teasession._nLanguage, "After")%><input name="attribute<%=id%>_2" mask="max" value="<%=HtmlElement.htmlToText(attribute.getAfterItem("attribute"+id))%>"  class="edit_input"  type="text">
      <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="attribute<%=id%>_3"  class="edit_input"  type="text" value="<%=attribute.getSequence("attribute"+id)%>" maxlength="3" size="4">
<%
if("img".equals(obj.getTypes()))
{
	out.print("<select name=attribute"+id+"_4 >");
	out.print("<option value=0 >-------");

	out.print("<option value=1");
	if(attribute.getAnchor("attribute"+id)==1)out.print(" SELECTED ");
	out.print(" >"+r.getString(teasession._nLanguage, "Node"));

	out.print("<option value=4");
	if(attribute.getAnchor("attribute"+id)==4)out.print(" SELECTED ");
	out.print(" >"+r.getString(teasession._nLanguage, "Picture"));

	out.print("</select>");
}else
{
	out.print("<input type=checkbox name=attribute"+id+"_4");
	if(attribute.getAnchor("attribute")>0)out.print(" CHECKED ");
	out.print(">"+r.getString(teasession._nLanguage, "Anchor"));
}
%></td>
    </tr>
    <%  }

    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td ><%=r.getString(teasession._nLanguage, "CBDetail")%>:</td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="attribute" value="checkbox"  <%=getCheck(ld.getIstype("attribute"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="attribute_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("attribute"))%>"  class="edit_input"  type="text">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="attribute_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("attribute"))%>"  class="edit_input"  type="text">
       <TD><%=r.getString(teasession._nLanguage, "Sequence")%><input name="attribute_3"  class="edit_input"  type="text" value="<%=ld.getSequence("attribute")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="attribute_4"   <%=getCheck(ld.getAnchor("attribute"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%>&nbsp;</td>
    </tr>

    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td colspan="6"><hr></td>
    </tr>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "Supplier")%>:</TD>
      <TD> <input  id="CHECKBOX" type="CHECKBOX" name="supplier" value="checkbox"  <%=getCheck(ld.getIstype("supplier"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="supplier_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("supplier"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="supplier_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("supplier"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="supplier_3" type="text" class="edit_input" value="<%=ld.getSequence("supplier")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="supplier_4"   <%=getCheck(ld.getAnchor("supplier"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "SKU")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="sku" value="checkbox"  <%=getCheck(ld.getIstype("sku"))%>><%=r.getString(teasession._nLanguage, "Show")%>
      <TD><%=r.getString(teasession._nLanguage, "Before")%><input name="sku_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("sku"))%>" type="text" class="edit_input">
         <td><%=r.getString(teasession._nLanguage, "After")%><input name="sku_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("sku"))%>" type="text" class="edit_input">
         <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="sku_3" type="text" class="edit_input" value="<%=ld.getSequence("sku")%>" maxlength="3" size="4">
         <input  id=CHECKBOX type="CHECKBOX" name="sku_4"   <%=getCheck(ld.getAnchor("sku"))%>>
         <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "SerialNumber")%>:</TD>
      <TD> <input  id="CHECKBOX" type="CHECKBOX" name="serialNumber" value="checkbox"  <%=getCheck(ld.getIstype("serialNumber"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="serialNumber_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("serialNumber"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="serialNumber_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("serialNumber"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="serialNumber_3" type="text" class="edit_input" value="<%=ld.getSequence("serialNumber")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="serialNumber_4"   <%=getCheck(ld.getAnchor("serialNumber"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "Goods")%>:</TD>
      <TD> <input  id="CHECKBOX" type="CHECKBOX" name="goods" value="checkbox"  <%=getCheck(ld.getIstype("goods"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="goods_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("goods"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="goods_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("goods"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="goods_3" type="text" class="edit_input" value="<%=ld.getSequence("goods")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="goods_4"   <%=getCheck(ld.getAnchor("goods"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td  ID=RowHeader><%=r.getString(teasession._nLanguage, "Inventory")%>:</TD>
      <TD ><input  id="CHECKBOX" type="CHECKBOX" name="inventory" value="checkbox"  <%=getCheck(ld.getIstype("inventory"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input   value="<%=HtmlElement.htmlToText(ld.getBeforeItem("inventory"))%>" type="text" class="edit_input"  name="inventory_1">
      <td><%=r.getString(teasession._nLanguage, "After")%><input   value="<%=HtmlElement.htmlToText(ld.getAfterItem("inventory"))%>" type="text" class="edit_input" name="inventory_2">
      <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="inventory_3" type="text" class="edit_input" value="<%=ld.getSequence("inventory")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="inventory_4"   <%=getCheck(ld.getAnchor("inventory"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "MinQuantity")%>:</TD>
      <TD> <input  id="CHECKBOX" type="CHECKBOX" name="minQuantity" value="checkbox"  <%=getCheck(ld.getIstype("minQuantity"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="minQuantity_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("minQuantity"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="minQuantity_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("minQuantity"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="minQuantity_3" type="text" class="edit_input" value="<%=ld.getSequence("minQuantity")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="minQuantity_4"   <%=getCheck(ld.getAnchor("minQuantity"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "MaxQuantity")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="maxQuantity" value="checkbox"  <%=getCheck(ld.getIstype("maxQuantity"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="maxQuantity_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("maxQuantity"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="maxQuantity_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("maxQuantity"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="maxQuantity_3" type="text" class="edit_input" value="<%=ld.getSequence("maxQuantity")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="maxQuantity_4"   <%=getCheck(ld.getAnchor("maxQuantity"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "Delta")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="delta" value="checkbox"  <%=getCheck(ld.getIstype("delta"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="delta_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("delta"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="delta_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("delta"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="delta_3" type="text" class="edit_input" value="<%=ld.getSequence("delta")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="delta_4"   <%=getCheck(ld.getAnchor("delta"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "Weight")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="weight" value="checkbox"  <%=getCheck(ld.getIstype("weight"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="weight_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("weight"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="weight_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("weight"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="weight_3" type="text" class="edit_input" value="<%=ld.getSequence("weight")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="weight_4"   <%=getCheck(ld.getAnchor("weight"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "Volume")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="volume" value="checkbox"  <%=getCheck(ld.getIstype("volume"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="volume_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("volume"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="volume_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("volume"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="volume_3" type="text" class="edit_input" value="<%=ld.getSequence("volume")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="volume_4"   <%=getCheck(ld.getAnchor("volume"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td colspan="6"><hr></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "Currency")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="currency" value="checkbox"  <%=getCheck(ld.getIstype("currency"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="currency_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("currency"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="currency_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("currency"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="currency_3" type="text" class="edit_input" value="<%=ld.getSequence("currency")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="currency_4"   <%=getCheck(ld.getAnchor("currency"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "Supply")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="supply" value="checkbox"  <%=getCheck(ld.getIstype("supply"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="supply_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("supply"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="supply_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("supply"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="supply_3" type="text" class="edit_input" value="<%=ld.getSequence("supply")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="supply_4"   <%=getCheck(ld.getAnchor("supply"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "List")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="list" value="checkbox"  <%=getCheck(ld.getIstype("list"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="list_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("list"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="list_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("list"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="list_3" type="text" class="edit_input" value="<%=ld.getSequence("list")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="list_4"   <%=getCheck(ld.getAnchor("list"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "OurPrice")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="ourPrice" value="checkbox"  <%=getCheck(ld.getIstype("ourPrice"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="ourPrice_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("ourPrice"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="ourPrice_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("ourPrice"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="ourPrice_3" type="text" class="edit_input" value="<%=ld.getSequence("ourPrice")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="ourPrice_4"   <%=getCheck(ld.getAnchor("ourPrice"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></TD>
    </TR>

    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "OurPrice")%>1:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="getPrice1" value="checkbox"  <%=getCheck(ld.getIstype("getPrice1"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="getPrice1_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPrice1"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="getPrice1_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPrice1"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="getPrice1_3" type="text" class="edit_input" value="<%=ld.getSequence("getPrice1")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getPrice1_4"   <%=getCheck(ld.getAnchor("getPrice1"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></TD>
    </TR>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "OurPrice")%>2:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="getPrice2" value="checkbox"  <%=getCheck(ld.getIstype("getPrice2"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="getPrice2_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPrice2"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="getPrice2_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPrice2"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="getPrice2_3" type="text" class="edit_input" value="<%=ld.getSequence("getPrice2")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getPrice2_4"   <%=getCheck(ld.getAnchor("getPrice2"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></TD>
    </TR>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "OurPrice")%>3:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="getPrice3" value="checkbox"  <%=getCheck(ld.getIstype("getPrice3"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="getPrice3_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("getPrice3"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="getPrice3_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("getPrice3"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="getPrice3_3" type="text" class="edit_input" value="<%=ld.getSequence("getPrice3")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="getPrice3_4"   <%=getCheck(ld.getAnchor("getPrice3"))%>><%=r.getString(teasession._nLanguage, "Anchor")%></TD>
    </TR>

    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "Point")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="point" value="checkbox"  <%=getCheck(ld.getIstype("point"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="point_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("point"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="point_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("point"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="point_3" type="text" class="edit_input" value="<%=ld.getSequence("point")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="point_4"   <%=getCheck(ld.getAnchor("point"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "ConvertCurrency")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="convertCurrency" value="checkbox"  <%=getCheck(ld.getIstype("convertCurrency"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="convertCurrency_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("convertCurrency"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="convertCurrency_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("convertCurrency"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="convertCurrency_3" type="text" class="edit_input" value="<%=ld.getSequence("convertCurrency")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="convertCurrency_4"   <%=getCheck(ld.getAnchor("convertCurrency"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "Quantity")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="quantity" value="checkbox"  <%=getCheck(ld.getIstype("quantity"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="quantity_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("quantity"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="quantity_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("quantity"))%>" type="text" class="edit_input">
        <input name="quantity_3" type="hidden" value="255">
        <%--
<%=r.getString(teasession._nLanguage, "Sequence")%>:<input name="quantity_3" type="text" class="edit_input" value="<%=ld.getSequence("quantity")%>" maxlength="3" size="4">
<input  id=CHECKBOX type="CHECKBOX" name="quantity_4"   <%=getCheck(ld.getAnchor("quantity"))%>><%=r.getString(teasession._nLanguage, "Anchor")%>--%> </TD>
    </TR>

    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "CBAddToShoppingCart")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="atsc" value="checkbox"  <%=getCheck(ld.getIstype("atsc"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="atsc_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("atsc"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="atsc_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("atsc"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="atsc_3" type="text" class="edit_input" value="<%=ld.getSequence("atsc")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="atsc_4"   <%=getCheck(ld.getAnchor("atsc"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
    <!--我的收藏-->
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <TD><%=r.getString(teasession._nLanguage, "我的收藏")%>:</TD>
      <TD><input  id="CHECKBOX" type="CHECKBOX" name="wdsc" value="checkbox"  <%=getCheck(ld.getIstype("wdsc"))%>><%=r.getString(teasession._nLanguage, "Show")%>
<td><%=r.getString(teasession._nLanguage, "Before")%><input name="wdsc_1" mask="max" value="<%=HtmlElement.htmlToText(ld.getBeforeItem("wdsc"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "After")%><input name="wdsc_2" mask="max" value="<%=HtmlElement.htmlToText(ld.getAfterItem("wdsc"))%>" type="text" class="edit_input">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%><input name="wdsc_3" type="text" class="edit_input" value="<%=ld.getSequence("wdsc")%>" maxlength="3" size="4">
        <input  id=CHECKBOX type="CHECKBOX" name="wdsc_4"   <%=getCheck(ld.getAnchor("wdsc"))%>>
        <%=r.getString(teasession._nLanguage, "Anchor")%> </TD>
    </TR>
  </table>
  <center>
    <input type=SUBMIT name="GoBack"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </center>
</form>

<script>
  function fshow()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)!="_4")
          {
              form1.elements[counter].checked=form1.elements["objshow"].checked;
          }
      }
  }
  function fafter()
  {
      for(var counter=0;counter<form1.elements.length;counter++)
      {
          if(form1.elements[counter].type=="text"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)=="_2")
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
          if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)=="_4")
          {
              form1.elements[counter].checked=form1.elements["objanchor_4"].checked;
          }
      }
  }

  function fsequ()
  {
    var paramvalue=0;
    for(var counter=0;counter<form1.elements.length;counter++)
    {
      if(form1.elements[counter].type=="text"&&form1.elements[counter].name.substring(form1.elements[counter].name.length-2)=="_3")
      {
        form1.elements[counter].value=++paramvalue*10;
      }
    }
  }
</script>
<script><%if(request.getParameter("edit")==null)out.println("fsequ();");%>document.form1.code_1.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

