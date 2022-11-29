<%@page import="tea.entity.zs.Ctf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%><%@ page import="tea.ui.*,tea.entity.custom.jjh.*" %><%@ page import="tea.db.*,java.util.*" %><%@ page import="tea.entity.*,tea.entity.util.*" %>
<%@ page import="tea.entity.node.*" %>
<%
TeaSession tea=new TeaSession(request);
if(tea._rv==null){
	  response.sendRedirect("/servlet/StartLogin?node="+tea._nNode);
	  return;
}
String nextUrl=tea.getParameter("nextUrl");
String ids=tea.getParameter("ids");

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>证书信息管理</title>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/custom/jjh/djq.js" type="text/javascript" ></script>
<script src="/tea/city.js" type="text/javascript"></script>

<link href="/res/Home/cssjs/community.css" type="text/css" rel="stylesheet">
<link href="/jsp/custom/jjh/djq.css" type="text/css" rel="stylesheet">
</head>
<body>

<h1>证书信息管理</h1>
<h2>编辑备注</h2>
<form action="/CtfSeivlet.do" name="form1" method="post" target="_ajax">
    <input type="hidden" name="status" value="editbz"/>
	<input type="hidden" name="nextUrl" value="<%=nextUrl%>"/>
	<input type="hidden" name="ids" value="<%=ids%>"/>
	<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	  <tr id="">
	    <td nowrap width="25%" align="left" colspan="4">对所选证书统一修改:</TD>
	    
	    </td>
	    
	  </tr>
	  <tr id="">
	    <td nowrap width="25%" align="right">备注名称:</TD>
	    <td nowrap width="25%">
	    	<input type="TEXT" class="edit_input"  name="otherName" value="">
	    </td>
	    <td nowrap width="25%" align="right">备注内容:</TD>
	    <td nowrap width="25%">
	    	<input type="TEXT" class="edit_input"  name="other" value="">
	    </td>
	    
	  </tr>
	  
	  
	</table>
	<span id="submitshow">
  <input id="submit1" class="edit_button" value="保存" onclick="" type="submit">&nbsp;
  <input name="reset" value="返回" onclick="history.go(-1);" type="button">
</span>
</form>


</body>
</html>