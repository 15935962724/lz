<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
TeaSession ts=new TeaSession(request);
if(ts._rv==null)return;



Profile p=Profile.find(h.member);
String avatar=MT.f(p.getPhotopath(h.language),"/tea/image/avatar.gif");

%>


<style>
.strength{text-align:center;width:180px;color:#FFFFFF}
.strength td{background:#FFD099;height:15px;padding:0;line-height:15px}
.strength2{background:#FF6600 !important}

em{padding-right:5px;color:#FF0000;font-style:normal}

.date
{
  background-image: url(/tea/image/date.gif);
  background-repeat: no-repeat;
  background-position: right;
  width:100px;
  cursor:pointer;
}
.th{text-align:right}
</style>
<div class="tabtop">
<a href="javascript:mt.tab(1)" id="a_tab1" class="cur">个人信息</a>
<a href="javascript:mt.tab(2)" id="a_tab2" >修改密码</a>
</div>

<form name="form1" action="/EduMembers.do" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act" value="myedit" />
<input type="hidden" name="nexturl" value="location.reload()" />
<input type="hidden" name="avatar" value="<%=avatar%>" id="avatar"/>
<table id="tab1">
  <tr>
    <td rowspan="2"><img src="<%=avatar%>" id="avatar_img"></td>
    <td><span class="grname">用户名：</span><span class="mcname"><%=h.username%></span> <span class="xghead"><a href="###" onClick="mt.show('/jsp/profile/MemberSetAvatar.jsp?',2,'上传照片',450,277);">修改头像</a></span></td>
  </tr>
  <tr>
    <td>您上次登陆时间：<%=MT.f(Logs.getLastLogin(h.username),1)%></td>
  </tr>
</table>

<div class="jbxx"><h2>基本信息</h2></div>
<table id="tab2">
  <tr>
    <td class="th"><em>*</em>姓名：</td>
    <td><input name="name" value="<%=MT.f(p.getName(h.language))%>" alt="姓名"></td>
    <td class="th"><em>*</em>性别：</td>
    <td><select name="sex"><option value=1>男<option value=0>女</select></td>
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
</form>


<form name="form2" action="/Members.do" target="_ajax" onSubmit="return mt.check(this)" style="display:none">
<input type="hidden" name="act" value="password" />
<input type="hidden" name="nexturl" value="location.reload()" />
<table id="tab1">
  <tr>
    <td class="th">用户名：</td>
    <td><%=h.username%></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>旧密码：</td>
    <td><input type="password" name="old"></td>
    <td tip="请输入现在的密码"></td>
  </tr>
  <tr>
    <td class="th"><em>*</em>密码：</td>
    <td><input type="password" name="password" alt="密码" min="6"></td>
    <td tip="6-32字符，可使用字母、数字及符号的任意组合"></td>
  </tr>
  <tr>
    <td class="th">&nbsp;</td>
    <td colspan="2">
      <table class="strength w270" width="180" height="20">
        <tr>
          <td id="strength0" class="strength2">弱</td>
          <td id="strength1">中</td>
          <td id="strength2">强</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="th"><em>*</em>确认密码：</td>
    <td><input type="password" name="password2" alt="确认密码"></td>
    <td tip="请再次输入密码"></td>
  </tr>
</table>

<input type="submit" value="提交" />
</form>

<script>
mt.reg(form2);
mt.tab=function(j)
{
  for(var i=1;i<3;i++)
  {
    var t=document['form'+i];
    t.style.display=i==j?"":"none";
    $$('a_tab'+i).className=i==j?"cur":"";
  }
};
</script>
