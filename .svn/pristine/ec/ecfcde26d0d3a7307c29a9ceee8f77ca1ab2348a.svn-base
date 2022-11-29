<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
String s =  request.getParameter("Receiver");
r.add("/tea/ui/member/meeting/DivertCall");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBNewMessageBoard")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%

            Object aobj[] = {
                s, "<A HREF=/servlet/NewMessage?receiver="+s+">"+r.getString(teasession._nLanguage, "ClickHere")+"</a>"

            };
            out.print(java.text.MessageFormat.format(r.getString(teasession._nLanguage, "InfNotAccept"), aobj));

%>
      </td>
    </tr>
  </table>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

