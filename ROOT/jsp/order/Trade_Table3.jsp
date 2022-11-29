﻿<%@page contentType="text/html;charset=UTF-8" %>
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
<linkhref="/tea/CssJs/<%//=node.getCommunity()%>.css" rel="stylesheet" type="text/css">









<%//*********************交货地址***********************表%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="TableCaption"><td COLSPAN=10><%=r.getString(teasession._nLanguage, "ShippingAddress")%></td></tr><%          if(flag2 && (k == 0 || k == 3 || k == 5))
            {%>
<tr><TD><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
<td COLSPAN=3><input type="TEXT" class="edit_input"  name=sEmail VALUE="<%=s12%>" SIZE=40 MAXLENGTH=40></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "FirstName")%>:</TD>
<td><input type="TEXT" class="edit_input"  name=sFirstName VALUE="<%=s13%>" SIZE=20 MAXLENGTH=20></td>
<TD><%=r.getString(teasession._nLanguage, "LastName")%>:</TD><td>
<input type="TEXT" class="edit_input"  name=sLastName VALUE="<%=s14%>" SIZE=20 MAXLENGTH=20></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
<td COLSPAN=3>
<input type="TEXT" class="edit_input"  name=sOrganization VALUE="<%=s16%>" SIZE=40 MAXLENGTH=40></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
<td COLSPAN=3><TEXTAREA name=sAddress COLS=40 ROWS=2 class="edit_input"><%=HtmlElement.htmlToText(s17)%></TEXTAREA></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "City")%>:</TD>
<td><input type="TEXT" class="edit_input"  name=sCity VALUE="<%=s18%>" SIZE=20 MAXLENGTH=20></td>
<TD><%=r.getString(teasession._nLanguage, "State")%>:</TD>
<td><input type="TEXT" class="edit_input"  name=sState VALUE="<%=s19%>" SIZE=20 MAXLENGTH=20></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
<td><input type="TEXT" class="edit_input"  name=sZip VALUE="<%=s20%>" SIZE=20 MAXLENGTH=20></td>
<TD><%=r.getString(teasession._nLanguage, "Country")%>:</TD>
<td><input type="TEXT" class="edit_input"  name=sCountry VALUE="<%=s21%>" SIZE=20 MAXLENGTH=20></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
<td><input type="TEXT" class="edit_input"  name=sTelephone VALUE="<%=s22%>" SIZE=20 MAXLENGTH=20></td>
<TD><%=r.getString(teasession._nLanguage, "Fax")%>:</TD>
<td><input type="TEXT" class="edit_input"  name=sFax VALUE="<%=s23%>" SIZE=20 MAXLENGTH=20></td></tr></table>
<%
} else{%>
<tr><TD><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
<td COLSPAN=3><%=s12%></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "FirstName")%>:</TD>
<td><%=s13%></td>
<TD><%=r.getString(teasession._nLanguage, "LastName")%>:</TD><td>
<%=s14%></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
<td COLSPAN=3>
<%=s16%></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
<td COLSPAN=3><%=s17%></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "City")%>:</TD>
<td><%=s18%></td>
<TD><%=r.getString(teasession._nLanguage, "State")%>:</TD>
<td><%=s19%></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
<td><%=s20%></td>
<TD><%=r.getString(teasession._nLanguage, "Country")%>:</TD>
<td><%=s21%></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
<td><%=s22%></td>
<TD><%=r.getString(teasession._nLanguage, "Fax")%>:</TD>
<td><%=s23%></td></tr></table>
<%}%>

