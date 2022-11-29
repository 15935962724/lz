/*MobileLoading.js  手机端公用文档整理，为保证代码整洁，请勿随意修改此文件，如需修改请@MaLuoLe*/
var YKRJ = new Object();	//基本操作
var codeurl = "/res/Home/qr.jpg";	//二维码路径
var url = "/tea/image/1447041687304910.gif";	//加载的GIF路径
var loadhtml = "<div id='loadhtml' style='display:none;width:100%;height:100%;position:fixed;background:rgba(0,0,0,0.6);left:0px;top:0px;z-index:100;'><div style='width:40px;height:40px;position:fixed;background:rgba(0,0,0,0.8);left:50%;top:50%;margin-top:-20px;margin-left:-20px;border-radius:6px;z-index:101;text-align:center;border:2px solid rgba(225,225,225,0.5);'><img src='"+url+"' width='40' height='40' style='border-radius:6px;' /></div></div>";
var dialoghtml = "<div style='display:none' id='weui_dialog_confirm' class='weui_dialog_confirm'><div class='weui_mask'></div> <div class='weui_dialog'> <div class='weui_dialog_hd'><strong id='weui_dialog_title' class='weui_dialog_title'>弹窗标题</strong></div> <div id='weui_dialog_bd' class='weui_dialog_bd'>自定义弹窗内容，居左对齐显示，告知需要确认的信息等</div><div class='weui_dialog_ft'><a href='javascript:YKRJ.no()' id='weui_no_btn' class='weui_btn_dialog default'>取消</a><a href='javascript:YKRJ.ok()' id='weui_ok_btn' class='weui_btn_dialog primary'>确定</a></div></div></div>";
var toasthtml = "<div id='toast' style='display: none;'><div class='weui_mask_transparent'></div><div class='weui_toast'><i class='weui_icon_toast'></i><p class='weui_toast_content' id='weui_toast_content'>已完成</p></div></div>";
var divloadhtml = "<div class='load-div' style='width: 100%;text-align: center;margin-top:15px;'><div id='loading2' style='width:60px;margin:10px auto;height: 30px;position:relative;'><div class='demo2' style='width: 4px;height: 6px;background: #FCC73A;float: left;margin: 0 3px;animation: demo2 linear 1s infinite;-webkit-animation: demo2 linear 1s infinite;animation-delay:0s;'></div><div class='demo2' style='width: 4px;height: 6px;background: #FCC73A;float: left;margin: 0 3px;animation: demo2 linear 1s infinite;-webkit-animation: demo2 linear 1s infinite;animation-delay:0.15s;'></div><div class='demo2' style='width: 4px;height: 6px;background: #FCC73A;float: left;margin: 0 3px;animation: demo2 linear 1s infinite;-webkit-animation: demo2 linear 1s infinite;animation-delay:0.3s;'></div><div class='demo2' style='width: 4px;height: 6px;background: #FCC73A;float: left;margin: 0 3px;animation: demo2 linear 1s infinite;-webkit-animation: demo2 linear 1s infinite;animation-delay:0.45s;'></div><div class='demo2' style='width: 4px;height: 6px;background: #FCC73A;float: left;margin: 0 3px;animation: demo2 linear 1s infinite;-webkit-animation: demo2 linear 1s infinite;animation-delay:0.6s;'></div><p class='load-p ft14' style='color:#888; text-align: center;position: absolute;width:100px;left: 50%;margin-left:-44px;top:20px;font-size:13px;'>数据加载中……</p> </div></div>";	//模块加载html
var divnotdatahtml = "<div style='text-align: center;margin-top: 35px;'><img src='/mobjsp/westrac/image/52e53f73c1e150b553d56d50b1ded3a.png' style='width:80px;'><p style='margin-top:5px;color:#8e8e8e;font-size:16px;'>暂无数据</p></div>";	//无数据
YKRJ.isload = false;	//是否加载中
document.write(loadhtml);
document.write(dialoghtml);
document.write(toasthtml);
//弹出加载
YKRJ.run = function(){
	document.getElementById("loadhtml").style.display="block";
}
//关闭加载
YKRJ.close = function(){
	document.getElementById("loadhtml").style.display="none";
}

//div模块加载
YKRJ.load = function(divId){
	document.getElementById(divId).innerHTML += divloadhtml;
}
//关闭div加载模块
YKRJ.closeload = function(divId){
	$("#" + divId).find(".load-div").remove();
}
//div模块无数据
YKRJ.notdata = function(divId){
	document.getElementById(divId).innerHTML = divnotdatahtml;
}

//弹出提示框
YKRJ.show = function(title,context){
	document.getElementById("weui_dialog_confirm").style.display="block";
	document.getElementById("weui_dialog_title").innerHTML = title;
	document.getElementById("weui_dialog_bd").innerHTML = context;
	var btncount = arguments[2];
	if(btncount == '1'){
		document.getElementById("weui_ok_btn").innerHTML = "确定";
		document.getElementById("weui_no_btn").style.display = "none";
	}else if(btncount == '2'){
		document.getElementById("weui_no_btn").innerHTML = "取消";
		document.getElementById("weui_no_btn").style.display = "block";
	}
	
	if(arguments.length  == 4) {	//取消按钮名称
		document.getElementById("weui_no_btn").innerHTML = arguments[3];
	}else if(arguments.length  == 5) {	//确定和缺陷按钮的名称
		document.getElementById("weui_no_btn").innerHTML = arguments[3];
		document.getElementById("weui_ok_btn").innerHTML = arguments[4];
	}
}

//弹出Toast提示
YKRJ.toast = function(context){
	document.getElementById("weui_toast_content").innerHTML = context;
	document.getElementById("toast").style.display = "block";
}

//弹出提示框
YKRJ.no = function(){
	document.getElementById("weui_dialog_confirm").style.display="none";
}
YKRJ.ok = function(){
	document.getElementById("weui_dialog_confirm").style.display="none";
}
//隐藏提示框
YKRJ.hide = function(){
	document.getElementById("weui_dialog_confirm").style.display="none";
}

//转化数字为大写金额
YKRJ.DXJE = function(num) {
	var strOutput = "",
		strUnit = '仟佰拾亿仟佰拾万仟佰拾元角分';
	num += "00";
	var intPos = num.indexOf('.');
	if (intPos >= 0) {
		num = num.substring(0, intPos) + num.substr(intPos + 1, 2);
	}
	strUnit = strUnit.substr(strUnit.length - num.length);
	for (var i = 0; i < num.length; i++) {
		strOutput += '零壹贰叁肆伍陆柒捌玖'.substr(num.substr(i, 1), 1) + strUnit.substr(i, 1);
	}
	return strOutput.replace(/零角零分$/, '整').replace(/零[仟佰拾]/g, '零').replace(/零{2,}/g, '零').replace(/零([亿|万])/g, '$1').replace(/零+元/, '元').replace(/亿零{0,3}万/, '亿').replace(/^元/, "零元");
}
//表单验证1
YKRJ.check = function(form) {
	var inputs = $(form).find("input"); //获取所有input
	var selects = $(form).find("select"); //获取所有select
	var textareas = $(form).find("textarea"); //获取所有textarea
	if (!YKRJ.valueFlag(inputs)) {
		return false;
	}
	if (!YKRJ.valueFlag(selects)) {
		return false;
	}
	if (!YKRJ.valueFlag(textareas)) {
		return false;
	}
	return true;
};
//表单验证2
YKRJ.valueFlag = function(obj) {
	for ( var i = 0; i < obj.length; i++) {
		if ($(obj[i]).attr("alt") != undefined && $(obj[i]).attr("alt") != "" && $(obj[i]).attr("alt") != "0" && obj[i].value == "" && !$(obj[i]).is(':hidden')) {
			YKRJ.show($(obj[i]).attr("alt"));
			return false;
		}
	}
	return true;
};
//获取url中参数
YKRJ.getParam = function(paramName) {
    var paramValue = "";
    isFound = false;
    if (location.search.indexOf("?") == 0 && location.search.indexOf("=")>1)
    {
        arrSource = location.search.substring(1,location.search.length).split("&");
        i = 0;
        while (i < arrSource.length && !isFound)
        {
            if (arrSource[i].indexOf("=") > 0)
            {
                 if (arrSource[i].split("=")[0].toLowerCase()==paramName.toLowerCase())
                 {
                    paramValue = arrSource[i].split("=")[1];
                    isFound = true;
                 }
            }
            i++;
        }  
    }
	return decodeURIComponent(paramValue);
};