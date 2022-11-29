<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String author="";
    if(session.getAttribute("author")!=null){
    	author=(String)session.getAttribute("author");
    }
    
    String phone="";
    if(session.getAttribute("phone")!=null){
    	phone=(String)session.getAttribute("phone");
    }
%>

 <script src="/tea/tea.js" type="text/javascript"></script>
 <script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/type/monkey/mt.upload.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
 <script src="/tea/Calendar.js" type="text/javascript"></script>
<script type="text/javascript">
function getDates(){

	if(mt.isIE){
		var d=new Calendar();
		d.show('form1.time');
	}else{
		var d=new Calendar(1900+new Date().getYear());
		d.show('form1.time');
	}
}
function checkIntroduce(){
	var intr=form1.introduce;
	if(intr.value.trim().length>500){
		document.getElementById("introduceshow").innerHTML='<font color=red>图片说明不能大于500字！</font>';
		intr.focus();
		return false;
	}
	document.getElementById("introduceshow").innerHTML='图片说明不能大于500字！';
	return true;
} 
function f_sub(){
	
	var aut=form1.author;
	if(aut.value.trim().length==0){
		document.getElementById("authorshow").innerHTML='<font color=red>请输入作者名称！</font>';
		aut.focus();
		return false;
	}
	document.getElementById("authorshow").innerHTML='';
	
	var phone = form1.phone;
    // var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159|188|182|186|189)+\d{8})$/;
     var reg=/^(((13[0-9]{1})|145|147|150|151|152|153|154|155|156|157|158|159|180|181|182|183|184|185|186|187|188|189)+\d{8})$/;
     if(!reg.test(phone.value)){
        document.getElementById("phoneshow").innerHTML='<font color=red>请输入正确的手机号码</font>';
        phone.focus();
       return false;
     }
     document.getElementById("phoneshow").innerHTML='';

    var att= document.getElementsByName("attach");
    if(att.length==0){
        document.getElementById("attachshow").innerHTML='<font color=red>请选择图片</font>';
    	return false;
    }
    document.getElementById("attachshow").innerHTML='格式不限，图片大小不能小于5M';
	
    if(!checkIntroduce()){
    	return false;
    }
	
	form1.nexturl.value=window.location.href;
}

</script>

<!--<h1>中国金丝猴摄影展征稿</h1>
 <p>由北京动物园举办，澳门民政署和佳能有限公司北京分公司赞助的中国金丝猴摄影展将在7月28日在北京动物园科普馆开幕。现向社会征集金丝猴照片，希望广大影友踊跃投稿</p>
<h2>照片类型：</h2>
<p>
1.川金丝猴、黔金丝猴和滇金丝猴的野外生境及食物；<br/>
2.三种金丝猴的社群行为、繁殖育幼行为，领地行为、觅食行为、节律行为等；<br/>
3.三种金丝猴的肖像；
</p>
<span>
   为了保护作者的权益，所有报送照片只作为此次活动使用。<br>
   征稿截止日期2013年6月30日，对于选定展览的作品将给与奖励，同时邀请作者出席影展开幕式。<br>
   联系方式：13911756007 68390249<br>
   联系人：张宁新<br>
   稿件投送地址：北京市西城区西外大街137号  北京动物园科普馆	<br>
</span> -->
<span id="spanImg" >
	<img src="/jsp/type/monkey/zzqs.jpg"   id="img"/>
</span>
<form  method="post" name="form1" action="/EditMphoto" enctype=multipart/form-data onsubmit="return f_sub();">
<input type="hidden" name="act" value="add"/>
<input type="hidden" name="type" value="0"/>
<input type="hidden" name="nexturl" value="/jsp/type/monkey/AddMphoto.jsp"/>
<input type="hidden" name="repository" value="monkey"/>
<table cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td>作者：</td>
		<td><input type="text" name="author"  value="<%=author%>"/><span id="authorshow"></span></td>
	</tr>
	<tr>
		<td>联系方式：</td>
		<td><input type="text" name="phone"  value="<%=phone%>"/><span id="phoneshow"></span></td>
	</tr>
	<tr>
		<td>作品上传：</td>
		<td>  <input id="_attach" type="button" value="添加附件"/><span id="attachshow">格式不限，图片大小不能小于5M</span>
      <table style="width:auto;" id="attachlist">
        <tbody> </tbody>
      </table>
       </td>
	</tr>
	<tr>
		<td>图片说明：</td>
		<td><textarea name="introduce"  cols="100"  rows="8" onkeyup="checkIntroduce()"></textarea><br><span id="introduceshow">图片说明不能大于500字</span></td>
	</tr>
	<tr>
		<td>拍摄地点：</td>
		<td><input type="text" name="place"  value=""/></td>
	</tr>
	<tr>
		<td>拍摄时间：</td>
		<td><input id="" name="time" size="7"  value=""  style="cursor:pointer;width:126px;" readonly onClick="getDates();"> 
  <img style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="getDates();" /></td>
			</td>
	</tr>
	<tr>
		<td>拍摄参数：</td>
		<td><input type="text" name="parameters"  value=""/></td>
	</tr>
	<tr>
                <td class="th">验证码：</td>
                <td colspan="3"><input name="verify0" type="text" />　<img  id="vcodeImg"  src="/NFasts.do?act=verify&community=papc&t=1" />　<a href="javascript:mt.vertify();"  >看不清？换一张</a></td>
        </tr>
	
	<tr>
		<td colspan="2" align="center"><input type="submit" value="提交"/></td>
	</tr>
</table>
</form>
<script>
mt.vertify=function()
{
  var vcode=document.getElementById('vcodeImg');
  vcode.setAttribute('src',vcode.src.replace(/t=[\d.]+/,'t='+Math.random()));
};

mt.upload($('_attach'));
</script>
