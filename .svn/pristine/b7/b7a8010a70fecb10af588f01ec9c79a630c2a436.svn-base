<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%

r.add("/tea/ui/member/profile/EditCoupon");
if(!teasession._rv.isAccountant())
            {
              response.sendError(403);
              return;
            }
            String s =  request.getParameter("Coupon");
            boolean flag = s == null;
            int i = 0;
            int k = 0;
            int i1 = 0;
            BigDecimal bigdecimal = new BigDecimal(0.0D);
            BigDecimal bigdecimal2 = new BigDecimal(0.0D);
            String s1 = "";
            String s3 = "";
            String s5 = "";
            BigDecimal bank;
            String memberx;
                if(!flag)
                {
                    tea.entity.member.Coupon coupon =tea.entity.member. Coupon.find(Integer.parseInt(s));
                    i = coupon.getCurrency();
                    k = coupon.getType();
                    i1 = coupon.getOptions();
                    bigdecimal = coupon.getMinimum();
                    bigdecimal2 = coupon.getDiscount();
                    s1 = coupon.getCode();
                    s3 = coupon.getName(teasession._nLanguage);
                    s5 = coupon.getText(teasession._nLanguage);
                    memberx=coupon.getMemberx();
                    bank=coupon.getBank();
                }else
                {
                  memberx="";
                  bank = new BigDecimal(0.0D);
                }
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Edit")%><%=r.getString(teasession._nLanguage, "Coupon")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <FORM name=foEdit METHOD=POST action="/servlet/EditCoupon" onSubmit="return(submitFloat(this.Minimum,'<%=r.getString(teasession._nLanguage, "InvalidMinimum")%>')&&submitFloat(this.Discount,'<%=r.getString(teasession._nLanguage, "InvalidDiscount")%>')&&submitText(this.Code,'<%=r.getString(teasession._nLanguage, "InvalidCode")%>')&&submitText(this.Name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>')&&submitText(this.bank,'<%=r.getString(teasession._nLanguage, "InvalidBank")%>'));">
    <%if(!flag){%>
    <input type='hidden' name=Coupon VALUE="<%=s%>">
    <%}%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">      <%-- table.add(new CurrencySelection(teasession._nLanguage, i, false));--%>
      <%=
new CurrencySelection(teasession._nLanguage, i, false)
%>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Type")%>:</TD>
        <td><input  id="radio" type="radio" name=Type VALUE=0 <%=getCheck(k==0)%>>
          <%=r.getString(teasession._nLanguage, Coupon.COUPON_TYPE[0])%>
          <input  id="radio" type="radio" name=Type VALUE=1 <%=getCheck(k==1)%>>
          <%=r.getString(teasession._nLanguage, Coupon.COUPON_TYPE[1])%>
          <input  id="radio" type="radio" name=Type VALUE=2 <%=getCheck(k==2)%>>
          <%=r.getString(teasession._nLanguage, Coupon.COUPON_TYPE[2])%>
          <input  id="radio" type="radio" name=Type VALUE=3 <%=getCheck(k==3)%>>
          <%=r.getString(teasession._nLanguage, Coupon.COUPON_TYPE[3])%></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Options")%>:</TD>
        <td><input  id="CHECKBOX" type="CHECKBOX" name=CouponOAccess value=null <%=getCheck((i1 & 0x8000) != 0)%>>
          <%=r.getString(teasession._nLanguage, "CouponOAccess")%>
          <input  id="CHECKBOX" type="CHECKBOX" name=CouponOAd value=null <%=getCheck((i1 & 0x4000) != 0)%>>
          <%=r.getString(teasession._nLanguage, "CouponOAd")%>
          <input  id="CHECKBOX" type="CHECKBOX" name=CouponOBuy value=null <%=getCheck((i1 & 0x2000) != 0)%>>
          <%=r.getString(teasession._nLanguage, "CouponOBuy")%>
          <input  id="CHECKBOX" type="CHECKBOX" name=CouponOBid value=null <%=getCheck((i1 & 0x1000) != 0)%>>
          <%=r.getString(teasession._nLanguage, "CouponOBid")%>
          <input  id="CHECKBOX" type="CHECKBOX" name=CouponOBargain value=null <%=getCheck((i1 & 0x800) != 0)%>>
          <%=r.getString(teasession._nLanguage, "CouponOBargain")%></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Minimum")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Minimum VALUE="<%=bigdecimal%>"></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Discount")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Discount VALUE="<%=bigdecimal2%>"></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Code")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Code VALUE="<%=s1%>" SIZE=20 MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Name")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Name VALUE="<%=s3%>" SIZE=20 MAXLENGTH=255></td>
      </tr>
     <tr>
        <TD><%=r.getString(teasession._nLanguage, "MemberId")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=memberx VALUE="<%=memberx%>" SIZE=20 MAXLENGTH=255></td>
      </tr>
	       <tr>
        <TD><%=r.getString(teasession._nLanguage, "Bank")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=bank VALUE="<%=bank%>" SIZE=20 MAXLENGTH=255></td>
      </tr>
	   <tr>
        <TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
        <td><TEXTAREA name="Text" ROWS=8 COLS=60><%=HtmlElement.htmlToText(s5)%></TEXTAREA></td>
      </tr><tr><td></td><td>
    
    <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
 </td></tr></table>
  </FORM>
  <SCRIPT>document.foEdit.Text.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

