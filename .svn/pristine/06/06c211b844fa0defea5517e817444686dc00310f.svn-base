<%@page import="util.Config"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="util.DateUtil"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
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
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<link href="/jsp/yl/shop/img/iconfont.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
</head>
<body>
<h1>出厂信息</h1>

<div class="radiusBox">
<table id="tdbor" cellspacing="0" class="newTable">
<thead>
<tr><td colspan="6" class="bornone">订单基本信息</td></tr>
</thead>
<tbody>
	<tr id="tableonetr">
	  <th width="30">序号</th>
	  <th width="260">医院</th>
	  <th width="50">活度</th>
	  <th width="50">数量</th>
	  <th width="100">校准日期</th>
	  <th>备注</th>
	</tr>
	
	<tr>
		<td>1</td>
	    <td><%=sod.getA_hospital() %></td>
	    <td><%=t.getActivity() %></td> 
	    <td><%=t.getQuantity() %></td>
	    <td><%=MT.f(t.getCalibrationDate()) %></td>
	  	<td><%=MT.f(order.getUserRemarks()) %></td>
  	</tr>

</tbody></table>
</div>

<br>

<form name="form1" id="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return checked(this)">
<input type="hidden" name="orderId" value="<%=oid%>"/>
<input type="hidden" name="soeid" value="<%=soeid%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="act" value="chushen"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="serveridwai" id="serveridwai" value="<%=MT.f(seo.images) %>"/>
<input type="hidden" name="reason" />
<div class='radiusBox'>

<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='2' class='bornone'>查看</td></tr>
</thead>

<%
int mypuid = ShopOrderData.findPuid(order.getOrderId());
	%>
<tr>
    <td><%
        if(Config.getInt("junan")!=mypuid){
            out.print("销售编号");
        }else{
            out.print("质检号");
        }
    %></td>
    <td class='bornone'><%=MT.f(seo.NO1)%></td> 
  </tr>
  <tr>
    <td>生产批号</td>
    <td class='bornone'><%=MT.f(seo.NO2)%></td> 
  </tr>

    <%
        if(Config.getInt("junan")!=mypuid){
            %>
    <tr>
        <td>有效期</td>
        <td class='bornone'><%=MT.f(seo.vtime)==""?DateUtil.addMonth(MT.f( order.getCreateDate()), 5):MT.f(seo.vtime)%></td>
    </tr>
    <%
        }
    %>
  <tr >
    <td  width="30%">发货日期</td>
    <td class='bornone'><%=MT.f(seo.time,1)%></td> 
  </tr>
  
  <tr>
    <td>运单号</td>
    <td class='bornone'><%=MT.f(seo.express_code)%></td> 
  </tr>
  
  <tr>
    <td>发件人</td>
    <td class='bornone'><%=MT.f(seo.person) %></td> 
  </tr>
  <tr>
    <td>联系电话</td>
    <td class='bornone'><%=MT.f(seo.mobile) %></td> 
  </tr>
  <tr>  
     <td>  
        检验报告 
     </td>  
     <td width="80" align="right">  
     <div id="canvasDiv" >
     <%
     	if(MT.f(seo.images).length()>0){
     		String[] imgarr=seo.images.split(",");
     		for(int i=0;i<imgarr.length;i++){
     			Attch attch=Attch.find(Integer.parseInt(imgarr[i]));
     			String imgsr=attch.path;
     %>
     <%-- <img src="<%=imgsr %>" width="300px" height="300px"> --%>
     <img src="<%=imgsr %>" >
     <%
     		}
     	}
     %>
     </div>
     </td>  
  </tr>
    <%
        if(Config.getInt("junan")==mypuid){
            %>
    <tr>
        <td>
            上传快递单号照片
        </td>
        <td width="80" align="right">
            <div id="canvasDiv" >
                <%
                    if(MT.f(seo.express_img).length()>0){
                        String[] imgarr=seo.express_img.split(",");
                        for(int i=0;i<imgarr.length;i++){
                            Attch attch=Attch.find(Integer.parseInt(imgarr[i]));
                            String imgsr=attch.path;
                %>
                <%-- <img src="<%=imgsr %>" width="300px" height="300px"> --%>
                <img src="<%=imgsr %>" >
                <%
                        }
                    }
                %>
            </div>
        </td>
    </tr>
    <%
        }
  	if(order.getStatus()!=-2&&MT.f(seo.refusereason).length()>0&&order.getStatus()==-3){
  %>
  <tr>
    <td>初审拒绝原因</td>
    <td class='bornone'><%=MT.f(seo.refusereason) %></td> 
  </tr>
  <%
  	}
  %>
  <%
  	if(order.getStatus()!=-2&&MT.f(seo.fuhereason).length()>0&&order.getStatus()==-4){
  %>
  <tr>
    <td>复核拒绝原因</td>
    <td class='bornone'><%=MT.f(seo.fuhereason) %></td> 
  </tr>
  <%
  	}
  %>
</table>

</div>
 <div class='center mt15'>
 
    <button class="btn btn-default" type="button" onclick="history.back();">返回</button></div>
 </form>



</body>
</html>
