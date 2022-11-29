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



Resource r=new Resource("/tea/resource/Photography");

String memberorder = teasession.getParameter("memberorder");
MemberOrder mobj = MemberOrder.find(memberorder);
Profile pobj = Profile.find(mobj.getMember());

%>

<html>
<head>
<title>会员审核管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >


<h1>会员状态</h1>


 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  			  <td nowrap align="right">用户名：</td>
  			  <td nowrap><input type="text" value="<%=mobj.getMember() %>" readonly="readonly" size="6"></td>
	    </tr>
	    <tr>
  			  <td nowrap align="right">密码：</td>
  			  <td nowrap><input type="text" value="<%=pobj.getPassword() %>" readonly="readonly" size="6"></td>
	    </tr>
	      <tr>
  			  <td nowrap align="right">当天登录次数：</td>
  			  <td nowrap><%
  			int l = Logs.countlogs(mobj.getMember()," and time >=" + DbAdapter.cite(Entity.sdf.format(new Date()) + " 00:00") + " and time <=" + DbAdapter.cite(Entity.sdf.format(new Date()) + " 23:59") + " and type =1 ");
  			out.print(l);
  			  %></td>
	    </tr>
	   <tr>
  			  <td nowrap align="right">是否锁定：</td>
  			  <td nowrap><%
  			  	if(mobj.getServicetype()==1){out.println("是");}
  			  	else{out.print("否");}
  			  %></td>
	    </tr>
	    <tr>
  			  <td nowrap align="right">锁定次数：</td>
  			  <td nowrap><%=mobj.getServicetypenumber()%>
	    </tr>
	     
  </table>
  <input type="button" id="closeid" value="关闭" onclick=window.close();>
</body>
</html>
