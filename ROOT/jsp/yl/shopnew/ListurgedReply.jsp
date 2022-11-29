<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


String pids=h.get("pids");




//按服务商查询

String pname=h.get("pname","");
if(pname.length()>0){
	pids="";
	List<Profile> lst=Profile.find1(" and member like "+DbAdapter.cite("%"+pname+"%"), 0, Integer.MAX_VALUE);
	if(lst.size()==0){
		pids=",";
	}else{
		for(int i=0;i<lst.size();i++){
			int p=lst.get(i).profile;
			pids+=p+",";
		}
	}
	
}

%><!DOCTYPE html><html><head>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
	  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}

</script> 

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>


</head>
<body>
<h1>催缴单</h1>

<form name="form1" action="?">
<input type="hidden" name="pids" value="<%=pids %>" />
<div class="radiusBox">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='3'>查询</td></tr>
</thead>
<tr>
  
  <td>服务商：<input type="text" name="pname" id="pname" value="<%=pname %>"/>
	  
  </td>
  
  <td><input type="submit" class="button" value="查询"/></td>
  
</tr>
</table>
</div>
</form>
<form action="/Invoices.do" method="post" target="_ajax" name="form2">
	<input type="hidden" name="pids" value=""/> 
	<input type="hidden" name="act" value="urgedprofilereply"/> 
</form>
<table  id="" cellspacing="0" class='newTable'>
<tr>
  <th><input type="checkbox" id="all"/>全选</th>
  <th>序号</th>
  <th>服务商</th>
 
  <th>医院</th>
  
  
</tr>
<%


String[] arrpid=pids.split(",");

int sum=arrpid.length;
if(sum==0){
	out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else{
int a=0;
for(int i=0;i<arrpid.length;i++){
	int pid=Integer.parseInt(arrpid[i]);
	Profile p=Profile.find(pid);
	
	String sql=" and sod.order_id in(select order_id from shoporder so where 1=1 and status!=5 and status!=6 and member="+pid+" AND order_id in (select orderid from invoicedata where invoiceid in(select id from invoice where status=2 and matchstatus!=2 and DATEDIFF(y, makeoutdate, GETDATE()) >=15)) ) group by sod.a_hospital  ";
	//根据服务商获取有哪些医院
	List<String> lsth=ShopOrderDispatch.searchHospital(sql, 0, Integer.MAX_VALUE);
	
	for(int j=0;j<lsth.size();j++){
		
		String hname=lsth.get(j);
%>

	<tr>
	<%
		if(j==0){
	%>
	<td rowspan="<%=lsth.size() %>"><input type="checkbox" name="isurged" value="<%=pid %>"/></td>
	<td rowspan="<%=lsth.size() %>"><%=(i+1) %></td>
	<td rowspan="<%=lsth.size() %>"><%=MT.f(p.member) %></td>
	<%
		}
	%>
	<td><%=MT.f(hname) %></td>
	</tr>

<%
	}
	
}
  
}%>
</table>


<div class='center mt15'><button class="btn btn-primary" type="button" disabled="disabled"  id="sendurged">发送短信催缴</button>

</div>

<script>
//全选操作

$("#all").click(function(){  
	
	
	if($(this).prop("checked")==true){
		
		$("input[name='isurged']").each(function(){
			  if($(this).prop("checked")==false){
				  $(this).click();
			  }
			  
		})
	}else{
		$("input[name='isurged']").each(function(){
			  
			if($(this).prop("checked")==true){
				  $(this).click();
			  }
		})
	}
	var len = $("input:checkbox:checked").length;
	//控制索要发票按钮
	if(len==0){
		$('#sendurged').attr('disabled',"true");
		
	}else{
		$('#sendurged').removeAttr("disabled"); 
		
	}
	
	
	
});

	
	//单选操作
	$("input[name='isurged']").click(function(){  
		
		
		
		var len = $("input[name='isurged']:checked").length; 
		//控制索要发票按钮
		if(len==0){
			$('#sendurged').attr('disabled',"true");
			
		}else{
			$('#sendurged').removeAttr("disabled"); 
		}
		var alllen=document.getElementsByName("isurged").length;
		//控制全选
		if(len<alllen){
			$("#all").prop("checked", false);  
		}
		if(len==alllen){
			$("#all").prop("checked", true);  
		}
		

	});

	$("#sendurged").click(function(){
		var ids='';
		
			
			$("input[name='isurged']:checked").each(function(){
				ids+=$(this).val()+",";
				
			});
			alert(ids);
			form2.pids.value=ids;
			form2.submit();
		
	});

</script>
</body>
</html>
