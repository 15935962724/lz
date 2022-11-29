<%@ page language="java" contentType="text/html; charset=UTF-8"%><%@ page import="tea.entity.Http" %>
<%
	String nextUrl="";
	if(request.getParameter("nextUrl")!=null&&request.getParameter("nextUrl").length()>0){
		nextUrl=request.getParameter("nextUrl");
	}else{
		nextUrl=request.getRequestURL().toString();
	}
	String jump="";
	if(request.getParameter("jump")!=null&&request.getParameter("jump").length()>0){
		jump=request.getParameter("jump");
	}

	Http h=new Http(request);

%>

 <script src="/tea/Calendar.js" type="text/javascript"></script>
 <script src="/jsp/type/ChildMember/register.js" type="text/javascript"></script>
<script type="text/javascript">
function getDates(){

	if(mt.isIE){
		var d=new Calendar();
		d.show('form1.birth');
	}else{
		var d=new Calendar();
		d.show('form1.birth');
	}
}

</script>

<form name="form1" action="/ChildMembers.do" method="post" target="_ajax" onSubmit="">
<input type="hidden" name="act" value="register"/>
<input type="hidden" name="nextUrl" value="<%=nextUrl %>"/>
<input type="hidden" name="jump" value="<%=jump %>"/>
<input type="hidden" name="isloginin" value="false"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<table id="tab1">
	<tr>
		<td align="right"><span class="redStar">*</span>&nbsp;用户名：</td>
		<td><input type="text" class="textInput" name="member" alt="用户名"></td>
		<td><span class="warn"></span></td>
	</tr>
	<tr>
		<td align="right"><span class="redStar">*</span>&nbsp;密码：</td>
		<td><input type="password" class="textInput" name="password"  alt="密码"></td>
		<td ><span class="warn">6-32字符，可使用字母、数字及符号的任意组合</span></td>
	</tr>
	<tr>
		<td align="right"><span class="redStar">*</span>&nbsp;确认密码：</td>
		<td><input type="password" class="textInput" name="password2" alt="确认密码"></td>
		<td ><span class="warn">请再次输入密码</span></td>
	</tr>
</table>
<h2>基本信息</h2>
<table id="tab2">
	<tr>
		<td align="right"><span class="redStar">*</span>&nbsp;姓名：</td>
		<td><input type="text" name="fname" class="textInput" alt="姓名"></td>
		<td align="right"><span class="redStar">*</span>&nbsp;性别：</td>
		<td>
			<select name="sex" class="sex">
				<option value="1">男</option>
				<option value="0">女</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right"><span class="redStar">*</span>&nbsp;单位全称：</td>
		<td><input type="text" class="textInput" name="unitname" alt="单位全称"></td>
		<td align="right">职务：</td>
		<td><input type="text" class="textInput" name="position"></td>
	</tr>
	<tr>
		<td align="right">出生日期：</td>
		<td>
		<input id="" name="birth" size="7"  value=""  class="birth" readonly onClick="getDates();">
  <img style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="getDates();" />
		</td>
		<td align="right">手机号：</td>
		<td><input type="text" class="textInput" name="mobile"></td>
	</tr>
	<tr>
		<td align="right">办公电话：</td>
		<td><input type="text" class="textInput" name="phone"></td>
		<td align="right"><span class="redStar">*</span>&nbsp;邮箱：</td>
		<td><input type="text" name="email" class="textInput" alt="邮箱"></td>
	</tr>
	<tr>
		<td align="right">QQ号：</td>
		<td><input type="text" class="textInput" name="qq"></td>
		<td></td>
		<td></td>
	</tr>
</table>
<input type="button" onClick="checkAll();" class="submitBtn" value="注册">
</form>

