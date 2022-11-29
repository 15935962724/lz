<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.*"%>

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
String member = teasession.getParameter("member");
Profile pobj = Profile.find(member);

if("POST".equals(request.getMethod()))
{
	String cardnumber = teasession.getParameter("cardnumber");
	if(cardnumber!=null && cardnumber.length()>0)
	{
		if(pobj.isCardnumber(cardnumber))
		{
			out.println("<script>alert('会员关联卡号已经存在，请重新填写');</script>");
		}else
		{
			pobj.setCardnumber(cardnumber);
			out.println("<script>alert('会员关联卡号成功');</script>");
		}

	}
	out.println("<script>window.close();</script>");
	return;
}


%>

<html>
<head> 
<title>俱乐部高级会员关联卡号管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">


</script>

<h2>俱乐部高级会员关联卡号管理</h2>

 
<form name="form1" action ="?" method="post">
<input type="hidden" name="member" value="<%=member %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td align="right">会员关联卡号：<input type="text" name="cardnumber" value="<%=Entity.getNULL(pobj.getCardnumber()) %>"></td>
		
	</tr>
		</table>
		<input type="submit" value="提交">&nbsp;<input type="button" value="关闭"  onClick="javascript:window.close();">
</form>
</body>
</html>

