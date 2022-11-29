<%@page import="tea.entity.node.Animal"%>
<%@page import="tea.entity.Attch"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.node.AlbumList"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.node.Reserve"%>
<%@page import="tea.entity.node.Node"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.ContaintSlide{display:block;padding-bottom:0px;}
#ContaintSlideNav01,#ContaintSlideNav02,#ContaintSlideNav01 li{display:block;width:100%;max-height:auto;overflow:hidden;-webkit-transition:left 800ms ease-in 0;-moz-transition:left 800ms ease-in 0;-o-transition:left 800ms ease-in 0;-ms-transition:left 800ms ease-in 0;transition:left 800ms ease-in 0;}
#ContaintSlideNav02 li{float:left;display:block;}
#ContaintSlideNav02 img{display:block;width:100%;height:auto;}
#ContaintSlideNav03{display:block;height:auto;overflow:hidden; text-align:center; width:80px; margin:0 auto; padding-top:8px;}
#ContaintSlideNav03 a{display:block;width:10px;height:10px;overflow:hidden; cursor:pointer;background:#a3a3a3; float:left; margin-right:10px;-webkit-border-radius: 7px;
-moz-border-radius: 7px;
border-radius: 7px;}
#ContaintSlideNav03 a.active{background:#dc1f1f;}
</style>
<!--幻灯片start-->
<div class="ContaintSlide" id="ContaintSlide">
<div id="ContaintSlideNav01" class="clearfix" style="overflow: hidden; visibility: visible; list-style: none; position: relative;">
<ul id="ContaintSlideNav02" style="position: relative; overflow: hidden; -webkit-transition: left 600ms ease; transition: left 600ms ease; width: 3652px; left: -1826px;">
<%
Http h=new Http(request);
Animal a=Animal.find(h.node);
Node n=Node.find(a.getAlbum());
String arr[]=n.getFile(h.language).split("[|]");
for(int i=1;i<arr.length;i++){
	Attch al=Attch.find(Integer.parseInt(arr[i]));
	%>
	<li><img src="<%=al.path %>" alt=""></li>
	<%
}
%>


</ul>
</div>

<ul id="ContaintSlideNav03" class="clearfix">
<%
for(int i=1;i<arr.length;i++){
	%>
	<a href="#javascript(0)" class="<%=i==1?"active":"" %>"></a>
	<%
}
%>

</ul>
</div>
<!--幻灯片end-->



<script type="text/javascript">
/**
 * TouchSlider v1.2.4
 * By qiqiboy, http://www.qiqiboy.com, http://weibo.com/qiqiboy, 2012/12/05
 */
(function(window, undefined){
	
	"use strict";
	
	var hasTouch=("createTouch" in document) || ('ontouchstart' in window),
		testStyle=document.createElement('div').style,
		testVendor=(function(){
			var cases={
				'OTransform':['-o-','otransitionend'],
				'WebkitTransform':['-webkit-','webkitTransitionEnd'],
				'MozTransform':['-moz-','transitionend'],
				'msTransform':['-ms-','MSTransitionEnd'],
				'transform':['','transitionend']
			},prop;
			for(prop in cases){
				if(prop in testStyle)return cases[prop];
			}
			return false;
		})(),
		sg=[['width','left','right'],['height','top','bottom']],
		cssVendor=testVendor&&testVendor[0],
		toCase=function(str){
			return (str+'').replace(/^-ms-/, 'ms-').replace(/-([a-z]|[0-9])/ig, function(all, letter){
				return (letter+'').toUpperCase();
			});
		},
		testCSS=function(prop){
			var _prop=toCase(cssVendor+prop);
			return (prop in testStyle)&& prop || (_prop in testStyle)&& _prop;
		},
		parseArgs=function(arg,dft){
			for(var key in dft){
				if(typeof arg[key]=='undefined'){
					arg[key]=dft[key];
				}
			}
			return arg;
		},
		children=function(elem){
			var children=elem.children||elem.childNodes,
				_ret=[],i=0;
			for(;i<children.length;i++){
				if(children[i].nodeType===1){
					_ret.push(children[i]);
				}
			}
			return _ret;
		},
		each=function(arr,func){
			var i=0,j=arr.length;
			for(;i<j;i++){
				if(func.call(arr[i],i,arr[i])===false){
					break;
				}
			}
		},
		returnFalse=function(evt){
			evt=TouchSlider.fn.eventHook(evt);
			evt.preventDefault();
		},
		startEvent=hasTouch ? "touchstart" : "mousedown",
		moveEvent=hasTouch ? "touchmove" : "mousemove",
		endEvent=hasTouch ? "touchend" : "mouseup",
		transitionend=testVendor[1]||'',
		
		TouchSlider=function(id,cfg){
			if(!(this instanceof TouchSlider)){
				return new TouchSlider(id,cfg);
			}
			
			if(typeof id!='string' && !id.nodeType){
				cfg=id;
				id=cfg.id;
			}
			if(!id.nodeType){
				id=document.getElementById(id);
			}
			this.cfg=parseArgs(cfg||{},this._default);
			this.element=id;
			if(this.element){
				this.container=this.element.parentNode||document.body;
				this.setup();
			}
		}

	TouchSlider.fn=TouchSlider.prototype={
		//默认配置
		_default: {
			'id':'slider', //幻灯容器的id
			'begin':0,
			'auto':true, //是否自动开始，负数表示非自动开始，0,1,2,3....表示自动开始以及从第几个开始
			'speed':600, //动画效果持续时间 ms
			'timeout':5000,//幻灯间隔时间 ms,
			'direction':'left', //left right up down
			'align':'center',
			'fixWidth':true,
			'mouseWheel':false,
			'before':new Function,
			'after':new Function
		},
		//设置OR获取节点样式
		css:function(elem,css){
			if(typeof css=='string'){
				var style=document.defaultView && document.defaultView.getComputedStyle && getComputedStyle(elem, null) || elem.currentStyle || elem.style || {};
				return style[toCase(css)];
			}else{
				var prop,
					propFix;
				for(prop in css){
					if(prop=='float'){
						propFix=("cssFloat" in testStyle) ? 'cssFloat' : 'styleFloat';
					}else{
						propFix=toCase(prop);
					}
					elem.style[propFix]=css[prop];
				}
			}
		},
		//绑定事件
		addListener:function(e, n, o, u){
			if(e.addEventListener){
				e.addEventListener(n, o, u);
				return true;
			} else if(e.attachEvent){
				e.attachEvent('on' + n, o);
				return true;
			}
			return false;
		},
		removeListener:function(e, n, o, u){
			if(e.addEventListener){
				e.removeEventListener(n, o, u);
				return true;
			} else if(e.attachEvent){
				e.detachEvent('on' + n, o);
				return true;
			}
			return false;
		},
		eventHook:function(origEvt){
			var evt={},
				props="changedTouches touches scale target view which clientX clientY fromElement offsetX offsetY pageX pageY toElement".split(" ");
			origEvt=origEvt||window.event;
			each(props,function(){
				evt[this]=origEvt[this];
			});
			evt.target=origEvt.target||origEvt.srcElement||document;
			if(evt.target.nodeType===3){
				evt.target=evt.target.parentNode;
			}
			evt.preventDefault=function(){
				origEvt.preventDefault && origEvt.preventDefault();
				evt.returnValue=origEvt.returnValue=false;
			}
			evt.stopPropagation=function(){
				origEvt.stopPropagation && origEvt.stopPropagation();
				evt.cancelBubble=origEvt.cancelBubble=true;
			}
			if(hasTouch&&evt.touches.length){
				evt.pageX=evt.touches.item(0).pageX;
				evt.pageY=evt.touches.item(0).pageY;
			}else if(typeof origEvt.pageX=='undefined'){
				var doc=document.documentElement,
					body=document.body;
				evt.pageX=origEvt.clientX+(doc&&doc.scrollLeft || body&&body.scrollLeft || 0)-(doc&&doc.clientLeft || body&&body.clientLeft || 0);
				evt.pageY=origEvt.clientY+(doc&&doc.scrollTop  || body&&body.scrollTop  || 0)-(doc&&doc.clientTop  || body&&body.clientTop  || 0);
			}
			evt.origEvent=origEvt;
			return evt;
		},
		//修正函数作用环境
		bind:function(func, obj){
			return function(){
				return func.apply(obj, arguments);
			}
		},
		//初始化
		setup: function(){
			this.slides=children(this.element);
			this.length=this.slides.length;
			this.cfg.timeout=parseInt(this.cfg.timeout);
			this.cfg.speed=parseInt(this.cfg.speed);
			this.cfg.begin=parseInt(this.cfg.begin);
			this.cfg.auto=!!this.cfg.auto;
			this.cfg.timeout=Math.max(this.cfg.timeout,this.cfg.speed);
			this.touching=!!hasTouch;
			this.css3transition=!!testVendor; 
			this.index=this.cfg.begin<0||this.cfg.begin>=this.length ? 0 : this.cfg.begin;
			
			if(this.length<1)return false;
			
			switch(this.cfg.direction){
				case 'up':
				case 'down':this.direction=this.cfg.direction; this.vertical=1; break;
				case 'right':this.direction='right';
				default:this.direction=this.direction||'left'; this.vertical=0; break;
			}

			this.addListener(this.element,startEvent,this.bind(this._start,this),false);
			this.addListener(document,moveEvent,this.bind(this._move,this),false);
			this.addListener(document,endEvent,this.bind(this._end,this),false);
			this.addListener(document,'touchcancel',this.bind(this._end,this),false);
			this.addListener(this.element,transitionend,this.bind(this.transitionend,this),false);
			
			this.addListener(window,'resize',this.bind(function(){
				clearTimeout(this.resizeTimer);
				this.resizeTimer=setTimeout(this.bind(this.resize,this),100);
			},this),false);
			
			if(this.cfg.mouseWheel){
				this.addListener(this.element,'mousewheel',this.bind(this.mouseScroll,this),false);
				this.addListener(this.element,'DOMMouseScroll',this.bind(this.mouseScroll,this),false);
			}
			this.playing=this.cfg.auto;
			this.resize();
		},
		getSum:function(type,start,end){
			var sum=0,i=start,
				_type=toCase('-'+type);
			for(;i<end;i++){
				sum+=this['getOuter'+_type](this.slides[i]);
			}
			return sum;
		},
		getPos:function(type,index){
			var _type=toCase('-'+type),
				myWidth=this.getSum(type,index,index+1),
				sum=this.getSum(type,0,index)+this['getOuter'+_type](this.element)/2-this['get'+_type](this.element)/2;
			switch(this.cfg.align){
				case 'left':
					return -sum;
				case 'right':
					return this[type]-myWidth-sum;
				default:return (this[type]-myWidth)/2-sum;
			}
		},
		resize:function(){
			clearTimeout(this.aniTimer);
			var _this=this,css,type=sg[this.vertical][0],_type=toCase('-'+type),
				pst=this.css(this.container,'position');
			this.css(this.container,{'overflow':'hidden','visibility':'hidden','listStyle':'none','position':pst=='static'?'relative':pst});
			this[type]=this['get'+_type](this.container);
			css={float:this.vertical?'none':'left',display:'block'};
			each(this.slides,function(){
				if(_this.cfg.fixWidth){

					css[type]=_this[type]-_this['margin'+_type](this)-_this['padding'+_type](this)-_this['border'+_type](this)+'px';
				}
				_this.css(this,css);
			});
			this.total=this.getSum(type,0,this.length);
			css={position:'relative',overflow:'hidden'};
			css[cssVendor+'transition-duration']='0ms';
			css[type]=this.total+'px';
			css[sg[this.vertical][1]]=this.getPos(type,this.index)+'px';
			this.css(this.element,css);
			this.css(this.container,{'visibility':'visible'});
			this.playing && this.play();
			return this;
		},
		slide:function(index, speed){
			var direction=sg[this.vertical][1],
				type=sg[this.vertical][0],
				transition=testCSS('transition'),
				nowPos=parseFloat(this.css(this.element,direction))||0,
				endPos,css={},change,size=this.getSum(type,index,index+1);
			index=Math.min(Math.max(0,index),this.length-1);
			speed=typeof speed=='undefined' ? this.cfg.speed : parseInt(speed);
			endPos=this.getPos(type,index);
			change=endPos-nowPos, //变化量
			speed=Math.abs(change)<size?Math.ceil(Math.abs(change)/size*speed):speed;
			if(transition){
				css[transition]=direction+' ease '+speed+'ms';
				css[direction]=endPos+'px';
				this.css(this.element,css);
			}else{
				var _this=this,
					begin=0, //动画开始时间
					time=speed/10,//动画持续时间
					animate=function(t,b,c,d){ //缓动效果计算公式
						return -c * ((t=t/d-1)*t*t*t - 1) + b;
					},
					run=function(){
						if(begin<time){
							begin++;
							_this.element.style[direction]=Math.ceil(animate(begin,nowPos,change,time))+'px';
							_this.aniTimer=setTimeout(run,10);
						}else{
							_this.element.style[direction]=endPos+'px';
							_this.transitionend({propertyName:direction});
						}
					}
				clearTimeout(this.aniTimer);
				run();
			}
			this.cfg.before.call(this,index,this.slides[this.index]);
			this.index=index;
			return this;
		},
		play:function(){
			clearTimeout(this.timer);
			this.playing=true;
			this.timer=setTimeout(this.bind(function(){
				this.direction=='left'||this.direction=='up' ? this.next() : this.prev();
			},this), this.cfg.timeout);
			return this;
		},
		pause:function(){
			clearTimeout(this.timer);
			this.playing=false;
			return this;
		},
		stop:function(){
			this.pause();
			return this.slide(0);
		},
		prev:function(offset,sync){
			clearTimeout(this.timer);
			var index=this.index;
			offset=typeof offset == 'undefined'?offset=1:offset%this.length;
			index-=offset;
			if(sync===false){
				index=Math.max(index,0);
			}else{
				index=index<0?this.length+index:index;
			}
			return this.slide(index);
		},
		next:function(offset,sync){
			clearTimeout(this.timer);
			var index=this.index;
			if(typeof offset=='undefined')offset=1;
			index+=offset;
			if(sync===false){
				index=Math.min(index,this.length-1);
			}else{
				index%=this.length
			}
			return this.slide(index);
		},
		_start:function(evt){
			evt=this.eventHook(evt);
			if(!this.touching)evt.preventDefault();
			this.removeListener(this.element,'click',returnFalse);
			this.startPos=[evt.pageX,evt.pageY];
			this.element.style[toCase(cssVendor+'transition-duration')]='0ms';
			this.startTime=+new Date;
			this._pos=parseFloat(this.css(this.element,sg[this.vertical][1]))||0;
		},
		_move:function(evt){
			if(!this.startPos || evt.scale&&evt.scale!==1)return;
			evt=this.eventHook(evt);
			this.stopPos=[evt.pageX,evt.pageY];
			var direction=sg[this.vertical][1],
				type=sg[this.vertical][0],
				offset=this.stopPos[this.vertical]-this.startPos[this.vertical];
			if(this.scrolling || typeof this.scrolling=='undefined'&&Math.abs(offset)>=Math.abs(this.stopPos[1-this.vertical]-this.startPos[1-this.vertical])){
				evt.preventDefault();
				offset=offset/((!this.index&&offset>0 || this.index==this.length-1&&offset<0) ? (Math.abs(offset)/this[type]+1) : 1);
				this.element.style[direction]=this._pos+offset+'px';
				if(offset&&typeof this.scrolling=='undefined'){
					this.scrolling=true;//标记拖动（有效触摸）
					clearTimeout(this.timer);//暂停幻灯
					clearTimeout(this.aniTimer);//暂停动画
				}
			}else this.scrolling=false;
		},
		_end:function(evt){
			if(this.startPos){
				if(this.scrolling){
					var type=sg[this.vertical][0],
						direction=sg[this.vertical][1],
						offset=this.stopPos[this.vertical]-this.startPos[this.vertical],
						absOff=Math.abs(offset),
						sub=absOff/offset,
						myWidth,curPos,tarPos,
						next=this.index,off=0;
					this.addListener(this.element,'click',returnFalse);
					if(absOff>20){//有效移动距离
						curPos=parseFloat(this.css(this.element,sg[this.vertical][1]));
						do{
							if(next>=0 && next<this.length){
								tarPos=this.getPos(type,next);
								myWidth=this.getSum(type,next,next+1);
							}else{
								next+=sub;
								break;
							}
						}while(Math.abs(tarPos-curPos)>myWidth/2 && (next-=sub));
						off=Math.abs(next-this.index);
						if(!off && +new Date-this.startTime<250){
							off=1;
						}
					}
					offset>0?this.prev(off,false):this.next(off,false);
					
					this.playing && this.play();
				}
				delete this._pos;
				delete this.stopPos;
				delete this.startPos;
				delete this.scrolling;
				delete this.startTime;
			}
		},
		mouseScroll:function(evt){
			if(this.cfg.mouseWheel){
				evt=this.eventHook(evt);
				evt.preventDefault();
				var _e=evt.origEvent;
				var wheelDelta=_e.wheelDelta || _e.detail && _e.detail*-1 || 0,
					flag=wheelDelta/Math.abs(wheelDelta);
				wheelDelta>0?this.prev(1,false):this.next(1,false);
			}
		},
		transitionend:function(evt){
			if(evt.propertyName==sg[this.vertical][1]){
				this.cfg.after.call(this, this.index, this.slides[this.index]);
				this.playing && this.play();
			}
		}
	}

	each(['Width','Height'],function(i,type){
		var _type=type.toLowerCase();
		each(['margin','padding','border'],function(j,name){
			TouchSlider.fn[name+type]=function(elem){
				return parseFloat(this.css(elem,name+'-'+sg[i][1]+(name=='border'?'-width':'')))+parseFloat(this.css(elem,name+'-'+sg[i][2]+(name=='border'?'-width':'')));
			}
		});
		TouchSlider.fn['get'+type]=function(elem){
			return elem['offset'+type]-this['padding'+type](elem)-this['border'+type](elem);
		}
		TouchSlider.fn['getOuter'+type]=function(elem){
			return elem['offset'+type]+this['margin'+type](elem);
		}
	});
	
	window.TouchSlider=TouchSlider;
})(window);
</script>

<script type="text/javascript">
var active=0,
	as=document.getElementById('ContaintSlideNav03').getElementsByTagName('a');

for(var i=0;i<as.length;i++){
	(function(){
		var j=i;
		as[i].onclick=function(){
			t2.slide(j);
			return false;
		}
	})();
}
var t2=new TouchSlider({id:'ContaintSlideNav02', speed:600, timeout:6000, before:function(index){
		as[active].className='';
		active=index;
		as[active].className='active';
	}});
</script>

<script type="text/javascript">
// JavaScript Document
$(function(){
	$('#ContaintTrustCon01 li').mouseover(function(){
		$(this).addClass("Current").siblings().removeClass();
		$(".ConTrustTabs_c > div.c").eq($("#ContaintTrustCon01 li").index(this)).show().siblings().hide();
	});
   	$('#ContaintTrustCon02 li').mouseover(function(){
		$(this).addClass("Current").siblings().removeClass();
		$(".ContaintCompanyTabs_c > div.c").eq($("#ContaintTrustCon02 li").index(this)).show().siblings().hide();
	});
	 	$('#ContaintTrustCon03 li').mouseover(function(){
		$(this).addClass("Current").siblings().removeClass();
		$(".ContaintNewsTabs_C > div.c").eq($("#ContaintTrustCon03 li").index(this)).show().siblings().hide();
	});
});
$(document).ready(function() {
	$('.ConTrustReviews03 dd').hover(function(){
	$(this).toggleClass('THover');
	});
});

/*数字递增*/
$(document).ready(function () {
	var s=1;
	$(".SpecialShowYs01 li").each(function() {
		$(this).children(".SpecialI").html(s);
		s=s+1;
    });
	var i=1;
$(".StartTrust_Content_Nav03 .StartTust_Nav01").each(function() {
		$(this).find(".StartTust_N02").html(i);
		i=i+1;
    });
  });	
$(function(){
$(".ContaintCent ul:odd").addClass("ContaintCentNav01");
$(".ContaintTrustCon01 li:eq(0)").addClass("ContaintCentNav01");
$("#ConTrustListNav01 ul:last").addClass("ConTrustListNav01x");
$("#ConTrustListNav02 ul:last").addClass("ConTrustListNav01x");

$(".ContaintCent ul:eq(2)").addClass("ContaintCentNav02");
$(".ContaintCent ul:eq(3)").addClass("ContaintCentNav02");

$("#ConCompany01 li:eq(6)").addClass("ConCompany01x");
$("#ConCompany01 li:eq(7)").addClass("ConCompany01x");
$("#ConCompany01 li:eq(8)").addClass("ConCompany01x");
$("#ConCompany01 li:eq(2)").addClass("ConCompany01xy");
$("#ConCompany01 li:eq(5)").addClass("ConCompany01xy");
$("#ConCompany01 li:eq(8)").addClass("ConCompany01xy");

$("#ConCompany02 li:eq(6)").addClass("ConCompany01x");
$("#ConCompany02 li:eq(7)").addClass("ConCompany01x");
$("#ConCompany02 li:eq(8)").addClass("ConCompany01x");
$("#ConCompany02 li:eq(2)").addClass("ConCompany01xy");
$("#ConCompany02 li:eq(5)").addClass("ConCompany01xy");
$("#ConCompany02 li:eq(8)").addClass("ConCompany01xy");

$("#ContaintNewL01 ul li:last").addClass("ConTrustListNav01x");
$("#ContaintNewL02 ul li:last").addClass("ConTrustListNav01x");
$("#ContaintNewL03 ul li:last").addClass("ConTrustListNav01x");

$(".FooterCon ul:last").addClass("FooterConNav01");

$("#ConTrustListNav01 ul:last").addClass("ConTrustListNav01x");
$("#ListTrustReviews ul:odd").addClass("ListTrustReviewsNav01");

$("#ContaintNewsList ul li:eq(7)").addClass("ContaintNewsListNav01");
$("#ContaintNewsList ul li:eq(8)").addClass("ContaintNewsListNav02");
$("#ContaintNewsList ul li:eq(15)").addClass("ContaintNewsListNav01");
$("#ContaintNewsList ul li:eq(16)").addClass("ContaintNewsListNav02");
$("#ContaintNewsList ul li:last").addClass("ContaintNewsListNav03");

$("#AboutMenu ul li:eq(1)").addClass("AboutMenuNav01");
$("#AboutMenu ul li:eq(2)").addClass("AboutMenuNav02");
$("#AboutMenu ul li:eq(3)").addClass("AboutMenuNav03");
$("#AboutMenu ul li:eq(4)").addClass("AboutMenuNav04");
$("#AboutMenu ul li:eq(5)").addClass("AboutMenuNav05");
});

</script>