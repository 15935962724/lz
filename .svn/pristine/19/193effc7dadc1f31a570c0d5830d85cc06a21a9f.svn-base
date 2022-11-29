<%@page import="tea.entity.tobacco.Smoke"%>
<%@page import="java.util.Date"%>
<%@page import="tea.entity.Seq"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.Attch"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%
Http h=new Http(request,response);
%>
<script type="text/javascript" src="/tea/jquery.js"></script>
<script type="text/javascript" src="/tea/ajaxfileupload.js"></script>
<script type="text/javascript">
var imgindex = 1;
	function uploadfile(num){
		
		 $.ajaxFileUpload
         (
             {
                 url: '/jsp/madd/file.jsp', //用于文件上传的服务器端请求地址
                 secureuri: false, //是否需要安全协议，一般设置为false
                 fileElementId: "introPicture"+num, //文件上传域的ID
                 dataType: 'text', //返回值类型 一般设置为json
                 success: function (data, status)  //服务器成功响应处理函数
                 {
                	 if(data==""){
                		 alert("上传失败");
                		 return;
                	 }
                	 var imgarr = data.split("||");
					$("#img"+num).attr("src",imgarr[1]);
					$("#img"+num).attr("alt",imgarr[0]);
					$("#imgattch").val(imgarr[0]);
					$("#img1").show();
					$("#introPicture1").hide();
					$("#uploadImg").hide();
					//imgindex++;
					//addimg();
                 },
                 error: function (data, status, e)//服务器响应失败处理函数
                 {
                     alert(e);
                 }
             }
         );
	}
	function delimg(obj){
		if(confirm("是否删除")){
			$.ajax({
				type: "GET",
	             url: "/jsp/madd/delfile.jsp",
	             data: {url:$(obj).attr("src"),alt:$(obj).attr("alt")},
	             dataType: "text",
	             success: function(data){
	            	 if(data!=""){
		            	 //$(obj).parent().remove();
		            	 $("#imgtd").html("<img src='/res/tobacco/structure/14070224.png' id='uploadImg' onClick='uploadImgHandler()'/><input value='' type='file' accept='image/*' id='introPicture1' name='introPicture1' capture='camera'  style='filter:alpha(opacity=0); -moz-opacity:0; opacity:0;'  onchange='uploadfile(1);'><img style='display: none;' src='' id='img1' onclick='delimg(this);'>");

	            	 }else{
	            		 alert("删除失败");
		            	 return;
	            	 }
	             },
	             error: function(data){
	            	 alert("删除失败");
	            	 return;
	             }
			});
			
		}else{
			
		}
	}
	function addimg(){
		$("#myul").append("<li><input type='file' value='' accept='image/*' id='introPicture"+imgindex+"' name='introPicture"+imgindex+"' capture='camera'  style='filter:alpha(opacity=0); -moz-opacity:0; opacity:0;' onchange='uploadfile("+imgindex+");'><img src='' id='img"+imgindex+"' onclick='delimg(this);'></li>");
	}
	
	function uploadImgHandler(){
		$("#introPicture1").click();
		if($("#introPicture1").value!=""){
			$("#uploadImg").attr("src","/res/tobacco/structure/14070237.gif");
		}else{
			$("#uploadImg").attr("src","/res/tobacco/structure/14070224.png");
			}
		
	}
</script>
<form id="myfrom" name="form2" action="/Smokes.do" method="post" enctype="multipart/form-data"  target="_ajax" onsubmit="return mycheck();" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="type" value="2"/>
<input type="hidden" name="act" value="madd"/>
<input type="hidden" name="nexturl" value="location.reload()"/>
	<table>
		<tr>
			<td nowrap align='right'>姓名：</td>
			<td><input name="name" class="rad" /></td>
		</tr>
		<tr>
			<td nowrap align='right'>身份证号：</td>
			<td><input name="idcard" type="number" class="rad" /></td>
		</tr>
		<tr>
			<td nowrap align='right'>地址：</td>
			<td><input name="address" class="rad" /></td>
		</tr>
		<tr>
			<td nowrap align='right'>手机号：</td>
			<td><input name="mobile" type="tel" class="rad" /></td>
		</tr>
		<tr>
			<td nowrap align='right'>图片：</td>
			<td id="imgtd" valign="middle">
				<input type="hidden" id="imgattch" name="attch" />
                <img src="/res/tobacco/structure/14070224.png" id="uploadImg" onClick="uploadImgHandler()"/><input value="" type="file" accept="image/*" id="introPicture1" name="introPicture1" capture="camera" style="filter:alpha(opacity=0); -moz-opacity:0; opacity:0; "   onchange="uploadfile(1);">                
				<img style="display: none;" src="" id="img1" onclick="delimg(this);">
			</td>
		</tr>
		<tr>
			<td nowrap align='right' valign="top">图片说明：</td>
			<td class="imgcontent"><textarea name="content" rows="" cols=""></textarea></td>
		</tr>
		<tr>
		 <td nowrap align='right'>选择类型：</td>
   		 <td id='typeno'><%=h.radios(Smoke.MATTER_TYPE[2],"matter"+1,1)%></td>
		</tr>
		<tr>
			<td colspan="2" id='submit' align='center'><input type="submit" /></td>
		</tr>
	</table>
</form>
<script type="text/javascript">
	function mycheck(){
		var name = document.getElementsByName("name")[0].value;
		var idcard = document.getElementsByName("idcard")[0].value;
		var address = document.getElementsByName("address")[0].value;
		var mobile = document.getElementsByName("mobile")[0].value;
		var attch = document.getElementsByName("attch")[0].value;
		var content = document.getElementsByName("content")[0].value;
		if(name==""){
			alert("姓名不能为空");
			return false;
		}
		var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/; 
		if(idcard==""){
			alert("身份证不能为空");
			return false;
		}
		if(reg.test(idcard) === false)  
		   {  
		       alert("身份证输入不合法");  
		       return  false;  
		   }
		if(address==""){
			alert("地址不能为空");
			return false;
		}
		var reg1 = /^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\d{8}$/;
		if(mobile==""){
			alert("手机不能为空");
			return false;
		}
		if(reg1.test(mobile) === false)  
		   {  
		       alert("手机输入不合法");  
		       return  false;  
		   }
		if(attch==""){
			alert("图片不能为空");
			return false;
		}
		if(content.length>100){
			alert("内容最多为100字");
			return false;
		}
	}
	


</script>
