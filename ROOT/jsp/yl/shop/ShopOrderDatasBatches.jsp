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
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %>
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

String mydate = "";
	ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());

	Profile pf = Profile.find(so.getMember());
%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">

<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
<script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<%--<script src="/tea/mt.js" type="text/javascript"></script>--%>
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
}
%>
<table id="tablecenter" cellspacing="0" style="margin-top:10px">
<tr style="font-weight:bold;"><td colspan="4" align='left'>订单信息</td></tr>
<tr>
	<td width="10%" align='right'>服务商</td><td align='left'><%= pf.getMember()  %></td>
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
  <td >商品图片</td>
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
	  if(sp.isExist&&sp.picture!=null&sp.picture.length()>0){
		  out.println("<a href='/html/folder/14110010-1.htm?product="+sp.product+"' target='_blank'><img src='"+MT.f(sp.getPicture('b'))+"'  onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
	  }
	  out.println("</td>");
	  out.println("<td>"+pname);
	  out.println("</td>");

	      mysum = t.getQuantity();
		  out.println("<td style='text-align:center;'>"+t.getQuantity()+"</td>");
		  out.println("</tr>");

		  out.println("<tr style=\"font-weight:bold;\" ><td colspan='5' align='left' style=\"border:none;padding-top:15px\" >发货时间</td></tr>");
	  	out.print("<tr><td colspan='5'>");
		  if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals("")){
		  	mydate = MT.f(t.getCalibrationDate());
			  out.println("<input name='tid' type='hidden' value='"+t.getId()+"' /><input name='calibrationDate' onfocus=\"WdatePicker({readOnly:true})\"  value='"+MT.f(t.getCalibrationDate())+"' />");
	  }
out.println("</td></tr>");
		  out.print("<tr><td colspan='5'><input type='button' value='保存发货时间' onclick='saveTime()' /></td></tr>");

		  if(!sp.isExist){
			  for(int n=0;n<spagePList.size();n++){
				  ShopProduct s1 = spagePList.get(n);
				  String s1name = s1.name[1];
				  out.println("<tr class='tzP'><td style='text-align:right;'>"+s1.yucode+"</td>");
				  out.println("<td style='text-align:right;'>");
				  if(s1.picture!=null&s1.picture.length()>0)
					  out.println("<img src='"+MT.f(s1.getPicture('b'))+"'  onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
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

<table id="tablecenter" cellspacing="0" style="<%= (so.getAllocate()==0?"display:none;":"")%>">
	<%
		double myactivity1 = myactivity*0.9;

		BigDecimal b   =   new   BigDecimal(myactivity1);
		double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();

		double myactivity2 = myactivity*1.1;

		BigDecimal b1   =   new   BigDecimal(myactivity2);
		double  f2   =   b1.setScale(4,   RoundingMode.HALF_UP).doubleValue();

	%>
	<tr style="font-weight:bold;"><td align='left' colspan="12">调配提醒信息&nbsp;粒子活度（<%= f1%>-<%= f2%>）</td></tr>
	<tr>
		<td width='60'>序号</td>
		<td>产品名称</td>
		<td>质检号</td>
		<td>批号</td>
		<td>检验时间</td>
		<td>入库时间</td>
		<td>入库活度(mCi)</td>
		<td>当前活度(mCi)</td>
		<td>库存数量/支</td>
		<td>预留数量/支</td>
		<td>有效期(天)</td>
		<td>用户占用库存（前台下单）</td>
	</tr>
<tbody class="mytab">

</tbody>

</table>

<form name="form3" id="form3">
	<input type="hidden" name="ordercode" value="<%= orderId%>"  />
	<input type="hidden" name="mysum" value="<%= mysum%>"  />
	<div>
		<table id="tablecenter" cellspacing="0" >
			<tr style="font-weight:bold;"><td colspan="<%= (so.getAllocate()==0?"6":"7")%>" align='left'>分批信息&nbsp;<input type="button" value="新增批数" onclick="addbatches()" /></td></tr>
			<%
				String sodbsql = " AND ordercode = "+Database.cite(orderId);
				int sodbcount = ShopOrderDatasBatches.count(sodbsql);
				List<ShopOrderDatasBatches> sodblist = ShopOrderDatasBatches.find(sodbsql,0,Integer.MAX_VALUE);
				int mycount = 0;
				mycount = mysum/100;
				int yunum = mysum%100;
				if(yunum>0){
					mycount++;
				}
			%>
				<tr><td >批数：<span class="sum"><%= (sodbcount==0?mycount:sodbcount)%></span></td>
				<%
					if(so.getAllocate()==0) {//不调配
						out.print("<td>受订活度："+myactivity+"</td><td>库存：<span class='productstockcount'></span></td>");
					}
				%>
				</tr>
				<tr>
					<td>序号</td>
					<td>产品批号（金蝶）</td>
					<%
						if(so.getAllocate()==0){//不调配

						}else{
							%>
					<td>受订活度</td>
					<td>库存数量</td>
					<%
						}
					%>
					<td>分批数量</td>
					<td>分批状态</td>
					<td>操作</td>
				</tr>
			<tbody class="babody">
			<%
				if(sodbcount>0){
					for (int i = 0; i < sodblist.size(); i++) {
						ShopOrderDatasBatches sodb1 = sodblist.get(i);
				%>
				<tr>
					<td><span class="num"><%= (i+1)%></span><input name="sid"  type="hidden" value="<%= MT.f(sodb1.getId()) %>" /></td>
					<td><input name="batchnumber"  class="batchnumber"  value="<%= MT.f(sodb1.getBatchnumber())%>" /></td>

					<%
						if(so.getAllocate()==0){//不调配
							out.print("<input class='activity' name='activity' type='hidden' value='"+MT.f(sodb1.getActivity())+"' />");
						}else{
							out.print("<td><input class='activity' disabled=\"disabled\" name='activity' onkeyup='keyupActivity(this)' value='"+MT.f(sodb1.getActivity())+"' /></td>");
							out.print("<td><span class='number'>0</span></td>");
						}
					%>
					<td><input name="number" disabled="disabled" value="<%= MT.f(sodb1.getNumber())%>" /><input type="hidden" name="soid" value="<%= MT.f(sodb1.getSoid())%>" /></td>
					<td><span class="status">已分批</span></td>
					<td><input type="button" value="保存" class="savebut" style='display: none' onclick="savebat(this)" /><input type="button" value="取消" class="calbut" onclick="calbat(this)" /><input type="button" class="delbut" onclick="delbat(this)" value="删除" /></td>
				</tr>
				<%
					}
				}else{
					String myyear = DateUtil.getSysYear();
					String myyearstr = myyear.substring(2,4);
						for (int i = 0; i < mycount; i++) {
				%>
			<tr>
				<td><span class="num"><%= (i+1)%></span><input name="sid"  type="hidden" value="0" /></td>
				<td><input name="batchnumber" class="batchnumber" value="" /></td>
				<%
					if(so.getAllocate()==0){//不调配
						out.print("<input name='activity' type='hidden' value='"+myactivity+"' />");
					}else{
						out.print("<td><input name='activity' onkeyup='keyupActivity(this)' onblur='findProductStockCountTp(this)' /></td>");
						out.print("<td><span class='number'>0</span></td>");
					}
				%>
				<td><input name="number" /><input type="hidden" name="soid" value="" /></td>
				<td><span class='status'>待分批</span></td>
				<td><input type="button" value="保存" class="savebut"  onclick="savebat(this)" /><input type="button" value="取消" class="calbut" style='display: none' onclick="calbat(this)" /><input type="button" class="delbut" onclick="delbat(this)" value="删除" /></td>
			</tr>
			<%
						}
					}
			%>
			</tbody>
		</table>
		<%
			if(Config.getInt("junan")==mypuid){
				List<StockOperation> solist = StockOperation.find(" AND oid = "+so.getId()+" AND type = 0  AND isRetreat = 0 ",0, Integer.MAX_VALUE);

		%>
		<table id="tablecenter" class="showck" style="display: none;" cellspacing="0" >
			<tr style="font-weight:bold;"><td colspan="6" align='left'>占用库存信息</td></tr>
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
	</div>
<div class="center mt15">
	<button class="btn btn-primary" type="button" onclick="showkc()" >查看库存占用</button>&nbsp;
	<button class="btn btn-primary" type="button" onclick="mysubph()" >保存批号</button>&nbsp;
&nbsp;<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button></div>
</form>
<form name="form1" id="form1"  method="post" >
	<input type="hidden" name="activity1" value="<%= f1%>"/>
	<input type="hidden" name="activity2" value="<%= f2%>"/>
	<input type="hidden" name="mydate" value="<%= mydate%>"/>
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
			mtDiag.show('此活度此发货时间库存不足，请重新选择！');
			return;
		}else{

			mtDiag.show('操作成功！',"alert",null,function(index){
				location = form2.nexturl.value;
			});
		}
	});
}

function mysubph(){


	fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=editShopOrderDatasBatchesph",$("#form3").serialize(),function(data){
		if(data.type>0){
			if(data.type==1) {
				mtDiag.show('对不起！您还未登录，登陆后才可提交订单！');
				return;

			}
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
	fn.ajax("/ProductStocks.do?act=findProductStockCountBack&activity="+form2.activity.value+"&perce="+perce+"&orderId="+form2.orderId.value,"",function(data){
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

function findProductStockCountTp(obj){
    var activity = $(obj).val();
    //mt.show(null,0)调整为查看前台占用
    fn.ajax("/ProductStocks.do?act=findProductStockCount&activity="+activity+"&perce="+perce+"&orderId="+form2.orderId.value+"&expecteddelivery="+form2.calibrationDate.value,"",function(data){
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
            console.log(data.count+"==");
            $(obj).parent().parent().find(".number").html(data.count);
        }
    });
}

var trstr = "";
<%
if(so.getAllocate()==0){
    %>
trstr = "<tr><td><span class=\"num\">1</span><input name=\"sid\" type=\"hidden\" value=\"0\"></td><td><input name=\"batchnumber\" class=\"batchnumber\" value=\"\"></td><input name=\"activity\" type=\"hidden\" value=\"<%= myactivity%>\"><td><input name=\"number\"><input type=\"hidden\" name=\"soid\" value=\"\"></td><td><span class=\"status\">待分批</span></td><td><input type=\"button\" value=\"保存\" class=\"savebut\" onclick=\"savebat(this)\"><input type=\"button\" value=\"取消\" class=\"calbut\" style=\"display: none\" onclick=\"calbat(this)\"><input type=\"button\" class=\"delbut\" onclick=\"delbat(this)\" value=\"删除\"></td></tr>";
<%
}else{
    %>
trstr = "<tr><td><span class=\"num\">1</span><input name=\"sid\" type=\"hidden\" value=\"0\"></td><td><input name=\"batchnumber\" class=\"batchnumber\" value=\"\"></td><td><input name=\"activity\" onkeyup=\"keyupActivity(this)\" onblur=\"findProductStockCountTp(this)\"></td><td><span class=\"number\">0</span></td><td><input name=\"number\"><input type=\"hidden\" name=\"soid\" value=\"\"></td><td><span class='status'>待分批</span></td><td><input type=\"button\" value=\"保存\" class=\"savebut\" onclick=\"savebat(this)\"><input type=\"button\" value=\"取消\" class=\"calbut\" style=\"display: none\" onclick=\"calbat(this)\"><input type=\"button\" class=\"delbut\" onclick=\"delbat(this)\" value=\"删除\"></td></tr>";
<%
}
%>

function addbatches(){
	$(".babody").append(trstr);
	initbat();
}
function savebat(obj){
	var tr1 = $(obj).parent().parent();
	var batchnumber = $(tr1).find("input[name='batchnumber']").val();
	var soid = $(tr1).find("input[name='soid']").val();
	var number = $(tr1).find("input[name='number']").val();
	var sid = $(tr1).find("input[name='sid']").val();
 	var activity = $(tr1).find("input[name='activity']").val();
 	var ordercode = form2.orderId.value;
 	if(number==""){
		mtDiag.show('请输入订货数量！');
		return;
	}
	if(number=="0"){
		mtDiag.show('请输入正确订货数量！');
		return;
	}

	var mysuminput = 0;
	var numbers = $("input[name='number']");
	for(var i=0;i<numbers.length;i++){
		mysuminput += parseInt(numbers[i].value);
	}
	//console.log(mysum+"==");
	var mysum = form3.mysum.value;
	if(mysuminput>mysum){
		mtDiag.show('总数量不能超过订货数量！');
		return;
	}


	fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=editShopOrderDatasBatche","batchnumber="+batchnumber+"&soid="+soid+"&number="+number+"&sid="+sid+"&activity="+activity+"&ordercode="+ordercode,function(data){
		if(data.type>0){
			if(data.type==1){
				mtDiag.show('对不起！您还未登录，登陆后才可提交订单！');
				return;
			}if(data.type==3){
				mtDiag.show('系统异常，请刷新重试！');
				return;
			}
			mtDiag.show('此活度此发货时间库存不足，请调配！');
			return;
		}else{
			var myobj = data.obj;
			mtDiag.show('操作成功！');
			findProductStockCount();
			$(tr1).find("input[name='batchnumber']").val(myobj.batchnumber);
			$(tr1).find("input[name='soid']").val(myobj.soid);
			$(tr1).find("input[name='number']").val(myobj.number);
			$(tr1).find("input[name='sid']").val(myobj.id);
			$(tr1).find(".status").html("已分批");
			$(tr1).find(".savebut").hide();
			$(tr1).find(".calbut").show();

			$(tr1).find("input[name='activity']").attr("disabled",true);
			$(tr1).find("input[name='number']").attr("disabled",true);

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
			$(tr1).find(".status").html("待分批");
			$(tr1).find("input[name='number']").val("0");
			$(tr1).find("input[name='sid']").val("0");
			$(tr1).find("input[name='number']").attr("disabled",false);
			$(tr1).find("input[name='activity']").attr("disabled",false);
			findProductStockCount();
		});
		mtDiag.close(index);
	});
}
function delbat(obj){


	var tr1 = $(obj).parent().parent();
	var sid = $(tr1).find("input[name='sid']").val();
	if(sid!="0"){
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
    }else{
        $(obj).parent().parent().remove();
        mtDiag.show('操作成功！');
        initbat();
    }

	//initbat();
}

function initbat(){
	var thisnum = $(".num").length;

	fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=initbat","num="+thisnum,function(data) {
		var numd = $(".num");
		var batchnumberd = $(".batchnumber");
		for (index in data) {
			$(numd[index]).html(data[index].num);
			$(batchnumberd[index]).val();
		}

	});
	$(".sum").html(thisnum);
}


function keyupActivity(obj){
	obj.value = obj.value.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
	obj.value = obj.value.replace(/^\./g,""); //验证第一个字符是数字而不是
	obj.value = obj.value.replace(/^[2-9]/g,""); //验证第一个字符是数字而不是
	obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
	obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
	obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数

}

$(function(){
	findProductStockCount();
	if(<%= sodbcount>0?"false":"true"%>){
		initbat();
	}
})

	function saveTime(){
		mtDiag.show("您确定要改成此发货时间吗？","confirm",function(){
			fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=saveTime&calibrationDate="+form2.calibrationDate.value+"&tid="+form2.tid.value+"&activity="+form2.activity.value,"",function(data) {
				if (data.type == 2 ) {
					mtDiag.show("此活度此发货时间库存不足，是否改为手动调配订单？","confirm",function(){
						fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=updateAllocate&tid="+form2.tid.value+"&calibrationDate="+form2.calibrationDate.value+"&type=1","",function(data) {
							if (data.type == 0) {
								layer.alert('操作成功！', function(index){
									location.reload();
								});
							}else{
								mtDiag.show(data.mes);
								return;
							}
						});
					},function(){
						mtDiag.show('请手动取消订单！');
						return;
					});
					return;
				}else{
					fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=updateAllocate&tid="+form2.tid.value+"&calibrationDate="+form2.calibrationDate.value+"&type=0","",function(data) {
						if (data.type == 0) {
							layer.alert('操作成功！', function(index){
								location.reload();
							});
						}else{
							mtDiag.show(data.mes);
							return;
						}
					});
				}
			});
			//mtDiag.show("删除成功!","msg");
		},function(){
			//mtDiag.show("取消删除!");
		});
	}


function loadlist(pos){
	mypos = pos;
	var listtb = new page.loadPage({"url":"/ProductStocks.do?act=findPSList&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'20','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
	listtb.show();
}
loadlist(0);


function createList(resultlist){

	var listDiv = $(".mytab");
	listDiv.html("");
	if(resultlist.data_list!=''){//是否存在数据
		for(var i=0;i<resultlist.data_list.length;i++){
			var proObj = resultlist.data_list[i];
			var boxDiv = $("<tr></tr>");
			var $name = $("<td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>放射性碘 I-125 粒子</td><td>"+proObj.obj.quality+"</td><td>"+proObj.obj.batch+"</td><td>"+proObj.obj.createtime+"</td><td>"+proObj.obj.time+"</td><td>"+proObj.obj.activity+"</td><td>"+proObj.pow+"</td><td>"+proObj.obj.amount+"</td><td><input type=number name=reserve min=0 onchange=mya(this,'"+proObj.obj.psid+"','"+proObj.obj.amount+"','"+proObj.obj.reserve+"') value="+proObj.obj.reserve+"  style='width:60px;border:none'/></td><td>"+proObj.validity+"</td><td>"+proObj.obj.ordernum+"</td>");
			boxDiv.append($name);
			listDiv.append(boxDiv);
		}

	}else{
		listDiv.append("<tr><td colspan='12' style='text-align:center'>暂无库存</td></tr>");
	}

}
function showkc(){
	$(".showck").show();
}
</script>
</body>
</html>
