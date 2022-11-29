
var c3t=document.getElementById("content3_top");
if(c3t)
{
  for(var i=0;i<3;i++)
  {
    c3t=c3t.firstChild;
    if(c3t.nodeType!=1)
    {
      c3t=c3t.nextSibling;
    }
  }
}
var c3n=document.getElementById("content3_news");
if(c3n)
{
  for(var i=0;i<3;i++)
  {
    c3n=c3n.firstChild;
    if(c3n.nodeType!=1)
    {
      c3n=c3n.nextSibling;
    }
  }
}
var last=new Array(c3t,c3n);
function f_click(i,id)
{
  last[i].className='onClick_Ago';
  var con=document.getElementById(last[i].id+"_con");
  con.style.display='none';
  var edi=document.getElementById(last[i].id+"_edit");
  if(edi)edi.style.display='none';
  //
  last[i]=id;
  last[i].className='onClick_After';
  var con=document.getElementById(last[i].id+"_con");
  con.style.display='block';
  var edi=document.getElementById(last[i].id+"_edit");
  if(edi)edi.style.display='block';
}

///////////企业名片 在线聊天 免费通话
var urls=new Array("/jsp/type/company/windows/CompanyBasicinfo.jsp","/jsp/type/company/windows/CompanySynopsis.jsp","/jsp/type/company/windows/CompanyTalkback.jsp","/jsp/im/SendImMessage.jsp","/jsp/type/company/windows/EonCall1.jsp");
function f_c(obj,v,url)
{
  obj.parentNode.parentNode.nextSibling.src=url;
  var cn=obj.parentNode.childNodes;
  for(var i=0;i<cn.length;i++)
  {
    cn[i].style.background=(v!=i?"":"URL(/res/lib/u/0805/080565361.jpg) no-repeat");
  }
}
function f_show(n,hits,i,d)
{
  if(!d)d=location.host;
  var title="<span id=company_menu><a href=javascript:; onclick=f_c(this,0,'http://"+d+urls[0]+"?node="+n+"');>名 片</a><a href=javascript:; onclick=f_c(this,1,'http://"+d+urls[1]+"?node="+n+"');>企业简介</a><a href=javascript:; onclick=f_c(this,2,'http://"+d+urls[2]+"?node="+n+"');>给我留言</a><a href=javascript:; onclick=f_c(this,3,'http://"+d+urls[3]+"?node="+n+"');>在线洽谈</a><a href=javascript:; onclick=f_c(this,4,'http://"+d+urls[4]+"?node="+n+"');>免费通话</a></span>";
  var footer=location.host+"浏览统计"+hits+"次 | <a href=/servlet/AddToFavorite?node="+n+" target=_blank>收藏</a>";
  showDialog(title,"http://"+d+urls[i]+"?node="+n,footer,373,225,"<a href=http://www.redcome.com/ target=_blank><img src=/res/lib/u/0805/080565370.jpg></a>");
}

function f_buy(node,member)
{
  if (member == null)
  {
    window.open("/servlet/StartLogin?node=" + node + "&nexturl=" + encodeURIComponent(location),'_self');
  } else
  {
    showDialog('加入购物车','/servlet/OfferBuy?node='+node+'&commodity=0&currency=1&quantity=1');
  }
}
function f_call(node,member)
{
    window.open("/jsp/eon/EonCall1.jsp?node="+node+"&member="+encodeURIComponent(member)+"&processnum=0",'_self');
}

//var tns=document.getElementsByTagName("script");
//var language=getParameter("language",tns[tns.length-1].src);

////暂未
var tmp=document.getElementById("notice_ma");
if(tmp&&tmp.innerHTML=="")
{
  tmp.innerHTML=tmp.info;//"该公司暂未添加公告";
}
var tmp=document.getElementById("NEW_OUT_DIV");
if(tmp&&tmp.innerHTML=="")
{
  tmp.innerHTML=tmp.info;//"该公司暂未添加焦点新闻";
}
var tmp=document.getElementById("gongs_jj_con");
if(tmp&&tmp.innerHTML=="")
{
  tmp.innerHTML=tmp.info;//"该公司暂未添加公司简介";
}
var tmp=document.getElementById("gongs_zz_con");
if(tmp&&tmp.innerHTML=="")
{
  tmp.innerHTML=tmp.info;//"该公司暂未添加公司资质";
}
var tmp=document.getElementById("gongs_news_con");
if(tmp&&tmp.innerHTML=="")
{
  tmp.innerHTML=tmp.info;//"该公司暂未添加公司新闻";
}
var tmp=document.getElementById("qiy_wh_con");
if(tmp&&tmp.innerHTML=="")
{
  tmp.innerHTML=tmp.info;//"该公司暂未添加企业文化";
}
var tmp=document.getElementById("products_ul");
if(tmp&&tmp.innerHTML=="")
{
  tmp.innerHTML=tmp.info;//"该公司暂未添加产品服务";
}
var tmp=document.getElementById("links_ul");
if(tmp&&tmp.innerHTML=="")
{
  tmp.innerHTML=tmp.info;//"该公司暂未添加合作伙伴";
}
