
var _drag={}
var zindex=1000
if(!document.all){
	Event.prototype.__defineGetter__("x",function(){return this.clientX})
	Event.prototype.__defineGetter__("y",function(){return this.clientY})
}
function msg(content,title,script){
	var div=document.createElement("DIV")
	div.style.cssText="width:400px;height:170px;position:absolute;border:1px solid #cacaca;background:#FFF;filter:progid:DXImageTransform.Microsoft.Shadow(color=#CCCCCC,direction=135 ,strength=5 )"
	var html='<div style="border-bottom:1px solid #cacaca;height:25px;background:#f0f0f0;font-size:14px;line-height:25px;padding-left:20px;cursor:move"><span style="float:left;padding-top:3px">#title#</span></div>\
				<div style="height:60px;text-align:center;padding-top:40px"><span class="mp_link">#content#</span></div>\
				<div style="text-align:center;height:30px;line-height:30px"></div>'
	title=title==null?"系统提示信息":title
	div.style.left=(document.body.clientWidth-400)/2+"px"
	div.style.top=(scrolltop()+(bodyHeight()-170)/3)+"px"
	zindex++
	div.style.zIndex=zindex
	div.innerHTML=html.replace("#title#",title).replace("#content#",content)

	var pf=document.createElement("iframe")
	pf.style.cssText="width:400px;height:170px;position:absolute;background:#FFF;z-index:999;filter:alpha(opacity=0);-moz-opacity:0"
	pf.style.left=(document.body.clientWidth-400)/2+"px"
	pf.style.top=(scrolltop()+(bodyHeight()-170)/3)+"px"
	document.body.appendChild(pf)
	//开始移动
	div.firstChild.onmousedown=function(e){
		e=e||event
		_drag.obj=div
		_drag.obj2=pf
		var a=getxy(div)
		_drag.x=e.x-a[1]
		_drag.y=e.y-a[0]
	}
	div.onmousedown=function(){
		zindex++
		div.style.zIndex=zindex
	}
	document.body.appendChild(div)
	//关闭按钮
	var x=document.createElement("INPUT")
	x.type="button"
	x.style.cssText="float:right;cursor:pointer;width:17px;height:17px;border:0px;background:url(http://image2.sina.com.cn/pay/quanzi/icon/w_close.gif);margin:3px"
	div.firstChild.appendChild(x)
	var bt=document.createElement("INPUT")
	bt.type="button"
	bt.value="确定"
	bt.style.cssText="text-align:center;width:114px;height:22px;border:0;background:url(\'http:\/\/image2.sina.com.cn/blog/tmpl/v3/control/images/tmpl_btn_bg.gif\');line-height:22px; cursor:pointer;"
	div.lastChild.appendChild(bt)
	var pb=document.createElement("DIV")
	pb.style.cssText="position:absolute;top:0px;left:0px;width:100%;background:#FFF;z-index:999;filter:alpha(opacity=0);-moz-opacity:0"
	pb.style.height=document.body.clientHeight+"px"
	document.body.appendChild(pb)


	x.onclick=function(){
		oDel(div)
		oDel(pb)
		oDel(pf)
	}
	bt.onclick=function(){
		if(script!=null&&script!="")
			eval(script)
		div.parentNode.removeChild(div)
		oDel(pb)
		oDel(pf)
	}
}
function oDel(obj){obj.parentNode.removeChild(obj)}
function addEvent(obj,eventName,eventFunc){
	if(obj.attachEvent)
	{
		obj.attachEvent(eventName,eventFunc);
	}
	else if(obj.addEventListener)
		{eventName = eventName.toString().replace(/on(.*)/i,'$1');
			obj.addEventListener(eventName,eventFunc,true);
		}
}
AddEventToBody()
function AddEventToBody(){
	if(document.body){
		addEvent(document.body, "onmouseup", emptyDrag);
		addEvent(document.body, "onmousemove", moveDrag);
	}
	else{
		window.setTimeout("AddEventToBody()", 100);
	}
}

function emptyDrag(){
	_drag={}
}


function moveDrag(e){
	if(typeof(_drag) != 'undefined' && _drag.obj!=null){
		e=e||event
		_drag.obj.style.left=(e.x-_drag.x)+"px"
		_drag.obj.style.top=(e.y-_drag.y)+"px"
		_drag.obj2.style.left=(e.x-_drag.x)+"px"
		_drag.obj2.style.top=(e.y-_drag.y)+"px"
	}
}

function getxy(e){
	var a=new Array()
	var t=e.offsetTop;
	var l=e.offsetLeft;
	var w=e.offsetWidth;
	var h=e.offsetHeight;
	while(e=e.offsetParent){
		t+=e.offsetTop;
		l+=e.offsetLeft;
	}
	a[0]=t;a[1]=l;a[2]=w;a[3]=h
  return a;
}
function bodyHeight(){
	var cobj = document.body;
	while(cobj.scrollTop == 0 && cobj.parentNode) {
		if(cobj.tagName.toLowerCase() == 'html') break;
		cobj = cobj.parentNode;
	}
	return cobj.clientHeight;
}
function scrolltop(){
	var cobj = document.body;
	while(cobj.scrollTop == 0 && cobj.parentNode) {
		if(cobj.tagName.toLowerCase() == 'html') break;
		cobj = cobj.parentNode;
	}
	return cobj.scrollTop;

}
////////////////////////////////////////////////////////////////////////////////
function showLoading(msg) {
	var loaddiv = document.getElementById('loading_div');
	if(loaddiv == null) {
		loaddiv = document.createElement('div');
		loaddiv.id = 'loading_div';
		loaddiv.style.cssText = 'position:absolute;dislay:none;z-index:5;color:#666;width:200px;height:60px;padding:10px;text-align:center;font-size:12px;';
		document.body.appendChild(loaddiv);
	}
	if(msg == null) msg = '处理中，请稍候…';
	loaddiv.innerHTML = msg+'<img src="http://image2.sina.com.cn/pay/quanzi/bbs/waiting.gif" alt="" style="display:block;" />';

	var editarea = document.getElementById('wEdit');
	if(editarea) {
		var a=getxy(editarea);
		loaddiv.style.left=(a[1]+(a[2]-200)/2)+"px";
		loaddiv.style.top=(a[0]+(a[3]-60)/2)+"px";
	} else {
		loaddiv.style.left=(document.body.clientWidth-200)/2+"px";
		loaddiv.style.top=(scrolltop()+(bodyHeight()-60)/2)+"px";
	}
	loaddiv.style.display = 'block';
}
function hideLoading() {
	var loaddiv = document.getElementById('loading_div');
	if(loaddiv) loaddiv.style.display = 'none';
}

function showMsg(content,title,script) {
	hideLoading();
	msg(content,title,script);
}
