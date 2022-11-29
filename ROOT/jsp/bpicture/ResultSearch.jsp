<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);

Community c=Community.find(teasession._strCommunity);

String count = request.getParameter("count");
String keywords = request.getParameter("keywords");
String url = request.getRequestURI()+request.getQueryString();
%>
<html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<title>结果中查询</title>
<style type="text/css">

.lzj_a{margin:0 10px;color:#0000CC; text-decoration:none;}
#my-B-picture{color:#000;font-weight:bold;text-decoration:none;margin:0 10px;}
#sear{text-align:left;padding-left:70px;}
#qt_new{width:210px;height:23px;border:1px solid #809EBA;background:#fff;line-height:23px;*line-height:18px;}
#lzj_bg{font-size:12px;}
#lzj_bg a{color:#0000cc;}
#lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0812/081243710.jpg) no-repeat;border:0;margin:0 10px;}
.kuan{border:0;}
#tablecenter001{border-top:1px solid #67A7E4;background:#D6E6FF;font-size:12px;color:#012DA8;}
.padleft{padding-left:10px;}
.top{border-top:1px solid #cccccc;margin-top:15px;}
.top td{font-size:12px;line-height:150%;}
.top a{color:0000cc;}
h1{color:#333;margin:20px 10px 5px 10px;display: block;width:95%;height:26px;padding-left:20px;vertical-align: middle;line-height: 30px;text-align:left;background:url(/res/bigpic/u/0812/081243709.gif) no-repeat left center;font-size:14px;font-weight:bold;}
.an001{height:23px;line-height:23px;*line-height:18px;}
</style>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>

</head>
<body style="margin:0;padding:0;">

<!--<div><a href="/jsp/bpicture">首页</a> > 结果查询</div>-->

<h1>结果查询</h1>
<h2><a href="/servlet/Node?node=2198115" >首页</a>  &gt; 结果查询</h2>
<form action="/servlet/Folder" name="Research" method="get"  onSubmit="">
<input type="hidden" name="node" value="2198224"/>
      <input type="hidden" name="language" value="1"/>
<table width="95%" border="0" cellspacing="0" cellpadding="3" align="center">
	<tr>
			<td colspan="2">
				<span class="big">有 <b><%if(count!=null)out.print(count);%></b> 个结果关于 <b>'<%if(keywords!=null)out.print(keywords);%>'</b>.</span><br>
				使用下面搜索框在现有结果中搜索。
			</td>
			<input type="hidden" name="bp_keywords" id="qt" value="<%=keywords%>" >
	</tr>
	<tr>
		<td width="300"><input type="Text" name="keywords" id="qt_new" style="width:100%;">
       </td>
		<td align="left">
			<input type="submit" value="结果搜索" class="an001">	  </td>
	</tr>
</table>
</form>

</body>
</html>
