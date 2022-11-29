<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect(request.getContextPath()+"/servlet/StartLogin?Node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;


//request.setCharacterEncoding("UTF-8");
Resource r=new Resource("tea/ui/member/offer/CheckoutCart2").add("tea/ui/member/offer/Offers");
java.math.BigDecimal bigdecimal = null;
try
{
  bigdecimal = new BigDecimal(request.getParameter("ListTotal"));
}catch(Exception _ex)
{}
if(bigdecimal == null)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidListTotal"),"UTF-8"));
  return;
}
BigDecimal bigdecimal1 = null;
try
{
  bigdecimal1 = new BigDecimal(request.getParameter("SubTotal"));
}catch(Exception _ex)
{}
if(bigdecimal1 == null)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidSubTotal"),"UTF-8"));
  return;
}
BigDecimal bigdecimal2 = null;
try
{
  bigdecimal2 = new BigDecimal(request.getParameter("Sh"));
}catch(Exception _ex){}
if(bigdecimal2 == null)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidShipping"),"UTF-8"));
  return;
}
BigDecimal bigdecimal3 = null;
try
{
  bigdecimal3 = new BigDecimal(request.getParameter("Tax"));
  System.out.print(request.getParameter("Tax"));
}
catch(Exception _ex) {}
if(bigdecimal3 == null)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidTax"),"UTF-8"));
  return;
}
int i = 0;
int j = 0;
i = Integer.parseInt(request.getParameter("PayByPoint"));
j = Integer.parseInt(request.getParameter("BuyPoint"));
tea.entity.member.BuyPoint buypoint = tea.entity.member.BuyPoint.find(j);
String s = request.getParameter("Vendor");
int k = Integer.parseInt(request.getParameter("Currency"));
if(k == 6 && i == 1)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "NotAllowed"),"UTF-8"));
  return;
}
String s1 = request.getParameter("CouponCode");
int l = 0;
if(s1!=null&&s1.length() != 0)
{
  l = Coupon.find(teasession._strCommunity ,s, k, 8192, s1);
  if(l == 0)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidCouponCode"),"UTF-8"));
    return;
  }
}
BigDecimal bigdecimal4 = new BigDecimal(0.0D);
if(l != 0)
{
  if(CouponMember.count(l) != 0 && !CouponMember.isExisted(l, teasession._rv._strR))
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidCouponMember"),"UTF-8"));
    return;
  }
  Coupon coupon = Coupon.find(l);
  BigDecimal bigdecimal5 = coupon.getMinimum();
  BigDecimal bigdecimal6 = coupon.getDiscount();
  if(bigdecimal5.compareTo(bigdecimal1) > 0)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidCouponMinimum"),"UTF-8"));
    return;
  }
  switch(coupon.getType())
  {
    case 0: // '\0'
    bigdecimal4 = bigdecimal6;
    break;

    case 1: // '\001'
    bigdecimal4 = bigdecimal.multiply(bigdecimal6);
    break;

    case 2: // '\002'
    bigdecimal4 = bigdecimal1.multiply(bigdecimal6);
    break;

    case 3: // '\003'
    bigdecimal4 = bigdecimal2.multiply(bigdecimal6);
    break;
  }
  bigdecimal4 = bigdecimal4.negate().setScale(2, 4);
}
int i1 = Integer.parseInt(request.getParameter("Shipping"));
String s2 = r.getString(teasession._nLanguage, Common.CURRENCY[k]);
Profile profile = Profile.find(teasession._rv._strR,community);
String s3 = profile.getEmail(teasession._nLanguage);
String s4 = profile.getFirstName(teasession._nLanguage);
String s5 = profile.getLastName(teasession._nLanguage);
String s6 = profile.getOrganization(teasession._nLanguage);
String s7 = profile.getAddress(teasession._nLanguage);
String s8 = profile.getCity(teasession._nLanguage);
String s9 = profile.getState(teasession._nLanguage);
String s10 = profile.getZip(teasession._nLanguage);
String s11 = profile.getCountry(teasession._nLanguage);
String s12 = profile.getTelephone(teasession._nLanguage);
String s13 = profile.getFax(teasession._nLanguage);
BigDecimal bigdecimal7 = new BigDecimal(0.0D);

//   Table table = new Table();
//     table.setCellSpacing(3);
//    table.setTitle(r.getString(teasession._nLanguage, "TradeSubject") + "\n" + " &nbsp;" + "\n" + r.getString(teasession._nLanguage, "Price") + "\n" + " &nbsp;" + "\n" + r.getString(teasession._nLanguage, "Quantity") + "\n" + " &nbsp;" + "\n" + r.getString(teasession._nLanguage, "Total") + "\n");
Shipping shipping = Shipping.find(i1);
shipping.getPayMethod();
shipping.getParameters();


%><HTML>
<HEAD>
<link href="/tea/CssJs/<%=teasession._strCommunity%>.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>

<body>
<h1><%=r.getString(teasession._nLanguage, "ChekoutCart")%></h1>
<div id="head6"><img height="6"></div>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
      <TD><%=r.getString(teasession._nLanguage, "TradeSubject")%></TD>
      <TD><%=r.getString(teasession._nLanguage, "Price")%></TD>
      <TD><%=r.getString(teasession._nLanguage, "Quantity")%></TD>
      <TD><%=r.getString(teasession._nLanguage, "Total")%></TD>
    </tr>
    <tr>
      <form name=foCheckout method=POST action="/servlet/CheckoutCart3" enctype=multipart/form-data onSubmit="return(submitEmail(this.bEmail,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitText(this.bFirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')&&submitText(this.bLastName,'<%=r.getString(teasession._nLanguage, "InvalidLastName")%>')&&submitText(this.bAddress,'<%=r.getString(teasession._nLanguage, "InvalidAddress")%>')&&submitText(this.bCity,'<%=r.getString(teasession._nLanguage, "InvalidCity")%>')&&submitText(this.bState,'<%=r.getString(teasession._nLanguage, "InvalidState")%>')&&submitText(this.bCountry,'<%=r.getString(teasession._nLanguage, "InvalidCountry")%>')&&submitText(this.bTelephone,'<%=r.getString(teasession._nLanguage, "InvalidTelephone")%>'));">
        <input type='hidden' name=Vendor value="<%=s%>">
        <input type='hidden' name=Currency value="<%=k%>">
        <input type='hidden' name=Shipping value="<%=i1%>">
        <input type='hidden' name=community value="<%=community%>">

        <%	int j1 = 0;
            do
            {
              String s14 =  request.getParameter("Buy" + j1);
              if(s14 == null)
              break;
              String s15 =  request.getParameter("Node" + j1);
              String s16 =  request.getParameter("Nodex" + j1);
              String s17 =  request.getParameter("SKU" + j1);
              String s18 =  request.getParameter("SerialNumber" + j1);
              int k1 = Integer.parseInt( request.getParameter("Quality" + j1));
              String s19 =  request.getParameter("Subject" + j1);

              String s20 =  request.getParameter("Subjectx" + j1);

              java.math.BigDecimal bigdecimal9 = new java.math.BigDecimal( request.getParameter("Price" + j1));
              int l1 = Integer.parseInt( request.getParameter("Quantity" + j1));
              int i2 = Integer.parseInt( request.getParameter("ConvertCurrency" + j1));
              java.math.BigDecimal bigdecimal10 = new java.math.BigDecimal( request.getParameter("ConvertPoint" + j1));
              java.math.BigDecimal bigdecimal11 = bigdecimal9.multiply(new java.math.BigDecimal(l1));
              bigdecimal7 = bigdecimal7.add(bigdecimal11);
%><tr onmouseover="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
        <td><%=(new Text(s19)).toString()%> &nbsp;<%=(new Text(s20)).toString()%> </td>
        <td><%=s2%> <%= bigdecimal9%> </td>
        <td><%=Integer.toString(l1)%> </td>
        <td><%=s2 + bigdecimal11%>
            <input type='hidden' name=Buy<%=j1%> value="<%=s14%>">
            <input type='hidden' name=Node<%=j1%> value="<%=s15%>">
            <input type='hidden' name=Nodex<%=j1%> value="<%=s16%>">
            <input type='hidden' name=SKU<%=j1%> value="<%=s17%>">
            <input type='hidden' name=SerialNumber<%=j1%> value="<%=s18%>">
            <input type='hidden' name=Quality<%=j1%> value="<%=Integer.toString(k1)%>">
            <input type='hidden' name=Subject<%=j1%> value="<%=s19%>">
            <input type='hidden' name=Subjectx<%=j1%> value="<%=s20%>">
            <input type='hidden' name=Price<%=j1%> value="<%=bigdecimal9.toString()%>">
            <input type='hidden' name=Quantity<%=j1%> value="<%=Integer.toString(l1)%>">
            <input type='hidden' name=ConvertCurrency<%=j1%> value="<%=Integer.toString(i2)%>">
            <input type='hidden' name=ConvertPoint<%=j1%> value="<%=bigdecimal10.toString()%>">
            <%j1++;
            } while(true);
            if(bigdecimal7.compareTo(bigdecimal1) != 0)
            {
              response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidSubTotal"),"UTF-8"));
              return;
            }
            Object obj = new Row();%>

		</td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Shipping")%>:</TD>
      <td><%=s2 + bigdecimal2%>
          <input type='hidden' name=Sh value="<%=bigdecimal2%>">
          <%if(bigdecimal3.compareTo(new BigDecimal(0.0D)) != 0)
            {%>
      </td></tr>
  <tr>
      <td><%=r.getString(teasession._nLanguage, "Tax")%>(<%=shipping.getTaxRate().toString()%>%):
      <td><%=s2 + bigdecimal3%>
                        <%}%>
                        <input type='hidden' name=Tax value="<%=bigdecimal3%>">
                        <%if(l != 0)
            {%>
      <tr>
                      <td colspan=6><%=r.getString(teasession._nLanguage, "Coupon")%>(<%=s1%>):
        <tr>
				      <td><%=s2%> <%=bigdecimal4.toString()%>
                          <%                Coupon coupon1 = Coupon.find(l);%>
          <tr>
<td colspan=6><%=coupon1.getName(teasession._nLanguage)%>
            <tr>
                                    <td colspan=6><%=coupon1.getText(teasession._nLanguage)%>
<%}%>
<input type='hidden' name=Coupon value="<%=l%>">
<input type='hidden' name=Discount value="<%=bigdecimal4%>">
<input type='hidden' name=ListTotal value="<%=bigdecimal%>">
<input type='hidden' name=SubTotal value="<%=bigdecimal1%>">
<input type='hidden' name=PayByPoint value="<%=i%>">
<input type='hidden' name=BuyPoint value="<%=j%>">
<input type='hidden' name=CouponCode value="<%=s1%>">
<%           BigDecimal bigdecimal8 = bigdecimal1.add(bigdecimal2).add(bigdecimal3).add(bigdecimal4);
			Object obj2 = new Row();
%>
<input type='hidden' name=Total value="<%=bigdecimal8%>">
              <tr>
                            <TD>             <%=r.getString(teasession._nLanguage, "Total")%>:                          </TD>
                            <td><%=s2 + bigdecimal8%>
                                <%          if(i == 0 && buypoint.getCurrentPoint().compareTo(new BigDecimal(0.0D)) == 1)
            {%>
        <tr>
            <td colspan=4><%=r.getString(teasession._nLanguage, "YourCurrentPoint")%>: <%=buypoint.getCurrentPoint().toString()%>
                <%}%>
</td></tr></table>
支付方式:
<select name="paytype">
  <%
  for(int index=0;index<tea.entity.member.Trade.PAY_TYPE.length;index++){
    %>
    <option value="<%=index%>" ><%=tea.entity.member.Trade.PAY_TYPE[index]%></option>
<%}%>
</select>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                  <tr id="TableCaption">
                    <td colspan=10><%=r.getString(teasession._nLanguage, "BillingAddress")%>
                  <tr>
                                    <TD> <%=r.getString(teasession._nLanguage, "Customer")%>:
                                    <td><%=teasession._rv.toString()%>
                  <tr>
    <TD><%=r.getString(teasession._nLanguage, "EmailAddress")%>:
                    <td><input type="TEXT" class="edit_input"  name=bEmail value=<%=s3%> size=40 maxlength=40>
   <tr>
         <TD><%=r.getString(teasession._nLanguage, "FirstName")%>:</TD>
         <td><input type="TEXT" class="edit_input"  name=bFirstName value="<%=s4%>" size=20 maxlength=20>
           <%=r.getString(teasession._nLanguage, "LastName")%>:
           <input type="TEXT" class="edit_input"  name=bLastName value="<%=s5%>" size=20 maxlength=20></td>
   </tr>
       <tr>
         <TD><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
         <td><input type="TEXT" class="edit_input"  name=bOrganization value="<%=s6%>" size=40 maxlength=40></td>
       </tr>
       <tr>
         <TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
         <td><textarea name=bAddress rows=2 cols=40><%=HtmlElement.htmlToText(s7)%></textarea></td>
       </tr>
       <tr>
         <TD><%=r.getString(teasession._nLanguage, "City")%>:</TD>
         <td><input type="TEXT" class="edit_input"  name=bCity value="<%=s8%>" size=20 maxlength=20>
           <%=r.getString(teasession._nLanguage, "State")%>:
           <select name="bState">
             <option value="">--------------</option>
             <%
             for(int bstate_i=0;bstate_i<Common.PROVINCE.length;bstate_i++)
             {
               out.print("<option value="+Common.PROVINCE[bstate_i]);
               if(Common.PROVINCE[bstate_i].equals(s9))
               {
                 out.print(" SELECTED ");
               }
               out.print(" >"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[bstate_i]));
             }
             %>
             </select>

         </td>
       </tr>
       <tr>
         <TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
         <td><input type="TEXT" class="edit_input"  name=bZip value="<%=s10%>" size=20 maxlength=20>
           <%=r.getString(teasession._nLanguage, "Country")%>:
           <%=new tea.htmlx.CountrySelection("bCountry",s11,teasession._nLanguage)%></td>
       </tr>
       <tr>
         <TD><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
         <td><input type="TEXT" class="edit_input"  name=bTelephone value="<%=s12%>" size=20 maxlength=20>
           <%=r.getString(teasession._nLanguage, "Fax")%>:
           <input type="TEXT" class="edit_input"  name=bFax value="<%=s13%>" size=20 maxlength=20></td>
       </tr>
</table>
                         <input  id="CHECKBOX" type="CHECKBOX" name=TradeOUpdateProfile value=null>
                         <%=r.getString(teasession._nLanguage, "TradeOUpdateProfile")%>
                         <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                           <tr id="TableCaption">
                             <td colspan=10><%=r.getString(teasession._nLanguage, "ShippingAddress")%></td>
                           </tr>
                           <tr>
                             <TD><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
                             <td><input type="TEXT" class="edit_input"  name=sEmail value="<%=s3%>" size=40 maxlength=40></td>
                           </tr>
                           <tr>
                             <TD><%=r.getString(teasession._nLanguage, "FirstName")%>:</TD>
                             <td><input type="TEXT" class="edit_input"  name=sFirstName value="<%=s4%>" size=20 maxlength=20>
                                 <%=r.getString(teasession._nLanguage, "LastName")%>:
     <input type="TEXT" class="edit_input"  name=sLastName value="<%=s5%>" size=20 maxlength=20></td>
                           </tr>
                                   <tr>
 <TD><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
 <td><input type="TEXT" class="edit_input"  name=sOrganization value="<%=s6%>" size=40 maxlength=40></td>
                                   </tr>
                                   <tr>
 <TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
 <td><textarea name=sAddress rows=2 cols=40><%=HtmlElement.htmlToText(s7)%></textarea></td>
                                   </tr>
                                   <tr>
 <TD><%=r.getString(teasession._nLanguage, "City")%>:</TD>
 <td><input type="TEXT" class="edit_input"  name=sCity value="<%=s8%>" size=20 maxlength=20>
     <%=r.getString(teasession._nLanguage, "State")%>:

            <select name="sState">
             <option value="">--------------</option>
             <%

             for(int bstate_i=0;bstate_i<Common.PROVINCE.length;bstate_i++)
             {
               out.print("<option value="+Common.PROVINCE[bstate_i]);
               if(Common.PROVINCE[bstate_i].equals(s9))
               {
                 out.print(" SELECTED ");
               }
               out.print(" >"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[bstate_i]));
             }
             %>
             </select>

 </td>
                                   </tr>
                                   <tr>
 <TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
 <td><input type="TEXT" class="edit_input"  name=sZip value="<%=s10%>" size=20 maxlength=20>
     <%=r.getString(teasession._nLanguage, "Country")%>:

     <%
    for (int scountry_i = 0; scountry_i <= tea.htmlx.CountrySelection.COUNTRY_TYPE.length; scountry_i++)
    {
      if(scountry_i==tea.htmlx.CountrySelection.COUNTRY_TYPE.length)
      {
        out.print(s11);
      }else
      if (tea.htmlx.CountrySelection.COUNTRY_TYPE[scountry_i].equals(s11))
      {
        out.print( r.getString(teasession._nLanguage,"Country."+tea.htmlx.CountrySelection.COUNTRY_TYPE[scountry_i]));
        break;
      }
    }
%>

 </td>
                                   </tr>
                                   <tr>
 <TD><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
 <td><input type="TEXT" class="edit_input"  name=sTelephone value="<%=s12%>" size=20 maxlength=20>
     <%=r.getString(teasession._nLanguage, "Fax")%>:
     <input type="TEXT" class="edit_input"  name=sFax value="<%=s13%>" size=20 maxlength=20></td>
                                   </tr>
</table>
                                 <input  id="CHECKBOX" type="CHECKBOX" name=TradeOShipToBilling value=null checked>
                                 <%=r.getString(teasession._nLanguage, "TradeOShipToBilling")%>
                                 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                                   <tr>
 <TD><%=r.getString(teasession._nLanguage, "Voice")%>:</TD>
 <td colspan=6><input type="file" name="Voice" class="edit_input"/>
     <input  id="CHECKBOX" type="CHECKBOX" name="ClearVoice" value=null>
     <%=r.getString(teasession._nLanguage, "Clear")%> <a href="/tea/html/0/recorder.html" target="_blank"><%=r.getString(teasession._nLanguage, "Record")%></a></td>
                                   </tr>
                                   <tr>
 <TD><%=r.getString(teasession._nLanguage, "Remark")%>:</TD>
 <td><textarea name=Remark rows=6 cols=60></textarea></td>
                                   </tr>
                                 </table>
                                 <input type=SUBMIT value="<%=r.getString(teasession._nLanguage, "Continue")%>"> </form>
                           </DIV>
<script>document.foCheckout.bEmail.focus();</script>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
<DIV><table cellspacing="0" class="section"><tr><form name=foCheckout method=POST action="/servlet/CheckoutCart3" enctype=multipart/form-data onSubmit="return(submitEmail(this.bEmail,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitText(this.bFirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')&&submitText(this.bLastName,'<%=r.getString(teasession._nLanguage, "InvalidLastName")%>')&&submitText(this.bAddress,'<%=r.getString(teasession._nLanguage, "InvalidAddress")%>')&&submitText(this.bCity,'<%=r.getString(teasession._nLanguage, "InvalidCity")%>')&&submitText(this.bState,'<%=r.getString(teasession._nLanguage, "InvalidState")%>')&&submitText(this.bCountry,'<%=r.getString(teasession._nLanguage, "InvalidCountry")%>')&&submitText(this.bTelephone,'<%=r.getString(teasession._nLanguage, "InvalidTelephone")%>'));"></form>
</tr></table>
<div id="head6"><img height="6"></div>
</body>
</HTML>
