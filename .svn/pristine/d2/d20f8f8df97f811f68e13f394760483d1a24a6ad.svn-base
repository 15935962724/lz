<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.yl.shopnew.*"%>
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
	String hname=h.get("hname","");
	if(hname.length()>0){
		ShopHospital sh1 = ShopHospital.find(hname);
		//sql.append(" and order_id in (select order_id from shoporderdispatch where a_hospital like "+Database.cite("%"+hname+"%")+")");
		ArrayList<ShopHospital> shopHospitals = ShopHospital.find(" AND name=" + Database.cite(hname), 0, Integer.MAX_VALUE);
		if(shopHospitals.size()>0) {//重名了
			String hospitalstr = p.hospitals;
			for (int i = 0; i <shopHospitals.size() ; i++) {
				if(hospitalstr.contains(shopHospitals.get(i).getId()+"")){//是这家医院
					sh1 = shopHospitals.get(i);
				}
			}
		}
		sql.append(" AND sod.a_hospital_id = "+sh1.getId());
		par.append("&hname="+h.enc(hname));
	}




String hospitals=p.hospitals;

if(p.membertype==2){

	sql.append(" AND applyUnit = 0 ");
}else{
	ShopQualification sq = ShopQualification.findByMember(p.profile);
	sql.append(" AND (applyUnit = "+sq.hospital_id+" or member = "+h.member+")");
}
/*if(hname.length()>0){
}else{
	//sql.append(" and order_id in(select order_id from shoporderdispatch where a_hospital_id in("+hospitals2+"))");
	sql.append(" AND member="+h.member);
}*/
	sql.append(" AND member="+h.member);
//查询当前服务商下的医院结束
/* sql.append(" AND member="+h.member);
par.append("&member="+h.member);  */
/* sql.append(" AND invoicestatus = 0 ");
par.append("&invoicestatus=0"); */
//按医院查询


	
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
//AND puid <> "+Config.getInt("junan")+" or so.id in (select id from ShopOrder where puid = "+Config.getInt("junan")+" AND status in (3,4))
//String[] SQL={" and (isinvoicenum<(select quantity from shoporderdata where so.order_id=order_id and quantity>0) and noinvoicenum > 0 or isinvoicenum=0 and order_id in(select order_id from shoporderdata where quantity<0 )and noinvoicenum<0) "," and isinvoicenum=(select quantity from shoporderdata where so.order_id=order_id) "};
String[] SQL={" and (( (isinvoicenum<(select quantity from shoporderdata where so.order_id=shoporderdata.order_id and quantity>0)and noinvoicenum>0) or (isinvoicenum=0 and so.order_id in(select order_id from shoporderdata where quantity<0)and noinvoicenum<0)) and so.status not in(0,5,6) and  puid <> "+Config.getInt("junan")+" or ( (isinvoicenum<(select quantity from shoporderdata where so.order_id=shoporderdata.order_id and quantity>0)and noinvoicenum>0) or (isinvoicenum=0 and so.order_id in(select order_id from shoporderdata where quantity<0)and noinvoicenum<0)) and so.status in (3,4,7) and  puid = "+Config.getInt("junan")+") "," and noinvoicenum=0 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);


int size = h.getInt("size",10);
par.append("&size="+size);

int pos=h.getInt("pos");
par.append("&pos=");

sql.append(" AND (isclear=0 or isclear is null) ");


%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=0">
<title>发票管理</title>
</head>
<body style=''>

<div class="body body-bot">
	<div class="order-sea">
		<form name="form1" action="?">
			<input type="hidden" name="id" value="<%=menu%>"/>
			<input type="hidden" name="tab" value="<%=tab%>"/>
			<input type="hidden" name="size" value="<%= size%>"/>

		<div class="order-sea-left fl-left">
			<p style="position:relative;">
				<span class="ft14 order-l-span">医院：</span>
				<select name="hname"  class="right-box-yy">
					<option value="">请选择</option>
					<%
						String name="";
						p=Profile.find(h.member);
						String hospitals1=p.hospitals;
						List<String> lst=new ArrayList<String>();
						if(hospitals1!=null) {
							String[] hospitalarr = hospitals1.split("\\|");
							for(int i=1;i<hospitalarr.length;i++){
								String hospital=hospitalarr[i];
								ShopHospital sh=ShopHospital.find(Integer.parseInt(hospital));
								if(sh.getName()!=null) {
									if (name.length() > 0) {
										if (sh.getName().indexOf(name) > -1) {
											lst.add(sh.getName());
										}
									} else {
										lst.add(sh.getName());
									}
								}


							}
						}
						for (int i = 0; i < lst.size(); i++) {
							String s = lst.get(i);
							%>
					<option value="<%=s%>"><%=s%></option>
						<%}
					%>
				</select>
				<%--<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style=""/>--%>
				<%--<input id="hospitalsel" class="btn btn-link" style="position:absolute;width:auto;right:-70px;color:#044694;border:none;background:none;top:0px;height:33px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,area: ['98%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>--%>
			</p>
			<p>
				<span class="ft14 order-l-span">订单编号：</span>
				<input type="text" name="orderId" class="right-box-inp" value="<%=orderId %>" />
			</p>
			<p>
				<span class="ft14 order-l-span">开票单位：</span>
				<select name='puid' style=""  class="right-box-yy">
					<option value=''>请选择</option>
					<option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
					<option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
					<option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
				</select>
			</p>
		</div>
		<input type="submit" class="fl-right order-cxb order-cxb3 ft14" style="margin-top:60px;" value="查询">
		</form>
	</div>
	<div class="order-list" style="margin-top:10px;margin-bottom:0px;">
		<p class="inv-inp ft14">
			<span>申请开票总数：</span>
			<input class="inv-bor" name="inputnum" id="inputnum" type="text" placeholder="请输入申请开票数量">
			<span class="inv-qd inv-qd1 fl-right"  id='invoicebutton1'>确定</span>
		</p>
		<p class="inv-inp ft14">
			<span>申请开票总额：</span>
			<input class="inv-bor" type="text"  placeholder="请输入申请开票金额" name="inputamount" id="inputamount">
			<span class="inv-qd inv-qd2 fl-right" id='invoicebutton2'>确定</span>

		</p>
		<span class="right-je" id="invoicetotal" style="display:none;">开票总金额：<em></em></span>
		<span class="right-je" id="invoicenum" style="display:none;">开票总数量：<em></em></span>
	</div>
	<div class="order-lx order-lx4">
		<%out.print("<ul>");
			for(int i=0;i<TAB.length;i++)
			{
				out.print("<li class='ft14 fl-left "+(i==tab?"on":"")+"'><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"("+ShopOrder.count(sql.toString()+SQL[i])+")</a></li>");
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


				<%
					sql.append(SQL[tab]);
					System.out.println("==="+sql.toString());
					int sum=ShopOrder.count(sql.toString());
					if(sum<1)
					{
						out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
					}else
					{
						//Iterator it=ShopOrder.find(sql.toString()+" order by noinvoicenum asc,createDate asc ",pos,20).iterator();
						Iterator it=ShopOrder.find(sql.toString()+" order by createDate desc,SIGN(noinvoicenum) asc",pos,size).iterator();

						for(int i=1+pos;it.hasNext();i++)
						{
							ShopOrder t=(ShopOrder)it.next();
							ShopOrderDispatch dispatch=ShopOrderDispatch.findByOrderId(t.getOrderId());
							String hospital="";//医院
							System.out.println();
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
				<div class="order-list">
					<p class="order-line1 ft14 inv-p">
                        <%
                        if(tab==0){
                        %>
						<input type="checkbox" class="inv-che fl-left" name="issigns" value="<%=t.getId() %>"/>
                        <%}%>
						<span class="fl-left inv-tit order-tit"><%=MT.f(hospital) %></span>
						<span class="fl-right order-zt"><%=statuscontent %></span>
					</p>
					<ul class="ft14">
						<li>
							<span class="list-spanr3 fl-left">订单编号：</span>
							<span class="list-spanr fl-left"><%=MT.f(t.getOrderId()) %></span>
						</li>
						<li>
							<span class="list-spanr3 fl-left">开票单位：</span>
							<span class="list-spanr fl-left"><%= ProcurementUnit.findName(t.getPuid()) %></span>
						</li>
						<li>
							<span class="list-spanr3 fl-left">下单时间：</span>
							<span class="list-spanr fl-left" ><%=MT.f(t.getCreateDate(),1) %></span>
						</li>
						<li>
							<span class="list-spanr3 fl-left">数量：</span>
							<span class="list-spanr fl-left"><%=num %></span>
						</li>
						<li>
							<span class="list-spanr3 fl-left">未开数量：</span>
							<span class="list-spanr fl-left"><%=noinvoicenum %></span>
						</li>
						<li>
							<span class="list-spanr3 fl-left">开票金额：</span>
							<span class="list-spanr fl-left">
								<%=invoiceamount %>
							</span>
						</li>
					</ul>
					<div class="order-btnt">
						<p class="fl-left">
							<span class="ft14">申请开票数量：</span>
							<%
								if(tab==0){
							%>
							<input type="text" name="invoicenum" style="" class="form-control"/>
							<%
								}else{
									out.print(t.getIsinvoicenum());
								}
							%>
						</p>
						<p class="fl-left">
							<span class="ft14">申请开票金额：</span>
							<em style="font-style: normal;">
							<%
								if(tab==1){
									out.print(t.getIsinvoiceamount());
								}
							%>
							</em>
						</p>

					</div>
				</div>

				<%
						}
						if(sum>size){
							out.print("<div id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size)+"<select class='mysize' name='mysize' style='padding: 0 20px 0 0; margin-left: 8px;'><option value=\"10\" selected=\"\">10 条/页</option><option value=\"20\">20 条/页</option><option value=\"30\">30 条/页</option><option value=\"40\">40 条/页</option><option value=\"50\">50 条/页</option><option value=\"60\">60 条/页</option><option value=\"70\">70 条/页</option><option value=\"80\">80 条/页</option><option value=\"90\">90 条/页</option></select></div>");
						}
					}%>


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
		<div>
			<input type="button" value="索要发票" class="inv-f-btn ft16" onclick="fnconfirm()">
		</div>
		<%} %>
	</form>






</div>




</body>
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
	/*mt.receive=function(v){
		document.getElementById("hname").value=v;
	}*/

	function receive(v) {
        document.getElementById("hname").value=v;
    }


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
			//var num=$(this).parent().parent().find("td").eq(8).html();//未开票数量
			var num=$(this).parent(".inv-p").next("ul").children("li").eq(4).children(".list-spanr").html();//未开票数量
			$(this).parent().parent().find(".order-btnt input[name='invoicenum']").val(num);//赋值
			//求单价
			var num2=$(this).parent(".inv-p").next("ul").children("li").eq(3).children(".list-spanr").html();
			var amount=$(this).parent(".inv-p").next("ul").children("li").eq(5).children(".list-spanr").html();
			var dan=parseInt(amount)/parseInt(num2);
			//$(this).parent().parent().find("td:last").html(dan*parseInt(num));
			$(this).parent().parent().find(".order-btnt p").eq(1).html("<span class=\"ft14\">申请开票金额：</span><em>"+dan*parseInt(num)+"</em>");
		}else{
			$(this).parent().parent().find(".order-btnt input[name='invoicenum']").val("");//赋值
			//$(this).parent().parent().find("td:last").html("");
			$(this).parent().parent().find(".order-btnt p").eq(1).html("");
		}
		getTotal();


	});
	//输入开票数量
	$("input[name='invoicenum']").keyup(function(){
		var wnum=parseInt($(this).parents(".order-btnt").prev("ul").children("li").eq(4).children(".list-spanr").html());//未开票数量
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
			$(this).parent().next().html("<span class=\"ft14\">申请开票金额：</span>");
			return;
		}
		if(parseInt(num)<0&&Math.abs(parseInt(num))>Math.abs(wnum)){
			mt.show("请输入正确的开票数量！");
			$(this).focus();
			$(this).parent().next().html("<span class=\"ft14\">申请开票金额：</span>");
			return;
		}
		if(parseInt(num)==0){
			mt.show("请输入正确的开票数量！");
			$(this).select();
			$(this).parent().next().html("<span class=\"ft14\">申请开票金额：</span>");
			return;
		}
		if(num!=''){
			var num2=parseInt($(this).parents(".order-btnt").prev("ul").children("li").eq(3).children(".list-spanr").html());


			var invoiceamount=parseFloat($(this).parents(".order-btnt").prev("ul").children("li").eq(5).children(".list-spanr").html());

			$(this).parent().next().html("<span class=\"ft14\">申请开票金额：</span><em>"+parseFloat(invoiceamount/num2*num)+"</em>");

			$(this).parents(".order-list").find("input:checkbox").prop("checked",true);
		}else{
			$(this).parent().next().html("<span class=\"ft14\">申请开票金额：</span>");
			$(this).parents(".order-list").find("input:checkbox").prop("checked",false);
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
			var num=parseInt($(this).parents(".order-list").find(".order-btnt").children("p").eq(0).children("input[name='invoicenum']").val());
			totalnum+=num;
			//var amount=parseInt($(this).parent().parent().find("td:last").html());
			var amount=parseInt($(this).parents(".order-list").find(".order-btnt").children("p").eq(1).children("em").html());
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
				//var num=parseInt($(this).parent().parent().find("td").eq(8).html());
				var num=parseFloat($(this).parent(".inv-p").next("ul").children("li").eq(4).children(".list-spanr").html());
				console.log("=="+num);
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
				var tempnum=parseInt($(this).parents(".order-list").find(".order-btnt").children("p").eq(0).children("input[name='invoicenum']").val());
				tnum2+=tempnum;

			})
			var cha=0;
			if(tnum2>v){
				var cha=tnum2-v;

			}
			var nowval= $("input[name='issigns']").eq(j-1).parents(".order-list").find(".order-btnt").children("p").eq(0).children("input[name='invoicenum']").val();
			var nowval2=nowval-parseInt(cha);
			//赋新的开票数量
			$("input[name='issigns']").eq(j-1).parents(".order-list").find(".order-btnt").children("p").eq(0).children("input[name='invoicenum']").val(nowval2);
			//重新计算申请开票金额
			var kainum=parseInt($("input[name='issigns']").eq(j-1).parent(".inv-p").next("ul").children("li").eq(3).children(".list-spanr").html());//开票数量
			var kaiamount=parseFloat($("input[name='issigns']").eq(j-1).parent(".inv-p").next("ul").children("li").eq(5).children(".list-spanr").html());//开票金额
			var kaidan=parseFloat(kaiamount/kainum);
			//赋新的开票金额
			$("input[name='issigns']").eq(j-1).parents(".order-list").find(".order-btnt").children("p").eq(1).children("em").html(nowval2*kaidan);
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
				var amount=parseFloat($(this).parent(".inv-p").next("ul").children("li").eq(5).children(".list-spanr").html());
				var num=parseFloat($(this).parent(".inv-p").next("ul").children("li").eq(3).children(".list-spanr").html());
				var dan=parseFloat(amount/num);//单价
				var weinum=parseFloat($(this).parent(".inv-p").next("ul").children("li").eq(4).children(".list-spanr").html());//未开数量
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
				var amount=parseFloat($(this).parent(".inv-p").next("ul").children("li").eq(5).children(".list-spanr").html());//开票金额
				var num=parseInt($(this).parent(".inv-p").next("ul").children("li").eq(3).children(".list-spanr").html());//开票数量
				var dan=parseFloat(amount/num);//单价
				var weinum=parseFloat($(this).parent(".inv-p").next("ul").children("li").eq(4).children(".list-spanr").html());//未开数量
				tempamount+=parseFloat(weinum*dan);
				//alert(tempamount);
			})
			var lastamount=parseFloat($("input[name='issigns']:checked").eq(i-1).parent(".inv-p").next("ul").children("li").eq(5).children(".list-spanr").html());
			var lastnum=parseInt($("input[name='issigns']:checked").eq(i-1).parent(".inv-p").next("ul").children("li").eq(3).children(".list-spanr").html());
			var lastdan=parseFloat(lastamount/lastnum);
			if(i>1){
				var cha=parseFloat(tempamount-v);
				//计算最后一个选中的单价
				var yushu=cha%lastdan;
				if(cha!=0&&yushu==0){
					var weinum=parseFloat($("input[name='issigns']:checked").eq(i-1).parent(".inv-p").next("ul").children("li").eq(4).children(".list-spanr").html());
					var weiamount=weinum*lastdan;
					//alert(lastamount)
					var newamount=parseFloat(weiamount-cha);

					var newnum=parseInt(newamount/lastdan);
					$("input[name='issigns']:checked").eq(i-1).parents(".order-list").find(".order-btnt").children("p").eq(0).children("input[name='invoicenum']").val(newnum);
					$("input[name='issigns']:checked").eq(i-1).parents(".order-list").find(".order-btnt").children("p").eq(1).children("em").html(newamount);
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
					$("input[name='issigns']:checked").eq(i-1).parents(".order-list").find(".order-btnt").children("p").eq(0).children("input[name='invoicenum']").val(newnum);

					$("input[name='issigns']:checked").eq(i-1).parents(".order-list").find(".order-btnt").children("p").eq(1).children("em").html(v);
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
				hospital=$(this).next(".order-tit").html();
				puname = $(this).parent(".inv-p").next("ul").children("li").eq(1).children(".list-spanr").html();

			}
			var hospital2=$(this).next(".order-tit").html();
			var puname2=$(this).parent(".inv-p").next("ul").children("li").eq(1).children(".list-spanr").html();

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
		if(a==0){

			var ids='';//id
			var nums='';//开票数量
			var amounts='';//开票金额
			$("input[name='issigns']:checked").each(function(){

				ids+=$(this).val()+",";
				nums+=$(this).parents(".order-list").find(".order-btnt").children("p").eq(0).children("input[name='invoicenum']").val()+",";
				amounts+=$(this).parents(".order-list").find(".order-btnt").children("p").eq(1).children("em").html()+",";

			});
			//mt.show('/jsp/yl/shopwebnew/AskInvoiceConfirm.jsp?ids='+ids+'&nums='+nums+'&amounts='+amounts,2,'新增收货人地址',800,600);



			//var aa='/jsp/yl/shopwebnew/AskInvoiceConfirm.jsp';
			mt.send("/mobjsp/yl/shop/ajax.jsp?act=checkInvoice&ids="+ids+"&nums="+nums+"&hospital="+hospital,function(d)
			{
				var d = eval('(' + d + ')');
				if(d.type==0){
					if(a==0){

						var aa='/mobjsp/yl/shopwebnew/AskInvoiceConfirm_wx.jsp';
						//var aa='/html/folder/17100788-1.htm'(测试);
						//location.href='/html/folder/17100788-1.htm?ids='+ids+'&nums='+nums+'&amounts='+amounts+'&hospital='+hospital+'&nexturl='+location.pathname+location.search;
						var invoval=$("#invoval").html();
						var numval=$("#numval").html();

						if(parseInt(invoval)<0||parseInt(numval)<0){
							mt.show("开票数量或开票金额不能为负！");
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
</html>
