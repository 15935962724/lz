<%@page import="tea.entity.zs.Ctf"%>
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
String nextUrl=tea.getParameter("nextUrl");
String id="";
if(tea.getParameter("id")!=null){
	id=tea.getParameter("id");
}
pro.append("?id="+id);

String name="";
if(tea.getParameter("name")!=null&&tea.getParameter("name").trim().length()>0){
	name=tea.getParameter("name");
	sql.append(" AND name like "+DbAdapter.cite("%"+name.trim()+"%"));
	pro.append("&name=").append(name);
}
String CreName="";
if(tea.getParameter("CreName")!=null&&tea.getParameter("CreName").trim().length()>0){
	CreName=tea.getParameter("CreName");
	sql.append(" AND cre_name like "+DbAdapter.cite("%"+CreName.trim()+"%"));
	pro.append("&cre_name=").append(CreName);
}
String creNum="";
if(tea.getParameter("creNum")!=null&&tea.getParameter("creNum").trim().length()>0){
	creNum=tea.getParameter("creNum");
	sql.append(" AND cre_num like "+DbAdapter.cite("%"+creNum.trim()+"%"));
	pro.append("&cre_num=").append(creNum);
}
String OtherName="";
if(tea.getParameter("OtherName")!=null&&tea.getParameter("OtherName").trim().length()>0){
	OtherName=tea.getParameter("OtherName");
	sql.append(" AND other_Name like "+DbAdapter.cite("%"+OtherName.trim()+"%"));
	pro.append("&other_Name=").append(OtherName);
}
String Other="";
if(tea.getParameter("Other")!=null&&tea.getParameter("Other").trim().length()>0){
	Other=tea.getParameter("Other");
	sql.append(" AND Other like "+DbAdapter.cite("%"+Other.trim()+"%"));
	pro.append("&Other=").append(Other);
}
String creNumber="";
if(tea.getParameter("creNumber")!=null&&tea.getParameter("creNumber").trim().length()>0){
	creNumber=tea.getParameter("creNumber");
	sql.append(" AND cre_number like "+DbAdapter.cite("%"+creNumber.trim()+"%"));
	pro.append("&cre_number=").append(creNumber);
}
String timeStart="";
String timeEnd="";
if(tea.getParameter("timeStart")!=null&&tea.getParameter("timeStart").trim().length()>0){
	timeStart=tea.getParameter("timeStart");
	timeEnd=tea.getParameter("timeEnd");
	sql.append(" AND time between "+DbAdapter.cite(timeStart)+" and "+DbAdapter.cite(timeEnd));
	pro.append("&cre_number=").append(creNumber);
}



int size=0;
if(tea.getParameter("size")!=null&&tea.getParameter("size").trim().length()>0){
	size=Integer.parseInt(tea.getParameter("size"));
}else{
	size=100;
}


int pages=0;
if(tea.getParameter("page")!=null&&tea.getParameter("page").trim().length()>0){
	pages=Integer.parseInt(tea.getParameter("page"));
}
pro.append("&page=");
int count=0;

count=Ctf.countCtf(sql.toString());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>证书信息管理</title>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<script src="/jsp/custom/jjh/djq.js" type="text/javascript"></script>

<link href="/res/<%=tea._strCommunity%>/cssjs/community.css" type="text/css" rel="stylesheet">
<link href="/jsp/custom/jjh/djq.css" type="text/css" rel="stylesheet">
</head>
<body>
<script type="text/javascript">

function act(type,cid){
	if("add"==type){
		
		
		form2.nextUrl.value=window.location;
		form2.action="/jsp/zhengshu/zs.jsp";
		form2.target="";
		form2.submit();
	} if("query"==type){
		
		form2.cid.value=cid;
		form2.nextUrl.value=window.location;
		form2.action="/jsp/zhengshu/queryZs.jsp";
		form2.target="";
		form2.submit();
	}else if("edit"==type){
		form2.cid.value=cid;
		
		form2.nextUrl.value=window.location;
		form2.action="/jsp/zhengshu/"+type+"Zs.jsp";
		form2.target="";
		form2.submit();
	}else if("editbz"==type){
		var ids="/";
		var cids=document.getElementsByName("cids");
		
		for(var i=0;i<cids.length;i++){
			if(cids[i].checked==true){

				ids=ids+cids[i].value+"/";
				
			}
		}
		if(ids=="/"){
			alert("请选择要编辑的信息");
		}else{
			form2.ids.value=ids;
			form2.nextUrl.value=window.location;
			form2.action="/jsp/zhengshu/"+type+".jsp";
			form2.target="";
			form2.submit();
		}
	  
	}else if("del"==type){
		if(confirm("确定要删除该条信息吗？")){
			form2.cid.value=cid;
			form2.status.value="del";
			form2.nextUrl.value=window.location;
			form2.action="/CtfSeivlet.do";
			form2.submit();
		}
	}else if("Excel"==type){
		var ids=" and id=";
		var cids=document.getElementsByName("cids");
		
			for(var i=0;i<cids.length;i++){
				if(cids[i].checked==true){
                    
					ids=ids+cids[i].value+" or id=";
					
				}
			}
			if(ids==" or id="){
				ids="";
			}else{
				var len=ids.length-7;
				ids=ids.substring(0, len);
			}
			
				form2.ids.value=ids;
				  form2.status.value="Excel";
				  form2.nextUrl.value=window.location;
				  form2.action="/CtfSeivlet.do";
				  form2.submit();
			
			/* form2.ids.value=ids; */
			  /* form2.status.value="Excel";
			  form2.nextUrl.value=window.location;
			  form2.action="/CtfSeivlet.do";
			  form2.submit(); */
		
		
	}else if("Import"==type){
		// form2.vid.value=vid;
		  //form2.act.value="Import";
		  //form2.nextUrl.value=window.loction;
		  //form2.action="/EditVolunteers.do";
		  //form2.submit();
		  
		  var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:650px;';
			 var url = '/jsp/zhengshu/ctfImport.jsp';
			 var rs = window.showModalDialog(url,self,y);

		  // form1.submit();
			 window.location.reload();
	}else if ("delAll"==type){
            
		    var ids="/";
			var cids=document.getElementsByName("cids");
			
			for(var i=0;i<cids.length;i++){
				if(cids[i].checked==true){
	
					ids=ids+cids[i].value+"/";
				}
			}
          
		  form2.ids.value=ids;
		  form2.status.value="delAll";
		  form2.nextUrl.value=window.location;
		  form2.action="/CtfSeivlet.do";
		  form2.submit();
		
	}
}
</script>
<h1>证书信息管理</h1>
<h2>查询</h2>
<form action="?" name="form1" method="post">
	
	<input type="hidden" name="id" value="<%=id%>"/> 
	<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	  
	  <tr id="">
	    <td nowrap width="25%" align="right">姓名:</TD>
	    <td nowrap width="25%">
	    	<input type="TEXT" class="edit_input"  name="name" value="<%=name %>">
	    </td>
	    <td nowrap width="25%" align="right">证件号码:</TD>
	    <td nowrap width="25%">
	    	<input type="TEXT" class="edit_input"  name="creNum" value="<%=creNum %>">
	    </td>
	    
	  </tr>
	  <tr id="">
	    <td nowrap width="25%" align="right">证书名称:</TD>
	    <td nowrap width="25%"><input type="TEXT" class="edit_input"  name="CreName" value="<%=CreName %>"></td>
	    <td nowrap width="25%" align="right">证书编号:</TD>
	    <td nowrap>
			<input type="TEXT" class="edit_input"  name="creNumber" value="<%=creNumber %>">
		</td>
	  </tr>
	  <tr id="">
	    <td nowrap width="25%" align="right">备注名称:</TD>
	    <td nowrap width="25%"><input type="TEXT" class="edit_input"  name="OtherName" value="<%=OtherName %>"></td>
	    <td nowrap width="25%" align="right">备注内容:</TD>
	    <td nowrap>
			<input type="TEXT" class="edit_input"  name="Other" value="<%=Other %>">
		</td>
	  </tr>
	  <tr id="">
	    
	    <td nowrap width="25%" align="right">发证时间:</TD>
	    <td nowrap width="25%" align="left" colspan="3">
	    
			<input id="datestime" name="timeStart" size="14"  value="<%=timeStart %>"  style="cursor:pointer" readonly onClick="new Calendar().show('form1.timeStart');" > 
  <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.timeStart');" />到
			<input id="datestime" name="timeEnd" size="14"  value="<%=timeEnd %>"  style="cursor:pointer" readonly onClick="new Calendar().show('form1.timeEnd');"> 
  <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.timeEnd');" />
		</td>
		<script type="text/javascript">
           function fn1(){
        	   var is=false;
        	   var time1=form1.timeStart.value.replace("-","").replace("-","");
        	   
        	   var time2=form1.timeEnd.value.replace("-","").replace("-","");
        	   if(time1>time2){
        		   alert("请选择开始日期之后的时间！");
        		   return is;
        	   }else{
        		   is=true;
        		   return is;
        	   }
        	   
           }
           function fn2(){
        	   if(fn1()){
        		   form1.submit();
        	   }
           }
        </script>
	    
	  </tr>
	  <tr>
	  	<td colspan="4" align="center"><input type="button" value="查询" onClick="javascript:fn2()"/>
	  	<input type="button" value="清空" onclick="javascript:fnreset();"/>
	  	</td>
	  	
	  </tr>
	  
	</table>
	<script type="text/javascript">
	 function fnreset(){
		 form1.name.value="";
		 form1.creNum.value="";
		 form1.creNumber.value="";
		 form1.CreName.value="";
		 form1.timeStart.value="";
		 form1.timeEnd.value="";
	 }
	</script>
</form>
<form action="" name="form2"  target="_ajax">
<h2>列表
<input type="button" value="新建" onClick="javascript:act('add',0);"/>&nbsp;&nbsp;&nbsp; 共<%=Ctf.countCtf(sql.toString()) %>条数据</h2>

<input type="hidden" name="sql" value="<%=sql%>"/>
	<input type="hidden" name="status"  />
	<input type="hidden" name="id"  value=""/>
	<input type="hidden" name="ids"  value=""/>
	<input type="hidden" name="cid" value=""/>
	<input type="hidden" name="nextUrl" value=""/>
	
	<%-- <div class="switch">
	<a href="javascript:mt.tabchange('');" id="typetab">全部(<%= Volunteer.countVolunteer(sql.toString()) %>)</a>
	<%
	List list2=Voltype.findVoltypes("", 0, Integer.MAX_VALUE);
	Iterator it2=list2.iterator();
	while(it2.hasNext()){
		Voltype vt=(Voltype)it2.next();%>
		<a href="javascript:mt.tabchange(<%=vt.getVtid() %>);" id="typetab<%=vt.getVtid() %>"><span><%=vt.getVtname()%><span>(<%= Volunteer.countVolunteer(sql.toString()+" AND vtype = "+vt.getVtid()) %>)</a>
	<%}
	%>
	</div> --%>
	<table id="tablecenter">
		<tr >
			<td width="2%" title="全选" ><input  type="checkbox"  style="cursor: pointer;" onClick="mt.select(form2.cids,checked);"/>
			 </td>
			<td  width="8%" nowrap='nowrap'  >姓名</td>
			<td  width="2%" nowrap='nowrap'>性别</td>
			<td width="12%" nowrap='nowrap' >证件号码</td>
			<td width="12%" nowrap='nowrap'>证书编号</td>
			<td width="12%" nowrap='nowrap'>证书名称</td>
			<td width="5%" nowrap='nowrap'>证书级别</td>
			<td width="12%" nowrap='nowrap'>数据上报单位</td>
			<td width="10%" nowrap='nowrap'>发证时间</td>
			<td width="10%" nowrap='nowrap'>备注名称</td>
			<td width="10%" nowrap='nowrap'>备注内容</td>
			<td width="10%" nowrap='nowrap'>操作</td>
			
		</tr>
		<%
			List list=new ArrayList();
		sql.append("order by time desc ,id desc");
		list=Ctf.findCtf(sql.toString(),pages, size);
		if(list.size()==0){
			 out.print("<tr><td colspan='12' align='center'><font color='red'>暂无记录!</font></td></tr>");
		}else{
			Iterator it=list.iterator();
			while(it.hasNext()){
				Ctf ctf=(Ctf)it.next();%>
			<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
				<td align="center"><input type="checkbox" name="cids" value="<%=ctf.getId() %>"  style="cursor: pointer;"/></td>
				<td nowrap><a href="javascript:act('query','<%=ctf.getId()%>');"><%=ctf.getName() %></a></td>
				<td align="center"><%=ctf.getSex()==0?"男":"女" %></td>
				<td nowrap><%=ctf.getCreNum()%></td>
				<td nowrap><%=ctf.getCreNumber() %></td>
				<td nowrap><%=ctf.getCreName() %></td>
				<td nowrap><%=ctf.getCreLv() %></td>
				<td nowrap><%=ctf.getDanwei() %></td>
				<td nowrap><%=MT.f(ctf.getTime()) %></td>
				<td nowrap><%=ctf.getOtherName() %></td>
				<td nowrap><%=ctf.getOther() %></td>
				<td nowrap><a href="javascript:act('edit','<%=ctf.getId()%>');">编辑</a>&nbsp;<a href="javascript:act('del','<%=ctf.getId()%>');">删除</a></td>
			</tr>
			<%}
		}
			%>
			<tr><td></td><td colspan='3' nowrap><input type="button" value="批量删除" onClick="javascript:act('delAll',0);"/><input type="button" value="批量编辑备注" onClick="javascript:act('editbz',0);"/><input type="button" value="导入" onClick="javascript:act('Import',0);"/><input type="button" value="导出" onClick="javascript:act('Excel',0);"/></td>
			<%if(count>size){out.print("<td colspan='5' align='right'>"+new tea.htmlx.FPNL(tea._nLanguage, request.getRequestURI()+pro.toString(), pages, count,size));}%>
			<td colspan='4'></td>
			</tr>
			
	</table>
	
	
	
	
	
</form>

</body>
</html>