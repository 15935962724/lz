<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


if(!teasession._rv.isAccountant())
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/ui/member/profile/EditShipping").add("/tea/ui/member/profile/EditShipping1");

int i = Integer.parseInt( request.getParameter("Shipping"));
Shipping shipping = Shipping.find(i);
int j = shipping.getCurrency();

tea.html.DropDown dropdown = new tea.html.DropDown("PayMethod", shipping.getPayMethod());

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
<h1><%=r.getString(teasession._nLanguage, "EditShipping")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<FORM name=foEdit METHOD=POST action="/servlet/EditShipping1">
<input type='hidden' name=Shipping VALUE="<%=Integer.toString(i)%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><TD><%=r.getString(teasession._nLanguage, "PayMethod") %>:</TD>
<td>
<SELECT name=PayMethod>
<%for(int l = 0; l < Shipping.PAYMETHOD[j].length; l++)
{%>
      <OPTION VALUE="<%=l%>"><%=r.getString(teasession._nLanguage, Shipping.PAYMETHOD[j][l])%></OPTION>
<%
}%>
</SELECT></td></tr><tr><TD><%=r.getString(teasession._nLanguage, "Parameters")%>:</TD>
<td>
<input type=PASSWORD name=Parameters VALUE="<%=shipping.getParameters()%>" MAXLENGTH=255 SIZE=20></td></tr></table>
<P ALIGN=CENTER>
<input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
</P>
</FORM>
<SCRIPT>document.foEdit.Parameters.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div>
</body>
</html>

