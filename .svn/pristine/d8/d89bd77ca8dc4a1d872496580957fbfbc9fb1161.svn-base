<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%r.add("/tea/ui/member/profile/NewCouponMembers");
int i = Integer.parseInt( request.getParameter("Coupon"));
            Coupon coupon = Coupon.find(i);
            if(!coupon.getMember().equals(teasession._rv._strR) || !teasession._rv.isAccountant())
            {
                 response.sendError(403);
                return;
            }
%>







<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "NewCouponMembers")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">

<FORM name=foNew METHOD=POST action="/servlet/NewCouponMembers" onSubmit="return(submitText(this.Members,'<%=r.getString(teasession._nLanguage, "InvalidCouponMembers")%>'));">
<input type='hidden' name=Coupon VALUE="<%=i%>">
<%=r.getString(teasession._nLanguage, "MemberIds")%>:
<input type="TEXT" class="edit_input"  name=Members>
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
<SCRIPT>document.foNew.Members.focus();</SCRIPT>
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>


<%----%></body>
</html>

