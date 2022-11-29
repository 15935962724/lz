<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/SMS");
String community=request.getParameter("community");
if(community==null)
community=node.getCommunity();
%>
<html>
<head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.subnumber.focus();">

<h1><%=r.getString(teasession._nLanguage,"SetMobile")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br/>
<form  name="form1" action="/servlet/EditSMSProfile" method="post" onsubmit="return submitText(this.subnumber,'<%=r.getString(teasession._nLanguage,"ConfirmCodeError")%>')&&submitText(this.password,'<%=r.getString(teasession._nLanguage,"ConfirmCodeError")%>')">
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="SetMobile" value="ON"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<TD><%=r.getString(teasession._nLanguage,"Subnumber")%></TD>
<td><input name="subnumber" type="text" id="validate" value=""></TD>
</tr>
<tr>
<TD><%=r.getString(teasession._nLanguage,"Password")%></TD>
<td><input name="password" type="text" id="validate" value="" onkeyup="this.value=this.value.toString().toUpperCase()" style="text-transform:uppercase;"></TD>
</tr>

</table>
<input name="GoFinish" value="<%=r.getString(teasession._nLanguage,"GoFinish")%>" type="submit">
</form>

<br>
<div id="head6"><img height="6" alt=""></div>
<br/>

