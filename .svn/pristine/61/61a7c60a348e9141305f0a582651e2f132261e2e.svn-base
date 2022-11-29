<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<script>
	function sub()
	{
		if(form1.time_s.value=="")
		{
			alert("请你选择日期!");
			return false;
		}
		if(form1.time_e.value=="")
		{
			alert("请您选择日期!");
			return false;
		}
	}
</script>
<h1>上下班记录查询</h1>
<div id="head6"><img height="6" src="about:blank"></div>
          <br />
          <%String day = DutyClass.GetNowDate(); %>
<form name=form1 METHOD=post  action="/jsp/admin/manage/seereport.jsp" onsubmit="return sub(this);">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>起始日期：<input name="time_s" size="10"  value="<%=day %>"  readonly><A href="###"><img onclick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    	 &nbsp;截止日期：<input name="time_e" size="10"  value="<%=day %>"  readonly><A href="###"><img onclick="showCalendar('form1.time_e');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    	<input type="submit" name="" value="查询" >
    	 </td>

    </tr>
</table>
</form>
</body>
</html>



