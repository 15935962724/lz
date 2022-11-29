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
  String mobile=h.get("member");
  if(Profile.isMobile(h.community, mobile))
  {
    out.print("<script>mt.show('该手机号已被使用。')</script>");
    return;
  }
  String member=String.valueOf(Seq.get());
  Profile.create(member,h.get("password"),h.community,h.get("email"),request.getServerName());
  Profile p=Profile.find(member);
  p.setMobile(mobile);
  p.setMembertype(0);
  session.setAttribute("member",p.getProfile());
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
<script src="/tea/mt.js"></script>
<script src="/tea/tea.js"></script>
<script src="/jsp/custom/westrac/script.js"></script>
<form method="post" action="<%=request.getRequestURI()%>" target="_ajax" onSubmit="t=$('member_info').innerHTML;if(t.length>1&&t!='&amp;nbsp;'){mt.show(t);return false;};return mt.check(this);">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl" value="/html/Home/folder/14050119-1.htm"/>
<table border="0" cellpadding="0" cellspacing="0" class="regtable">

  <tr>
    <td align="right" class="td01"  valign="top"><span>*</span>手机号码：</td>
    <td style="width:272px !important"><input class="in text1" name="member" onfocus="v_mobile(this)" onblur="v_mobile(this)" min='4' maxlength="20" size="21" alt="手机号码"><span id="member_info"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01"  valign="top"><span>*</span>请设置密码：</td>
    <td><input class="in text3" type="password" name="password" onfocus="mt.f_p(this)" onblur="mt.f_p(this)" min='6' maxlength="20" size="21" alt="密码"><span id="password_info"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01"  valign="top"><span>*</span>请确认密码：</td>
    <td><input class="in text3" type="password" name="password2" onfocus="mt.f_2(this)" onblur="mt.f_2(this)" alt="确认密码" size="21" ><span id="password2_info"></span></td>
  </tr>
  <!--
  <tr>
    <td align="right" nowrap="nowrap" class="td01">现在工作地址：</td>
    <td colspan="3"><script>mt.city("city0","city1",null,"");</script></td>
  </tr>
  -->
  <tr>
    <td align="right" class="td01"><span>*</span>验证码：</td>
    <td><table border="0" cellpadding="0" cellspacing="0"><tr><td style="margin:0px;padding:0px;width:75px !important;"><input name="verify" onfocus="mt.f_v(this,true)" onblur="mt.f_v(this,false)" size="5" alt="验证码"></td><td align="left" style="width:75px !important;"><img id="t_verify" src="/NFasts.do?community=<%=h.community%>&act=verify"></td><td><a href="javascript:mt.verify()">看不清，换一张</a></td></tr></table><span id="verify_info"></span></td>
  </tr>
</table>
<div class="agree">
<p><input type="checkbox" class="xy" name="agreement" alt="会员协议"/>我已阅读并同意 <a class="Agreement" href="/html/Home/folder/14050187-1.htm" target="_blank">《中华服务网用户协议》</a></p>
<p><input type="submit" class="button_reg" value="提交注册"></p>
</div>
</form>
