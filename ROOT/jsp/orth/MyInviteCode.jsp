<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.admin.orthonline.*" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page import="tea.entity.member.*"%>
<%@page  import="tea.entity.site.*" %><%@page  import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><%@ page import="java.util.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
	out.println("您没有登录，请登录后操作");
	return;
}


Resource r=new Resource("/tea/resource/Report");
Profile profile=Profile.find(teasession._rv.toString());

Communityintegral cobj = Communityintegral.find(teasession._strCommunity);
	
%>
<html>
<head>
<title>邀请会员</title>
<base target="dialog"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/tea/tea.js" type="text/javascript"></script>

<style type="text/css">
#nt_step_2{ padding-left:20px; }
#nt_step_3{ padding-left:40px; }
</style>
</head>
<body >
<script type="text/javascript">
function copyText(obj)   
{ 
var rng = document.body.createTextRange(); 
rng.moveToElementText(obj); 
rng.scrollIntoView(); 
rng.select(); 
rng.execCommand("Copy"); 
rng.collapse(false);
alert("复制成功!"); 
} 
</script> 
<form name="form1" method="post" action="?" >
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node">
<div class="Invitemembers">邀请会员</div>
<div class="InviteTips">
您可以使用如下方式邀请您的朋友加入威斯特：<br>
每位邀请会员来注册，您将获得<%=cobj.getInvitepoint() %>个积分。
</div>
<span id="InviteCon">
  <%
  String domain=request.getRequestURL().toString();
  domain=domain.substring(0,domain.indexOf("/",9));
   %>

  我是 <%=teasession._rv.toString() %>，邀请您来威斯特在线注册会员，请点击下面的邀请链接进行注册：<br>
     <a href="<%=domain%>/jsp/westrac/WestracRegister.jsp?community=<%=teasession._strCommunity %>&invite=<%=profile.getProfile() %>" target=_blank>
   <%=domain%>/jsp/westrac/WestracRegister.jsp?community=orth&invite=<%=profile.getProfile() %>
   </a>

</span> 

</form>
<div class="InviteCopy"><table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><a href="#" onClick="copyText(document.all.InviteCon);return false;"><img src="/res/orth/0911/0911994.gif"></a></td><td>　以上代码，通过QQ,MSN，E-mail等方式发送邀请给您的朋友。</td> </tr>
</table></div>
</body>
</html>
