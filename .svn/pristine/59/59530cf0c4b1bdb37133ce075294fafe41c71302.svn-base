<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%


Http h=new Http(request);

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}
//h.member=teasession._rv.toString();

Profile p=Profile.find(h.member);
ProfileBBS pb=ProfileBBS.find(h.community,p.getMember());

if("POST".equals(request.getMethod()))
{
  pb.set(h.language,h.get("title"),h.get("portrait"),h.get("signature"));
  p.setProvince(h.getInt("city1",h.getInt("city0")),h.language);
  p.setAddress(h.get("address"),h.language);
  p.setEmail(h.get("email"));
  p.setMobile(h.get("mobile"));
  p.setLastName(h.get("name").substring(0,1),h.language);
  p.setFirstName(h.get("name").substring(1),h.language);
  out.print("<script>parent.mt.show('资料修改成功！',1,'parent.location.reload()');</script>");
  return;
}

%>
<!DOCTYPE html><html><head>
<script>
document.write(parent.document.getElementsByTagName('HEAD')[0].innerHTML);
var arr=parent.document.getElementsByTagName('LINK');
for(var i=0;i<arr.length;i++)document.write('<link href='+arr[i].href+' rel='+arr[i].rel+' type=text/css>');
</script></head>
<body class=ifrmemberview>


<script src="/tea/city.js"></script>
<form name="form2" method="post" action="?" target="_ajax" onSubmit="return mt.check(this);">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="portrait" value="<%=pb.getPortrait(h.language)%>"/>
<div class="title">我的资料</div>
<div class="con">
<div class="left"><img src="<%=pb.getPortrait(h.language)%>" id="_avatar" /><br>
<a href="###" onclick="mt.show('/jsp/custom/westrac/MemberSetAvatar.jsp?community=<%=h.community%>',2,'修改您的头像',450,277)">上传头像</a>
<span class="tix">请尽量使用英文名称的图片上传！</span>
</div>
<div class="right">
<table border="0" cellpadding="0" cellspacing="0">
<tr id="tableonetr">
    <td align="right" nowrap="nowrap">个人基本信息</td>
    <td colspan="3"></td>
  </tr>
  <tr>
    <td align="right">用户名：</td>
    <td colspan="3" align="left"><%=h.username%></td>
  </tr>
  <tr>
    <td align="right">真实姓名：</td>
    <td colspan="3" align="left"><input name="name" value="<%=MT.f(p.getName(h.language))%>" /></td>
    
  </tr>
  <tr>
    <td align="right">邮箱：</td>
    <td colspan="3" align="left"><input name="email" value="<%=MT.f(p.getEmail())%>"/></td>
  </tr>
  <tr>
    <td align="right">手机：</td>
    <td colspan="3" align="left"><input name="mobile"  value="<%=MT.f(p.getMobile())%>"/></td>
  </tr>
  <%--
  <tr>
    <td align="right">昵称：</td>
    <td><input name="title" value="<%=pb.getTitle(h.language)%>" alt="昵称"></td>
  </tr>--%>
  <tr>
    <td align="right" nowrap="nowrap">现在工作地址：</td>
    <td colspan="3" align="left"><script>mt.city("city0","city1",null,"<%=p.getProvince(h.language)%>");</script>&nbsp;<input name="address" value="<%=p.getAddress(h.language)%>" size="28"></td>
    </tr>
  <tr>
    <td align="right">签名设置：</td>
    <td colspan="3" align="left"><textarea name="signature" cols="40" rows="4"><%=MT.f(pb.getSignature(h.language))%></textarea></td>
  </tr>
   <tr>
    <td align="right"></td>
    <td align="center" colspan="3"><input type="submit" value="保存" class="submit"></td>
  </tr>
</table>

</div></div>
</form>
<script>
mt.receive=function(u)
{
  form2.portrait.value=u;
  $$('_avatar').src=u+'?t='+Math.random();
};
mt.fit();
</script>
