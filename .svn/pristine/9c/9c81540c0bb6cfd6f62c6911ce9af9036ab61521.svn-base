<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.site.Community" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%@ page import="javax.servlet.http.Cookie"%><%


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
  
  Community c = Community.find(h.community);
  session.setAttribute("member",p.getProfile());
  if(!c.isSession())
  {
      Cookie cs = new Cookie("member",MT.enc(p.getProfile() + "|" + p.getPassword()));
      cs.setPath("/");
      String sn = request.getServerName();
      int j = sn.indexOf(".");
      if(j != -1 && sn.charAt(sn.length() - 1) > 96)
          cs.setDomain(sn.substring(j));
      response.addCookie(cs);
  }
  out.print("<script>mt.show('会员注册成功！',1,'"+h.get("nexturl")+"');</script>");
  return;
}
String nexturl="/html/jskxcbs/folder/14010980-1.htm";
if(h.get("nexturl")!=null){
	nexturl=h.get("nexturl");
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
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<table border="0" cellpadding="0" cellspacing="0" class="regtable">

  <tr>
    <td align="right" class="td01"><span>*</span>用户名：</td>
    <td><input class="in text1" name="member" onfocus="mt.f_m(this)" onblur="mt.f_m(this)" min='4' maxlength="20" alt="用户名"><span id="member_info"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01"><span>*</span>电子邮箱：</td>
    <td><input class="in text2" name="email" value="" onfocus="mt.isEmail(this)" onblur="mt.isEmail(this)" alt="电子邮箱"><span id="email_info"></span><span class="ts"></span>
  </tr>
  <tr>
    <td align="right" class="td01"><span>*</span>请设置密码：</td>
    <td><input class="in text3" type="password" name="password" onfocus="mt.f_p(this)" onblur="mt.f_p(this)" min='6' maxlength="20" alt="密码"><span id="password_info"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01"><span>*</span>请确认密码：</td>
    <td><input class="in text3" type="password" name="password2" onfocus="mt.f_2(this)" onblur="mt.f_2(this)" alt="确认密码"><span id="password2_info"></span></td>
  </tr>
  <!--
  <tr>
    <td align="right" nowrap="nowrap" class="td01">现在工作地址：</td>
    <td colspan="3"><script>mt.city("city0","city1",null,"");</script></td>
  </tr>
  -->
  <tr>
    <td align="right" class="td01"><span>*</span>验证码：</td>
    <td><table border="0" cellpadding="0" cellspacing="0"><tr><td style="margin:0px;padding:0px;border:none;"><input name="verify" onfocus="mt.f_v(this,true)" onblur="mt.f_v(this,false)" size="5" alt="验证码"></td><td style="border:none;margin:0px;padding:0px;"><img id="t_verify" src="/NFasts.do?community=<%=h.community%>&act=verify" style="margin-left:3px;margin-top:1px;"></td><td style="border:none;margin:0px;padding:0px;"><a href="javascript:mt.verify()" style="padding-left:3px;">看不清,换一张</a></td></tr></table><span id="verify_info"></span></td>
  </tr>
</table>
<div class="agree">
<p><input type="checkbox" class="xy" name="agreement" alt="会员协议"/>我已阅读并同意 <a class="Agreement" href="/html/Home/folder/14050395-1.htm" target="_blank">《点击阅读用户注册协议》</a></p>
<p><input type="submit" class="button_reg" value="提交注册"></p>
</div>
</form>
