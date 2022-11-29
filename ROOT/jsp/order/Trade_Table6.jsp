<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.http.*"%><%@ page import="tea.entity.node.*"%>
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

            int i = Integer.parseInt(request.getParameter("Trade"));
            Trade trade = Trade.find(i);
            RV rv = trade.getVendor();
            RV rv1 = trade.getCustomer();
            java.util.Date date = trade.getTime();
            int j = trade.getType();
            int k = trade.getStatus();
            String s = trade.getbEmail();
            String s1 = trade.getbFirstName(teasession._nLanguage);
            String s2 = trade.getbLastName(teasession._nLanguage);
            String s3 = RequestHelper.makeName(teasession._nLanguage, s1, s2);
            String s4 = trade.getbOrganization(teasession._nLanguage);
            String s5 = trade.getbAddress(teasession._nLanguage);
            String s6 = trade.getbCity(teasession._nLanguage);
            String s7 = trade.getbState(teasession._nLanguage);
            String s8 = trade.getbZip();
            String s9 = trade.getbCountry(teasession._nLanguage);
            String s10 = trade.getbTelephone(teasession._nLanguage);
            String s11 = trade.getbFax(teasession._nLanguage);
            String s12 = trade.getsEmail();
            String s13 = trade.getsFirstName(teasession._nLanguage);
            String s14 = trade.getsLastName(teasession._nLanguage);
            String s15 = RequestHelper.makeName(teasession._nLanguage, s13, s14);
            String s16 = trade.getsOrganization(teasession._nLanguage);
            String s17 = trade.getsAddress(teasession._nLanguage);
            String s18 = trade.getsCity(teasession._nLanguage);
            String s19 = trade.getsState(teasession._nLanguage);
            String s20 = trade.getsZip();
            String s21 = trade.getsCountry(teasession._nLanguage);
            String s22 = trade.getsTelephone(teasession._nLanguage);
            String s23 = trade.getsFax(teasession._nLanguage);
            int l = trade.getCurrency();
            int i1 = trade.getShipping();
            String s24 = trade.getShippingText(teasession._nLanguage);
            BigDecimal bigdecimal = trade.getSh();
            BigDecimal bigdecimal1 = trade.getTax();
            int j1 = trade.getCoupon();
            String s25 = trade.getCouponText(teasession._nLanguage);
            BigDecimal bigdecimal2 = trade.getDiscount();
            String s26 = trade.getCText(teasession._nLanguage);
            boolean flag = trade.getCVoiceFlag();
            String s27 = trade.getVText(teasession._nLanguage);
            boolean flag1 = trade.getVVoiceFlag();
            BigDecimal bigdecimal3 = new BigDecimal(0.0D);
            String s28 = r.getString(teasession._nLanguage, Common.CURRENCY[l]);
            String s29 = r.getString(teasession._nLanguage, Common.CURRENCY[1]);
            boolean flag2 = trade.isCustomer(teasession._rv);
            boolean flag3 = trade.isVendor(teasession._rv);
            boolean flag4 = flag2 && (k == 0 || k == 3 || k == 5);
            boolean flag5 = flag3 && k != 1 && k != 5 && k != 9 && k != 8;
            if(flag2)
                trade.customerRead();
            if(flag3)
                trade.vendorRead();

%>
<link href="/tea/CssJs/<%//=node.getCommunity()%>.css" rel="stylesheet" type="text/css">








<table cellpadding="0" cellspacing="0" class="section">
<%          if(flag3 && (k == 2 || k == 5))
            {%>
                <FORM name=foDataOutput METHOD=POST action="/servlet/TradeDataOutput" >
				<input type='hidden' name=Trade VALUE="<%=i%>">
				<tr><td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBDataOutput")%>" ID="CBDataOutput" CLASS="CB" onClick="">
<%              DropDown dropdown = new DropDown("Method", r.getString(teasession._nLanguage, "TradeDataOutputMethodDefault"));
                dropdown.addOption("-1", r.getString(teasession._nLanguage, "None"));
                for(int l4 = 0; l4 < TradeDataOutput.TRADEDATAOUTPUT_METHOD.length; l4++)
                    dropdown.addOption(l4, r.getString(teasession._nLanguage, TradeDataOutput.TRADEDATAOUTPUT_METHOD[l4]));%>

               <%=dropdown%></FORM>
<%          }%>
			<FORM name=foInvoice METHOD=POST action="/servlet/TradeInvoice" Target="_blank">
			<input type='hidden' name=Trade VALUE="<%=i%>">

<%  System.out.println(i);        DropDown dropdown1 = new DropDown("InvoiceFormat", r.getString(teasession._nLanguage, "TradeInvoiceFormatDefault"));
            for(int i5 = 0; i5 < TradeInvoice.TRADEINVOICE_FORMAT.length; i5++)
                dropdown1.addOption(i5, r.getString(teasession._nLanguage, TradeInvoice.TRADEINVOICE_FORMAT[i5]));%>
            <tr><td><input type=submit VALUE="<%=r.getString(teasession._nLanguage, "CBInvoice")%>" ID="CBInvoice" CLASS="CB" onClick="">
			<%=dropdown1%>
</form>
</td></tr></table>

