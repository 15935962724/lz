<%@page contentType="text/html;charset=utf-8" %>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="java.util.*"%>
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

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>
function f_edit(v)
{
	form1.nexturl.value=location;
	form1.id.value=v;
	form1.act.value="edittraveltype";
	form1.method="get";
	form1.submit();
}
function f_delete(v)
{
    if(window.confirm('您确定要删除此内容吗？'))
    {
    	form1.nexturl.value=location;
    	form1.act.value="deletetraveltype";
		form1.id.value=v;
		form1.submit();
	}
}
</script>
</head>
<body>
<h1>编辑类型</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/jsp/type/travel/EditTravelType.jsp"  method="post">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="nexturl" >
<input type="hidden" name="act" >
<input type="hidden" name="id" >

<table align="center" border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
    <td>类型ID</td>
    <td>类型</td>
    <td>操作</td>
  </tr>
  <%
	Enumeration e=TravelType.find(teasession._strCommunity,"");
	while(e.hasMoreElements())
	{
	int id=((Integer)e.nextElement()).intValue();
	TravelType tt=TravelType.find(id);
%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><%=id%></td>
    <td><%=tt.getName()%></td>
    <td>
    <input type="button" onclick="javascript:f_edit(<%=id%>)" value="编辑">
    <input type="button" onclick="javascript:f_delete(<%=id%>)" value="删除">
	</td>
  </tr>
  <%
}
%>
  <tr>
    <td align="center"></td>
  </tr>
</table>
<input type="button" onclick="javascript:f_edit(0)" value="添加">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
