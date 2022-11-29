var mtDiag = new Object();
!window.layer && document.write("<script src=\"/tea/yl/layer/layer.js\">"+"</scr"+"ipt>");

var layer = window.layer;
/**
 * t
	 * 	alert
	 *  msg
	 * 	open
	 * 	confirm
	 *  load
 */
mtDiag.show=function(c,t,_a,_b){
	var type = t;
	if(c && mtDiag.f_isurl(c)){//弹出层
		type = "open";
	}else if(type == undefined){
		type = "alert";
	}
	switch (type) {
    	case "alert":
    		_a = _a == null?"":_a;
    		if(_a == undefined){
    			layer.alert(c);
    		}else{
    			var _title = _a?{title:_a}:{};
    			var _func = null;
    			if(_b){
    				if(typeof _b === "function"){
        				_func = _b;
        			}else{
        				_func = function(index){
        					//if(_b.indexOf("/")>=0){
        						location.href = _b;
        					//}
        					layer.close(index);
        				};
        			}
    			}
    			layer.alert(c,_title,_func);
    		}
    		break;
    	case "msg":
    		layer.msg(c);
    		break;
    	case "open":
    		layer.open({
    		    type: 2,
    		    title:t,
    		    area: _a,
    		    fix: false, //不固定
    		    maxmin: true,
    		    content: c,
    		    end:_b
    		});
    		break;
    	case "confirm":
    		layer.confirm(c,_a,_b);
    		break;
    	case "load":
    		if(!c){
    			layer.load(1, {shade: [0.1,'#fff']});
    		}else{
    			layer.msg(c, {
    				  icon: 16
    				  ,shade: 0.01
    				});
    		}
    		break;
	}

};

mtDiag.close=function(t){
	if(t == undefined){
		layer.closeAll();
	}else{
		if(!isNaN(t)){//如果为数字
			layer.close(t);
		}else{
			layer.closeAll(t);
		}
	}
};

mtDiag.f_isurl=function(sc) {
    return sc.indexOf("/") == 0 || sc.indexOf("http://") == 0 || sc.indexOf("https://") == 0 || sc == "about:blank";
};

function goToLogin(returnUrl) {
	var loginUrl = '/jsp/mantu/login.html';
	if(returnUrl)
		loginUrl += '?returnUrl='+encodeURIComponent(returnUrl);
	else{
		var href = location.pathname+location.search;
		loginUrl += '?returnUrl='+encodeURIComponent(href+(href.indexOf("?")!=-1?"&":"?")+"t="+Math.random());
	}
	location.href=loginUrl;
}

/**
 * 从url里获取对应参数值
 * @param paramName
 * @returns {String}
 */
function getParam(paramName)
{
    var paramValue = "";
    isFound = false;
    if (this.location.search.indexOf("?") == 0 && this.location.search.indexOf("=")>1)
    {
        arrSource = this.location.search.substring(1,this.location.search.length).split("&");
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
	return paramValue;
}

/**
 * 判断是否是空
 * @param value
 */
function isEmpty(value){
    if(value == null || value == "" || value == "undefined" || value == undefined || value == "null"){
        return true;
    }
    else{
        value = (value+"").replace(/\s/g,'');
        if(value == ""){
            return true;
        }
        return false;
    }
}

/**
 * 检查是否含有非法字符
 * @param temp_str
 * @returns {Boolean}
 */
function is_forbid(temp_str){
    temp_str = temp_str.replace(/(^\s*)|(\s*$)/g, "");
    temp_str = temp_str.replace('--',"@");
    temp_str = temp_str.replace('/',"@");
    temp_str = temp_str.replace('+',"@");
    temp_str = temp_str.replace('\'',"@");
    temp_str = temp_str.replace('\\',"@");
    temp_str = temp_str.replace('$',"@");
    temp_str = temp_str.replace('^',"@");
    temp_str = temp_str.replace('.',"@");
    temp_str = temp_str.replace(';',"@");
    temp_str = temp_str.replace('<',"@");
    temp_str = temp_str.replace('>',"@");
    temp_str = temp_str.replace('"',"@");
    temp_str = temp_str.replace('=',"@");
    temp_str = temp_str.replace('{',"@");
    temp_str = temp_str.replace('}',"@");
    var forbid_str = new String('@,%,~,&');
    var forbid_array = new Array();
    forbid_array = forbid_str.split(',');
    for(var i=0;i<forbid_array.length;i++){
        if(temp_str.search(new RegExp(forbid_array[i])) != -1)
            return false;
    }
    return true;
}

/*
 * @auth mall
 * @param From表单
 * @return boolean 
 */
mtDiag.check = function(form) {
    var inputs = $(form).find("input"); //获取所有input
    var selects = $(form).find("select"); //获取所有select
    var textareas = $(form).find("textarea"); //获取所有textarea
    if (!mtDiag.valueFlag(inputs)) {
        return false;
    }
    if (!mtDiag.valueFlag(selects)) {
        return false;
    }
    if (!mtDiag.valueFlag(textareas)) {
        return false;
    }
    return true;
};

mtDiag.valueFlag = function(obj) {

    for ( var i = 0; i < obj.length; i++) {
        if($(obj[i]).attr('type')=="file"){
            //console.log($(obj[i]).next().attr('value'));
            if($(obj[i]).next().attr('value') == undefined || $(obj[i]).next().attr('value') == 0){
                if($(obj[i]).get(0).files[0] == undefined){
                    mtDiag.show($(obj[i]).attr("alt"),'msg');
                    return false;
                }
            }
        }else {
            if ($(obj[i]).attr("alt") != undefined && $(obj[i]).attr("alt") != "" && $(obj[i]).attr("alt") != "0" && obj[i].value == "" && !$(obj[i]).is(':hidden')) {
                mtDiag.show($(obj[i]).attr("alt"),'msg');
                return false;
            }
        }
    }
    return true;
};
/**
 * 弹窗中嵌套弹窗,关闭时会出bug,所以弹窗再次弹窗提示在该弹窗的父节点弹出
 * @param form
 * @returns {boolean}
 */
mtDiag.check1 = function(form) {
    var inputs = $(form).find("input"); //获取所有input
    var selects = $(form).find("select"); //获取所有select
    var textareas = $(form).find("textarea"); //获取所有textarea
    if (!mtDiag.valueFlag1(inputs)) {
        return false;
    }
    if (!mtDiag.valueFlag1(selects)) {
        return false;
    }
    if (!mtDiag.valueFlag1(textareas)) {
        return false;
    }

    return true;
};

mtDiag.valueFlag1 = function(obj) {
    //Object.keys(obj).forEach(key=>console.log(key,obj[key].getAttribute('type')));

    for ( var i = 0; i < obj.length; i++) {
        if($(obj[i]).attr('type')=="file"){
            //console.log($(obj[i]).next().attr('value'));
            if($(obj[i]).next().attr('value') == undefined || $(obj[i]).next().attr('value') == 0){
                if($(obj[i]).get(0).files[0] == undefined&&$(obj[i]).attr("alt") != undefined){
                    mtDiag.show($(obj[i]).attr("alt"),'msg');
                    return false;
                }
            }
        }else{
            if ($(obj[i]).attr("alt") != undefined && $(obj[i]).attr("alt") != "" && $(obj[i]).attr("alt") != "0" && obj[i].value == "" && !$(obj[i]).is(':hidden')) {
                mtDiag.show($(obj[i]).attr("alt"),'msg');
                return false;
            }
        }
    }
    return true;
};

/**
 * 从url里获取对应参数值
 * @param paramName
 * @returns {String}
 */
mtDiag.getParam = function(paramName) {
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
    return paramValue;
};
