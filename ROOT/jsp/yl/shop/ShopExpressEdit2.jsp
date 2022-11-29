<%@page import="tea.db.DbAdapter"%>
<%@page import="util.DateUtil"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@ page import="util.Config" %>
<%

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
		/* soe.express_code=h.get("express_code","");
		soe.express_name=h.get("express_name","");
		soe.mobile=h.get("mobile","");
		soe.order_id=h.get("orderId","");
		soe.person=h.get("person","");
		soe.price=BigDecimal.valueOf(h.getDouble("price"));
		soe.time=h.getDate("time");
		soe.type=type;
		soe.NO1=h.get("NO1","");
		soe.NO2=h.get("NO2","");
		soe.vtime=h.getDate("vtime"); */
		soe.images=h.get("serveridwai");
		soe.set();
		order.set("status", "-1");//修改订单状态，添加（修改）完成检验报告。
		//发送短信给初审管理员(订单管理员)
		String user = Profile.find(h.member).getMember();

		ShopOrder so = ShopOrder.findByOrderId(soe.order_id);
		
		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			if(MT.f(sms.ckcs)!=""){
				List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckcs);
				if(!"".equals(MT.f(mobiles.toString())))
					SMSMessage.create("Home", user, mobiles.toString(), h.language, order.getOrderId()+"订单已上传检验报告，请验收！");
			}
			
		}
		ModifyRecord.creatModifyRecord(order.getOrderId(),"质检报告",h.member,"订单质检报告上传");
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
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="serveridwai" id="serveridwai" value=""/>

<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='2' class='bornone'>出厂基本信息</td></tr>
</thead>

<tr>
    <td width="30%">销售编号</td>
    <td class='bornone'><%=MT.f(seo.NO1)%></td> 
  </tr>
  <tr>
    <td>生产批号</td>
    <td class='bornone'><%=MT.f(seo.NO2)%></td> 
  </tr>

<%
    int mypuid = ShopOrderData.findPuid(oid);
    if(Config.getInt("junan")!=mypuid){
        %>
    <tr>
        <td>有效期</td>
        <td class='bornone'><%=MT.f(seo.vtime)==""?DateUtil.addMonth(MT.f( order.getCreateDate()), 5):MT.f(seo.vtime)%></td>
    </tr>
    <%
    }
%>
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
   
</table>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='2' class='bornone'>上传检验报告</td></tr>
</thead>
<%
	if(MT.f(seo.refusereason).length()>0&&order.getStatus()==-3){
%>
	<tr>
    <td width="30%">初审不通过原因</td>
    <td class='bornone'><%=MT.f(seo.refusereason) %></td> 
  </tr>
<%		
	}
%>
<%
	if(MT.f(seo.fuhereason).length()>0&&order.getStatus()==-4){
%>
	<tr>
    <td width="30%">复核不通过原因</td>
    <td class='bornone'><%=MT.f(seo.fuhereason) %></td> 
  </tr>
<%		
	}
%>

  <tr>  
     <td width="30%">  
        <input id="fileToUpload" type="file" name="fileToUpload" accept="image/*" multiple="multiple">  
     </td>  
     <td width="80" align="right">  
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
     </td>  
  </tr>  

</table>

</div>
 <div class='center mt15'>
    <input type="submit" class="btn btn-primary" value="提交">
    <button class="btn btn-default" type="button" onclick="history.back();">返回</button></div>
 </form>

<script>

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
        		   $("#serveridwai").val(str);
        		   alert("压缩上传成功");
        		   
        		
        		 //alert("jieguo"+m);
        	   }
           }
			
        }  
        
    });  
     

      
}  
function fntijiao(){
	catUpload();
	var serveridwai=$("#serveridwai").val();
	if(serveridwai==''){
		mt.show("请上传报告！");
		return false;
	}
	form1.submit();
	
}
</script>
</body>
</html>
