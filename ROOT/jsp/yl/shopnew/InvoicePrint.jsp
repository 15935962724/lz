<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.yl.shopnew.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.AdminUsrRole"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int invoiceid = h.getInt("invoiceid");
//根据发票id查询发票信息
Invoice invoice = Invoice.find(invoiceid);
List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid = "+invoice.getId(), 0, Integer.MAX_VALUE);


String nexturl = h.get("nexturl");
//上海管理员  14122306
//AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);

//粒子签收 二维码
Map<String,String> map = new HashMap<String,String>();
map.put("act", "lzsign_invoice");
map.put("invoiceid",String.valueOf(invoice.getId()));
String param = JSON.toJSON(map).toString();
String CODE_URL = "http://www.brachysolution.com/ScanQRCodeInvoice?"+MT.enc(param);

	ProcurementUnit pu1 = ProcurementUnit.find(invoice.getPuid());

%><!DOCTYPE html>
<html>
<head>
	<link href="/jsp/yl/shop/print_css.css" rel="stylesheet" type="text/css" />
	
	<script src="/tea/mt.js" type="text/javascript"></script>
	<script src="/tea/jquery-1.4.2.min.js" type="text/javascript"></script>
	<script src="/tea/jquery.jqprint-0.3.js" type="text/javascript"></script>
</head>
<style>
.tabline{table-layout: fixed;width:99%;}
.tabline th,.tabline td{word-wrap:break-word;text-align: center;}
</style>
<body>
	<div id="_printInfo" style="width: 951px;margin: 0 auto;">
		<div class="tits"><h2><%= pu1.getName()%>-医疗粒子</h2>
			<div class="h3">随行单</div>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>收货单位:<%=MT.f(invoice.getHospital()) %></td>
				
				<td>单位：人民币（元）</td>
			</tr>
		</table>
		<table  border="0" cellspacing="0" cellpadding="0" class='tabline'>
			<tr>
				<th>发票号</th>
				<th>商品名称</th>
				<th>受订活度</th>
				<th>生产厂家</th>
				<th>注册证号</th>
				<th>产品批号</th>
				<th>订单编号</th>
				<th>生产日期</th>
				<th>有效期</th>
				<th>发货日期</th>
				<th>订单数量</th>
				<th>开票数量</th>
				<th>单位</th>
				<th>单价</th>
				<th>总金额</th>
			</tr>
		<%
			for(int i=0;i<lstdata.size();i++){
				InvoiceData data=lstdata.get(i);
				String orderid=data.getOrderid();
				List<ShopOrderData> lstorderdata=ShopOrderData.find(" and order_id = "+Database.cite(orderid), 0, Integer.MAX_VALUE);
				
				String name="";//商品名称
				double model=0;//规格
				String factory="";//生产厂家
				String pihao="";//产品批号
				String scdate="";//生产日期
				Date vtime=new Date();//有效期
				int num=0;//数量
				float price=0;//单价
				float total=0;//总金额
				Date fatime=new Date();//发件日期
				if(lstorderdata.size()>0){
					ShopOrderData orderdata=lstorderdata.get(0);
					int productid=orderdata.getProductId();
					ShopProduct sp=ShopProduct.find(productid);
					name=sp.name[1];
					model=orderdata.getActivity();
					factory=sp.factory;
					num=orderdata.getQuantity();
					price=orderdata.getAgent_price();
					total=orderdata.getAgent_amount();
				}
				ShopOrderExpress soe=ShopOrderExpress.findByOrderId(orderid);
				pihao=soe.NO2;
				if(MT.f(soe.NO2)!=""){
					String d=soe.NO2.substring(2);
					String d1=d.substring(0, 2);
					String d2=d.substring(2, 4);
					String d3=d.substring(4);
					scdate="20"+d1+"-"+d2+"-"+d3;
				}
				vtime=soe.vtime;
				fatime=soe.time;
				
		%>
			<tr>
				<td><%=MT.f(invoice.getInvoiceno()) %></td>
				<td><%=name %></td>
				<td><%=model %>mCi</td>
				<td><%=factory %></td>
				<td>国药准字H20041695</td>
				<td><%=MT.f(pihao) %></td>
				<td><%=MT.f(data.getOrderid()) %></td>
				<td><%=scdate %></td>
				<td><%=MT.f(vtime) %></td>
				<td><%=MT.f(fatime) %></td>
				<td><%=num %></td>
				<td><%=data.getNum() %></td>
				<td>粒</td>
				<td><%=price %></td>
				<td><%=total %></td>
			</tr>
		<%
			}
		%>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="15" style="height:100px;">
					<div  class='borderlineleft' style="float:left;width:30%">
						<div>出库单位：<%= pu1.getName()%>（盖章）</div>
						
					</div>
				
					<div class='borderlineright' style="float:left;width:20%">
						
					</div>
					<div class='borderlineright' style="float:right;width:30%">
						<div>收货日期：&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</div>
					</div>
				</td>
			</tr>
		</table>
		<!-- <div class='borderline' style="min-height:140px">
			<div  class='borderlineleft' style="float:left;width:30%">
				<div>出库单位：中国同辐股份有限公司（盖章）</div>
				
			</div>
		
			<div class='borderlineright' style="float:left;width:20%">
				
			</div>
			<div class='borderlineright' style="float:right;width:30%">
				<div>收货日期：&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</div>
			</div>
		</div> -->
		<table><tr>
			<td style="vertical-align:top;padding:15px 15px" width='70%' class='texts'>
				
				<p><strong>签收方式：</strong></p>
				<p class='indent'>通过微信扫一扫，扫描右侧二维码，快速确认收货。</p>
			</td>
			<td width='30%' style='padding:20px 35px'><img id="order_code" src="/CodeServletInvoice?text=<%=CODE_URL%>" width='100%'/></td>
		</tr></table>
 	</div>
 	<div class='center mt15'>
	    <button class="btn btn-primary" type="button" onclick="printit()">打印</button>
	    <button class="btn btn-default" type="button" onclick="history.back();">返回</button>
    </div>

    <script type="text/javascript">
    
		<%-- window.onload=function(){ 
			//alert("初始化加载"); 
			mt.send("/WeiXins.do?act=lzcode&orderid=<%=so.getOrderId()%>",function(data){
				//alert(data);
				document.getElementById("order_code").src = data.trim();
			})
		}; --%> 
		
		function printit(){
			$("#_printInfo").jqprint();
		}
	
	</script>
	
	<script>
		mt.fit();
	</script>
</body>
</html>
