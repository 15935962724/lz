<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


if(!teasession._rv.isReal())
{
  response.sendError(403);
  return;
}
Resource r=new Resource("/tea/ui/member/profile/CancelMembership");


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



<h1><%=r.getString(teasession._nLanguage, "CancelMembership")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td><%=r.getString(teasession._nLanguage, "InfCancelMembership")%>
<FORM name=foCancel METHOD=POST action="/servlet/CancelMembership" onSubmit="return(confirm('<%=r.getString(teasession._nLanguage, "ConfirmCancelMembership")%>'));">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<%=r.getString(teasession._nLanguage, "Password")%>:
<input type="password" class="edit_input" name="Password">
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>

<SCRIPT>document.foCancel.Password.focus();
</SCRIPT>

</td></tr></table>

<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

