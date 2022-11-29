<%@page import="tea.entity.util.Card"%>
<%@page import="tea.entity.westrac.WestracClue"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


if(teasession._rv==null)
{
	out.println("<script>alert('您还没有登录，不能查看，请先登录...');window.location.href='/html/folder/41-1.htm';</script>");
	return;
}


Profile pobj = Profile.find(teasession._rv._strR);

if(pobj.getMembertype()!=1)
{
	//不是俱乐部会员
	out.println("<script>alert('您还不是履友会员，请到个人中心升级为履友会员,如果你已经升级，请等待管理员审核...');window.location.href='/html/folder/3-1.htm';</script>");
	return;
}
   

%>