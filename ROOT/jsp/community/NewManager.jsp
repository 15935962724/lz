<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/member/community/Communities");
String s = request.getParameter("Community");
            if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
            {
                response.sendError(403);
                return;
            }
%>


<html><head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script></head>
<body>

<h1><%=r.getString(teasession._nLanguage, "CBNewAdmin")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"><tr><td>
<FORM name=foNew METHOD=POST action="/servlet/NewManager" onSubmit="return(submitText(this.Members,'<%=r.getString(teasession._nLanguage, "InvalidMemberIds")%>'));">
<input type='hidden' name=Community VALUE="<%=s%>"><%=r.getString(teasession._nLanguage, "MemberId")%>:
<input type="TEXT" class="edit_input"  name=Members>
<%=r.getString(teasession._nLanguage, "Community")%>:<input type='text' name=cmember VALUE="<%=s%>">
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></FORM>
<SCRIPT>document.foNew.Members.focus();</SCRIPT>
</td></tr></table>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>


