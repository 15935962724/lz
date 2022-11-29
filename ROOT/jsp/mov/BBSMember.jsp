<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>

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

int type=0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0){
	type = Integer.parseInt(teasession.getParameter("type"));
}

String nexturl = request.getRequestURI()+"?"+request.getQueryString();

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
param.append("&type=").append(type);
StringBuffer sql=new StringBuffer(" AND  p.community ="+DbAdapter.cite(teasession._strCommunity));

//用户ID
String member = teasession.getParameter("member");
if(member!=null && member.length()>0){
	member = member.trim();
	sql.append(" and p.member like ").append(DbAdapter.cite("%"+member+"%"));
	param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}

AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
if(Profile.find(teasession._rv._strR).getBbspermissions()!=null&&Profile.find(teasession._rv._strR).getBbspermissions().length()>0 || arobj.getBbs()!=null)
{
 
	if(arobj.getBbs()!=null &&arobj.getBbs().length()>0&&!"/".equals(arobj.getBbs()))
	{
		StringBuffer sb = new StringBuffer();
		boolean fs = false;
		for(int i=1;i<arobj.getBbs().split("/").length;i++){
		
			
			
			fs = true;
			int bbs = Integer.parseInt(arobj.getBbs().split("/")[i]);
			if(Node.find(bbs).getType()==0){
				Enumeration e = Node.find(" and hidden = 0 and father = "+bbs,0,Integer.MAX_VALUE);
				int ai = 1;
				while(e.hasMoreElements()){
					int nid = ((Integer)e.nextElement()).intValue();
					Node nobj = Node.find(nid);
					sb.append(" or  bbspermissions like  ").append(DbAdapter.cite("%/"+nid+"/%"));
					
					ai++;
					
					
				}
				if(ai==1)
				{
					sb.toString().replaceAll(" or ","");
				}else if(ai>1)
				{
					sb.append(")"); 
					
					
				} 
				sql.append(sb.toString().replaceAll(" and    or"," and ("));
			}else if(Node.find(bbs).getType()==1){
				//sb.append("/").append(arobj.getBbs());
			} 
			
		}
		//sql.append(" and bbspermissions like ").append(DbAdapter.cite("%"+Profile.find(teasession._rv._strR).getBbspermissions()+"%"));
		 // sb.append("/"); 
		 // sql.append(sb.toString());
	
		 if(!fs)
		 {
			 
			 sql.append(" 1=1 "); 
			 System.out.println(sql.toString());
			 
			 
		 }
	}else
	{
		sql.append(" and bbspermissions like ").append(DbAdapter.cite("%"+Profile.find(teasession._rv._strR).getBbspermissions()+"%"));
		
	}

} 

 

//申请时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND p.time >=").append(DbAdapter.cite(time_c+" 00:00")); 
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d"); 
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND p.time <=").append(DbAdapter.cite(time_d+" 23:59"));
  param.append("&time_d=").append(time_d);
}
//性别
int sex= -1;
if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0){
	sex = Integer.parseInt(teasession.getParameter("sex"));
}
if(sex>=0){
	sql.append(" and p.sex= ").append(sex);
	param.append("&sex=").append(sex);
}




int pos=0,pageSize=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}




int count=Profile.count(sql.toString());
sql.append(" order by time desc ");  
 

%>

<html>
<head>
<title>BBS论坛版块会员管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">


function f_delete(igd)
{
	if(confirm('确实要删除吗？')){
	sendx("/jsp/admin/edn_ajax.jsp?act=BBSMember&member="+encodeURIComponent(igd),
		 function(data)
		 {
		
			  alert("会员删除成功");
			   window.location.reload();
		 }
		 );
	}
}


</script>

<h1>BBS论坛版块会员管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
 
<form action="?" name="form2">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="type" value="<%=type %>">
 
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td nowrap align="right">会员ID：</td>
		<td><input type="text" name="member" value="<%=Entity.getNULL(member) %>"/></td>
		
		<td align="right">申请时间：</td>
		<td>
		 从&nbsp;
	        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form2.time_c');"> 
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form2.time_c');" />
	        &nbsp;到&nbsp;
	        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form2.time_d');" >
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form2.time_d');" />
		
		</td>
	
		<td align="right">性别：</td>
		<td>
			<select name="sex">
				<option value="-1">-性别-</option>
				<option value="0" <%if(sex==0)out.print(" selected "); %>>男</option>
				<option value="1" <%if(sex==1)out.print(" selected "); %>>女</option>
			</select>
		</td>
		</tr>
		<tr>
	    
		
	    <td colspan="10" align="center"><input type="submit" value="查询"/></td>
	    </tr>
	</tr> 
 </table>
</form> 

<form name="form1" action ="?">
<input type="hidden" name="nexturl">  


<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<input type="hidden" name="act">


<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;
<input type="button" value="创建会员" onclick="window.open('/jsp/mov/EditBBSMember.jsp?memberid=NO&type=<%=type %>&nexturl=<%=nexturl %>','_self');" >
</h2>
 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter"> 
	   <tr id=tableonetr>
  			  
  			 
  			  <td nowrap>用户名</td>
  			  <td nowrap>论坛版块</td>
  			  <td nowrap>姓名</td>
  			  <td nowrap>性别</td>
  			  <td nowrap>电子邮箱</td>
  			  <td nowrap>手机号</td>
  			  <td nowrap>创建时间</td>
  			  
  			  <td nowrap>操作</td>
	    </tr>
	    
    <%
 		
		
	    java.util.Enumeration e =Profile.find(sql.toString(),pos,pageSize); // MemberOrder.findMP(teasession._strCommunity,sql.toString(),pos,pageSize);
		 if(!e.hasMoreElements())
		 {
		     out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
		 }
    	for(int i=1;e.hasMoreElements();i++)
    	{
    		String memberid =((String)e.nextElement());
    	    Profile  pobj = Profile.find(memberid);
    	   
    	    StringBuffer bbs =new StringBuffer();
    	    if(pobj.getBbspermissions()!=null){
    	    	for(int b=1;b<pobj.getBbspermissions().split("/").length;b++){
    	    		
    	    		Node nobj = Node.find(Integer.parseInt(pobj.getBbspermissions().split("/")[b]));
    	    		bbs.append(nobj.getSubject(teasession._nLanguage)).append(" ");
    	    	}
    	    }
    	    
	 
    		 
    %>
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
     
    
      <td nowrap="nowrap"><%=memberid%></td>
      <td ><%=bbs.toString() %></td>
     <td><%=pobj.getFirstName(teasession._nLanguage)%></td> 
	   <td><%if(pobj.isSex()){out.print("女");}else{out.print("男");} %></td>
	   <td><%=pobj.getEmail()%></td> 
	   <td><%=pobj.getMobile()%></td> 
	   <td nowrap><%=pobj.sdf2.format(pobj.getTime()) %></td>
	   <td nowrap>
		  
		   <a href="/jsp/mov/EditBBSMember.jsp?memberid=<%=URLEncoder.encode(memberid,"UTF-8") %>&type=<%=type %>&nexturl=<%=URLEncoder.encode(nexturl,"UTF-8") %>">编辑</a>&nbsp;
		    <a href="###" onclick="f_delete('<%=memberid %>');">删除</a>&nbsp;
		
	   </td> 
	   
	   
    </tr>
<%} %>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>

