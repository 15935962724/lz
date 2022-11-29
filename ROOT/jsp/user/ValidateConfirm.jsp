<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import = "tea.entity.site.Community" %>
<%@ page import = "tea.entity.node.*" %>
<%@ page import = "tea.entity.member.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.admin.orthonline.ProfileOrth" %>
<%@ page import="tea.ui.TeaServlet"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
 

Community community = Community.find(teasession._strCommunity);

String user = teasession.getParameter("user");
Profile pobj = Profile.find(user);


if("chongxin".equals(teasession.getParameter("act")))
{
	 tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
	 ProfileOrth.send(teasession,pobj);
}
if("newemail".equals(teasession.getParameter("act")))
{
	 String newemail=request.getParameter("newemail");
	 pobj.setEmail(newemail);
	 tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
	 ProfileOrth.send(teasession,pobj);
}

 

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script>
	function f_submit(m,i)
	{
		 sendx("/jsp/user/ValidateConfirm.jsp?act=chongxin&user="+encodeURIComponent(m)+"&membertype="+i,
         function(data)
         {
             alert("邮件重新发送成功.");
         }
         );
	}
	
	function new_submit(m,i)
	{
		 sendx("/jsp/user/ValidateConfirm.jsp?act=newemail&user="+encodeURIComponent(m)+"&membertype="+i+"&newemail="+frm.newemail.value,
         function(data)
         {
             alert("邮件重新发送成功.");
         }
         );
	}
</script>
<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div class="RegProcess"><div class="Process00">注册流程：</div><div class="Process01">会员类型选择</div><div class="Process02" >用户协议</div><div class="Process03">填写基本信息</div><div class="Process04" id="ProcessSpecial">注册成功</div></div>

<div class=RegInf><br><table id="tablecenter">
<tr> 
<td><img src="../img/wenhao.jpg"></td>
<td>您的账号尚未激活，不能进行登陆，我们已发送激活邮件到您的邮箱，请登陆您的邮箱按操作进行激活，<br>
  如没收到请点击下方链接重新发送邮件或更换邮件地址。<br>

</td></tr><tr><td>　</td><td></td></tr><tr><td><img src="../img/wenhao.jpg"></td><td>
<a href=# onClick="f_submit('<%=user%>','15');">再次发送激活邮件</a><br>
<a href=# onclick='document.getElementById("newemail").style.display=""'>更换邮箱再试一次</a>
<div id='newemail' style="display:none">
<form name="frm" action="?">
<input type="text" name="newemail" value="" width="50"/>
<a href=# onClick="new_submit('<%=user%>','15');">发送</a>
</form>

</td>
</tr>
</table> <br>
</div>

<br>



<input type="button" name="dingyue" onClick="window.close()" value="关闭" />
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>

</html>
