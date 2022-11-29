<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>



<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "TradeInvoiceInc")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">

       <%
int i =Integer.parseInt(request.getParameter("Trade"));
int j=teasession._nLanguage;
RV rv=teasession._rv;
   /* public void originalInvoice( int i, int j)
        throws Exception
    {*/
        Trade trade = Trade.find(i);
        RV rv1 = trade.getVendor();
        RV rv2 = trade.getCustomer();
        java.util.Date date = trade.getTime();
        int k = trade.getType();
        int l = trade.getStatus();
        String s = trade.getbEmail();
        String s1 = trade.getbFirstName(j);
        String s2 = trade.getbLastName(j);
        String s3 = RequestHelper.makeName(j, s1, s2);
        String s4 = trade.getbOrganization(j);
        String s5 = trade.getbAddress(j);
        String s6 = trade.getbCity(j);
        String s7 = trade.getbState(j);
        String s8 = trade.getbZip();
        String s9 = trade.getbCountry(j);
        String s10 = trade.getbTelephone(j);
        String s11 = trade.getbFax(j);
        String s12 = trade.getsEmail();
        String s13 = trade.getsFirstName(j);
        String s14 = trade.getsLastName(j);
        String s15 = RequestHelper.makeName(j, s13, s14);
        String s16 = trade.getsOrganization(j);
        String s17 = trade.getsAddress(j);
        String s18 = trade.getsCity(j);
        String s19 = trade.getsState(j);
        String s20 = trade.getsZip();
        String s21 = trade.getsCountry(j);
        String s22 = trade.getsTelephone(j);
        String s23 = trade.getsFax(j);
        int i1 = trade.getCurrency();
        int j1 = trade.getShipping();
        String s24 = trade.getShippingText(j);
        BigDecimal bigdecimal = trade.getSh();
        BigDecimal bigdecimal1 = trade.getTax();
       // int k1 = trade.getCoupon();
        String s25 = trade.getCouponText(j);
        BigDecimal bigdecimal2 = trade.getDiscount();
        String s26 = trade.getCText(j);
        boolean flag = trade.getCVoiceFlag();
        String s27 = trade.getVText(j);
        boolean flag1 = trade.getVVoiceFlag();
        Table table = new Table();
        BigDecimal bigdecimal3 = new BigDecimal(0.0D);
        String s28 = r.getString(j, Common.CURRENCY[i1]);
        String s29 = r.getString(teasession._nLanguage, Common.CURRENCY[1]);if(s29==null)s29="";
        boolean flag2 = trade.isCustomer(rv);
        boolean flag3 = trade.isVendor(rv);
        boolean flag4 = flag2 && (l == 0 || l == 3 || l == 5);
        boolean flag5 = flag3 && l != 1 && l != 5 && l != 9 && l != 8;
       // boolean flag6 = true;
        if(flag2)
            trade.customerRead();
        if(flag3)
            trade.vendorRead();
%>

<div id="PathDiv"><%=ts.hrefGlance(teasession._rv)%> ><%
if(flag2){%>
<A href="/servlet/PurchaseOrders"><%=r.getString(teasession._nLanguage, "PurchaseOrders")%></A>
><A href="/servlet/PurchaseOrders?type=<%=j%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])%></A>
><A href="/servlet/PurchaseOrders?type=<%=j%>&Status=<%=k%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k])%></A> >#<%=i%>
<%}else{%>
<A href="/servlet/SaleOrders"><%=r.getString(teasession._nLanguage, "SaleOrders")%></A>
><A href="/servlet/SaleOrders?type=<%=j%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])%></A>
><A href="/servlet/SaleOrders?type=<%=j%>&Status=<%=k%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k])%></A> >#<%=i%>
<%}%>




 <%        if(flag2)
            {
//if(i!=null)
%>				<jsp:include page="Trade_Table1.jsp"/>
<%              if(flag4)
                {%>
                	<FORM name=foEdit METHOD=POST action="/servlet/EditPurchaseOrder" ENCtype=multipart/form-data onSubmit="return(submitEmail(this.bEmail,'<%= r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitText(this.bFirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')&&submitText(this.bLastName,'<%=r.getString(teasession._nLanguage, "InvalidLastName")%>')&&submitText(this.bAddress,'<%=r.getString(teasession._nLanguage, "InvalidAddress")%>')&&submitText(this.bCity,'<%=r.getString(teasession._nLanguage, "InvalidCity")%>')&&submitText(this.bState,'<%=r.getString(teasession._nLanguage, "InvalidState")%>')&&submitText(this.bCountry,'<%=r.getString(teasession._nLanguage, "InvalidCountry")%>')&&submitText(this.bTelephone,'<%=r.getString(teasession._nLanguage, "InvalidTelephone")%>')&&confirm('<%=r.getString(teasession._nLanguage, "ConfirmProcessOrder")%>'));">
                	<jsp:include page="Trade_Table2.jsp"/>
                	<input  id="CHECKBOX" type="CHECKBOX" name=ShipToBilling value=null><%=r.getString(teasession._nLanguage, "TradeOShipToBilling")%>
                	<jsp:include page="Trade_Table3.jsp"/>
                        <%@include file="Trade_Table.jsp" %>
                	<%//jsp:include page="Trade_Table.jsp"/%>
	               	<jsp:include page="Trade_Table4.jsp"/>
                	<jsp:include page="Trade_Table5.jsp"/>
                	<br/>
					</FORM>
<%               } else
                {%>
                    <jsp:include page="Trade_Table2.jsp"/>
<%                //   if(table3 != null)
                    {%><jsp:include page="Trade_Table3.jsp"/>
                    <%}%>
                    <jsp:include page="Trade_Table.jsp"/>
                    <jsp:include page="Trade_Table4.jsp"/>
                    <jsp:include page="Trade_Table5.jsp"/>
           <% }%>
			<%=r.getString(j, "LastUpdate") + ":" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date) + ""%>
<%          } else
            if(flag5)
            {%>
                    <jsp:include page="Trade_Table2.jsp"/>
<%                 // if(table3 != null)
                    {%><jsp:include page="Trade_Table3.jsp"/>
                  <%}%>

                <FORM name=foProcess METHOD=POST action="/servlet/ProcessSaleOrder" ENCtype=multipart/form-data >
                <input type='hidden' name=Trade VALUE="<%=i%>">
				<jsp:include page="Trade_Table.jsp"/>
				<jsp:include page="Trade_Table4.jsp"/>
				<jsp:include page="Trade_Table5.jsp"/>
                <br/></form>
<%          } else
            {%><jsp:include page="Trade_Table2.jsp"/>
<%            //  if(table3 != null)
                    {%><jsp:include page="Trade_Table3.jsp"/>
                  <%}%>
				<%@include file="Trade_Table.jsp"%><%--  <jsp:include page="Trade_Table.jsp"/>--%>
				<jsp:include page="Trade_Table4.jsp"/>
				<jsp:include page="Trade_Table5.jsp"/>
<%          }%>
            <%--=r.getString(teasession._nLanguage, "LastUpdate")%>:<%=(new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date)%>--%>



<%! // }

    public static final String TRADEINVOICE_FORMAT[] = {
        " 0", " 1", " 2", " 3"
    };
    public static final int TRADEINVOICEF_0ORIGINAL = 0;
    public static final int TRADEINVOICEF_1 = 1;
    public static final int TRADEINVOICEF_2 = 2;
    public static final int TRADEINVOICEF_3 = 3;
%>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

