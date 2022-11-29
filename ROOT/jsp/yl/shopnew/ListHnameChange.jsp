<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%><%@page import="java.text.SimpleDateFormat "%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.yl.shop.HospitalNameChange"%>
<%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

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
<h1>医院名称更改记录</h1>



<form name="form2" action="/ReplyMoneys.do" method="post" target="_ajax">

<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="backid" />
<input type="hidden" name="nobackreason" />
<div class='radiusBox mt15'>
<table  id="" cellspacing="0" class='newTable'>
<tr>
  <th>序号</th>
  <th>原医院名称</th>
  <th>新医院名称</th>
  <th>变更人</th>
  <th>变更时间</th>
</tr>
<%


int sum=HospitalNameChange.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
 
  List<HospitalNameChange> lst=HospitalNameChange.find(sql.toString()+" order by createdate desc ", pos, size);
  for(int i=0;i<lst.size();i++)
  {
	  HospitalNameChange hc=lst.get(i);
	  Profile p=Profile.find(hc.getMember());
			  
		  
%>
<tr>
    <td><%=i+1 %></td>
    <td><%=MT.f(hc.getOldname()) %></td>
    <td><%=MT.f(hc.getNewname()) %></td>
    <td><%=MT.f(p.member) %></td>
    <td><%=MT.f(hc.getCreatedate(),1) %></td>
</tr>

<%			  
		 
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
</form>



<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,backid)
{
  form2.act.value=a;
  form2.backid.value=backid;
  if(a=='data')
  {
	  form2.action="/jsp/yl/shopnew/BackInvoiceDatas.jsp";
	  form2.target='_self';form2.method='get';form2.submit();
	  
  }else if(a=='backyes'){
	  mt.show("确定审核通过吗？",2);
		mt.ok=function(){
			form2.submit();
		}
  }else if(a=="backno"){
	  mt.show("<textarea id='_q' cols='28' rows='5'></textarea>",2,"拒绝原因");
	  mt.ok=function()
	  {
	    var v=document.getElementById("_q").value;
		if(v==''||v=='undefined')return;
		
		form2.nobackreason.value = v;
		form2.submit();
		
	  }
  }
};

mt.receive=function(v,n,h){
  

document.getElementById("hname").value=v;
};

mt.receive2=function(v,n,h){
	  

	document.getElementById("pname").value=v;
	};
	
	function showhospitalsearch(){
		
		mt.show("/jsp/yl/shopnew/Selhospital_shop.jsp",1,"查询医院",900,500);	
	}
	function dcorder(){
		
		form3.submit();
	}	
//mt.show('/jsp/yl/shopnew/Selhospital_shop.jsp',1,'选择医院',500,500)
</script>
</body>
</html>
