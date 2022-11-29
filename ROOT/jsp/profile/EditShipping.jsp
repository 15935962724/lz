<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


if(!teasession._rv.isAccountant())
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/ui/member/profile/EditShipping");

String s =  request.getParameter("Shipping");
boolean flag = s == null;
int i = 0;
int k = 8192;
BigDecimal bigdecimal = new BigDecimal(0.0D);
BigDecimal bigdecimal2 = new BigDecimal(0.0D);
BigDecimal bigdecimal4 = new BigDecimal(0.0D);
String s1 = "";
String s3 = "";
if(!flag)
{
  Shipping shipping = Shipping.find(Integer.parseInt(s));
  i = shipping.getCurrency();
  k = shipping.getOptions();
  bigdecimal = shipping.getPerShipment();
  bigdecimal2 = shipping.getPerItem();
  bigdecimal4 = shipping.getTaxRate();
  s1 = shipping.getName(teasession._nLanguage);
  s3 = shipping.getText(teasession._nLanguage);
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditShipping")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<FORM name=foEdit METHOD=POST action="/servlet/EditShipping" onSubmit="return(submitFloat(this.PerShipment,'<%=r.getString(teasession._nLanguage, "InvalidPerShipment")%>')&&submitFloat(this.PerItem,'<%=r.getString(teasession._nLanguage, "InvalidPerItem")%>')&&submitFloat(this.TaxRate,'<%=r.getString(teasession._nLanguage, "InvalidTaxRate")%>')&&submitText(this.Name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>'));">
<%if(!flag){%>
	<input type='hidden' name=Shipping VALUE="<%=s%>">
<%}%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%-- table.add(new CurrencySelection(teasession._nLanguage, i, false));--%>
<tr><TD><%=r.getString(teasession._nLanguage, "Currency")%>:</TD>
<td>
<input  id="radio" type="radio" name=Currency VALUE=0<%if(i==0)out.print(" CHECKED ");%>>US$
<input  id="radio" type="radio" name=Currency VALUE=1<%if(i==1)out.print(" CHECKED ");%>>&yen;
<input  id="radio" type="radio" name=Currency VALUE=2<%if(i==2)out.print(" CHECKED ");%>>HK$
<input  id="radio" type="radio" name=Currency VALUE=3<%if(i==3)out.print(" CHECKED ");%>>NT$
<input  id="radio" type="radio" name=Currency VALUE=4<%if(i==4)out.print(" CHECKED ");%>>&euro;
<input  id="radio" type="radio" name=Currency VALUE=5<%if(i==5)out.print(" CHECKED ");%>>J&yen;
<input  id="radio" type="radio" name=Currency VALUE=6<%if(i==6)out.print(" CHECKED ");%>>CC</td></tr>

<tr><TD><%=r.getString(teasession._nLanguage, "Options")%>:</TD>
<td>
<input  id="CHECKBOX" type="CHECKBOX" name=ShippingOAccess value=null <%if((k & 0x8000) != 0)out.print(" CHECKED ");%>><%=r.getString(teasession._nLanguage, "ShippingOAccess")%>
<input  id="CHECKBOX" type="CHECKBOX" name=ShippingOAd value=null <%if((k & 0x4000) != 0)out.print(" CHECKED ");%>><%=r.getString(teasession._nLanguage, "ShippingOAd")%>
<input  id="CHECKBOX" type="CHECKBOX" name=ShippingOBuy value=null <%if((k & 0x2000) != 0)out.print(" CHECKED ");%>><%=r.getString(teasession._nLanguage, "ShippingOBuy")%>
<input  id="CHECKBOX" type="CHECKBOX" name=ShippingOBid value=null <%if((k & 0x1000) != 0)out.print(" CHECKED ");%>><%=r.getString(teasession._nLanguage, "ShippingOBid")%>
<input  id="CHECKBOX" type="CHECKBOX" name=ShippingOBargain value=null <%if((k & 0x800) != 0)out.print(" CHECKED ");%>><%=r.getString(teasession._nLanguage, "ShippingOBargain")%>
<input  id="CHECKBOX" type="CHECKBOX" name=ShippingOPercentage value=null <%if((k & 2) != 0)out.print(" CHECKED ");%>><%=r.getString(teasession._nLanguage, "ShippingOPercentage")%>
<input  id="CHECKBOX" type="CHECKBOX" name=ShippingOTax value=null <%if((k & 1) != 0)out.print(" CHECKED ");%>><%=r.getString(teasession._nLanguage, "ShippingOTax")%></td></tr>
<tr><TD><%=r.getString(teasession._nLanguage, "PerShipment")%>:</TD>
<td>
<input type="TEXT" class="edit_input"  name=PerShipment VALUE="<%=bigdecimal%>"></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "PerItem")%>:</TD>
<td>
<input type="TEXT" class="edit_input"  name=PerItem VALUE="<%=bigdecimal2%>"></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "TaxRate")%>:</TD>
<td>
<input type="TEXT" class="edit_input"  name=TaxRate VALUE="<%=bigdecimal4%>">%</td></tr><tr><TD><%=r.getString(teasession._nLanguage, "Name")%>:</TD>
<td>
<input type="TEXT" class="edit_input"  name=Name VALUE="<%=s1%>"></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
<td>
<TEXTAREA name="Text" ROWS=8 COLS=60><%=tea.html.HtmlElement.htmlToText(s3)%></TEXTAREA></td></tr></table>
<P ALIGN=CENTER>
<input type=SUBMIT name="GoNext" id="edit_GoNext" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBNext")%>">
<input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
</P>
</FORM>
<SCRIPT>document.foEdit.Text.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

