<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.subscribe.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource();
r.add("/tea/ui/node/general/EditNode");

String nexturl = request.getRequestURL() + "?node="+teasession._nNode+"&community="+teasession._strCommunity + request.getContextPath();


Pageinform pfobj = Pageinform.find(Pageinform.getPfid(teasession._nNode,teasession._strCommunity));

//提交信息
if("POST".equals(request.getMethod()))
{
	int pagenumber =0;
	if( teasession.getParameter("pagenumber")!=null &&  teasession.getParameter("pagenumber").length()>0)
	{
		pagenumber = Integer.parseInt(teasession.getParameter("pagenumber"));
	}
	String pagename = teasession.getParameter("pagename");
	
	if(pfobj.isExists())
	{
		pfobj.set(pagenumber,pagename);
		
	}else
	{ 
		Pageinform.create(pagenumber,pagename,teasession._nNode,teasession._strCommunity);
	}
	out.print("<script>alert('报纸设置成功!');window.returnValue=1;window.close();</script>");
	return;
}

 
%>
<html>
<head>
<title>报纸信息管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body scroll="yes">
<script>
window.name='tar';
</script>

<h1>报纸设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST"  target="tar"  >
<input type="hidden" name="pfid" />
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="nexturl_2" value="<%=nexturl %>"/>  
<input type="hidden" name="act"> 

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right">设置报纸版次：</td>
      <td><input type="text" name="pagenumber" value="<%=pfobj.getPagenumber() %>"></td>
	</tr>
	    <tr>
      <td align="right">设置电子报上传路径(服务器路径)：</td>
      <td><input type="text" name="pagename" value="<%if(pfobj.getPagename()!=null)out.print(pfobj.getPagename()); %>">(例如:d:\newspaper)</td>
	</tr>
	</table>
	<br/>
	<input type="submit" value="　提交设置　">
</form>
</body>
</html>
