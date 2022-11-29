var tsstr = Date.parse(new Date());

document.write('<script src="/tea/yl/mtDiag.js?tsstr='+tsstr+'"></script> ');
document.write('<script src="/tea/yl/jquery.cookie.js?tsstr='+tsstr+'"></script> ');
document.write('<script src="/tea/yl/jquery.serializejson.js?tsstr='+tsstr+'"></script> ');
document.write('<script src="/tea/yl/jquery.validate.js?tsstr='+tsstr+'"></script> ');
document.write('<script src="/tea/yl/messages_zh.js?tsstr='+tsstr+'"></script> ');
document.write('<script src="/tea/yl/page.js?tsstr='+tsstr+'"></script> ');
document.write('<script src="/tea/yl/common.js?tsstr='+tsstr+'"></script> ');
var myurl = window.location.pathname;
/**
 * 从url里获取对应参数值
 * @param paramName
 * @returns {String}
 */
 function getParam(paramName) {
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