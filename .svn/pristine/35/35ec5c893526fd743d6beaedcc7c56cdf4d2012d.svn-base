<%@page import="tea.htmlx.FPNL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.ui.*" %><%@ page import="tea.resource.Resource" %>
<%@ page import="tea.db.*" %><%@ page import="tea.newer.*" %><%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
} 
String pag=request.getParameter("pos");
int pages=pag==null?0:Integer.parseInt(pag);
StringBuffer sb=new StringBuffer();
StringBuffer sb2=new StringBuffer();
String name=request.getParameter("nname");
if(name!=null && name.length()>0){
	sb.append(" AND nname LIKE "+DbAdapter.cite("%"+name.trim()+"%"));
	sb2.append("?nname=").append(java.net.URLEncoder.encode(name,"UTF-8"));
	sb2.append("&pos=");
}else{
	sb2.append("?pos=");
}
int count=Newproviders.count();
%>
<html>
<head>
<title>管理新闻提供者</title>
<base target="dialog">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
	window.name="dialog";
	function choose(nname){
		window.returnValue=nname;
		window.close();
	}
	function n_edit(id){
		document.form1.nid.value=id;
		document.form1.nexturl.value=window.location;
		document.form1.action="";
		document.form1.action="/jsp/newer/AddNewproviders.jsp";
		document.form1.submit();
	}
	function n_del(id){
		document.form1.nid.value=id;
		document.form1.nexturl.value=window.location;
		document.form1.act.value="delete";
		document.form1.action="/EditNewproviders";
		document.form1.submit();
	}
</script>
</head>
<body>
<h1>管理新闻提供者</h1>
<form  name="form1" action="?" target="dialog">
	<input type="hidden" value="" name="nid">
	<input type="hidden" value="" name="nexturl">
	<input type="hidden" value="" name="act">
	<table border="0"  cellpadding="0" cellspacing="0" id="tablecenter" > 
		<tr>
			<td>姓名：<input type="text" name="nname" value='<%=(null==name)?"":name%>'><input type="submit" value="go"></td>
		</tr>
	</table>
</form>
<br/>
<h2>列表<%=count %><input type="button" value="新建" onclick="n_edit(0);"></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr id="tableonetr"><td>姓名</td><td></td></tr>
	<%
		List list=Newproviders.findList(sb.toString(), pages, 10);
		for(int i=0;i<list.size();i++){
			Newproviders np=(Newproviders)list.get(i);
			%>
			<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''  style='cursor:hand; cursor:pointer;'>
			<td onclick='choose("<%=np.getNname()%>");'><%=np.getNname() %></td><td>
			<input type='button' value='编辑' onclick='n_edit("<%=np.getNid()%>");' > 
			 <input type='button' value='删除' onclick='n_del("<%=np.getNid()%>");'></td>
			 </tr>
		
		<%}
		if(count>10){%>
			
<tr><td colspan="20" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,sb2.toString().toString(), pages, count,10)%></td></tr>
		<%}
	%>
</table>
</body>
</html>