<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="tea.entity.integral.*" %>
<%@ page import="tea.entity.admin.orthonline.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

//判断是否登录，必须登录才能操作积分

Community obj = Community.find(teasession._strCommunity);
String member ="";
if(teasession._rv == null)
{
	if(Community.find(teasession._strCommunity).getIscheck()!=null && Community.find(teasession._strCommunity).getIscheck().indexOf("/3/")!=-1)
	{
  		out.println("<script  language='javascript'>alert('您还没有登录,只有登录用户才可以下载本站点的资源!');window.location.href='/servlet/Node?node=" + obj.getLogin() + "&language=" + teasession._nLanguage + "';</script> ");
	}
}else if(teasession._rv!=null)
{ 
	member = teasession._rv.toString(); 
} 
Files fobj = Files.find(teasession._nNode,teasession._nLanguage);

/*
if(fobj.getPointlimit() > 0) ////判断是否有课件积分限制
{
  if(profile.getIntegral() > 0 && profile.getIntegral() >= fobj.getPointlimit()) //积分为整数，可以下载
  {
   float i = profile.getIntegral() - fobj.getPointlimit();
    profile.setIntegral(i);
  } else
  {
    out.println("<script  language='javascript'>alert('您的积分不足,不能下载此文件!');window.location.href='/html/files/" + teasession._nNode + "-" + teasession._nLanguage + ".htm';</script> ");
    return;
  }
} else
*/ 
if(Community.find(teasession._strCommunity).getIscheck()!=null && Community.find(teasession._strCommunity).getIscheck().indexOf("/3/")!=-1)
{
	Profile profile = Profile.find(member);

	//类别限制的积分

	NodePoints np=NodePoints.get(teasession._nNode);

	Integral iaobj = Integral.find(Integral.getIgid(teasession._strCommunity,41,0));
	if(np.getXzzy() > 0) //类别积分有限制
	{
	  if(profile.getIntegral() > 0 && profile.getIntegral() >= np.getXzzy()) //个人积分大于下载积分 可以下载
	  {
	   //float i = profile.getIntegral() - iaobj.getXzzy();
	   // profile.setIntegral(i);
	   
	   
	Node node=Node.find(teasession._nNode);
	// 扣下载者积分
	Profile dp=Profile.find(teasession._rv.toString());
	dp.addIntegral(-np.getXzzy(),dp.getProfile());
	
	
	// 上传者加积分
	Profile up=Profile.find(node.getCreator()._strV);
	up.addIntegral(np.getZybxz(),up.getProfile());
	
	 IntegralRecord.create(teasession._strCommunity, dp.getMember(),-np.getLlwz(), 9, teasession._nNode, up.getMember());
	
	IntegralRecord.create(teasession._strCommunity, up.getMember(),np.getZybxz(), 7, teasession._nNode, dp.getMember());
	
	 if(teasession._rv!=null)     
	      Logs.create(teasession._strCommunity, teasession._rv, 100, teasession._nNode, "down");
	  } else
	  {
	    out.println("<script  language='javascript'>alert('您的积分不足,不能下载此文件!');window.location.href='/html/files/" + teasession._nNode + "-" + teasession._nLanguage + ".htm';</script> ");
	    return;
	  }
	}
}



//if(fobj.getNamepath().indexOf("http://") != -1 || fobj.getNamepath().indexOf("www.") != -1) //找到字符
//{
 // out.println("<script>window.location.href='" + fobj.getNamepath() + "';</script>");
//} else
//{

  

String p = "/jsp/type/files/DownFile.jsp?uri=" + java.net.URLEncoder.encode(fobj.getNamepath(),"UTF-8") + "&name=" + java.net.URLEncoder.encode(fobj.getName(),"UTF-8");
  //out.println("<script>window.location.href='" + p + "';</script>");
   response.sendRedirect(p);
//}

 


  %>


