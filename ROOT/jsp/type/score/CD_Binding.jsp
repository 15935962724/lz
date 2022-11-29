<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.member.*" %>
<%@include file="/jsp/Header.jsp"%>
<%
Http h=new Http(request);
if(h.key!=null)//邮件验证
{
  String info="验证信息错误!";
  Profile p=Profile.find(h.get("me"));
  if(h.key.equals(p.getVerify()))
  {
    p.setEmail(h.get("em"));
    info="E-Mail验证成功!";
  }
  out.print("<script>alert('"+info+"');window.open('/','_self');</script>");
  return;
}
String member=teasession._rv.toString();
Profile profile_obj=Profile.find(member);

%>
<div class="title"><h2>绑定用户名</h2><span>会员ID：<%=profile_obj.getMember()%></span></div>
<script language="javascript" src="/tea/tea.js"></script>
<form name="form_bin" method="POST" action="?" onsubmit="return submitText(this.code,'“用户名”不能为空!')&&submitLength(3,20,this.code,'“用户名”长度必需在6-20位之间!')">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<div id="tablecenter02">

<%
if("POST".equals(request.getMethod()))
{
  String code=h.get("code");
  String mobile=h.get("mobile");
  String email=h.get("email");
  if(Profile.find(" AND member!="+DbAdapter.cite(member)+" AND code="+DbAdapter.cite(code),0,1).hasMoreElements())
  {
    out.print("<script>alert('“"+code+"”已经存在！');history.back();</script>");
    return;
  }
  profile_obj.setCode(code);
  if(mobile!=null)profile_obj.setMobile(mobile);
  String old=profile_obj.getEmail();
  if(!old.equals(email))
  {
    out.print("<span id='minfo'>正发送电子邮件....</span><script>var minfo=document.getElementById('minfo');function f_info(s){minfo.innerHTML=s;}</script>");
    out.flush();
    String sn=request.getServerName(),webn=Community.find(h.community).getName(h.language),url="http://" + sn+"/jsp/type/score/CD_Binding.jsp?community="+h.community+"&me="+Http.enc(member)+"&em="+email+"&key="+Http.enc(MT.enc(profile_obj.getVerify()));
    String c="你好," + member + "( " + email + " ): <BR><BR>" + "感谢您注册 <A href=http://" + sn + ">" + webn + "</A> 帐户。请按下面的说明操作，确认您注册了此帐户，如果您没有注册，请删除此信。<BR><BR><BR>" + "确认帐户<BR>" + "为了有助于防止未经授权的帐户创建，我们需要确认您的新帐户的电子邮件地址，这样还可以确保我们发送给您的重要信息能够到达您的帐户，此外，我们网站上的一些服务也可能需要经过确认的电子邮件地址 。<BR><BR>" + "若要确认此电子邮件地址，请选择并复制下列链接。打开浏览器窗口并将其粘贴到地址栏中，然后按键盘上的 Enter 或回车键，然后按照显示的指令操作。<BR><BR>" + "<a href=\""+url+ "\">" + url + "</a>"+
    "<BR><BR><BR>" + "要点<BR>" + "为了有助于保证您个人信息的安全，" + webn + " 建议您永远不要单击未经请求的电子邮件中的链接，该链接可能会要求您输入您的凭据（电子邮件和密码），不要单击此类链接，而要将其复制并粘贴到网络浏览器的地址栏中。我们也可能会向您发送包含链接的电子邮件，该链接是为了便于您使用而提供的。";
    boolean flag=Email.create(h.community,null,email,webn+":确认您的电子邮件地址",c);
    if(flag)
    {
      out.print("<script>f_info(\""+(flag?"邮件已发送! 需验证后才能修改!":"邮件发送失败! 请确定填写正确的邮件地址!")+"\");</script>");
    }
    //profile_obj.setEmail(email);
  }else
  out.print("<script>alert('修改成功!');history.back();</script>");
  return;
}

%>
<table>
 <tr>
    <td class="left">差点会员号码：</td><td><%=profile_obj.getMember()%></td>
  </tr>
  <tr>
    <td class="left">差点信用卡号：</td><td><%=profile_obj.getCreditcard()%></td>
  </tr>
  <tr>
    <td class="left">绑定用户名：</td><td><input name="code" value="<%=profile_obj.getCode()%>" mask="exists"/></td>
    <td class="Prompt">可由大小写英文字母、汉字、数字组成长度6-20个字符，方便您以后登录</td>
  </tr>
  <%--
  <tr>
    <td class="left">绑定手机号：</td><td><input name="mobile" value="<%=profile_obj.getMobile()%>" mask="int"/></td>
    <td class="Prompt">请输入您常用的手机号码，方便您登录、找回密码</td>
  </tr>
  --%>
  <tr>
    <td class="left">电子邮箱：</td><td><input name="email" value="<%=profile_obj.getEmail()%>" /></td>
    <td class="Prompt">请输入您常用的电子邮箱，方便您登录、找回密码</td>
  </tr>
 </table>
</div>
<div class="submit"><input class="input1"  type="submit" value="" />  <input type="button" value="" class="input2" onclick="history.back();" /></div>
</form>
<script>form_bin.member.focus();</script>
