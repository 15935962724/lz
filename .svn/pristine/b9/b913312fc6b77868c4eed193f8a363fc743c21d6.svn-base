<%@page import="util.DateUtil"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
/*if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}*/
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
		order.set("status", "-1");//修改订单状态，添加（修改）完成检验报告。
		//发送短信给初审管理员(订单管理员)
		String user = Profile.find(h.member).getMember();
		
		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+order.getPuid(),0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			if(MT.f(sms.ckcs)!=""){
				List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckcs);
				if(!"".equals(MT.f(mobiles.toString())))
					SMSMessage.create("Home", user, mobiles.toString(), h.language, order.getOrderId()+"订单已上传检验报告，请审核！");
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
				<li>
				<div id="canvasDiv2" ></div>
				<span style="width:240px;margin:30px auto;">
					<input id="fileToUpload" type="file" name="fileToUpload" accept="image/*" >
				</span>
				
				<!-- <input type="button" class="ui-btn ui-icon-add ui-corner-all"  onclick="catUpload()" value="压缩上传">  -->
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
				<li style="margin:30px auto;">
			    	<button type="submit" >提交</button>
			    	<button type="button" onclick="history.back();">返回</button>
			    </li>
			</ul>
		</div>
	</form>
	
<script>
$(".radiusBox ul .bold").on("click", function () {
	
    $list = $(this).attr("data-resourelist");
    if ($(this).attr("data-slideup")) {
        $(".radiusBox ul div#" + $list + "-wrapper").slideDown();
        //$("span", this).css("background-image", "url(/furniture/icon-close-dark.png)");
        $("cite", this).html($("cite", this).attr("data-button-close"));
        $(this).removeAttr("data-slideup")
    } else {
        $(this).attr("data-slideup", "up");
        $(".radiusBox ul div#" + $list + "-wrapper").slideUp();
        //$("dfn", this).css("background-image", "url(" + $path + "furniture/icon-open-dark.png)");
        $("cite", this).html($("cite", this).attr("data-button-open"))
    } 
});
	mt.focus(form1);
	var str2="";
	function checked(a){
		if(mt.check(a)){
			$("#serveridwai").val(str2);
			
			  
				var serveridwai=$("#serveridwai").val();
			if(serveridwai==''){
				mt.show("请上传报告！");
				return false;
			} 
				
			
		}else{
			return false;
		} 
		/* alert(str2);
		return false; */
	}
</script>
<script>
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
                
                var img = new Image();  
                img.src = newImageData;  
                $(img).css('width',300+'px');  
                $(img).css('height',300+'px');  
                $("#canvasDiv2").append(img);  
                //alert("image");
               catUpload2(newImageData);
  				
                isHand = 0;  
              
            }  
          
        }  
}  
$(function(){  
    document.getElementById('fileToUpload').addEventListener('change', handleFileSelect, false);  
    
      
}); 
function handleFileSelect (evt) { 
	$("#canvasDiv").html("");
	 
    isHand = 1;  
    //imgArr = [];  
    imgTypeArr = [];  
    //$("#canvasDiv").html("");  
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
	//alert(imgArr.length);
	var str="";
     $.ajax({  
        type : "POST",  
        url : "/CompressImg.do", 
        traditional:true,    
        data : {
        	'img' : imgArr,  
            'type' : imgTypeArr 
        }, 
        dataType:"json",
        contentType:"multipart/form-data;charset=utf-8",
        success : function(data) {  
        	alert("success");
        	alert(imgArr.length);
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
var imgArr2=new Array();

function catUpload2(imgs){ 
	//alert("catupload2"+imgs);
	var str="";
     $.ajax({  
        type : "POST",  
        url : "/CompressImg2.do", 
        data : {'img' : imgs}, 
        dataType:"json",
        contentType:"application/x-www-form-urlencoded;charset=utf-8",
        success : function(data) {  
        	
        	
           var newdata=eval(data);
           for(var a=0;a<newdata.length;a++){
        	   var attch=newdata[a].attch;
        	   
        	   str2+=attch+",";
        	   //alert("str2:"+str2);
        	   /* if(a==parseInt(newdata.length-1)){
        		   $("#serveridwai").val(str);
        		   alert("压缩上传成功");
        		   
        	   } */
           }

        } 
    });   
   
}  
</script>

</body>
</html>
