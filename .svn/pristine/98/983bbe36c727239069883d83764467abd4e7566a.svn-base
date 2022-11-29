<%@page import="tea.db.DbAdapter"%>
<%@page import="util.DateUtil"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@ page import="util.Config" %><%

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
if(request.getMethod().equals("POST")){
	ShopOrder so=ShopOrder.findByOrderId(oid);
	if("yes".equals(act)){
		//审核通过
		so.set("status","-2");
		//发送短信给出库复核管理员
		String user = Profile.find(h.member).getMember();
		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			if(MT.f(sms.ckfh)!=""){
				List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckfh);
				if(!"".equals(MT.f(mobiles.toString())))
					SMSMessage.create("Home", user, mobiles.toString(), h.language, order.getOrderId()+"订单的检验报告已验收通过，请入库！");
			}
		}
		ModifyRecord.creatModifyRecord(order.getOrderId(),"报告验收",h.member,"检验报告验收通过");
		out.print("<script>parent.mt.show('操作成功',1,'"+h.get("nexturl")+"')</script>");
		return;
	}else if("no".equals(act)){
		//审核不通过
		seo.set("refusereason", h.get("reason"));//拒绝原因
		so.set("status","-3");
		//发送短信给上海出库管理员（不是上海质检员）
		String user = Profile.find(h.member).getMember();

        int mypuid = order.getPuid();//默认开票单位
        //查看开票单位 不是同辐
        if(Config.getInt("tongfu")==order.getPuid()){
            mypuid = ShopOrderData.findPuid(order.getOrderId());
        }

        ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+mypuid,0,1);
		//ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			if(MT.f(sms.ckjgtz)!=""){
				List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckjgtz);
				if(!"".equals(MT.f(mobiles.toString())))
					SMSMessage.create("Home", user, mobiles.toString(), h.language, order.getOrderId()+"订单的出库信息与检验报告不符，未通过验收，请修改！");
			}
		}
        ModifyRecord.creatModifyRecord(order.getOrderId(),"报告验收",h.member,"检验报告验收未通过");
		out.print("<script>parent.mt.show('操作成功',1,'"+h.get("nexturl")+"')</script>");
		return;
	}
	
}
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

<form name="form1" id="form1" action="?" method="post"  target="_ajax" onsubmit="return checked(this)">
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

<tr>
    <td width="30%">销售编号</td>
    <td class='bornone'><%=MT.f(seo.NO1)%></td> 
  </tr>
  <tr>
    <td>生产批号</td>
    <td class='bornone'><%=MT.f(seo.NO2)%></td> 
  </tr>
  <tr>
    <td>有效期</td>
    <td class='bornone'><%=MT.f(seo.vtime)==""?DateUtil.addMonth(MT.f( order.getCreateDate()), 5):MT.f(seo.vtime)%></td> 
  </tr>
  <tr>
    <td>发货日期</td>
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
     <img src="<%=imgsr %>" >
     <%
     		}
     	}
     %>
     </div>
     </td>  
  </tr>  
  <%
  	if(MT.f(seo.refusereason).length()>0&&order.getStatus()==-3){
  %>
  <tr>
    <td>验收拒绝原因</td>
    <td class='bornone'><%=MT.f(seo.refusereason) %></td> 
  </tr>
  <%
  	}
  %>
</table>

</div>
 <div class='center mt15'>
 <%
 	if(order.getStatus()==-1){
 %>
    
    <button class="btn btn-default" type="button" onclick="mt.act('yes')">验收通过</button>
    <button class="btn btn-default" type="button" onclick="mt.act('no')">验收不通过</button>
    
 <%
 	}
 %>
    <button class="btn btn-default" type="button" onclick="history.back();">返回</button></div>
 </form>

<script type="text/javascript">
mt.act=function(a)
{
  form1.act.value=a;
  
  if(a=='yes')
  {
    mt.show('你确定验收通过吗？',2,'form1.submit()');
  }else if(a=='no')
  {
	//mt.show("<textarea></textarea>");
	//mt.show('你确定审核不通过吗？',2,'form1.submit()');
	 mt.show("<textarea id='_q' cols='28' rows='5'></textarea>",2,"拒绝原因");
	  mt.ok=function()
	  {
	    var v=document.getElementById("_q").value;
		if(v==''||v=='undefined')return;
		
		form1.reason.value = v;
		form1.submit();
		
	  }
  }
}
</script>

</body>
</html>
