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

Profile pf = Profile.find(so.getMember());

String nexturl = h.get("nexturl");
//上海管理员  14122306
AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);

int tpflag = 0;
Date expectedDelivery = new Date();
%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<!-- <script src="/jsp/sup/sup.js" type="text/javascript"></script> -->
<script src='/tea/jquery-1.11.1.min.js'></script>
<script src='/tea/yl/mtDiag.js' type="text/javascript"></script>
<script src='/tea/yl/common.js' type="text/javascript"></script>

</head>
<body>
<h1>订单详细</h1>

<%
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
	<td align='right'>当前状态</td><td align='left'><%=MT.f(statusContent) %> —— 签收人：<%=Profile.getMemberByOpenId(so.getSign_user_openid()) %></td>
	<td align='right'>支付方式</td><td align='left'><%out.print(so.getPayType()==1?"在线支付":"公司转账"); %></td>
</tr>

<tr style="font-weight:bold;"><td colspan="4" align='left' style='border:none;padding-top:15px'>订单备注</td></tr>
<tr><td colspan="4" align='left' style='color:red'><%out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></td></tr>
<%-- <%
	if(so.getIshidden()==1){
%> --%>
<tr style="font-weight:bold;"><td colspan="4" align='left' style='border:none;padding-top:15px'>特殊备注</td></tr>
<tr><td colspan="4" align='left' style='color:red'><%out.print(MT.f(so.getRemarks(),"无")); %></td></tr>
<%-- <%
	}
%> --%>
</table>

<form name="form2" id="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId" value="<%= orderId %>"/>
<input type="hidden" name="status"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
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
int quantity = 0;
String mystr = "";
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  
  //根据订单id查询订单详情信息
  Iterator it=ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE).iterator();
  for(int i=1;it.hasNext();i++)
  {
	  ShopOrderData t=(ShopOrderData)it.next();
	  out.print("<input name='dataid' type='hidden' value='"+t.getId()+"' />");
	  //判断product_id是否商品的id，如果不是则为套装id；最后产品或套装中的商品存入list中
      int product_id=t.getProductId();
      ShopProduct sp = ShopProduct.find(product_id);
      ShopPackage spage = new ShopPackage(0);
      List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
      
      if(t.getExpectedActivity()!=0){
    	  tpflag = 1;
      }
      
      String pname = "";
	  if(sp.isExist){
		  pname=sp.getAnchor(h.language);
		  /* if(sp.model_id>0){
			  ShopProductModel spm = ShopProductModel.find(sp.model_id);
			  if(spm.getModel()!=null&&spm.getModel().length()>0){
				  ShopCategory sc = ShopCategory.find(spm.getCategory());
				  pname += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："+spm.getModel()+"】</span>";
			  }
		  } */
		  if(t.getActivity()>0){
			  ShopCategory sc = ShopCategory.find(sp.category);
			  double activityMinmy = 0;
			  double activityMaxmy = 0;
			  //pname += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："+t.getActivity()+"】</span>";
			  if(sp.model_id>0){
	    	    	ShopProductModel spm = ShopProductModel.find(sp.model_id);
	    	    	String activityStr = spm.getModel().replaceAll("[a-zA-Z]","");

	    	    	if(activityStr.contains("[")){
					  activityStr = activityStr.split("\\[")[0];
	    	    	}
	    	    	if(activityStr.indexOf("-")!=-1){
	    	    		String[] activityArr = activityStr.split("-");
	    	    		Double activityMin =  Double.parseDouble(activityArr[0]);
	    	    		Double activityMax =  Double.parseDouble(activityArr[1]);
	    	    		activityMinmy = activityMin;
	    	    		activityMaxmy = activityMax;
	    	    		pname += "&nbsp;<span style='color:red;'>【商品活度："+activityStr+"，需要活度："+t.getActivity()+"】</span>";
	    	    		
	    	    		expectedDelivery = t.getExpectedDelivery();
	    	    		
	    	    		if(tpflag==0){
		    	    		if(so.getAllocatetype()==0){
			    	    		mystr = " <input alt='粒子活度' title='粒子活度范围："+activityStr+"' style='width:50px;' class='activity' name='activity' value='' onkeyup=\"keyupActivity(this)\" onblur=\"blurActivity(this,"+activityMin+","+activityMax+")\" />";
		    	    		}else{
		    	    			mystr = t.getActivity()+"<input name='activity' type='hidden' value='"+t.getActivity()+"' />";
		    	    		}
	    	    		}else{
	    	    			mystr = t.getExpectedActivity()+"<input name='activity' type='hidden' value='"+t.getExpectedActivity()+"' />";
	    	    		}
	    	    			
	    	    		//caliBuff.append(" 粒子活度：<input alt='粒子活度' title='粒子活度范围："+activityStr+"' style='width:50px;' class='activity' name='activity' value='' onkeyup=\"keyupActivity(this)\" onblur=\"blurActivity(this,"+activityMin+","+activityMax+")\" />");
	    	    	}else{
		    	    	//caliBuff.append("<input name='activity' type='hidden' value='0' />");
		    	    }
	    	    }
			  //pname += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："++"】</span>";
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
		  out.println("<img src='"+MT.f(sp.getPicture('b'))+"' onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
	  out.println("</td>");
	  out.println("<td>"+pname);
	  if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals(""))
		  if(Config.getInt("xinke")==sp.puid){
			  out.println("&nbsp;<span style='color:red;'>【校准时间："+MT.f(t.getCalibrationDate())+"】</span>");
		  }
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
	  quantity = t.getQuantity();
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
}

	if(isadmin){
%>
	<tr><td colspan="7" class="tagsize" style="text-align: right;">商品总价：<%if(aur.getRole().indexOf("14122306") < 0&&aur.getRole().indexOf("18011995") < 0){ %><span>&yen&nbsp;<%=MT.f((double)so.getAmount(),2)%></span><%} %>
		&nbsp;&nbsp;&nbsp;&nbsp;开票金额：<%if(aur.getRole().indexOf("14122306") < 0&&aur.getRole().indexOf("18011995") < 0){ %><span>&yen&nbsp;<%=price%></span><%} %></td></tr>
	<%
	}
%>
</table>
<input name='quantity' value='<%= quantity %>' type='hidden' />
<%
if(Config.getInt("junan")==mypuid&&tpflag==1){
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
<table id="tablecenter" cellspacing="0" style="margin-top:10px">
<tr style="font-weight:bold;"><td colspan="4" align='left'>调配信息</td></tr>
<tr>
	<td width="10%" align='right'>是否已调配</td><td align='left'><%= (tpflag==0?"否":"是") %></td>
</tr>
<tr>
	<td width="10%" align='right'>发货时间</td><td align='left'><%
	if(tpflag==0){
		if(so.getAllocatetype()==0){
			out.print(MT.f(so.getCreateDate())+"<input type='hidden' name='expecteddelivery' value='"+MT.f(so.getCreateDate())+"' />");
		}else{
			out.print("<input alt='校准时间' name='expecteddelivery' value='' onchange='findProductStockCount()' onClick='mt.date(this,false,\""+MT.f(new Date())+"\",\"\")' readonly style='width:100px' class='date'/>");
		}
	}else{
		out.print(MT.f(expectedDelivery)+"<input type='hidden' name='expecteddelivery' value='"+MT.f(expectedDelivery)+"' />");
		}
	 %></td>
</tr>
<tr>
	<td width="10%" align='right'>粒子活度</td><td align='left'><%
			out.print(mystr);
	%></td>
	</tr>
	<tr>
	<td width="10%" align='right'>库存</td><td align='left'><div class='productstockcount'></div></td>
</tr>
</table>
<div class="center mt15">
<%
if(tpflag==0){
	out.print("<button class='btn btn-primary' type='button' onclick='mysub()'>确认调配</button>");
}else{
	out.print("<button class='btn btn-primary' type='button' onclick='tpflag()'>重新调配</button>");
}


%>
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



function blurActivity(obj,activityMin,activityMax){
	if(obj.value!=''&&(obj.value<activityMin||obj.value>activityMax)){
		mtDiag.show("活度超出范围 "+activityMin+"-"+activityMax+"！");
		obj.value = activityMin;
		findProductStockCount();
		//console.log(123);
	}
}
function keyupActivity(obj){
	obj.value = obj.value.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
	obj.value = obj.value.replace(/^\./g,""); //验证第一个字符是数字而不是
	obj.value = obj.value.replace(/^[2-9]/g,""); //验证第一个字符是数字而不是
	obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
	obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
	obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数 
	findProductStockCount();
}

var perce = '<%=pf.membertype==2?"0.03":"0.01" %>';
function findProductStockCount(){
	//mt.show(null,0)
	fn.ajax("/ProductStocks.do?act=findProductStockCountBack&activity="+form2.activity.value+"&perce="+perce+"&expecteddelivery="+form2.expecteddelivery.value+"&orderId="+form2.orderId.value,"",function(data){
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
			//console.log(data);
		}
		});
} 


function mysub(){
	
	if(form2.activity.value==''){
		mtDiag.show('请输入调配活度！');
		return;
	}
if(form2.expecteddelivery.value==''){
	mtDiag.show('请输入调配时间！');
	return;
	}
	/* var indexlayer = layer.load(1, {
		  shade: [0.1,'#fff'] //0.1透明度的白色背景
	}); */
	fn.ajax("/ShopOrders.do?act=editallocate",$("#form2").serialize(),function(data){
		//mt.send("/ShopOrders.do?act=editallocate"+$("#form2").serialize(),function(data){
		//layer.close(indexlayer);
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

function tpflag(){
		fn.ajax("/ShopOrders.do?act=reallocate",$("#form2").serialize(),function(data){
			
			if(data.type>0){
				if(data.type==1){
					mtDiag.show('对不起！您还未登录，登陆后才可提交订单！');
					return;
				}
				
			}else{
				mtDiag.show('操作成功！',"alert",null,function(index){
					location.reload();
				});
			}
		});
}

</script>
</body>
</html>
