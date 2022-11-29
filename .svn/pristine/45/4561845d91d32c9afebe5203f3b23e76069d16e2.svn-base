<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource("/tea/ui/member/profile/ProfileServlet");
r.add("/tea/ui/member/profile/Coupons");

String sql=" AND member="+DbAdapter.cite(teasession._rv._strR);
int i = Coupon.count(teasession._strCommunity,sql);

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
<h1><%=i%> <%=r.getString(teasession._nLanguage, "Coupons")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<div id="PathDiv">
<A href="/servlet/Glance?Member=<%=teasession._rv%>" TARGET="_blank"><%=teasession._rv%></A> >
<A href="/servlet/Profile"><%=r.getString(teasession._nLanguage, "Profile")%></A> ><%=r.getString(teasession._nLanguage, "Coupons")%></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"><%
if(i != 0)
{%>
<tr ID=tableonetr>
<TD><%=r.getString(teasession._nLanguage, "MemberId")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Name")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Currency")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Type")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Minimum")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Discount")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Code")%></TD>
<td></td>
</tr>
<%
for(Enumeration enumeration = Coupon.find(teasession._strCommunity,sql); enumeration.hasMoreElements();)
{
  int j = ((Integer)enumeration.nextElement()).intValue();
  Coupon coupon = Coupon.find(j);
  int k = coupon.getCurrency();
  int l = coupon.getType();
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td><%=coupon.getMemberx()%></td>
<td><%=coupon.getName(teasession._nLanguage)%></td>
<td><%=r.getString(teasession._nLanguage, Common.CURRENCY[k])%></td>
<td><%=r.getString(teasession._nLanguage, Coupon.COUPON_TYPE[l])%></td>
<td><%=coupon.getMinimum().toString()%></td>
<td><%=coupon.getDiscount().toString()%></td>
<td><%=coupon.getCode()%></td>
<%
                    if(teasession._rv.isAccountant())
                    {%>
<td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/servlet/EditCoupon?Coupon=<%=j%>', '_self');">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteCoupon?Coupon=<%=j%>', '_self');}"></td>
<!--td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBCouponMembers")%>" ID="CBCouponMembers" CLASS="CB" onClick="window.open('/servlet/CouponMembers?Coupon=<%=j%>', '_self');"></td--></tr><% }
                }
}
%>
</table><br/>
<%
if(teasession._rv.isAccountant())
{%>
		<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/servlet/EditCoupon', '_self');">
<%}%>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

