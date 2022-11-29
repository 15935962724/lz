<%@page import="util.Config"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@ page import="util.DateUtil" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String orderId = h.get("orderId");
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
//出厂信息
ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
//
ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());

StringBuffer sql=new StringBuffer();
sql.append(" AND order_id="+DbAdapter.cite(orderId));
//根据订单id查询订单详情信息
List<ShopOrderData> sodList = ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE);
ShopOrderData orderData = sodList.get(0);
//商品
ShopProduct sp = ShopProduct.find(orderData.getProductId());

String nexturl = h.get("nexturl");
//上海管理员  14122306
//AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);

//粒子签收 二维码
Map<String,String> map = new HashMap<String,String>();
map.put("act", "lzsign");
map.put("orderid",so.getOrderId());
String param = JSON.toJSON(map).toString();
String CODE_URL = "http://www.brachysolution.com/ScanQRCode?"+MT.enc(param);
Filex.logs("yt_qianshou.txt", "code1=================="+CODE_URL);
%><!DOCTYPE html>
<html>
<head>
	<link href="/jsp/yl/shop/print_css.css?param=Math.random()" rel="stylesheet" type="text/css" />
	
	<script src="/tea/mt.js" type="text/javascript"></script>
	<script src="/tea/jquery-1.4.2.min.js" type="text/javascript"></script>
	<script src="/tea/jquery.jqprint-0.3.js" type="text/javascript"></script>
</head>
<body>
<%
String person = MT.f(soe.person);
	String mobile = MT.f(soe.mobile);
	ProcurementUnit pu = ProcurementUnit.find(so.getPuid());
	String pname = MT.f(pu.fullname);
	if(Config.getInt("tongfu")==so.getPuid()){
		person = MT.f(pu.person);
		mobile = MT.f(pu.mobile);
	}
	
%>
	<div id="_printInfo" style="width: 751px;margin: 0 auto;">
		<div class="tits"><h2><%=pname  %>-医疗粒子</h2>
			<div class="h3">发货交接单</div>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>订单号:<%=MT.f(so.getOrderId()) %></td>
				<%
				int mypuid = ShopOrderData.findPuid(so.getOrderId());
					if(mypuid!=Config.getInt("junan")){
						if(mypuid!=Config.getInt("gaoke")){
							%>
				<td>销售编号:<%=MT.f(soe.NO1) %></td>
							<%
						}
						%>
						<td>产品批号:<%=MT.f(soe.NO2) %></td>
						<%
					}
				%>
				<td>发货时间：<%=MT.f(soe.time) %></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class='tabline'>
			<tr>
				<th>商品名称</th>
				<th>医院</th>
				<th>活度</th>
				<th>商品数量</th>
				<%
					if(Config.getInt("gaoke")!=mypuid){
						out.print("<th>校准日期</th>");
					}
				%>
				<%--<th>有效期</th>--%>
				<%
					if(Config.getInt("gaoke")==mypuid){
						out.print("<th>标定日期</th>");
						out.print("<th>有效期</th>");
						out.print("<th>备注</th>");
					}
				%>
			</tr>
			<%
			if(mypuid!=Config.getInt("junan")){
				%>
				<tr>
				<td><%=sp.name[1] %></td>
				<td><%=MT.f(sod.getA_hospital()) %></td>
				<td align="right"><%=orderData.getActivity() %></td>
				<td align="right"><%=orderData.getQuantity() %></td>
					<%
						if(Config.getInt("gaoke")!=mypuid){
							%>
					<td><%=MT.f(orderData.getCalibrationDate()) %></td>
					<%
						}
					%>
				<%--<td><%=MT.f(soe.vtime) %></td>--%>
					<%
						if(Config.getInt("gaoke")==mypuid){
							out.print("<td>"+MT.f(soe.time)+"</td>");
							out.print("<td>"+MT.f(soe.vtime)+"</td>");
							out.print("<td>"+MT.f(so.getUserRemarks())+"</td>");

						}
					%>
			</tr>
				<%
			}else{

				String sodbsql = " AND ordercode = "+Database.cite(orderId);
				List<ShopOrderDatasBatches> sodblist = ShopOrderDatasBatches.find(sodbsql,0,Integer.MAX_VALUE);
				String sostr = ",";
				for (int i = 0; i < sodblist.size(); i++) {
					ShopOrderDatasBatches sodb = sodblist.get(i);
					sostr +=sodb.soid;
				}
				String [] soidarr = sostr.split(",");

				/*System.out.println("==="+soidarr.length);
				for (int i = 2; i <soidarr.length ; i++) {
					System.out.println(i+"==="+soidarr[i]);
				}*/

				//List<StockOperation> solist = StockOperation.find(" AND oid = "+so.getId()+" AND type = 0 AND isRetreat = 0 ",0, Integer.MAX_VALUE);
				if(soidarr.length==0){
					//out.print("<tr><td colspan='6'>暂无记录</td></tr>");
				}else{
					//for(int i=0;i<solist.size();i++){
					for (int i = 2; i <soidarr.length ; i++) {
						StockOperation son = StockOperation.find(Integer.parseInt(soidarr[i]));
						ProductStock pss = ProductStock.find(son.getPsid());
						out.print("<tr>");
						out.print("<td>"+sp.name[1]+"</td>");
						out.print("<td>"+MT.f(sod.getA_hospital())+"</td>");
						out.print("<td>"+son.getActivity()+"</td>");
						out.print("<td>"+(son.getAmount()+son.getReserve())+"</td>");
						if(Config.getInt("gaoke")!=mypuid){
							out.print("<td>"+MT.f(son.getCalibrationtime())+"</td>");
						}
						Date yxq = son.getValid();
						/*if(Config.getInt("junan")==mypuid){
							out.print("<td>"+DateUtil.subDay(MT.f(yxq))+"</td>");
						}else{
							out.print("<td>"+MT.f(yxq)+"</td>");
						}*/


						if(Config.getInt("gaoke")==mypuid){
							out.print("<td>"+MT.f(so.getRemarks())+"</td>");
						}
						out.print("</tr>");
					}
				}
			}
			%>
			<tr>
				<td>&nbsp;</td>
				<td></td>
				<td></td>
				<td></td>
				<%
					if(Config.getInt("gaoke")!=mypuid){
						out.print("<td></td>");
					}
				%>

				<%
					if(Config.getInt("gaoke")==mypuid){
						out.print("<td></td>");
						out.print("<td></td>");
						out.print("<td></td>");
					}
				%>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td></td>
				<td></td>
				<td></td>
				<%
					if(Config.getInt("gaoke")!=mypuid){
						out.print("<td></td>");
					}
				%>

				<%
					if(Config.getInt("gaoke")==mypuid){
						out.print("<td></td>");
						out.print("<td></td>");
						out.print("<td></td>");
					}
				%>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td></td>
				<td></td>
				<td></td>
				<%
					if(Config.getInt("gaoke")!=mypuid){
						out.print("<td></td>");
					}
				%>

				<%
					if(Config.getInt("gaoke")==mypuid){
						out.print("<td></td>");
						out.print("<td></td>");
						out.print("<td></td>");
					}
				%>
			</tr>
		</table>
		<div class='borderline' style="min-height:140px">
		<div  class='borderlineleft' style="float:left;width:40%">
			<!-- <div><span>发货方：</span>&nbsp;&nbsp;&nbsp;<span>上海欣科医药有限公司</span></div>
			<div ><span>代表：</span></div>
			<div ><span>日期：</span></div> -->
			<div><span>发货方：</span>&nbsp;&nbsp;&nbsp;<span><%= pname %></span></div>
			<div ><span>代表：</span><%= person %></div>
			<div ><span>日期：</span><%=MT.f(soe.time) %></div>
			</div>
		
		<div class='borderlineright' style="float:right;width:40%">
			<div><span>收货方：</span>&nbsp;&nbsp;&nbsp;<span><%=MT.f(sod.getA_hospital()) %></span></div>
			<div ><span>代表：</span></div>
			<div ><span>日期：</span></div>
		</div>
		</div>
		<table width="100%"><tr>
			<td style="vertical-align:top;padding:15px 15px" width='70%' class='texts'>
				<p><strong>温馨提示：</strong></p>
				<p class='indent'>如发现商品破损或与商品订购信息描述不符等任何问题，请及时联系我们的售后服务热线 <%= mobile %>。</p>
				<p><strong>签收方式：</strong></p>
				<p class='indent'>通过微信扫一扫，扫描右侧二维码，快速确认收货。</p>
			</td>
			<td ><img id="order_code" src="/CodeServlet?text=<%=CODE_URL%>" width='100%'/></td>
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
