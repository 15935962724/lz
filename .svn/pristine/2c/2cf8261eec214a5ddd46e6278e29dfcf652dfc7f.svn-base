<%@page contentType="text/html;charset=utf-8" %>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}


int id =Integer.parseInt(request.getParameter("id"));
String nexturl=request.getParameter("nexturl");
String act=request.getParameter("act");
String name=request.getParameter("name");
if("POST".equals(request.getMethod()))
{
	if("edittraveltype".equals(act))
	{
		if(id>0)
		{
			TravelType tt=TravelType.find(id);
			tt.set(name);
		}else
		{
			TravelType.create(teasession._strCommunity,name);
		}
	}else if("deletetraveltype".equals(act))
	{
		TravelType tt=TravelType.find(id);
		tt.delete();
	}
	response.sendRedirect(nexturl);
	return;
}

if(id>0)
{
	TravelType tt=TravelType.find(id);
	name=tt.getName();
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="form1.name.focus();">
<h1>编辑类型</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" action="?" method="post" onSubmit="return submitText(this.name,'无效-名称');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act" value="<%=act%>">

<table align="center" border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>类型:</td><td><input name="name" value="<%if(name!=null)out.print(name);%>"></td>
  </tr>
</table>
<input type="submit" value="提交">
<input type="button" value="返回" onClick="history.back();">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

