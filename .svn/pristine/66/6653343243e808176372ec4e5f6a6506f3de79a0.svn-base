<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.net.*" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/html/folder/30787-1.htm");
  return;
}
String moid = MemberOrder.getMemberOrder(teasession._strCommunity,MemberOrder.getMemberType(teasession._strCommunity,teasession._rv._strR),teasession._rv._strR);
MemberOrder mobj = MemberOrder.find(moid);

//判断登陆用户是否邮寄发票
Profile pobj = Profile.find(teasession._rv.toString());


if(pobj.getNewlockingdata()!=null && Entity.countDays(Entity.sdf.format(new Date()), Entity.sdf.format(pobj.getNewlockingdata()))>0)
{
	out.print("<script langage=\"javascript\">alert('您的用户已经被管理员锁定，有问题请联系网站管理员。');window.close();</script>");
	   return;	
}



	//邮寄发票
	UpgradeMember umobj = null;

	 Enumeration e = UpgradeMember.find(teasession._strCommunity," and member= "+DbAdapter.cite(teasession._rv.toString())+" ORDER BY becometime DESC ",0,1);
	   if(e.hasMoreElements())
	   {
		    int u = ((Integer)e.nextElement()).intValue();
		     umobj = UpgradeMember.find(u);
	   }

	   if(umobj!=null && umobj.getInvoicetype()==1 && mobj.getMembertype()==2 && mobj.getPeriod()==0)//只有是数字报会员才能判断
	   {

		   //判断添加时间
		   int d = Entity.countDays(Entity.sdf.format(umobj.getTimes()),Entity.sdf.format(new Date()));

		   if(d>=30)
		   {
			   out.print("<script langage=\"javascript\">alert('您开通已经30天啦，还没有汇款，请汇款后在查看，有问题请联系网站管理员。');window.close();</script>");
			   return;
		   }

	   }








AdminUsrRole auobj = AdminUsrRole.find(teasession._strCommunity, teasession._rv.toString());
boolean f = false;
if(auobj.getRole()!=null && auobj.getRole().length()>0 && auobj.getRole().split("/").length>1)
{
	f = true;
}

if(mobj.getBecometime()!=null&&!"null".equals(mobj.getBecometime())&&String.valueOf(mobj.getBecometime()).length()>0 || f )//数字报会员的有效期
{

  int d =1;
  if(!f)
  {
    d = Entity.countDays(Entity.sdf.format(new Date()),Entity.sdf.format(mobj.getBecometime()));
  }

if(d>=1)
{
			//response.sendRedirect("/html/folder/27198-1.htm");
%>
<script>
function a(){window.status="欢迎您查看数字报";}
window.setInterval("a()",1);

var b;
function show(a)
{
  if(b)return;
  b=true;

  for(var i=0;i<2;i++)
  {
    var t=document.getElementById('ifr'+i);
    if(t==a)continue;
    t.parentNode.removeChild(t);
  }
}
</script>
<style type="text/css">
<%--
#apDiv1
	position:absolute;
	width:100%;
	height:100%;
	z-index:1;
	left: 0px;
	top: 0px;

<div id="apDiv1" oncontextmenu="return false;"></div>
--%>
</style>


<body style="padding:0px;margin:0px;overflow:hidden">
<iframe id="ifr0" src="http://59.252.162.9:8080/bzdbdl/" width=100% height=100% frameborder=0 onload="show(this)" onreadystatechange="show(this)"></iframe>

<iframe id="ifr1" src="http://10.1.114.27:8080/bzdbdl/" width=100% height=100% frameborder=0 onload="show(this)" onreadystatechange="show(this)"></iframe>
</body>


<%
}else
{
  response.sendRedirect("/html/folder/30810-1.htm");
}
}else
{
  response.sendRedirect("/html/folder/30810-1.htm");
}

%>

