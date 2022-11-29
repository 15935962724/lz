<%@page contentType="text/html;charset=UTF-8"%>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.admin.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.math.BigDecimal" %>

<%
	request.setCharacterEncoding("UTF-8");

	TeaSession teasession = new TeaSession(request);
		if (teasession._rv == null) {
		response.sendRedirect("/servlet/StartLogin?Node="
		+ teasession._nNode);
		return;
	}



	Profile p = Profile.find(teasession._rv.toString());

	//查询积分
	int point = Point.getLastPoint(teasession._rv.toString());


	//得到上次访问时间
	java.text.SimpleDateFormat objSDF = new java.text.SimpleDateFormat(
			"yyyy-MM-dd HH:mm:SS");
	Date date = Log.getLastTime(teasession._rv);
	String s_date = objSDF.format(date).toString();
	String _date = s_date.split(" ")[0];
	String _time = s_date.split(" ")[1];
	String year = _date.split("-")[0];
	String month = _date.split("-")[1];
	String day = _date.split("-")[2];

	//查询订单数量
	String sql = " and rcustomer='" + teasession._rv.toString()
			+ "' and  vcustomer='" + teasession._rv.toString() + "'";
	int trade_count = Trade.count(teasession._strCommunity, sql);

    //查询已完成订单数量及总金额
	String sql1 = "  and rcustomer='" + teasession._rv.toString() + "' and vcustomer='"
			+ teasession._rv.toString() + "' and status=5 ";//" + 5 + "  and time <=sysdate()
    Map map=Trade.totalSum(teasession._strCommunity, sql1);//


    //当前系统日期
    java.text.SimpleDateFormat _objSDF = new java.text.SimpleDateFormat("yyyy-MM-dd");
	      java.util.Date sysdate = new java.util.Date();
	    String sys_date=_objSDF.format(sysdate).toString().split(" ")[0];


%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="/tea/tea.js"></script>
		<script src="/tea/image/ig/ig.js"></script>
		<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

	</head>
	<body>
	    <div id="zhanghu"><div id="hy" class="lanse">欢迎您：<%=teasession._rv.toString()%></div>

		<div class="lanse">帐户类型：量贩超市用户</div>

		<div class="lanse">累计积分：<span class="jusec"><%=point%></span></div>

		<div id="lastdl">上一次登录时间：
		<%=year%>年<%=month%>月<%=day%>日&nbsp;&nbsp;&nbsp;&nbsp;<%=_time%></div>

		<div class="zh_title">您的订单：</div>
		<div id="zh_d">您目前一共有<span class="jusex"><%=trade_count%></span>个订单</div>

		<div class="zh_title">您的购物车：</div>
		<div id="zh_sp">
		<%
	     java.util.Enumeration e2 = tea.entity.node.Buy.findBuys(teasession._rv,teasession._strCommunity);
	     if(!e2.hasMoreElements()){
          out.print("您的购物车现有0件商品 总计： 0.00 元");
         }
         while(e2.hasMoreElements())
         {
        int k = ((Integer)e2.nextElement()).intValue();
        tea.entity.node.Buy buy = tea.entity.node.Buy.find(k);
        int l = buy.getNode();
        tea.entity.node.Node node = tea.entity.node.Node.find(l);
        int node_id=node._nNode;
        tea.entity.node.Goods gobj=tea.entity.node.Goods.find(node._nNode);
         out.print("<a href='/servlet/Node?Node="+node_id+"&Language="+teasession._nLanguage+"' target='_top'><img src='"+gobj.getSmallpicture(teasession._nLanguage)+"'/></a>");
        }
		 %></div>
		 <div id="zh_bei">*&nbsp;&nbsp;您购物车中的商品信息，我们将为您保存30天，请您及时购买。购物车中显示的价格为商品的最新价格。</div>
		<div id="zh_bei2">
		<%if(map.size()==2){
		BigDecimal sum=(BigDecimal)map.get("sum");
		Integer count=(Integer)map.get("count");
	    %>
		  截至<%=sys_date %>，您共有<%=count%>张订单完成交易，累计消费<%if(sum!=null)out.print(sum);else out.print("0.00");%>元。
	    <% }else {%>
	    截至<%=sys_date %>，您共有0张订单完成交易，累计消费0元。
	    <%}%></div>
	</div>
</body>
</html>
