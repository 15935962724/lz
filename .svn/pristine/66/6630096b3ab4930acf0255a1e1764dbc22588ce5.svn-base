var common_QQ=function()
{
  this.$=function(v){return document.getElementById(v)};
  this.$$=function(o,e){return this.$(o).getElementsByTagName(e)};
  this.isFunction=function(obj){return toString.call(obj)==="[object Function]"};
  this.isArray=function(obj){return toString.call(obj)==="[object Array]"};
  this.addEventHandler=function(a,b,c)
  {
    if(a.addEventListener)
    {
      a.addEventListener(b,c,false)
    }else
    {
      if(a.attachEvent)
      {
        a.attachEvent("on"+b,c)
      }else
      {
        a["on"+b]=c
      }
    }
  };
  this.removeEventHandler=function(a,b,c)
  {
    if(a.removeEventListener)
    {
      a.removeEventListener(b,c,false)
    }else
    {
      if(a.detachEvent)
      {
        a.detachEvent("on"+b,c)
      }else
      {
        a["on"+b]=null
      }
    }
  };
  this.getStyle=function(el,style){if(!+"\v1"){style=style.replace(/\-(\w)/g,function(all,letter){return letter.toUpperCase()});var value=el.currentStyle[style];(value=="auto")&&(value="0px");return value}else{return document.defaultView.getComputedStyle(el,null).getPropertyValue(style)}};this.$A=function(c){if(!c){return[]}if("toArray"in Object(c)){return c.toArray()}var b=c.length||0,a=new Array(b);while(b--){a[b]=c[b]}return a};this.$R=function(s,e){var arr=[];for(var i=s;i<e+1;i++){arr.push(i)}return arr};this.each=function(object,callback,args){var name,i=0,length=object.length,isObj=length===undefined;if(args){if(isObj){for(name in object){if(callback.apply(object[name],args)===false){break}}}else{for(;i<length;){if(callback.apply(object[i++],args)===false){break}}}}else{if(isObj){for(name in object){if(callback.call(object[name],name,object[name])===false){break}}}else{for(var value=object[0];i<length&&callback.call(value,i,value)!==false;value=object[++i]){}}}return object}};var Ajax_QQ=function(url,callback){var xmlHttp;this.url=url;this.callback=callback;this.createXMLHttpRequest=function(){if(window.ActiveXObject){xmlHttp=new ActiveXObject("Microsoft.XMLHTTP")}else if(window.XMLHttpRequest){xmlHttp=new XMLHttpRequest()}};this.startRequest=function(){this.createXMLHttpRequest();try{xmlHttp.onreadystatechange=function(){if(xmlHttp.readyState==4){if(xmlHttp.status==200||xmlHttp.status==0){var result=xmlHttp.responseText;window.setTimeout(callback(result),50)}}};xmlHttp.open("GET",this.url,true);xmlHttp.setRequestHeader("If-Modified-Since","0");xmlHttp.setRequestHeader("Cache-Control","no-cache");xmlHttp.setRequestHeader("Charset","GB2312");xmlHttp.send(null)}catch(exception){alert("无法连接服务器!请稍后再试!")}};this.startRequest()}
