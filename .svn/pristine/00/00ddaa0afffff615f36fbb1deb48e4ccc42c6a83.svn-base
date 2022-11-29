<%@ page language="java" contentType="text/html; charset=UTF-8"%><%@ page import="tea.ui.*" %><%@ page import="tea.resource.*" %><%@ page import="tea.db.*,java.util.*" %><%@ page import="tea.entity.*,tea.entity.util.*" %><%@ page import="tea.entity.notices.*" %>
<%@ page import="tea.entity.node.*" %>
<%
TeaSession tea=new TeaSession(request);

Resource r=new Resource("/tea/resource/Notices");

if(tea._rv==null){
	  response.sendRedirect("/servlet/StartLogin?node="+tea._nNode);
	  return;
}
StringBuffer sql=new StringBuffer();
StringBuffer pro=new StringBuffer();
	if(Category.find(tea._nNode).getCategory()!=99){
		List list=Category.find(tea._strCommunity, 99, 0, Integer.MAX_VALUE);
		Iterator it=list.iterator();
		while(it.hasNext()){
			int nodeid=(Integer)it.next();
			Node node=Node.find(nodeid);
			if(node.getType()==1){
				tea._nNode=node._nNode;
				break;
			}
		}
	}
String id="";
if(tea.getParameter("id")!=null){
	id=tea.getParameter("id");
}
pro.append("?id="+id);

sql.append(" and node in (select node from node where father="+tea._nNode+") ");

String vname="";
if(tea.getParameter("ProjectName")!=null&&tea.getParameter("ProjectName").trim().length()>0){
	vname=tea.getParameter("ProjectName");
	sql.append(" AND nname like "+DbAdapter.cite("%"+vname.trim()+"%"));
	pro.append("&ProjectName=").append(vname);
}

String ProjectAddresss="";
if(tea.getParameter("ProjectAddresss")!=null&&tea.getParameter("ProjectAddresss").trim().length()>0){
	ProjectAddresss=tea.getParameter("ProjectAddresss");
	sql.append(" AND address like "+DbAdapter.cite("%"+ProjectAddresss.trim()+"%"));
	pro.append("&ProjectAddresss=").append(ProjectAddresss);
}

int size=0;
if(tea.getParameter("size")!=null&&tea.getParameter("size").trim().length()>0){
	size=Integer.parseInt(tea.getParameter("size"));
}else{
	size=10;
}


int pages=0;
if(tea.getParameter("page")!=null&&tea.getParameter("page").trim().length()>0){
	pages=Integer.parseInt(tea.getParameter("page"));
}
pro.append("&page=");
int count=0;
count=Notices.count(sql.toString());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=r.getString(tea._nLanguage, "NoticesList") %></title>
<link href="/res/<%=tea._strCommunity%>/cssjs/community.css" type="text/css" rel="stylesheet">
<script src="/tea/mt.js" type="text/javascript"></script>

</head>
<body>
<h1><%=r.getString(tea._nLanguage, "NoticesList") %></h1>
<h2><%=r.getString(tea._nLanguage, "Search") %></h2>
<form action="?" name="form1">
	<input type="hidden" name="id" value="<%=id%>"/> 
	<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	  <tr id="">
	    <td nowrap width="25%" align="right"><%=r.getString(tea._nLanguage, "ProjectName") %>:</TD>
	    <td nowrap width="25%"><input type="TEXT" class="edit_input"  name="ProjectName" value="<%=vname %>"></td>
	    <td nowrap width="25%" align="right"><%=r.getString(tea._nLanguage, "ProjectAddresss") %>:</TD>
	    <td nowrap width="25%"><input type="TEXT" class="edit_input"  name="ProjectAddresss" value="<%=ProjectAddresss%>"></td>
	  </tr>
	  
	  <tr>
	  	<td colspan="4" align="center"><input type="submit" value="<%=r.getString(tea._nLanguage, "Search") %>"/></td>
	  </tr>
	  
	</table>
</form>
<form action="/servlet/EditNotices" name="form2"  target="_ajax">
<h2><%=r.getString(tea._nLanguage, "List") %><input type="button" value="<%=r.getString(tea._nLanguage, "Add") %>" onclick="mt.act('Edit',0,'<%=tea._nNode%>');"/></h2>
	<input type="hidden" name="act"  />
	<input type="hidden" name="vid"  />
	<input type="hidden" name="nextUrl" value=""/>
	<input type="hidden" name="node" value="<%=tea._nNode%>"/>
	
	<table id="tablecenter">
		<tr>
			<%--<td><input type="checkbox" onclick="mt.select(form2.vids,checked);"/></td> --%>
			<td><%=r.getString(tea._nLanguage, "ProjectNumber") %></td>
			<td><%=r.getString(tea._nLanguage, "ProjectName") %></td>
			<td><%=r.getString(tea._nLanguage, "ProjectAddresss") %></td>
			<td><%=r.getString(tea._nLanguage, "OwnerName") %></td>
			<td><%=r.getString(tea._nLanguage, "PackageName") %></td>
			<td><%=r.getString(tea._nLanguage, "EditPerson") %></td>
			<td><%=r.getString(tea._nLanguage, "ReleaseTime") %></td>
			<td></td>
		</tr>
		<%
		
			sql.append(" order by nid desc");
		Enumeration e=Notices.fintList(sql.toString(), pages, size);
		if(!e.hasMoreElements()){
			 out.print("<tr><td colspan='10' align='center'>"+r.getString(tea._nLanguage, "HaveNoNotes")+"!</td></tr>");
		}
			while(e.hasMoreElements()){
				int nid=(Integer)e.nextElement();
				Notices nt=Notices.find(nid);
			%>
			<tr>
				<td><%=nt.getNoteid() %></td>
				<td><%=nt.getNname() %></td>
				<td><%=nt.getAddress() %></td>
				<td><%=nt.getOwnerName() %></td>
				<td><%=nt.getGeneralName() %></td>
				<td><%=nt.getEditname() %></td>
				<td><%=nt.getTimes() %></td>
			
				
				<td><a href="javascript:mt.act('Edit','<%=nt.getNode()%>');"><%=r.getString(tea._nLanguage, "Edit") %></a>&nbsp;<a href="javascript:mt.act('del','<%=nt.getNode()%>');"><%=r.getString(tea._nLanguage, "Delete") %></a></td>
			</tr>
			<%}%>
			<tr><td><input type="button" value="<%=r.getString(tea._nLanguage, "Export") %>" onclick="mt.act('Excel',0);"/></td>
			<%if(count>size){out.print("<td colspan='5' align='right'>"+new tea.htmlx.FPNL(tea._nLanguage, request.getRequestURI()+pro.toString(), pages, count,size));}
		%>
	</table>
</form>
<script type="text/javascript">
mt.act=function(type,node){
	form2.node.value=node;
	if("Edit"==type){
		form2.nextUrl.value=window.location;
		form2.action="/jsp/notices/"+type+"Notices.jsp";
		form2.target="";
		form2.submit();
	}else if("del"==type){
		if(confirm("确定要删除该条信息吗？")){
			form2.act.value="del";
			form2.nextUrl.value=window.location;
			form2.action="/servlet/EditNotices";
			form2.submit();
		}
	}else if("Excel"==type){
		  form2.act.value="Excel";
		  form2.nextUrl.value=window.loction;
		  form2.action="/servlet/EditNotices";
		  form2.submit();
	}
}

</script>
</body>
</html>