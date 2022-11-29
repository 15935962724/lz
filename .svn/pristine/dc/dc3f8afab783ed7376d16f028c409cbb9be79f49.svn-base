<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String act = teasession.getParameter("act");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
</head>
<script>

function f_sub()
{
	
	var ck = document.getElementsByName("iswmember"); 
	var flat = -1;
	for(var i = 0; i < ck.length; i++) {
		if(ck[i].checked) {
			flat = ck[i].value;
		}
	}	
	if(flat==-1)
	{
		alert("请选择是否注册为履友选项");
		return false;
	}
	else if(flat==0)
	{
		parent.f_wcj('0');
		return false;
	}else if(flat==1)
	{
		parent.f_wcj('1');
		return false;
	}
	
}
function f_sub2()
{
	var ck = document.getElementsByName("iswmember"); 
	var flat = -1;
	for(var i = 0; i < ck.length; i++) {
		if(ck[i].checked) {
			flat = ck[i].value;
		}
	}	
	if(flat==-1)
	{
		alert("请选择是否升级为履友选项");
		return false;
	}
	else if(flat==0)
	{//是 
		parent.f_wcj('3');
		return false;
	}else if(flat==1)
	{//否
		parent.f_wcj('4');
		return false;
	}
}
</script>
<body class="pop_up">



<form name="form_wcj" method="POST" action="?" >
<%
	if("0".equals(act)){
		//登录以后，不是履友会员的提示
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
      <td >是否升级为履友：
      <input type="radio" name="iswmember" value="0">&nbsp;是&nbsp;&nbsp;
      <input type="radio" name="iswmember" value="1">&nbsp;否&nbsp;&nbsp;
      </td>
     
    </tr>
     <tr>
      <td >注：注册为履友会员后，可获取积分，换取礼品，并可参加履友联盟组织的活动. </td>
    </tr>
    
  </table>
<br>
  <center>
 
  <INPUT TYPE=button ID="submit1" class="edit_button" VALUE="确认" onClick="f_sub2();">&nbsp;
  <INPUT TYPE=button  class="edit_button" VALUE="关闭" onClick="parent.ymPrompt.close();">&nbsp;
</center>



<%}else{//没有登录提示的 %>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td >我已经是履友，还没有登录，点击<a href="###" onClick="parent.f_wcj('2');">登录</a></td>
    </tr>
 	<tr>
      <td >是否注册履友：
      <input type="radio" name="iswmember" value="0">&nbsp;是&nbsp;&nbsp;
      <input type="radio" name="iswmember" value="1">&nbsp;否&nbsp;&nbsp;
      </td>
     
    </tr>
     <tr>
      <td >注：注册为履友会员后，可获取积分，换取礼品，并可参加履友联盟组织的活动. </td>
    </tr>
    
  </table>
<br>
  <center>
 
  <INPUT TYPE=button ID="submit1" class="edit_button" VALUE="确认" onClick="f_sub();">&nbsp;
  <INPUT TYPE=button  class="edit_button" VALUE="关闭" onClick="parent.ymPrompt.close();">&nbsp;
</center>


<%} %>

</form>


</body>
</html>

