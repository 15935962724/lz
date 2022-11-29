<%@page import="tea.ui.yl.shop.ProductStocks"%>
<%@page import="util.Config"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.yl.shopnew.InvoiceData"%>
<%@page import="tea.entity.yl.shopnew.Invoice"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@ page import="tea.entity.admin.AdminRole" %>
<%@ page import="tea.entity.member.ModifyRecord" %>
<%@ page import="org.apache.commons.lang.time.DateUtils" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer();

String orderId = h.get("orderId");
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
sql.append(" AND order_id="+DbAdapter.cite(orderId));

int sum=ShopOrderData.count(sql.toString());

String nexturl = h.get("nexturl");
//上海管理员  14122306
AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);


	int crole= AdminRole.findByName("价格", "Home");//角色
	Enumeration ce=AdminUsrRole.findByRole(crole);

	boolean isadmin = false;
	while(ce.hasMoreElements()){
		int cpro=Integer.parseInt(String.valueOf(ce.nextElement()));
		if(cpro==h.member){
			isadmin = true;
			break;
		}
	}
if(h.member==14100001){
	isadmin = true;
}


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<h1>订单详细</h1>

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
Profile p=Profile.find(so.getMember());//12.6新加 手机号更改为获取p的mobile，之前为获取sod的a_mobile；
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
<table id="tablecenter" cellspacing="0" style="margin-top:10px">
<tr style="font-weight:bold;"><td colspan="4" align='left'>订单信息</td></tr>
<tr>
	<td width="10%" align='right'>订单编号</td><td align='left'><%=MT.f(so.getOrderId()) %></td>
	<td align='right'>下单时间</td><td align='left'><%=MT.f(so.getCreateDate(),1) %></td>
</tr>
<%
int mypuid = ShopOrderData.findPuid(so.getOrderId());
	if(mypuid==Config.getInt("junan")){
		%>
		<tr>
			<td align='right'>是否调配</td><td align='left'><%= (so.getAllocate()==0?"否":"是") %></td>
			<%
				if(so.getAllocate()==1){
					out.print("<td align='right'>是否同意调配</td><td align='left'>"+(so.getAllocatetype()==0?"同意":"不同意")+"</td>");
				}else{
					out.print("<td colspan='2'></td>");
				}
			%>
		</tr>	
		<%
	}
%>
<tr>
	<%--订单签收人取值有误  用户推出openid被清除就查不到了--%>
	<%
		String qianshouren = "";
		if(status==4){//已签收展示
		    qianshouren = "—— 签收人："+sod.getA_consignees();
		}
	%>
	<td align='right'>当前状态</td><td align='left'><%=MT.f(statusContent) %> <%=qianshouren %></td>
	<td align='right'>支付方式</td><td align='left'><%out.print(so.getPayType()==1?"在线支付":"公司转账"); %></td>
</tr>
<tr>
	<td align='right'>签收时间</td><td align='left'><%=MT.f(so.getReceiptTime(),1) %></td>
	<td align='right'>
	<%
		if(so.getStatus()==7)
			out.print("原订单编号");
	%>
	</td>
	<td align='left'>
	<%
		if(so.getStatus()==7)
			out.print(MT.f(so.getOldorderid()));
	%>
	</td>
</tr>
<%
if(so.getStatus()==5)
{	
%>
<tr>
	<td align='right'>取消订单原因</td><td align='left'><%=MT.f(so.getCancelReason()) %></td>
</tr>
<%
}
%>
<tr style="font-weight:bold;"><td colspan="4" align='left'>收货人信息</td></tr>
<tr>
	<td align='right'>收货人姓名</td><td align='left'><%=MT.f(sod.getA_consignees())%></td>
	<td align='right'>医院</td><td align='left'><%=MT.f(sod.getA_hospital())%></td>
</tr>
<tr>
	<td align='right'>地址</td><td align='left'><%=MT.f(sod.getA_address())%></td>
	<td align='right'>邮编</td><td align='left'><%=MT.f(sod.getA_zipcode())%></td>
</tr>
<tr>
	<td align='right'>手机号</td><td align='left'><%=MT.f(sod.getA_mobile())%><%-- <%=p.mobile %> --%></td>
	<td align='right'>固定电话</td><td align='left'><%=MT.f(sod.getA_telphone())%></td>
</tr>

<%
if(so.getStatus()==3||so.getStatus()==4||so.getStatus()==7)
{
	ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
	
	if(so.getStatus()==7){
		soe=ShopOrderExpress.findByOrderId(so.getOldorderid());
	} 
	if(soe.time!=null)
	{
%>
<tr style="font-weight:bold;"><td colspan="4" align='left'>发货信息</td></tr>
<tr>
	<td nowrap align='right'>运单号</td><td colspan="3" align='left'><%=MT.f(soe.express_code)%></td>
</tr>
<tr>
	<td nowrap align='right'>销售编号</td><td align='left'><%=MT.f(soe.NO1)%></td>
	<td nowrap align='right'>生产批号</td><td align='left'><%=MT.f(soe.NO2)%></td>
</tr>
<tr>
	<td nowrap align='right'>发货日期</td><td align='left'><%=MT.f(soe.time)%></td>
	<%
		if(Config.getInt("junan")!=mypuid){
	%>
	<td nowrap align='right'>有效期</td><td align='left'><%=MT.f(soe.vtime)%></td>
	<%
		}
	%>

</tr>
<tr>
	<td nowrap align='right'>发件人</td><td align='left'><%=MT.f(soe.person)%></td>
	<td nowrap align='right'>联系电话</td><td align='left'><%=MT.f(soe.mobile)%></td>

</tr>
	<%
		if(MT.f(soe.express_img).length()>0){

			String imgsr = "";
			if(MT.f(soe.express_img).length()>0){
				String[] imgarr=soe.express_img.split(",");
				for(int i=0;i<imgarr.length;i++){
					Attch attch=Attch.find(Integer.parseInt(imgarr[i]));
					imgsr=attch.path;
				}
			}

			out.print("<tr><td nowrap align='right'>快递图片：</td><td align='left' colspan='3'><img src='"+imgsr+"' width='300px' height='300px' ></td></tr>");
		}

	%>
<%
	}
}
%>
<%
if(aur.getRole().indexOf("14122306") < 0&&aur.getRole().indexOf("18011995") < 0){
%>
<tr style="font-weight:bold;"><td colspan="4" align='left'>发票信息</td>
<tr>
	<td >开票厂商</td><td align='left' colspan="3">
	<% 
	out.print(ProcurementUnit.findName(so.getPuid()));
	%></td>
</tr>
</tr>
<%

	ShopOrderExpress seo=ShopOrderExpress.findByOrderId(orderId);
	//发票单号
	String invoiceno="";
	//发票快递单号
	String kuaidino="";
	List<InvoiceData> lstidata=InvoiceData.find(" and orderid="+DbAdapter.cite(orderId), 0, Integer.MAX_VALUE);
	
	for(int i=0;i<lstidata.size();i++){
		InvoiceData idata=lstidata.get(i);
		int invoiceid=idata.getInvoiceid();
		Invoice invoice=Invoice.find(invoiceid);
		String ino=invoice.getInvoiceno();
		String kd=invoice.getCourierno();
		
		%>
		<tr>
	<td nowrap align='right'>开票状态</td><td align='left'><%=Invoice.STATUS[invoice.getStatus()] %></td>
	<td nowrap align='right'>发票号</td><td align='left'><%=MT.f(invoice.getInvoiceno())%></td>
</tr>
<tr>
	<td nowrap align='right'>开票数量</td><td align='left'><%=idata.getNum() %></td>
	<td nowrap align='right'>开票金额</td><td align='left'><%=idata.getAmount() %></td>
</tr>
<tr>
	<td nowrap align='right'>快递单号</td><td align='left'><%=MT.f(kd) %></td>
	<td nowrap align='right'>开票单位/发票接收人</td><td align='left'><%=invoice.getHospital()+"/"+invoice.getConsigness() %></td>
</tr>	
	

		<%
	}
}
	
%>



<tr style="font-weight:bold;"><td colspan="4" align='left' style='border:none;padding-top:15px'>订单备注</td></tr>
<tr><td colspan="4" align='left' style='color:red'><%out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></td></tr>
<%-- <%
	if(so.getIshidden()==1){
%> --%>
<tr style="font-weight:bold;"><td colspan="4" align='left' style='border:none;padding-top:15px'>特殊备注</td></tr>
<tr><td colspan="4" align='left' style='color:red'><%out.print(MT.f(so.getRemarks())); %></td></tr>
<%-- <%
	}
%> --%>
</table>

<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act"/>
<%-- <%
	if(so.getIshidden()!=1){
%> --%>
<table id="tablecenter" cellspacing="0">
<tr style="font-weight:bold;"><td colspan="7" align='left'>商品信息</td></tr>
<tr id="tableonetr">
	<td>商品厂商</td>
  <td>商品编号</td>
  <td>商品图片</td>
  <td align='left'>商品名称</td>
	<%
		if(isadmin){
			%>
	<td>商品单价</td>
	<td>开票价格</td>
	<%
		}
	%>
    <td>商品数量</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Profile pf = Profile.find(so.getMember());
  
  //根据订单id查询订单详情信息
  Iterator it=ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE).iterator();
  for(int i=1;it.hasNext();i++)
  {
	  ShopOrderData t=(ShopOrderData)it.next();
	  
	  //判断product_id是否商品的id，如果不是则为套装id；最后产品或套装中的商品存入list中
      int product_id=t.getProductId();
      ShopProduct sp = ShopProduct.find(product_id);
      ShopPackage spage = new ShopPackage(0);
      List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
      if(t.getExpectedActivity()!=0){
    	  tpflag = 1;
      }
      hdstr = MT.f(t.getExpectedActivity());
      tmstr = MT.f(t.getExpectedDelivery());
      String pname = "";
	  if(sp.isExist){
		  pname=sp.name[1];
		  /* if(sp.model_id>0){
			  ShopProductModel spm = ShopProductModel.find(sp.model_id);
			  if(spm.getModel()!=null&&spm.getModel().length()>0){
				  ShopCategory sc = ShopCategory.find(spm.getCategory());
				  pname += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："+spm.getModel()+"】</span>";
			  }
		  } */
		  if(t.getActivity()>0){
			  ShopCategory sc = ShopCategory.find(sp.category);
			  pname += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："+t.getActivity()+"】</span>";
		  }
	  }else{
		  spage = ShopPackage.find(product_id);
		  pname="[套装]"+MT.f(spage.getPackageName());
		  spagePList.add(0,ShopProduct.find(spage.getProduct_id()));
		  String [] sarr = spage.getProduct_link_id().split("\\|");
		  for(int m=1;m<sarr.length;m++){
			  spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
		  }
	  }
	  ProcurementUnit pu = ProcurementUnit.find(sp.puid);
	  out.println("<tr><td>"+MT.f(pu.getName())+"</td>");
	  out.println("<td>");
	  if(sp.isExist)
		  out.println(sp.yucode);
	  out.println("</td>");
	  out.println("<td style='text-align:center'>");
	  if(sp.isExist&&sp.picture!=null&sp.picture.length()>0)
		  out.println("<img src='"+MT.f(sp.getPicture('b'))+"'  onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
	  out.println("</td>");
	  out.println("<td>"+pname);
	  if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals(""))
		  //if(Config.getInt("xinke")==sp.puid){
			  out.println("&nbsp;<span style='color:red;'>【校准时间："+MT.f(t.getCalibrationDate())+"】</span>");
		 // }
	  out.println("</td>");

	  if(isadmin){
		  if(aur.getRole().indexOf("14122306") < 0&&aur.getRole().indexOf("18011995") < 0){
			  if(pf.getMembertype() == 2){
				  if(so.isLzCategory()){
					  out.println("<td style='text-align:center;' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getAgent_price_s(),2)+"</td>");
					  out.println("<td style='text-align:center;' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getAgent_price(),2)+"</td>");
				  }else{
					  out.println("<td style='text-align:center;' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
					  out.println("<td style='text-align:center;' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
				  }
			  }else{
				  out.println("<td style='text-align:center;' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
				  out.println("<td style='text-align:center;' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
			  }
		  }else{
			  out.println("<td style='text-align:right;'><span style='font-size:13px;'></span></td>");
			  out.println("<td style='text-align:right;'><span style='font-size:13px;'></span></td>");
		  }
		   }
		  out.println("<td style='text-align:center;'>"+t.getQuantity()+"</td>");
		  out.println("</tr>");

		  if(!sp.isExist){
			  for(int n=0;n<spagePList.size();n++){
				  ShopProduct s1 = spagePList.get(n);
				  String s1name = s1.getAnchor(h.language);
				  out.println("<tr class='tzP'><td style='text-align:right;'>"+s1.yucode+"</td>");
				  out.println("<td style='text-align:right;'>");
				  if(s1.picture!=null&s1.picture.length()>0)
					  out.println("<a href='/html/folder/14110010-1.htm?product="+s1.product+"' target='_blank'><img src='"+MT.f(s1.getPicture('b'))+"' alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
				  out.println("</td>");
				  out.println("<td style='text-align:right;'>"+s1name+"</td>");
				  out.println("<td style='text-align:right;text-decoration:line-through;'><span style='font-size:13px;'>&yen;</span>"+MT.f(s1.price,2)+"</td>");
				  out.println("<td>&nbsp;</td>");
				  out.println("<td style='text-align:right;'>"+t.getQuantity()+"</td>");
				  out.println("</tr>");
			  }
		  }


  }
  //商品总价改为开票金额
}

if(isadmin){
	%>
	<tr><td colspan="7" class="tagsize" style="text-align: right;">商品总价：<%if(aur.getRole().indexOf("14122306") < 0&&aur.getRole().indexOf("18011995") < 0){ %><span>&yen&nbsp;<%=MT.f((double)price,2)%></span><%} %>
		&nbsp;&nbsp;&nbsp;&nbsp;开票金额：<%if(aur.getRole().indexOf("14122306") < 0&&aur.getRole().indexOf("18011995") < 0){ %><span>&yen&nbsp;<%=price%></span><%} %></td></tr>
		<%
}
out.print("</table>");
        List<ModifyRecord> modifyRecords = ModifyRecord.find(" AND order_id="+Database.cite(so.getOrderId())+" order by modifyTime ",0,Integer.MAX_VALUE);
        if(modifyRecords.size()>0){
%>
	<table id="tablecenter" cellspacing="0">
		<tr style="font-weight:bold;"><td colspan="4" align='left'>订单日志</td></tr>
		<tr id="tableonetr">
			<td>操作人</td>
			<td>时间</td>
			<td>操作类型</td>
			<td>操作内容</td>
		</tr>
		<%
			for (ModifyRecord m: modifyRecords) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
				String format = sdf.format(m.getModifyTime());
			    %>
		<tr>
			<td><%=MT.f(Profile.find(m.getMember()).getMember())%></td>
			<td><%=MT.f(format)%></td>
			<td><%=MT.f(m.getContent())%></td>
			<td><%=MT.f(Profile.find(m.getMember()).getMember())+" "+format+" "+MT.f(m.getContent())+" "+MT.f(m.getContentDetail())%></td>
		</tr>
			<%}
		%>
	</table>
<%
}
if(Config.getInt("junan")==mypuid){
	
	%>
	<table id="tablecenter" cellspacing="0" style="margin-top:10px">
<tr style="font-weight:bold;"><td colspan="4" align='left'>调配信息</td></tr>
<tr>
	<td width="10%" align='right'>是否已调配</td><td align='left'><%= (tpflag==0?"否":"是") %></td>
</tr>
<%
	if(tpflag==1){
		%>
		<tr>
	<td width="10%" align='right'>校准时间</td><td align='left'><%= tmstr %></td>
</tr>
<tr>
	<td width="10%" align='right'>粒子活度</td><td align='left'><%= hdstr %></td></tr>
		<%
	}
%>
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
<%-- <%
	}
%> --%>
<!-- 订单状态为已出库或者已完成时，可以看到上海上传的质检报告 -->
<div>
<%
	int flag=0;//不显示按钮 等于几就显示几个按钮
	int attchval=0;
	StringBuffer strbutton=new StringBuffer();//拼接button里边的参数
	
	if(Config.getInt("tongfu")==so.getPuid()){
		
		String attchstr="";
		int cannum=0;//参数个数
		String button2="";
		if(so.getStatus()==3||so.getStatus()==4){
			ShopOrderExpress express=ShopOrderExpress.findByOrderId(so.getOrderId());
			String img=MT.f(express.images);
			attchstr=img;
			if(img.length()>0){
				String imgs[]=img.split(",");
				cannum=imgs.length;
				
				for(int i=0;i<imgs.length;i++){
					flag++;
					String image=imgs[i];
					attchval=Integer.parseInt(image);
					out.print("<img src='"+Attch.find(Integer.parseInt(image)).path+"'>");
					if(i==imgs.length-1){
						strbutton.append(Attch.find(Integer.parseInt(image)).path);
						//strbutton.append("a");
						/* String aa=strbutton.toString();
						String[] arr=aa.split(",");
						String cans="";
						for(int a=0;a<arr.length;a++){
							
							button2="<button class='btn btn-primary' type='button'  onclick=downatt2('"+arr[0]+"','"+arr[1]+"')>下载质检报告</button>";
						} */
						
					}else{
						strbutton.append(Attch.find(Integer.parseInt(image)).path+",");
						//strbutton.append("b"+",");
						//button2="<button class='btn btn-primary' type='button'  onclick='downatt2()>下载质检报告</button>";
					}
					
					
				}
			}
		}
		
	}
	
	
%>
</div>
<div class="center mt15">
<%
	if(flag>0){
		if(flag==1){
%>
<button class="btn btn-primary" type="button"  onclick="downatt('<%=MT.enc(attchval) %>')">下载质检报告</button>
<%
		}else{
			//out.print(button2);
%>
<button class="btn btn-primary" type="button"  onclick="downatt2('<%=strbutton.toString() %>')">下载质检报告</button>

<%
		}
	}
%>
<button class="btn btn-primary" type="button" onclick="printView('<%=orderId%>')">打印预览</button>
&nbsp;<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button></div>
</form>
<form action="/Attchs.do" name="form3" method="post" target="_ajax">
	<input name="act" type="hidden" value="down" />
	<input name="attch" type="hidden" /></div>
</form>
<script>
function printView(orderId){
	 window.open("/jsp/yl/shop/ShopOrderDatasPrint.jsp?orderId="+orderId);
}
function downatt(num){
		form3.attch.value = num;
		form3.submit();
	}
function downatt2(a){
	

	var arr=a.split(",");
	
	arr.map(function(i){
	    var a = document.createElement('a');
	    a.setAttribute('download','');
	    a.href=i;
	    document.body.appendChild(a);
	    a.click();
	})
}
</script>
</body>
</html>
