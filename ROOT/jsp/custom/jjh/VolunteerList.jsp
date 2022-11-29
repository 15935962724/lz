<%@ page language="java" contentType="text/html; charset=UTF-8"%><%@ page import="tea.ui.*,tea.entity.custom.jjh.*" %><%@ page import="tea.db.*,java.util.*" %><%@ page import="tea.entity.*,tea.entity.util.*" %>
<%@ page import="tea.entity.node.*" %>
<%
TeaSession tea=new TeaSession(request);
if(tea._rv==null){
	  response.sendRedirect("/servlet/StartLogin?node="+tea._nNode);
	  return;
}
StringBuffer sql=new StringBuffer();
StringBuffer pro=new StringBuffer();
	if(Category.find(tea._nNode).getCategory()!=96){
		List list=Category.find(tea._strCommunity, 96, 0, Integer.MAX_VALUE);
		Iterator it=list.iterator();
		while(it.hasNext()){
			int nodeid=(Integer)it.next();
			Node node=Node.find(nodeid);
			if(node.getCommunity().equals(tea._strCommunity)){
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
String tabtype="";
if(tea.getParameter("tabtype")!=null&&tea.getParameter("tabtype").trim().length()>0){
	tabtype=tea.getParameter("tabtype").trim();
	pro.append("&tabtype="+tabtype);
}

String vprovinces="";
if(tea.getParameter("vprovince")!=null&&tea.getParameter("vprovince").trim().length()>0){
	vprovinces=tea.getParameter("vprovince").trim();
	int vprovince=Integer.parseInt(vprovinces);
	sql.append(" AND vprovince = "+vprovince);
	pro.append("&vprovince="+vprovince);
}


String vname="";
if(tea.getParameter("vname")!=null&&tea.getParameter("vname").trim().length()>0){
	vname=tea.getParameter("vname");
	sql.append(" AND vname like "+DbAdapter.cite("%"+vname.trim()+"%"));
	pro.append("&vname=").append(vname);
}

int vsex=9;
if(tea.getParameter("vsex")!=null&&tea.getParameter("vsex").length()>0){
	vsex=Integer.parseInt(tea.getParameter("vsex"));
	sql.append(" AND vsex = "+vsex );
	pro.append("&vsex="+vsex);
}

int vnation=0;
if(tea.getParameter("vnation")!=null&&tea.getParameter("vnation").trim().length()>0){
	String vnations=tea.getParameter("vnation").trim();
	vnation=Integer.parseInt(vnations);
	if(vnation>0){
		sql.append(" AND vnation = "+vnations);
		pro.append("&vnation="+vnation);
	}
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
if(tabtype.length()>0)
{
count=Volunteer.countVolunteer(sql.toString()+(" AND vtype = "+tabtype));
}else
{
	count=Volunteer.countVolunteer(sql.toString());
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>志愿者信息管理</title>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/custom/jjh/djq.js" type="text/javascript" ></script>
<script src="/tea/city.js" type="text/javascript"></script>

<link href="/res/<%=tea._strCommunity%>/cssjs/community.css" type="text/css" rel="stylesheet">
<link href="/jsp/custom/jjh/djq.css" type="text/css" rel="stylesheet">
</head>
<body>
<h1>志愿者信息管理</h1>
<h2>查询</h2>
<form action="?" name="form1">
	<input type="hidden" value="<%=tabtype %>" name="tabtype"/>
	<input type="hidden" name="id" value="<%=id%>"/> 
	<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	  <tr id="">
	    <td nowrap width="25%" align="right">姓名:</TD>
	    <td nowrap width="25%"><input type="TEXT" class="edit_input"  name="vname" value="<%=vname %>"></td>
	    <td nowrap width="25%" align="right">省份:</TD>
	    <td nowrap>
			<script>mt.city("vprovince",null,null,"<%=vprovinces%>");</script>
		</td>
	  </tr>
	  <tr id="">
	    <td nowrap width="25%" align="right">性别:</TD>
	    <td nowrap width="25%">
	    	<select name="vsex">
	    		<option value="">---------</option>
	    		<option value="0" <%=vsex==0?"selected":"" %> >男</option>
	    		<option value="1" <%=vsex==1?"selected":"" %> >女</option>
	    	</select>
	    </td>
	    <td nowrap width="25%" align="right">民族:</TD>
	    <td nowrap>
			<select name="vnation">
	    		<option value="0">----请选择----</option>
	    		<%for(int i=1;i<Volunteer.nations.length+1;i++){%>
	    				<option value="<%=i%>" <%=vnation==i?"selected":"" %>><%=Volunteer.nations[i-1] %></option>
	    		<%}%>
	    </select>
		</td>
	  </tr>
	  <tr>
	  	<td colspan="4" align="center"><input type="submit" value="查询"/></td>
	  </tr>
	  
	</table>
</form>
<form action="/EditVolunteers.do" name="form2"  target="_ajax">
<h2>列表<input type="button" value="新建" onclick="mt.act('Edit',0,'<%=tea._nNode%>');"/></h2>
	<input type="hidden" name="act"  />
	<input type="hidden" name="vid"  />
	<input type="hidden" name="nextUrl" value=""/>
	<input type="hidden" name="node" value="<%=tea._nNode %>"/>
	<input type="hidden" name="nodess" value=""/>
	<input type="hidden" name="community" value="<%=tea._strCommunity%>"/>
	<div class="switch">
	<a href="javascript:mt.tabchange('');" id="typetab">全部(<%= Volunteer.countVolunteer(sql.toString()) %>)</a>
	<%
	List list2=Voltype.findVoltypes("", 0, Integer.MAX_VALUE);
	Iterator it2=list2.iterator();
	while(it2.hasNext()){
		Voltype vt=(Voltype)it2.next();%>
		<a href="javascript:mt.tabchange(<%=vt.getVtid() %>);" id="typetab<%=vt.getVtid() %>"><span><%=vt.getVtname()%><span>(<%= Volunteer.countVolunteer(sql.toString()+" AND vtype = "+vt.getVtid()) %>)</a>
	<%}
	%>
	</div>
	<table id="tablecenter">
		<tr >
			<td width="2%" title="全选" ><input  type="checkbox"  style="cursor: pointer;" onclick="mt.select(form2.vids,checked);"/>
			 </td>
			<td  width=" " nowrap='nowrap'  >姓名</td>
			<td  width="10%" nowrap='nowrap'>省份</td>
			<td width="10%" nowrap='nowrap' >性别</td>
			<td width="10%" nowrap='nowrap'>民族</td>
			<td width="10%" nowrap='nowrap'>所在单位</td>
			<td width="10%" nowrap='nowrap'>联系电话</td>
			<td width="10%" nowrap='nowrap'>注册时间</td>
			<td  width="10%" nowrap='nowrap'>操作</td>
		</tr>
		<%
			List list=new ArrayList();
		if(tabtype.length()>0)
		{
			sql.append(" AND vtype = "+tabtype+" order by vid desc");
		}else
		{
			sql.append(" order by vid desc");
		}
		list=Volunteer.findVolunteer(sql.toString(),pages, size);
		if(list.size()==0){
			 out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
		}else{
			Iterator it=list.iterator();
			while(it.hasNext()){
				Volunteer v=(Volunteer)it.next();%>
			<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
				<td><input type="checkbox" name="vids" value="<%=v.getNode()%>"  style="cursor: pointer;"/></td>
				<td><%=v.getVname() %></td>
				<td><%
				if(v.getVprovince()==71){
					out.print("台湾省");
				}else if(v.getVprovince()==81){
					out.print("香港特区");
				}else if(v.getVprovince()==82){
					out.print("澳门特区");
				}else{
					out.print(Card.find(v.getVprovince()).toString());
				}
				 %></td>
				<td><%=v.getVsex()==0?"男":"女" %></td>
				<td><%if(v.getVnation()!=0)out.print(Volunteer.nations[v.getVnation()-1]); %></td>
				<td><%=v.getVuwork() %></td>
				<td><%=v.getVphone() %></td>
				<td><%=v.getVtime()==null?"":Entity.sdf.format(v.getVtime()) %></td>
				<td><a href="javascript:mt.act('Edit','<%=v.getVid()%>','<%=v.getNode()%>');">编辑</a>&nbsp;<a href="javascript:mt.act('del','<%=v.getVid()%>','<%=v.getNode()%>');">删除</a></td>
			</tr>
			<%}
		}
			%>
			<tr><td><input type="button" value="批量删除" onclick="mt.act('deleteAll',0,0);"/><input type="button" value="导入" onclick="mt.act('Import',0,'<%=tea._nNode%>');"/><input type="button" value="导出" onclick="mt.act('Excel','<%=sql.toString()%>',0);"/></td>
			<%if(count>size){out.print("<td colspan='5' align='right'>"+new tea.htmlx.FPNL(tea._nLanguage, request.getRequestURI()+pro.toString(), pages, count,size));}
		
		%>
	</table>
	
	
	
	
	
</form>
<script type="text/javascript">
	var vtype="<%=tabtype%>";
		$("typetab"+vtype).className="current";
</script>
</body>
</html>