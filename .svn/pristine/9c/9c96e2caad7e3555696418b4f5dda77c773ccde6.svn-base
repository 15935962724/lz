Date.prototype.format = function (regExp,i18nT) {    
    var date = this;
    var i18nT = !i18nT ? 0 : i18nT;
    var i18n = [{
    				"ddd":['日', '一', '二', '三', '四', '五', '六'],
    				"dddd":['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
    				"MMM":['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
    				"MMMM":['一月份', '二月份', '三月份', '四月份', '五月份', '六月份', '七月份', '八月份', '九月份', '十月份', '十一月份', '十二月份']
   				 },{
   					"ddd":['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'],
    				"dddd":['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
    				"MMM":['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    				"MMMM":['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
    			}];
    var zeroize = function (v, l) {    
        if (!l) l = 2;
        return ("0"+v).substring(("0"+v).length-2);    
    };    
    return regExp.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|M{1,4}|yy(?:yy)?|([hHmstT])\1?|[lLZ])\b/g, function($0) {    
        switch ($0) {    
            case 'd': return date.getDate();    
            case 'dd': return zeroize(date.getDate());    
            case 'ddd': return i18n[i18nT]["ddd"][date.getDay()];    
            case 'dddd': return i18n[i18nT]["dddd"][date.getDay()];    
            case 'M': return date.getMonth() + 1;    
            case 'MM': return zeroize(date.getMonth() + 1);    
            case 'MMM': return i18n[i18nT]["MMM"][date.getMonth()];    
            case 'MMMM': return i18n[i18nT]["MMMM"][date.getMonth()];    
            case 'yy': return new String(date.getFullYear()).substr(2);    
            case 'yyyy': return date.getFullYear();    
            case 'h': return date.getHours() % 12 || 12;    
            case 'hh': return zeroize(date.getHours() % 12 || 12);    
            case 'H': return date.getHours();    
            case 'HH': return zeroize(date.getHours());    
            case 'm': return date.getMinutes();    
            case 'mm': return zeroize(date.getMinutes());    
            case 's': return date.getSeconds();    
            case 'ss': return zeroize(date.getSeconds());    
            case 'l': return date.getMilliseconds();    
            case 'll': return zeroize(date.getMilliseconds());    
            case 'tt': return date.getHours() < 12 ? 'am' : 'pm';    
            case 'TT': return date.getHours() < 12 ? 'AM' : 'PM';    
        }    
    });    
};  
//判断闰年
function isLeap(y) {
    return ((y % 4 == 0 && y % 100 != 0) || y % 400 == 0) ? true : false;
}
/**
 * 
 * @param o	Date类型的对象 
 * @param f 格式简码
 * f = 0 : "yyyy-MM-dd"
 * f = 1 : "yyyy年MM月dd日"
 */
function formatDate(o,f) { 
	if(typeof(o) == "undefined" || o.constructor!=Date) o = new Date();
	var fmt = ["yyyy-MM-dd","yyyy年MM月dd日"];
	f = !f || isNaN(f)? 0 : (parseInt(f)>fmt.length-1 ? fmt.length: parseInt(f));
    return o.format(fmt[f]);    
}

/**
 * 
 * @param o	Date类型的对象 
 * @param f 格式简码
 * f = 0 : "yyyy-MM-dd HH-mm-ss"
 * f = 1 : "yyyy年MM月dd日 "
 */
function formatDateTime(o,f){
	if(typeof(o) == "undefined" || o.constructor!=Date) o = new Date();
	var fmt = ["yyyy-MM-dd HH:mm:ss","yyyy年MM月dd日 HH时mm分ss秒"];
	f = !f || isNaN(f)? 0 : (parseInt(f)>fmt.length-1 ? fmt.length-1: parseInt(f));
    return o.format(fmt[f]); 
}

function formteShortDateTime(date){
	if(typeof(o) == "undefined" || o.constructor!=Date) o = new Date();
	var fmt = ["yyyy-MM-dd HH:mm","yyyy年MM月dd日 HH时mm分"];
	f = !f || isNaN(f)? 0 : (parseInt(f)>fmt.length-1 ? fmt.length: parseInt(f));
    return o.format(fmt[f]);  
}

//格式化字符串返回日期：yyyy-MM-dd 
function stringToDate(o){
	return std(o);
}

/*
* 字符串转化为日期
* 格式化字符串"yyyy-MM-dd hh:mm:ss"返回日期
*/
function stringToDateTime(o){
	return std(o,1);
}
function std(o,t){
	if(typeof(o) == "undefined" || typeof(o) != 'string') o = formatDateTime(new Date());
	var s = [];
	if(o.length>0) s = o.split(" ");
	var d = new Date();
	if(s.length>=1){
		var a1 = s[0].split("-");
		if(!isNaN(a1[0])) d.setFullYear(parseInt(a1[0]));   
		var month = a1[1] -1;
		if(!isNaN(a1[1]) && !isNaN(a1[2])) d.setMonth(month, a1[2]);   
	}
	if(s.length==2 && t==1){
		var a2 = s[1].split(":");
		if(!isNaN(a2[0])) d.setHours(parseInt(a2[0]));
		if(!isNaN(a2[1])) d.setMinutes(parseInt(a2[1]));
		if(!isNaN(a2[2])) d.setSeconds(parseInt(a2[2]));
	}
	return d;
}

/**
* 加减天数
* @param o	Date类型的对象 或string
* @param len 加减的天数 
* @returns Date
*/
function plusOrMinDays(len,o){
	if(typeof(o) == "undefined" || (o.constructor!=Date && o.constructor!=String)) o = new Date();
	if(o.constructor==String)  o = std(o);
	var len = !len || isNaN(len) ? 0 : parseInt(len); 
	o.setDate(o.getDate()+len);
	return o;//返回Date类型的值
}
/**
* 加减小时
* @param o	Date类型的对象 或string
* @param len 加减的小时 
* @returns Date
*/
function plusOrMinusHour(h,o){
	if(typeof(o) == "undefined" || (o.constructor!=Date && o.constructor!=String)) o = new Date();
	if(o.constructor==String)  o = std(o,1);
	h = (h==undefined || isNaN(h)) ? 0 : parseInt(h);
	o.setHours(o.getHours()+h);
	return formatDateTime(o);
}

function getDateWeek(o) {
	if(typeof(o) == "undefined" || (o.constructor!=Date && o.constructor!=String)) o = new Date();
	if(o.constructor==String)  o = std(o);
	return "周"+o.format("ddd"); 
} 

//获得某月的天数 12表示12月
function getMonthDays(y,m){
  var d = new Date(y, m+1, 0);    
  return  d.getDate();    
}   

//获得本季度的开始月份   
function getQuarterStartMonth(){  
	var m = new Date().getMonth();
  var qM = 0;   
  if(m<3) qM = 0;
  if(2<m && m<6) qM = 3;  
  if(5<m && m<9) qM = 6;    
  if(m>8) qM = 9;  
  return qM;   
}   

//获得本周的开始日期   
function getWeekStartDate(o) {
	if(typeof(o) == "undefined" || o.constructor!=Date) o = new Date();
	o.setDate(o.getDate()-o.getDay());
  return formatDate(o);   
}   

//获得本周的结束日期   
function getWeekEndDate(o) {    
	if(typeof(o) == "undefined" || o.constructor!=Date) o = new Date();
	o.setDate(o.getDate()-o.getDay()+6);
  return formatDate(o);   
}  
//获得本月的开始日期   
function getMonthStartDate(o){
	if(typeof(o) == "undefined" || o.constructor!=Date) o = new Date();
	o.setDate(1);
  return formatDate(o);   
}    

//获得某月的结束日期(默认本月)   
function getMonthEndDate(o){ 
	if(typeof(o) == "undefined" || o.constructor!=Date) o = new Date();
	var m = o.getMonth();
	o.setMonth(m+1);
  o.setDate(0);
  return formatDate(o);   
}   

//获得上月开始时间
function getLastMonthStartDate(o){
	if(typeof(o) == "undefined" || o.constructor!=Date) o = new Date();
	var m = o.getMonth();
	o.setMonth(m-1);
	o.setDate(1);
  return formatDate(o); 
}

//获得上月结束时间
function getLastMonthEndDate(o){
	if(typeof(o) == "undefined" || o.constructor!=Date) o = new Date();
	o.setDate(0);
   return formatDate(o);
}
  
//获得本季度的开始日期   
function getQuarterStartDate(){   
	var d = new Date();
	d.setMonth(getQuarterStartMonth(), 1);
  return formatDate(d);   
}   

//获取本季度的结束日期   
function getQuarterEndDate(){ 
	var d = new Date();
	var qM = getQuarterStartMonth() + 3; 
	d.setMonth(qM, 0);
  return formatDate(d);   
}
/**
*获取下一个周几的日期，从哪个日期算起
*/
function getNextDate(o,weekFalg){//0--7;
	if(typeof(o) == "undefined" || (o.constructor!=Date && o.constructor!=String)) o = new Date();
	if(o.constructor==String)  o = std(o);
	var day = o.getDay();
	var plusDays = 0;
	day = (day+1)%7;
	if(weekFalg==0) weekFalg=7;
	if(day>=weekFalg) 7-day+weekFalg;
	if(day<weekFalg)  weekFalg-day;
	plusDays = day>=weekFalg?7-day+weekFalg:weekFalg-day;
	return formatDate(plusOrMinDays(plusDays,o));
}

function getDateI18nString(o){
	if(typeof(o) == "undefined" || (o.constructor!=Date && o.constructor!=String)) o = new Date();
	if(o.constructor==String){
		o = std(o);
	}  
	var now = new Date();
	if(formatDate(now)==formatDate(o)){
		return "今日";
	}
	if(formatDate(plusOrMinDays(1))==formatDate(o)){
		return "明日";
	}
	return o.format("M月d日");
}
function toChineseDateString(o){
	if(typeof(o) == "undefined" || (o.constructor!=Date && o.constructor!=String)) o = new Date();
	if(o.constructor==String)  o = std(o);
	return o.format("yyyy年MM月dd日");
}
function toChineseDateMDString(o){
	if(typeof(o) == "undefined" || (o.constructor!=Date && o.constructor!=String)) o = new Date();
	if(o.constructor==String)  o = std(o);
	return o.format("MM月dd日");;
}
function getTeeDateString(obj){
	return getDateI18nString(obj)+" "+getDateWeek(obj);
}
function returnFloat0(value) {  //将小数点清零
    value = Math.round(parseFloat(value));
    return value;
   } 

function returnFloat1(value) { //保留一位小数点
    value = Math.round(parseFloat(value) * 10) / 10;
    	return value;
   }
function getQuantity(q){
	if(isNaN(q) || !isFinite(q)) q = 0;
	if(q!=0 && q%10==0 && q!=10){
		q = q/10;
		getQuantity(q);
	}
	return q;
}
function isScrollBottom(){
	var scrollTop = $(window).scrollTop();
	var scrollHeight = $(document).height();
	var windowHeight = $(window).height();
	return scrollTop + windowHeight == scrollHeight;
}
