<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%--@ page import="tea.http.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%@ page import="tea.entity.member.Trade"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.resource.Common"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.ui.member.order.*"%>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();
TeaServlet ts=new TeaServlet();
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{response.sendRedirect("/servlet/StartLogin");
return;}--%>
<%
r.add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/SaleOrders").add("/tea/ui/member/order/TradeServlet").add("/tea/ui/member/offer/Offers");
            int i = Integer.parseInt(request.getParameter("Trade"));
            Trade trade = Trade.find(i);
            RV rv = trade.getVendor();
            RV rv1 = trade.getCustomer();
            java.util.Date date = trade.getTime();
            int j = trade.getType();
            int k = trade.getStatus();
            String s = trade.getbEmail();if(s==null)s="";
            String s1 = trade.getbFirstName(teasession._nLanguage);if(s1==null)s1="";
            String s2 = trade.getbLastName(teasession._nLanguage);if(s2==null)s2="";
            String s3 = RequestHelper.makeName(teasession._nLanguage, s1, s2);if(s3==null)s3="";
            String s4 = trade.getbOrganization(teasession._nLanguage);if(s4==null)s4="";
            String s5 = trade.getbAddress(teasession._nLanguage);if(s5==null)s5="";
            String s6 = trade.getbCity(teasession._nLanguage);if(s6==null)s6="";
            String s7 = trade.getbState(teasession._nLanguage);if(s7==null)s7="";
            String s8 = trade.getbZip();if(s8==null)s8="";
            String s9 = trade.getbCountry(teasession._nLanguage);if(s9==null)s9="";
            String s10 = trade.getbTelephone(teasession._nLanguage);if(s10==null)s10="";
            String s11 = trade.getbFax(teasession._nLanguage);if(s11==null)s11="";
            String s12 = trade.getsEmail();if(s12==null)s12="";
            String s13 = trade.getsFirstName(teasession._nLanguage);if(s13==null)s13="";
            String s14 = trade.getsLastName(teasession._nLanguage);if(s14==null)s14="";
            String s15 = RequestHelper.makeName(teasession._nLanguage, s13, s14);if(s15==null)s15="";
            String s16 = trade.getsOrganization(teasession._nLanguage);if(s16==null)s16="";
            String s17 = trade.getsAddress(teasession._nLanguage);if(s17==null)s17="";
            String s18 = trade.getsCity(teasession._nLanguage);if(s18==null)s18="";
            String s19 = trade.getsState(teasession._nLanguage);if(s19==null)s19="";
            String s20 = trade.getsZip();if(s20==null)s20="";
            String s21 = trade.getsCountry(teasession._nLanguage);if(s21==null)s21="";
            String s22 = trade.getsTelephone(teasession._nLanguage);if(s22==null)s22="";
            String s23 = trade.getsFax(teasession._nLanguage);
            if(s23==null)s23="";
            int l = trade.getCurrency();
            int i1 = trade.getShipping();
            String s24 = trade.getShippingText(teasession._nLanguage);
            if(s24==null)s24="";
            BigDecimal bigdecimal = trade.getSh();
            BigDecimal bigdecimal1 = trade.getTax();
            int j1 = trade.getCoupon();
            String s25 = trade.getCouponText(teasession._nLanguage);
            if(s25==null)s25="";
            BigDecimal bigdecimal2 = trade.getDiscount();
            String s26 = trade.getCText(teasession._nLanguage);
            if(s26==null)s26="";
            boolean flag = trade.getCVoiceFlag();
            String s27 = trade.getVText(teasession._nLanguage);if(s27==null)s27="";
            boolean flag1 = trade.getVVoiceFlag();
            BigDecimal bigdecimal3 = new BigDecimal(0.0D);
            String s28 = r.getString(teasession._nLanguage, Common.CURRENCY[l]);if(s28==null)s28="";
            String s29 = r.getString(teasession._nLanguage, Common.CURRENCY[1]);if(s29==null)s29="";
            boolean flag2 = trade.isCustomer(teasession._rv);
            boolean flag3 = trade.isVendor(teasession._rv);
            boolean flag4 = flag2 && (k == 0 || k == 3 || k == 5);
            boolean flag5 = flag3 && k != 1 && k != 5 && k != 9 && k != 8;
            if(flag2)
                trade.customerRead();
            if(flag3)
                trade.vendorRead( );

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
/HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage, "Trade_old")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <table id="BodyTable">
    <tr>
      <td><div id="PathDiv"><%=ts.hrefGlance(teasession._rv)%> >
              <%
if(flag2){%>
              <a href="/servlet/PurchaseOrders"><%=r.getString(teasession._nLanguage, "PurchaseOrders")%></a> ><a href="/servlet/PurchaseOrders?type=<%=j%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])%></a> ><a href="/servlet/PurchaseOrders?type=<%=j%>&Status=<%=k%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k])%></a> >#<%=i%>
              <%}else{%>
              <a href="/servlet/SaleOrders"><%=r.getString(teasession._nLanguage, "SaleOrders")%></a> ><a href="/servlet/SaleOrders?type=<%=j%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])%></a> ><a href="/servlet/SaleOrders?type=<%=j%>&Status=<%=k%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k])%></a> >#<%=i%>
              <%}%>
              <%          if(flag2)
            {
//if(i!=null)
%>
<%@include file="Trade_Table1_inc.jsp" %>             <!-- <jsp:include page="Trade_Table1.jsp"/>-->
              <%if(flag4)
                {%>
              <form name=foEdit method=POST action="/servlet/EditPurchaseOrder" enctype=multipart/form-data onSubmit="return(submitEmail(this.bEmail,'<%= r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitText(this.bFirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')&&submitText(this.bLastName,'<%=r.getString(teasession._nLanguage, "InvalidLastName")%>')&&submitText(this.bAddress,'<%=r.getString(teasession._nLanguage, "InvalidAddress")%>')&&submitText(this.bCity,'<%=r.getString(teasession._nLanguage, "InvalidCity")%>')&&submitText(this.bState,'<%=r.getString(teasession._nLanguage, "InvalidState")%>')&&submitText(this.bCountry,'<%=r.getString(teasession._nLanguage, "InvalidCountry")%>')&&submitText(this.bTelephone,'<%=r.getString(teasession._nLanguage, "InvalidTelephone")%>')&&confirm('<%=r.getString(teasession._nLanguage, "ConfirmProcessOrder")%>'));">
                <input type='hidden' name=Trade value="<%=i%>">
                <input type='hidden' name=Shipping value="<%=i1%>">
                <jsp:include page="Trade_Table2.jsp"/><!-- ///////////////////////////////////////////  -->
                <input  id="CHECKBOX" type="CHECKBOX" name=ShipToBilling value=null>
                <%=r.getString(teasession._nLanguage, "TradeOShipToBilling")%>
                <input  id="CHECKBOX" type="CHECKBOX" name=UpdateProfile value=null>
                <%=r.getString(teasession._nLanguage, "TradeOUpdateProfile")%>
                <jsp:include page="Trade_Table3.jsp"/><!-- ///////////////////////////////////////////  -->
        </div>
        <input type='hidden' name=Currency VALUE="<%=l%>">
          <%@ include file="Trade_Table.jsp" %>

          <jsp:include page="Trade_Table4.jsp"/>

          <jsp:include page="Trade_Table5.jsp"/>

                	<input  id="CHECKBOX" type="CHECKBOX" name=SendEmail value=null CHECKED><%=r.getString(teasession._nLanguage, "MsgOSendEmail")%>
                	<br/>
<%                  switch(k)
                    {
                    case 0: // '\0'%>
                    		<input  id="radio" type="radio" name=Status VALUE=0 CHECKED><%=r.getString(teasession._nLanguage, "NewOrder")%>
                    		<input  id="radio" type="radio" name=Status VALUE=1><%=r.getString(teasession._nLanguage, "CancelOrder")%>
                        <%break;

                    case 3: // '\003'%>
                    		<input  id="radio" type="radio" name=Status VALUE=4 CHECKED><%=r.getString(teasession._nLanguage, "Confirmed")%>
                    		<input  id="radio" type="radio" name=Status VALUE=1><%=r.getString(teasession._nLanguage, "CancelOrder")%>

                       <% break;

                    case 10: // '\n'%>
                    		<input  id="radio" type="radio" name=Status VALUE=1 ><%=r.getString(teasession._nLanguage, "CancelOrder")%>
                        <%break;

                    case 5: // '\005'%>
                    		<input  id="radio" type="radio" name=Status VALUE=6 ><%=r.getString(teasession._nLanguage, "Refund")%>
                        <%break;
                    }%>
                    <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></FORM>
<%               } else
                {%>
                    <jsp:include page="Trade_Table2.jsp"/>
<%                //   if(table3 != null)
                    {%><jsp:include page="Trade_Table3.jsp"/>
                    <%}%>
                    <jsp:include page="Trade_Table.jsp"/>
                    <jsp:include page="Trade_Table4.jsp"/>
                    <jsp:include page="Trade_Table5.jsp"/>
           <%   }
            } else
            if(flag5)
            {%>
                    <jsp:include page="Trade_Table2.jsp"/>
<%                 // if(table3 != null)
                    {%><jsp:include page="Trade_Table3.jsp"/>
                  <%}%>

                <FORM name=foProcess METHOD=POST action="/servlet/ProcessSaleOrder" ENCtype=multipart/form-data onSubmit="return(confirm('<%=r.getString(teasession._nLanguage, "ConfirmProcessOrder")%>'));">
                <input type='hidden' name=Trade VALUE="<%=i%>">
				<jsp:include page="Trade_Table.jsp"/>
				<jsp:include page="Trade_Table4.jsp"/>
				<jsp:include page="Trade_Table5.jsp"/>
				<input  id="CHECKBOX" type="CHECKBOX" name=SendEmail  checked><%=r.getString(teasession._nLanguage, "MsgOSendEmail")%>
                <br/>
<%              switch(k)
                {
                case 0: // '\0'
                case 4: // '\004'%>
                    <input  id="radio" type="radio" name=Status VALUE=10 CHECKED><%=r.getString(teasession._nLanguage, "Pending")%>
                    <input  id="radio" type="radio" name=Status VALUE=3 ><%=r.getString(teasession._nLanguage, "Reconfirm")%>
                    <input  id="radio" type="radio" name=Status VALUE=2 ><%=r.getString(teasession._nLanguage, "Unshipped")%>
                    <input  id="radio" type="radio" name=Status VALUE=1 ><%=r.getString(teasession._nLanguage, "CancelOrder")%>
<%                   break;
                case 3: // '\003'%>
                    <input  id="radio" type="radio" name=Status VALUE=10 CHECKED><%=r.getString(teasession._nLanguage, "Pending")%>
                    <input  id="radio" type="radio" name=Status VALUE=2 ><%=r.getString(teasession._nLanguage, "Unshipped")%>
                    <input  id="radio" type="radio" name=Status VALUE=1 ><%=r.getString(teasession._nLanguage, "CancelOrder")%>
<%                  break;
                case 10: // '\n'%>
                    <input  id="radio" type="radio" name=Status VALUE=3 ><%=r.getString(teasession._nLanguage, "Reconfirm")%>
                    <input  id="radio" type="radio" name=Status VALUE=2 ><%=r.getString(teasession._nLanguage, "Unshipped")%>
                    <input  id="radio" type="radio" name=Status VALUE=1 ><%=r.getString(teasession._nLanguage, "CancelOrder")%>
<%                  break;
                case 2: // '\002'%>
                    <input  id="radio" type="radio" name=Status VALUE=5 ><%=r.getString(teasession._nLanguage, "ApprovedShipped")%>
                    <input  id="radio" type="radio" name=Status VALUE=1 ><%=r.getString(teasession._nLanguage, "CancelOrder")%>
                    <input  id="radio" type="radio" name=Status VALUE=6 ><%=r.getString(teasession._nLanguage, "Refund")%>
<%                  break;
                case 5: // '\005'%>
                    <input  id="radio" type="radio" name=Status VALUE=6 ><%=r.getString(teasession._nLanguage, "Refund")%>
<%                   break;
                case 6: // '\006'%>
                    <input  id="radio" type="radio" name=Status VALUE=7 ><%=r.getString(teasession._nLanguage, "PendingRefund")%>
                    <input  id="radio" type="radio" name=Status VALUE=8 ><%=r.getString(teasession._nLanguage, "IgnoredRefund")%>
                    <input  id="radio" type="radio" name=Status VALUE=9 ><%=r.getString(teasession._nLanguage, "ApprovedRefund")%>
<%                   break;
                case 7: // '\007'%>
                    <input  id="radio" type="radio" name=Status VALUE=8 ><%=r.getString(teasession._nLanguage, "IgnoredRefund")%>
                    <input  id="radio" type="radio" name=Status VALUE=9 ><%=r.getString(teasession._nLanguage, "ApprovedRefund")%>
    <%              break;
                case 1: // '\001'
                case 8: // '\b'
                case 9: // '\t'
                default:%>
					<input type='hidden' name=Status VALUE=<%=k%> >
<%                   break;
                }%>
                <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></FORM>
<%          } else
            {%><jsp:include page="Trade_Table2.jsp"/>
<%            //  if(table3 != null)
                    {%><jsp:include page="Trade_Table3.jsp"/>
                  <%}%>
				<jsp:include page="Trade_Table.jsp"/>
				<jsp:include page="Trade_Table4.jsp"/>
				<jsp:include page="Trade_Table5.jsp"/>
<%          }%>
            <%=r.getString(teasession._nLanguage, "LastUpdate")%>:<%=(new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date)%>
			<jsp:include page="Trade_Table6.jsp"/>

<%          int j5 = trade.getPrev(flag2, teasession._rv, j, k);
            if(j5 != 0)
			{%>
				<input type="button" value="<%=r.getString(teasession._nLanguage, "CBPrevious")%>" ID="CBPrevious" CLASS="CB" onClick="window.open('/servlet/Trade?Trade=<%=j5%>', '_self');">
<%			}
			int k5 = trade.getNext(flag2, teasession._rv, j, k);
            if(k5 != 0)
			{%>	<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNext")%>" ID="CBNext" CLASS="CB" onClick="window.open('/servlet/Trade?Trade=<%=k5%>', '_self');">
<%
</td></tr></table><%----%>			}%>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</b<div id="head6"><img height="6" src="about:blank"></div>
ody>
</html>

