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
<%@ page import="util.DateUtil" %>
<%@ page import="java.text.DecimalFormat" %>
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


	int crole= AdminRole.findByName("同辐订单管理员", "Home");//角色
	if(Config.getInt("gaoke")==so.getPuid()){
		crole=AdminRole.findByName("高科订单管理员", "Home");//角色
	}else if(Config.getInt("junan")==so.getPuid()){
		crole=AdminRole.findByName("君安订单管理员", "Home");//角色
	}
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
	ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());

	Profile pf = Profile.find(so.getMember());
%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="/tea/jquery.jqprint-0.3.js" type="text/javascript"></script>
<script src='/tea/yl/mtDiag.js' type="text/javascript"></script>
<script src='/tea/yl/common.js' type="text/javascript"></script>
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
}int aaa = ShopOrderData.findPuid(so.getOrderId());
	int ho_id=0;
	String fwsName ="";
	List<ShopHospital> list1 = ShopHospital.find("AND name=" + DbAdapter.cite(sod.getA_hospital()), 0, Integer.MAX_VALUE);
	for (ShopHospital d : list1) {
		ho_id = d.getId();
	}



	if(ho_id !=0){
		ProcurementUnitJoin pu =  ProcurementUnitJoin.find(aaa,so.getMember(),ho_id);
		fwsName=pu.getCompany();
	}
%>
<div class="pring_instruct" id="_printInfo" >

<table id="tablecenter" cellspacing="0" style="margin-top:10px">
<tr style="font-weight:bold;"><td colspan="4" align='left'>订单信息</td></tr>
<tr>
	<td width="10%" align='right'>服务商</td><td align='left'><%= pf.getMember()  %></td>
	<td width="10%" align='right'>服务商公司名称</td><td align='left'><%= fwsName  %></td>
</tr>
	<tr>
		<td align='right'>下单医院</td><td align='left'><%= sod.getA_hospital() %></td>
	</tr>
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
<input type="hidden" name="orderId" value="<%= orderId%>"/>
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
    <td>商品数量</td>
</tr>
<%
int mysum = 0;
double myactivity =0;
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  //Profile pf = Profile.find(so.getMember());
  
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
			  myactivity = t.getActivity();
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

	  /*if(isadmin){
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
		   }*/
	      mysum = t.getQuantity();
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

out.print("</table>");
	%>
	<input type="hidden" name="activity" value="<%= myactivity%>"/>
</form>
<form name="form3" id="form3">
	<input type="hidden" name="ordercode" value="<%= orderId%>"  />
	<%--<div>
		<table id="tablecenter" cellspacing="0">
			<tr style="font-weight:bold;"><td colspan="6" align='left'>分批信息（批数：<span class="sum">2</span>）</td></tr>
			<tbody>
				<tr>
					<td colspan="5"><b>批号：1</b></td>
				</tr>
			<tr>
				<td>库存批号</td>
				<td>库存质检号</td>
				<td>入库活度</td>
				<td>当前活度（选择时）</td>
				<td>数量</td>
			</tr>
			<tr>
				<td>ye-333</td>
				<td>qe-333</td>
				<td>0.5</td>
				<td>0.46</td>
				<td>90</td>
			</tr>
			<tr>
				<td>ye-333</td>
				<td>qe-333</td>
				<td>0.5</td>
				<td>0.47</td>
				<td>10</td>
			</tr>
			<tr>
				<td colspan="5"><b>批号：2</b></td>
			</tr>
			<tr>
				<td>库存批号</td>
				<td>库存质检号</td>
				<td>入库活度</td>
				<td>当前活度（选择时）</td>
				<td>数量</td>
			</tr>
			<tr>
				<td>ye-333</td>
				<td>qe-333</td>
				<td>0.5</td>
				<td>0.47</td>
				<td>100</td>
			</tr>
			</tbody>
		</table>
	</div>--%>
	<div>
		<%
			String sodbsql = " AND ordercode = "+Database.cite(orderId);
			int sodbcount = ShopOrderDatasBatches.count(sodbsql);
			List<ShopOrderDatasBatches> sodblist = ShopOrderDatasBatches.find(sodbsql,0,Integer.MAX_VALUE);
		%>
		<table id="tablecenter" cellspacing="0">
			<tr style="font-weight:bold;"><td colspan="<%= (so.getAllocate()==0?"6":"7")%>" align='left'>分批信息&nbsp;批数：<span class="sum"><%= sodbcount%></span></td></tr>
			<%

				int mycount = 0;
				mycount = mysum/100;
				int yunum = mysum%100;
				if(yunum>0){
					mycount++;
				}
				if(sodbcount>0){
					for (int i = 0; i < sodblist.size(); i++) {
						ShopOrderDatasBatches sodb1 = sodblist.get(i);

			%>
			<tr id="tableonetr">
				<td>批号：<%= (i+1)%></td>
				<td>产品批号（金蝶）：<%= MT.f(sodb1.getBatchnumber())%></td>
				<td>受订活度：<%= sodb1.getActivity()%></td>
				<td colspan="2">批次数量：<%= sodb1.getNumber()%></td>
			</tr>
			<tr id="tableonetr">
				<td>库存批号</td>
				<td>库存质检号</td>
				<td>入库活度</td>
				<td>当前活度（选择时）</td>
				<td>数量</td>
			</tr>
			<%
							String [] soids = MT.f(sodb1.getSoid(),",").split(",");
						for (int j = 1; j < soids.length; j++) {
							StockOperation so1 = StockOperation.find(Integer.parseInt(soids[j]));
							ProductStock ps1 = ProductStock.find(so1.getPsid());
%>
			<tr>
				<td><%= ps1.getBatch()%></td>
				<td><%= ps1.getQuality()%></td>
				<td><%= ps1.getActivity()%></td>
				<td><%= so1.getActivity()%></td>
				<td><%= (so1.getAmount()+so1.getReserve())%></td>
			</tr>
			<%
						}

				}
			}
			%>
		</table>
	</div>
</div>
<div class="center mt15">
    <button class="btn btn-primary" type="button" onclick="printit()">打印</button>
&nbsp;<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button></div>
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

function mysub(){


	fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=editShopOrderDatasBatches",$("#form3").serialize(),function(data){
		if(data.type>0){
			if(data.type==1){
				mtDiag.show('对不起！您还未登录，登陆后才可提交订单！');
				return;
			}if(data.type==3){
				mtDiag.show('系统异常，请刷新重试！');
				return;
			}
			mtDiag.show('此活度此校准时间库存不足，请重新选择！');
			return;
		}else{

			mtDiag.show('操作成功！',"alert",null,function(index){
				location = form2.nexturl.value;
			});
		}
	});
}

var perce = '<%=pf.membertype==2?"0.03":"0.01" %>';
function findProductStockCount(){
	//mt.show(null,0)
	fn.ajax("/ProductStocks.do?act=findProductStockCount&activity="+form2.activity.value+"&perce="+perce+"&orderId="+form2.orderId.value,"",function(data){
		//mt.send("/ProductStocks.do?act=findProductStockCount&activity="+form2.activity.value+"&perce="+perce+"&expecteddelivery="+form2.expecteddelivery.value+"&orderId="+form2.orderId.value,function(data){
		//mt.close();
		if(data.type>0){
			if(data.type==1){
				//location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
				return;
			}
			mtDiag.close();
			mtDiag.show(data.mes);
			return;
		}else{
			//form1.productstockcount.value = data.count;
			jQuery(".productstockcount").html(data.count);
		}
	});
}
function addbatches(){
	var trstr = "<tr><td><span class=\"num\"></span><input name=\"sid\" type=\"hidden\" value=\"0\"></td><input name=\"activity\" type=\"hidden\" value=\"0.8\"><td><input name=\"number\"><input type=\"hidden\" name=\"soid\" value=\"\"></td><td>待分批</td><td><input type=\"button\" value=\"保存\" class=\"savebut\"  onclick=\"savebat(this)\" /><input type=\"button\" style='display: none' value=\"取消\" class=\"calbut\" onclick=\"calbat(this)\" /><input type=\"button\" class=\"delbut\" onclick=\"delbat(this)\" value=\"删除\" /></tr>";
	$(".babody").append(trstr);
	initbat();
}
function savebat(obj){
	var tr1 = $(obj).parent().parent();
	var batchnumber = $(tr1).find("input[name='batchnumber']").val();
	var soid = $(tr1).find("input[name='soid']").val();
	var number = $(tr1).find("input[name='number']").val();
	var sid = $(tr1).find("input[name='sid']").val();
 	var activity = form2.activity.value;
 	var ordercode = form2.orderId.value;
	fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=editShopOrderDatasBatche","batchnumber="+batchnumber+"&soid="+soid+"&number="+number+"&sid="+sid+"&activity="+activity+"&ordercode="+ordercode,function(data){
		if(data.type>0){
			if(data.type==1){
				mtDiag.show('对不起！您还未登录，登陆后才可提交订单！');
				return;
			}if(data.type==3){
				mtDiag.show('系统异常，请刷新重试！');
				return;
			}
			mtDiag.show('此活度此校准时间库存不足，请调配！');
			return;
		}else{
			var myobj = data.obj;
			mtDiag.show('操作成功！');
			findProductStockCount();
			$(tr1).find("input[name='batchnumber']").val(myobj.batchnumber);
			$(tr1).find("input[name='soid']").val(myobj.soid);
			$(tr1).find("input[name='number']").val(myobj.number);
			$(tr1).find("input[name='sid']").val(myobj.id);
			$(tr1).find(".savebut").hide();
			$(tr1).find(".calbut").show();
		}
	});
}
function calbat(obj){
	var tr1 = $(obj).parent().parent();
	var sid = $(tr1).find("input[name='sid']").val();
	mtDiag.show("是否确认取消？","alert",null,function(index){
		fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=delShopOrderDatasBatche","sid="+sid,function(data) {
			if (data.type > 0) {
				mtDiag.show('系统异常，请刷新重试！');
				return;
			}
			//$(obj).parent().parent().remove();
			mtDiag.show('操作成功！');
			$(tr1).find(".savebut").show();
			$(tr1).find(".calbut").hide();
			findProductStockCount();
		});
		mtDiag.close(index);
	});
}
function delbat(obj){


	var tr1 = $(obj).parent().parent();
	var sid = $(tr1).find("input[name='sid']").val();
	mtDiag.show("是否确认删除？","alert",null,function(index){
		fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=delShopOrderDatasBatche","sid="+sid,function(data) {
			if (data.type > 0) {
				mtDiag.show('系统异常，请刷新重试！');
				return;
			}
			$(obj).parent().parent().remove();
			mtDiag.show('操作成功！');
			findProductStockCount();
		});
		mtDiag.close(index);
	});

	//initbat();
}

function initbat(){
	var thisnum = $(".num").length;

	fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=initbat","num="+thisnum,function(data) {
		var numd = $(".num");
		var batchnumberd = $(".batchnumber");
		for (index in data) {
			$(numd[index]).html(data[index].num);
			$(batchnumberd[index]).val(data[index].code);
		}

	});
	$(".sum").html(thisnum);
}

function printit() {
    $("#_printInfo").jqprint();
}

$(function(){
})
</script>
</body>
</html>
