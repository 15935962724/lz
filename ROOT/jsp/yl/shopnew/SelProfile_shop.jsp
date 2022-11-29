<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

sql.append(" and deleted = 0 ");
sql.append(" and membertype = 2");

String name=h.get("name","");
sql.append(" and member like "+Database.cite("%"+name+"%"));
par.append("&name="+name);


int pos=h.getInt("pos");
par.append("&pos=");

int size=10;

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script>
<style>
.mt_data td,.mt_data th{padding:3px}
</style>
</head>
<body style='min-height:300px'>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>

<div class="query">
<table id="tablecenter" cellspacing="0">
<tr>
  <td>服务商：<input name="name" value="<%=name %>"/></td>
  
  <td><input type="submit" class="button" value="查询"/></td>
</tr>
</table>
</div>
</form>

<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="cancelReason"/>

<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class="results">
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>服务商</td>
  <td>操作</td>
  
</tr>
<%
int sum=Profile.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
  List<Profile> lstprofile=Profile.find1(sql.toString(), pos, size);
 
  for(int i=0;i<lstprofile.size();i++)
  {
	  Profile profile=lstprofile.get(i);
%>
<tr>
	
	<td><%=i+1 %></td>
	<td><%=MT.f(profile.member) %></td>
	
	<td><a href="javascript:void(0)" onclick="f_ok('<%=profile.member %>',<%=profile.profile %>)">选择</a></td>
</tr>
<%
  }
  if(sum>size)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size));
}%>


 
</table>
<!-- <input type="button" name="multi" value="确定" onclick="f_ok()"/> -->
</div>

<script>

/* $(document).ready(function(){
	
	$("#sel").click(function(){
		alert("1");
		var val=$(this).parent().prev().html();
		alert(val);
		parent.mt.receive(val);
		alert("22")
		parent.mt.close();
		
	}) 
	}); */
	function f_ok(a,b)
	{
		
		var pmt=parent.mt;
		var v=a,n=b,h='';
	  pmt.receive2(v,n,h);
	  pmt.close();
	}

</script>
</body>
</html>
