<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();



tea.entity.member.SClient sc=tea.entity.member.SClient.find(teasession._strCommunity,teasession._rv._strV);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function flen(obj,text)
{
  if(obj.value<1||obj.value>1000)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
</head>

<body onload="form1.code.focus();">
<h1>充值</h1>
<div id="head6"><img height="6" alt=""></div>
<h2>充值</h2>
<form action="/servlet/EditCode" method="get" name="form1" onSubmit="return(submitText(this.code,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Code")%>')&&submitText(this.password,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&submitText(this.validate,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Validate")%>'));">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>卡号</td>
<td><input name="code" type="text" id="code" size="30" onkeyup="this.value=this.value.toString().toUpperCase()" style="text-transform:uppercase;"></td></tr>
<tr><td>密码</td>
<td><input name="password" type="text" id="password" size="30" onkeyup="this.value=this.value.toString().toUpperCase()" style="text-transform:uppercase;"></td>
</tr>
<tr><td>验证码</td>
<td><input name="validate" type="text" id="validate"><img  align="absmiddle" src="/jsp/user/validate.jsp?.jpg"/>
</td>
</tr>
<tr><td colspan="2" ><input name="" type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"><input name="" type="reset" value="<%=r.getString(teasession._nLanguage,"Reset")%>">
</td>
</tr>
</table>
</form>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>余额:</td><td><%=sc.getPrice()%></td></tr>
<tr><td>积分:</td><td><%=sc.getPoint()%></td></tr>
<tr><td>有效期:</td><td>2007-05-16  已过期,单击<a href=/jsp/info/Succeed.jsp?info=<%=java.net.URLEncoder.encode("申请成功,请等待管理员批准","UTF-8")%> >这里</a>申请延期15天</td></tr>
</table>


<h2>充值记录</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr"><td>卡号</td>
<td>面值</td>
<td>时间</td>
<td></td>
</tr>
<%
int pos=0;
//java.util.Date time = new java.util.Date(Long.parseLong(request.getParameter("time")));
java.util.Enumeration enumer=Code.find(teasession._strCommunity,teasession._rv._strV,pos,Integer.MAX_VALUE);
while(enumer.hasMoreElements())
{
  Code obj=(Code)enumer.nextElement();
%>
<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
<td><%=obj.getSymbol()+obj.getCode()%></td>
<td><%=obj.getParvalue()%></td>
<td><%=obj.getTime2ToString()%></td>
</tr>
<%
}
%>
</table>
<div id="head6"><img height="6" alt=""></div>
</body>
</html>
