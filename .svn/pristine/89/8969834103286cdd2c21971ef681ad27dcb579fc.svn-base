<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.yl.shopnew.*"%>
<%@ page import="tea.entity.admin.orthonline.Hospital" %>
<%

//ShopOrder.changeInvoiceNA();3.13已走过


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);
sql.append(" AND issubmitinvoice !=2");
//查询当前服务商下的医院
Profile p=Profile.find(h.member);
String hospitals=p.hospitals;

if(p.membertype==2){
	String[] hospitalarr=hospitals.split("\\|");
	for(int i=1;i<hospitalarr.length;i++){
		String hospital=hospitalarr[i];
		ShopHospital hospital1 = ShopHospital.find(Integer.parseInt(hospital));
		System.out.println(hospital1.getName());

	}
	sql.append(" AND applyUnit = 0 ");
}else{
	ShopQualification sq = ShopQualification.findByMember(p.profile);
	sql.append(" AND (applyUnit = "+sq.hospital_id+" or member = "+h.member+")");
}

//sql.append(" and order_id in(select order_id from shoporderdispatch where a_hospital_id in("+hospitals2+"))");
//查询当前服务商下的医院结束
/* sql.append(" AND member="+h.member);
par.append("&member="+h.member);  */
/* sql.append(" AND invoicestatus = 0 ");
par.append("&invoicestatus=0"); */
//按医院查询

/*String hname=h.get("hname","");
if(hname.length()>0){
	//sql.append(" and order_id in (select order_id from shoporderdispatch where a_hospital like "+Database.cite("%"+hname+"%")+")");
	sql.append(" and order_id in (select order_id from shoporderdispatch where a_hospital = "+Database.cite(hname)+")");
	par.append("&hname="+h.enc(hname));
}*/
	String hname=h.get("hname","");
	if(hname.length()>0){
		ShopHospital sh1 = ShopHospital.find(hname);
		ArrayList<ShopHospital> shopHospitals = ShopHospital.find(" AND name=" + Database.cite(hname), 0, Integer.MAX_VALUE);
		if(shopHospitals.size()>0) {//重名了
			String hospitalstr = p.hospitals;
			for (int i = 0; i <shopHospitals.size() ; i++) {
				if(hospitalstr.contains(shopHospitals.get(i).getId()+"")){//是这家医院
				    sh1 = shopHospitals.get(i);
				}
			}
		}
		//sql.append(" and order_id in (select order_id from shoporderdispatch where a_hospital like "+Database.cite("%"+hname+"%")+")");
		sql.append(" AND sod.a_hospital_id = "+sh1.getId());
		par.append("&hname="+h.enc(hname));
	}

	/*if(hname.length()>0){
	}else{
		//sql.append(" and order_id in(select order_id from shoporderdispatch where a_hospital_id in("+MT.f(hospitals2,"0")+"))");
		sql.append(" AND member="+h.member);
	}*/
	sql.append(" AND member="+h.member);

String orderId=h.get("orderId","");
if(orderId.length()>0)
{
  sql.append(" AND so.order_id LIKE "+Database.cite("%"+orderId+"%"));
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

int puid = h.getInt("puid",-1);
if(puid!=-1){
	sql.append(" AND puid = "+puid);
	  par.append("&puid="+puid);
}

String[] TAB={"未申请开票订单","已申请开票订单"};
//and isinvoicenum=(select quantity from shoporderdata where so.order_id=shoporderdata.order_id)
//AND puid <> "+Config.getInt("junan")+" or id in (select id from ShopOrder where puid = "+Config.getInt("junan")+" AND status in (3,4))
//String[] SQL={" and (isinvoicenum<(select quantity from shoporderdata where so.order_id=order_id and quantity>0) and noinvoicenum > 0 or isinvoicenum=0 and order_id in(select order_id from shoporderdata where quantity<0 )and noinvoicenum<0) "," and isinvoicenum=(select quantity from shoporderdata where so.order_id=order_id) "};
//String[] SQL={" and ( (isinvoicenum<(select quantity from shoporderdata where so.order_id=order_id and quantity>0)and noinvoicenum>0) or (isinvoicenum=0 and order_id in(select order_id from shoporderdata where quantity<0)and noinvoicenum<0)) and status not in(0,5,6) "," and isinvoicenum=(select quantity from shoporderdata where so.order_id=order_id) "};
String[] SQL={" and (( (isinvoicenum<(select quantity from shoporderdata where so.order_id=shoporderdata.order_id and quantity>0)and noinvoicenum>0) or (isinvoicenum=0 and so.order_id in(select order_id from shoporderdata where quantity<0)and noinvoicenum<0)) and so.status not in(0,5,6) and  puid <> "+Config.getInt("junan")+" or ( (isinvoicenum<(select quantity from shoporderdata where so.order_id=shoporderdata.order_id and quantity>0)and noinvoicenum>0) or (isinvoicenum=0 and so.order_id in(select order_id from shoporderdata where quantity<0)and noinvoicenum<0)) and so.status in (3,4,7) and  puid = "+Config.getInt("junan")+") "," and noinvoicenum=0 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

	int size = h.getInt("size",20);
	par.append("&size="+size);

int pos=h.getInt("pos");
par.append("&pos=");

sql.append(" AND (isclear=0 or isclear is null) ");

%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<%--<script src="/tea/new/js/jquery.min.js"></script>--%>
<%--<script src="/tea/new/js/superslide.2.1.js"></script>--%>
<script src="/tea/yl/mtDiag.js"></script>
<style>
	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(3){
		font-weight: bold;
	}
	.right-tab th,.right-tab td{padding:0px 3px;}
.mt_data td,.mt_data th{padding:3px}
	.con-left-list .tit-on1{color:#044694;}

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
<body style='min-height:800px'>

<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">

		<form name="form1" action="?">
			<input type="hidden" name="id" value="<%=menu%>"/>
			<input type="hidden" name="tab" value="<%=tab%>"/>
			<input type="hidden" name="size" value="<%= size%>"/>
			<div class="con-right-box">
				<div class="right-line1">
					<p>
						<span>医　　院：</span>
						<span style="width:335px;display: inline-block">
							<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style="width:252px;"/>
							<input id="hospitalsel" class="right-search" style="float:none;margin:0px;height:33px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,offset:'100px',area: ['60%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
							<%--<input type="button" value="清空医院" onclick="fnclearhname()"/>--%>
						</span>

						<span class="right-box-tit">订单编号：</span>
						<input type="text" name="orderId" class="right-box-inp" value="<%=orderId %>" />
					</p>
					<p>
						<span>开票单位：</span>
						<select name='puid' style="width:333px;"  class="right-box-yy">
							<option value=''>请选择</option>
							<option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
							<option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
							<option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
						</select>
					</p>
				</div>
				<input type="submit" class="right-search" value="查询">
			</div>


		</form>
		<p class="right-sqkp" style="margin-top:20px;">
			<span>请输入申请开票数量：</span>
			<input type="text" name="inputnum" id="inputnum" class="right-sq-inp">
			<input type="button" value="确认" class="right-sq-btn" id='invoicebutton1'>
			<span>或输入申请开票金额：</span>
			<input type="text" class="right-sq-inp" name="inputamount" id="inputamount">
			<input type="button" value="确认" class="right-sq-btn" id='invoicebutton2'>
			<span class="right-je" id="invoicetotal">开票总金额：<em></em></span>
			<span class="right-je" id="invoicenum">开票总数量：<em></em></span>
		</p>
		<div class="right-list">
			<%out.print("<ul class='right-list-zt'>");
				for(int i=0;i<TAB.length;i++)
				{
					out.print("<li><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"("+ShopOrder.count(sql.toString()+SQL[i])+")</a></li>");
				}
				out.print("</ul>");
			%>
			</div>
		<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
			<input type="hidden" name="orderId"/>
			<input type="hidden" name="status"/>
			<input type="hidden" name="cancelReason"/>
			<input type="hidden" name="tab" value="<%=tab%>"/>
			<input type="hidden" name="nexturl"/>
			<input type="hidden" name="act"/>
			<input type="hidden" name="size" value="<%= size%>"/>
			<div class="results">
				<table class="right-tab" border="1" cellspacing="0">
					<tr id="tableonetr">
						<%
							if(tab==0){
						%>
						<th class="td1" nowrap=""><label><input type="checkbox" id="all"/>全选</label></th>
						<%
							}
						%>
						<th class="td2" nowrap="">序号</th>
						<th class="td3">订单编号</th>
						<th class="td4">医院</th>
						<th class="td5">下单时间</th>
						<th class="td6">数量</th>
						<th class="td7">开票金额</th>
						<th class="td8">状态</th>
						<th class="td9">未开数量</th>
						<th class="td10">申请开票数量</th>
						<th class="td11">申请开票金额</th>
						<th class="td11">开票单位</th>
					</tr>
					<%
						sql.append(SQL[tab]);
						int sum=ShopOrder.count(sql.toString());
						if(sum<1)
						{
							out.print("<tr><td colspan='12' align='center'>暂无记录!</td></tr>");
						}else
						{
							System.out.println("sql====="+sql.toString());
							//Iterator it=ShopOrder.find(sql.toString()+" order by noinvoicenum asc,createDate asc ",pos,20).iterator();
							/*Iterator it=ShopOrder.find(sql.toString()+" order by SIGN(noinvoicenum) asc,createDate asc ",pos,size).iterator();*/
							Iterator it=ShopOrder.find(sql.toString()+" order by createDate desc,SIGN(noinvoicenum) asc",pos,size).iterator();

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
					<tr>
						<%
							if(tab==0){
						%>
						<td><input type="checkbox" name="issigns" value="<%=t.getId() %>"/></td>
						<%
							}
						%>
						<td><%=i %></td>
						<td><%=MT.f(t.getOrderId()) %></td>
						<td><%=MT.f(hospital) %></td>
						<td><%=MT.f(t.getCreateDate(),1) %></td>
						<td><%=num %></td>
						<td class="invoiceamount"><%=invoiceamount %></td>
						<td><%=statuscontent %></td>
						<td class="noinvoicenum"><%=noinvoicenum %></td>
						<td>
							<%
								if(tab==0){
							%>
							<input type="text" name="invoicenum" style="width:80px" class="form-control"/>
							<%
								}else{
									out.print(t.getIsinvoicenum());
								}
							%>
						</td>
						<td>
							<%
								if(tab==1){
									out.print(t.getIsinvoiceamount());
								}
							%>
						</td>
						<td><%= ProcurementUnit.findName(t.getPuid()) %></td>
					</tr>
					<%
							}
							if(sum>20)out.print("<tr class='fenye'><td colspan='12' align='right' id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size)+"<select class='mysize' name='mysize' style='padding: 0 20px 0 0; margin-left: 8px;'><option value=\"10\" selected=\"\">10 条/页</option><option value=\"20\">20 条/页</option><option value=\"30\">30 条/页</option><option value=\"40\">40 条/页</option><option value=\"50\">50 条/页</option><option value=\"60\">60 条/页</option><option value=\"70\">70 条/页</option><option value=\"80\">80 条/页</option><option value=\"90\">90 条/页</option></select></div></td></tr>");
						}%>
				</table>
			</div>
			<%
				Profile pro = Profile.find(h.member);
//if(pro.getMembertype() == 2&&tab==0)
				{
					sql.append(" AND isLzCategory=1");
					sql.append(" order by createDate desc");
			%>
			<!-- <div class='center mt15 mtotal'>
                <span id="invoicetotal">开票总金额：</span>&nbsp;<span id="invoicenum">开票总数量：</span>
            </div> -->
			<div class='center text-c pd20'>
				<button class="btn btn-primary btn-blue"  type="button" id="getinvoice" onclick="fnconfirm()" >索要发票</button>
			</div>
			<%} %>
		</form>
		<form action="/ShopOrders.do" name="form3"  method="post" target="_ajax" >
			<input name="act" value="exp_sh" type="hidden" />
			<input name="exflag" value="0" type="hidden"/>
			<input type='hidden' name='category' value="14102669">
			<input type='hidden' name="sql" value="<%= sql.toString() %>" />
		</form>
	</div>
</div>



<script>
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
		$("#inputamount").removeAttr('disabled');
		
		$("#invoicebutton1").removeAttr('disabled');
		$("#invoicebutton2").removeAttr('disabled');
	}else{
		//$('#getinvoice').removeAttr("disabled"); 
		//禁用输入开票数量和开票金额的文本框
		$("#inputnum").attr('disabled',"true");
		$("#inputamount").attr('disabled',"true");
		$("#invoicebutton1").attr('disabled',"true");
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
			var num=$(this).parent().parent().find("td").eq(8).html();//未开票数量
			$(this).parent().parent().find("input[name='invoicenum']").val(num);//赋值
			//求单价
			var num2=$(this).parent().parent().find("td").eq(5).html();
			var amount=$(this).parent().parent().find("td").eq(6).html();
			var dan=parseInt(amount)/parseInt(num2);
			//$(this).parent().parent().find("td:last").html(dan*parseInt(num));
			$(this).parent().parent().find("td").eq(10).html(dan*parseInt(num));
		}else{
			$(this).parent().parent().find("input[name='invoicenum']").val("");//赋值
			//$(this).parent().parent().find("td:last").html("");
			$(this).parent().parent().find("td").eq(10).html("");
		}
		getTotal();


	});
	//输入开票数量
	$("input[name='invoicenum']").keyup(function(){
		var wnum=parseInt($(this).parent().parent().find("td").eq(8).html());//未开票数量
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
			$(this).parent().next().html("");
			return;
		}
		if(parseInt(num)<0&&Math.abs(parseInt(num))>Math.abs(wnum)){
			mt.show("请输入正确的开票数量！");
			$(this).focus();
			$(this).parent().next().html("");
			return;
		}
		if(parseInt(num)==0){
			mt.show("请输入正确的开票数量！");
			$(this).select();
			$(this).parent().next().html("");
			return;
		}
		if(num!=''){
			var num2=parseInt($(this).parent().prev().prev().prev().prev().html());
			
			
			var invoiceamount=parseFloat($(this).parent().prev().prev().prev().html());
			
			$(this).parent().next().html(parseFloat(invoiceamount/num2*num));
			
			$(this).parent().parent().find("input:checkbox").prop("checked",true);
		}else{
			$(this).parent().next().html("");
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
			var num=parseInt($(this).parent().parent().find("td").eq(9).children().val());
			
			totalnum+=num;
			//var amount=parseInt($(this).parent().parent().find("td:last").html());
			var amount=parseInt($(this).parent().parent().find("td").eq(10).html());
			totalamount+=amount;
		})
		$("#invoicetotal").html("开票总金额：<em id='invoval'>"+totalamount+"</em>元");
		$("#invoicenum").html("开票总数量：<em id='numval'>"+totalnum+"</em>粒");
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

	$(":checkbox[name='issigns']:checked").each(function(){

		$(this).click();
	})

	var v=parseInt($("#inputnum").val());

	if(v>0){
		var tnum=0;
		var i=0;
		$("input[name='issigns']").each(function(){
			var num=parseInt($(this).parent().parent().find("td").eq(8).html());
			tnum+=num;
			i+=1;
			if(tnum>=v){
				for(var a=0;a<i;a++){

					if($("input[name='issigns']").eq(a).is(':checked')==false){
						$("input[name='issigns']").eq(a).click();
					}


				}
				return false;
			}
		})
		if(v>tnum){
			mt.show("输入的开票数量大于当前页面的总数量！");
			$(":checkbox[name='issigns']:checked").each(function(){
				$(this).click();
			})
			return false;
		}
		//获取选中的总粒数
		var tnum2=0;
		var j=0;//计数
		$("input[name='issigns']:checked").each(function(){
			j+=1;
			var tempnum=parseInt($(this).parent().parent().find("td").eq(9).children().val());
			console.log($(this).parent().parent().find(".noinvoicenum").html()+"======");
			tnum2+=tempnum;

		})
		var cha=0;
		if(tnum2>v){
			var cha=tnum2-v;

		}
		var nowval=parseInt($("input[name='issigns']").eq(j-1).parent().parent().find("td").eq(9).children().val());
		var nowval2=nowval-parseInt(cha);
		//赋新的开票数量
		$("input[name='issigns']").eq(j-1).parent().parent().find("td").eq(9).children().val(nowval2);
		//重新计算申请开票金额
		var kainum=parseInt($("input[name='issigns']").eq(j-1).parent().parent().find("td").eq(5).html());//开票数量
		var kaiamount=parseFloat($("input[name='issigns']").eq(j-1).parent().parent().find("td").eq(6).html());//开票金额
		var kaidan=parseFloat(kaiamount/kainum);
		//赋新的开票金额
		$("input[name='issigns']").eq(j-1).parent().parent().find("td").eq(10).html(nowval2*kaidan);
		getTotal();
	}else{
		mt.show("请输入正确的开票数量！");
		$(":checkbox[name='issigns']:checked").each(function(){
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
			$(":checkbox[name='issigns']:checked").each(function(){
				$(this).click();
			})
			var v=parseFloat($("#inputamount").val());
			
			if(v>0){
				var tamount=0;
				var i=0;
				
				$("input[name='issigns']").each(function(){
					//计算申请开票金额
					var amount=parseFloat($(this).parent().parent().find("td").eq(6).html());
					var num=parseFloat($(this).parent().parent().find("td").eq(5).html());
					var dan=parseFloat(amount/num);//单价
					var weinum=parseFloat($(this).parent().parent().find("td").eq(8).html());//未开数量
					var shen=parseFloat(dan*weinum);//应开票金额
					
					
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
					var amount=parseFloat($(this).parent().parent().find("td").eq(6).html());//开票金额
					var num=parseInt($(this).parent().parent().find("td").eq(5).html());//开票数量
					var dan=parseFloat(amount/num);//单价
					var weinum=parseFloat($(this).parent().parent().find("td").eq(8).html());//未开数量
					tempamount+=parseFloat(weinum*dan);
					//alert(tempamount);
				})
				var lastamount=parseFloat($("input[name='issigns']:checked").eq(i-1).parent().parent().find("td").eq(6).html());
				var lastnum=parseInt($("input[name='issigns']:checked").eq(i-1).parent().parent().find("td").eq(5).html());
				var lastdan=parseFloat(lastamount/lastnum);
				if(i>1){
					var cha=parseFloat(tempamount-v);
					//计算最后一个选中的单价
					var yushu=cha%lastdan;
					
					if(cha!=0&&yushu==0){
						var weinum=parseFloat($("input[name='issigns']:checked").eq(i-1).parent().parent().find("td").eq(8).html());
						var weiamount=weinum*lastdan;
						//alert(lastamount)
						var newamount=parseFloat(weiamount-cha);
						
						var newnum=parseInt(newamount/lastdan);
						$("input[name='issigns']:checked").eq(i-1).parent().parent().find("input[name='invoicenum']").val(newnum);
						$("input[name='issigns']:checked").eq(i-1).parent().parent().find("td").eq(10).html(newamount);
					}else if(cha!=0&&yushu!=0){
						mt.show("请输入正确的开票金额（开票单价的整数倍）！");
						$(":checkbox[name='issigns']:checked").each(function(){
							$(this).click();
						})
						return;
					}
				}else if(i==1){
					var yushu=v%lastdan;
					if(yushu==0){
						var newnum=v/lastdan;
						
						$("input[name='issigns']:checked").eq(i-1).parent().parent().find("input[name='invoicenum']").val(newnum);
						
						$("input[name='issigns']:checked").eq(i-1).parent().parent().find("td").eq(10).html(v);
					}else{
						mt.show("请输入正确的开票金额（开票单价的整数倍）！");
						$(":checkbox[name='issigns']:checked").each(function(){
							$(this).click();
						})
						return;
					}
				}
				
				/* if(cha!=0){
					mt.show("请输入正确的开票金额！");
					$(":checkbox:checked").each(function(){
						$(this).click();
					})
					return;
				}  */
				getTotal();
			}else{
				mt.show("请输入正确的开票金额");
				$(":checkbox[name='issigns']:checked").each(function(){
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
		var puname='';
		var a=0;
		
		$("input[name='issigns']:checked").each(function(){
			i+=1;


			if(i==1){
				hospital=$(this).parent().parent().find("td").eq(3).html();
				puname = $(this).parent().parent().find("td").eq(11).html()
				
			}
			var hospital2=$(this).parent().parent().find("td").eq(3).html();
			var puname2=$(this).parent().parent().find("td").eq(11).html();
			
			if(hospital2!=hospital){

				mt.show("请选择同一医院申请开票！");
				a=1;
				return false;

			}
			if(puname2!=puname){

				mt.show("请选择同一开票单位申请开票！");
				a=1;
				return false;

			}

		});

		var ids='';//id
		var nums='';//开票数量
		var amounts='';//开票金额
		$("input[name='issigns']:checked").each(function(){

			ids+=$(this).val()+",";
			nums+=$(this).parent().parent().find("td").eq(9).children().val()+",";
			amounts+=$(this).parent().parent().find("td").eq(10).html()+",";

		});
		mt.send("/mobjsp/yl/shop/ajax.jsp?act=checkInvoice&ids="+ids+"&nums="+nums+"&hospital="+hospital,function(d)
		{
            var d = eval('(' + d + ')');
            if(d.type==0){
                if(a==0){

                    //mt.show('/jsp/yl/shopwebnew/AskInvoiceConfirm.jsp?ids='+ids+'&nums='+nums+'&amounts='+amounts,2,'新增收货人地址',800,600);


                    var aa='/jsp/yl/shopwebnew/AskInvoiceConfirm.jsp';
                    //var aa='/html/folder/17100788-1.htm'(测试);
                    //location.href='/html/folder/17100788-1.htm?ids='+ids+'&nums='+nums+'&amounts='+amounts+'&hospital='+hospital+'&nexturl='+location.pathname+location.search;
                    var invoval=$("#invoval").html();
                    var numval=$("#numval").html();

                    if(parseInt(invoval)<0||parseInt(numval)<0){
                        mt.show("开票数量或开票金额不能为负！");
                        return;
                    }
					if(parseInt(invoval)==0||parseInt(numval)==0){
						mt.show("开票数量或开票金额不能为0！");
						return;
					}
                    location.href=aa+'?ids='+ids+'&nums='+nums+'&amounts='+amounts+'&hospital='+hospital+'&nexturl='+location.pathname+location.search+'&invoval='+invoval+'&numval='+numval;
                }
            }else{
                mt.show(d.mes);
                return;
            }
		});



	}
	//清空医院
	function fnclearhname(){
		var hname=$("#hname");
		hname.val("");
	}
mt.fit();

$(function(){
	$(".mysize").change(function(){
		//console.log($(this).val());
		form1.size.value = $(this).val();
		form1.submit();
	});
	$(".mysize").val(form2.size.value);
});
</script>
</body>
</html>
