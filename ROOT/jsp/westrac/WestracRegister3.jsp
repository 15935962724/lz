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
<div class="RegSelect"><input type="radio" name="type" value="0" onClick="window.open('/html/folder/32-1.htm','_self');">&nbsp;普通会员&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="type" value="1" checked="checked">&nbsp;履友</div>

<form name="form1" method="post" action="/servlet/EditEvent"  target="_ajax" >
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act" value="WestracRegister">


 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">   
    <tr>
      <td  colspan="2" class="step3">
      1.填写基本信息&nbsp;&nbsp;&nbsp;&nbsp;
      2.验证信息&nbsp;&nbsp;&nbsp;&nbsp;
      3.注册成功
      </td>
     
    </tr>
     <tr>
      <td>在线验证：我们已将验证码发送动您手机，请回复确认验证码：<input type=text name="" value=""><input type="button" value="确认"></td>
     
    </tr>
    <tr>
     <td>
        短信验证：请将您收到到验证码直接发送至***，进行手机短信验证。
      </td>
    </tr>
	
  </table>
  <br>
  <center>
  <INPUT TYPE=button name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="重新获取验证码" onClick="f_sub();">&nbsp;
  <INPUT TYPE=button name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="跳过,稍候完善信息" onClick="f_sub();">&nbsp;
  <INPUT TYPE=button name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="下一步" onClick="f_sub();">&nbsp;
  
  
</center></form>


