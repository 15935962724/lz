<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
String communityid = "DEV4";
String name = request.getParameter("name");
String password = request.getParameter("password");
if( name != null && password != null)
{
Communitymsn communiteymsn = new Communitymsn(communityid);
communiteymsn.create(communityid,name,password);
out.print("Congratulations!");
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="form1.name.focus();">
<h1>客服登陆</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<form name="form1" method="post" action="Communitymsn.jsp" onsubmit="">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<input type="hidden" name="msntemp" value="0"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<TR id="tableonetr">
<td width="1"><script type="">var index=0;</script></td>
</tr>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td width="1"><script type="">document.write(++index);</script></td>
  <!--
    两个 td
  -->
  <td>
  <!--两个 input-->
  </td>
</tr>
 </table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>用户名:</td>
<td>
  <input name="name"  onkeydown="onfocus();"  onfocus="if(this.style.color=='#999999')form1.password.focus();"  type="text" id="name" size="30">
</td>
</tr>
<tr>
  <td>密码:</td>
  <td>
    <input name="password" type="password" id="password" size="30">
  </td>
</tr>
<tr>
  <td>
    <input name="submit" type="submit" value="登陆"/>
  </td>
</tr>
</table>
</form>
<!--一个 input-->
<div id="head6"><img height="6" src="about:blank" alt=""></div><br />
<a href="https://accountservices.passport.net/reg.srf" target="_blank">注册新的MSN账号</a>
</body>
</html>
