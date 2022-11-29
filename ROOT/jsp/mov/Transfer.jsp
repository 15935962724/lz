<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
//if(teasession._rv==null)
//{
//  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
//  return;
//}

String nexturl = teasession.getParameter("nexturl");
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);

int membertype = 0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
  membertype = Integer.parseInt(teasession.getParameter("membertype"));
}


 MemberType myobj = MemberType.find(membertype);
 RegisterInstall riobj = RegisterInstall.find(membertype);
 boolean f = false;
 //判断用户是否登录
 if(teasession._rv!=null)
 {
   f=MemberRecord.isMemberRecord(teasession._rv.toString(),teasession._strCommunity,myobj.getAbove());
 }
 //如果用户登录 则有给予的会员 ，则提示用户先注册给予的会员

if(myobj.getAbove()>0&&!f)
{
  // out.print(RegisterInstall.getNavigation(membertype,teasession._nLanguage,"lzj_zccg",1));
      MemberType obj = MemberType.find(myobj.getAbove());
      out.print("<script>alert('您必须注册成为【"+obj.getMembername()+"】的会员,才能成为【"+myobj.getMembername()+"】会员.');window.location.href='"+nexturl+"';</script>");
}else
{
  String url = null;
  if(riobj.getClause()==0)
  {
    url="/jsp/mov/register.jsp";
   //url="/jsp/orth/choice.jsp";
  }else if(riobj.getClause()==1)
  {
    url="/jsp/mov/SigUp.jsp";
   //url="/jsp/orth/choice.jsp";
  }
  response.sendRedirect(url+"?community="+teasession._strCommunity+"&membertype="+membertype);
  return;
}




%>



