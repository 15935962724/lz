<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if("goodstype".equals(teasession.getParameter("act")))
{

  int father = Integer.parseInt(teasession.getParameter("father"));
  if(father>0){
    java.util.Enumeration ge = GoodsType.findByFather(father);
    out.print( "<select name=\"goodstype2\">");
    while(ge.hasMoreElements())
    {
      GoodsType gobj = (GoodsType)ge.nextElement();
      out.print("<option value="+gobj.getGoodstype());
      out.print(">"+gobj.getName(teasession._nLanguage));
      out.print("</option>");
    }
    out.print("</select>");
  }else
  {
    out.print(" <select><option>----------</option></select>");
  }
  return;
}

int supplname = 0;
String rsgoods = teasession.getParameter("rsgoods");
StringBuffer param=new StringBuffer("?node="+teasession._nNode);
StringBuffer sql=new StringBuffer();
if(teasession.getParameter("supplname")!=null && teasession.getParameter("supplname").length()>0)
{
  supplname=Integer.parseInt(teasession.getParameter("supplname"));
}
if(supplname>0)
{
  sql.append(" AND warname ="+supplname);
  param.append("&supplname=").append(supplname);
}
String goodsnumber = teasession.getParameter("goodsnumber");
if(goodsnumber!=null && goodsnumber.length()>0)
{
  sql.append(" AND goods in (SELECT node FROM Node WHERE goodsnumber LIKE '%"+goodsnumber+"%')");
  param.append("&goodsnumber=").append(java.net.URLEncoder.encode(goodsnumber,"UTF-8"));
}
String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  sql.append(" AND goods in (SELECT node FROM Nodelayer WHERE subject LIKE '%"+subject+"%')");
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}
String spec = teasession.getParameter("spec");
if(spec!=null && spec.length()>0)
{
  sql.append(" AND goods in (SELECT node FROM Goods WHERE  spec LIKE '%"+spec+"%' )");
  param.append("&spec=").append(java.net.URLEncoder.encode(spec,"UTF-8"));
}

int brand =0;
if(teasession.getParameter("brand")!=null && teasession.getParameter("brand").length()>0)
{
  brand = Integer.parseInt(teasession.getParameter("brand"));
  sql.append(" AND goods in (SELECT node FROM Goods WHERE  brand ="+brand+" )");
  param.append("&brand=").append(brand);
}

int goodstype1 = 0,goodstype2 = 0;
if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
{
  goodstype1 = Integer.parseInt(teasession.getParameter("goodstype1"));
  goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
  sql.append(" AND goods in (SELECT node FROM Goods WHERE   goodstype LIKE '%/"+goodstype2+"/%' )");
  param.append("&goodstype1=").append(goodstype1);
  param.append("&goodstype2=").append(goodstype2);
}



  if(rsgoods!=null){
    param.append("&rsgoods=").append(rsgoods);
  }
  int count=0;
  int pos=0;
  int pageSize=10;
  if( teasession.getParameter("pos")!=null)
  {
    pos=Integer.parseInt(  teasession.getParameter("pos"));
  }
count = Inventory.count(teasession._strCommunity,sql.toString());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

<body  <%if(goodstype2>0){out.print("onload=\"f_goodstype();\"");}%>>
<script type="text/javascript">
window.name='tar';

function CheckAll(){
  var checkname=document.getElementsByName("checkall");
  var fname=document.getElementsByName("checkname");
  var t = document.all('checknamehidden').value;
  var lname="";
  if(checkname[0].checked){
    for(var i=0; i<fname.length; i++){

      fname[i].checked=true;
        t=t+fname[i].value+"/";
    }
     document.all('checknamehidden').value=t;
  }else{
    for(var i=0; i<fname.length; i++){
      fname[i].checked=false;
      document.all('checknamehidden').value='/';
    }
  }
}

function f_ra(igd,bool)
{
  var t = document.all('checknamehidden').value;
  if(bool)
  {
    t=t+igd+"/";
  }else
  {
    t= f_re(t,igd,false);
  }
  document.all('checknamehidden').value =t;
}
function f_re(t,i,b)
{
  var re=new RegExp('/'+i+'/');
  re=re.exec(t);
  if(re)
  {
    t=t.substring(0,re.index)+"/"+(b?i+"/":"")+t.substring(re.lastIndex);
  }
  return t;
}
function f_button()
{

  var tsb = form1.checknamehidden.value;
  if(tsb=='/')
  {
    alert("请选择商品!");
    return false;
  }
  window.returnValue=tsb;
  window.close();
}
function f_goodstype()
{
     sendx("?act=goodstype&father="+form1.goodstype1.value,
     function(data)
     {
       document.getElementById('show').innerHTML=data;
     }
     );
}
</script>

<h1>选择商品</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>查询</h2>
<form name="form1" action="?" method="GET" target="tar">
<input type="hidden" name="checknamehidden" value="<%if(rsgoods!=null && rsgoods.length()>0){out.print(rsgoods);}else{out.print("/");}%>"/>
<input type="hidden" name="supplname" value="<%=supplname%>"/>
<input type="hidden" name="rsgoods" value="<%=rsgoods%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  <td nowrap>商品编号：&nbsp;<input type="text" name="goodsnumber" value="<%if(goodsnumber!=null)out.print(goodsnumber);%>"/></td>
    <td nowrap>名称：&nbsp;<input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
    <td nowrap>类别：&nbsp;
    <select name="goodstype1" onchange="f_goodstype();">
    <option value="0">-----</option>
   <%
   java.util.Enumeration ge = GoodsType.findByFather(5);
   while(ge.hasMoreElements())
   {
      GoodsType gobj = (GoodsType)ge.nextElement();
     out.print("<option value="+gobj.getGoodstype());
     if(goodstype1==gobj.getGoodstype())
     {
       out.print(" SELECTED");
     }
     out.print(">"+gobj.getName(teasession._nLanguage));
     out.print("</option>");
   }

   %>
    </select>
     <span id="show">
     <select name="">
      <option value="">----------</option>
    </select>
    </span>
    </td>

  </tr>
  <tr>
    <td nowrap>规格：&nbsp;<input type="text" name="spec" value="<%if(spec!=null)out.print(spec);%>"/></td>
    <td nowrap>品牌：&nbsp;
     <select name="brand">
     <option value="">-----</option>
     <%
       java.util.Enumeration be = Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
        while(be.hasMoreElements())
        {
          int bradnid = ((Integer)be.nextElement()).intValue();
           Brand bobj = Brand.find(bradnid);
           out.print("<option value="+bradnid);
           if(brand==bradnid)
           {
             out.print(" selected");
           }
           out.print(">"+bobj.getName(teasession._nLanguage));
           out.print("</option>");
        }
     %>
    </select>
    </td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>

<h2>列表( <span id=spancount><%=count %></span> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
   <td  width="1"></td><!-- <input type="checkbox" name="checkall" onclick="CheckAll('checkname','checkall');">-->
    <td nowrap>商品编号</td>
    <td nowrap>商品名称</td>
    <td nowrap>规格型号</td>
    <td nowrap>品牌</td>
    <td nowrap>单位</td>
    <td nowrap>进价</td>
  </tr>
  <%

int is = 1;
java.util.Enumeration e = Inventory.find(teasession._strCommunity,sql.toString(),pos,pageSize);

   if(!e.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>该仓库没有商品!</td></tr>");
   }

while(e.hasMoreElements())
{
  int invid = ((Integer)e.nextElement()).intValue();
  Inventory  iobj = Inventory.find(invid);

  Node node=Node.find(iobj.getGoods());
  Goods g=Goods.find(iobj.getGoods());
  Commodity cobj = Commodity.find_goods(iobj.getGoods());
  BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
  %>

  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
   <td width="1"><input type="checkbox" name="checkname" value="<%=iobj.getGoods()%>" <%if(rsgoods!=null && rsgoods.length()>0 && rsgoods.indexOf("/"+iobj.getGoods()+"/")!=-1){out.print(" checked=checked");}%>  onClick="f_ra(value,checked);" ></td>
    <td nowrap><%=node.getNumber() %></td>
    <td nowrap><%=node.getSubject(teasession._nLanguage) %> </td>
    <td nowrap><%=g.getSpec(teasession._nLanguage) %></td>
    <td nowrap><%
        Brand b=null;
        if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
        {
          if(b.getNode()>0)
             out.print(b.getName(teasession._nLanguage));
        }
        %></td>
    <td nowrap><%=g.getMeasure(teasession._nLanguage)%></td>
    <td nowrap><%= bpobj.getSupply()%></td>
  </tr>
  <%
is++;
}

%>
  <%if (count > pageSize) { %>
   <tr> <td colspan="10" id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%
 out.print("<script>document.getElementById('go').style.display='none';</script>");
}  %>
</table>
<br>
<input type="button" value="确认选择的商品" onclick="f_button();">&nbsp;<input type="button" value="关闭"  onClick="javascript:window.close();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<script>
var as=document.getElementById("tdpage");
if(as)
{
  as=as.getElementsByTagName("A");

  for(var i=0;i<as.length;i++)
  {
    as[i].setAttribute("target","tar");
  }
}

</script>
</body>
</html>
