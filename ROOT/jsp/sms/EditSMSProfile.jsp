<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=request.getParameter("community");
if(community==null)
{
  community=node.getCommunity();
}
Profile profile=Profile.find(teasession._rv._strV);
SMSProfile smsprofile=SMSProfile.find(teasession._rv._strV,community);
boolean bool=smsprofile.isAutor()&&profile.isValidate();
r.add("/tea/resource/SMS");

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function fautor(bool)
{
  if(bool)
  {
    form1.GoNext.style.display="";
    form1.GoNext.disabled=false;

    form1.GoFinish.style.display="none";
    form1.GoFinish.disabled=true;
  }else
  {
    form1.GoFinish.style.display="";
    form1.GoFinish.disabled=false;

    form1.GoNext.style.display="none";
    form1.GoNext.disabled=true;
  }
}
function submitMobile(obj,text)
{
  if(isNaN(parseInt(obj.value))||obj.value.indexOf("13")!=0||obj.value.length!=11)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
</head>
<body onload="form2.mobile.focus();">
<h1><%=r.getString(teasession._nLanguage,"SetMobile")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form  name="form2" action="/servlet/EditSMSProfile" method="post" onsubmit="return submitMobile(this.mobile,'<%=r.getString(teasession._nLanguage,"InvalidTelephone")%>')">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="SetMobile" value="ON"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>

<TD><%=r.getString(teasession._nLanguage,"Number")%></TD>
<td><input name="mobile" type="text" id="mobile" value="<%=profile.getMobile()%>"></TD>
</tr>
</table>
<input name="GoNext"  type="submit" value="<%=r.getString(teasession._nLanguage,"CBNext")%>">
</form>


<h1><%=r.getString(teasession._nLanguage,"Autor")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form  name="form1" action="/servlet/EditSMSProfile" method="post">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<TD><%=r.getString(teasession._nLanguage,"Autor")%></TD>
<td><input name="autor"  id="radio" type="radio" value="false" onclick="" checked><%=r.getString(teasession._nLanguage, "Stop")%>
  <input name="autor"  id="radio" type="radio" value="true" onclick="" <% if(!profile.isValidate())out.print(" disabled ");else if(bool)out.print("checked");%>><%=r.getString(teasession._nLanguage, "Startup")%>
</td>
</tr>
</table>
<input name="SetAutor" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>" type="submit">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>注:</td></tr>
<tr><td>1.只有经过验证的手机才也可开启"自动回复".</td></tr>
</table>

</body>
</html>

