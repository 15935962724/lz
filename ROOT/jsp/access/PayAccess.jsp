<%@page contentType="text/html;charset=UTF-8" %><%@include file="/jsp/Header.jsp"%>

<%r.add("/tea/ui/node/access/PayAccess");
            int i = Integer.parseInt(request.getParameter("Currency"));
            BigDecimal bigdecimal = new BigDecimal(request.getParameter("Price"));
            Shipping shipping;

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<DIV ID="edit_Bodydiv">
<table cellspacing="0" class="section">
<tr><td>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<%=RequestHelper.format(r.getString(teasession._nLanguage, "InfConfirmPay"), r.getString(teasession._nLanguage, Common.CURRENCY[i]) + bigdecimal.toString())%>


<FORM name=foSelect METHOD=GET action="/servlet/PayAccess0">
<input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<input type='hidden' name=Currency VALUE="<%=i%>">
<input type='hidden' name=Price VALUE="<%=bigdecimal%>">
<%          for(Enumeration enumeration = Shipping.find(teasession._strCommunity," AND member="+DbAdapter.cite(node.getCreator()._strR), i, 32768); enumeration.hasMoreElements(); )
            {
                int j = ((Integer)enumeration.nextElement()).intValue();
                shipping = Shipping.find(j);%>
				<input  id="radio" type="radio" name=Shipping VALUE=<%=Integer.toString(j)%> checked><%=shipping.getName(teasession._nLanguage)%>
<%          }%>
<%=r.getString(teasession._nLanguage, "CouponCode")%>:
<input type="TEXT" class="edit_input"  name=CouponCode>

<input type=SUBMIT VALUE="<%=r.getString(teasession._nLanguage, "Continue").replaceAll("","").replaceAll("","")%>">
</FORM></td></tr></table></DIV>
<%----%></body>
</html>



