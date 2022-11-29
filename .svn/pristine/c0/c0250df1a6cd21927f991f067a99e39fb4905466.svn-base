<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
TeaSession ts=new TeaSession(request);
if(ts._rv==null)return;



int member=h.getInt("member");

Profile p=Profile.find(member);
String avatar=MT.f(p.getPhotopath(h.language),"/tea/image/avatar.gif");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>创建/编辑——会员管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/EduMembers.do" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act" value="edit" />
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>" />
<input type="hidden" name="avatar" value="<%=avatar%>" id="avatar"/>
<input type="hidden" name="member" value="<%=member%>" />

<%
if(member<1)
{
%>
<h2>创建用户</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th"><em>*</em>用户名：</td>
    <td><input name="username" alt="用户名"></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>密码：</td>
    <td><input type="password" name="password" alt="密码"></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>确认密码：</td>
    <td><input type="password" name="password2" alt="确认密码"></td>
  </tr>
</table>
<%
}
%>
<h2>基本信息</h2>
<table id="tablecenter" cellspacing="0">
<%
if(member>0)
{
  out.print("<tr><td class='th'>用户名：</td><td>"+p.getMember()+"</td></tr>");
}
%>
  <tr>
    <td class="th"><em>*</em>姓名：</td>
    <td><input name="name" value="<%=MT.f(p.getName(h.language))%>" alt="姓名"></td>
    <td class="th"><em>*</em>性别：</td>
    <td><select name="sex"><option value=1>男<option value=0>女</select></td>
    <td rowspan="5" class="th"><img src="<%=avatar%>" id="avatar_img"><br/><a href="###" onClick="mt.show('/jsp/profile/MemberSetAvatar.jsp?',2,'上传照片',450,277);">修改证件照</a></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>单位：</td>
    <td><input name="org" value="<%=MT.f(p.getOrganization(h.language))%>" alt="单位"></td>
    <td class="th"><em>*</em>职务：</td>
    <td><input name="job" value="<%=MT.f(p.getJob(h.language))%>" alt="职务"></td>
	</tr>
  <tr>
    <td class="th"><em>*</em>出生日期：</td>
    <td><input name="birth" value="<%=MT.f(p.getBirth())%>" alt="出生日期" readonly class="date" onClick="mt.date(this)"></td>
    <td class="th"><em>*</em>手机号：</td>
    <td><input name="mobile" value="<%=MT.f(p.getMobile())%>" alt="手机号"></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>电话：</td>
    <td><input name="tel" value="<%=MT.f(p.getTelephone(h.language))%>" alt="电话"></td>
    <td class="th">邮箱：</td>
    <td><input name="email" value="<%=MT.f(p.getEmail())%>"></td>
  </tr>
  <tr>
    <td class="th">身份证号：</td>
    <td colspan="3"><input name="card" value="<%=MT.f(p.getCard())%>"></td>
  </tr>
</table>
<input type="submit" value="提交" />
<input type="button" value="返回" onclick="history.back()"/>
</form>


<script>

</script>
</body>
</html>
