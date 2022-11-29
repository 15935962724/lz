<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%><%@page import="java.text.SimpleDateFormat "%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);


//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospitalid in(select id from shophospital where name like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}
//按服务商查询

String pname=h.get("pname","");
if(pname.length()>0){
	
	sql.append(" and member in(select profile from profile where member like "+Database.cite("%"+pname+"%")+")");
	par.append("&pname="+h.enc(pname));
}

String[] TAB={"待审核","审核通过","审核不通过"};
String[] SQL={" AND status = 0 "," AND status = 1 "," AND status = 2 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

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
<h1>回款匹配发票管理</h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="radiusBox">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='3'>查询</td></tr>
</thead>
<tr>
  <td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>"/>
	<input id="hospitalsel" onclick="showhospitalsearch()" type="button" value="请选择"/>  
  </td>
  <td>服务商：<input type="text" name="pname" id="pname" value="<%=pname %>"/>
	<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopnew/SelProfile_shop.jsp',1,'选择服务商',500,500)" type="button" value="请选择"/>  
  </td>
  
  <td><input type="submit" class="button" value="查询"/></td>
  
</tr>
</table>
</div>
</form>

<%out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+BackInvoice.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<form name="form2" action="/ReplyMoneys.do" method="post" target="_ajax">

<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="backid" />
<input type="hidden" name="nobackreason" />
<div class='radiusBox mt15'>
<table  id="" cellspacing="0" class='newTable'>
<tr>
  
  <th>序号</th>
  <th>回款编号</th>
  <th>类型</th>
  <th>回款单位</th>
  <th>服务商</th>
  <th>回款金额</th>
  <th>服务商匹配金额</th>
  <th>挂款金额</th>
  <th>回款时间</th>
  <th>状态</th>
  <th>进项税返还政策</th>
  <th>操作</th>
  
</tr>
<%
sql.append(SQL[tab]);

int sum=BackInvoice.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
 
  List<BackInvoice> lstback=BackInvoice.find(sql.toString()+" order by createdate desc ", pos, size);
  for(int i=0;i<lstback.size();i++)
  {
	  BackInvoice back=lstback.get(i);
	  ShopHospital hospital=ShopHospital.find(back.getHospitalid());//回款单位
	  Profile profile=Profile.find(back.getMember());//服务商
	  String replyids=back.getReplyid();//回款id
	  String[] replyidarr=replyids.split(",");
	  for(int j=0;j<replyidarr.length;j++){
		  String re=replyidarr[j];
		  RemainReplyMoney reply=RemainReplyMoney.find(Integer.parseInt(re));//回款
		  ReplyMoney rm=ReplyMoney.find(reply.getReplyid());
		  if(j==0){
			  
		  
%>
<tr>
    <td rowspan="<%=replyidarr.length %>"><%=i+1 %></td>
    <td>
    	<%
    		if(reply.getType()==0){
    			out.print(rm.getCode());
    		}else if(reply.getType()==1){
    			out.print(reply.getCode());
    		}
    	%>
    </td>
    <td><%=RemainReplyMoney.typeARR[reply.getType()] %></td>
    <td rowspan="<%=replyidarr.length %>"><%=hospital.getName() %></td>
    <td rowspan="<%=replyidarr.length %>"><%=profile.member %></td>
    <td><%=reply.getAmount() %></td>
    <td rowspan="<%=replyidarr.length %>"><%=back.getMatchamount() %></td>
    <td rowspan="<%=replyidarr.length %>"><%=back.getHangamount() %></td>
    <td>
    	<%
	    	if(reply.getType()==0){
				out.print(MT.f(rm.getReplyTime()));
			}else if(reply.getType()==1){
				out.print(MT.f(reply.getReplyTime()));
			}
    	%>
    </td>
    <td rowspan="<%=replyidarr.length %>"><%=BackInvoice.STATUS[back.getStatus()] %></td>
    <td rowspan="<%=replyidarr.length %>"><%=Profile.TAX[Integer.parseInt(MT.f(profile.tax,0))] %></td>
    <td rowspan="<%=replyidarr.length %>">
    	<button type="button" class="btn btn-link" onclick="mt.act('data','<%=back.getId() %>')">查看详情</button>
    	<%
    		if(back.getStatus()==0){
    	%>
    	<button type="button" class="btn btn-link" onclick="mt.act('backyesnew','<%=back.getId() %>')">审核通过</button>
    	<button type="button" class="btn btn-link" onclick="mt.act('backnonew','<%=back.getId() %>')">审核不通过</button>
    	<%
    		}
    	%>
    </td>	
	
</tr>
<%
		  }else{
%>
<tr>
    <td>
    	<%
    		if(reply.getType()==0){
    			out.print(rm.getCode());
    		}else if(reply.getType()==1){
    			out.print(reply.getCode());
    		}
    	%>
    </td>
    <td><%=RemainReplyMoney.typeARR[reply.getType()] %></td>
    <td><%=reply.getAmount() %></td>
    <td>
    	<%
	    	if(reply.getType()==0){
				out.print(MT.f(rm.getReplyTime()));
			}else if(reply.getType()==1){
				out.print(MT.f(reply.getReplyTime()));
			}
    	%>
    </td>
    	
	
</tr>
<%			  
		  }
	  }
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>



<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,backid)
{
  form2.act.value=a;
  form2.backid.value=backid;
  if(a=='data')
  {
	  form2.action="/jsp/yl/shopnew/BackInvoiceDatasnew.jsp";
	  form2.target='_self';form2.method='get';form2.submit();
	  
  }else if(a=='backyesnew'){
	  mt.show("确定审核通过吗？",2);
		mt.ok=function(){
			form2.submit();
		}
  }else if(a=="backnonew"){
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
	
//mt.show('/jsp/yl/shopnew/Selhospital_shop.jsp',1,'选择医院',500,500)
</script>
</body>
</html>
