<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.node.ChildMember" %><%@ page import="tea.entity.*" %><%@ page import="java.util.*" %><%@ page  import="tea.ui.*"%>
<%
	Http h=new Http(request,response);
	String member=h.get("member","");
	TeaSession tea=new TeaSession(request);

	if(tea._rv==null)
	{
	  response.sendRedirect("/servlet/StartLogin?node="+tea._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	  return;
	}
	String nextUrl=h.get("nextUrl", "");
	String fname="",unitname="",position="",email="",mobile="",qq="",phone="",pwd="",birth="";
	boolean sex=true;
	ChildMember cm=ChildMember.findChildMember(member,h.language);
	if(cm.isExist()){
		fname=cm.getFname();
		pwd=cm.getPassword();
		unitname=cm.getUnitname();
		position=cm.getPosition();
		email=cm.getEmail();
		mobile=cm.getMobile();
		qq=cm.getQq();
		phone=cm.getPhone();
		birth=cm.getBirth();
		sex=cm.getSex();
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <script src="/tea/tea.js" type="text/javascript"></script>
 <script src="/tea/mt.js" type="text/javascript"></script>
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
<link href="/res/<%=h.community%>/cssjs/community.css" type="text/css" rel="stylesheet">
</head>
<body>
<form name="form1" action="/ChildMembers.do" target="_ajax">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nextUrl" value="<%=nextUrl %>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>

	<table id="tablecenter">
	<tr>
		<td><span class="redStar">*</span>用户名：</td>
		<%
			if(cm.isExist()){
				out.print("<td colspan='3'><span>"+member+"</span><input type='hidden' name='member'  value='"+member+"'</td>");

			}else{
		%>
		<td><input type="text" name="member"  value="<%=member%>" alt="用户名"></td>
		<td colspan="2"><span class="warn">4-16字符，不能以数字开头</span></td>
		<%} %>
	</tr>
	<%if(!cm.isExist()){%>
	<tr>
		<td><span class="redStar">*</span>密码：</td>
		<td><input type="password" name="password" value="<%=pwd %>" alt="密码"></td>
		<td colspan="2" ><span class="warn">6-32字符，可使用字母、数字及符号的任意组合</span></td>
	</tr>
	<tr>
		<td><span class="redStar">*</span>确认密码：</td>
		<td><input type="password" name="password2" value="<%=pwd %>" alt="确认密码"></td>
		<td colspan="2"><span class="warn">请再次输入密码</span></td>
	</tr> <%}%>

	<tr>
		<td><span class="redStar">*</span>姓名：</td>
		<td><input type="text" name="fname" alt="姓名"  value="<%=fname%>"></td>
		<td><span class="redStar">*</span>性别：</td>
		<td>
			<select name="sex">
				<option value="1" <%=sex?"selected":"" %>>男</option>
				<option value="0" <%=!sex?"selected":"" %>>女</option>
			</select>
		</td>
	</tr>
	<tr>
		<td><span class="redStar">*</span>单位全称：</td>
		<td><input type="text" name="unitname" alt="单位全称"  value="<%=unitname%>"></td>
		<td>职务：</td>
		<td><input type="text" name="position"  value="<%=position%>"></td>
	</tr>
	<tr>
		<td>出生日期：</td>
		<td>
		<input id="" name="birth" size="7"  value="<%=birth %>"  style="cursor:pointer;width:126px;" readonly onClick="getDates();">
  <img style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="getDates();" />
		</td>
		<td>手机号：</td>
		<td><input type="text" name="mobile"  value="<%=mobile%>"></td>
	</tr>
	<tr>
		<td>办公电话：</td>
		<td><input type="text" name="phone"  value="<%=phone%>"></td>
		<td><span class="redStar">*</span>邮箱：</td>
		<td><input type="text" name="email" alt="邮箱"  value="<%=email%>"></td>
	</tr>
	<tr>
		<td>QQ号：</td>
		<td><input type="text" name="qq"  value="<%=qq%>"></td>
		<td></td>
		<td></td>
	</tr>
</table>
<%
	if(cm.isExist()){
		out.print("<input type='button' value='保存' onclick='checkSome();'/>");
	}else{
		out.print("<input type='button' value='保存' onclick='checkAll();'/>");
	}
	%>
    <input type="button" value="返回" onclick="history.back();"/>

</form>
</body>
</html>
