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
		if(form1.area.value=="")
		{
			alert("请填城市!");
			return false;
		}
		if(form1.time_k.value=="")
		{
			alert("请您选择日期!");
			return false;
		}
		if(form1.time_j.value=="")
		{
			alert("请您选择日期!");
			return false;
		}
	}
</script>
<h1>出差登记</h1>

<div id="head6"><img height="6" src="about:blank"></div>
        

　  <br />
<form name=form1 METHOD=get  action="/servlet/EditEvection" onsubmit="return sub(this);">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <%
	String member = teasession._rv.toString();//当前用户
	AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity, member);
	if(au_obj.isExists())
	{
		out.print("<input type=\"hidden\" value="+au_obj.getUnit()+" name=\"unid\">");
		out.print("<input type=\"hidden\" value="+au_obj.getClasses()+" name=\"classes\">");
	}  		
   %>
     <tr id="tableonetr">
    	 <td nowrap>前往<input type="text" name="area" value="">地区</td>
   
         <td nowrap>由<input name="time_k" size="7"  value="" readonly><A href="###"><img onclick="showCalendar('form1.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
         至<input name="time_j" size="7"  value="" readonly><A href="###"><img onclick="showCalendar('form1.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
         </td>
         <td nowrap> <input type="submit" value="出差" name=""></td>
       </tr>
       <tr><td><input type="button" value="返回上一页" onClick="history.back();"></td></tr>
</table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



