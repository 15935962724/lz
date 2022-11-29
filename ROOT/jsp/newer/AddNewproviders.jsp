<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.ui.*" %><%@ page import="tea.newer.*" %><%@ page import="tea.resource.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	TeaSession tea=new TeaSession(request);
	if(tea._rv == null)
	{
	  response.sendRedirect("/servlet/StartLogin?node="+tea._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	  return;
	}
	int nid=Integer.parseInt(tea.getParameter("nid"));
	String nexturl=request.getParameter("nexturl");
	String nname="";
	if(nid>0){
		Newproviders np=Newproviders.finds(nid);
		if(np.getNname()!=null){
			nname=np.getNname();
		}
	}
	Resource r=new Resource("/tea/resource/Newproviders");
%>
<html>
<head>
<title><%=r.getString(tea._nLanguage, "editNewproviders") %></title>
<base target="dialog"/>
<link href="/res/<%=tea._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(tea._nLanguage, "editNewproviders") %></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form action="/EditNewproviders" name="form1" target="dialog">
	<input type="hidden" name="nid" value="<%=nid%>">
	<input type="hidden" name="act" value="<%=nid>0?"edit":"add" %>">
	<input type="hidden" name="nexturl" value="<%=nexturl %>" >
	<table id="tablecenter">
		<tr>
			<td ID=RowHeader><%=r.getString(tea._nLanguage, "names") %>：</td>
			<td><input type="text" value="<%=nname %>" name="nname"></td>
		</tr>
	</table>
	<input type="submit" value="<%=r.getString(tea._nLanguage, "Finish")%>"/>
	<input type="button" value="返回" onclick="window.open('<%=nexturl %>','dialog');"/>
</form>

<div id="head6"><img height="6" src="about:blank"></div>

<div id="language"><%=new tea.htmlx.Languages(tea._nLanguage,request)%></div>
</body>
</html>