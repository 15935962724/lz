<%@page import="util.DateUtil"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.*"%>
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

	if(request.getMethod().equals("POST")){
		if("edit".equals(act)){
			ShopOrderExpress soe=ShopOrderExpress.find(soeid);
			soe.express_code=h.get("express_code","");
			soe.express_name=h.get("express_name","");
			soe.mobile=h.get("mobile","");
			soe.order_id=h.get("order_id","");
			soe.person=h.get("person","");
			soe.price=BigDecimal.valueOf(h.getDouble("price"));
			soe.time=h.getDate("time");
			soe.type=type;
			soe.NO1=h.get("NO1","");
			soe.NO2=h.get("NO2","");
			soe.vtime=h.getDate("vtime");
			soe.images=h.get("serveridwai");
			soe.express_img = h.get("express_img");
			soe.set();
			ShopOrder so=ShopOrder.findByOrderId(h.get("order_id",""));

			if(Config.getInt("tongfu")==so.getPuid()){
				if(so.getStatus()==-3||so.getStatus()==-4){
					//改变订单状态为：等待初审

					so.set("status", "-1");
					//修改出厂信息 通知初审管理员
					//给初审管理员发送短信
					String user = Profile.find(h.member).getMember();
					ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
					if(list.size() > 0){
						ShopSMSSetting sms = list.get(0);
						if(MT.f(sms.ckcs)!=""){
							List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckcs);
							if(!"".equals(MT.f(mobiles.toString())))
								SMSMessage.create("Home", user, mobiles.toString(), h.language, "订单"+so.getOrderId()+"已修改出厂信息，请审核！");
						}
					}


				}
				if(so.getStatus()==2){
					//添加出厂信息 通知上海质检员
					//给质检员发送短信提示上传检验报告
					String user = Profile.find(h.member).getMember();
					int mypuid = order.getPuid();//默认开票单位
					//查看开票单位 不是同辐
					if(Config.getInt("tongfu")==order.getPuid()){
						mypuid = ShopOrderData.findPuid(so.getOrderId());
					}

					ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+mypuid,0,1);
					//ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
					if(list.size() > 0){
						ShopSMSSetting sms = list.get(0);
						if(MT.f(sms.sczjbg)!=""){
							List<String> mobiles = ShopSMSSetting.getUserMobile(sms.sczjbg);
							if(!"".equals(MT.f(mobiles.toString())))
								SMSMessage.create("Home", user, mobiles.toString(), h.language, "订单"+so.getOrderId()+"请上传检验报告！");
						}
					}
				}
			}else{
				so.set("status", "-5");
			}




			out.print("<script>parent.mt.show('操作成功',1,'"+h.get("nexturl")+"')</script>");
			return;
		}else if("uploadjian".equals(act)){
			String[] attcharr=h.getValues("images.attch");
		/* String showimg = ""; // 显示的图片

		String servierid = ""; // 服务id
		if(attcharr.length>0){
			for(int i=0;i<attcharr.length;i++){

				int iatt=Integer.parseInt(attcharr[i]);
				showimg+=","+Attch.find(iatt).path;
				servierid+=","+attcharr[i];
			}
		}

		out.print("<script>var mt=parent.mt;mt.value3('" + showimg+ "','" + servierid + "')</script>");
 */
			return;
		}

	}
ShopOrderExpress seo=ShopOrderExpress.find(soeid);
%><!DOCTYPE html><html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

<script src="/tea/mt.js" type="text/javascript"></script>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<script src="/tea/jquery.js" type="text/javascript"></script>

</head>
<body>
	<header class="header"><a href="javascript:history.go(-1)"></a>添加出厂信息</header>
	
	<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return checked(this)">
		<input type="hidden" name="order_id" value="<%=oid%>"/>
		<input type="hidden" name="soeid" value="<%=soeid%>"/>
		<input type="hidden" name="type" value="<%=type%>"/>
		<input type="hidden" name="act" value="edit"/>
		<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
		<input type="hidden" name="serveridwai" id="serveridwai" value="<%=MT.f(seo.images) %>"/>
		<input type="hidden" name="express_img" id="express_img" value="<%=MT.f(seo.express_img) %>"/>
		
		<div class='radiusBox newlist'>
		<ul id="tablecenter" >
	<li class="bold" data-resourelist="xinxi" data-slideup="up">订单信息 <!-- <cite data-button-open="展开" data-button-close="收起">展开</cite> --></li>
	<li><span>订单编号：</span><%=MT.f(order.getOrderId()) %></li>
	<li><span>下单时间：</span><%=MT.f(order.getCreateDate(),1) %></li>
	<!-- <div id="xinxi-wrapper"style="display:none"> -->
	<%
	
	  	Profile pf = Profile.find(order.getMember());
	  	//根据订单id查询订单详情信息
	  	List<ShopOrderData> sodList = ShopOrderData.find(" AND order_id="+DbAdapter.cite(order.getOrderId()),0,Integer.MAX_VALUE);
		ShopOrderData t = sodList.get(0);
      	out.println("<li><span>粒子活度：</span>"+t.getActivity()+" X "+ t.getQuantity() +"</li>");
      	//out.println("<li><span>购买数量：</span>"+t.getQuantity()+"</li>");
      	out.println("<li><span>校准时间：</span>"+MT.f(t.getCalibrationDate())+"</li>");

	%>
	<%if(order.getStatus()==5){%>
	<li><span>取消原因：</span><%=MT.f(order.getCancelReason()) %></li>
	<%}%>
	<!-- </div> -->
	</ul>
	 <ul>
		<li class="bold" data-resourelist="beizhu" data-slideup="up">订单备注 </li>
	   
			<li style="color:red"><%out.print(order.getUserRemarks()==null||order.getUserRemarks().length()<1?"无":MT.f(order.getUserRemarks())); %></li>
	    
	</ul>


		<ul>
			<li>
				<%

					String NO1str = "";
					String NO2str = "";
					int mypuid = ShopOrderData.findPuid(order.getOrderId());
					if(Config.getInt("junan")==mypuid){

						List<StockOperation> solist = StockOperation.find(" AND oid = "+order.getId()+" AND type = 5 AND isRetreat = 0 ",0, Integer.MAX_VALUE);

				%>
				<table id="tdbor" cellspacing="0" class="newTable">
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
								if(i>0){
									NO1str+=",";
									NO2str+=",";
								}
								NO1str+=pss.getQuality();
								NO2str+=pss.getBatch();
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

			</li>

		</ul>

			<ul class="seachr">
				<li class='bold'>添加/编辑</li>
				<%
					if(Config.getInt("gaoke")!=mypuid){
					%>
				<li><span><%
					if(Config.getInt("junan")!=mypuid){
						out.print("销售编号");
					}else{
						out.print("质检号");
					}
				%>：</span><input type="text" alt="销售编号" placeholder="请输入销售编号" name="NO1" value="<%

	    if(Config.getInt("junan")==mypuid){
				if(seo.id==0){
				out.print(MT.f(NO1str));
			}else{
				out.print(MT.f(seo.NO1));
			}
	    }else{
	    	out.print(MT.f(seo.NO1));
	    }

	    %>"></li>
				<%
					}
				%>

				<li><span>生产批号：</span><input type="text" alt="生产批号" name="NO2"  placeholder="请输入生产批号"value="<%

	    if(Config.getInt("junan")==mypuid){
				if(seo.id==0){
				out.print(MT.f(NO2str));
			}else{
				out.print(MT.f(seo.NO2));
			}
	    }else{
	    	if(Config.getInt("gaoke")==mypuid){//高科自动生成
				if(seo.id==0){
out.print(DateUtil.getLongCalendar());
				}else{
					out.print(MT.f(seo.NO2));
				}
	    	}else{
	    		out.print(MT.f(seo.NO2));
	    	}

	    }

	    %>"></li>
				<%
					if(Config.getInt("junan")!=mypuid) {
						int moon = 6;
						if (Config.getInt("gaoke") == mypuid) {//高科两个月
							moon = 2;
						}
						%>
				<li><span>有效期：</span><input type="date" alt="有效期" placeholder="请输入有效期" name="vtime" value="<%=MT.f(seo.vtime)==""?DateUtil.addMonth(MT.f( order.getCreateDate()), moon):MT.f(seo.vtime)%>"></li>
				<%
					}
					Date tptime = null;
					if(Config.getInt("junan")==mypuid){
						tptime = t.getExpectedDelivery();
					}
				%>

				<li><span>发货日期：</span><input type="date" alt="发货日期" placeholder="请输入发货日期" name="time" value="<%
    if(tptime!=null){
    	out.print(MT.f(tptime,1));
    }else{
    	out.print(MT.f(seo.time,1));
    }

    String person = MT.f(seo.person);
  	String mobile = MT.f(seo.mobile);

  	if(seo.id==0){
  		//信息改为商品厂商
  		ProcurementUnit pu = ProcurementUnit.find(ShopOrderData.findPuid(order.getOrderId()));
  		person = MT.f(pu.person);
  		mobile = MT.f(pu.mobile);
  	}
    %>"></li>

				<li><span>快递单号：</span><input type="text" <%
    int sdpuid = ShopOrderData.findPuid(order.getOrderId());
		if(Config.getInt("gaoke")!=sdpuid){
			out.print("alt=\"快递单号\"");
		}
    %> placeholder="请输入快递单号" name="express_code" value="<%=MT.f(seo.express_code)%>"></li>

				<li><span>发件人：</span><input type="text" placeholder="发件人" name="person" alt="发件人" value="<%= person %>"></li>

				<li><span>联系电话：</span><input type="text" placeholder="联系电话" name="mobile" value="<%= mobile%>"></li>
				<%
					if(Config.getInt("junan")==mypuid){
				%>
				<li><span>上传快递单号照片</span>
						<input id="fileToUpload" type="file" name="fileToUpload" accept="image/*" multiple="multiple">
						<!-- <input type="button" class="ui-btn ui-icon-add ui-corner-all"  onclick="catUpload(this)" value="压缩上传">  -->
						<div id="canvasDiv" >
							<%
								if(MT.f(seo.express_img).length()>0){
									String[] imgarr=seo.express_img.split(",");
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
				<%
					}


					if(Config.getInt("tongfu")==order.getPuid()){

				  	if(order.getStatus()==-3||order.getStatus()==-4){
				%>
				<li><span>质检报告：</span>
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
		<%
		  	}

			}
		if(order.getStatus()==-3&&MT.f(seo.refusereason).length()>0){
		%>
		<li><span>初审拒绝原因：</span><%=MT.f(seo.refusereason) %></li>
		<%
		}
		if(order.getStatus()==-4&&MT.f(seo.fuhereason).length()>0){
		%>
		<li><span>复核拒绝原因：</span><%=MT.f(seo.fuhereason) %></li>
		<%
		}
		%>
		<li>
			    	<button type="submit">提交</button>
			    	<button type="button" onclick="history.back();">返回</button>
			    </li>
			</ul>
		</div>
	</form>
	
<script>
	mt.focus(form1);
	function checked(a){
		if(mt.check(a)){
			var mobile=form1.mobile.value;
			if(mobile.length==0){
				mt.show("电话不能为空");
				form1.mobile.focus();
				return false;
			}
			/*var reg=/^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$)/;
			if(!reg.test(form1.mobile.value)){
				mt.show("电话格式不正确");
				form1.mobile.focus();
				return false;
			}
			*/
			//新加
			catUpload();
		}else{
			return false;
		}
	}

	var imgTypeArr = new Array();
	var imgArr = new Array();
	var isHand = 0;//1正在处理图片
	var nowImgType = "image/jpeg";
	var jic = {
		compress: function(source_img_obj,imgType){
			//alert("处理图片");
			source_img_obj.onload = function() {
				var cvs = document.createElement('canvas');
				//naturalWidth真实图片的宽度
				console.log("原图--"+this.width+":"+this.height);

				var scale = 1;
				if(this.width > 1600 || this.height > 1600){
					if(this.width > this.height){
						scale = 1600 / this.width;
					}else{
						scale = 1600 / this.height;
					}
				}
				cvs.width = this.width*scale;
				cvs.height = this.height*scale;

				var ctx=cvs.getContext("2d");
				ctx.drawImage(this, 0, 0, cvs.width, cvs.height);
				var newImageData = cvs.toDataURL(imgType, 0.8);
				base64Img = newImageData;
				imgArr.push(newImageData);
				var img = new Image();
				img.src = newImageData;
				$(img).css('width',100+'px');
				$(img).css('height',100+'px');
				$("#canvasDiv").append(img);
				isHand = 0;

			}

		}
	}
	$(function(){
		document.getElementById('fileToUpload').addEventListener('change', handleFileSelect, false);

	});
	function handleFileSelect (evt) {

		isHand = 1;
		imgArr = [];
		imgTypeArr = [];
		$("#canvasDiv").html("");
		var files = evt.target.files;
		for (var i = 0, f; f = files[i]; i++) {
			// Only process image files.
			if (!f.type.match('image.*')) {
				continue;
			}
			imgTypeArr.push(f.type);
			nowImgType = f.type;
			var reader = new FileReader();
			// Read in the image file as a data URL.
			reader.readAsDataURL(f);
			// Closure to capture the file information.
			reader.onload = (function(theFile) {
				return function(e) {
					var i = new Image();
					i.src = e.target.result;
					jic.compress(i,nowImgType);

				};
			})(f);

		}

	}
	function catUpload(){
		var str="";
		$.ajax({
			type : "POST",
			url : "/CompressImg.do",
			async:false,
			traditional:true,
			data : {
				'img' : imgArr,
				'type' : imgTypeArr
			},
			dataType:"json",
			contentType:"application/x-www-form-urlencoded;charset=utf-8",
			success : function(data) {
				var newdata=eval(data);
				for(var a=0;a<newdata.length;a++){
					var attch=newdata[a].attch;

					str+=attch+",";
					if(a==parseInt(newdata.length-1)){
						$("#express_img").val(str);
						alert("压缩上传成功");


						//alert("jieguo"+m);
					}
				}

			}

		});
	}

</script>

</body>
</html>
