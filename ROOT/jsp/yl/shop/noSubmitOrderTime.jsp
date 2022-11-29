<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.*"%>
<%@ page import="tea.entity.yl.shop.ActivityWarning" %>
<%

	Http h=new Http(request,response);
	if(h.member<1)
	{
		response.sendRedirect("/servlet/StartLogin?community="+h.community);
		return;
	}

	ActivityWarning activityWarning = ActivityWarning.find(2022);
	if(h.get("act","").equals("edit")) {
        String time = h.get("time");
        activityWarning.setWarning2(time);
        activityWarning.update();
	}

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<link href="/jsp/yl/shop/img/iconfont.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
</head>
<body>

<form name="form1" id="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return checked(this)">
	<input type="hidden" name="act" value="edit"/>
	<div class='radiusBox'>

		<table id="tdbor" cellspacing="0" class='newTable'>
			<tr>
				<td>高科、君安不可下单日期</td>
				<td class='bornone'><input type="text" alt="日期" id="fahuotime" name="time"  value="<%=MT.f(activityWarning.getWarning2())%>"
										   readonly="readonly" onclick="mt.date(this,true)">&nbsp;&nbsp;<%--<input type="button" onclick="fngettime()" value="获取当前时间"/>--%></td>
			</tr>
		</table>

	</div>
	<div class='center mt15'>
		<button class="btn btn-primary" type="submit">提交</button>
</form>
<script type="text/javascript">
    function fngettime(){
        var date = new Date();

        var month = (date.getMonth()+1) > 9 ? (date.getMonth()+1) : "0" + (date.getMonth()+1);

        var day = (date.getDate()) > 9 ? (date.getDate()) : "0" + (date.getDate());

        var hours = (date.getHours()) > 9 ? (date.getHours()) : "0" + (date.getHours());

        var minutes = (date.getMinutes()) > 9 ? (date.getMinutes()) : "0" + (date.getMinutes());

        var seconds = (date.getSeconds()) > 9 ? (date.getSeconds()) : "0" + (date.getSeconds());



        var dateString =

            date.getFullYear() + "-" +

            month + "-" +

            day + " " +

            hours + ":" +

            minutes + ":" +

            seconds;






        //alert(currentdate);

        document.getElementById("fahuotime").value=dateString;

        return;

    }
</script>
<script>

    mt.focus(form1);

    function checked(a){
        var nums = form1.express_code.value;
        if(mt.check(a)){
            var mobile=form1.mobile.value;
            if(mobile.length==0){
                mt.show("电话不能为空");
                form1.mobile.focus();
                return false;
            }
            var NO2=form1.NO2.value;
            if(NO2.length<6){
                mt.show("生产批号不能小于6位数");
                form1.NO2.focus();
                return false;
            }

            //新加
            catUpload();
            /*var reg=/^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$)/;
            if(!reg.test(form1.mobile.value)){
                mt.show("电话格式不正确");
                form1.mobile.focus();
                return false;
            }
            */

            $.ajax({
                url:'/mobjsp/yl/shop/ajax.jsp',
                type:'post',
                dataType:'json',
                data:{express_code:nums,act:"checkNumber"},
                success:function(data){
                    if (data.type > 0) {
                        if(data.type==3){
                            mt.show("运单号有误，请输入顺丰单号！");
                            return false;
                        }
                    } else {
                        mt.show("运单号不能为空！");
                        return false;
                    }
                }

            });



        }else{
            return false;
        }
    }
    //上传图片
    function uploadwai(a){
        mt.show(null,0);
        $("#form3").submit();
    }
    /* mt.value3=function(url,id){
        mt.show("上传成功！");
        $("#serveridwai").val(id);
        var strs= new Array(); //定义一数组
        strs=url.split(","); //字符分割
        var ids=id.split(",");
        var imgs="";
        for (i=1;i<strs.length ;i++ )
        {
            imgs+="&nbsp;&nbsp;<img src='"+strs[i]+"' width='100px' height='50px' class='imgmuti'/>";
        }
        $("#wai").siblings("img").remove();
        $("#wai").after(imgs);
    } */

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
