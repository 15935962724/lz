<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=teasession._strCommunity;

String members[]=request.getParameterValues("members");
if(members==null)
{
  return;
}

Calendar c=Calendar.getInstance();
c.set(1,c.get(1)+1);


%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Auditing")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="POST" action="/servlet/AuditingEnterprise">
<input type="hidden" name="community" value="<%=community%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>会员ID</td><td><%
    for(int i=0;i<members.length;i++)
    {
      out.print("<input type=hidden name=members value="+members[i]+"> "+members[i]);
    }
    %></td>
  </tr>
  <tr>
    <td>有效期</td><td><%=new TimeSelection("validity", c.getTime())%></td>
  </tr>
</table>
<input type="submit" value="提交"/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>
