<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String act=h.get("act");
if("list".equals(act))
{
  int category=h.getInt("category");
  Iterator it=ShopCategory.findByFather(category).iterator();
  while(it.hasNext())
  {
    ShopCategory t=(ShopCategory)it.next();
    out.print("<li onclick='f_sel(this)' id='"+t.category+"'>"+MT.f(t.name[1])+"</li>");
  }
  return;
}else if("search".equals(act))
{
  String q=h.get("q");
  Iterator it=ShopCategory.find(" AND hidden=0 AND name1 LIKE "+Database.cite("%"+q+"%"),0,200).iterator();
  while(it.hasNext())
  {
    ShopCategory t=(ShopCategory)it.next();
    StringBuilder sb=new StringBuilder();
    String[] arr=t.getPath().split("[|]");
    for(int i=1;i<arr.length;i++)sb.append("<em>></em>"+MT.red(ShopCategory.find(Integer.parseInt(arr[i])).name[1],q));
    out.print("<li onclick='f_sel(this,true)' id='"+t.category+"'>"+sb.toString()+"</li>");
  }
  return;
}

int product=h.getInt("product");
ShopProduct g=ShopProduct.find(product);

int shopid = h.getInt("shopid");

ShopCategory r=ShopCategory.getRoot();


%><!DOCTYPE html><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<style type='text/css'>
#select div,#result span{border:1px solid #C7DEFF;background:#FFFFFF;width:222px;height:280px;margin-right:5px;overflow: scroll-y; float:left}
#select li,#result li{padding-left:5px}
.sel{border:1px solid #98BBD2;background:#D6EDF4;}
em{color:#A6A6A5;font-style:normal;margin:2px}
</style>
</head>
<body>
<h1>选择商品类目</h1>
<!-- 
<form name="form1" onsubmit="return mt.check(this)&&f_search()">
<table id="tablecenter">
<tr>
  <td>类目搜索<input name="q" alt="关键字"/><input type="submit" class="btn btn-primary" value="搜索"/></td>
</table>
</form>

您经常选择的类目: <select onchange="path=value;f_list();">
<%
Iterator it=ShopProduct.often(h.member).iterator();
if(!it.hasNext())
out.print("<option value='|'>暂无");
else
{
  out.print("<option value='|'>请选择");
  while(it.hasNext())
  {
    ShopCategory c=ShopCategory.find(((Integer)it.next()).intValue());
    out.println("<option value='"+c.getPath()+"'>"+c.getName(h.language));
  }
}
%>
</select>
 -->
<table id="tablecenter" cellspacing="0">
<tbody id="list">
<tr>
  <td><div id="select"><div></div><div></div><div></div><div></div><div></div></div></td>
<tr>
  <td>您当前选择的是：<span id="label"></span></td>
</tbody>
<tbody id="search" style="display:none">
<tr>
  <td><div id="result"><span style="width:100%"></span><input type="button" value="取消" onclick="f_swap(false)"/></div></td>
</tbody>
</table>

<form name="form2" action="/jsp/yl/shop/ShopProductEdit.jsp" method="get" target="" onsubmit="return mt.check(this)">
<input type="hidden" name="product" value="<%=product%>"/>
<input type="hidden" name="shopid" value="<%= shopid %>"/>
<input type="hidden" name="act" value="setcategory"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="category" alt="分类"/>
<input name="subPro" type="submit" class="btn btn-primary" value="好了，去发布商品"/>
<input type="button" value="返回"  class="btn btn-default" onclick="history.back()" />
</form>

<script>
var select=$('select').childNodes,label=$('label'),path="<%=ShopCategory.find(g.category).getPath()%>";
function f_list(t)
{
  mt.show(null,0);
  var n=t?t.nextSibling:select[0];
  //联级的隐藏
  var ns=n;
  while(ns)
  {
    ns.style.display='none';
    ns.label='';
    ns=ns.nextSibling;
  }
  n.innerHTML='';
  var c=form2.subPro.className;
  mt.send('?act=list&category='+(t?t.id:<%=r.category%>),function(h){mt.close();if(!h){form2.subPro.disabled=false;form2.subPro.className='btn btn-primary';return;}form2.subPro.disabled=true;form2.subPro.className=c+1;n.innerHTML=h;n.style.display='';f_auto(n);});
}
//自动选择
function f_auto(p)
{
  var ps=p.childNodes;
  for(var i=0;i<ps.length;i++)
  {
    if(path.indexOf('|'+ps[i].id+'|')==-1)continue;
    f_sel(ps[i]);
    break;
  }
}
function f_sel(t,b)
{
  var p=t.parentNode,ps=p.childNodes;
  for(var i=0;i<ps.length;i++)ps[i].className='';
  form2.category.value=p.id=t.id;
  p.label=t.innerHTML;
  t.className='sel';
  if(b)return;

  f_list(p);
  //当前选择
  var h='';
  for(var i=0;i<select.length&&select[i].label;i++)h+='<em>></em>'+select[i].label;
  label.innerHTML=h;
}
f_list();
function f_swap(b)
{
  $('list').style.display=b?'none':'';
  $('search').style.display=b?'':'none';
  form2.category.value='';
}
function f_search()
{
  f_swap(true);
  mt.show(null,0);
  var t=$('result').firstChild;
  mt.send('?act=search&q='+encodeURIComponent(form1.q.value),function(h){t.innerHTML=h||"抱歉，没有找到相关的类目。";t.style.display='';mt.close();});
  return false;
}
/* function f_checkLast(){
	var lastflag = true;
	for(var i=0;i<select.length&&select[i].style.display!='none';i++)
	{
		if(select[i].label=='')
		{
			lastflag = false;
			mt.show('请选择商品的具体类目！');
		}
			
	}
	return lastflag;
} */
</script>

</body>
</html>
