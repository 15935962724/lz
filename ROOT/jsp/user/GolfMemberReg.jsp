<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%


Http h=new Http(request);

if("POST".equals(request.getMethod()))
{
  out.print("<script>var mt=parent.mt;</script>");
  if(!h.get("verify").equalsIgnoreCase((String)session.getAttribute("sms.vertify")))
  {
    out.print("<script>mt.show('验证码不正确。')</script>");
    return;
  }
  String member=h.get("member");
  if(Profile.isExisted(member))
  {
    out.print("<script>mt.show('该会员名已被使用。')</script>");
    return;
  }
  Profile.create(member,h.get("password"),h.community,h.get("email"),request.getServerName());
  Profile p=Profile.find(member);
  p.setMembertype(0);
  p.setProvince(h.getInt("city1",h.getInt("city0")),h.language);
  session.setAttribute("tea.RV",new RV(member));
  out.print("<script>mt.show('会员注册成功！',1,'"+h.get("nexturl")+"');</script>");
  return;
}




%>
<style type="text/css">
.tip
{
background:url(/tea/mt/msg.gif) no-repeat; padding-left:20px;
border:1px solid #40B3FF;
background-position:0 -150px;
background-color:#E5F5FF;
}
.err
{
background:url(/tea/mt/msg.gif) no-repeat; padding-left:20px;
border:1px solid #FF8080;
background-color:#FFF2F2;
}
.ok
{
background:url(/tea/mt/msg.gif) no-repeat; padding-left:20px;
background-position:0 -250px;
}
</style>
<script src="/tea/city.js"></script>
<script src="/jsp/custom/westrac/script.js"></script>
<form method="post" action="<%=request.getRequestURI()%>" target="_ajax" onSubmit="t=$('member_info').innerHTML;if(t.length>1&&t!='&amp;nbsp;'){mt.show(t);return false;};return mt.check(this);">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl" value="/html/folder/3-1.htm"/>
<table border="0" cellpadding="0" cellspacing="0" class="regtable">

  <tr>
    <td align="right" class="td01">用户名：</td>
    <td><input name="member" onfocus="mt.f_m(this)" onblur="mt.f_m(this)" min='4' maxlength="20" alt="用户名"><span id="member_info"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01">密码：</td>
    <td><input type="password" name="password" onfocus="mt.f_p(this)" onblur="mt.f_p(this)" min='6' maxlength="20" alt="密码"><span id="password_info"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01">确认密码：</td>
    <td><input type="password" name="password2" onfocus="mt.f_2(this)" onblur="mt.f_2(this)" alt="确认密码"><span id="password2_info"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01">E-mail：</td>
    <td><input name="email" value=""><span class="tixing"><font>&nbsp;邮箱是联系我们、订阅信息、找回密码的必要手段，请正确填写。如您还没有邮箱，请马上<a href="http://reg.email.163.com/mailregAll/reg0.jsp?from=email163&regPage=163" target="_blank">注册</a>一个。</font></span>
  </tr>
  <tr>
    <td align="right" nowrap="nowrap" class="td01">现在工作地址：</td>
    <td colspan="3"><script>mt.city("city0","city1",null,"");</script></td>
  </tr>
  <tr>
    <td align="right" class="td01">验证码：</td>
    <td><table border="0" cellpadding="0" cellspacing="0"><tr><td><input name="verify" onfocus="mt.f_v(this,true)" onblur="mt.f_v(this,false)" size="5" alt="验证码"></td><td><img id="t_verify" src="/NFasts.do?community=<%=h.community%>&act=verify"></td><td><a href="javascript:mt.verify()">看不清,换一张</a></td></tr></table><span id="verify_info"></span></td>
  </tr>
</table>
<input type="checkbox" name="agreement" alt="会员协议"/>我已阅读并同意<a class="Agreement" href="/html/folder/49-1.htm" target="_blank">《FashionGOLF服务条款》</a>
<br><br><input type="submit" value="提交注册">
</form>
