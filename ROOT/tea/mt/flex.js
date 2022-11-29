
var fit=true;
window.dispatchJQueryEvent=function(elementId,eventName,args)
{
  switch(eventName)
  {
    case 'onInitializationComplete'://加载进度
    break;
    case 'onDocumentLoading'://开始读取文档_关闭进度
    break;
    case 'onProgress':
	mt.progress(args[0],args[1],'读取文档中...');
    break;
    case 'onCurrentPageChanged'://读取完成
    document.getElementById('gotoPage').value=args[0];
    break;
    case 'onFitModeChanged':
	if(args[0]=='Fit Width')
	{
	}
    break;
    case 'onScaleChanged':
    document.getElementById('setZoom').value=parseInt(args[0]*100/1.53)+"%";
    break;
    case 'onDocumentLoaded'://加载文档_转圈
	if(!swf.ok)mt.show('加载文档中...',0);
    document.getElementById('TotalPages').innerHTML="/"+args[0];//swf.getTotalPages();
	break;
	case 'onPageLoaded'://展示文档_关闭转圈
	if(args[0]==1)//同时会加载两页
	{
	  swf.ok=true;
	  setTimeout("swf.fitWidth()",0);
	  mt.close();
      document.onmousewheel=null;//删除swf中定义的js
	}
    //console.log(page);
    case 'onDocumentLoadedError':
    //console.log(err);
    case 'onExternalLinkClicked':
    //console.log(link);
    break;
    case 'onDocumentPrinted':
    break;
    default:
  }
//  console.log(elementId+'=='+eventName+"=");
//  for(var i=0;i<args.length;i++)
//  {
//    console.log('  '+i+":"+args[i]);
//  }
};

//<input type="button" value="单页" onclick="swf.switchMode('Portrait');" />
//<input type="button" value="双页" onclick="swf.switchMode('TwoPage');" />
//<input type="button" value="缩略图" onclick="w.switchMode('Tile');" />

var swf,tb;
//toolbar:3162111
mt.flex=function(p,toolbar)
{
  var htm="<div id='toolbar' onselectstart1='return false;'>";
  var TOOLBARIMAGE=["","<a href='javascript:;' id='logo'></a>","<a href='javascript:;' id='ArrowCursor' title='拖曳页面'></a>","<a href='javascript:;' id='TextSelectorCursor' title='选择文本'></a>","<a href='javascript:;' id='zoomOut' title='缩小'></a><a href='javascript:;' id='zoomIn' title='放大'></a>","<input id='setZoom' title='缩放'/>","<a href='javascript:;' id='fitWidth' title='适合宽度'></a>","<a href='javascript:;' id='fitHeight' title='适合页面'></a>","<a href='javascript:;' id='prevPage' title='前一页'></a>","<input id='gotoPage'/><div id='TotalPages'></div>","<a href='javascript:;' id='nextPage' title='下一页'></a>","<input id='searchText' title='此处输入查询内容'/>","<a href='javascript:;' id='search' title='查询'></a>","<a href='javascript:;' id='rotate' title='旋转'></a>","<a href='javascript:;' id='printPaper' title='打印'></a>","<a href='javascript:;' id='fullScreen' title='全屏'></a>"];
  for(var i=1,j=1;i<TOOLBARIMAGE.length;i++,j+=j)
  {
    if(i==15)j=0x00300000;//全屏
    if((toolbar&j)!=0)htm+=TOOLBARIMAGE[i];
    if(i==3||i==7||i==10)htm+="<div id='separator'></div>";
  }
  htm+="</div>";
  document.write(htm);
  tb=document.getElementById('toolbar');
  //使用其它域的swf,js无法调用flash中的方法！
  mt.embed("http://"+location.host+"/"+(location.host.indexOf("127")==0?"tea":"images")+"/mt/flex_r.swf","100%",document.body.offsetHeight-tb.offsetHeight+"px","ElementId=flex_r&SwfFile="+encodeURIComponent("{"+host+p+"}")+"&JSONFile="+encodeURIComponent(host+p.replace("paper","json").replace(/[{}]/g,""))+"&Scale1=1.4567724550898203592814371257485&ProgressiveLoading=true&key=$cba4ca133d6fb2eef15&localeChain=zh_CN");
  //MinZoomSize=0.3
  //MaxZoomSize=5
  //Scale=0.6  (999-25.876)/668
  //FitWidthOnLoad=false //默认加载两页，两页全加载完成后才会调用
  swf=document.getElementById('flex_r');
  var tbs=tb.children;
  for(var i=0;i<tbs.length;i++)
  {
    tbs[i].hideFocus=true;
    if(tbs[i].tagName=='INPUT')
    {
      tbs[i].onkeypress=function()
      {
        if(event.keyCode!=13)return;
        if(this.id=='setZoom')
        {
          swf.setZoom(parseInt(this.value)/100*1.53);//分辨率改为110
        }else
          eval("swf."+this.id+"('"+this.value+"')");
      };
      tbs[i][mt.isIE?'onfocus':'onclick']=function()//
      {
        this.select();
      };
    }else
    tbs[i].onclick=function()
    {
      if(this.id=='search')
      {
        swf.searchText(this.previousSibling.value);
        return;
      }
      var str=this.id;
      fit=fit||str=='fitWidth';
      if(str.indexOf('zoom')==0)
      {
        var t=document.getElementById('setZoom');
        val=parseInt(t.value)+(str.charAt(4)=='O'?-25:25);
        str='setZoom('+val/100*1.53+')';
        fit=false;
      }else if(str.charAt(0)<'a')
        str="setCurrentCursor('"+str+"')";
      else
        str+="()";
      eval("swf."+str);
      return false;
    };
  }
  swf.fullScreen=function()
  {
    if(document.isFullScreen)
    {
      if(document.webkitFullscreenEnabled)
        document.webkitCancelFullScreen();
      //else if(document.mozFullScreenEnabled)
      //  document.mozCancelFullScreen();
	  //else if(document.msFullscreenEnabled)
      //  document.msExitFullscreen();
      else
        window.open(host+"/tea/mt/flex.htm?{css:''}","_ajax");
    }else
    {
      var aa=document.documentElement;
      if(document.webkitFullscreenEnabled)
        aa.webkitRequestFullscreen();
      //else if(document.mozFullScreenEnabled)//提示的是iframe的域名
      //  aa.mozRequestFullScreen();
	  //else if(document.msFullscreenEnabled)
      //  aa.msRequestFullscreen();
      else
        window.open(host+"/tea/mt/flex.htm?{css:'position:absolute;left:0;top:0;width:100%;height:100%;z-index:9999'}","_ajax");
      aa.style.cssText="position:absolute;left:0;top:0;width:100%;height:100%;background-color:#0000FF;";
    }
    document.isFullScreen=!document.isFullScreen;
  };
  if(mt.isIE)//解决IE下,浏览器也跟着滚动问题
  {
    swf.onmousewheel=function(ev)
    {
      //console.log(document.onmousewheel);//IE下此处不支持console
      this.scrollHappened(event.wheelDelta/12);
      return false;
    };
  }
  mt.show("初始化中...",0);
};
$FlexPaper=function(id){return swf};
mt.flex('/Filess.do?act=paper&node='+d.node+'&language='+d.lang+'&page=[*,0],'+d.total+'',d.toolbar);
//mt.flex('{/~3/wps_[*,0].swf?a=b&b=c,24}',d.toolbar);


//document.addEventListener('webkitfullscreenchange', // webkitfullscreenchange/mozfullscreenchange
//    function(evt)
//	{
//	  console.log(evt);
//	  if(fit)swf.fitWidth();
//        //todo 全屏状态改变时的时间处理。
//        //默认不会有任何处理，需要自己判断当前屏幕全屏与否，做出相应处理。
//    },
//    false
//);
