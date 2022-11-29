var sEdit = "blog_body_area";
var sSelect = "浏览";
var gBrowesr = browserDetect();

function browserDetect() {
	var sUA = navigator.userAgent.toLowerCase();
	var sIE = sUA.indexOf("msie");
	var sOpera = sUA.indexOf("opera");
	var sMoz = sUA.indexOf("gecko");
	if (sIE != -1) {
		nIeVer = parseFloat(sUA.substr(sIE + 5));
		if (nIeVer >= 6) {
			return "ie6";
		} else if (nIeVer >= 5.5) {
			return "ie55";
		} else if (nIeVer >= 5 ) {
			return "ie5";
		}
	}

	if (sOpera != -1) {
		return "opera";
	}

	if (sMoz != -1) {
		return "moz";
	}

	return "other";
}
function $(_sId){
	return document.getElementById(_sId);
}
function $$(_sId){

	return document.frames ? document.frames[_sId] : $(_sId).contentWindow;
}
function exist(_sId){
	return document.getElementById(_sId) != null;
}
function dw(_sStr){
	document.write(_sStr);
}
function isIE(){
	return gBrowesr.indexOf("ie") > -1;
}
function clearSelect(_sId){
	var oEdit;
	//alert('[img]' + $("filePath" + _sId).value + "[/img]");
	if (sState == "iframe"){
		replaceStr($("filePath" + _sId).value, "");
	}
	else{
		replaceStr("\\[img\\]" + $("filePath" + _sId).value + "\\[/img\\]", "");
	}
	$('file' + _sId).form.reset();
	$("form" + _sId).title = "";
	$("picShow" + _sId).innerHTML = "<span style='color:#7f7f7f'>图片剪切板</span>";
}
function initUpload(_oObj, _sId){
	var sZoom;
	var sOldPath = $("filePath" + _sId).value;
	$("form" + _sId).title	= _oObj.value.substr(_oObj.value.lastIndexOf('\\')+1);
	if (seekCurr(_sId, _oObj.value)) {
		if(sState == "iframe") {
			if (isIE()) {
				$('picShow' + _sId).innerHTML = "<a href='javascript:;'><img border='0' title='图片" + _sId + "' onload='this.width > this.height ? this.width=130 : this.height=110' src='" + _oObj.value + "' onerror='picError(this,this.parentNode.parentNode)' onclick='addArticle(" + _sId + ")' /></a>";
				$("filePath" + _sId).value = "file:///" + _oObj.value.replace(/\\/ig, "/").replace(/ /ig,"%20");
			} else {
				$('picShow' + _sId).innerHTML = _oObj.value.substr(_oObj.value.lastIndexOf('\\')+1);
				$("filePath" + _sId).value = "file:///" + _sId;
			}
		} else {
			if (isIE()) {
				$('picShow' + _sId).innerHTML = "<a href='javascript:;'><img border='0' title='图片" + _sId + "' onload='this.width > this.height ? this.width=130 : this.height=110' src='" + _oObj.value + "' onerror='picError(this,this.parentNode)' onclick='addArticle(" + _sId + ")' /></a>";
			} else {
				$('picShow' + _sId).innerHTML = _oObj.value.substr(_oObj.value.lastIndexOf('\\')+1);
			}
			$("filePath" + _sId).value = "###图片" + _sId + "###";
		}
	}
	if (sOldPath.length > 0) {
		replaceStr(sOldPath, $("filePath" + _sId).value);
	}
}
function picError(_oObj, _oParent) {
	_oParent.innerHTML = "<font color='red'><b>非法图片</b></font>";
	$("form" + _oObj.title).title = "";
	$("form" + _oObj.title).reset();
}
function addArticle(_sId){

	var sInsert = $('picShow' + _sId).innerHTML;
        alert(sInsert);
	if (sInsert.indexOf('.') != -1) {
		if (sState == "iframe") {
			if (isIE()) {
				insertHTML('<a href="' + $("filePath" + _sId).value + '" target="_blank"><img border="0" onload="resizeImg(this,500)" src="' + $("filePath" + _sId).value + '"></a>');
			} else {
				insertHTML("<a href='" + $('filePath' + _sId).value  + "'  target='_blank'><img border='1' onload='resizeImg(this,500)' alt='" + $('filePath' + _sId).value + "' title='" + $('filePath' + _sId).value + "' src='" + $('filePath' + _sId).value + "' /></a>");
			}
		} else {
			if($("filePath" + _sId).value.indexOf("###") > -1){
				insertHTML("[img]" + $("filePath" + _sId).value + "[/img]");
			} else {
				insertHTML($("filePath" + _sId).value);
			}
		}
	}
}
function seekCurr(_sId){
	var i = 1;
	while(exist('form' + i)) {
		if (_sId != i && $("file" + i).value.length > 0 && $("file" + _sId).value == $("file" + i).value) {
			$('form' + _sId).reset();
			_error_msg_show('此图片已经被选择');
			return false;
		}
		i++;
	}
	return true;
}
function seekUse(_sId){
	if (sState == "iframe") {
		var imgs = $$(sEdit).document.getElementsByTagName("img");
		for(var i = 0; i < imgs.length; i++) {
			if(imgs[i].src == $("filePath" + _sId).value) {
				return true;
			}
		}
	return false;
	} else {
		return $(sEdit).value.indexOf($("filePath" + _sId).value) > -1;
	}
}
function decodeSpecialCharacters(str){
	var list = {
		"amp" 	: "&",
		"lt" 		: "<",
		"gt"		: ">"
	}

	var regStr = "";
	for (var i in list){
		if (typeof (i) == 'string')
			str = str.replace(new RegExp("\\&"+i+"\\;","gm"),list[i]);
	}
	return str;
}
function replaceStr(_sStr, _sRel){
	if (sState == "iframe") {
		if (_sRel == "") {
			seekImg(_sStr);
		} else {
			$$(sEdit).document.body.innerHTML = decodeSpecialCharacters($$(sEdit).document.body.innerHTML).split(_sStr).join(_sRel);
		}
	} else {
		$(sEdit).value = decodeSpecialCharacters($(sEdit).value).split(_sStr).join(_sRel);
	}
}
function seekImg(_sPath){
	var aImg = $$(sEdit).document.getElementsByTagName('IMG');
	for(var i = aImg.length - 1; i >= 0; i--) {
		if(aImg[i] && aImg[i].tagName && aImg[i].src && aImg[i].src == _sPath){
			aImg[i].parentNode.parentNode.removeChild(aImg[i].parentNode);
		}
	}
}
function insertHTML(_sStr) {
	var oRng;
	var oEdit;
	if (sState == "iframe") {
		oEdit = $$(sEdit);
		oEdit.focus();
		if (isIE()) {
			oRng = oEdit.document.selection.createRange();
			oRng.pasteHTML(_sStr);
			oRng.collapse(false);
			oRng.select();
		} else {
			oEdit.document.execCommand('insertHTML', false, _sStr);
		}
	} else {
		oEdit = $(sEdit);
		oEdit.focus();
		if (isIE()) {
			oRng = oEdit.document.selection.createRange();
			oRng.text += _sStr;
		} else {
			oEdit.value = oEdit.value.substring(0, oEdit.selectionStart) + _sStr + oEdit.value.substring(oEdit.selectionEnd, oEdit.value.length);
		}
	}
}
// 回调函数
function savekey(snum, skey, sname)
{
	var sort = document.getElementById('blog_class');
	sort.options[sort.options.length] = new Option(sname, skey);
	sort.options[sort.options.length - 1].selected = true;
}
