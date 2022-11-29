
var mp=new Object();
mp.sec=5;
mp.seq=0;

_pview=$$('pview');
_ppage=$$('ppage');
mp.pic=_pview.firstChild;
//查看原图
mp.open=function()
{
  window.open(mp.pic.src.replace('/B_','/S_'));
};

//多图 单图 切换
mp.list=function(b)
{
  $$('plist').style.display=b?'':'none';
  $$('pfooter').style.display=$$('pbody').style.display=b?'none':'';
  for(var i=0;i<6;i++)
  {
    if(i==5)b=!b;
    $$('btn'+i).style.display=i<2||b?'none':'';
  }
};

//自动切换
mp.start=function(b)
{
  mp.auto=b;
  if(b)
    mp.sint=setInterval(function(){if(parseInt(new Date().getTime()/1000)%mp.sec>0)return;mp.view(true);},1000);
  else
    clearInterval(mp.sint);
  for(var i=0;i<3;i++)
  {
    if(i==2)b=!b;
    $$('btn'+i).style.display=b?'':'none';
  }
};

//间隔 菜单
mp.menu=function(b)
{
  b0=$$('btn0');
  ms=$$('menu').style;
  if(!b)
  {
    mp.mint=setTimeout("b0.className='';ms.display='none';",50);
    return;
  }else
    clearTimeout(mp.mint);
  b0.className='pmove';
  ms.display='';
  ms.left=mt.left(b0);
  ms.top=mt.top(b0)+28;
};
//选择 间隔
mp.time=function(i)
{
  mp.sec=i;
  $$('btn0').innerHTML=i+'秒';
  mp.menu(false);
};

//箭头
for(var i=0;i<2;i++)
{
  t=$$('blr'+i);
  t.style.marginTop=-_pview.scrollWidth/2+80+'px';
  t.onmouseover=function(){clearTimeout(mp.aint);}
}
$$('blr0').style.marginLeft='20px';
$$('blr1').style.marginLeft=_pview.scrollWidth-80+'px';

mp.arrow=function(event,b)
{
  if((event.srcElement||event.target).onmouseover)return;//左右箭头
  if(b)
  {
    clearTimeout(mp.aint);
    b=event.clientX<(mt.left(_pview)+_pview.scrollWidth/2)?'0':'1';
    $$('blr'+(b==0?1:0)).style.display='none';
    $$('blr'+b).style.display='';
  }else
    mp.aint=setTimeout("for(var i=0;i<2;i++)$$('blr'+i).style.display='none';",100);
};
//换图
mp.view=function(b)
{
  _parr=_ppage.childNodes;
  _parr[mp.seq].className='';
  if(typeof(b)=='number')
  {
    mp.list(false);
    mp.seq=b;
  }else
  {
    var i=mp.seq+(b||-1);
    if(i<0||i>mpa.length-1)
	{
	  if(!mp.auto)mt.show("/jsp/type/album/AlbumLast.jsp?node="+node.id,1,"更多组图",564,400);
	  mp.start(false);//暂停
	  return;
	}
	mp.seq=i;
  }

  ps=mp.pic.style;
  var opa=100;
  pinter=setInterval(function()
  {
	opa-=20;
    ps.filter="alpha(opacity="+(opa)+")";
    ps.opacity=opa/100;
    if(opa>0)return;
    clearInterval(pinter);
	mp.pic.removeAttribute("width");
	mp.pic.src='/tea/image/public/load3.gif';
    ps.opacity=1;
    ps.filter="";
    mp.pic.src="/res/"+node.community+"/album/"+parseInt(mpa[mp.seq].album/10000)+"/B_"+mpa[mp.seq].album+".jpg";
	//
    $$('pcount').innerHTML=(mp.seq+1)+'/'+mpa.length;
	$$('psubject').innerHTML=mpa[mp.seq].subject;
	$$('pcontent').innerHTML=mpa[mp.seq].content;
	_parr[mp.seq].className='cur';
	//自动滚动小图
	var oldl=_ppage.scrollLeft;
	var dtop=document.body.scrollTop;
	_parr[mp.seq].focus();
	document.body.scrollTop=dtop;
	oldl-=_ppage.scrollLeft;
	if(oldl!=0)
	{
	  _ppage.scrollLeft+=oldl;
	  mp.page(oldl<0);
	}

  },50);
};

//下一页
mp.page=function(b)
{
  w=mt.isIE?parseInt(_ppage.currentStyle.width):550;
  for(var i=w;i>0;i-=2)
  {
    _ppage.scrollLeft+=b?2:-2;
  }
  $$('btn7').className=_ppage.scrollLeft<1?'pdis':'';
  $$('btn8').className=_ppage.scrollLeft+w<_ppage.scrollWidth?'':'pdis';
};


mp.pic.src="/res/"+node.community+"/album/"+parseInt(mpa[mp.seq].album/10000)+"/B_"+mpa[mp.seq].album+".jpg";
mp.start(false);
mp.page(false);
mp.view(0);
