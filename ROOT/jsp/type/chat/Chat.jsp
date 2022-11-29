<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.Entity"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.entity.RV"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
}
String nexturl = request.getRequestURI()+"?"+request.getQueryString();

if("EDIT".equals(teasession.getParameter("act")))
{
String pn []  = teasession.getParameterValues("cidorder");
	
	if(pn!=null && pn.length>0){
	
		for(int i2 =0;i2<pn.length;i2++)
		{
			int pnid = Integer.parseInt(pn[i2]);
			
		Chat cobj = Chat.find(pnid);
		cobj.delete();
			
		
		}
	}
	
	
	//添加成功
	out.print("<script>alert('记录删除成功'); window.location.href='"+nexturl+"';</script>");
	return;
}




StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer("?Node=" + teasession._nNode);

sql.append(" and node=" + teasession._nNode);
param.append("&id=").append(request.getParameter("id"));

String name = teasession.getParameter("name");
if(name!=null && name.length()>0)
{
	name = name.trim();
	sql.append(" and exists  (select member from ProfileLayer pl where pl.member=Chat.rmember and  (  pl.lastname like "+DbAdapter.cite("%"+name+"%")+" or pl.firstname like "+DbAdapter.cite("%"+name+"%")+"))");
	param.append("&name=").append(URLEncoder.encode(name,"UTF-8"));
	
}




int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=");


 count = Chat.count(sql.toString());
 
 sql.append(" order by time desc ");
 
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<script>
function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("cidorder");
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
	function f_edit(igd)
	{
		var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:530px;dialogHeight:310px;';
		 var url = '/jsp/type/chat/EditChatadmin.jsp?t='+new Date().getTime()+"&cid="+igd;
		 var rs = window.showModalDialog(url,self,y);
		 if(rs==1) 
		 {
			 window.location.reload();
		 }
		
	}
	function f_delete(igd)
	{
		if(confirm('确实要删除吗？'))
			{
		 
					 sendx("/jsp/admin/edn_ajax.jsp?act=Chatdelete&cid="+igd,
							 function(data)
							 {
						 		alert("记录删除成功");
						 		window.location.reload();
							 }
					 );
			}
	}
	function f_delteall()
	{ 
			if(submitCheckbox(form1.cidorder,'请选择一条记录'))
		  {
				if(confirm('确实要删除吗？'))
				{
			
			form1.act.value="EDIT";
			form1.action="?";
			form1.submit();
				}
		 }
		
	}
	
	function f_clear()
	{
		sendx("/jsp/admin/edn_ajax.jsp?act=Chatclear",
				 function(data)
				 {
			 		alert("聊天室记录清空成功");
			 		window.location.reload();
				 }
		 );
	}

	
</script>


<h1>聊天室管理</h1>
<h2>查询</h2>
 <form name="form2" action="?">
  <input type=hidden name="id" value="<%=teasession.getParameter("id") %>">
   <input type=hidden name="node" value="<%=teasession._nNode %>">
   
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
 		<td align="right" nowrap>用户名：</td>
 		<td><input type="text" name="name" value="<%if(name!=null&&name.length()>0){out.print(name);} %>"/></td>
 			<td><input type="submit"  value="查询"/></td>

 	</tr>
 	
 	</table> 
</form>
 <form name="form1" action="?">
 <input type=hidden name="act">
  <input type=hidden name="id" value="<%=teasession.getParameter("id") %>">

<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count %></font>&nbsp;条数据&nbsp;)&nbsp;
<input type=button value=选择删除 onclick=f_delteall();>&nbsp;
<input type=button value="清空聊天室记录" onclick="f_clear();">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr id=tableonetr>
    <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
      <td nowrap>用户名</td>
      <td nowrap>内容</td>
      <td nowrap>图片</td>
       <td nowrap>聊天时间</td>
        <td nowrap>操作</td>
 </tr>
 
 <%

Enumeration e = Chat.find(sql.toString(),pos,pageSize);
 if(!e.hasMoreElements())
 {
     out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
 }
 while(e.hasMoreElements())
 {
	 int cid = ((Integer)e.nextElement()).intValue();
	 Chat cobj = Chat.find(cid);
	  RV rv = cobj.getFrom();
	
	 Profile pobj =Profile.find(rv.toString());
	 String member =pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
	 if(member==null)
	 {
		 member = rv.toString();
	 }
	 String attach = cobj.getAttach();
 
 %>
 
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td width=1><input type=checkbox name=cidorder value="<%=cid %>" style="cursor:pointer"></td>
      <td><%=member %></td>
      <td><%=cobj.getText(teasession._nLanguage) %></td>
      <td><%if(attach!=null&&attach.length()>0)out.print("<a href="+attach+"  target=_blank>查看</a>"); %></td>
      <td><%if(cobj.getTime()!=null)out.print(Entity.sdf2.format(cobj.getTime())); %></td>
      <td><a href="###" onclick=f_edit('<%=cid %>');>编辑</a>&nbsp;<a href="###" onclick=f_delete('<%=cid %>');>删除</a></td>
  </tr>
    
  <%} %>
   <%if(count>pageSize){ %>
<tr><td colspan="20" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(), pos, count,pageSize)%></td></tr>
<%} %>
  
</table>
</form>	
</body> 
</html>

