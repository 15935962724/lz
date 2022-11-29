<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
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
String community=teasession._strCommunity;



if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}


int eid = Integer.parseInt(teasession.getParameter("eid"));
Eventregistration eobj = Eventregistration.find(eid);

if(!eobj.getMember().equals(teasession._rv.toString()))
{
	out.println("您没有权限评论");
	return;
}


if("POST".equals(request.getMethod()))
{
	int score = 0;
	if(teasession.getParameter("score")!=null && teasession.getParameter("score").length()>0)
	{
		score = Integer.parseInt(teasession.getParameter("score"));
	}
	if(score>0){
		eobj.setScore(score);
		out.print("<script>alert('您的评论成功');window.close();</script>");
	}

	out.print("<script>window.close();</script>");
	return;
}




%>
<html>
<base target="tar"/>
<title>我要评价</title>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>
  <script src="/tea/city.js"></script>
</HEAD>

<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<script type="text/javascript">
window.name='tar';

</script> 

<h2>我要评价</h2>
<form name="form1" action="?" method="POST" target="tar" >
<input type="hidden" name="eid" value="<%=eid %>">

<input type="hidden" name="community" value="<%=teasession._strCommunity%>">


<input type="hidden" name="act" >



<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
 
      <td nowrap >感谢您对活动的支持，请对此次活动进行评价</td>

</tr>

 <tr id="tableonetr">
 
      <td nowrap ><%
      	for(int i=1;i<eobj.SCORE_TYPE.length;i++)
      	{
      		out.print("<input type=radio name=score value="+i);
      		if(eobj.getScore()==i)
      		{
      			out.print(" checked");
      		}
      		out.print(">"+eobj.SCORE_TYPE[i]);
      		out.print("&nbsp;");
      	}
      %></td>

</tr>
 <tr id="tableonetr">
 
      <td nowrap align="center" ><input type="submit""  value="提交"></td>

</tr>

</form>
</body>
</html>
