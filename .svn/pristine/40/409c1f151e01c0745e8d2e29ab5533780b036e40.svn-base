<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.member.Profile" %>
<%
	Http h=new Http(request); 
	if(h.member<1)
	{
	  response.sendRedirect("/servlet/StartLogin?community="+h.community);
	  return;
	}
	if(h.isIllegal())
	{
	  response.sendError(404,request.getRequestURI());
	  return;
	}
	
	String key=h.get("member");
	int member = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
	
	String name="",password="",job="",title="",content="",firstname="",picture="";
	boolean ishow=true;
	if(member>0){
		Profile p=Profile.find(member);
		name=p.getMember();
		job=p.getJob(h.language);
		title=p.getTitle(h.language);
		content=p.getIntroduce(h.language);
		firstname=p.getName(h.language);
		picture=p.getPhotopath(h.language);
		password="******";
		ishow=p.isValidate();
		
	}
	

	Resource res=new Resource().add("/tea/resource/Consultant");

%>
<html>
<head>
<title>编辑名家信息</title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/script/md5.js" type="text/javascript"></script>
<!--[if IE 6]><style>.tfont{font-family:宋体;}</style><![endif]-->
<style>
#tablecenter td table td{border:0}
</style>
</head>
<body>
<h1>编辑名家信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" method="post" action="/EditConsultant.do"  enctype="multipart/form-data" target="_ajax" onSubmit="return mt.submit(this)">

<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="member" value="<%=key%>">
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>">
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
	<tr >
		<td class="th">用户名:</td>
		<td><input type="text" name="name" value="<%=name%>"> <input type="checkbox" name="ishow" <%=ishow?"checked":"" %> id="isshow"><label for="isshow">是否允许发表每日银评</label></td>
	</tr>
	<tr >
		<td class="th">姓名:</td>
		<td><input type="text" name="firstname" value="<%=firstname%>"></td>
	</tr>
	<tr >
		<td class="th">登录密码:</td>
		<td><input type="password" name="password" value="<%=password%>"></td>
	</tr>
	<tr >
		<td class="th">职务:</td>
		<td><input type="text" name="job" value="<%=job%>"></td>
	</tr>
	<tr >
		<td class="th">职称:</td>
		<td><input type="text" name="title" value="<%=title%>"></td>
	</tr>
	<tr >
		<td class="th">头像:</td>
		<td>
			<input type="file" name="logo"/><%if(picture!=null)out.print(" <a href='###' onclick=mt.img('"+picture+"')>查看</a>");%>
		</td>
	</tr>
	<tr >
		<td class="th">简介:</td>
		<td>
			<textarea name="content" rows="10" cols="50"><%=content %></textarea>
		</td>
	</tr>
	
</table>
<div align="center"><input type="submit" value="提交"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="返回" onClick="window.history.back();"/></div>
</form>
</body>
</html>