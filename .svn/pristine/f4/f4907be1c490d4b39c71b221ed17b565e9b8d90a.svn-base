<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.Resource" %>
<%@page import="java.net.URLEncoder"%>
<%
//response.setHeader("Cache-Control", "no-cache");
//response.setHeader("Pragma", "no-cache");



TeaSession teasession = new TeaSession(request);

String nexturl="/jsp/user/UserLog.jsp?act=Jump&url="+request.getParameter("url");

if("Jump".equals(request.getParameter("act"))) 
{
	out.println("<script>");
	//out.println("alert(window.parent.length);");
		//out.println("if(window.parent.length>0){");
			out.println("window.parent.location='"+request.getParameter("url")+"';");
		//out.println("}");

	out.println("</script>");
}


%>
<html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body id="bodylog">
<h1>会员登录</h1>
<script>
	function f_sub()
	{
		if(foLogin.LoginId.value==''){
			alert('用户名不能为空');
			foLogin.LoginId.focus();
			return false;
		}
		if(foLogin.Password.value==''){
			alert('密码不能为空');
			foLogin.Password.focus();
			return false;
		}
		foLogin.action ="/html/Home/folder/14050002-1.htm";
		foLogin.submit();
		
	}
</script>
  <FORM target="_parent" name="foLogin" METHOD="POST" action="?" onSubmit="">
  
    <input type='hidden' name="nexturl" VALUE="<%=nexturl%>"/>
    <input type='hidden' name="community" VALUE="<%=teasession._strCommunity%>"/>
    <input type='hidden' name="Node" VALUE="<%=teasession._nNode%>"/>
    <input type='hidden' name="LoginType" value="0"/>
    <%//0用会员ID登陆,1用手机号登陆%>
    <style>
	#tablecenterlog td{height:30px;}
	</style>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenterlog">
      <tr>
        <TD>用户名:</TD>
        <td><input type="TEXT" class="edit_input"  name="LoginId"></td>
      </tr>
      <tr>
        <TD>密码:</TD>
        <td><input type="password" class="edit_input" name="Password"></td>
      </tr>    
    </table>
    <input type="button" value="登录" onClick="f_sub();">
  </FORM>
  

</body>
</html>

