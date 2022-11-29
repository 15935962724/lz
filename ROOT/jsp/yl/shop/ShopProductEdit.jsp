<%@page import="tea.entity.util.Lucene"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@ page import="util.Config" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int product=h.getInt("product");
ShopProduct t=ShopProduct.find(product);
if(product==0){
	product = t.product = Seq.get();
}

int category=h.getInt("category")>0?h.getInt("category"):t.category;

ShopCategory c=ShopCategory.find(category);

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/tea/mt.js"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
<style>
.color label{border:1px solid #E4E4E4;width:15px;height:15px}
#psize input{margin-right:5px;}
</style>
</head>
<body>
<h1>商品管理</h1>
<form name="form2" action="/ShopProducts.do?repository=product/<%=product%>&product=<%=product%>" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="category" value="<%=category%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="state" value="<%= ("".equals(MT.f(t.yucode,"")))?1:t.state %>" />
<table id="tablecenter" cellspacing="0">
   <tr>
    <td>商品编号</td>
    <td><input name="yucode" value="<%=MT.f(t.yucode)%>" alt="商品编号"/></td>
  </tr>
  <tr>
    <td>品牌</td>
    <td><select name="brand" alt="品牌"><option value="0">---请选择---</option><%
    String[] ab=c.getBrand().split("[|]");
    for(int i=1;i<ab.length;i++)
    {
      int bid=Integer.parseInt(ab[i]);
      out.print("<option value="+ab[i]+(t.brand==bid?" selected":"")+">"+ShopBrand.find(bid).name[h.language]);
    }
    %></select></td>
  </tr>
  <tr>
    <td>商品分类</td>
    <td><%=c.getName(h.language)%><input type="button" class="btn btn-default" value="编辑类目" onclick="location.href='/jsp/yl/shop/ShopProductSetCategory.jsp?product=<%=product%>&nexturl='+encodeURIComponent(form2.nexturl.value);"/></td>
  </tr>
  <tr>
    <td>显示类型</td>
    <td><select name="view_type" alt="显示类型"><option value="0">---请选择---</option><%
    String[] viewArr=ShopProduct.VIEW_TYPE;
    for(int i=1;i<viewArr.length;i++)
    {
      out.print("<option value="+i+(t.view_type==i?" selected":"")+">"+viewArr[i]);
    }
    %></select></td>
  </tr>
  <tr>
    <td>名称</td>
    <td><input name="name1" value="<%=MT.f(t.name[1])%>" size="60" alt="名称"/></td>
  </tr>
  <%
  if(MT.f(c.attribute)!=null&&MT.f(c.attribute).length()>0)
  {
  %>
   <tr>
    <td><%=c.attribute %></td>
    <td><select name="model_id" alt="商品类型"><option value="">--请选择--</option><%
    	Iterator spmi = ShopProductModel.find(" AND category= " + category,0,Integer.MAX_VALUE).iterator();
    	while(spmi.hasNext()){
    		ShopProductModel spm = (ShopProductModel)spmi.next();
    		out.print("<option value="+spm.getId()+(spm.getId()==t.model_id?" selected":"")+">"+spm.getModel());
    	}
    	
    %></select></td>
  </tr>
  <%
  }
  if(c.path.indexOf(Config.getString("tps"))!=-1){
%>
    <tr>
        <td>软件大小</td>
        <td><input type="text" name="ycolor" value="<%=MT.f(t.color) %>" /></td>
    </tr>
    <tr>
        <td>软件版本</td>
        <td><input type="text" name="ysize" value="<%=MT.f(t.size) %>" /></td>
    </tr>
    <%
  }
        if(c.path.indexOf(Config.getString("shebei"))!=-1){
            %>
    <tr>
        <td>型号</td>
        <td><input type="text" name="packing" value="<%=MT.f(t.packing) %>" /></td>
    </tr>
    <%
        }

  %>
  <tr>
    <td>销售价</td>
    <td><input id="_price" <%=t.price_display==0?"":"disabled" %> name="price" value="<%=MT.f(t.price)%>" onkeyup="clearNoNum(this)" /></td>
  </tr>
	<tr>
		<td>是否隐藏价格</td>
		<td>隐藏价格：<input type="checkbox" <%=t.price_display==0?"":"checked" %> onclick="setPriceDisplay(this)" /><input type="hidden" id="_price_display" name="price_display" value="<%=MT.f(t.price_display)%>" />
			价格说明：<input name="price_type" value="<%=MT.f(t.price_type)%>" />&nbsp;&nbsp;<b>注：如选择隐藏价格，请填写价格说明，如不填写系统默认显示为“面议”</b></td>
	</tr>

	<tr>
		<td>生产厂家</td>
		<td><input type="text" name="factory" value="<%=MT.f(t.factory) %>" /></td>
	</tr>
	<tr>
		<td>所属厂商</td>
		<td><%-- <input type="text" name="puid" value="<%=MT.f(t.puid) %>" /> --%>
		<select name='puid'>
		<option value='0'>无</option>
			<%
				List<ProcurementUnit> prlist = ProcurementUnit.find(" AND deleted = 0 ", 0, Integer.MAX_VALUE);
				for(int i=0;i<prlist.size();i++){
					ProcurementUnit pu = prlist.get(i);
					out.print("<option "+(t.puid==pu.getPuid()?"selected='selected'":"")+" value='"+pu.getPuid()+"'>"+pu.getName()+"</option>");
				}
			%>
		</select>
		
		</td>
	</tr>
    <tr>
        <td>TPS邮件推送数量</td>
        <td><input type="text" name="send_tps_number" value="<%=MT.f(t.send_tps_number) %>" /></td>
    </tr>
	<%
	String sysCategorys = "";
	List<ShopCategory> sysCategoryslist = ShopCategory.find(" AND father="+ShopCategory.getCategory("sysCategory")+" AND hidden = 0", 0, 100);
	for(int i=0;i<sysCategoryslist.size();i++){
		sysCategorys += ","+sysCategoryslist.get(i).category;
	}
	if(sysCategorys.length()>0&&sysCategorys.indexOf(String.valueOf(t.category))!=-1)
	{
	%>
	<tr>
    	<td>试用包</td>
	    <td><input type="file" name="tps_attch" value=""/>
	    <%if(t.tps_attch != 0){ out.print("<a href="+Attch.find(t.tps_attch).path+"  target=_blank>"+Attch.find(t.tps_attch).length+"</a>字节");}%>
	      </td>
	</tr>
	<%
	}
	%>
  <tr>
    <td>商品图片</td>
    <td><input type="button" id="browse" class="btn btn-default" value="上传图片"/>
    <input type="hidden" name="picture" value="<%=MT.f(t.picture)%>"/>
<div id="img"><%
String[] arr=t.picture.split("[|]");
for(int i=1;i<arr.length;i++)
{
  Attch a=Attch.find(Integer.parseInt(arr[i]));
  out.print("<span><img src='"+a.path3+"' /></span>");
}
%></div></td>
  </tr>
  <%-- <tr>
    <td>是否上架</td>
    <td><input name="state" type="radio" value="0" id="state_0" checked="checked"/><label for="state_0">是</label>　<input name="state" type="radio" value="1" id="state_1" <%if(t.state==1)out.print(" checked='checked' ");%>/><label for="state_1">否</label></td>
  </tr> --%>
  
 <%-- <tr>
    <td>导语</td>
    <td><textarea name="content1" rows="12" cols="90"><%=Lucene.t(t.content[1])%></textarea>
    <!-- <iframe id="editor" src="/tea/FCKeditor/editor/fckeditor.html?InstanceName=content1" width="735" height="300" frameborder="no" scrolling="no"></iframe>
     -->
    </td>
  </tr>--%>
  <tr>
    <td>商品信息</td>
    <td><textarea CLASS="ckeditor" name="activity" rows="12" cols="90"><%=MT.f(t.activity)%></textarea>
    <!-- <iframe id="editor" src="/tea/FCKeditor/editor/fckeditor.html?InstanceName=content1" width="735" height="300" frameborder="no" scrolling="no"></iframe>
     -->
    </td>
  </tr>
   <tr>
    <td>商品信息（手机）</td>
    <td><textarea CLASS="ckeditor" name="spec1" rows="12" cols="90"><%=MT.f(t.spec[1])%></textarea>
    <!-- <iframe id="editor" src="/tea/FCKeditor/editor/fckeditor.html?InstanceName=spec1" width="735" height="300" frameborder="no" scrolling="no"></iframe>
     -->
    </td>
  </tr>
 
</table>


<table id="tablecenter" cellspacing="0">
<%
StringBuilder sb=new StringBuilder();
Iterator it=ShopAttrib.find(" AND category IN("+c.path.substring(1).replace('|',',')+"0)",0,200).iterator();
while(it.hasNext())
{
  ShopAttrib a=(ShopAttrib)it.next();
  out.println("<tr><td>"+a.name[1]+"<td>"+a.getHtm(1,t.product));
}
%>
</table>


<div class="center mt15">
<input type="submit" class="btn btn-primary" value="提交"/> <input type="button" class="btn btn-default" value="返回" onclick="history.back();"/>
</form>


<script>
mt.focus(form2);

mt.rec=function()
{
  mt.show("/jsp/yl/shop/ProductSel.jsp?product="+mt.value(form2.products,"|"),2,"选择商品",500,400);
};
mt.receive=function(id,n,h)
{
  $("t_recommend").innerHTML+=h;
};

//颜色
mt.color=function(t)
{
  $('color_tab').style.display=mt.value(form2.color)?'':'none';
  $('co'+t.value).style.display=t.checked?'':'none';
};
var cs=form2.color;
if(cs)for(var i=0;i<cs.length;i++)if(cs[i].checked)cs[i].onclick();


//尺码
mt.psize=function(a)
{
  b=a.nextSibling;
  b.disabled=!a.checked;
  s=b.style;
  if(a.checked)
  {
    b.old=s.cssText;
    s.cssText='';
  }else
    s.cssText=b.old;
};
var ps=form2.psize;
if(ps)for(var i=0;i<ps.length;i++)if(ps[i].checked)ps[i].onclick();


//图片左右移动
document.write("<style>#img span{ width:52px; height:52px; border:1px solid #CCCCCC;text-align:center;margin-right:5px}</style><div id='but' style='position:absolute;display:none;background:#CCE1FE;width:52px'><img src='/tea/image/l.gif' onclick='mt.move(-1)' /> <img src='/tea/image/r.gif' onclick='mt.move(1)' /> <img src='/tea/image/d.gif' onclick='mt.del()' /></div>");

var imgs,img=$('img'),but=$('but'),seq;
mt.add=function(s)
{
  var tr=document.createElement('SPAN');
  tr.innerHTML="<img src="+s+" />";
  img.appendChild(tr);
  mt.but();
};
mt.but=function()
{
  imgs=img.childNodes,pic='|';
  for(var i=0;i<imgs.length;i++)
  {
    eval("imgs[i].onmouseover=function(){seq="+i+";but.style.display='';but.style.left=mt.left(this)+'px';but.style.top=mt.top(this)+36+'px';};");
    //arr[i].onmouseout=function(){but.style.display='none';}
    var t=imgs[i].firstChild.src;
    pic+=t.substring(t.lastIndexOf('/')+1,t.lastIndexOf('_'))+"|";
  }
  form2.picture.value=pic;
  but.style.display='none';
};
mt.but();

mt.move=function(i)
{
  var t=imgs[seq],d=imgs[seq+i];
  if(!d)return;
  t.swapNode(d);
  mt.but();
};
mt.del=function()
{
  mt.show("确认要删除吗？",2);
  mt.ok=function()
  {
    imgs[seq].parentNode.removeChild(imgs[seq]);
    mt.but();
  }
};
var cur=1,total=0,up=new Upload($('browse'),{fileSizeLimit:'20 MB',filePostName:'Filedata',fileTypes:'*.jpg;*.gif;*.png;*.bmp'});
up.fileDialogComplete=function(i)
{
  if(i<1)return;
  mt.show(null,0);
  total+=i;
  this.start();
};
up.uploadProgress=function(f,b,t)
{
  if(!t)return;
  mt.progress(b,f.size,'正在上传('+cur+'/'+total+')：'+f.name);
};
up.uploadSuccess=function(f,d)
{
  eval(d);
  cur++;
};
up.complete=function()
{
  cur=1;
  total=0;
  mt.close();
};
function showshop(){
	mt.show('/jsp/yl/shop/SelYuShops.jsp',0,'查询商家',600,500);
}

mt.addOption=function(text,value){
	form2.model_id.options.add(new Option(text,value));
};

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

function clearNoNum(obj)
{
 //先把非数字的都替换掉，除了数字和.
 obj.value = obj.value.replace(/[^\d.]/g,"");
 //必须保证第一个为数字而不是.
 obj.value = obj.value.replace(/^\./g,"");
 //保证只有出现一个.而没有多个.
 obj.value = obj.value.replace(/\.{2,}/g,".");
 //保证.只出现一次，而不能出现两次以上
 obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}

//设置是否显示价格
function setPriceDisplay(obj){
	if(obj.checked == true){
		document.getElementById("_price_display").value = "1";
		document.getElementById("_price").disabled = "disabled";
	}else{
		document.getElementById("_price_display").value = "0";
		document.getElementById("_price").disabled = "";
	}
}
</script>
</body>
</html>
