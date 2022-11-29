var sup={};


sup.query=function()
{
  var h2=document.getElementsByTagName('H2')[0];
  h2.innerHTML="<a href='###' style='float:right;margin-right:30px'>展开</a>查询";
  h2.onclick=function(a,b)
  {
    mt.hidden(form1);
	mt.attach();
	this.firstChild.innerHTML=form1.style.display=='none'?'展开':'收起';
	if(!b)cook.set('qdisplay',form1.style.display);
  };
  if(cook.get('qdisplay')!='none')h2.onclick(null,true);
};

sup.hquery=function()
{
  var search=document.createElement('A');
  search.href="###";
  search.className='searchImg';
  search.innerHTML='<img src=/res/jskxcbs/structure/searchImg.gif />';
  search.onclick=function()
  {
    mt.hidden(form1);
    mt.attach();
  };
  var h1=document.getElementsByTagName('H1')[0];
  h1.parentNode.insertBefore(search,h1);

  var arr=form1.elements;
  for(var i=0;i<arr.length;i++)
  {
    if(/submit|button|hidden/.test(arr[i].type))continue;
	var v=arr[i].value;
	if(arr[i].tagName=='SELECT'&&v=='0')v='';
	if(v.length>0)
	{
	  search.onclick();
	  break;
	};
  }
};


sup.bold=function(s)
{
  //调整顺序
  var seq=1,trs=form2.getElementsByTagName("TR");
  for(var i=1;i<trs.length;i++)
  {
    var t=trs[i];
    if(s.indexOf('|'+t.getAttribute('state')+'|')==-1)continue;
	t.className='bold';
	t.parentNode.insertBefore(t,trs[seq++]);
  }
  //调整序号
  if(trs.length<3||seq==1)return;
  if(trs[0].children[0].innerHTML=='序号')
  for(var i=1;i<trs.length;i++)
  {
	var t=trs[i].children[0];
	if(t.colSpan==1)t.innerHTML=i;
  }
};


var ltip;
mt.ltip=function(a)
{
  if(!ltip)
  {
    ltip=document.createElement('DIV');
    ltip.innerHTML="<div style='background-color:#2D3030; margin-left:5px; color:#FFFFFF; text-align:left; padding:10px; width:70px; height:11px;'></div>";
    ltip.style.cssText="position:absolute; background-image:url(/res/GYS/structure/tip.gif);";
    var body=document.body;
    body.insertBefore(ltip,body.firstChild);
  }
  if(mt.isIE)a=event;

  var s=ltip.style;
  if(a.type=='mouseover')
  {
    var t=a.srcElement||a.target;
    ltip.firstChild.innerHTML=t.alt;

    s.left=mt.left(t)+t.offsetWidth+"px";
    s.top=mt.top(t)-10+"px";
    s.display='';
  }else if(a.type=='mouseout')
    s.display='none';
};



mt.tipx=function(t)
{
  var arr=document.getElementsByTagName(t);
  for(var i=0;i<arr.length;i++)
  {
	 if(!arr[i].title)continue;
	 arr[i].onmouseover=arr[i].onmouseout=function(a)
     {
       a=a||event;
       if(a.type=='mouseover')
       {
         var t=a.srcElement||a.target;
         mt.tip(t,t.titlex);
         clearTimeout(mt.tip.inter);
       }else if(a.type=='mouseout')
         mt.tip.bg.display='none';
     };
	 arr[i].titlex=arr[i].title;
	 arr[i].title='';
  }
};
