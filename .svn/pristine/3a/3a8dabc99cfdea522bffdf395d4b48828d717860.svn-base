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

if(teasession._rv==null)
{
	out.println("您没有登录，请登录后操作");
	return;
}

tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl = teasession.getParameter("nexturl");
String member = teasession.getParameter("member");
Profile p = Profile.find(member);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js"></script>
<script src="/jsp/custom/westrac/script.js"></script>

<script type="text/javascript">

function f_sub()
{


	if(form1.member.value=='')
	{
		document.getElementById("member_id").innerHTML='用户名不能为空';
		form1.member.focus();
		return false;
	}else if(form1.member.value.indexOf("<")!=-1||form1.member.value.indexOf(">")!=-1)
	{
		document.getElementById("member_id").innerHTML='用户名中含有非法字符';
		form1.member.focus();
		return false;
	}

	if(form1.membername.value=='')
	{
		document.getElementById("membername_id").innerHTML='姓名不能为空';
		form1.membername.focus();
		return false;

	}
	document.getElementById("membername_id").innerHTML='';


	if(form1.EnterPassword.value.length<6 || form1.EnterPassword.value.length>18)
    {

        document.getElementById("EnterPassword_id").innerHTML='密码必须为6到18位之间';
        form1.EnterPassword.focus();
        return false;
    }
	document.getElementById("EnterPassword_id").innerHTML='';

    if(form1.ConfirmPassword.value!=form1.EnterPassword.value)
    {
       document.getElementById("ConfirmPassword_id").innerHTML='两次密码输入不一致';
       form1.ConfirmPassword.focus();
       return false;
   }
    document.getElementById("ConfirmPassword_id").innerHTML='';

   

    if(form1.mobile.value=='')
    {
    	  document.getElementById("mobile_id").innerHTML='手机不能为空';
   	    form1.mobile.focus();
   	    return false;
    }else
    {
    	var str = form1.mobile.value;
      //  var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
      var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
      if(!reg.test(str)){
        	document.getElementById("mobile_id").innerHTML='手机格式不正确';
       	    form1.mobile.focus();
       	    return false;
        }
    }

    document.getElementById("mobile_id").innerHTML='';

    if(form1.birth.value=='')
    {
    	  document.getElementById("birth_id").innerHTML='生日不能为空';
   	    form1.birth.focus();
   	    return false;
    }

    document.getElementById("birth_id").innerHTML='';


	if(form1.city0.value=='')
	{
		document.getElementById("city_id").innerHTML='现工作地省份不能为空';
   	    form1.city0.focus();
   	    return false;
	}
	document.getElementById("city_id").innerHTML='';
	if(form1.city1.value=='')
	{
		document.getElementById("city_id").innerHTML='现工作地市不能为空';
   	    form1.city1.focus();
   	    return false;
	}
	document.getElementById("city_id").innerHTML='';
	if(form1.address.value==''){

		document.getElementById("city_id").innerHTML='现工作地详细地址不能为空';
   	    form1.address.focus();
   	    return false;
	}

	document.getElementById("city_id").innerHTML='';



	document.getElementById("submitshow").innerHTML='正在提交，请稍候...';
	 

	form1.action='/servlet/EditMember';

	form1.submit();



}


</script>
</head>

<body >
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<h1>系统会员(<%=member %>)编辑</h1>

<form name="form1" method="POST" action="/servlet/EditMember" >

<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act" value="EditWestracMmeber">
<input type="hidden"   name="member" value="<%=member %>">
<input type="hidden"   name="code" value="<%=p.getCode() %>">

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr>
      <td align="right"><span id="btid">*</span>&nbsp;用户名：</td>
      <td>
        <%=Entity.getNULL(member) %>
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;密码：</td>
      <td>
       	<input type="password"   class="edit_input" name="EnterPassword" value="<%=p.getPassword() %>">&nbsp;<span id="EnterPassword_id"></span>
      </td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;确认密码：</td>
      <td>
       	<input type="password"    class="edit_input" name="ConfirmPassword" value="<%=p.getPassword() %>">&nbsp;<span id="ConfirmPassword_id"></span>
      </td>
    </tr>
     <tr>
      <td align="right">E-mail：</td>
      <td>
       	<input type="text"    class="edit_input" name="email" value="<%=Entity.getNULL(p.getEmail()) %>">&nbsp;
       	<!-- 邮箱是联系我们、订阅信息、找回密码的必要手段，请正确填写。如您还没有邮箱，请马上去<a herf="http://reg.email.163.com/mailregAll/reg0.jsp?from=163mail_right">注册</a>一个。 -->
      </td>
    </tr>

    

	<tr>
      <td align="right"><span id="btid">*</span>&nbsp;姓名：</td>
      <td>
        <input type="text"    class="edit_input" name="membername" value="<%=Entity.getNULL(p.getFirstName(teasession._nLanguage)) %>">&nbsp;<span id="membername_id"></span>
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;性别：</td>
      <td>
       	<select name="sex">
       		<option value="1" <%if(!p.isSex()){out.println(" selected ");} %>>男</option>
       		<option value="0" <%if(p.isSex()){out.println(" selected ");} %>>女</option>
       	</select>
      </td>
    </tr>
    
    
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;手机：</td>
      <td>
       	<input type="text"    class="edit_input" name="mobile" value="<%=p.getMobile() %>">&nbsp;<span id="mobile_id"></span>
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;生日：</td>
      <td>
        <input id="birth" name="birth" size="7"  value="<%if(p.getBirth()!=null)out.print(Entity.sdf.format(p.getBirth())); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.birth');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.birth');" />
       &nbsp;<span id="birth_id"></span>
      </td>
    </tr>
       <tr>
      <td align="right"><span id="btid">*</span>&nbsp;现工作地：</td>
      <td>
       	<script>mt.city("city0","city1",null,'<%=p.getProvince(teasession._nLanguage) %>');</script>

    详细地址:<input type="text" name="address" value="<%=p.getAddress(teasession._nLanguage) %>" title="详细地址">&nbsp;<span id="city_id"></span>
      </td>
    </tr>

  <tr>
      <td align="right">固定电话：</td>
      <td>
        <input type="text"    class="edit_input" name="telephone" value="<%=Entity.getNULL(p.getTelephone(teasession._nLanguage)) %>
        ">
      </td>
    </tr>
     <tr>
      <td align="right">邮编：</td>
      <td>
       	<input type="text"    class="edit_input" name="zip" value="<%=Entity.getNULL(p.getZip(teasession._nLanguage)) %>">
      </td>
    </tr>


  </table>



<br>
  <center>
  
  <span id="submitshow">
  

  <INPUT TYPE=button ID="submit1" class="edit_button" VALUE="提交用户信息" onclick="f_sub();">&nbsp;

  <input type="button" name="reset" value="返回" onClick="window.open('<%=nexturl%>','_self');">

</span>
</center></form>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

</body>
</html>

