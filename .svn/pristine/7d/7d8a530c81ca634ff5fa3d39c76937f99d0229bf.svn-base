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


tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl = teasession.getParameter("nexturl"); 
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city2.js" type="text/javascript"></script>
<script type="text/javascript">

function f_sub()
{
	if(form1.mobile.value=='')
	{
		alert("请填写手机号.");
		form1.mobile.focus();
		return false;
	}

}

</script> 
</head>

<body >
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<h1>注册新会员</h1>

<form name="form1" method="post" action="/servlet/EditEvent"  target="_ajax" >
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act" value="WestracRegister">


 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 
    
   
   
    <tr>
      <td  colspan="2">
      1.填写基本信息&nbsp;&nbsp;&nbsp;&nbsp;
      2.验证信息&nbsp;&nbsp;&nbsp;&nbsp;
      3.注册成功
      </td>
     
    </tr>
     <tr>
      <td>恭喜您！已经成功完成注册,您会员编号：WST6666,快来登录吧</td>
     
    </tr>
  <tr>
      <td>5秒钟后将自动进入登陆页面...</td>
     
    </tr>
    <tr>
      <td>如页面无法正常跳转,请点击<a href="###">登录</a></td>
     
    </tr>
	
  </table>
  </form>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

</body>
</html>

