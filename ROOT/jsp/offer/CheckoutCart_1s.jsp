<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect(request.getContextPath()+"/servlet/StartLogin?Node="+teasession._nNode);
  return;
}


String community=teasession._strCommunity;

if(request.getParameter("ChangeQuantity") != null)//修改数量
{
  int i = 0;
  do
  {
    String s1 =  request.getParameter("Buy" + i);
    if(s1 != null)
    {
      int k = 0;
      k = Integer.parseInt( request.getParameter("Quantity" + i));
      tea.entity.node.Buy buy = tea.entity.node.Buy.find(Integer.parseInt(s1));
      buy.set(k);
      i++;
    } else
    {
      String nexturl=request.getParameter("nexturl");
      if(nexturl==null)
      nexturl=request.getContextPath()+"/servlet/ShoppingCarts";
      response.sendRedirect(nexturl);
      return;
    }
  } while(true);
}


Resource r=new Resource("tea/ui/member/offer/Offers");

String s =  request.getParameter("Vendor");//卖主
int j =Integer.parseInt(request.getParameter("Currency"));
int l = 0;
if(request.getParameter("Shipping")!=null)
l = Integer.parseInt(request.getParameter("Shipping"));
java.math.BigDecimal bigdecimal = new java.math.BigDecimal( request.getParameter("SubTotal"));//小计
java.math.BigDecimal bigdecimal1 = new java.math.BigDecimal( request.getParameter("ListTotal"));//原计
String s2 = r.getString(teasession._nLanguage, Common.CURRENCY[j]);//货币种类

Profile p =Profile.find(teasession._rv.toString());

%><HTML>
<HEAD>
<link href="/tea/CssJs/<%=teasession._strCommunity%>.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage, "CheckoutCart1")%></h1>
<div id="head6"><img height="6"></div>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
<FORM name=foCheckout METHOD=POST action="/jsp/offer/EditCheckout.jsp">
<input type='hidden' name=Vendor VALUE="<%=s%>">
<input type='hidden' name=Currency VALUE="<%=j%>">
<input type='hidden' name=Shipping VALUE="<%=l%>">
<input type='hidden' name=SubTotal VALUE="<%=bigdecimal%>">
<input type='hidden' name=ListTotal VALUE="<%=bigdecimal1%>">
<tr ID=tableonetr>
<TD><%=r.getString(teasession._nLanguage, "TradeSubject")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Price")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Quantity")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Total")%></TD></tr>
<%
int i1 = 0;
int j1 = 0;
BigDecimal bigdecimal2 = new BigDecimal(0.0D);
do
{
  String s3 = request.getParameter("Buy" + j1);
  if(s3 == null)
  break;
  String s4 = request.getParameter("Node" + j1);
  String s5 = request.getParameter("Nodex" + j1);
  String s6 = request.getParameter("SKU" + j1);
  String s7 = request.getParameter("SerialNumber" + j1);
  int i2 = Integer.parseInt(request.getParameter("Quality" + j1));
  String s8 =  request.getParameter("Subject" + j1);
  String s10 =  request.getParameter("Subjectx" + j1);
  BigDecimal bigdecimal7 = new BigDecimal(request.getParameter("Price" + j1));
  int j2 = Integer.parseInt(request.getParameter("ConvertCurrency" + j1));
  BigDecimal bigdecimal8 = new BigDecimal(request.getParameter("ConvertPoint" + j1));
  int k2 = 0;
  try
  {
    k2 = Integer.parseInt(request.getParameter("Quantity" + j1));
  } catch(Exception _ex)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidQuantity"),"UTF-8"));
    return;
  }
  java.math.BigDecimal bigdecimal10 = bigdecimal7.multiply(new BigDecimal(k2));
  bigdecimal2 = bigdecimal2.add(bigdecimal10);
%>
<tr onmouseover="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
  <td><%=s8%> &nbsp;<%=s10%></td>
  <td><%=s2%> <%=bigdecimal7%></td>
  <td><%=k2%></td>
  <td><%=s2%> <%=bigdecimal10%></td>
</tr>

<input type='hidden' name=Buy<%=j1%> VALUE="<%=s3%>">
<input type='hidden' name=Node<%=j1%> VALUE="<%=s4%>">
<input type='hidden' name=Nodex<%=j1%> VALUE="<%=s5%>">
<input type='hidden' name=SKU<%=j1%> VALUE="<%=s6%>">
<input type='hidden' name=SerialNumber<%=j1%> VALUE="<%=s7%>">
<input type='hidden' name=Quality<%=j1%> VALUE="<%=i2%>">
<input type='hidden' name=Subject<%=j1%> VALUE="<%=s8%>">
<input type='hidden' name=Subjectx<%=j1%> VALUE="<%=s10%>">
<input type='hidden' name=Price<%=j1%> VALUE="<%=bigdecimal7.toString()%>">
<input type='hidden' name=Quantity<%=j1%> VALUE="<%=k2%>">
<input type='hidden' name=ConvertCurrency<%=j1%> VALUE="<%=j2%>">
<input type='hidden' name=ConvertPoint<%=j1%> VALUE="<%=bigdecimal8.toString()%>">
<%
j1++;
Node node = Node.find(Integer.parseInt(s4));
java.util.ArrayList al=new  java.util.ArrayList();
al.add(new Integer(s4));
session.setAttribute("list",al);

Node.find(Integer.parseInt(s5));
if((node.getOptions1() & 2) == 0)
i1 += k2;
} while(true);

if(bigdecimal2.compareTo(bigdecimal) != 0)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidSubTotal"),"UTF-8"));
  return;
}
            boolean flag = bigdecimal.compareTo(new java.math.BigDecimal(0.0D)) == 0;
            if(l == 0)
            {%><%--
                <tr><td  ALIGN=RIGHT COLSPAN=6><%=r.getString(teasession._nLanguage, "Shipping")%>:
                <%=s2%><input type="TEXT" class="edit_input"  name=Sh VALUE="" SIZE=6>
<%              if(flag)
                {%> <input type='hidden' name="Tax" VALUE="0">
              <%} else
                {%>
			<tr><td ALIGN=RIGHT COLSPAN=6><%=r.getString(teasession._nLanguage, "Tax")%>:
			<input type="TEXT" class="edit_input"  name="Tax" VALUE="" size=6>
              <%}--%>
              <input type="hidden" class="edit_input"  name=Sh VALUE="0" SIZE=6>
                <input type='hidden' name="Tax" VALUE="0">
                <tr><td><td align=right colspan=6><%=r.getString(teasession._nLanguage, "Total")%>:
				<%=s2 + bigdecimal%>
              <%
            } else
            {
                tea.entity.member.Shipping shipping = tea.entity.member.Shipping.find(l);
                int l1 = shipping.getOptions();
                BigDecimal bigdecimal3 = shipping.getPerShipment();
                BigDecimal bigdecimal4 = shipping.getPerItem();
                BigDecimal bigdecimal5 = shipping.getTaxRate();
                String s9 = shipping.getText(teasession._nLanguage);%>
                <%=s9%>
  <%            java.math.BigDecimal bigdecimal6 = bigdecimal3;
                if((l1 & 2) != 0)
                    bigdecimal6 = bigdecimal6.add(bigdecimal1.multiply(bigdecimal4).divide(new java.math.BigDecimal(100D), 2, 4));
                else
                    bigdecimal6 = bigdecimal6.add(bigdecimal4.multiply(new java.math.BigDecimal(i1)));
          %>    <tr><td ALIGN=RIGHT COLSPAN=6><%=r.getString(teasession._nLanguage, "Shipping")%>:
                <td ALIGN=RIGHT><%=s2 + bigdecimal6%>
		<input type='hidden' name=Sh VALUE="<%=bigdecimal6%>">
<%              java.math.BigDecimal bigdecimal9 = new java.math.BigDecimal(0.0D);
                if((l1 & 1) != 0 && !flag)
                {
                    bigdecimal9 = bigdecimal9.add(bigdecimal.multiply(bigdecimal5).divide(new java.math.BigDecimal(100D), 2, 4));
%>					<tr><td ALIGN=RIGHT COLSPAN=6><%=r.getString(teasession._nLanguage, "Tax")%>(<%=bigdecimal5.toString()%>%):
					<td ALIGN=RIGHT><%=s2 + bigdecimal9%>
					<input type='hidden' name="Tax" VALUE="<%=bigdecimal9%>">
<%              } else
                {%><input type='hidden' name=Tax VALUE="0">
  <%            }%>
                <tr><td><td align=right colspan=6>
                  <input type="hidden" name="total" value="<%=bigdecimal.add(bigdecimal6).add(bigdecimal9)%>"/>
                  <%=r.getString(teasession._nLanguage, "Total")%>:
				<%=s2 + bigdecimal.add(bigdecimal6).add(bigdecimal9)%>
  <%        }
  int k1 = Integer.parseInt(request.getParameter("BuyPoint"));
  BuyPoint buypoint = BuyPoint.find(k1);
  if(buypoint.getCurrentPoint().compareTo(new BigDecimal(0.0D)) == 1)
  {%>
                <table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
				<tr><td align=right colspan=4>
                <%=r.getString(teasession._nLanguage, "YourCurrentPoint")%>:
                 <%=buypoint.getCurrentPoint().toString()%>
                <tr><td align=right colspan=4><%=r.getString(teasession._nLanguage, "PayByPoint")%>:
				<input  id="radio" type="radio" name="PayByPoint" value=0 selected><%=r.getString(teasession._nLanguage, "Yes")%>
				<input  id="radio" type="radio" name="PayByPoint" value=1 ><%=r.getString(teasession._nLanguage, "No")%>
				<input type='hidden' name="BuyPoint" value=k1>
<%          } else
            {%>
				<input type='hidden' name="PayByPoint" value="0">
				<input type='hidden' name="BuyPoint" value="<%=k1%>">
          <%}
          //判断是否有优惠卷,如果有则 显示文件框,让会员输入
         java.util.Enumeration enumerCoupon= Coupon.find(teasession._strCommunity," AND member="+DbAdapter.cite(teasession._rv._strR));
         while(enumerCoupon.hasMoreElements())
         {
           if( tea.entity.member.CouponMember.isExisted(((Integer)enumerCoupon.nextElement()).intValue(),teasession._rv._strR))
           {%>
           <br/><%=r.getString(teasession._nLanguage, "CouponCode")%>:
           <input type="TEXT" class="edit_input"  name="CouponCode">
           <%break;}
         }
          %>
          <br/>

<!--收货地址 -->
<h2>填写收货地址</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="tablejh">
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "State")%>:</Td>
    <td><script>selectcard('state','city0','city','<%=p.getCity(teasession._nLanguage)%>');</script>
 </td>
  </tr>
  <tr>
    <td id="left"><%=r.getString(teasession._nLanguage, "收货地址")%></Td>
    <td><textarea name=address rows=2 cols=40><%=p.getAddress(teasession._nLanguage).replaceAll("</","&lt;/")%></textarea></td>

  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=email value="<%=p.getEmail()%>" size=40 maxlength=40></td>

  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=firstname value="<%=p.getFirstName(teasession._nLanguage)%>" size=20 maxlength=20>
    </td>

  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "Organization")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=organization value="<%=p.getOrganization(teasession._nLanguage)%>" size=40 maxlength=40></td>

  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "Zip")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=zip value="<%=p.getZip(teasession._nLanguage)%>" size=20 maxlength=20></td>

  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
    <td><input type="TEXT" class="edit_input"  name=telephone value="<%=p.getTelephone(teasession._nLanguage)%>" size=20 maxlength=20></td>

  </tr>
</table>
          <input type=SUBMIT class="edit_button" value="<%=r.getString(teasession._nLanguage, "Continue")%>" >
          &nbsp;
          <input type=button value="返回" onClick="javascript:history.back()">
                                        </td>                </tr></FORM></table>
<div id="head6"><img height="6"></div>
</body>
</HTML>
