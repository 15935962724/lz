<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.bbs.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{ 
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


String member= teasession.getParameter("member");
Profile p = Profile.find(member);

if("POST".equals(request.getMethod()))
{
	String contributorsreason = teasession.getParameter("contributorsreason");
	String str=null;
	if(p.getNocontributors()==0)
	{
		str="禁止用户投稿成功";
		p.setNocontributors(1);
	}else
	{
		str="用户可以投稿";
		p.setNocontributors(0);
	} 
	p.setContributorsreason(contributorsreason,teasession._nLanguage);
	
	out.print("<script>alert('"+str+"');window.returnValue=1;window.close();</script>");
	return;
}
 
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script type="text/javascript">
window.name='tar';
</script>
</head>
<body>
<h1>设置用户禁止投稿</h1>


<form name="form1" action="?" method="POST" target="tar">
<input type="hidden" name="member" value="<%=member %>"/>
<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr>
	<td align="right">禁止用户：</td>
	<td><%=member %></td>
</tr>
<tr>
	<td align="right">用户投稿当前状态：</td>
	<td><%if(p.getNocontributors()==0){out.print("<font color=Green>目前用户可以投稿</font>");}else{out.print("<font color=red>用户已经不能投稿了</font>");} %></td>
</tr>
<tr>
	<td align="right">禁止投稿原因：</td>
	<td><textarea rows="4" cols="40" name="contributorsreason"><%if(p.getContributorsreason(teasession._nLanguage)!=null&&p.getContributorsreason(teasession._nLanguage).length()>0){out.print(p.getContributorsreason(teasession._nLanguage));}else{out.print("您暂时不能发言!");} %></textarea></td>

</tr>

  </table>
<Br/>
<input type="submit" value="提交"/>&nbsp; <input type="button" value="关闭"  onClick="javascript:window.close();">
</form>

</body>
</html>
