<%@page import="util.DateUtil"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
WeiXin wx = WeiXin.find(h.community);
/* String url = "http://" + h.request.getServerName()
+ h.request.getRequestURI(); */
//生成url
StringBuffer surl=request.getRequestURL();
if(request.getQueryString()!=null){
	surl.append("?");
	surl.append(request.getQueryString());
}
String jsUrl=surl.toString();
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
		
		soe.images=h.get("serveridwai");
		soe.set();
		//order.set("status", "-1");//修改订单状态，添加（修改）完成检验报告。
		//发送短信给初审管理员(订单管理员)
		String user = Profile.find(h.member).getMember();


		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+order.getPuid(),0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			if(MT.f(sms.ckcs)!=""){
				List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckcs);
				//if(!"".equals(MT.f(mobiles.toString())))
					//SMSMessage.create("Home", user, mobiles.toString(), h.language, order.getOrderId()+"订单已上传检验报告，请审核！");
			}
			
		}
		out.print("<script>parent.mt.show('操作成功',1,'"+h.get("nexturl")+"')</script>");
		return;
	}
}
ShopOrderExpress seo=ShopOrderExpress.find(soeid);

List<ShopOrderData> sodList = ShopOrderData.find(" AND order_id="+DbAdapter.cite(oid),0,Integer.MAX_VALUE);
ShopOrderData t = sodList.get(0);
ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(oid);
%><!DOCTYPE html><html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/res/jquery-1.11.1.min.js" type="text/javascript"></script>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
</head>
<body>
	<header class="header"><a href="javascript:history.go(-1)"></a>上传质检报告</header>
	
	<form name="form1" action="?" method="post"  target="_ajax" onsubmit="return checked(this)">
		<input type="hidden" name="orderId" value="<%=oid%>"/>
		<input type="hidden" name="soeid" value="<%=soeid%>"/>
		<input type="hidden" name="type" value="<%=type%>"/>
		<input type="hidden" name="act" value="edit"/>
		<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
		<input type="hidden" name="serveridwai" id="serveridwai" value=""/>
		<div class='radiusBox newlist'>
		<!-- 订单基本信息 -->
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
	<!-- 出厂基本信息 -->
		<ul>
	    <li class="bold" data-resourelist="shouhuo" data-slideup="up">出厂信息 <!-- <cite data-button-open="展开" data-button-close="收起">展开</cite> --></li>
		<li><span>销售编号：</span><%=MT.f(seo.NO1)%></li>
		<li><span>生产批号：</span><%=MT.f(seo.NO2)%></li>
	   <!--  <div id="shouhuo-wrapper" style="display:none"> -->
	    <li><span>有效期：</span><%=MT.f(seo.vtime)==""?DateUtil.addMonth(MT.f( order.getCreateDate()), 5):MT.f(seo.vtime)%></li>
	    <li><span>发货日期：</span><%=MT.f(seo.time,1)%></li>
		<li><span>运单号：</span><%=MT.f(seo.express_code)%></li>
		<li><span>发件人：</span><%=MT.f(seo.person)%></li>
		<li><span>联系电话：</span><%=MT.f(seo.mobile)%></li>
		<!-- </div> -->
	</ul>
		
		
		
			<ul class="seachr">
			
				<li class='bold'>上传质检报告</li>
				<%
				if(MT.f(seo.refusereason).length()>0&&order.getStatus()==-3){
			%>
			  
			    <li><span>初审不通过原因</span>
			    <%=MT.f(seo.refusereason) %></li>
			  
			<%		
				}
			%>
			<%
				if(MT.f(seo.fuhereason).length()>0&&order.getStatus()==-4){
			%>
				
			    <li><span>复核不通过原因</span>
			    <%=MT.f(seo.fuhereason) %></li> 
			  
			<%		
				}
			%>
				<li style="text-align:center">
				
					<input type="button" value="选择图片" onclick="fnchoose()">
				&nbsp;
				
				
					<input type="button" value="继续选择图片" onclick="fnchoose()">
				
				<!-- <input type="button" class="ui-btn ui-icon-add ui-corner-all"  onclick="catUpload(this)" value="压缩上传">  -->
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
     
     <div id="canvasDiv2"></div>
     </li>
				<li>
			    	<button type="submit" >提交</button>
			    	<button type="button" onclick="history.back();">返回</button>
			    </li>
			</ul>
		</div>
	</form>
	
<script>

var imgArr=new Array();
var imgTypeArr =new Array();
wx.config(<%=wx.getJsSign(jsUrl,1)%>);

wx.ready(function(){
    // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
	//alert('success');
	
});
wx.error(function(res){
    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
	alert(res.errMsg);
});
function fnchoose(){
	//清空之前的报告
	$("#canvasDiv").html("");
	wx.chooseImage({
		count:9, // 默认9
		sizeType: ['original'], // 可以指定是原图还是压缩图，默认二者都有
		sourceType: ['album'], // 可以指定来源是相册还是相机，默认二者都有
		success: function (res) {
		
			var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
			//alert(localIds);
			uploadimg(localIds);
			
		
		},
		fail: function(res) {
            alert("1:"+res.errMsg);
          },
          complete: function() {
              // complete
              //alert('complete');
            }
		});
}
var serid;
var images=[];
function uploadimg(localIds){
	var localId = localIds.pop();
	wx.uploadImage({
	    localId: localId, // 需要上传的图片的本地ID，由chooseImage接口获得
	    isShowProgressTips: 1, // 默认为1，显示进度提示
	    success: function (res) {
	    	
	        var serverId = res.serverId; // 返回图片的服务器端ID
	        images.push(serverId);
	        if(localIds.length > 0){
	        	uploadimg(localIds);
	        }else{
	        	
	        	fnxia();
	        }
	        
	        
	        
	    },
	    fail: function(res) {
            alert("2:"+res.errMsg);
          },
          complete: function() {
              // complete
              //alert('complete');
            }
          
	});
}
var bendi=[];
var a1=0;
function fnxia(){
	var length1=images.length;
	wx.downloadImage({
		serverId: images[a1], // 需要下载的图片的服务器端ID，由uploadImage接口获得
		isShowProgressTips: 1, // 默认为1，显示进度提示
		success: function (res) {
			a1++;
			//alert("已下载"+a1+"/"+length1);
		//var localId = res.localId; // 返回图片下载后的本地ID
		bendi.push(res.localId);
		if(a1<length1){
			fnxia();
		}else{
			
			fnxia2();
		}
		
		},fail:function(res){
			alert(res.errMsg);
		}
		});
}
var a2=0;
function fnxia2(){
	var length2=bendi.length;
	wx.getLocalImgData({
		localId: bendi[a2], // 图片的localID
		success: function (res) {
			a2++;
		var localData = res.localData; // localData是图片的base64数据，可以用img标签显示
		if(localData.indexOf('data:image')==-1){
			localData="data:image/jgp;base64,"+localData;
		}
		/* if (window.__wxjs_is_wkwebview) { // 如果是IOS，需要去掉前缀
	        localData = localData.replace('jgp', 'jpeg');
	    } else {
	        localData = 'data:image/jpeg;base64,' + localData;
	    } */
		
		
		var image=new Image();
		image.src=localData;
		imgArr.push(image.src);
		imgTypeArr.push(image.type);
		//alert(imgArr.length);
		$("#canvasDiv2").append(image);
		
		if(a2<length2){
			fnxia2();
		}
		
		},fail:function(res){
			alert(res.errMsg);
		}
		});	
}

	mt.focus(form1);
	function checked(a){
		if(mt.check(a)){
			//新加
			catUpload();
			  
				var serveridwai=$("#serveridwai").val();
			if(serveridwai==''){
				mt.show("请上传报告！");
				return false;
			} 
				
			
		}else{
			return false;
		}
	}
	
	function catUpload(){ 
		//alert(imgArr.length);
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
	        	   //alert('att:'+attch);
	        	   str+=attch+",";
	        	   if(a==parseInt(newdata.length-1)){
	        		   $("#serveridwai").val(str);
	        		   alert("压缩上传成功");
	        		   
	        	   }
	           }

	        }  
	    });  
	     

	      
	}  
</script>

</body>
</html>
