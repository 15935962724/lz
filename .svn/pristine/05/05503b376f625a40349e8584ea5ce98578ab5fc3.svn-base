<%@page import="tea.entity.trust.TrustCompany"%>
<%@page import="tea.entity.trust.TrustProduct"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.sup.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

boolean _bNew=request.getParameter("NewNode")!=null;
String nexturl=h.get("nexturl","");
int node=h.getInt("node");
TrustCompany t=new TrustCompany(node);

if(_bNew){
	t=TrustCompany.find(0);
}else{
	t=TrustCompany.find(h.node);
	Node n=Node.find(node);
}





%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>

</head>
<body>
<h1>编辑信托公司信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form2" action="/TrustCompanys.do" method="post" enctype="multipart/form-data"  onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="NewNode" value="<%=_bNew%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">公司全称：</td>
    <td colspan="3"><input name="nameMsg" value="<%=MT.f(t.nameMsg)%>"  size="30" /></td>
  </tr>
  <tr>
    <td class="th">公司简称：</td>
    <td colspan="3"><input name="name" value="<%=MT.f(t.name)%>"  size="30" /></td>
  </tr>
  <tr>
    <td class="th" width="10%">成立时间：</td>
    <td width="40%">
    
    <input name="time" value="<%=MT.f(t.time)%>" onClick="mt.date(this)" readonly class="date" size="30"/>
    
    </td>
    <td class="th" width="10%">地区：</td>
    <td width="40%">
   
    <script>mt.city("city0","city1","","<%=t.city%>")</script>
   
    </td>
  </tr>
  <tr>
    <td class="th">法人代表：</td>
    <td><input name="legalPerson" value="<%=MT.f(t.legalPerson)%>"  size="30"/></td>
    <td class="th">董事长：</td>
    <td><input name="chairman" value="<%=MT.f(t.chairman)%>"  size="30"/></td>
  </tr>
  <tr>
    <td class="th">大股东：</td>
    <td><input name="bigShareholders" value="<%=MT.f(t.bigShareholders)%>"  size="30" /></td>
    <td class="th">是否上市：</td>
    <td><input type="radio" name="isListed" value="1" <%=t.isListed==1?"checked":"" %>/>是<input type="radio" value="0" name="isListed" <%=t.isListed==1?"":"checked" %>/>否</td>
  </tr>
  <tr>
    
    <td class="th">注册资本：</td>
    <td><input name="regMoney" value="<%=t.regMoney==null?0:t.regMoney%>"  size="10" />万元</td>
    <td class="th">收益率：</td>
    <td>
    <input name="yield" value="<%=t.yield==null?0:t.yield%>"  size="3" />%
    </td>
  </tr>
  <tr>
    <td class="th">上传Logo：</td>
    <td colspan="3"><input name="logo" type="file" value="<%=t.logo %>" size="30" />
    <%if(MT.f(t.logo).length()>0)out.print("<a href='"+Attch.find(Integer.parseInt(t.logo)).path+"' target='_blank'>查看原图</a>"); %>
    </td>
    
  </tr>
  
    <tr>
    <td class="th">股东背景：</td>
    <td colspan="3"><textarea name="background"  rows="3" cols="90" ><%=MT.f(t.background)%></textarea></td>
  </tr>
  <tr>
    <td class="th">经营范围：</td>
    <td colspan="3"><textarea  name="scopeOf" rows="5" cols="90"><%=MT.f(t.scopeOf) %></textarea></td>
  </tr>
  
</table>


<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>


<script>
form2.subject.focus();

mt.rec=function()
{
  TYPE=false;
  mt.show("/jsp/type/product/ProductSel.jsp?nodes="+mt.value(form2.nodes,"|"),2,"选择商品",500);
};
mt.receive=function(id,n,h)
{
  if(TYPE)
  {
    if(id.length<2)return;
    form2.member.value=id.split('|')[1];
    form2.supplier.value=n.split('；')[0];
  }else
  $$("t_recommend").innerHTML+=h;
};

//颜色
mt.color=function(t)
{
  $$('color_tab').style.display=mt.value(form2.color)?'':'none';
  $$('co'+t.value).style.display=t.checked?'':'none';
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
document.write("<style>#img div{ width:52px; height:52px; float:left; border:1px solid #CCCCCC;text-align:center;margin-right:5px;overflow:hidden;}</style><div id='but' style='position:absolute;display:none1;background:#CCE1FE;width:52px'><img src='/tea/image/l.gif' onclick='mt.move(-1)' /> <img src='/tea/image/r.gif' onclick='mt.move(1)' /> <img src='/tea/image/d.gif' onclick='mt.del()' /></div>");

var imgs,img=$$('img'),but=$$('but'),seq;
mt.add=function(s)
{
  var tr=document.createElement('DIV');
  tr.innerHTML="<img src="+s+" />";
  img.appendChild(tr);
  mt.but();
};
mt.but=function()
{
  imgs=img.childNodes,pic='|';
  for(var i=0;i<imgs.length;i++)
  {
    eval("imgs[i].onmouseover=function(){seq="+i+";but.style.display='';but.style.left=mt.left(this)+'px';but.style.top=mt.top(this)+36+'px';}");
    //arr[i].onmouseout=function(){but.style.display='none';}
    var t=imgs[i].firstChild;
    t.onload=function(){this[this.width>this.height?'width':'height']='52';};
    t=t.src;
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
var cur=1,total=0,up=new Upload($$('browse'),{filePostName:'Filedata',fileTypes:'*.jpg;*.gif;*.png;*.bmp'});
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
</script>
