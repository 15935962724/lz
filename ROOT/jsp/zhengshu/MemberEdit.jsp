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
ProfileBBS pb=ProfileBBS.find(h.community,String.valueOf(h.member));
if("POST".equals(request.getMethod()))
{
  pb.set(h.language,h.get("title"),pb.getPortrait(h.language),h.get("signature"));
  p.setProvince(h.getInt("city1",h.getInt("city0")),h.language);
  p.setAddress(h.get("address"),h.language);
  out.print("<script>parent.mt.show('资料修改成功！',1,'parent.location.reload()');</script>");
  return;
}

%>
<script src="/tea/city.js"></script>
<script type="text/javascript">
mt.re=function(cc){
	form1.photo.value=document.getElementById("ccc").src=cc;
};

</script>
<form method="post" action="?" target="_ajax" onSubmit="return mt.check(this);">
<input type="hidden" name="community" value="<%=h.community%>"/>
<div class="con">
<div class="left"><img id="ccc" src="<%=out.print("<script>form1.photo.value</script>")==null?"":"" %>../type/bbs/default_bbsphoto/index.jpg" /><br>
<a href="###" onclick="mt.show('/jsp/zhengshu/MemberSetAvatar.jsp?community=<%=h.community%>',2,'修改您的头像',450,277)">上传头像</a>
<span class="tix">请尽量使用英文名称的图片上传！</span>
</div>
</div>
</form>
