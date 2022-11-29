<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*"%>
<%@ page import="tea.resource.*"%>
<%@page import="tea.ui.*"%>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);

Node node=Node.find(teasession._nNode);
Resource r = new Resource();
r.add("/tea/ui/node/type/buy/EditBuyPrice");
if(teasession._rv==null)
{
  if((node.getOptions1()& 1) == 0)
  {
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }
}else
{
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(node.getType()))
  {
    response.sendError(403);
    return;
  }
}
String s = request.getParameter("Currency");
String s1 = request.getParameter("ConvertCurrency");

boolean flag = s == null;
int j = 0;
java.math.BigDecimal bigdecimal = null;
java.math.BigDecimal bigdecimal2 = null;
java.math.BigDecimal bigdecimal4 = null;
int l = 0;
java.math.BigDecimal bigdecimal7 = null;
int j1 = 1;
int commodity=Integer.parseInt(request.getParameter("commodity"));

java.math.BigDecimal price1 =null,price2=null,price3=null;
if(!flag)
{
  j = Integer.parseInt(s);
  BuyPrice obj = BuyPrice.find(commodity, j);
  bigdecimal = obj.getSupply();
  bigdecimal2 = obj.getList();
  bigdecimal4 = obj.getPrice();
  l = obj.getOptions();
  bigdecimal7 = obj.getPoint();
  j1 = obj.getConvertCurrency();
  price1=obj.getPrice1();
  price2=obj.getPrice2();
  price3=obj.getPrice3();
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBEditBuy")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <form name=foEdit method=POST action="/servlet/EditBuyPrice" onSubmit="return(submitFloat(this.Supply,'<%=r.getString(teasession._nLanguage, "InvalidSupply")%>')&&submitFloat(this.List,'<%=r.getString(teasession._nLanguage, "InvalidList")%>')&&submitFloat(this.Price,'<%=r.getString(teasession._nLanguage, "InvalidPrice")%>')&&submitFloat(this.Price1,'<%=r.getString(teasession._nLanguage, "InvalidPrice")%>1')&&submitFloat(this.Price2,'<%=r.getString(teasession._nLanguage, "InvalidPrice")%>2')&&submitFloat(this.Price3,'<%=r.getString(teasession._nLanguage, "InvalidPrice")%>3'));">
    <input type='hidden' name=Node value="<%=Integer.toString(teasession._nNode)%>">
    <input type='hidden' name=commodity value="<%=commodity%>">
    <%
    String nexturl=request.getParameter("nexturl");
    if(nexturl!=null)
    out.print(new tea.html.HiddenField("nexturl",nexturl));
    %>
    <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
      <tr id="Currencyid">
        <td><%=r.getString(teasession._nLanguage, "Currency")%>:</td>
        <td>
          <%if(flag){%>
          <input type='hidden' name=New value="ON">
          <input  id="radio" type="radio" name=Currency value=0 >US$
          <input  id="radio" type="radio" name=Currency checked value=1>&yen;
          <input  id="radio" type="radio" name=Currency value=2>HK$
          <input  id="radio" type="radio" name=Currency value=3>NT$
          <input  id="radio" type="radio" name=Currency value=4>&euro;
          <input  id="radio" type="radio" name=Currency value=5>J&yen;
          <input  id="radio" type="radio" name=Currency value=6>CC
        </td>
      </tr>
      <%}else{%>
      <input type='hidden' name=Currency value="<%=s%>">
      <%
switch(Integer.parseInt(s))
{ 	case 0:%>
      US$
      <%break;
 	case 1:%>
&yen;
      <%break;
	case 2:%>
      HK$
      <%break;
 	case 3:%>
      NT$
      <%break;
 	case 4:%>
&euro;
      <%break;
 	case 5:%>
      J&yen;
      <%break;
 	case 6:%>
      CC
      <%break;
}
			}
            %>
      <%--=new CurrencySelection(teasession._nLanguage, j, !flag)--%>
        <tr id="List">
        <td><%=r.getString(teasession._nLanguage, "进货价")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=List value="<%if(bigdecimal2!=null)out.print(bigdecimal2);else out.print("0.00");%>" size=6></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Supply")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Supply value="<%if(bigdecimal!=null)out.print(bigdecimal);else out.print("0.00");%>" size=6></td>
      </tr>

      <tr>
        <td><%=r.getString(teasession._nLanguage, "OurPrice")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Price value="<%if(bigdecimal4!=null)out.print(bigdecimal4);else out.print("0.00");%>" size=6></td>
      </tr>
            <tr>
        <td><%=r.getString(teasession._nLanguage, "OurPrice")%>1:</td>
        <td><input type="TEXT" class="edit_input"  name=Price1 value="<%if(price1!=null)out.print(price1);else out.print("0.00");%>" size=6></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "OurPrice")%>2:</td>
        <td><input type="TEXT" class="edit_input"  name=Price2 value="<%if(price2!=null)out.print(price2);else out.print("0.00");%>" size=6></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "OurPrice")%>3:</td>
        <td><input type="TEXT" class="edit_input"  name=Price3 value="<%if(price3!=null)out.print(price3);else out.print("0.00");%>" size=6></td>
      </tr>
      <tr>
        <td><br/> </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Point")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Point value="<%if(bigdecimal7!=null)out.print(bigdecimal7);else out.print("0");%>" size=6>
        <span id="spanOptionsid">
          <input  id="radio" type="radio" name=Options value=0 <%=getCheck(l == 0)%> checked>
          <%=r.getString(teasession._nLanguage, "BaseOnRelation")%>
          <input  id="radio" type="radio" name=Options value=1 <%=getCheck(l == 1)%>>
          <%=r.getString(teasession._nLanguage, "BaseOnAmount")%></span></td>
      </tr>
      <tr id= "ConvertCurrencyid">
        <td><%=r.getString(teasession._nLanguage, "ConvertCurrency")%>:</td>
        <td><input  id="radio" type="radio" name=ConvertCurrency value=0 <%=getCheck(j1==0)%>>US$
          <input  id="radio" type="radio" name=ConvertCurrency value=1 <%=getCheck(j1==1)%>>&yen;
          <input  id="radio" type="radio" name=ConvertCurrency value=2 <%=getCheck(j1==2)%>>HK$
          <input  id="radio" type="radio" name=ConvertCurrency value=3 <%=getCheck(j1==3)%>>NT$
          <input  id="radio" type="radio" name=ConvertCurrency value=4 <%=getCheck(j1==4)%>>&euro;
          <input  id="radio" type="radio" name=ConvertCurrency value=5 <%=getCheck(j1==5)%>>J&yen;
          <input  id="radio" type="radio" name=ConvertCurrency value=6 <%=getCheck(j1==6)%>>CC</td>
      </tr>
      <%--
<table class="section">
  <tr>
    <td><form name=foEdit method=POST action="/servlet/EditBuyPrice" onSubmit="return(submitFloat(this.Supply,'<%=r.getString(teasession._nLanguage, "InvalidSupply")%>')&&submitFloat(this.Price,'<%=r.getString(teasession._nLanguage, "InvalidPrice")%>'));">

      </form>--%>
    </table>
    <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
