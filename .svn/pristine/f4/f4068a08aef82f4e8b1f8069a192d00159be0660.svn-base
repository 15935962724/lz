<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);



Profile p=Profile.find(h.member);
String avatar=MT.f(p.getPhotopath(h.language),"/tea/image/avatar.gif");

%>


<style>
.th{text-align:right}
</style>


<form name="form2" action="/Papcs.do" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act" value="myedit" />
<input type="hidden" name="nexturl" value="location.reload()" />
<input type="hidden" name="avatar" value="<%=avatar%>" id="avatar"/>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td rowspan="2"><img src="<%=avatar%>" id="avatar_img"></td>
    <td><span class="grname">用户名：</span><span class="mcname"><%=h.username%></span> <span class="xghead"><a href="###" onClick="mt.show('/jsp/profile/MemberSetAvatar.jsp?',2,'上传照片',450,277);">修改头像</a></span></td>
  </tr>
  <tr>
    <td>您上次登陆时间：<%=MT.f(Logs.getLastLogin(h.username),1)%></td>
  </tr>
</table>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th"><em>*</em>姓名：</td>
    <td><input name="name" value="<%=MT.f(p.getName(h.language))%>" alt="姓名"></td>
    <td class="th"><em>*</em>性别：</td>
    <td><select name="sex"><option value=1>男<option value=0>女</select></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>手机号：</td>
    <td><input name="mobile" value="<%=MT.f(p.getMobile())%>" alt="手机号"></td>
    <td class="th">电话：</td>
    <td><input name="tel" value="<%=MT.f(p.getTelephone(h.language))%>"></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>邮箱：</td>
    <td><input name="email" value="<%=MT.f(p.getEmail())%>" alt="邮箱"></td>
    <td class="th">微博：</td>
    <td><input name="webpage" value="<%=MT.f(p.getWebPage(h.language))%>" title="http://"></td>
  </tr>
  <tr>
    <td class="th">单位：</td>
    <td><input name="org" value="<%=MT.f(p.getOrganization(h.language))%>"></td>
    <td class="th">职务：</td>
    <td><input name="job" value="<%=MT.f(p.getJob(h.language))%>"></td>
  </tr>
</table><div class="subut">
<input type="submit" value="提交" /></div>
</form>

<script>
mt.title(form2.webpage);
</script>
