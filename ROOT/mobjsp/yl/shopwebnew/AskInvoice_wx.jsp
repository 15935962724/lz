<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.yl.shopnew.*"%><%

Http h=new Http(request,response);
String community = h.get("community","");
if(community.equals("")){
community = h.getCook("community", "Home");
}
h.setCook("community", community, Integer.MAX_VALUE);

	String openid=h.getCook("openid",null);
	if(openid==null){
		response.sendRedirect("/PhoneProjectReport.do?act=openid&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()+"&r="+Math.random()));
		return;
	}
	
	List<Profile> lstp= Profile.find1(" and openid="+DbAdapter.cite(openid), 0, 1);
	if(lstp.size()==0){
		String param = request.getQueryString();
		String url = request.getRequestURI();
		if(param != null)
			url = url + "?" + param;
		response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
		return;
	}
	Profile p1=lstp.get(0);
	if(p1.profile>0){
		h.member=p1.profile;
		session.setAttribute("member",h.member);
		//out.print("<script>alert('a:"+h.member+"');</script>");
		
	}
/* if(h.member<1){
	String param = request.getQueryString();
	String url = request.getRequestURI();
	if(param != null)
		url = url + "?" + param;
	response.sendRedirect("/mobjsp/yl/user/login_wx.jsp?nexturl="+url);
	return;
}  */
//h.member=15110990;
//out.print("<script>alert("+h.member+");</script>");
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);
//查询当前服务商下的医院
Profile p=Profile.find(h.member);
String hospitals=p.hospitals;
String[] hospitalarr=hospitals.split("\\|");
String hospitals2="0";
for(int i=1;i<hospitalarr.length;i++){
	if(hospitalarr[i].length()>0){
		String hospital=hospitalarr[i];
		
		if(i==hospitalarr.length-1){
			hospitals2+=hospital;
		}else{
			hospitals2+=hospital+",";
		}
	}
	
	
}

sql.append(" and order_id in(select order_id from shoporderdispatch where a_hospital_id in("+hospitals2+"))");
//查询当前服务商下的医院结束
/* sql.append(" AND member="+h.member);
par.append("&member="+h.member); */
/* sql.append(" AND invoicestatus = 0 ");
par.append("&invoicestatus=0"); */

//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and order_id in (select order_id from shoporderdispatch where a_hospital like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}
String orderId=h.get("orderId","");
if(orderId.length()>0)
{
  sql.append(" AND order_Id LIKE "+Database.cite("%"+orderId+"%"));
  par.append("&orderId="+h.enc(orderId));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND createDate>"+DbAdapter.cite(time0));
  par.append("&createDate="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND createDate<"+DbAdapter.cite(time1));
  par.append("&createDate="+MT.f(time1));
}

String[] TAB={"未开票订单","已开票订单"};
//String[] SQL={" and (isinvoicenum<(select quantity from shoporderdata where so.order_id=order_id and quantity>0) and noinvoicenum > 0 or isinvoicenum=0 and order_id in(select order_id from shoporderdata where quantity<0 )and noinvoicenum<0) "," and isinvoicenum=(select quantity from shoporderdata where so.order_id=order_id) "};
String[] SQL={" and ( (isinvoicenum<(select quantity from shoporderdata where so.order_id=order_id and quantity>0)and noinvoicenum>0) or (isinvoicenum=0 and order_id in(select order_id from shoporderdata where quantity<0)and noinvoicenum<0)) and status !=5"," and isinvoicenum=(select quantity from shoporderdata where so.order_id=order_id) "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");

//设置了截止日期未开票粒子数后
sql.append(" AND (isclear=0 or isclear is null) ");
%>
<!DOCTYPE html><html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<script src="/tea/mt.js" type="text/javascript"></script>

<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="webcss.css" rel="stylesheet" type="text/css">
<title>索要发票</title>
</head>
<body>
 
<header class="header">索要发票</header>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="query">
<table id="tableweb" cellspacing="0">
<tr>
  <td>　　医院：<input type="text" name="hname" id="hname" value="<%=hname %>" readonly/>
	<input id="hospitalsel" onclick="mt.show('/mobjsp/yl/shopwebnew/Selhospital.jsp',1,'选择医院',460,400)" type="button" value="请选择"/>  
    <input type="button" value="清空医院" onclick="fnclearhname()"/> 
  </td>
 </tr>
  <tr>
  <td>订单编号：<input type="text" name="orderId"  value="<%=orderId %>" /></td>
   </tr>
  <tr>
  <td style="text-align:center;"><input type="submit" class="button" value="查询"/></td>
  
</tr>
</table>
</div>
</form>
<style>
#tableweb tr:nth-child(even){background:#fff;}
</style>
<table id="tableweb" cellspacing="0" class="listtop">
	<tr>
		<td class="tdleft2">输入开票数量</td>
		<td><input type="text" name="inputnum" id="inputnum"/></td>
		<td class="tdrt2"><input type="button" id='invoicebutton1' value="确认"></td>
	</tr>
	
	<tr>
		<td class="tdleft2">或输入开票金额</td>
		<td><input type="text" name="inputamount" id="inputamount"/></td>
		<td class="tdrt2"><input type="button" id='invoicebutton2' value="确认"></td>
	</tr>

</table>
<div class='center mt15 mtotal'>
		<span id="invoicetotal">开票总金额：</span>&nbsp;<span id="invoicenum">开票总数量：</span>
	</div>
<%out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+ShopOrder.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>

<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="cancelReason"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class="results">
<%-- <table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
<%
	if(tab==0){
%>
  <td class="td1"><input type="checkbox" id="all"/>全选</td>
<%
	}
%>
  <td class="td2">序号</td>
  <td class="td3">订单编号</td>
  <td class="td4">医院</td>
  <td class="td5">下单时间</td>
  <td class="td6">数量</td>
  <td class="td7">开票金额</td>
  <td class="td8">状态</td>
  <td class="td9">未开数量</td>
  <td class="td10">填写开票数量</td>
  <td class="td11">申请开票金额</td>
</tr> --%>
<%
	if(tab==0){
%>
<div><input type="checkbox" id="all"/>全选</div>
<%
	}
sql.append(SQL[tab]);

int sum=ShopOrder.count(sql.toString());
if(sum<1)
{
  out.print("<ul style='text-align:center;width:100%;'>暂无记录!</ul>");
}else
{
  //Iterator it=ShopOrder.find(sql.toString()+" order by noinvoicenum asc,createDate asc ",pos,20).iterator();
  Iterator it=ShopOrder.find(sql.toString()+" order by SIGN(noinvoicenum) asc,createDate asc ",pos,20).iterator();
  
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopOrder t=(ShopOrder)it.next();
	  ShopOrderDispatch dispatch=ShopOrderDispatch.findByOrderId(t.getOrderId());
	  String hospital="";//医院
	  if(dispatch.getId()>0){
		  hospital=dispatch.getA_hospital();
	  }else{
		  String oldorderid=t.getOldorderid();
		  ShopOrderDispatch dispatch2=ShopOrderDispatch.findByOrderId(oldorderid);
		  hospital=dispatch2.getA_hospital();
	  }
	  List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id="+Database.cite(t.getOrderId()), 0, Integer.MAX_VALUE);
	  //每个订单只能添加一种粒子产品
	  //数量
	  int num=0;
	  //开票金额
	  double invoiceamount=0;
	  if(lstdata.size()>0){
		  ShopOrderData data=lstdata.get(0);
		  num=data.getQuantity();
		  invoiceamount=data.getAgent_amount();
	  }
	  //状态
	  String statuscontent="";
	  if(t.getStatus()==3){
		  statuscontent="已出库";
	  }else if(t.getStatus()==7){
		  statuscontent="已退货";
	  }else if(t.getStatus()==4){
		  statuscontent="已完成";
	  }else if(t.getStatus()==0){
		  statuscontent="等待付款";
	  }else if(t.getStatus()==2||t.getStatus()==-1||t.getStatus()==-2||t.getStatus()==-3||t.getStatus()==-4||t.getStatus()==-5){
		  statuscontent="等待发货";
	  }
	  int noinvoicenum=t.getNoinvoicenum();//未开票数量
%>
<ul>
    <%
			if(tab==0){
		%>
		<span class="check"><input type="checkbox" name="issigns" value="<%=t.getId() %>"/></span>
		<%
			}
		%>
	<li>
		<span class="orderid">订单号：<h3><%=MT.f(t.getOrderId()) %></h3></span>
		<span class="statuscon"><%=statuscontent %></span>
		<span class="createdate"><%=MT.f(t.getCreateDate(),1) %></span>
	</li>
	<li>
		
		<span><%=MT.f(hospital) %></span>
		<span>数量：<span class="num"><%=num %></span></span>
		<span>金额：<span class="amount"><%=invoiceamount %></span></span>
		
	</li>
	<li>
		<span>未开数量：<span><%=noinvoicenum %></span></span>
		<%
		if(tab==0){
		%>
		<input type="text" name="invoicenum" placeholder="填写开票数量"/>
		<%
		}else{
			out.print(t.getIsinvoicenum());
		}
		%>
		<span>
		<% 
		if(tab==1){
			out.print(t.getIsinvoiceamount());
		}
		%>
		</span>
		
	</li>
	
	
</ul>
<%
  }
  if(sum>20)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
}%>

</div>
<%
Profile pro = Profile.find(h.member);
if(pro.getMembertype() == 2&&tab==0){
	sql.append(" AND isLzCategory=1");
	sql.append(" order by createDate desc");
%>
	<!-- <div class='center mt15 mtotal'>
		<span id="invoicetotal">开票总金额：</span>&nbsp;<span id="invoicenum">开票总数量：</span>
	</div> -->
	<div class='btnbottom'>
		<button class="btn btn-primary"  type="button" id="getinvoice" onclick="fnconfirm()" >索要发票</button>
	</div>
<%} %>
</form>
<form action="/ShopOrders.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="exp_sh" type="hidden" />
	<input name="exflag" value="0" type="hidden"/>
	<input type='hidden' name='category' value="14102669">
		<input type='hidden' name="sql" value="<%= sql.toString() %>" />
</form>
<script>
$(function(){
	$("input[name='issigns']").each(function(){
		  if($(this).prop("checked")==true){
			  $(this).click();
		  }
		  
	})
})
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,orderId,status,statusContent)
{
  form2.act.value=a;
  form2.orderId.value=orderId;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='status')
  {
	  form2.status.value=status;
	  if(status==5){
		  mt.show("<textarea id='_content' cols='33' rows='6' title='请填写取消订单原因...'></textarea>",2,'取消订单原因',348);
	      mt.ok=function()
	      {
	        var t=parent.$$('_content');
	        if(t.value=='')
	        {
	          alert('“取消订单原因”不能为空！');
	          return false;
	        }
	        form2.cancelReason.value=t.value;
	        form2.submit();
	      };
	  }else{
	  	mt.show('你确定要"'+statusContent+'"吗？',2,'form2.submit()');
	  }
  }else if(a=='data')
  {
	  //window.open("ShopOrderDatas.jsp?orderId="+orderId);
	  parent.location="/html/folder/14110832-1.htm?orderId="+orderId;

  }else if(a=='payment')
  {
	  //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
	  window.open("/html/folder/14110391-1.htm?orderId="+orderId);
  }else if(a=='refund')
  {
	  //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
	  parent.location="/html/folder/14111279-1.htm?orderId="+orderId;
  }else if(a=='getfp'){
	  //parent.location="/jsp/yl/shopweb/ShopGetFp.jsp?orderId="+orderId;
	  parent.location="/html/folder/14113269-1.htm?orderId="+orderId;
  }else if(a=='printOrder'){
	  /* form2.action=("/jsp/yl/shop/ShopOrderDatasReceipt.jsp");
	  form2.target='_self';form2.method='get';form2.submit(); */
	 // parent.location="/jsp/yl/shop/ShopOrderDatasReceipt.jsp";
	  parent.location="/html/folder/17072660-1.htm?orderId="+orderId;
  }
};
function dcorder(){
	form3.submit();
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
	//控制索要发票按钮
	if(len==0){
		//$('#getinvoice').attr('disabled',"true");
		//放开输入开票数量和开票金额的文本框的禁用
		$("#inputnum").removeAttr('disabled');
		$("#invoicebutton1").removeAttr('disabled');
		$("#inputamount").removeAttr('disabled');
		$("#invoicebutton2").removeAttr('disabled');
	}else{
		//$('#getinvoice').removeAttr("disabled"); 
		//禁用输入开票数量和开票金额的文本框
		$("#inputnum").attr('disabled',"true");
		$("#invoicebutton1").attr('disabled',"true");
		$("#inputamount").attr('disabled',"true");
		$("#invoicebutton2").attr('disabled',"true");
	}
	getTotal();
	
	
});
mt.receive=function(v,n,h){
	  document.getElementById("hname").value=v;
	};
	
	//单选操作
	$("input[name='issigns']").click(function(){  
		
		
		
		var len = $("input[name='issigns']:checked").length; 
		//控制索要发票按钮
		if(len==0){
			//$('#getinvoice').attr('disabled',"true");
			
		}else{
			//$('#getinvoice').removeAttr("disabled"); 
		}
		var alllen=document.getElementsByName("issigns").length;
		//控制全选
		if(len<alllen){
			$("#all").prop("checked", false);  
		}
		if(len==alllen){
			$("#all").prop("checked", true);  
		}
		//控制开票数量和开票金额
		if($(this).prop("checked")==true){
			var num=$(this).parent().parent().find("li:last").children().children().html();//未开票数量
			
			$(this).parent().parent().find("li:last").find("input[name='invoicenum']").val(num);//赋值
			//求单价
			var num2=$(this).parent().parent().find("li").eq(1).find(".num").html();
			
			var amount=$(this).parent().parent().find("li").eq(1).find(".amount").html();
			
			var dan=parseInt(amount)/parseInt(num2);
			$(this).parent().parent().find("li").eq(2).find("span:last").html(dan*parseInt(num));
		}else{
			$(this).parent().parent().find("li:last").find("input[name='invoicenum']").val("");//赋值
			$(this).parent().parent().find("li").eq(2).find("span:last").html("");
		}
		getTotal();
		

	});
	//输入开票数量
	$("input[name='invoicenum']").keyup(function(){
		//var wnum=parseInt($(this).parent().parent().find("td").eq(8).html());//未开票数量
		var wnum=parseInt($(this).prev().children().html());//未开票数量
		if(wnum>0){
			this.value=this.value.replace(/\D/g,'');
		}else{
			var digit = /^-{1}\d+$/;
			if (this.value.length>2&&!digit.test(this.value)) 
	         {
	            alert("只能输入负数");
	            $(this).focus(); 
	         }
		}
		var num=$(this).val();
		if(parseInt(num)>0&&parseInt(num)>wnum){
			mt.show("请输入正确的开票数量！");
			$(this).focus();
			$(this).next().html("");
			return;
		}
		if(parseInt(num)<0&&Math.abs(parseInt(num))>Math.abs(wnum)){
			mt.show("请输入正确的开票数量！");
			$(this).focus();
			$(this).next().html("");
			return;
		}
		if(parseInt(num)==0){
			mt.show("请输入正确的开票数量！");
			$(this).select();
			$(this).next().html("");
			return;
		}
		if(num!=''){
			//var num2=parseInt($(this).parent().prev().prev().prev().prev().html());
			
			var num2=parseInt($(this).parent().prev().find("span").eq(1).children().html());
			var invoiceamount=parseFloat($(this).parent().prev().find(".amount").html());
			
			$(this).next().html(parseFloat(invoiceamount/num2*num));
			
			$(this).parent().parent().find("input:checkbox").prop("checked",true);
		}else{
			$(this).next().html("");
			$(this).parent().parent().find("input:checkbox").prop("checked",false);
		}
		var len = $("input[name='issigns']:checked").length; 
		//控制索要发票按钮
		if(len==0){
			//$('#getinvoice').attr('disabled',"true");
			
		}else{
			//$('#getinvoice').removeAttr("disabled"); 
		}
		getTotal();
		
	})
	//计算开票总金额和开票总数量
	function getTotal(){
		var totalnum=0;
		var totalamount=0;
		//获取所有选中的复选框
		$("input:checkbox[name='issigns']:checked").each(function(){
			var num=parseInt($(this).parent().parent().find("li:last").find("input[name='invoicenum']").val());
			
			totalnum+=num;
			var amount=parseInt($(this).parent().parent().find("li").eq(2).find("span:last").html());
			totalamount+=amount;
		})
		$("#invoicetotal").html("开票总金额：<span id='invoval'>"+totalamount+"</span>元");
		$("#invoicenum").html("开票总数量：<span id='numval'>"+totalnum+"</span>粒");
	}
	
	
	
	
	
	//输入开票数量
	$("#invoicebutton1").click(function(){
		var hname=$("#hname").val();
		if(hname==''){
			mt.show("请先选择医院！");
			return;
		}
		  $("#inputamount").val("");//清空开票金额的值
			//吧所有选中的都去掉
			$(":checkbox:checked").each(function(){
				$(this).click();
			})
			var v=parseInt($("#inputnum").val());
			if(v>0){
			var tnum=0;
			var i=0;
			$("input[name='issigns']").each(function(){
				//var num=parseInt($(this).parent().parent().find("td").eq(8).html());
				var num=parseInt($(this).parent().parent().find("li").eq(2).children(":first").children().html());
				tnum+=num;
				i+=1;
				if(tnum>=v){
					for(var a=0;a<i;a++){
						if($("input[name='issigns']").eq(a).prop('checked')==false) {
							$("input[name='issigns']").eq(a).click();
						}
						
					}
					return false;
				}
			})
			//获取选中的总粒数
			var tnum2=0;
			var j=0;//计数
			$("input[name='issigns']:checked").each(function(){
				j+=1;
				//var tempnum=parseInt($(this).parent().parent().find("td").eq(9).children().val());
				var tempnum=parseInt($(this).parent().parent().find("li").eq(2).find("input").val());
				
				tnum2+=tempnum;
				
			})
			
			var cha=0;
			if(tnum2>v){
				var cha=tnum2-v;
				
			}
			//var nowval=parseInt($("input[name='issigns']").eq(j-1).parent().parent().find("td").eq(9).children().val());
			var nowval=parseInt($("input[name='issigns']").eq(j-1).parent().parent().find("li").eq(2).find("input").val());
			var nowval2=nowval-parseInt(cha);
			
			//赋新的开票数量
			//$("input[name='issigns']").eq(j-1).parent().parent().find("td").eq(9).children().val(nowval2);
			$("input[name='issigns']").eq(j-1).parent().parent().find("li").eq(2).find("input").val(nowval2);
			//重新计算申请开票金额
			var kainum=parseInt($("input[name='issigns']").eq(j-1).parent().parent().find("li").eq(1).find("span").eq(1).children().html());//开票数量
			
			var kaiamount=parseFloat($("input[name='issigns']").eq(j-1).parent().parent().find("li").eq(1).find(".amount").html());//开票金额
			
			var kaidan=parseFloat(kaiamount/kainum);
			
			//赋新的开票金额
			$("input[name='issigns']").eq(j-1).parent().parent().find("li").eq(2).find("span:last").html(nowval2*kaidan);
			getTotal();
			}else{
				mt.show("请输入正确的开票数量");
				$(":checkbox:checked").each(function(){
					$(this).click();
				})
				return;
			}
	
		
	})
	//输入开票金额
	$("#invoicebutton2").click(function(){
		var hname=$("#hname").val();
		if(hname==''){
			mt.show("请先选择医院！");
			return;
		}
		//输入申请开票金额
		
			
			$("#inputnum").val("");//清空开票数量的值
			
			//吧所有选中的都去掉
			$(":checkbox:checked").each(function(){
				$(this).click();
			})
			var v=parseFloat($("#inputamount").val());
			if(v>0){
				var tamount=0;
				var i=0;
				
				$("input[name='issigns']").each(function(){
					//计算申请开票金额
					var amount=parseFloat($(this).parent().parent().find("li").eq(1).find(".amount").html());
					
					var num=parseFloat($(this).parent().parent().find("li").eq(1).find(".num").html());
					var dan=parseFloat(amount/num);//单价
					var weinum=parseFloat($(this).parent().parent().find("li").eq(2).find("span").eq(1).html());//未开数量
					var shen=parseFloat(dan*weinum);
					
					
					tamount+=shen;
					//alert(tamount);
					i+=1;
					if(parseFloat(tamount)>=v){
						
						for(var a=0;a<i;a++){
							$("input[name='issigns']").eq(a).click();
						}
						return false;
					}
				})
				var tempamount=0;
				$("input[name='issigns']:checked").each(function(){
					
					//计算选中的所有的开票金额
					var amount=parseFloat($(this).parent().parent().find("li").eq(1).find(".amount").html());//开票金额
					var num=parseInt($(this).parent().parent().find("li").eq(1).find(".num").html());//开票数量
					var dan=parseFloat(amount/num);//单价
					var weinum=parseFloat($(this).parent().parent().find("li").eq(2).find("span").eq(1).html());//未开数量
					tempamount+=parseFloat(weinum*dan);
					//alert(tempamount);
				})
				
				var lastamount=parseFloat($("input[name='issigns']:checked").eq(i-1).parent().parent().find("li").eq(1).find(".amount").html());//最后一个的开票金额
				
				var lastnum=parseInt($("input[name='issigns']:checked").eq(i-1).parent().parent().find("li").eq(1).find(".num").html());//最后一个的开票数量
				var lastdan=parseFloat(lastamount/lastnum);//最后一个的单价
				//alert(tempamount);
				if(i>1){
					var cha=parseFloat(tempamount-v);
					//计算最后一个选中的单价
					
					var yushu=cha%lastdan;
					
					if(cha!=0&&yushu==0){
					
						var newamount=parseFloat(lastamount-cha);
						/* alert(lastamount);
						alert(cha); */
						var newnum=parseInt(newamount/lastdan);
						
						$("input[name='issigns']:checked").eq(i-1).parent().parent().find("input[name='invoicenum']").val(newnum);
						$("input[name='issigns']:checked").eq(i-1).parent().parent().find("li").eq(2).find("span:last").html(newamount);
					}else if(cha!=0&&yushu!=0){
						mt.show("请输入正确的开票金额（开票单价的整数倍）！");
						$(":checkbox:checked").each(function(){
							$(this).click();
						})
						return;
					}
				}else if(i==1){
					var yushu=v%lastdan;
					if(yushu==0){
						var newnum=v/lastdan;
						
						$("input[name='issigns']:checked").eq(i-1).parent().parent().find("input[name='invoicenum']").val(newnum);
						$("input[name='issigns']:checked").eq(i-1).parent().parent().find("li").eq(2).find("span:last").html(v);
					}else{
						mt.show("请输入正确的开票金额（开票单价的整数倍）！");
						$(":checkbox:checked").each(function(){
							$(this).click();
						})
						return;
					}
				}
				/* var cha=parseFloat(tempamount-v);
				if(cha!=0){
					mt.show("请输入正确的开票金额！");
					$(":checkbox:checked").each(function(){
						$(this).click();
					})
					return;
				} */
				getTotal();
			}else{
				mt.show("请输入正确的开票金额");
				$(":checkbox:checked").each(function(){
					$(this).click();
				})
				return;
			}
		
	})
	function fnconfirm(){
		
		var a=$("input[name='issigns']:checked").length;
		
		if(a==0){
			mt.show("请选择订单再申请发票！");
			return;
		}
		var i=0;
		var hospital='';
		var a=0;
		
		$("input[name='issigns']:checked").each(function(){
			
			i+=1;
			
			if(i==1){
				hospital=$(this).parent().parent().find("li").eq(1).find("span:first").html();
				
			}
			var hospital2=$(this).parent().parent().find("li").eq(1).find("span:first").html();
			
			
			if(hospital2!=hospital){
				
				mt.show("请选择同一医院申请开票！");
				a=1;
				return false;
				
			}
			
		});
		if(a==0){
			
			var ids='';//id
			var nums='';//开票数量
			var amounts='';//开票金额
			$("input[name='issigns']:checked").each(function(){
				ids+=$(this).val()+",";
				nums+=$(this).parent().parent().find("li").eq(2).find("input[name='invoicenum']").val()+",";
				
				amounts+=$(this).parent().parent().find("li").eq(2).find("span").eq(2).html()+",";
			});
			//mt.show('/jsp/yl/shopwebnew/AskInvoiceConfirm.jsp?ids='+ids+'&nums='+nums+'&amounts='+amounts,2,'新增收货人地址',800,600);
			
			var aa='/mobjsp/yl/shopwebnew/AskInvoiceConfirm_wx.jsp';
			var invoval=$("#invoval").html();
			var numval=$("#numval").html();
			if(parseInt(invoval)<0||parseInt(numval)<0){
				mt.show("开票数量或开票金额不能为负！");
				return;
			} 
			//location.href='/html/folder/17100788-1.htm?ids='+ids+'&nums='+nums+'&amounts='+amounts+'&hospital='+hospital+'&nexturl='+location.pathname+location.search;
			location.href=aa+'?ids='+ids+'&nums='+nums+'&amounts='+amounts+'&hospital='+hospital+'&nexturl='+location.pathname+location.search+'&invoval='+invoval+'&numval='+numval;
		}
		
	}
	//清空医院
	function fnclearhname(){
		var hname=$("#hname");
		hname.val("");
	}
mt.fit();
</script>

</body>
</html>
