<%@page import="util.Config"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

String orderId = MT.dec(h.get("orderId"));
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
    //获取医院，如果医院是20天签收否的    可以在status=3时退货
    ShopOrderDispatch byOrderId = ShopOrderDispatch.findByOrderId(orderId);
    ShopHospital shopHospital = ShopHospital.find(byOrderId.getA_hospital_id());
    int issign = shopHospital.getIssign();
    sql.append(" AND order_id="+DbAdapter.cite(orderId));
par.append("&orderId="+orderId);

int sum=ShopOrderData.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

String nexturl = h.get("nexturl");

%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(1){
		font-weight: bold;
	}
	.con-left-list .tit-on1{color:#044694;}

</style>
</head>
<body>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<p class="right-zhgl">
			<span>申请退货</span>
		</p>

<form name="form2" action="/ShopExchangeds.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class='results'>
<table class="right-tab" border="1" cellspacing="0" style="margin:0px;">
<tr id="tableonetr">
  <th>商品编号</th>
  <th>商品图片</th>
  <th>商品名称</th>
  <th>商品单价</th>
  <th>商品数量</th>
  <th>请求退货数量</th>
  <th>实际退货数量</th>
  <%
  if(so.getStatus()==4||issign==0)
	  out.println("<th>操作</td>");
  %>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Profile pf = Profile.find(so.getMember());
  
  //根据订单id查询订单详情信息
  Iterator it=ShopOrderData.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopOrderData t=(ShopOrderData)it.next();
	  
	  //判断product_id是否商品的id，如果不是则为套装id；最后产品或套装中的商品存入list中
      int product_id=t.getProductId();
	  
      ShopProduct sp = ShopProduct.find(product_id);
      ShopPackage spage = new ShopPackage(0);
      List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
      String pname = "";
      boolean isSell = false;
	  if(sp.isExist){
		  pname=sp.name[1];
		  if(sp.state==0)
			  isSell = true;
	  }else{
		  spage = ShopPackage.find(product_id);
		  pname="[套装]"+MT.f(spage.getPackageName());
		  ShopProduct s = ShopProduct.find(spage.getProduct_id());
		  if(s.state==0)
			  isSell = true;
		  spagePList.add(0,s);
		  String [] sarr = spage.getProduct_link_id().split("\\|");
		  for(int m=1;m<sarr.length;m++){
			  spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
		  }
	  }
	  
	  StringBuffer operateBuff = new StringBuffer();
	  if(so.getStatus()==4||issign==0)//20天未签收设置 否 （可以在出库状态下申请退货）
      {
		  operateBuff.append("<td align='center'>");
          ShopExchanged se = ShopExchanged.findByOidPid(orderId,product_id);
          Boolean isok = true;//是否可以展示退货按钮
          ArrayList<ShopExchanged> shopExchangeds = ShopExchanged.find(" AND  order_id=" + Database.cite(orderId), 0, Integer.MAX_VALUE);
          if(shopExchangeds.size()>0){
              for (int j = 0; j <shopExchangeds.size() ; j++) {
                  ShopExchanged shopExchanged = shopExchangeds.get(j);
                  if(shopExchanged.status==0){//有进行中的不能申请退货
                      isok = false;
                  }
              }
          }

          if(isok) {
              operateBuff.append("<input type='button' class='btn btn-default' value='申请退货' onClick=\"mt.act('refund','" + MT.enc(orderId) + "','" + MT.enc(t.getId()) + "');\" />");
          }else {
              operateBuff.append("正在进行中");
          }

          operateBuff.append("</td>");
      }
	  
	  out.println("<tr><td align='center'>");
	  if(sp.isExist)
		  out.println(sp.yucode);
	  out.println("</td>");
	  out.println("<td align='center'>");
	  if(sp.isExist&&sp.picture!=null&sp.picture.length()>0)
		  out.println("<img src='"+MT.f(sp.getPicture('b'))+"'  onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
	  out.println("</td>");
	  out.println("<td align='center'>"+pname);
	  if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals(""))
		  out.println("&nbsp;&nbsp;<span style='color:red;'>(粒子的校准时间："+MT.f(t.getCalibrationDate())+")</span>");
	  int mypuid = ShopOrderData.findPuid(t.getOrderId());
	  if(mypuid==Config.getInt("junan")){
		  if(t.getExpectedActivity()>0){
			  out.println("<p>调配活度："+t.getExpectedActivity());
			  out.println("&nbsp;&nbsp;调配校准时间："+MT.f(t.getExpectedDelivery())+"</p>");
		  }
	  }
	  out.println("</td>");
	  out.println("<td align='center'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
	  out.println("<td align='center'>"+t.getQuantity()+"</td>");
	  //新增请求退货数量和实际退货数量
	  ShopExchanged ex=ShopExchanged.findByOrderId(t.getOrderId());
      ArrayList<ShopExchanged> shopExchangeds = ShopExchanged.find(" AND order_id=" + Database.cite(t.getOrderId()), 0, Integer.MAX_VALUE);
      int qingqiu = 0;
      int shiji = 0;
      for (int j = 0; j < shopExchangeds.size(); j++) {
          ShopExchanged shopExchanged = shopExchangeds.get(j);
          if(shopExchanged.status==0){//未完成 记录青丘
              qingqiu += shopExchanged.quantity;
          }else if(shopExchanged.status==1){
              qingqiu += shopExchanged.quantity;
              shiji += shopExchanged.quantity;
          }else if(shopExchanged.status==2){//被拒修改实际数
              qingqiu += shopExchanged.quantity;
              shiji += shopExchanged.exchangednum;
          }

      }
      out.println("<td align='center'>"+qingqiu+"</td>");
      out.println("<td align='center'>"+shiji+"</td>");
      /*if(ex.id>0){
		  //点击查看退货进来的，如果status=2时，有请求退货数量和实际退货数量
		  if(ex.status==0){
			  out.println("<td align='center'>"+ex.quantity+"</td>");
			  out.println("<td align='center'></td>");
		  }else if(ex.status==1){
			  out.println("<td align='center'>"+ex.quantity+"</td>");
			  out.println("<td align='center'>"+ex.quantity+"</td>");
		  }else if(ex.status==2){
			  out.println("<td align='center'>"+ex.quantity+"</td>");
			  out.println("<td align='center'>"+ex.exchangednum+"</td>"); 
		  }
	  }else{
		  out.println("<td align='center'></td>");
		  out.println("<td align='center'></td>"); 
	  }*/
	//操作项
	  out.println(operateBuff.toString());
	  out.println("</tr>");
	  
	  if(!sp.isExist){
		  for(int n=0;n<spagePList.size();n++){
			    ShopProduct s1 = spagePList.get(n);
			    out.println("<tr class='tzP'><td style='text-align:center;'>"+s1.yucode+"</td>");
		    	out.println("<td style='text-align:center;'>");
		    	if(s1.picture!=null&s1.picture.length()>0)
		    		out.println("<img src='"+MT.f(s1.getPicture('b'))+"' alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
		    	out.println("</td>");
		    	out.println("<td style='text-align:center;'>"+s1.getAnchor(h.language)+"</td>");
		    	out.println("<td style='text-align:center;'><span style='font-size:13px;'>&yen;</span>"+MT.f(s1.price,2)+"</td>");
		    	out.println("<td style='text-align:center;border-right:none;'>"+t.getQuantity()+"</td>");
		    	out.println("<td></td>");
		    	out.println("</tr>");
  	  	  }
	  }
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
	<div class="center text-c pd20">
<%
	//增加确认退货数量按钮
	ShopExchanged exch=ShopExchanged.findByOrderId(orderId);
	if(exch.id>0&&exch.exchangednum>=0&&exch.exchangedstatus==0&&exch.status==2){
%>
<input type="button" class="btn btn-default" onclick="mt.act('yesexchange','<%=orderId %>')" value="确认退货数量">
<%
	}
%>
<input type="button" class="btn btn-default" onclick="history.back()" value="返回">
	</div>
</div>
</form>
	</div>
</div>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,oid,did)
{
  if(a=='refund')
  {
	  //ShopExchangedAdd.jsp
	  location.href="/jsp/yl/shopweb/ShopExchangedAdd.jsp?oid="+oid+"&did="+did+"&nexturl="+form2.nexturl.value;
  }else if(a=='yesexchange'){
	  form2.act.value=a;
	  form2.orderId.value=oid;
	  form2.submit();
  }
};
mt.fit();
</script>
</body>
</html>
