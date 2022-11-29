
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.util.*"%><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode("/jsp/admin/Frame.jsp?community="+teasession._strCommunity+"&node="+teasession._nNode,"UTF-8"));
  return;
}


%>

<html>
<head>
<style>
body{background:url(/res/ROOT/u/0709/070921018.jpg) no-repeat left bottom;border-right:1px #979797 solid;border-top:1px #979797 solid;margin:0px;}
form{margin:2px;}
input{
           border:1px #9bb7cc solid;
           font-size:12px;
           color:#000;
           background:#fff;
		   margin-left:5px;
		}

</style>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body>

<div style="text-align:center;background:#e9e9e9;padding:10px">

<form action="EarthCommunity.jsp" name="form1" target="earth_main">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="text" name="q"><input type="submit" value="社区搜索" />
</form>
<form action="EarthProfile.jsp" name="form2" target="earth_main">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="text" name="q"><input type="submit" value="会员搜索" />
</form>
<form action="EarthNode.jsp" name="form3" target="earth_main">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="text" name="q"><input type="submit" value="信息搜索" />
</form>
</div>

</body>
</html>



