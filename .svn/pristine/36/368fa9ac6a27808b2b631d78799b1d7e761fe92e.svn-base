<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%!private String setFont(String strFont)
  {		return strFont.replaceAll("","").replaceAll("","");
	}
%>
<%
String s =  request.getParameter("Caller");
if(s == null)
	return;
String s1 =  request.getParameter("InviteToChat");
boolean flag = s1 != null;
r.add("/tea/ui/member/meeting/AnswerIn");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "AnswerIn")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><bgsound SRC="/tea/audio/ringin.au" loop=infinite>
      <FORM name=foAnswer METHOD=POST action="/servlet/AnswerIn">
      <input type='hidden' name=community VALUE="<%=node.getCommunity()%>">

        <%=RequestHelper.format(r.getString(teasession._nLanguage, "InfIncomingCall"), s)

%>
        <input type='hidden' name=Caller VALUE="<%=s%>">
        <%if(flag)
{%>
        <input type='hidden' name=InviteToChat VALUE="<%=s1%>">
        <%}%>
        <input type=SUBMIT class="edit_button" VALUE="<%=setFont(r.getString(teasession._nLanguage, "Accept"))%>">
        <input type=SUBMIT class="edit_button" name="Ignore" VALUE="<%=setFont(r.getString(teasession._nLanguage, "Ignore"))%>" onClick="window.close();">
      </FORM></td>
  </tr>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

