<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
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

sql.append(" AND status = 2 ");
par.append("&status=2");
sql.append(" AND matchstatus = 0 ");
par.append("&matchstatus=0");

int member=h.getInt("member");//服务商id
sql.append(" AND member = "+member);
par.append("&member="+member);
int hid=h.getInt("hid");//医院id
sql.append(" AND hospitalid = "+hid);
par.append("&hid="+hid);
//只匹配开票日期是应收账款日期节点之后的发票
ShopHospital hospital=ShopHospital.find(hid);//医院
Date timesport2=hospital.getTimespot2();
sql.append(" and makeoutdate > "+DbAdapter.cite(MT.f(timesport2)));
String ids=h.get("ids");//回款id以逗号分隔
par.append("&ids="+ids);
float amount=h.getFloat("amount");//选中的回款金额
par.append("&amount="+amount);
int pos=h.getInt("pos");
par.append("&pos=");

String nexturl=h.get("nexturl");

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
</style>
</head>
<body style='min-height:300px'>


<form name="form2" action="/ReplyMoneys.do" method="post" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="member" value="<%=member %>"/>
<input type="hidden" name="hospitalid" value="<%=hid %>" />
<input type="hidden" name="replyid" value="<%=ids %>" />
<input type="hidden" name="invoiceid" />
<input type="hidden" name="replyamount" value="<%=amount %>"/>
<input type="hidden" name="hangamount" />
<input type="hidden" name="matchamount" />
<input type="hidden" name="nexturl" value=""/>
<input type="hidden" name="act" value="matchinvoicenew"/>
<div class="results">
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td class="td1"><input type="checkbox" id="all"/>全选</td>
  <td>序号</td>
  <td>发票号</td>
  <td>索要发票时间</td>
  <td>开具发票时间</td>
  <td>开票数量</td>
  <td>开票金额</td>
  <td>状态</td>
  <!-- <td>操作</td> -->
</tr>
<%

int sum=Invoice.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
  List<Invoice> lst=Invoice.find(sql.toString()+" order by makeoutdate asc ",pos,20);
  for(int i=0;i<lst.size();i++)
  {
	  Invoice t=lst.get(i);
	  
%>
 <tr>
	<td><input type="checkbox" name="issigns" value="<%=t.getId() %>"/></td>
	<td><%=(i+1) %></td>
	<td><%=MT.f(t.getInvoiceno()) %></td>
	<td><%=MT.f(t.getCreatedate()) %></td>
	<td><%=MT.f(t.getMakeoutdate()) %></td>
	<td><%=t.getNum() %></td>
	
	<td><%=t.getAmount() %></td>
	<td><%=Invoice.STATUS[t.getStatus()] %></td>
	<%-- <td><a href="javascript:mt.act('data',<%=t.getId() %>)">查看</a>&nbsp;&nbsp;</td> --%>
	
</tr>
<%
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<div id="tishi0">回款金额：<%=amount %>元<span id="tishi"></span></div>

</div>
<div class='center mt15'>
		<button class="btn btn-primary" disabled="disabled" type="button" id="getinvoice" onclick="fnconfirm()">提交</button>
		<input class="quxiao" type="button" value="取消" onclick="history.go(-2)"/>
</div>
<script>
mt.act=function(a,invoiceid)
{
  
  if(a=='data')
  {
	  //alert(form2.nexturl.value);
	  //window.open("SelInvoiceDatas.jsp");
	  /* alert(form2.member.value);
	  alert(form2.hospitalid.value);
	  alert(form2.replyid.value);
	  alert(form2.replyamount.value); */
	 // parent.location="/html/folder/17100861-1.htm?invoiceid="+invoiceid+"&nexturl=/html/folder/17100826-1.htm&member="+form2.member.value+"&hid="+form2.hospitalid.value+"&ids="+form2.replyid.value+"&amount="+form2.replyamount.value;
	  parent.location="/html/folder/17110037-1.htm?invoiceid="+invoiceid+"&nexturl=/html/folder/17100826-1.htm&member="+form2.member.value+"&hid="+form2.hospitalid.value+"&ids="+form2.replyid.value+"&amount="+form2.replyamount.value;
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
	var len = $("input:checkbox:checked").length;
	//控制提交按钮
	if(len<=1){
		$('#getinvoice').attr('disabled',"true");
		
	}else{
		$('#getinvoice').removeAttr("disabled"); 
		
	}
	
	getselamount();
	
});

	
	//单选操作
	$("input[name='issigns']").click(function(){  
		
		
		
		var len = $("input[name='issigns']:checked").length; 
		//控制索要发票按钮
		if(len==0){
			$('#getinvoice').attr('disabled',"true");
			
		}else{
			$('#getinvoice').removeAttr("disabled"); 
		}
		var alllen=document.getElementsByName("issigns").length;
		//控制全选
		if(len<alllen){
			$("#all").prop("checked", false);  
		}
		if(len==alllen){
			$("#all").prop("checked", true);  
		}
		
		getselamount();

	});
	function getselamount(){
		var hk=<%=amount %>;
		
		var amount=0;
		$("input[name='issigns']:checked").each(function(){
			
			var hk=parseFloat($(this).parent().parent().find("td").eq(6).html());
			amount+=hk;
			
		});
		var gk=parseFloat(hk)-parseFloat(amount);
		if(amount>0&&gk>0){
			$("#tishi").html("&nbsp;&nbsp;已选金额："+parseFloat(amount)+"元&nbsp;&nbsp;挂款金额："+parseFloat(gk)+"元");
		}else{
			$("#tishi").html("&nbsp;&nbsp;已选金额："+parseFloat(amount)+"元&nbsp;&nbsp;");
		}
		
	}
	function f_ok(a)
	{
		
		var pmt=parent.mt;
		var v=a,n='',h='';
	  pmt.receive(v,n,h);
	  pmt.close();
	}
	//提交
	var arr=[];
	function fnconfirm(){
		//判断，四月开的发票和五月开的发票不能同时提交。
		var date2=new Date("2018-5-1");
		var flag=0;//标记
		$("input[name='issigns']:checked").each(function(){
			
			var kaidate=$(this).parent().parent().find("td").eq(4).html();
			//alert(kaidate);
			kaidate = kaidate.replace(/-/g, '/'); // "2010/08/01";
			
			// 创建日期对象
			var date = new Date(kaidate);
			
			/* var month = date.getMonth() + 1;
			arr.push(month); */
			
			if(date<date2){
				flag=1;
			}
			if(flag==1&&date>=date2){
				flag=2;
			}
			
		});
		if(flag==2){
			mt.show("由于18年5月后的增值税税率调整，批量勾选发票时，请分开5月前和5月后的发票！");
			
			return;
		}
		
		//判断结束
		var hk0=<%=amount %>;//回款金额
		
		var amount=0;
		var ids="";
		$("input[name='issigns']:checked").each(function(){
			
			var hk=parseFloat($(this).parent().parent().find("td").eq(6).html());
			amount+=hk;
			ids+=$(this).val()+",";
		});
		if(parseFloat(amount)>parseFloat(hk0)){
			mt.show("选择的开票金额不能大于回款金额！");
			return false;
		}
		var gk=parseFloat(hk0)-parseFloat(amount);//挂款金额
		
		form2.invoiceid.value=ids;
		form2.hangamount.value=parseFloat(gk);
		form2.matchamount.value=parseFloat(amount);//已选金额
		//form2.nexturl.value="/html/folder/17100825-1.htm";
		form2.nexturl.value="/html/folder/18031296-1.htm";
		form2.submit();
		
	}
mt.fit();
</script>
</body>
</html>
