<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/member/profile/CouponMembers").add("/tea/ui/member/profile/ProfileServlet").add("/tea/ui/member/profile/Coupons");
int i = Integer.parseInt( request.getParameter("Coupon"));
Coupon coupon = Coupon.find(i);
if(!coupon.getMember().equals(teasession._rv._strR) || !teasession._rv.isAccountant())
{
  response.sendError(403);
  return;
}
String s =  request.getParameter("Pos");
int j = s == null ? 0 : Integer.parseInt(s);

int k = CouponMember.count(i);






	%>









<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=k%> <%=r.getString(teasession._nLanguage, "CouponMembers")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<div id="PathDiv">
<%=ts.hrefGlance(teasession._rv)%>>
<A href="/servlet/Profile"><%=r.getString(teasession._nLanguage, "Profile")%></A> >
<A href="/servlet/Coupons"><%=r.getString(teasession._nLanguage, "Coupons")%></A> ><%=r.getString(teasession._nLanguage, "CouponMembers")%></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"><%
if(k != 0)
{
      for(Enumeration enumeration = CouponMember.find(i, j, 25); enumeration.hasMoreElements();)
      {
                    String s1 = (String)enumeration.nextElement();
%>
<tr><td> <%=ts.hrefGlance(s1,teasession._strCommunity)%>
</td>

<td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteCouponMember?Coupon=<%=i%>&Member=<%=s1%>', '_self');}"></td></tr><%    }
}%>
</table>
<%=new FPNL(teasession._nLanguage, "/servlet/CouponMembers?Coupon=" + i + "&Pos=", j, k)%>
<br/>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/servlet/NewCouponMembers?Coupon=<%=i%>', '_self');">
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
<%----%></body>
</html>

