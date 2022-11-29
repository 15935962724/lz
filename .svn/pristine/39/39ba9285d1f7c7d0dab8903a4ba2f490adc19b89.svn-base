<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");


String name=h.get("name","");

if(!name.equals("")){
	sql.append(" and name like "+Database.cite("%"+name+"%"));
	par.append("&name="+name);
}

int pos=h.getInt("pos");
par.append("&pos=");

int size=10;

%><!DOCTYPE html><html><head>
 <script>
/* var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
	  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
} */

</script> 

<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/jquery.js" type="text/javascript"></script>

</head>
<body>
<table id="tablecenter" cellspacing="0" style="background:none;" >
<form action="">
	<tr>
  		<td class="th">医院名称：</td><td><input name="name" value="<%=name %>" /></td>
  	</tr>
	<tr>
		<td colspan="2"><input type="submit" class="btn btn-primary" value="查询" /></td>
	</tr>
</form>
</table>




<table id="tablecenter" cellspacing="0" style="background:none;">
<tr>
  <td>序号</td>
  <td>医院名称</td>
  <td>操作</td>
  
</tr>
<%
int sum=ShopHospital.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
  List<ShopHospital> lsthospital=ShopHospital.find(sql.toString(), pos, size);
  for(int i=0;i<lsthospital.size();i++)
  {
	  ShopHospital hospital=lsthospital.get(i);
	  
%>
<tr>
	
	<td><%=i+1 %></td>
	<td><%=MT.f(hospital.getName()) %></td>
	
	<td><a href="javascript:void(0)" onclick="f_ok('<%=hospital.getName() %>')">选择</a></td>
</tr>
<%
  }
  if(sum>size)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size));
}%>


 
</table>



<script>


	function f_ok(a)
	{
		
		var pmt=parent.mt;
		var v=a,n='',h='';
	  pmt.receive(v,n,h);
	  pmt.close();
	}

</script>
</body>
</html>
