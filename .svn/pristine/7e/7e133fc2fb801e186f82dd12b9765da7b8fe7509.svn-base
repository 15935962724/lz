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

sql.append(" AND profile="+h.member);
par.append("&profile="+h.member);

//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hid in (select id from shophospital where name like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}


String[] TAB={"未匹配发票","待审核","已匹配发票","全部"};
String[] SQL={" AND statusmember = 1 "," AND statusmember = 2 "," AND statusmember = 3 "," AND statusmember > 0 ",};

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
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+RemainReplyMoney.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<form name="form2" action="/ReplyMoneys.do" method="post" target="_ajax">

<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="replyid"/>
<div class="results">
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <%
   	if(tab==0){
  %>
  <td class="td1">
  
  <input type="checkbox" id="all"/>全选</td>
  <%
   	}
  %>
  <td class="td2">序号</td>
  <td class="td3">回款编号</td>
  <td class="td4">类型</td>
  <td class="td4">回款单位</td>
  
  <td class="td6">回款金额</td>
  <td class="td7">回款时间</td>
  <td class="td8">状态</td>
  <td class="td9">操作</td>
  
</tr>
<%
sql.append(SQL[tab]);

int sum=RemainReplyMoney.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
  List<RemainReplyMoney> lst=RemainReplyMoney.find(sql.toString()+" order by time desc ",pos,20);
  for(int i=0;i<lst.size();i++)
  {
	  RemainReplyMoney t=lst.get(i);
	  ShopHospital hospital=ShopHospital.find(t.getHid());
	  ReplyMoney rm=ReplyMoney.find(t.getReplyid());
	  
%>
<tr>
	<%
	    if(tab==0){
	%>
	<td>
	
	<input type="checkbox" name="issigns" value="<%=t.getId() %>"/>
	<input type="hidden" value="<%=hospital.getId() %>"/>
	
	</td>
	<%
	    }
	%>
	<td><%=(i+1) %></td>
	<td>
		<%
			if(t.getType()==0){
				out.print(rm.getCode());
			}else if(t.getType()==1){
				out.print(t.getCode());
			}
		%>
	</td>
	<td><%=RemainReplyMoney.typeARR[t.getType()] %></td>
	<td><%=MT.f(hospital.getName()) %></td>
	
	<td><%=t.getAmount() %></td>
	<td>
		<%
			if(t.getType()==0){
				out.print(MT.f(rm.getReplyTime()));
			}else if(t.getType()==1){
				out.print(MT.f(t.getReplyTime()));
			}
		%>
	</td>
	<td><%=RemainReplyMoney.statusmemberARR[t.getStatusmember()] %></td>
	<td><a href="javascript:mt.act('data',<%=t.getId() %>)">查看</a>&nbsp;&nbsp;</td>
	
</tr>
<%
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<div id="tishi0"></div>
</div>
<%
	if(tab==0){
%>
<div class='center mt15'>
		<button class="btn btn-primary"  type="button" id="getinvoice" onclick="fnconfirm(<%=h.member %>)" >选择发票</button>
</div>
<%
	}
%>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,rid)
{
  form2.act.value=a;
  form2.replyid.value=rid;
  if(a=='data')
  {
	  //window.open("ReplyMoneyDatas.jsp");
	  //window.open("ReplyMoneyDatasnew.jsp");
	  parent.location="/html/folder/18031333-1.htm?replyid="+rid+"&nexturl=/html/folder/17100825-1.htm"+location.search;

  }
};


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
	
	
	gethk();
	
});
mt.receive=function(v,n,h){
	  document.getElementById("hname").value=v;
	};
	
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
		
		gethk();

	});
	
	
	
	
	//输入开票金额
	
	function fnconfirm(member){
		
		var len=$("input[name='issigns']:checked").length;
		if(len==0){
			mt.show("请选择回款再匹配发票！");
			return;
		}
		var i=0;
		var hospital='';//医院名称
		var a=0;
		var hid=0;//医院id
		var amount=0;//回款金额
		
		$("input[name='issigns']:checked").each(function(){
			
			i+=1;
			
			if(i==1){
				hospital=$(this).parent().parent().find("td").eq(4).html();
				hid=$(this).next().val();
			}
			var hospital2=$(this).parent().parent().find("td").eq(4).html();
			
			if(hospital2!=hospital){
				
				mt.show("请选择同一医院选择发票！");
				a=1;
				return false;
				
			}
			var hk=parseFloat($(this).parent().parent().find("td").eq(5).html());
			amount+=hk;
			
		});
		if(a==0){
			
			var ids='';//id
			var nums='';//开票数量
			var amounts='';//开票金额
			$("input[name='issigns']:checked").each(function(){
				ids+=$(this).val()+",";
				
			});
			//jsp/yl/shopwebnew/SelInvoice.jsp;
			//jsp/yl/shopwebnew/SelInvoicenew.jsp;
			location.href='/html/folder/18031332-1.htm?ids='+ids+'&member='+member+'&hid='+hid+'&amount='+parseFloat(amount)+'&nexturl=/html/folder/17100825-1.htm'+location.search;
		}
		
	}
	//选中的回款金额
	function gethk(){
		var amount=0;
		$("input[name='issigns']:checked").each(function(){
			
			var hk=parseFloat($(this).parent().parent().find("td").eq(5).html());
			amount+=hk;
			
		});
		$("#tishi0").html("已选中的回款金额："+parseFloat(amount)+"元");
		mt.fit();
	}
	mt.fit();
</script>
</body>
</html>
