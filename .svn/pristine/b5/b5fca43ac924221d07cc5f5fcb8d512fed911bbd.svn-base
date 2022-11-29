<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="java.util.Date"%><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);



if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member = teasession.getParameter("member");

Node nobj = Node.find(teasession._nNode);

NodeRole nrobj = NodeRole.find(NodeRole.getNrid(teasession._nNode,member));
//System.out.println(member+"--"+teasession._nNode+"--"+nrobj.getNrname()+"--"+NodeRole.getNrid(teasession._nNode,member));
if("POST".equals(request.getMethod()))
{
	
	String nrname = teasession.getParameter("nrname");
	
	//if(nrname!=null && nrname.length()>0){
		
		String nrarr[] = teasession.getParameterValues("nrname");
		StringBuffer sp = new StringBuffer("/");
		
		if(nrname!=null && nrname.length()>0){
			for(int i=0;i<nrarr.length;i++){
				sp.append(nrarr[i]).append("/");
			}
		}
		if(nrobj.isExists()){
			nrobj.set(member,teasession._nNode,sp.toString(),new Date(),teasession._strCommunity,teasession._rv.toString());
		}else{
			NodeRole.create(member,teasession._nNode,sp.toString(),new Date(),teasession._strCommunity,teasession._rv.toString());
		}
	//}else
	
	out.print("<script>alert('权限设置成功!');window.returnValue=1;window.close();</script>");
}

  
%>

<html>
<head>
<title>内容管理权限分配</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">.tree{padding-left:15px;}
a#test:hover{text-decoration:underline;color:#00f;}
</style>
</head>
<h1><%=nobj.getSubject(teasession._nLanguage) %>--内容管理权限</h1>
<script>
window.name='tar';
function CheckAll(){
var checkname=document.getElementsByName("checkall");   
var fname=document.getElementsByName("nrname");
var lname=""; 
if(checkname[0].checked){
    for(var i=0; i<fname.length; i++){ 
      fname[i].checked=true; 
}   
}else{
   for(var i=0; i<fname.length; i++){ 
      fname[i].checked=false; 
   } 
}
}
</script>
<body>
	<form name="form1" action="?" method="POST" target="tar">
	<input type="hidden" name="member" value="<%=member %>"/>
	<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
	<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>
	<table border="0" align="left" cellpadding="0" cellspacing="0" id="tablecenter" > 
		<tr>
			<td nowrap><input type="checkbox" name="nrname" value="1"  <%if(nrobj.isNr(1))out.print(" checked "); %>  style="cursor:pointer" >&nbsp;添加</td>
			<td nowrap><input type="checkbox" name="nrname" value="2"  <%if(nrobj.isNr(2))out.print(" checked "); %>  style="cursor:pointer" >&nbsp;编辑</td>
			<td nowrap><input type="checkbox" name="nrname" value="3"  <%if(nrobj.isNr(3))out.print(" checked "); %>  style="cursor:pointer" >&nbsp;删除</td>
			<%if(nobj.getType()==0){ %>
			<td nowrap><input type="checkbox" name="nrname" value="12"  <%if(nrobj.isNr(12))out.print(" checked "); %>  style="cursor:pointer" >&nbsp;显示列表</td>
			<%} %>
			<td>&nbsp;</td> 
		</tr>
		<tr>
			<td nowrap><input type="checkbox" name="nrname" value="4"   <%if(nrobj.isNr(4))out.print(" checked "); %>  style="cursor:pointer">&nbsp;复制</td>
			<td nowrap><input type="checkbox" name="nrname" value="5"   <%if(nrobj.isNr(5))out.print(" checked "); %>  style="cursor:pointer" >&nbsp;移动</td>
			<td nowrap><input type="checkbox" name="nrname" value="6"   <%if(nrobj.isNr(6))out.print(" checked "); %>  style="cursor:pointer" >&nbsp;推荐</td>
			<td nowrap><input type="checkbox" name="nrname" value="7"   <%if(nrobj.isNr(7))out.print(" checked "); %>  style="cursor:pointer" >&nbsp;积分设置</td>
		</tr>
		<%if(nobj.getType()==1){ %> 
		<tr>
			<td nowrap><input type="checkbox" name="nrname" value="8"   <%if(nrobj.isNr(8))out.print(" checked "); %>  style="cursor:pointer">&nbsp;审核</td>
			<td nowrap><input type="checkbox" name="nrname" value="9"   <%if(nrobj.isNr(9))out.print(" checked "); %>  style="cursor:pointer" >&nbsp;签发</td>
			<td nowrap><input type="checkbox" name="nrname" value="10"  <%if(nrobj.isNr(10))out.print(" checked ");%>  style="cursor:pointer" >&nbsp;归档</td>
			<td nowrap><input type="checkbox" name="nrname" value="11"  <%if(nrobj.isNr(11))out.print(" checked ");%>  style="cursor:pointer" >&nbsp;退稿</td>
			
		</tr>
		<%} %>
		<tr><td colspan="5"><input type="checkbox" name="checkall" onclick="CheckAll()" />&nbsp;<input type="submit" value="提交"/>&nbsp;<input type="button" value="关闭" onClick="javascript:window.close();"> </td></tr>
	</table>
</form>

</body>
</html>
