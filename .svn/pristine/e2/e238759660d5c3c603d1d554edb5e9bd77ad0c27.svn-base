<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.league.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="tea.entity.league.*" %>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.integral.*" %> 
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String act =teasession.getParameter("act");
String field = teasession.getParameter("field");//修改的积分字段
float fieldvalude = 0;//修改积分字段的数值
if(teasession.getParameter("fieldvalude")!=null && teasession.getParameter("fieldvalude").length()>0)
{
  fieldvalude = Float.parseFloat(teasession.getParameter("fieldvalude"));
}

 //注册会员的系列设置
if("MemberType".equals(act))
{

  
	CommunityPoints iobj = CommunityPoints.find(CommunityPoints.getIgid(teasession._strCommunity));
  if(iobj.isExists())//说明库里面有记录
  {
    iobj.set(field,fieldvalude);
  }else
  {
    CommunityPoints.create(field,fieldvalude,teasession._strCommunity);
  }
  
  return;
}else if("CLicense".equals(act))//类别积分设置
{
  //类别 的 id号
  int  clid= 0;
  if(teasession.getParameter("clid")!=null && teasession.getParameter("clid").length()>0)
  {
    clid = Integer.parseInt(teasession.getParameter("clid"));
  }
  Integral iobj = Integral.find(Integral.getIgid(teasession._strCommunity,clid,0));
  if(iobj.isExists())//说明库里面有记录
  {
    iobj.set(field,fieldvalude,teasession._rv.toString());
  }else
  {
    Integral.create(field,fieldvalude,clid,0,teasession._strCommunity,teasession._rv.toString());
  }
  return;
}
else if("TypeAlias".equals(act))
{
  //类别 的 id号
  int  taid= 0;
  if(teasession.getParameter("taid")!=null && teasession.getParameter("taid").length()>0)
  {
    taid = Integer.parseInt(teasession.getParameter("taid"));
  }
  int tatype = 0;
  if(teasession.getParameter("tatype")!=null && teasession.getParameter("tatype").length()>0)
  {
    tatype = Integer.parseInt(teasession.getParameter("tatype"));
  }

  Integral iobj = Integral.find(Integral.getIgid(teasession._strCommunity,tatype,taid));
  if(iobj.isExists())
  {
    iobj.set(field,fieldvalude,teasession._rv.toString());
  }else
  {
    Integral.create(field,fieldvalude,tatype,taid,teasession._strCommunity,teasession._rv.toString());
  }
  return;

}
%>

