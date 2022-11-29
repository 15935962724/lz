<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%><%@page import="java.text.SimpleDateFormat "%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&id="+menu);


//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospitalid in(select id from shophospital where name like "+Database.cite("%"+hname+"%")+") ");
	par.append("&hname="+h.enc(hname));
}


    int puid = Config.getInt(h.get("puid"));
    sql.append(" AND sho.invoicePuid = "+puid);
    par.append("&puid="+h.get("puid"));

int pos=h.getInt("pos");
par.append("&pos=");

int size=20;
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

<style type="text/css">
.newTable tr:hover{background:#fff !important;}
</style>
</head>
<body>
<h1>应收账款数据表</h1>
	
	<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>

<div class="radiusBox">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='3'>查询</td></tr>
</thead>
<tr>
  <td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>"/>
	<input id="hospitalsel" onclick="showhospitalsearch()" type="button" value="请选择"/>  
  </td>
  
  <td><input type="submit" class="button" value="查询"/></td>
  
</tr>
</table>
</div>
</form>
<div class='radiusBox mt15'>
<table  id="" cellspacing="0" class='newTable'>
<tr>
  
  <th>序号</th>
  <th>医院</th>
  <th>服务商</th>
  <th>应收账款</th>
  <th>日期节点</th>
  <th>类型</th>
  
</tr>
<%
int sum=ChangeYingshouData.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
 
  List<ChangeYingshouData> lstchange=ChangeYingshouData.find(sql.toString()+" order by ordernum desc ", pos, size);
  for(int i=0;i<lstchange.size();i++)
  {
	  ChangeYingshouData data=lstchange.get(i);
	  ShopHospital hospital=ShopHospital.find(data.getHospitalid());//医院
	  List<Profile> lstpro=Profile.find1(" and hospitals like "+DbAdapter.cite("%"+hospital.getId()+"%"), 0, Integer.MAX_VALUE);
	  String member="";//服务商
	  if(lstpro.size()>0){
		  Profile pro=lstpro.get(0);
		  member=pro.member;
	  }
			  
		  
%>
<tr>
    <td><%=i+1 %></td>
    <td><%=MT.f(hospital.getName()) %></td>
    <td><%=member %></td>
    <td><%=ShopHospital.getDecimal(data.getNoreply()) %></td>
    <td><%=MT.f(data.getTimespot2()) %></td>
    <td><%=ChangeYingshouData.ISBACK[data.getIsback()] %></td>
</tr>

<%			  
		 
	  
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
<script type="text/javascript">
mt.receive=function(v,n,h){
	  

	document.getElementById("hname").value=v;
	};

	mt.receive2=function(v,n,h){
		  

		document.getElementById("pname").value=v;
		};
	function showhospitalsearch(){
		
		mt.show("/jsp/yl/shopnew/Selhospital_shop.jsp",1,"查询医院",900,500);	
	}
</script>
</body>
</html>
