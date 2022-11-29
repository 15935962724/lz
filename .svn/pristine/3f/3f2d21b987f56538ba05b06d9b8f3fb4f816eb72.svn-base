<%@page import="tea.db.DbAdapter" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Database" %>
<%@page import="tea.entity.Http" %>
<%@page import="tea.entity.MT" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="util.DateUtil" %>
<%@ page import="java.util.ArrayList" %>
<%

	Http h = new Http(request, response);
	if (h.member < 1) {
		response.sendRedirect("/servlet/StartLogin?community=" + h.community);
		return;
	}
	int menu = h.getInt("id");
	StringBuffer sql = new StringBuffer(), par = new StringBuffer("?");
	par.append("&menu=" + menu);
	int tab = h.getInt("tab", 0);
	Date date = new Date();
	String yyyy = DateUtil.getStringFromDate(date, "yyyy");
	if(tab == 0 ){//获取  粒子订单
		sql.append(" AND so.member="+h.member+" AND so.createDate>'"+yyyy+"-01-01 00:00:00' AND so.status!=5 AND so.status!=6 ");
	}else {//支出  TPS
		sql.append(" AND fws_id="+h.member+" AND createtime>'"+yyyy+"-01-01 00:00:00' ");
	}
	par.append("&member=" + h.member);

	String[] TAB = {"已获取", "已支出"};


	par.append("&tab=" + tab);

	int pos = h.getInt("pos");
	par.append("&pos=");


%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>

	.con-left-list .tit-on2 {
		color: #044694;
	}
	.right-list-zt li a.current {
		background: #044694;
		color: #fff;
	}
	.right-list-zt li a {
		display: block;
		color: rgb(51, 51, 51);
		padding: 0px 100px;
	}

</style>
</head>
<body style='min-height:800px;'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<form name="form1" action="?">
			<input type="hidden" name="id" value="<%=menu%>"/>
			<input type="hidden" name="tab" value="<%=tab%>"/>

		</form>
		<div class="right-list">
			<%
				out.print("<ul class='right-list-zt'>");
				for (int i = 0; i < TAB.length; i++) {
					out.print("<li><a href='javascript:mt.tab(" + i + ")' class='" + (i == tab ? "current" : "") + "'>" + TAB[i] + "</a></li>");
				}
				out.print("</ul>");
			%>
			<form name="form2" action="/ShopTps.do" method="post" target="_ajax">
				<input type="hidden" name="orderId"/>
				<input type="hidden" name="status"/>
				<input type="hidden" name="jqm"/>
				<input type="hidden" name="tab" value="<%=tab%>"/>
				<input type="hidden" name="nexturl"/>
				<input type="hidden" name="act"/>
				<table class="right-tab" border="1" cellspacing="0">
					<tr>
						<th>序号</th>
						<th>医院名</th>
						<th>订单编号</th>
						<th>订单时间</th>
						<th>积分变更</th>
					</tr>
					<%

						int sum ;
						if(tab==0){
							sum  = ShopOrder.count(sql.toString());
						}else {
							sum  = TpsOrder.count(sql.toString());
						}
						System.out.println(sum);
						if (sum < 1) {
							out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
						} else {

							if(tab==1) {
								Iterator<TpsOrder> iterator = TpsOrder.find(sql.toString() + " order by id desc ", pos, 10).iterator();
								for (int i = 1 + pos; iterator.hasNext(); i++) {
									TpsOrder t = (TpsOrder) iterator.next();
									%>
					<tr>
						<td><%=i%></td>
						<td><%=ShopHospital.find(t.getHospital_id()).getName()%></td>
						<td><%=t.getOrder_id()%></td>
						<td><%=MT.f(t.getCreatetime(),1)%></td>
						<td>- <%=t.getJifen()%></td>
					</tr>
								<%}
							}else {
								ArrayList<ShopOrder> shopOrders = ShopOrder.find(sql.toString() + "  order by id desc ", pos, 10);
									for (int i = 0; i < shopOrders.size(); i++) {
										ShopOrder shopOrder = shopOrders.get(i);
										ArrayList<ShopOrderData> shopOrderData = ShopOrderData.find(" AND order_id=" + Database.cite(shopOrder.getOrderId()), 0, Integer.MAX_VALUE);
										ShopOrderData sd = shopOrderData.get(0);
										ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(shopOrder.getOrderId());
								%>
					<tr>
						<td><%=i+pos+1%></td>
						<td><%=MT.f(sod.getA_hospital())%></td>
						<td><%=shopOrder.getOrderId()%></td>
						<td><%=MT.f(shopOrder.getCreateDate(),1)%></td>
						<td style="color: #044694; font-weight: bold">+<%=sd.getQuantity()%></td>
					</tr>
									<%}
							}


							if (sum > 20)
								out.print("<tr><td colspan='10' id='ggpage' align='right'>" + new tea.htmlx.FPNL(h.language, par.toString(), pos, sum, 20));
						}
					%>
				</table>
			</form>
		</div>
	</div>
</div>


<script>
    form2.nexturl.value = location.pathname + location.search;
    mt.act = function (a, orderId) {
        form2.act.value = a;
        form2.orderId.value = orderId;
        if (a == 'submitsbm') {
            mt.show("<textarea id='_content' cols='33' rows='6' title='请填写机器码...'></textarea>",2,'机器码',348);
            mt.ok=function()
            {
                var t=parent.$$('_content');
                if(t.value=='')
                {
                    alert('机器码不能为空！');
                    return false;
                }
                form2.jqm.value=t.value;
                form2.submit();
            };
        }else if(a == "detail"){

            location.href = "/jsp/yl/shopweb/ShopTpsOrderDatas.jsp?ids="+orderId;
        }
    };
</script>
</body>
</html>
