<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

sql.append(" AND member="+h.member);
par.append("&member="+h.member);

sql.append(" AND status = 1");
par.append("&status=1");
//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospitalid in (select id from shophospital where name like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}


String[] TAB={"已完成匹配发票","未申请","已申请"};
String[] SQL={""," AND chargestatus = 0 "," AND chargestatus <> 0 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");



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
<style>
.mt_data td,.mt_data th{padding:3px}

input[type=text]::-ms-clear{

                display: none;

                 

            }

            input::-webkit-search-cancel-button{

                display: none;

            }  

            input.t {

                border:1px solid #fff;

                background:#fff;            

                padding-left:5px; 

                height:30px; 

                line-height:30px ;

                font-size:12px;

                font-color: #004779;

                 

            } 
</style>

</head>
<body style='min-height:300px'>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="query">
<table id="tablecenter" cellspacing="0">
<tr>
  <td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>"/>
	<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopwebnew/Selhospital.jsp',1,'选择医院',500,500)" type="button" value="请选择"/>  
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
<form name="form2" action="/Charges.do" method="post" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">

<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="hospital"/>
<div class="results">
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
<%
	if(tab==1){
%>
  <td class="td1"><input type="checkbox" id="all"/>全选</td>
  <%
	}
  %>
  <td class="td2">序号</td>
  <td class="td3">回款编号</td>
  <td class="td4">类型</td>
  <td class="td4">回款单位</td>
  
  <td class="td6">回款金额</td>
  <td class="td7">匹配金额</td>
  <td class="td7">挂款金额</td>
  <td class="td7">匹配发票号</td>
  <td class="td8">状态</td>
  <td class="td9">操作</td>
  
</tr>
<%
sql.append(SQL[tab]);

int sum=BackInvoice.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
  List<BackInvoice> lst=BackInvoice.find(sql.toString()+" order by createdate desc ",pos,20);
  for(int i=0;i<lst.size();i++)
  {
	  BackInvoice t=lst.get(i);
	  int hospitalid=t.getHospitalid();//医院
	  ShopHospital hospital=ShopHospital.find(hospitalid);//医院
	  String[] invoiceidarr=t.getInvoiceid().split(",");//匹配发票号
	  String invoicestr="";
	  for(int k=0;k<invoiceidarr.length;k++){
		  int in=Integer.parseInt(invoiceidarr[k]);
		  Invoice invoice=Invoice.find(in);
		  if(k==invoiceidarr.length-1){
			  invoicestr+=invoice.getInvoiceno();
		  }else{
			  invoicestr+=invoice.getInvoiceno()+",";
		  }
		  
	  }
	  
	  String[] replyidarr=t.getReplyid().split(",");//回款id
	  for(int j=0;j<replyidarr.length;j++){
		  int re=Integer.parseInt(replyidarr[j]);
		  RemainReplyMoney reply=RemainReplyMoney.find(re);
		  ReplyMoney rm=ReplyMoney.find(reply.getReplyid());
	      if(j==0){
%>
<tr>
<%
	if(tab==1){
%>
	<td rowspan="<%=replyidarr.length %>"><input type="checkbox" name="issigns" value="<%=t.getId() %>"/><input type="hidden" name="hid" value="<%=hospital.getId() %>"/></td>
<%
	}
%>	
	<td rowspan="<%=replyidarr.length %>"><%=(i+1) %></td>
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
	<td><%=reply.getAmount() %></td>
	
	<td rowspan="<%=replyidarr.length %>"><%=t.getMatchamount() %></td>
	<td rowspan="<%=replyidarr.length %>"><%=t.getHangamount() %></td>
	<td rowspan="<%=replyidarr.length %>"><%=invoicestr %></td>
	<td rowspan="<%=replyidarr.length %>"><%=BackInvoice.STATUS[t.getStatus()] %></td>
	<td rowspan="<%=replyidarr.length %>"><a href="javascript:mt.act('data',<%=t.getId() %>)">查看</a>&nbsp;&nbsp;</td>
	
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
</tr>
<%	    	  
	      }
	  }
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
<%
	if(tab==1){
%>
<div class='center mt15'>
		<button class="btn btn-primary"  type="button" id="getinvoice" onclick="fnconfirm()" >申请服务费</button>
	</div>
<%
	}
%>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function fnconfirm(){
	var len=$("input[name='issigns']:checked").length;
	if(len==0){
		mt.show("请选择回款再申请服务费！");
		return;
	}
	form2.act.value="askcharge";
	var i=0;
	var a=0;
	var h='';
	var hid=0;
	$("input[name='issigns']:checked").each(function(){
		
		i+=1;
		
		if(i==1){
			h=$(this).parent().parent().find("td").eq(4).html();
			hid=$(this).next().val();
		}
		
		var	h2=$(this).parent().parent().find("td").eq(4).html();
		
		
		if(h!=h2){
			mt.show("请选择同一所医院申请服务费！");
			a=1;
			return false;
		} 
		
	});
	if(a==0){
		mt.show("是否确定提交申请服务费？",2);
		mt.ok=function(){
			form2.hospital.value=hid;
			form2.nexturl.value="/html/folder/18031298-1.htm";
			form2.submit();
		}
	}
	
}
//全选操作

$("#all").click(function(){  
	
	
	if($(this).prop("checked")==true){
		
		$("input[name='issigns']").each(function(){
			  if($(this).prop("checked")==false){
				  $(this).click();
			  }
			  
		})
	}else{
		$("input[name='issigns']").each(function(){
			  
			if($(this).prop("checked")==true){
				  $(this).click();
			  }
		})
	}
	var len = $("input[name='issigns']:checkbox:checked").length;
	
	
	
	
});

	
	//单选操作
	$("input[name='issigns']").click(function(){  
		
		
		
		var len = $("input[name='issigns']:checked").length; 
		
		var alllen=document.getElementsByName("issigns").length;
		//控制全选
		if(len<alllen){
			$("#all").prop("checked", false);  
		}
		if(len==alllen){
			$("#all").prop("checked", true);  
		}
		
		

	});

	mt.act=function(a,rid)
	{
	  
	  if(a=='data')
	  {
		  //window.open("BackInvoiceDatas.jsp");
		  //window.open("BackInvoiceDatasnew.jsp");
		  parent.location="/html/folder/18031335-1.htm?backid="+rid+"&nexturl=/html/folder/17110003-1.htm"+location.search;

	  }
	};
	mt.fit();
</script>
</body>
</html>
