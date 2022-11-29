<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%


Http h=new Http(request);

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}
//h.member=teasession._rv.toString();

%>

<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
	  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}

</script>
<script src='/tea/mt.js'></script>
<form method="post" action="/servlet/ChangePassword" target="_ajax" onSubmit="return mt.check(this);">
<input type="hidden" name="community" value="<%=h.community%>"/>

<table border="0" cellpadding="0" cellspacing="0" class="PassWordtable">
<%-- <%
Profile p=Profile.find(h.member);
if(p.getMembertype()==1)
{
%>
  <tr style="display:none;">
    <td align="right">会员编号：</td>
    <td align="left"><%=p.code%>　　　绑定账号：<%=h.username%></td>
  </tr>
<%
}
%> --%>
  <tr>
    
    <td align="left"><input placeholder="请输入您旧密码" type="password" name="old" alt="旧密码" class="txt1"></td>
  </tr>
  <tr>
    
    <td align="left"><input placeholder="请输入您新密码" type="password" name="password" alt="新密码" class="txt1"></td>
  </tr>
  <tr>
    
    <td align="left"><input placeholder="确认密码" type="password" name="password2" alt="确认新密码" class="txt1"></td>
  </tr>
  <tr>
  	<td class="submitTd"><input type="submit" value="修改密码" class="tijiao"></td>
  </tr>
</table>



</form>

<script>
mt.fit();
</script>
