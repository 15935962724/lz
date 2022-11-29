

//分类页////////////////////////////////////////////////////////////////
var cat=new Object();
cat.init=function()
{
  comp.show();
  //预览 大图
  if(frmq.view.value=='0')
  {
    document.write("<div style='display:none;position:absolute' id='pre'>111</div>");
    var is=$('list').getElementsByTagName("IMG");
    for(var i=0;i<is.length;i++)
    {
      is[i].onmouseover=function()
      {
	   var d=$('pre');
       d.innerHTML="<img src='"+this.src.replace('_t','_b')+"' />";
       s=d.style;
       s.display='';
       s.left=mt.left(this)+80+'px';
       s.top=mt.top(this)+'px';
      }
      is[i].onmouseout=function()
      {
       $('pre').style.display='none';
      }
    }
  }
}
function f_scate(a)
{
if(a.tagName!='TABLE')a=a.nextSibling;
a.style.display='';
}
function f_hcate(a)
{
if(a.tagName!='TABLE')a=a.nextSibling;
a.style.display='none';
}

cat.show=function(a,b)
{
  d=(b?a:a.parentNode).parentNode.nextSibling,s=d.style;
  a.className=s.display=='none'?'show':'hidden';
  s.display=s.display=='none'?'':'none';
}

//商品筛选
cat.q=function(n,v1,v2)
{
  if(n=='price')
  {
    frmq.pmin.value=v1;
    frmq.pmax.value=v2;
  }else
  eval('frmq.'+n).value=v1;
  //隐藏 空条件
  var t=frmq.elements;
  for(var i=0;i<t.length;i++)if(t[i].value==''||t[i].value=='0')t[i].disabled=true;
  frmq.submit();
}
//显示全部分类
cat.more=function(a)
{
  a=a.parentNode.parentNode.parentNode.previousSibling;
  mt.hidden(a);
}



//产品页////////////////////////////////////////////////////////////////
var pro=new Object();
pro.move=function(i)
{
  $('t_img').scrollLeft+=i;
}
pro.picture=function()
{
  var is=$('t_img').childNodes;
  for(var i=0;i<is.length;i++)
  {
    is[i].onmouseover=function()
    {
      if(!arguments[0])this.className='over';
      var bi=$("b_img");
      bi.src=this.src.replace('_t','_b');
      mt.magnify(bi,this.src.replace('_t','_s'));
    }
    is[i].onmouseout=function(){this.className=''}
  }
  is[0].onmouseover(1);
}
pro.qua=function(i)
{
  i+=parseInt(fcar.quantity.value);
  if(isNaN(i)||i<1||i>1000)i=1;
  fcar.quantity.value=i;
}

//评论:有用 or 没用
pro.mark=function(a,v,b)
{
  a.onclick=null;
  var f=document.createElement("B");
  f.innerHTML='+1';
  f.style.cssText="color:#FF0000;position:absolute;margin-left:50px;margin-top:0px;opacity:1";
  a.parentNode.insertBefore(f,a);
  _1i=setInterval(function(){
    s=f.style;
    s.opacity-=0.2;
    s.filter="alpha(opacity="+(s.opacity*100)+")";
    s.marginTop=parseInt(s.marginTop)-5+'px';
    if(s.opacity>0)return;
    clearInterval(_1i);
    mt.post("/Reviews.do?act=mark&review="+v+"&mark="+b);
    var rs=/\d+/.exec(a.value);
    a.value=a.value.replace(rs[0],parseInt(rs[0])+1);
  },100);
}

//评论: 回复
pro.repay=function(r)
{
  mt.show("<textarea id='_q' cols='28' rows='5'></textarea>",2,"发表回复");
  mt.ok=function()
  {
    var v=$('_q').value;
	if(v=='')return;
	mt.post("/Reviews.do?act=repay&review="+r,v);
  }
}

//最近浏览过的商品
pro.hadd=function(p)
{
  p='|'+p+cookie.get('history','|').replace('|'+p+'|','|');
  cookie.set('history',p);
}
pro.hclear=function()
{
  $('history').innerHTML='暂无记录！';
  cookie.remove('history');
}

pro.init=function(a)
{
  pro.picture();
  pro.hadd(a);

//颜色
  var as=$('pcolor'),pcl;
  if(as)
  {
    as=as.childNodes;
    for(var i=0;i<as.length;i++)
    {
      as[i].onmouseover=function(){if(pcl!=this)this.className='over';}
      as[i].onmouseout =function(){if(pcl!=this)this.className=''}
	  as[i].onclick=function()
	  {
	    if(pcl)pcl.className='';
	    (pcl=this).className='click';
		fcar.pcolor.value=this.value;
	  }
    }
	//as[0].onclick();
  }
//尺码
  var as=$('psize'),psl;
  if(as)
  {
    as=as.childNodes;
    for(var i=0;i<as.length;i++)
    {
      as[i].onmouseover=function(){if(psl!=this)this.className='over';}
      as[i].onmouseout =function(){if(psl!=this)this.className=''}
      as[i].onclick=function()
	  {
	    if(psl)psl.className='';
	    (psl=this).className='click';
		fcar.psize.value=this.value;
	  }
    }
	//as[0].onclick();
  }
}




//图片页////////////////////////////////////////////////////////////////
var pic=new Object();
pic.init=function()
{
  pic.is=$('t_img').childNodes;
  pic.seq=0;
  for(var i=0;i<pic.is.length;i++)
  {
    eval("pic.is[i].onclick=function(){pic.is[pic.seq].className='';pic.seq="+i+";this.className='over';$('s_img').src=this.src.replace('_t','_s');}");
  }
  pic.is[pic.seq].onclick();
}
pic.move=function(i)
{
  i+=pic.seq;
  if(i<0)i=pic.is.length-1;else if(i>pic.is.length-1)i=0;
  pic.is[i].onclick();
}
pic.but=function(b)
{
  $('s_bug').style.display=b?"":"none";
}



//购物车
var car=new Object();
/*car.add=function(p,f,nexturl)
{
  //cookie.remove('cart');
  f>0?f:f=1;
  var id=p;
  var c=cookie.get('cart','|');
  if(c.indexOf(p)!=-1){
	  var d=c.split("|");
	  var t=c.substring(c.indexOf(p), (c.indexOf(p)+(p+"").length+2));
	  for(var i=1;i<d.length;i++){
	  	//alert(d[i]);
	  	if(d[i].indexOf(p)!=-1){
	  		var e=d[i].split("&");
	  		f=Number(e[1])+Number(f);
	  		p+="&"+f;
	  		c=c.replace(t, p);
	  		cookie.set('cart',c);
	  	}

	  }
  }else{
	  p+="&"+f;
	  cookie.set('cart','|'+p+cookie.get('cart','|'));
  }
  window.open(nexturl);
  
  //alert(cookie.get('cart','|'));
  //location=location.search();
  
}*/
/*car.update=function(a,v)
{
  if(a)
  {
    if(typeof(v)=='boolean')
    {
      while(a.tagName!="INPUT")
      {
    	  if(v)
    		  a=a.previousSibling;
    	  else
    		  a=a.nextSibling;
      }
      a.value=parseInt(a.value)+(v?1:-1);
      a.onchange();
      return;
    }
    //去掉数量
    var p=a.getAttribute('product');
    p=p.substring(0,p.lastIndexOf('&'));
    //
    var q=parseInt(a.value);
    if(isNaN(q)||q<1||q>1000)a.value=q=1;
    //alert(p);
    car.set(p,parseInt(a.value));
  }
  //刷新: 商品总金额
  var r=fcar.quantity,g=0,p=0;
  if(r)
  {
    if(!r.length)r=new Array(r);
    for(var i=0;i<r.length;i++)
    {
      q=parseInt(r[i].value);
      g+=parseFloat(r[i].getAttribute('gross'))*q;
      p+=parseFloat(r[i].getAttribute('price'))*q;
    }
  }
  $('gross').innerHTML=mt.f(g,2);
  $('price').innerHTML=mt.f(p,2);
  $('total').innerHTML=mt.f(p,2);
}*/
car.update=function(a,v)
{
	//cookie.remove('cart');
	//var c=cookie.get('cart','|');
	//  alert(c);
  if(a)
  {
    if(typeof(v)=='boolean')
    {
      while(a.tagName!="INPUT")
      {
    	  if(v)
    		  a=a.previousSibling;
    	  else
    		  a=a.nextSibling;
      }
      a.value=parseInt(a.value)+(v?1:-1);
      a.onchange();
      return;
    }
    //去掉数量
    var p=a.getAttribute('product');
    //alert(p);
    //p=p.substring(0,p.lastIndexOf('&'));
    p=p.substring(0,p.indexOf('&'));
    //
    var q=parseInt(a.value);
    if(isNaN(q)||q<1||q>1000)a.value=q=1;
    //alert(p);
   // alert(p);
   // alert(a.value);
    car.set(p,parseInt(a.value));
  }
  //刷新: 商品总金额
  var r=fcar.quantity,g=0,p=0;
  if(r)
  {
    if(!r.length)r=new Array(r);
    for(var i=0;i<r.length;i++)
    {
      q=parseInt(r[i].value);
      //g+=parseFloat(r[i].getAttribute('gross'))*q;
      p+=parseFloat(r[i].getAttribute('price'))*q;
    }
  }
  /*$('gross').innerHTML=mt.f(g,2);
  $('price').innerHTML=mt.f(p,2);*/
  //$('total').innerHTML=mt.f(p,2);
}
/*car.set=function(p,q)
{
  var c=cookie.get('cart','|'),i=c.indexOf('|'+p+'&');
  if(i==-1)return;
  i+=('|&'+p).length;
  var j=c.indexOf('|',i);
  if(typeof(q)=='boolean')q=parseInt(c.substring(i,j))+(q?1:-1);
  if(isNaN(q)||q<1)q=1;
  //alert(c.substring(0,i)+q+c.substring(j));
  cookie.set('cart',c.substring(0,i)+q+c.substring(j));
  //alert(cookie.get('cart','|'));
  return q;
}*/

car.clear=function()
{
  mt.show("确定要清空购物车吗？",2);
  mt.ok=function()
  {
    cookie.remove('cart');
    /*var r=fcar.quantity;
    alert(r);
    if(!r)return;
    if(!r.length)r=new Array(r);
    for(var i=0;i<r.length;i++)
    {
      while(r[i].tagName!="TR")r[i]=r[i].parentNode;
      r[i].parentNode.removeChild(r[i]);
    }
    car.update(null,0,0);*/
    parent.location.reload();
  }
}
/*cart.count=function(){
	var count=0;
	var str=cookie.get('cart','|')+"";
	alert(str);
	strs=str.split("|");
	for (var i=1;i<strs.length ;i++)    
    {  
		var s=strs[i].split("&");
		for (var j=1;j<s.length;j++)    
	    {  
			count+=Number(s[1]); 
			
	    }
    }
	return count;
}*/
/*cart.count=function(){
	var count=0;
	var str=cookie.get('cart','|')+"";
	alert(str);
	strs=str.split("|");
	for (var i=1;i<strs.length ;i++)    
    {  
		var s=strs[i].split("&");
		for (var j=1;j<s.length;j++)    
	    {  
			count+=Number(s[1]); 
			
	    }
    }
	return count;
}*/


//用户页
var my=new Object();
my.avatar=function()
{
  mt.show("/my/MemberSetAvatar.jsp",2,"修改您的头像",450,277);
}




//分类页////////////////////////////////////////////////////////////////
var cat=new Object();
cat.init=function()
{
comp.show();
//预览 大图
if(frmq.view.value=='0')
{
  document.write("<div style='display:none;position:absolute' id='pre'>111</div>");
  var is=$('list').getElementsByTagName("IMG");
  for(var i=0;i<is.length;i++)
  {
    is[i].onmouseover=function()
    {
	   var d=$('pre');
     d.innerHTML="<img src='"+this.src.replace('_t','_b')+"' />";
     s=d.style;
     s.display='';
     s.left=mt.left(this)+80+'px';
     s.top=mt.top(this)+'px';
    }
    is[i].onmouseout=function()
    {
     $('pre').style.display='none';
    }
  }
}
}
function f_scate(a)
{
if(a.tagName!='TABLE')a=a.nextSibling;
a.style.display='';
}
function f_hcate(a)
{
if(a.tagName!='TABLE')a=a.nextSibling;
a.style.display='none';
}

cat.show=function(a,b)
{
d=(b?a:a.parentNode).parentNode.nextSibling,s=d.style;
a.className=s.display=='none'?'show':'hidden';
s.display=s.display=='none'?'':'none';
}

//商品筛选
cat.q=function(n,v1,v2)
{
if(n=='price')
{
  frmq.pmin.value=v1;
  frmq.pmax.value=v2;
}else
eval('frmq.'+n).value=v1;
//隐藏 空条件
var t=frmq.elements;
for(var i=0;i<t.length;i++)if(t[i].value==''||t[i].value=='0')t[i].disabled=true;
frmq.submit();
}
//显示全部分类
cat.more=function(a)
{
a=a.parentNode.parentNode.parentNode.previousSibling;
mt.hidden(a);
}



//产品页////////////////////////////////////////////////////////////////
var pro=new Object();
pro.move=function(i)
{
$('t_img').scrollLeft+=i;
}
pro.picture=function()
{
var is=$('t_img').childNodes;
for(var i=0;i<is.length;i++)
{
  is[i].onmouseover=function()
  {
    if(!arguments[0])this.className='over';
    var bi=$("b_img");
    bi.src=this.src.replace('_t','_b');
    mt.magnify(bi,this.src.replace('_t','_s'));
  }
  is[i].onmouseout=function(){this.className=''}
}
is[0].onmouseover(1);
}
pro.qua=function(i)
{
i+=parseInt(fcar.quantity.value);
if(isNaN(i)||i<1||i>1000)i=1;
fcar.quantity.value=i;
}

//评论:有用 or 没用
pro.mark=function(a,v,b)
{
a.onclick=null;
var f=document.createElement("B");
f.innerHTML='+1';
f.style.cssText="color:#FF0000;position:absolute;margin-left:50px;margin-top:0px;opacity:1";
a.parentNode.insertBefore(f,a);
_1i=setInterval(function(){
  s=f.style;
  s.opacity-=0.2;
  s.filter="alpha(opacity="+(s.opacity*100)+")";
  s.marginTop=parseInt(s.marginTop)-5+'px';
  if(s.opacity>0)return;
  clearInterval(_1i);
  mt.post("/Reviews.do?act=mark&review="+v+"&mark="+b);
  var rs=/\d+/.exec(a.value);
  a.value=a.value.replace(rs[0],parseInt(rs[0])+1);
},100);
}

//评论: 回复
pro.repay=function(r)
{
mt.show("<textarea id='_q' cols='28' rows='5'></textarea>",2,"发表回复");
mt.ok=function()
{
  var v=$('_q').value;
	if(v=='')return;
	mt.post("/Reviews.do?act=repay&review="+r,v);
}
}

//最近浏览过的商品
pro.hadd=function(p)
{
p='|'+p+cookie.get('history','|').replace('|'+p+'|','|');
cookie.set('history',p);
}
pro.hclear=function()
{
$('history').innerHTML='暂无记录！';
cookie.remove('history');
}

pro.init=function(a)
{
pro.picture();
pro.hadd(a);

//颜色
var as=$('pcolor'),pcl;
if(as)
{
  as=as.childNodes;
  for(var i=0;i<as.length;i++)
  {
    as[i].onmouseover=function(){if(pcl!=this)this.className='over';}
    as[i].onmouseout =function(){if(pcl!=this)this.className=''}
	  as[i].onclick=function()
	  {
	    if(pcl)pcl.className='';
	    (pcl=this).className='click';
		fcar.pcolor.value=this.value;
	  }
  }
	//as[0].onclick();
}
//尺码
var as=$('psize'),psl;
if(as)
{
  as=as.childNodes;
  for(var i=0;i<as.length;i++)
  {
    as[i].onmouseover=function(){if(psl!=this)this.className='over';}
    as[i].onmouseout =function(){if(psl!=this)this.className=''}
    as[i].onclick=function()
	  {
	    if(psl)psl.className='';
	    (psl=this).className='click';
		fcar.psize.value=this.value;
	  }
  }
	//as[0].onclick();
}
}




//图片页////////////////////////////////////////////////////////////////
var pic=new Object();
pic.init=function()
{
pic.is=$('t_img').childNodes;
pic.seq=0;
for(var i=0;i<pic.is.length;i++)
{
  eval("pic.is[i].onclick=function(){pic.is[pic.seq].className='';pic.seq="+i+";this.className='over';$('s_img').src=this.src.replace('_t','_s');}");
}
pic.is[pic.seq].onclick();
}
pic.move=function(i)
{
i+=pic.seq;
if(i<0)i=pic.is.length-1;else if(i>pic.is.length-1)i=0;
pic.is[i].onclick();
}
pic.but=function(b)
{
$('s_bug').style.display=b?"":"none";
}



//购物车
var car=new Object();
/*car.add=function(p,f,nexturl)
{
//cookie.remove('cart');
f>0?f:f=1;
var id=p;
var c=cookie.get('cart','|');
if(c.indexOf(p)!=-1){
	  var d=c.split("|");
	  var t=c.substring(c.indexOf(p), (c.indexOf(p)+(p+"").length+2));
	  for(var i=1;i<d.length;i++){
	  	//alert(d[i]);
	  	if(d[i].indexOf(p)!=-1){
	  		var e=d[i].split("&");
	  		f=Number(e[1])+Number(f);
	  		p+="&"+f;
	  		c=c.replace(t, p);
	  		cookie.set('cart',c);
	  	}

	  }
}else{
	  p+="&"+f;
	  cookie.set('cart','|'+p+cookie.get('cart','|'));
}
window.open(nexturl);

//alert(cookie.get('cart','|'));
//location=location.search();

}*/
/*car.update=function(a,v)
{
if(a)
{
  if(typeof(v)=='boolean')
  {
    while(a.tagName!="INPUT")
    {
  	  if(v)
  		  a=a.previousSibling;
  	  else
  		  a=a.nextSibling;
    }
    a.value=parseInt(a.value)+(v?1:-1);
    a.onchange();
    return;
  }
  //去掉数量
  var p=a.getAttribute('product');
  p=p.substring(0,p.lastIndexOf('&'));
  //
  var q=parseInt(a.value);
  if(isNaN(q)||q<1||q>1000)a.value=q=1;
  //alert(p);
  car.set(p,parseInt(a.value));
}
//刷新: 商品总金额
var r=fcar.quantity,g=0,p=0;
if(r)
{
  if(!r.length)r=new Array(r);
  for(var i=0;i<r.length;i++)
  {
    q=parseInt(r[i].value);
    g+=parseFloat(r[i].getAttribute('gross'))*q;
    p+=parseFloat(r[i].getAttribute('price'))*q;
  }
}
$('gross').innerHTML=mt.f(g,2);
$('price').innerHTML=mt.f(p,2);
$('total').innerHTML=mt.f(p,2);
}*/
/*car.set=function(p,q)
{
var c=cookie.get('cart','|'),i=c.indexOf('|'+p+'&');
if(i==-1)return;
i+=('|&'+p).length;
var j=c.indexOf('|',i);
if(typeof(q)=='boolean')q=parseInt(c.substring(i,j))+(q?1:-1);
if(isNaN(q)||q<1)q=1;
//alert(c.substring(0,i)+q+c.substring(j));
cookie.set('cart',c.substring(0,i)+q+c.substring(j));
//alert(cookie.get('cart','|'));
return q;
}*/

car.clear=function()
{
mt.show("确定要清空购物车吗？",2);
mt.ok=function()
{
  cookie.remove('cart');
  /*var r=fcar.quantity;
  alert(r);
  if(!r)return;
  if(!r.length)r=new Array(r);
  for(var i=0;i<r.length;i++)
  {
    while(r[i].tagName!="TR")r[i]=r[i].parentNode;
    r[i].parentNode.removeChild(r[i]);
  }
  car.update(null,0,0);*/
  parent.location.reload();
}
}
/*cart.count=function(){
	var count=0;
	var str=cookie.get('cart','|')+"";
	alert(str);
	strs=str.split("|");
	for (var i=1;i<strs.length ;i++)    
  {  
		var s=strs[i].split("&");
		for (var j=1;j<s.length;j++)    
	    {  
			count+=Number(s[1]); 
			
	    }
  }
	return count;
}*/
/*cart.count=function(){
	var count=0;
	var str=cookie.get('cart','|')+"";
	alert(str);
	strs=str.split("|");
	for (var i=1;i<strs.length ;i++)    
  {  
		var s=strs[i].split("&");
		for (var j=1;j<s.length;j++)    
	    {  
			count+=Number(s[1]); 
			
	    }
  }
	return count;
}*/


//用户页
var my=new Object();
my.avatar=function()
{
mt.show("/my/MemberSetAvatar.jsp",2,"修改您的头像",450,277);
}




//分类页////////////////////////////////////////////////////////////////
var cat=new Object();
cat.init=function()
{
comp.show();
//预览 大图
if(frmq.view.value=='0')
{
  document.write("<div style='display:none;position:absolute' id='pre'>111</div>");
  var is=$('list').getElementsByTagName("IMG");
  for(var i=0;i<is.length;i++)
  {
    is[i].onmouseover=function()
    {
	   var d=$('pre');
     d.innerHTML="<img src='"+this.src.replace('_t','_b')+"' />";
     s=d.style;
     s.display='';
     s.left=mt.left(this)+80+'px';
     s.top=mt.top(this)+'px';
    }
    is[i].onmouseout=function()
    {
     $('pre').style.display='none';
    }
  }
}
}
function f_scate(a)
{
if(a.tagName!='TABLE')a=a.nextSibling;
a.style.display='';
}
function f_hcate(a)
{
if(a.tagName!='TABLE')a=a.nextSibling;
a.style.display='none';
}

cat.show=function(a,b)
{
d=(b?a:a.parentNode).parentNode.nextSibling,s=d.style;
a.className=s.display=='none'?'show':'hidden';
s.display=s.display=='none'?'':'none';
}

//商品筛选
cat.q=function(n,v1,v2)
{
if(n=='price')
{
  frmq.pmin.value=v1;
  frmq.pmax.value=v2;
}else
eval('frmq.'+n).value=v1;
//隐藏 空条件
var t=frmq.elements;
for(var i=0;i<t.length;i++)if(t[i].value==''||t[i].value=='0')t[i].disabled=true;
frmq.submit();
}
//显示全部分类
cat.more=function(a)
{
a=a.parentNode.parentNode.parentNode.previousSibling;
mt.hidden(a);
}



//产品页////////////////////////////////////////////////////////////////
var pro=new Object();
pro.move=function(i)
{
$('t_img').scrollLeft+=i;
}
pro.picture=function()
{
var is=$('t_img').childNodes;
for(var i=0;i<is.length;i++)
{
  is[i].onmouseover=function()
  {
    if(!arguments[0])this.className='over';
    var bi=$("b_img");
    bi.src=this.src.replace('_t','_b');
    mt.magnify(bi,this.src.replace('_t','_s'));
  }
  is[i].onmouseout=function(){this.className=''}
}
is[0].onmouseover(1);
}
pro.qua=function(i)
{
i+=parseInt(fcar.quantity.value);
if(isNaN(i)||i<1||i>1000)i=1;
fcar.quantity.value=i;
}

//评论:有用 or 没用
pro.mark=function(a,v,b)
{
a.onclick=null;
var f=document.createElement("B");
f.innerHTML='+1';
f.style.cssText="color:#FF0000;position:absolute;margin-left:50px;margin-top:0px;opacity:1";
a.parentNode.insertBefore(f,a);
_1i=setInterval(function(){
  s=f.style;
  s.opacity-=0.2;
  s.filter="alpha(opacity="+(s.opacity*100)+")";
  s.marginTop=parseInt(s.marginTop)-5+'px';
  if(s.opacity>0)return;
  clearInterval(_1i);
  mt.post("/Reviews.do?act=mark&review="+v+"&mark="+b);
  var rs=/\d+/.exec(a.value);
  a.value=a.value.replace(rs[0],parseInt(rs[0])+1);
},100);
}

//评论: 回复
pro.repay=function(r)
{
mt.show("<textarea id='_q' cols='28' rows='5'></textarea>",2,"发表回复");
mt.ok=function()
{
  var v=$('_q').value;
	if(v=='')return;
	mt.post("/Reviews.do?act=repay&review="+r,v);
}
}

//最近浏览过的商品
pro.hadd=function(p)
{
p='|'+p+cookie.get('history','|').replace('|'+p+'|','|');
cookie.set('history',p);
}
pro.hclear=function()
{
$('history').innerHTML='暂无记录！';
cookie.remove('history');
}

pro.init=function(a)
{
pro.picture();
pro.hadd(a);

//颜色
var as=$('pcolor'),pcl;
if(as)
{
  as=as.childNodes;
  for(var i=0;i<as.length;i++)
  {
    as[i].onmouseover=function(){if(pcl!=this)this.className='over';}
    as[i].onmouseout =function(){if(pcl!=this)this.className=''}
	  as[i].onclick=function()
	  {
	    if(pcl)pcl.className='';
	    (pcl=this).className='click';
		fcar.pcolor.value=this.value;
	  }
  }
	//as[0].onclick();
}
//尺码
var as=$('psize'),psl;
if(as)
{
  as=as.childNodes;
  for(var i=0;i<as.length;i++)
  {
    as[i].onmouseover=function(){if(psl!=this)this.className='over';}
    as[i].onmouseout =function(){if(psl!=this)this.className=''}
    as[i].onclick=function()
	  {
	    if(psl)psl.className='';
	    (psl=this).className='click';
		fcar.psize.value=this.value;
	  }
  }
	//as[0].onclick();
}
}




//图片页////////////////////////////////////////////////////////////////
var pic=new Object();
pic.init=function()
{
pic.is=$('t_img').childNodes;
pic.seq=0;
for(var i=0;i<pic.is.length;i++)
{
  eval("pic.is[i].onclick=function(){pic.is[pic.seq].className='';pic.seq="+i+";this.className='over';$('s_img').src=this.src.replace('_t','_s');}");
}
pic.is[pic.seq].onclick();
}
pic.move=function(i)
{
i+=pic.seq;
if(i<0)i=pic.is.length-1;else if(i>pic.is.length-1)i=0;
pic.is[i].onclick();
}
pic.but=function(b)
{
$('s_bug').style.display=b?"":"none";
}



//购物车
var car=new Object();
/*car.add=function(p,f,nexturl)
{
//cookie.remove('cart');
f>0?f:f=1;
var id=p;
var c=cookie.get('cart','|');
if(c.indexOf(p)!=-1){
	  var d=c.split("|");
	  var t=c.substring(c.indexOf(p), (c.indexOf(p)+(p+"").length+2));
	  for(var i=1;i<d.length;i++){
	  	//alert(d[i]);
	  	if(d[i].indexOf(p)!=-1){
	  		var e=d[i].split("&");
	  		f=Number(e[1])+Number(f);
	  		p+="&"+f;
	  		c=c.replace(t, p);
	  		cookie.set('cart',c);
	  	}

	  }
}else{
	  p+="&"+f;
	  cookie.set('cart','|'+p+cookie.get('cart','|'));
}
window.open(nexturl);

//alert(cookie.get('cart','|'));
//location=location.search();

}*/
/*car.update=function(a,v)
{
if(a)
{
  if(typeof(v)=='boolean')
  {
    while(a.tagName!="INPUT")
    {
  	  if(v)
  		  a=a.previousSibling;
  	  else
  		  a=a.nextSibling;
    }
    a.value=parseInt(a.value)+(v?1:-1);
    a.onchange();
    return;
  }
  //去掉数量
  var p=a.getAttribute('product');
  p=p.substring(0,p.lastIndexOf('&'));
  //
  var q=parseInt(a.value);
  if(isNaN(q)||q<1||q>1000)a.value=q=1;
  //alert(p);
  car.set(p,parseInt(a.value));
}
//刷新: 商品总金额
var r=fcar.quantity,g=0,p=0;
if(r)
{
  if(!r.length)r=new Array(r);
  for(var i=0;i<r.length;i++)
  {
    q=parseInt(r[i].value);
    g+=parseFloat(r[i].getAttribute('gross'))*q;
    p+=parseFloat(r[i].getAttribute('price'))*q;
  }
}
$('gross').innerHTML=mt.f(g,2);
$('price').innerHTML=mt.f(p,2);
$('total').innerHTML=mt.f(p,2);
}*/
/*car.set=function(p,q)
{
var c=cookie.get('cart','|'),i=c.indexOf('|'+p+'&');
if(i==-1)return;
i+=('|&'+p).length;
var j=c.indexOf('|',i);
if(typeof(q)=='boolean')q=parseInt(c.substring(i,j))+(q?1:-1);
if(isNaN(q)||q<1)q=1;
//alert(c.substring(0,i)+q+c.substring(j));
cookie.set('cart',c.substring(0,i)+q+c.substring(j));
//alert(cookie.get('cart','|'));
return q;
}*/

car.clear=function()
{
mt.show("确定要清空购物车吗？",2);
mt.ok=function()
{
  cookie.remove('cart');
  /*var r=fcar.quantity;
  alert(r);
  if(!r)return;
  if(!r.length)r=new Array(r);
  for(var i=0;i<r.length;i++)
  {
    while(r[i].tagName!="TR")r[i]=r[i].parentNode;
    r[i].parentNode.removeChild(r[i]);
  }
  car.update(null,0,0);*/
  parent.location.reload();
}
}
/*cart.count=function(){
	var count=0;
	var str=cookie.get('cart','|')+"";
	alert(str);
	strs=str.split("|");
	for (var i=1;i<strs.length ;i++)    
  {  
		var s=strs[i].split("&");
		for (var j=1;j<s.length;j++)    
	    {  
			count+=Number(s[1]); 
			
	    }
  }
	return count;
}*/
/*cart.count=function(){
	var count=0;
	var str=cookie.get('cart','|')+"";
	alert(str);
	strs=str.split("|");
	for (var i=1;i<strs.length ;i++)    
  {  
		var s=strs[i].split("&");
		for (var j=1;j<s.length;j++)    
	    {  
			count+=Number(s[1]); 
			
	    }
  }
	return count;
}*/


//用户页
var my=new Object();
my.avatar=function()
{
mt.show("/my/MemberSetAvatar.jsp",2,"修改您的头像",450,277);
}




//分类页////////////////////////////////////////////////////////////////
var cat=new Object();
cat.init=function()
{
comp.show();
//预览 大图
if(frmq.view.value=='0')
{
  document.write("<div style='display:none;position:absolute' id='pre'>111</div>");
  var is=$('list').getElementsByTagName("IMG");
  for(var i=0;i<is.length;i++)
  {
    is[i].onmouseover=function()
    {
	   var d=$('pre');
     d.innerHTML="<img src='"+this.src.replace('_t','_b')+"' />";
     s=d.style;
     s.display='';
     s.left=mt.left(this)+80+'px';
     s.top=mt.top(this)+'px';
    }
    is[i].onmouseout=function()
    {
     $('pre').style.display='none';
    }
  }
}
}
function f_scate(a)
{
if(a.tagName!='TABLE')a=a.nextSibling;
a.style.display='';
}
function f_hcate(a)
{
if(a.tagName!='TABLE')a=a.nextSibling;
a.style.display='none';
}

cat.show=function(a,b)
{
d=(b?a:a.parentNode).parentNode.nextSibling,s=d.style;
a.className=s.display=='none'?'show':'hidden';
s.display=s.display=='none'?'':'none';
}

//商品筛选
cat.q=function(n,v1,v2)
{
if(n=='price')
{
  frmq.pmin.value=v1;
  frmq.pmax.value=v2;
}else
eval('frmq.'+n).value=v1;
//隐藏 空条件
var t=frmq.elements;
for(var i=0;i<t.length;i++)if(t[i].value==''||t[i].value=='0')t[i].disabled=true;
frmq.submit();
}
//显示全部分类
cat.more=function(a)
{
a=a.parentNode.parentNode.parentNode.previousSibling;
mt.hidden(a);
}



//产品页////////////////////////////////////////////////////////////////
var pro=new Object();
pro.move=function(i)
{
$('t_img').scrollLeft+=i;
}
pro.picture=function()
{
var is=$('t_img').childNodes;
for(var i=0;i<is.length;i++)
{
  is[i].onmouseover=function()
  {
    if(!arguments[0])this.className='over';
    var bi=$("b_img");
    bi.src=this.src.replace('_t','_b');
    mt.magnify(bi,this.src.replace('_t','_s'));
  }
  is[i].onmouseout=function(){this.className=''}
}
is[0].onmouseover(1);
}
pro.qua=function(i)
{
i+=parseInt(fcar.quantity.value);
if(isNaN(i)||i<1||i>1000)i=1;
fcar.quantity.value=i;
}

//评论:有用 or 没用
pro.mark=function(a,v,b)
{
a.onclick=null;
var f=document.createElement("B");
f.innerHTML='+1';
f.style.cssText="color:#FF0000;position:absolute;margin-left:50px;margin-top:0px;opacity:1";
a.parentNode.insertBefore(f,a);
_1i=setInterval(function(){
  s=f.style;
  s.opacity-=0.2;
  s.filter="alpha(opacity="+(s.opacity*100)+")";
  s.marginTop=parseInt(s.marginTop)-5+'px';
  if(s.opacity>0)return;
  clearInterval(_1i);
  mt.post("/Reviews.do?act=mark&review="+v+"&mark="+b);
  var rs=/\d+/.exec(a.value);
  a.value=a.value.replace(rs[0],parseInt(rs[0])+1);
},100);
}

//评论: 回复
pro.repay=function(r)
{
mt.show("<textarea id='_q' cols='28' rows='5'></textarea>",2,"发表回复");
mt.ok=function()
{
  var v=$('_q').value;
	if(v=='')return;
	mt.post("/Reviews.do?act=repay&review="+r,v);
}
}

//最近浏览过的商品
pro.hadd=function(p)
{
p='|'+p+cookie.get('history','|').replace('|'+p+'|','|');
cookie.set('history',p);
}
pro.hclear=function()
{
$('history').innerHTML='暂无记录！';
cookie.remove('history');
}

pro.init=function(a)
{
pro.picture();
pro.hadd(a);

//颜色
var as=$('pcolor'),pcl;
if(as)
{
  as=as.childNodes;
  for(var i=0;i<as.length;i++)
  {
    as[i].onmouseover=function(){if(pcl!=this)this.className='over';}
    as[i].onmouseout =function(){if(pcl!=this)this.className=''}
	  as[i].onclick=function()
	  {
	    if(pcl)pcl.className='';
	    (pcl=this).className='click';
		fcar.pcolor.value=this.value;
	  }
  }
	//as[0].onclick();
}
//尺码
var as=$('psize'),psl;
if(as)
{
  as=as.childNodes;
  for(var i=0;i<as.length;i++)
  {
    as[i].onmouseover=function(){if(psl!=this)this.className='over';}
    as[i].onmouseout =function(){if(psl!=this)this.className=''}
    as[i].onclick=function()
	  {
	    if(psl)psl.className='';
	    (psl=this).className='click';
		fcar.psize.value=this.value;
	  }
  }
	//as[0].onclick();
}
}




//图片页////////////////////////////////////////////////////////////////
var pic=new Object();
pic.init=function()
{
pic.is=$('t_img').childNodes;
pic.seq=0;
for(var i=0;i<pic.is.length;i++)
{
  eval("pic.is[i].onclick=function(){pic.is[pic.seq].className='';pic.seq="+i+";this.className='over';$('s_img').src=this.src.replace('_t','_s');}");
}
pic.is[pic.seq].onclick();
}
pic.move=function(i)
{
i+=pic.seq;
if(i<0)i=pic.is.length-1;else if(i>pic.is.length-1)i=0;
pic.is[i].onclick();
}
pic.but=function(b)
{
$('s_bug').style.display=b?"":"none";
}



//购物车
var car=new Object();
/*car.add=function(p,f,nexturl)
{
//cookie.remove('cart');
f>0?f:f=1;
var id=p;
var c=cookie.get('cart','|');
if(c.indexOf(p)!=-1){
	  var d=c.split("|");
	  var t=c.substring(c.indexOf(p), (c.indexOf(p)+(p+"").length+2));
	  for(var i=1;i<d.length;i++){
	  	//alert(d[i]);
	  	if(d[i].indexOf(p)!=-1){
	  		var e=d[i].split("&");
	  		f=Number(e[1])+Number(f);
	  		p+="&"+f;
	  		c=c.replace(t, p);
	  		cookie.set('cart',c);
	  	}

	  }
}else{
	  p+="&"+f;
	  cookie.set('cart','|'+p+cookie.get('cart','|'));
}
window.open(nexturl);

//alert(cookie.get('cart','|'));
//location=location.search();

}*/
car.add=function(p,f,nexturl)
{
//cookie.remove('cart');
f>0?f:f=1;
var id=p;
var c=cookie.get('cart','|');
//alert(c);

    var d=c.split("|");
    for(var i=1;i<d.length-1;i++){
        var cartP = d[i];
        //alert(cartP);
        c = c.replace(cartP,cartP.substring(0,cartP.length-1)+("0"));
        //alert(c);
        cookie.set('cart',c);
    }

if(c.indexOf(p)!=-1){
	  var d=c.split("|");
	  //var t=c.substring(c.indexOf(p), (c.indexOf(p)+(p+"").length+2));
	  var start = c.indexOf(p);
	  var t=c.substring(start,c.indexOf('|',start));
	  /*var t0=c.substring(c.indexOf(p), c.length);
	  var t=t0.substring(0,t0.indexOf("|"));*/
	  //alert(t);
	  for(var i=1;i<d.length;i++){
	  	//alert(d[i]);
	  	if(d[i].indexOf(p)!=-1){
	  		var e=d[i].split("&");
	  		f=Number(e[1])+Number(f);
	  		//p+="&"+f;
	  		p+="&"+f+"&1";
	  		c=c.replace(t, p);
	  		cookie.set('cart',c);
	  	}

	  }
}else{
	  //p+="&"+f;
	  p+="&"+f+"&1";
	  cookie.set('cart','|'+p+cookie.get('cart','|'));
}
parent.location.href=nexturl;

//alert(cookie.get('cart','|'));
//location=location.search();

}


car.addlist=function(p,f,nexturl)
{
//cookie.remove('cart');
  f>0?f:f=1;
  var id=p;
  var c=cookie.get('cart','|');
//alert(c);

  var d=c.split("|");
  for(var i=1;i<d.length-1;i++){
    var cartP = d[i];
    //alert(cartP);
    c = c.replace(cartP,cartP.substring(0,cartP.length-1)+("0"));
    //alert(c);
    cookie.set('cart',c);
  }

  if(c.indexOf(p)!=-1){
    var d=c.split("|");
    //var t=c.substring(c.indexOf(p), (c.indexOf(p)+(p+"").length+2));
    var start = c.indexOf(p);
    var t=c.substring(start,c.indexOf('|',start));
    /*var t0=c.substring(c.indexOf(p), c.length);
    var t=t0.substring(0,t0.indexOf("|"));*/
    //alert(t);
    for(var i=1;i<d.length;i++){
      //alert(d[i]);
      if(d[i].indexOf(p)!=-1){
        var e=d[i].split("&");
        f=Number(e[1])+Number(f);
        //p+="&"+f;
        p+="&"+f+"&1";
        c=c.replace(t, p);
        cookie.set('cart',c);
      }

    }
  }else{
    //p+="&"+f;
    p+="&"+f+"&1";
    cookie.set('cart','|'+p+cookie.get('cart','|'));
  }
  //parent.location.href=nexturl;
  mt.show("添加成功！",1);
  mt.ok = function(){
    parent.location.reload()
  }
//alert(cookie.get('cart','|'));
//location=location.search();

}
/*car.update=function(a,v)
{
if(a)
{
  if(typeof(v)=='boolean')
  {
    while(a.tagName!="INPUT")
    {
  	  if(v)
  		  a=a.previousSibling;
  	  else
  		  a=a.nextSibling;
    }
    a.value=parseInt(a.value)+(v?1:-1);
    a.onchange();
    return;
  }
  //去掉数量
  var p=a.getAttribute('product');
  p=p.substring(0,p.lastIndexOf('&'));
  //
  var q=parseInt(a.value);
  if(isNaN(q)||q<1||q>1000)a.value=q=1;
  //alert(p);
  car.set(p,parseInt(a.value));
}
//刷新: 商品总金额
var r=fcar.quantity,g=0,p=0;
if(r)
{
  if(!r.length)r=new Array(r);
  for(var i=0;i<r.length;i++)
  {
    q=parseInt(r[i].value);
    g+=parseFloat(r[i].getAttribute('gross'))*q;
    p+=parseFloat(r[i].getAttribute('price'))*q;
  }
}
$('gross').innerHTML=mt.f(g,2);
$('price').innerHTML=mt.f(p,2);
$('total').innerHTML=mt.f(p,2);
}*/
car.update0=function(t,p)
{
    var c=cookie.get('cart','|')

    var f = t.checked;
    if(p)
    {
        var startP = c.indexOf(p);
        if(startP!=-1){
            var cartP=c.substring(startP,c.indexOf('|',startP));
            c=c.replace(cartP, cartP.substring(0,cartP.length-1)+(f?"1":"0"));
            cookie.set('cart',c);
        }
    }else{
        var d=c.split("|");
        for(var i=1;i<d.length-1;i++){
            var cartP = d[i];
          //console.log(d[i]+"-----");
            c = c.replace(cartP,cartP.substring(0,cartP.length-1)+(f?"1":"0"));
            cookie.set('cart',c);
          //console.log(c+"-----");
        }
    }
    //刷新: 商品总金额
    var d=c.split("|"),r=fcar.quantity,p=0;
    for(var i=1;i<d.length-1;i++){
        //alert(d[i]);
      //console.log(d[i]+"-----");
        var v = d[i].split("&");
        //if(v.length>1){
        //alert(v[2]);

        var checkFlag = v[2];
        if(checkFlag==1){
            //alert(d[i]);
            if(r)
            {
                if(!r.length)r=new Array(r);
                var p2 = v[0];
                for(var j=0;j<r.length;j++)
                {
                    var product=r[j].getAttribute('product');
                    //alert(product);
                    if(product.indexOf(p2)!=-1){
                        q=parseInt(r[j].value);
                        p+=parseFloat(r[j].getAttribute('price'))*q;
                    }
                }

            }
        }
        //}
    }
    //jQuery('.total0').innerHTML=mt.f(p,2);
    jQuery('.total0').html(mt.f(p,2));
}

car.update1=function(t,p)
{
    var c=cookie.get('cart','|')
    //alert(c);
    var f = t.checked;
    if(p)
    {
        //alert("p:"+f);
        var startP = c.indexOf(p);
        if(startP!=-1){
            var cartP=c.substring(startP,c.indexOf('|',startP));
            //alert(cartP);
            c=c.replace(cartP, cartP.substring(0,cartP.length-1)+(f?"1":"0"));
            //alert(c);
            cookie.set('cart',c);
        }
    }else{
        //alert("!p:"+f);
        var d=c.split("|");
        for(var i=1;i<d.length-1;i++){
            var cartP = d[i];
            //alert(cartP);
            c = c.replace(cartP,cartP.substring(0,cartP.length-1)+(f?"1":"0"));
            //alert(c);
            cookie.set('cart',c);
        }
    }
    //刷新: 商品总金额
    var d=c.split("|"),r=fcar1.quantity,p=0;
    for(var i=1;i<d.length-1;i++){
        //alert(d[i]);
        var v = d[i].split("&");
        //if(v.length>1){
        //alert(v[2]);
        var checkFlag = v[2];
        if(checkFlag==1){
            //alert(d[i]);
            if(r)
            {
                if(!r.length)r=new Array(r);
                var p2 = v[0];
                for(var j=0;j<r.length;j++)
                {
                    var product=r[j].getAttribute('product');
                    //alert(product);
                    if(product.indexOf(p2)!=-1){
                        q=parseInt(r[j].value);
                        p+=parseFloat(r[j].getAttribute('price'))*q;
                    }
                }

            }
        }
        //}
    }
    //jQuery('.total0').innerHTML=mt.f(p,2);
    jQuery('.total1').html(mt.f(p,2));
}
car.update=function(a,v)
{
	//cookie.remove('cart');
	//var c=cookie.get('cart','|');
	//  alert(c);
if(a)
{
  if(typeof(v)=='boolean')
  {
    while(a.tagName!="INPUT")
    {
  	  if(v)
  		  a=a.previousSibling;
  	  else
  		  a=a.nextSibling;
    }
    a.value=parseInt(a.value)+(v?1:-1);
    a.onchange();
    
    //a.parentNode.parentNode.firstChild.firstChild.checked=true;//当前tr中的checkbox为true
    return;
  }
  //去掉数量
  var p=a.getAttribute('product');
  //alert(p);
  //p=p.substring(0,p.lastIndexOf('&'));
  p=p.substring(0,p.indexOf('&'));
  //
  var q=parseInt(a.value);
  if(isNaN(q)||q<1||q>1000)a.value=q=1;
  //alert(p);
 // alert(p);
 // alert(a.value);
  car.set(p,parseInt(a.value));
}
//刷新: 商品总金额
var r=fcar.quantity,g=0,p=0;
  var c=cookie.get('cart','|')
  var d=c.split("|");
if(r)
{
  if(!r.length)r=new Array(r);
  var d=c.split("|"),r=fcar.quantity,p=0;
  for(var i=1;i<d.length-1;i++){
    //alert(d[i]);
    var v = d[i].split("&");
    var checkFlag = v[2];
    if(checkFlag==1){
      if(r)
      {
        if(!r.length)r=new Array(r);
        var p2 = v[0];
        for(var j=0;j<r.length;j++)
        {
          var product=r[j].getAttribute('product');
          //alert(product);
          if(product.indexOf(p2)!=-1){
            q=parseInt(r[j].value);
            p+=parseFloat(r[j].getAttribute('price'))*q;
          }
        }

      }
    }
  }
}
/*$('gross').innerHTML=mt.f(g,2);
$('price').innerHTML=mt.f(p,2);*/
//$('total').innerHTML=mt.f(p,2);
  jQuery('.total0').html(mt.f(p,2));
}

car.updatemob=function(a,v)
{
  console.log(123);
  //cookie.remove('cart');
  //var c=cookie.get('cart','|');
  //  alert(c);
  if(a)
  {
    if(typeof(v)=='boolean')
    {
      while(a.tagName!="INPUT")
      {
        if(!v)
          a=a.previousSibling;
        else
          a=a.nextSibling;
      }
      a.value=parseInt(a.value)+(v?1:-1);
      a.onchange();

      //a.parentNode.parentNode.firstChild.firstChild.checked=true;//当前tr中的checkbox为true
      return;
    }
    //去掉数量
    var p=a.getAttribute('product');
    //alert(p);
    //p=p.substring(0,p.lastIndexOf('&'));
    p=p.substring(0,p.indexOf('&'));
    //
    var q=parseInt(a.value);
    if(isNaN(q)||q<1||q>1000)a.value=q=1;
    //alert(p);
    // alert(p);
    // alert(a.value);
    car.set(p,parseInt(a.value));
  }
//刷新: 商品总金额
  var r=fcar.quantity,g=0,p=0;
  var c=cookie.get('cart','|')
  var d=c.split("|");
  if(r)
  {
    if(!r.length)r=new Array(r);
    var d=c.split("|"),r=fcar.quantity,p=0;
    for(var i=1;i<d.length-1;i++){
      //alert(d[i]);
      var v = d[i].split("&");
      var checkFlag = v[2];
      if(checkFlag==1){
        if(r)
        {
          if(!r.length)r=new Array(r);
          var p2 = v[0];
          for(var j=0;j<r.length;j++)
          {
            var product=r[j].getAttribute('product');
            //alert(product);
            if(product.indexOf(p2)!=-1){
              q=parseInt(r[j].value);
              p+=parseFloat(r[j].getAttribute('price'))*q;
            }
          }

        }
      }
    }
  }
  jQuery('.total0').html(mt.f(p,2));
  /*$('gross').innerHTML=mt.f(g,2);
  $('price').innerHTML=mt.f(p,2);*/
//$('total').innerHTML=mt.f(p,2);
}

car.set=function(p,q)
{
var c=cookie.get('cart','|'),i=c.indexOf('|'+p+'&');
if(i==-1)return;
i+=('|&'+p).length;
//var j=c.indexOf('|',i);
var j=c.indexOf('&',i);
if(typeof(q)=='boolean')q=parseInt(c.substring(i,j))+(q?1:-1);
if(isNaN(q)||q<1)q=1;
//alert(c.substring(0,i)+q+c.substring(j));
cookie.set('cart',c.substring(0,i)+q+c.substring(j));
//cookie.set('cart',c.substring(0,i)+q+"&1"+c.substring(j+2));
//alert(cookie.get('cart','|'));
return q;
}
/*car.set=function(p,q)
{
var c=cookie.get('cart','|'),i=c.indexOf('|'+p+'&');
if(i==-1)return;
i+=('|&'+p).length;
var j=c.indexOf('|',i);
if(typeof(q)=='boolean')q=parseInt(c.substring(i,j))+(q?1:-1);
if(isNaN(q)||q<1)q=1;
//alert(c.substring(0,i)+q+c.substring(j));
cookie.set('cart',c.substring(0,i)+q+c.substring(j));
//alert(cookie.get('cart','|'));
return q;
}*/

car.clear=function()
{
mt.show("确定要清空购物车吗？",2);
mt.ok=function()
{
  cookie.remove('cart');
  /*var r=fcar.quantity;
  alert(r);
  if(!r)return;
  if(!r.length)r=new Array(r);
  for(var i=0;i<r.length;i++)
  {
    while(r[i].tagName!="TR")r[i]=r[i].parentNode;
    r[i].parentNode.removeChild(r[i]);
  }
  car.update(null,0,0);*/
  parent.location.reload();
}
}
car.del=function(a,p,n,nexturl)
{

mt.show(mt.res("确定要删除“{0}”吗？",n),2);
mt.ok=function()
{
  cookie.set('cart',cookie.get('cart').replace(new RegExp("[|]"+p.substring(0,p.lastIndexOf('&')+1)+"\\d+[|]"),"|"));
  /*while(a.tagName!="TR")a=a.parentNode;
  a.parentNode.removeChild(a);
  car.update(null,0,0);*/
  parent.location.reload();
};
}

car.delsubmit=function(a,p,n,nexturl)
{

    cookie.set('cart',cookie.get('cart').replace(new RegExp("[|]"+p.substring(0,p.lastIndexOf('&')+1)+"\\d+[|]"),"|"));
    /*while(a.tagName!="TR")a=a.parentNode;
    a.parentNode.removeChild(a);
    car.update(null,0,0);*/
    //parent.location.reload();
}

/*cart.count=function(){
	var count=0;
	var str=cookie.get('cart','|')+"";
	alert(str);
	strs=str.split("|");
	for (var i=1;i<strs.length ;i++)    
  {  
		var s=strs[i].split("&");
		for (var j=1;j<s.length;j++)    
	    {  
			count+=Number(s[1]); 
			
	    }
  }
	return count;
}*/
/*cart.count=function(){
	var count=0;
	var str=cookie.get('cart','|')+"";
	alert(str);
	strs=str.split("|");
	for (var i=1;i<strs.length ;i++)    
  {  
		var s=strs[i].split("&");
		for (var j=1;j<s.length;j++)    
	    {  
			count+=Number(s[1]); 
			
	    }
  }
	return count;
}*/


//用户页
var my=new Object();
my.avatar=function()
{
mt.show("/my/MemberSetAvatar.jsp",2,"修改您的头像",450,277);
}


