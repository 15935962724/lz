<%@page import="tea.db.DbAdapter"%>
<%@page import="util.DateUtil"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
/*if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}*/
String act=h.get("act");
int soeid=h.getInt("soeid");
int type=h.getInt("type");
String oid=h.get("orderId");

String nexturl = h.get("nexturl");

ShopOrder order = ShopOrder.findByOrderId(oid);


ShopOrderExpress seo=ShopOrderExpress.find(soeid);

List<ShopOrderData> sodList = ShopOrderData.find(" AND order_id="+DbAdapter.cite(oid),0,Integer.MAX_VALUE);
ShopOrderData t = sodList.get(0);
ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(oid);

%><!DOCTYPE html><html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/res/jquery-1.11.1.min.js" type="text/javascript"></script>
<style type="text/css">
.info{display:-webkit-box;}
.info span{-webkit-box-flex:1; text-align:left;display:block;}
</style>
</head>
<body>

<header class="header">出厂信息</header>



<div class='radiusBox newlist'>
<ul>
	    <li class="bold" data-resourelist="shouhuo" data-slideup="up">订单基本信息<!--  <cite data-button-open="展开" data-button-close="收起">展开</cite> --></li>
		<li><span>医院：</span><%=MT.f(sod.getA_hospital())%></li>
		<li><span>活度：</span><%=t.getActivity() %></li>
	    <!-- <div id="shouhuo-wrapper" style="display:none"> -->
	    <li><span>数量：</span><%=t.getQuantity() %></li>
	    <li><span>校准日期：</span><%=MT.f(t.getCalibrationDate()) %></li>
		
		<!-- </div> -->
	</ul>
	<ul>
		<li class="bold" data-resourelist="beizhu" data-slideup="up">订单备注 </li>
	   
			<li style="color:red"><%out.print(order.getUserRemarks()==null||order.getUserRemarks().length()<1?"无":MT.f(order.getUserRemarks())); %></li>
	    
	</ul>
	<ul>
	    <li class="bold" data-resourelist="shouhuo" data-slideup="up">出厂信息 </li>
		<li><span>销售编号：</span><%=MT.f(seo.NO1)%></li>
		<li><span>生产批号：</span><%=MT.f(seo.NO2)%></li>
	    
	    <li><span>有效期：</span><%=MT.f(seo.vtime)==""?DateUtil.addMonth(MT.f( order.getCreateDate()), 5):MT.f(seo.vtime)%></li>
	    <li><span>发货日期：</span><%=MT.f(seo.time,1)%></li>
		<li><span>运单号：</span><%=MT.f(seo.express_code)%></li>
		<li><span>发件人：</span><%=MT.f(seo.person)%></li>
		<li><span>联系电话：</span><%=MT.f(seo.mobile)%></li>
		<li><span>图片：</span>
		<div id="canvasDiv" >
     <%
     	if(MT.f(seo.images).length()>0){
     		String[] imgarr=seo.images.split(",");
     		for(int i=0;i<imgarr.length;i++){
     			Attch attch=Attch.find(Integer.parseInt(imgarr[i]));
     			String imgsr=attch.path;
     %>
     <img src="<%=imgsr %>" width="300px" height="300px">
     <%
     		}
     	}
     %>
     </div>
		</li>
		<li>
			    	
			    	<!-- <button type="button" onclick="history.back();">返回</button> -->
			    </li>
			    </ul>
	
	
		


<script>
$(".radiusBox ul .bold").on("click", function () {
	
    $list = $(this).attr("data-resourelist");
    if ($(this).attr("data-slideup")) {
        $(".radiusBox ul div#" + $list + "-wrapper").slideDown();
        //$("span", this).css("background-image", "url(/furniture/icon-close-dark.png)");
        $("cite", this).html($("cite", this).attr("data-button-close"));
        $(this).removeAttr("data-slideup")
    } else {
        $(this).attr("data-slideup", "up");
        $(".radiusBox ul div#" + $list + "-wrapper").slideUp();
        //$("dfn", this).css("background-image", "url(" + $path + "furniture/icon-open-dark.png)");
        $("cite", this).html($("cite", this).attr("data-button-open"))
    } 
});
</script>
</body>
</html>
