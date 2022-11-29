<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/ui/member/profile/ProfileServlet").add("/tea/ui/member/profile/Shippings").add("/tea/ui/member/profile/EditShipping");

String sql=" AND member="+DbAdapter.cite(teasession._rv._strR);

int i = Shipping.count(teasession._strCommunity,sql);


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
<h1><%=i+" "+r.getString(teasession._nLanguage, "Shippings")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="PathDiv">
<A href="/servlet/Glance?Member=<%=teasession._rv%>" TARGET="_blank"><%=teasession._rv%></A> >
<A href="/servlet/Profile"><%=r.getString(teasession._nLanguage, "Profile")%></A> ><%=r.getString(teasession._nLanguage, "Shippings")%></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
if(i != 0)
{%>
<tr  id="tableonetr"><TD><%=r.getString(teasession._nLanguage, "Name")%></TD>
  <TD><%=r.getString(teasession._nLanguage, "Currency")%></TD>
<%--  <TD><%=r.getString(teasession._nLanguage, "Options")%></TD> --%>
  <TD><%=r.getString(teasession._nLanguage, "PerShipment")%></TD>
  <TD><%=r.getString(teasession._nLanguage, "PerItem")%></TD>
  <TD><%=r.getString(teasession._nLanguage, "TaxRate")%></TD>
  <TD><%=r.getString(teasession._nLanguage, "PayMethod")%></TD><td></td></tr>
  <%
  for(Enumeration enumeration = Shipping.find(teasession._strCommunity,sql); enumeration.hasMoreElements(); )
  {
    int j = ((Integer)enumeration.nextElement()).intValue();
    Shipping shipping = tea.entity.member.Shipping.find(j);
    int k = shipping.getCurrency();
    int l = shipping.getOptions();
    %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><%=shipping.getName(teasession._nLanguage)%></td>
<td><%=r.getString(teasession._nLanguage, Common.CURRENCY[k])%></td>
<%--
<td>
			<%if((l & 2) != 0)
					{%>
                       <%=r.getString(teasession._nLanguage, "ShippingOPercentage")%>
					<%}
					if((l & 1) != 0)
					{%>
<%=r.getString(teasession._nLanguage, "ShippingOTax")%>
					<%}%>
--%>
<td><%=shipping.getPerShipment()%></td>
<td><%=shipping.getPerItem()%></td>
<td><%=shipping.getTaxRate()%></td>
<td><%=r.getString(teasession._nLanguage, Shipping.PAYMETHOD[k][shipping.getPayMethod()])%></td>


                   <%if(teasession._rv.isAccountant())
                    {%>
<td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/servlet/EditShipping?Shipping=<%=j%>', '_self');">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteShipping?Shipping=<%=j%>', '_self'); this.disabled=true; }"></td>
<%                    }
                }
}
%>
</table><br/>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/servlet/EditShipping', '_self');">
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

