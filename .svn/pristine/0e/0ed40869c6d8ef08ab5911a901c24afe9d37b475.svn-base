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
	
	String name="",job="",title="",content="",firstname="",picture="";
	if(member>0){
		Profile p=Profile.find(member);
		name=p.getMember();
		job=p.getJob(h.language);
		title=p.getTitle(h.language);
		content=p.getIntroduce(h.language);
		firstname=p.getName(h.language);
		picture=p.getPhotopath(h.language);
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
<h1>名家信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
	<tr >
		<td class="th">用户名:</td>
		<td><%=name%></td>
	</tr>
	<tr >
		<td class="th">姓名:</td>
		<td><%=firstname%></td>
	</tr>
	
	<tr >
		<td class="th">职务:</td>
		<td><%=job%></td>
	</tr>
	<tr >
		<td class="th">职称:</td>
		<td><%=title%></td>
	</tr>
	<tr >
		<td class="th">头像:</td>
		<td>
			<%if(picture!=null&&picture.length()>0){
				
				out.print("<img src='"+picture+"' width='130' />");
			} %>
		</td>
	</tr>
	<tr >
		<td class="th">简介:</td>
		<td>
			<%if(content!=null&&content.length()>0){out.print(content.replaceAll("\r\n", "<br>"));} %>
		</td>
	</tr>
</table>
<div align="center"><input type="button" value="返回" onClick="window.history.back();"/></div>
</body>
</html>