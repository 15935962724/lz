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

StringBuffer sql=new StringBuffer();

String orderId = MT.dec(h.get("orderId"));
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
sql.append(" AND order_id="+DbAdapter.cite(orderId));

int sum=ShopOrderData.count(sql.toString());

String nexturl = h.get("nexturl");
int pos=h.getInt("pos");
%><!DOCTYPE html><html><head>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<!-- <script language="javascript">
var hkey_root,hkey_path,hkey_key
hkey_root="HKEY_CURRENT_USER"
hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"
//设置网页打印的页眉页脚为空

try{
var RegWsh = new ActiveXObject("WScript.Shell")
hkey_key="header" 
RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
hkey_key="footer"
RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
}catch(e){}
</script> -->
<script type="text/javascript">
//设置网页打印的页眉页脚为空
var hkey_root,hkey_path,hkey_key
	hkey_root="HKEY_CURRENT_USER"
	hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"

</script>
</head>
<body>
<%
int tpflag = 0;
String hdstr = "";
String tmstr = "";
int status = so.getStatus();
String statusContent = "";
if(status==0)
	  statusContent = "等待付款";
else if(status==1)
	  statusContent = "等待发货";
else if(status==2||status==3)
	  statusContent = "等待收货";
else if(status==4)
	  statusContent = "已完成";
else if(status==5)
	  statusContent = "取消订单";

ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
float price = so.getAmount().floatValue();
if(so.isLzCategory()){
	Profile profile = Profile.find(so.getMember());
	ArrayList sodList = ShopOrderData.find(" AND order_id="+Database.cite(so.getOrderId()),0,Integer.MAX_VALUE);
	if(sodList.size()>0){
		ShopOrderData sorderdata = (ShopOrderData)sodList.get(0); //订单详细
		if(profile.qualification==1 && so.isLzCategory()){
			price=sorderdata.getAmount().floatValue();
		}
		if(profile.membertype==2){//医院代理商价格
			price=sorderdata.getAgent_amount();
		}
	}
}
%>
<table id="tablecenter" cellspacing="0" >
<tr style="font-weight:bold;"><td colspan="4" align='left'>订单信息</td></tr>
<tr>
	<td width="10%" align='right'>订单编号</td><td align='left'><%=MT.f(so.getOrderId()) %></td>
	<td align='right'>下单时间</td><td align='left'><%=MT.f(so.getCreateDate(),1) %></td>
</tr>
<tr>
	<td width="10%" align='right'>当前状态</td><td align='left'><%=MT.f(statusContent) %></td>
	<td width="10%" align='right'>支付方式</td><td align='left'><%out.print(so.getPayType()==1?"在线支付":"公司转账"); %></td>
</tr>
<%
int mypuid = ShopOrderData.findPuid(so.getOrderId());
	if(mypuid==Config.getInt("junan")){
		%>
		<tr>
			<td align='right'>是否调配</td><td align='left'><%= (so.getAllocate()==0?"否":"是") %></td>
			<%
				if(so.getAllocate()==1){
					out.print("<td align='right'>同意调配</td><td align='left'>"+(so.getAllocatetype()==0?"同意":"不同意")+"</td>");
				}else{
					out.print("<td colspan='2'></td>");
				}
			%>
		</tr>	
		<%
	}
%>
<%
if(so.getStatus()==5)
{	
%>
<tr>
	<td width="10%" align='right'>取消原因</td><td colspan='3' align='left'><%=MT.f(so.getCancelReason()) %></td>
</tr>
<%
}
%>
<tr style="font-weight:bold;"><td colspan="4" align='left' style='border:none;padding-top:15px'>收货人信息</td></tr>
<tr>
	<td nowrap align='right'>收货人姓名</td><td align='left'><%=MT.f(sod.getA_consignees())%></td>
	<td nowrap align='right'>手机号</td><td align='left'><%=MT.f(sod.getA_mobile())%></td>
</tr>
<tr>
	<td nowrap align='right'>固定电话</td><td align='left'><%=MT.f(sod.getA_telphone())%></td>
	<td nowrap align='right'>邮编</td><td align='left'><%=MT.f(sod.getA_zipcode())%></td>
</tr>
<tr>
	<td nowrap align='right'>地址</td><td colspan="3" align='left'><%=MT.f(sod.getA_address())%></td>
</tr>

<%
if(so.getStatus()==3||so.getStatus()==4)
{
	ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
	if(soe.time!=null)
	{
%>
<tr style="font-weight:bold;"><td colspan="4" align='left'>发货信息</td></tr>
<tr>
	<td nowrap align='right'>快递单号</td><td colspan="3" align='left'><%=MT.f(soe.express_code)%></td>
</tr>
<tr>
	<td nowrap align='right'>销售编号</td><td align='left'><%=MT.f(soe.NO1)%></td>
	<td nowrap align='right'>生产批号</td><td align='left'><%=MT.f(soe.NO2)%></td>
</tr>
<tr>
	<td nowrap align='right'>有效期</td><td align='left'><%=MT.f(soe.vtime)%></td>
	<td nowrap align='right'>发货日期</td><td align='left'><%=MT.f(soe.time)%></td>
</tr>
<tr>
	<td nowrap align='right'>发件人</td><td align='left'><%=MT.f(soe.person)%></td>
	<td nowrap align='right'>联系电话</td><td align='left'><%=MT.f(soe.mobile)%></td>
</tr>
<%
	}
}
%>

<tr style="font-weight:bold;"><td colspan="4" align='left'>发票信息</td></tr>
<%
if(so.getInvoiceStatus()==3)
{
	ShopOrderExpress seo=ShopOrderExpress.findByOrderId(orderId);
%>
<tr>
	<td nowrap align='right'>开票状态</td><td align='left'>已开具</td>
	<td nowrap align='right'>开票金额</td><td align='left'><%= price%></td>
</tr>
<tr>
	<td nowrap align='right'>发票单号</td><td align='left'><%=MT.f(sod.getN_invoiceNo())%></td>
	<td nowrap align='right'>快递单号</td><td align='left'><%=MT.f(sod.getN_expressNo())%></td>
</tr>
<%
}else
{
%>
<tr>
	<td nowrap align='right'>开票状态</td><td align='left'>未开具</td>
	<td nowrap align='right'>开票金额</td><td align='left'><%= price%></td>
</tr>
<%
}
%>
<tr>
	<td nowrap align='right'>开票单位</td><td align='left'><%=MT.f(sod.getN_company())%></td>
	<td nowrap align='right'>发票接收人</td><td align='left'><%=MT.f(sod.getN_consignees())%></td>
</tr>
<tr>
	<td nowrap align='right'>联系电话</td><td align='left'><%=MT.f(sod.getN_telphone())%></td>
	<td nowrap align='right'>地址</td><td align='left'><%=MT.f(sod.getN_address())%></td>
</tr>

<%-- <%
if(so.getInvoice()==2)
{
%>
<tr>
	<td nowrap align='right' width='10%'>开户行</td><td align='left'><%=MT.f(sod.getN_openbank()) %></td>
	<td align='right'>账 户</td><td align='left'><%=MT.f(sod.getN_accountNo()) %></td>
</tr>
<tr>
	<td nowrap align='right'>纳税人识别号</td><td align='left'><%=MT.f(sod.getN_taxpayerid()) %></td>
</tr>
<tr>
	<td nowrap align='right'>电 话</td><td align='left'><%=MT.f(sod.getN_telphone()) %></td>
	<td nowrap align='right'>邮 编</td><td align='left'><%=MT.f(sod.getN_zip()) %></td>
</tr>
<tr>
	<td nowrap align='right'>地 址</td><td colspan='3' align='left'><%=MT.f(sod.getN_address()) %></td>
</tr>
<%
}
%> --%>
<tr style="font-weight:bold;"><td colspan="4" align='left' style='border:none;padding-top:15px'>订单备注</td></tr>
<tr><td colspan="4" align='left'><%out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></td></tr>

</table>

<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
	<th>商品厂商</th>
  <td>商品编号</td>
  <td>商品图片</td>
  <td align='left'>商品名称</td>
  <!-- <td>商品单价</td> -->
  <td>开票价格</td>
  <td>商品数量</td>
  <%-- <%
  if(so.getStatus()==3||so.getStatus()==4)
	  out.println("<td>操作</td>");
  %> --%>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Profile pf = Profile.find(so.getMember());
  //根据订单id查询订单详情信息
  Iterator it=ShopOrderData.find(sql.toString(),pos,Integer.MAX_VALUE).iterator();
  for(int i=1;it.hasNext();i++)
  {
	  ShopOrderData t=(ShopOrderData)it.next();
	  
	  //判断product_id是否商品的id，如果不是则为套装id；最后产品或套装中的商品存入list中
      int product_id=t.getProductId();
	  
      ShopProduct sp = ShopProduct.find(product_id);
      ShopPackage spage = new ShopPackage(0);
      List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
      String pname = "";
      if(t.getExpectedActivity()!=0){
    	  tpflag = 1;
      }
      hdstr = MT.f(t.getExpectedActivity());
      tmstr = MT.f(t.getExpectedDelivery());
      boolean isSell = false;
	  if(sp.isExist){
		  pname=sp.name[1];
		  /* if(sp.model_id>0){
			  ShopProductModel spm = ShopProductModel.find(sp.model_id);
			  if(spm.getModel()!=null&&spm.getModel().length()>0){
				  ShopCategory sc = ShopCategory.find(spm.getCategory());
				  pname += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："+spm.getModel()+"】</span>";
			  }
		  } */
		  if(t.getActivity()!=null&&!t.getActivity().equals("")){
			  ShopCategory sc = ShopCategory.find(sp.category);
			  pname += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："+t.getActivity()+"】</span>";
		  }
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
	  
	  /* StringBuffer operateBuff = new StringBuffer();
	  if(so.getStatus()==3||so.getStatus()==4)
      {
		  operateBuff.append("<td align='center'>");
          if(so.getStatus()==3){
        	  ShopExchanged se = ShopExchanged.findByOidPid(orderId,product_id);
        	  operateBuff.append("<input type='button' class='return' value='申请退换货' onClick=\"mt.act('refund','"+orderId+"',"+t.getId()+");\" "+(se.id>1?"disabled":"")+" />");
          }else if(isSell&&so.getStatus()==4)
        	  operateBuff.append("<input class='carbtn' type='button' value='放入购物车' onClick=\"car.add("+product_id+","+t.getQuantity()+");parent.mt.close();\"/>");
          operateBuff.append("</td>");
      } */
	  ProcurementUnit pu1 = ProcurementUnit.find(sp.puid);
	  out.println("<tr><td>"+MT.f(pu1.getName())+"</td>");
	  out.println("<td align='center'>");
	  if(sp.isExist)
		  out.println(sp.yucode);
	  out.println("</td>");
	  out.println("<td align='center'>");
	  if(sp.isExist&&sp.picture!=null&sp.picture.length()>0)
		  out.println("<a ><img src='"+MT.f(sp.getPicture('b'))+"'  onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
	  out.println("</td>");
	  out.println("<td align='left'>"+pname);
	  if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals(""))
		  out.println("&nbsp;<span style='color:red;'>【校准时间："+MT.f(t.getCalibrationDate())+"】</span>");
	  out.println("</td>");
	  if(pf.getMembertype()==2){
		  if(so.isLzCategory()){
		  	out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getAgent_price(),2)+"</td>");
		  }else{
			  out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
		  }
	  }else{
	  	out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
	  }
	  out.println("<td align='center'>"+t.getQuantity()+"</td>");
	  /* //操作项
	  out.println(operateBuff.toString()); */
	  out.println("</tr>");
	  
	  if(!sp.isExist){
		  for(int n=0;n<spagePList.size();n++){
			    ShopProduct s1 = spagePList.get(n);
			    String s1name = s1.getAnchor(h.language);
			    /* if(s1.model_id>0){
					  ShopProductModel spm = ShopProductModel.find(s1.model_id);
					  if(spm.getModel()!=null&&spm.getModel().length()>0){
						  ShopCategory sc = ShopCategory.find(spm.getCategory());
						  s1name += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："+spm.getModel()+"】</span>";
					  }
				} */
			    out.println("<tr class='tzP'><td style='text-align:center;'>"+s1.yucode+"</td>");
		    	out.println("<td style='text-align:center;'>");
		    	if(s1.picture!=null&s1.picture.length()>0)
		    		out.println("<a href='/html/folder/14110010-1.htm?product="+s1.product+"' target='_blank'><img src='"+MT.f(s1.getPicture('b'))+"' alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
		    	out.println("</td>");
		    	
		    	out.println("<td style='text-align:left;'>"+s1name+"</td>");
		    	out.println("<td style='text-align:center;text-decoration:line-through;'><span style='font-size:13px;'>&yen;</span>"+MT.f(s1.price,2)+"</td>");
		    	out.println("<td style='text-align:center;'>"+t.getQuantity()+"</td>");
		    	out.println("</tr>");
  	  	  }
	  }
  }
}
%>
<tr><td colspan="6" style="text-align:right;" class='tagsize'><%-- 商品总价：<span>&yen&nbsp;<%=MT.f((double)so.getAmount(),2)%></span>--%>
&nbsp;&nbsp;&nbsp;&nbsp;开票金额：<span>&yen&nbsp;<%=price%></span></td>
</table>

<%
if(Config.getInt("junan")==mypuid){
	
	%>
	<table id="tablecenter" cellspacing="0" style="margin-top:10px">
<tr style="font-weight:bold;"><td colspan="6" align='left'>调配信息</td></tr>
<tr>
	<td width="10%" align='right'>是否已调配</td><td align='left'><%= (tpflag==0?"否":"是") %></td>
<%
	if(tpflag==1){
		%>
	<td width="10%" align='right'>校准时间</td><td align='left'><%= tmstr %></td>
	<td width="10%" align='right'>粒子活度</td><td align='left'><%= hdstr %></td>
		<%
	}
%>
</tr>
</table>
	<%
	
	List<StockOperation> solist = StockOperation.find(" AND oid = "+so.getId()+" AND type = 5 AND isRetreat = 0 ",0, Integer.MAX_VALUE);
	
	%>
	<table id="tablecenter" cellspacing="0">
	<tr style="font-weight:bold;"><td colspan="6" align='left'>库存信息</td></tr>
		<tr id="tableonetr">
		<td >序号</td>
		  <td >购买活度</td>
		  <td>质检号</td>
		  <td>批号</td>
		  <td>购买数量</td>
		  <td>有效期</td>
		</tr>
		<%
		if(solist.size()==0){
			out.print("<tr><td colspan='6'>暂无记录</td></tr>");
		}else{
			for(int i=0;i<solist.size();i++){
				StockOperation son = solist.get(i);
				ProductStock pss = ProductStock.find(son.getPsid());
				out.print("<tr>");
				out.print("<td>"+(i+1)+"</td>");
				out.print("<td>"+son.getActivity()+"</td>");
				out.print("<td>"+pss.getQuality()+"</td>");
				out.print("<td>"+pss.getBatch()+"</td>");
				out.print("<td>");
				out.print(son.getAmount()+son.getReserve());
				out.print("</td>");
				out.print("<td>"+son.getValid()+"</td>");
				out.print("</tr>");
			}
		}
		%>
	</table>
	<%
	
}
%>

</form>
<div id="printP">
<button class="btn btn-default" type="button" onclick="printP()">打印</button>
</div>
<script>
function printP(){
	document.getElementById("printP").style.display="none";
	
	pagesetup_null();

	window.print();
	document.getElementById("printP").style.display="";
	return false;
}
function pagesetup_null(){
	try{
		var RegWsh = new ActiveXObject("WScript.Shell")
		hkey_key="header" 
		RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
		hkey_key="footer"
		RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
	}catch(e){}
};
mt.fit();
</script>
</body>
</html>
