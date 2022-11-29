<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

Resource r=new Resource();

String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl="/jsp/cio/RegCioMemberSuccess.jsp?community="+teasession._strCommunity;
}
if("POST".equals(request.getMethod()))
{
  out.print("<script>form1=parent.document.form1;");
  try
  {
    String cioinvitecode=request.getParameter("cioinvitecode");
    String member=request.getParameter("member");
    String password=request.getParameter("password");
    CioInviteCode cic=CioInviteCode.find(cioinvitecode);
    out.print("form1.sb.value='注册'; form1.sb.disabled=false;");
    if(!cic.isExists())//||cic.getMember()!=null
    {
      out.print("alert('对不起,邀请码不存在或已使用.请重新输入.'); form1.cioinvitecode.focus();");
    }else
    if(Profile.isExisted(member))
    {
      out.print("alert('对不起,用户名已经存在,请使用其它用户名.'); form1.member.focus();");
    }else
    {
      Profile.create(member,password,teasession._strCommunity,null,request.getServerName());
      CioCompany.create(0,teasession._strCommunity,member,null,null,null,null,null,null,null,null);
      cic.set(member,request.getRemoteAddr());
      session.setAttribute("tea.RV", new tea.entity.RV(member));
      out.print("alert('注册成功,请立即登陆,填写报名表.'); form1.sb.value='跳转中,请稍候...'; parent.location.replace('"+nexturl+"');");
    }
  }finally
  {
    out.print("</script>");
  }
  return;
}


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_submit()
{
  if(submitText(form1.cioinvitecode,'无效-邀请码')&&submitMemberid(form1.member,'无效-用户名')&&submitText(form1.password,'无效-密码')&&submitEqual(form1.password,form1.cp,'两次密码输入的不相同'))
  {
    form1.sb.value="注册中,请稍候...";
    form1.sb.disabled=true;
    return true;
  }
  return false;
}
</script>
</head>
<body id="qiyelog" onLoad="form1.cioinvitecode.focus();">
<div id="qiyelog_01">
<div id="qiyelog_02">
<div id="title_01"></div>
<div id="title_02"><h1>地方企业注册</h1></div>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<iframe src="about:blank" name="dialog" style="display:none"></iframe>
<form name="form1" action="?" method="post" onSubmit="return f_submit();" target="dialog">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<div id="qiy_xx">
<table border='0' cellpadding='0' cellspacing='0' id='tablecenter_center'>
<tr>
  <td ID="table_tr_img">&nbsp;</td>
  <td class="table_tr_td02">邀请码</td>
  <td class="table_tr_td03"><input type="text" name="cioinvitecode">　*</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td class="table_tr_td02">&nbsp;</td>
  <td class="tablecenter_text">请输入您收到资料上的参会邀请码，没有输入正确的参会邀请码不能注册会员并报名参会。</td>
</tr>
<tr id="teshu_tr">
  <td>&nbsp;</td>
  <td class="table_tr_td02">&nbsp;</td>
  <td class="table_tr_td03">&nbsp;</td>
</tr>
<tr>
  <td ID="table_tr_img">&nbsp;</td>
  <td colspan="2" class="tablecenter_text">请输入您收到资料上的参会邀请码，没有输入正确的参会邀请码不能注册会员并报名参会。</td>
</tr>
<tr>
<td>&nbsp;</td>
  <td class="table_tr_td02">用户名</td>
  <td class="table_tr_td03"><input type="text" name="member">　*</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td class="table_tr_td02">密码</td>
  <td class="table_tr_td03"><input type="password" name="password">　*</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td class="table_tr_td02">确认密码</td>
  <td class="table_tr_td03"><input type="password" name="cp">　*</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td class="table_tr_td02">&nbsp;</td>
  <td><input type="submit" name="sb" value="注册"> <input type="reset" value="返回"></td>
</tr>
</table>
</div>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</div>
</div>
<div id="footer02">
<div style="margin:15px 18px;line-height:20px;">
管理维护：国资委信息中心 　 电话：010-63192334  Email：webmaster@sasac.gov.cn<br/>
国资委总机：010-63192000 　 国资委地址：北京市宣武门西大街26号(100053)  京ICP备030066号<br>
<span style="color:#B04B00;font-size:16px;font-weight:bold;display:block;margin-top:10px;">注意：此网站为演示网站，所有信息非真实信息！</span>
</div></div>
</body>
</html>
