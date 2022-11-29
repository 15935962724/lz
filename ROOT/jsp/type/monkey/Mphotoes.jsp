<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.node.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.entity.*" %>
<%
	int count=Mphoto.countMphoto("");
    Http h=new Http(request);
    StringBuffer sb=new StringBuffer();
    int size=h.getInt("size",10);
    sb.append("?size="+size);
    int pages =h.getInt("pages", 0);
    sb.append("&pages=");
    
%>
<html>
<head>
<title>图片列表</title>
<script language="JAVASCRIPT" src="/tea/ym/ymPrompt.js" type=""></script>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script src="/res/<%=h.community %>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<link href="/res/<%=h.community %>/cssjs/community.css" type="text/css" rel="stylesheet">
<script language="javascript" src="/tea/tea.js"></script><script language="javascript" src="/tea/mt.js"></script>
<script type="text/javascript">
function f_show(igd)
{
	
	ymPrompt.win({message:'/jsp/type/monkey/MphotoInfo.jsp?goid='+igd,width:600,height:450,title:'图片详细信息',handler:function(){},maxBtn:false,minBtn:false,iframe:true});
}
function f_excel(){
	form1.submit();
}
</script>
</head>
<body>
<h1>图片列表(<%=count %>)</h1>
<form action="/EditMphoto" name="form1">
	<input type="hidden" name="act" value="excel">
</form>
<table cellpadding="0" cellspacing="0" id="tablecenter">

<tr id="tableonetr">

	<td>作者</td>
	<td>联系方式</td>
	<td>图片说明</td>
	<td>拍摄地点</td>
	<td>拍摄时间</td>
	<td>拍摄参数</td>
	<td>操作</td>
</tr>
<%
	Enumeration e=Mphoto.findMphotos(" order by id desc",pages, size);
if(e.hasMoreElements()){
	while(e.hasMoreElements()){
		int id=(Integer)e.nextElement();
		Mphoto mp=Mphoto.findPhoto(id);
		if(mp.isExits()){%>
		<tr>
			<td><%=mp.getAuthor() %></td>
			<td><%=mp.getPhone() %></td>
			<td><%=mp.getIntroduce()%></td>
			<td><%=mp.getPlace()%></td>
			<td><%=mp.getTime() %></td>
			<td><%=mp.getParameters()%></td>
			<td><a href="javascript:f_show(<%=mp.getId()%>)">查看</a></td>
		</tr>
		<%}
	}
	out.print("<tr><td><input type='button' onclick='f_excel()'  value='导出'/></td>");
	if(count>size){
		out.print("<td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, request.getRequestURI()+sb.toString(), pages, count,size));
		
	}
}else{
	out.print("<tr><td colspan=7>暂无记录！</td></tr>");
}
%>
</table>
</body>
</html>