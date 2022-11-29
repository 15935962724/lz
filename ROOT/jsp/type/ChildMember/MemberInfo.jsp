<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.node.ChildMember" %><%@ page import="tea.entity.*" %><%@ page import="java.util.*" %>
<%
	Http h=new Http(request,response);
	String member=h.get("member","");
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
<title></title>
 <script src="/tea/tea.js" type="text/javascript"></script>
 <script src="/tea/mt.js" type="text/javascript"></script>
 <script src="/tea/Calendar.js" type="text/javascript"></script>
 <script src="/jsp/type/ChildMember/register.js" type="text/javascript"></script>

<link href="/res/<%=h.community%>/cssjs/community.css" type="text/css" rel="stylesheet">
</head>
<body>
<form name="form1" action="">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nextUrl" value="<%=nextUrl %>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>

	<table id="tablecenter">
	<tr>
		<td>用户名：</td>
				<td colspan='4'><%=member %></td>
			
	</tr>
	

	<tr>
		<td>姓名：</td>
		<td><%=fname%></td>
		<td>性别：</td>
		<td>
			<%=sex?"男":"女" %>
		</td>
	</tr>
	<tr>
		<td>单位全称：</td>
		<td><%=unitname%></td>
		<td>职务：</td>
		<td><%=position%></td>
	</tr>
	<tr>
		<td>出生日期：</td>
		<td><%=birth %>
		</td>
		<td>手机号：</td>
		<td><%=mobile%></td>
	</tr>
	<tr>
		<td>办公电话：</td>
		<td><%=phone%></td>
		<td>邮箱：</td>
		<td><%=email%></td>
	</tr>
	<tr>
		<td>QQ号：</td>
		<td><%=qq%></td>
		<td></td>
		<td></td>
	</tr>
</table>
<input type='button' value='返回' onclick="window.location='<%=nextUrl%>'"/>	
	
	
</form>
</body>
</html>