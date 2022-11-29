<%@page import="java.util.Date"%>
<%@page import="tea.entity.Entity"%>
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
	String newreason = teasession.getParameter("newreason");
	int newlocking = 0;
	Date newlockingdata = new Date();
	if(teasession.getParameter("newlocking")!=null)
	{
		newlocking = Integer.parseInt(teasession.getParameter("newlocking"));
		newlockingdata = Entity.getDayTime(new Date(),newlocking );
	}
	
	p.setNewlockingdata(newlockingdata);
	p.setNewlocking(newlocking);
	p.setNewreason(newreason,teasession._nLanguage);
	
	out.print("<script>alert('操作成功');window.returnValue=1;window.close();</script>");
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
<h1>锁定用户是否能查看电子报</h1>


<form name="form1" action="?" method="POST" target="tar">
<input type="hidden" name="member" value="<%=member %>"/>
<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr>
	<td align="right">锁定用户：</td>
	<td><%=member %></td>
</tr>  
<tr>
	<td align="right">用户解锁日期为：</td>
	<td><%if(p.getNewlockingdata()!=null){out.println(Entity.sdf.format(p.getNewlockingdata()));} %></td>
</tr>

<tr>
	<td align="right">锁定天数：</td>
	<td><input type="text" name="newlocking" value="<%=p.getNewlocking()%>">(锁定日期为：<%if(p.getNewlockingdata()!=null){out.println(Entity.sdf.format(Entity.getSubDayTime(p.getNewlockingdata(),p.getNewlocking())));}%>)</td>
</tr>

<tr>
	<td align="right">锁定用户查看电子报原因：</td>
	<td><textarea rows="4" cols="40" name="newreason"><%if(p.getNewreason(teasession._nLanguage)!=null&&p.getNewreason(teasession._nLanguage).length()>0){out.print(p.getNewreason(teasession._nLanguage));} %></textarea></td>
</tr>

  </table>
<Br/>
<input type="submit" value="提交"/>&nbsp; <input type="button" value="关闭"  onClick="javascript:window.close();">
</form>

</body>
</html>
