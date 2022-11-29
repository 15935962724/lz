<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.member.*" %>
<%@include file="/jsp/Header.jsp"%>
<%

String member=teasession._rv.toString();
Profile profile_obj=Profile.find(member);
if("POST".equals(request.getMethod()))
{
  String old=request.getParameter("old");
  String newp=request.getParameter("newp");
  out.print("<script>");
  if(!old.equals(profile_obj.getPassword()))
  {
    out.print("alert('旧密码 填写错误!');");
  }else
  {
    profile_obj.setPassword(newp);
    out.print("alert('密码修改成功!');");
  }
  out.print("window.open('?node="+teasession._nNode+"','_self');</script>");
  return;
}

%>
<div class="title"><h2>修改密码</h2><span>会员ID：<%=profile_obj.getMember()%></span></div>
<script language="javascript" src="/tea/tea.js"></script>
<form name="form_pwd" method="POST" action="?" onsubmit="return submitText(this.newp,'新密码不能为空!')&&submitLength(6,20,this.newp,'密码长度必需在6-20位之间!')&&submitEqual(this.newp,this.cp,'您输入的两次密码不相同!')">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<div id="tablecenter02">
<table>
 <tr>
    <td class="left">差点会员号码：</td><td><b><%=profile_obj.getMember()%></b></td>
  </tr>
  <tr>
    <td class="left">差点信用卡号：</td><td><b><%=profile_obj.getCreditcard()%></b></td>
  </tr>
  <tr>
    <td class="left">旧密码：</td><td><input type="password" name="old" value=""/></td>
    <td class="Prompt">首次登陆系统默认密码为 888888</td>
  </tr>
  <tr>
    <td class="left">新密码：</td><td><input type="password" name="newp" size="20" value=""/></td>
    <td class="Prompt">密码可由大小写英文字母、数字及“_”、“-”组成长度6-20个字符</td>
  </tr>
  <tr>
    <td class="left">确认密码：</td><td><input type="password" name="cp" value=""/></td>
    <td class="Prompt">请再次输入您设置的密码</td>
  </tr>
 </table>
 </div>
<div class="submit"><input  class="input1" type="submit" value="" />  <input type="button" value="" class="input2" onclick="history.back();" /></div>
</form>
<script>form_pwd.old.focus();</script>
