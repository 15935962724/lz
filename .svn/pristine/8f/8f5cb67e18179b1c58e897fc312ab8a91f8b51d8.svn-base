<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);
int type = -1;//创建文件
if(teasession.getParameter("type")!=null)
{
  type = Integer.parseInt(teasession.getParameter("type"));
}
String member = "";//用户名
String nexturl = teasession.getParameter("nexturl");//request.getRequestURI()+"?type="+type+request.getContextPath();
String logurl = "";
if(teasession._rv==null)
{
	logurl = "/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+URLEncoder.encode(nexturl,"UTF-8");
}else
{
	member = teasession._rv.toString();
}



tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
%>

<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<script language='javascript' type='text/javascript'>    
var time =5; //倒计时的秒数    
var URL ;    
function Load(url)
{    
	URL =url;    
	for(var i=time;i>=0;i--)    
	{    
	window.setTimeout("doUpdate("+ i +")", (time-i) * 1000);    
	}    
}    
function doUpdate(num)    
{    
   document.getElementById("url_id").innerHTML = num;
 if(num == 0)
 {
    window.location=URL;
 }    
}     
</script>    
<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr> 
	<td align="center"><br>	  <img src="/res/REDCOME/1006/1006993.gif" width="300" height="150" /><br></td></tr><tr>
	  <td align="center" style="font-size: 18px;color: #0000FF;font-weight: bold;"><br><%
		
			if(type==0)//期次，阅读权限，以及版次不在策略查看内，需要订阅电子报 才能查看
			{
				//判断是否登录，如果不登陆则让登录后在去订阅
			
					out.print("您好：<br>您需要登录以后，才能订阅电子报<br>");
					out.print("系统会在&nbsp;<span id=\"url_id\" style=\"font-size:30px; color:#FF0000;\"></span>&nbsp;秒后，自动跳转到登录页面");
					out.print("<script> Load('"+logurl+"');</script>  ");
			
			}else if(type==1)
			{
				if(teasession._rv==null)
				{
					out.print("您需要登录以后，才能查看电子报<br>");
				}else
				{
					out.print("您需要订阅电子报才能查看<br>");
				} 
				
				
				out.print("系统会在&nbsp;<span id=\"url_id\" style=\"font-size:20px; color:#FF0000;\"></span>&nbsp;秒后，自动跳转到订阅页面");
				out.print("<script> Load('/jsp/general/subscribe/MyOrder.jsp?node="+teasession._nNode+"');</script>  ");
			}
		%>
      <br></td> 
</tr>

</table>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>

</html>
