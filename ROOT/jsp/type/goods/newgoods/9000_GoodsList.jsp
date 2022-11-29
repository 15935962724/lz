<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.net.*" %>
<%@page import="tea.html.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
request.setCharacterEncoding("UTF-8");


if("value".equals(request.getParameter("act")))
{
	String node_che = request.getParameter("node_che");
	Goodscon.add(Integer.parseInt(node_che), session.getId());
	return;
	
}
if("delete".equals(request.getParameter("act")))
{
	String node_che = request.getParameter("node_che");
	Goodscon.delete(Integer.parseInt(node_che), session.getId());
	return;
}

int action=1;
try
{
  action=Integer.parseInt(request.getParameter("action"));
}catch(NumberFormatException ex)
{
  out.print("action参数:点击\"对比选中商品\",转到的节点号.  必须有.");
  return;
}



TeaSession teasession=new TeaSession(request);




Node node=Node.find(teasession._nNode);

//StringBuffer sql=new StringBuffer(" FROM Node n INNER JOIN Goods g ON n.node=g.node WHERE n.community=");
StringBuffer sql=new StringBuffer(" FROM Node n, Goods g,Company c WHERE n.node=g.node AND g.company=c.node  AND n.community=");
sql.append(DbAdapter.cite(teasession._strCommunity)).append(" AND n.type=34");

StringBuffer param=new StringBuffer();
param.append("?Node=").append(teasession._nNode);
param.append("&action=").append(action);

String good=teasession.getParameter("good");


String brand=teasession.getParameter("brand");
if(brand.equalsIgnoreCase("aa"))
	brand="";

if(brand!=null&&brand.length()>0)
{
   if(good!=null&&good.length()>0)
   {
     param.append("&good="+java.net.URLEncoder.encode(good,"UTF-8"));
     sql.append(" AND g.brand=").append(Integer.parseInt(brand));//如果品牌是id
     sql.append(" AND n.node IN ( SELECT node FROM NodeLayer WHERE subject LIKE ").append(DbAdapter.cite("%"+good+"%")).append(")");//如果按商品名称
   }else
   {
     try
     {
       sql.append(" AND g.brand="+Integer.parseInt(brand));//如果品牌是id
     }catch(Exception ex)
     {
       //sql.append(" AND g.brand IN ( SELECT brand FROM BrandLayer WHERE name LIKE ").append(DbAdapter.cite("%"+brand+"%")).append(")");//如果品牌是 名称
     }
  }
  param.append("&brand=").append(URLEncoder.encode(brand,"UTF-8"));
}else if(brand==null)
{
  sql.append(" AND n.path LIKE ").append(DbAdapter.cite(node.getPath()+"%"));
}else if(good!=null&&good.length()>0)
{
  sql.append(" AND n.node IN ( SELECT node FROM NodeLayer WHERE subject LIKE ").append(DbAdapter.cite("%"+good+"%")).append(")");//如果按商品名称
}


String goodstype=request.getParameter("goodstype");
//
//if(goodstype.equalsIgnoreCase("1")&&good!=null&&good.length()>0){
//   goodstype="";
//}else if(goodstype.equalsIgnoreCase("1")){
//   goodstype="1";
//}





if(goodstype!=null&&goodstype.length()>0)
{
  String goodstype2=request.getParameter("goodstype2");
  if(goodstype2!=null&&goodstype2.length()>0)
  {
    goodstype=goodstype2;//+"/"+goodstype2;
  }
  GoodsType gt=GoodsType.find(Integer.parseInt(goodstype));
  sql.append(" AND g.goodstype LIKE ").append(DbAdapter.cite(gt.getPath()+"%"));
  param.append("&goodstype=").append(URLEncoder.encode(goodstype,"UTF-8"));
}

String time_s = request.getParameter("time_s");

if(time_s!=null && time_s.length()>0)
{
   sql.append(" and  n.time >=").append(DbAdapter.cite(time_s));
   param.append("&time_s=").append(time_s);
}
String time_k = request.getParameter("time_k");
if(time_k!=null && time_k.length()>0)
{
   sql.append(" and  n.time <= ").append(DbAdapter.cite(time_k));
   param.append("&time_k=").append(time_k);
}
String names = request.getParameter("names");
if(names!=null && names.length()>0)
{
  sql.append(" AND n.node IN ( SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+names+"%")+")");
  param.append("&names=").append(java.net.URLEncoder.encode(names,"UTF-8"));
}
String cj = request.getParameter("cj");
if(cj!=null && cj.length()>0)
{
  sql.append(" and g.company  in ( select node from NodeLayer where subject like "+DbAdapter.cite("%"+cj+"%")+")");
  param.append("&cj=").append(java.net.URLEncoder.encode(cj,"UTF-8"));
}

//String price_from=request.getParameter("price_from");
//String price_to=request.getParameter("price_to");
//boolean _bPf=(price_from!=null&&price_from.length()>0);
//boolean _bPt=(price_to!=null&&price_to.length()>0);
//if(_bPf||_bPt)
//{
//  sql.append(" AND n.node IN ( SELECT c.goods FROM Commodity c INNER JOIN BuyPrice bp ON c.commodity=bp.commodity WHERE 1=1 ");
//  if(_bPf)
//  {
//    sql.append(" AND price>=").append(DbAdapter.cite(price_from));
//    param.append("&price_from=").append(price_from);
//  }
//  if(_bPt)
//  {
//    sql.append(" AND price<").append(DbAdapter.cite(price_to));
//    param.append("&price_to=").append(price_to);
//  }
//  sql.append(")");
//}
/*
String path=request.getParameter("path");
if(path!=null&&path.length()>0)
{
  sql.append(" AND n.node IN ( SELECT c.goods FROM Commodity c INNER JOIN BuyPrice bp ON c.commodity=bp.commodity WHERE 1=1 ");

  sql.append(DbAdapter.cite("%/"+path+"/%"));
  param.append("&path="+path);
}

String supplier=request.getParameter("supplier");
if(supplier!=null&&supplier.length()>0)
{
  sql.append(",Commodity c ");
  sql.append(" AND c.goods=g.node AND c.supplier=");
  sql.append(DbAdapter.cite(supplier));
  param.append("&supplier="+supplier);
}

String attribute=request.getParameter("attribute");
String attrvalue=request.getParameter("attrvalue");
if(attribute!=null&&attribute.length()>0&&attrvalue!=null&&attrvalue.length()>0)
{
  sql.append(",Attribute a ");
  sql.append(" AND a.node=g.node AND a.attribute=");
  sql.append(DbAdapter.cite(attribute));
  sql.append(" AND a.attrvalue LIKE ");
  sql.append(DbAdapter.cite("%"+attrvalue+"%"));
  param.append("&attribute="+attribute+"&attrvalue="+attrvalue);
}
*/

int quantity=5;
String _strQuantity=request.getParameter("quantity");
if(_strQuantity!=null&&_strQuantity.length()>0)
{
  quantity=Integer.parseInt(_strQuantity);
}
String nodes_check =null;


int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null&&_strPos.length()>0)
{
  pos=Integer.parseInt(_strPos);
}

int size=5;
//String _strSize=request.getParameter("size");
//if(_strSize!=null)
//{
//	size=Integer.parseInt(_strSize);
//}

int pagesize=5;

//if(size==20)
//{
//  pagesize=20;
//}
//if(size==50)
//{
//  pagesize=50;
//}
//param.append("&goodstype=").append(request.getParameter("goodstype"));
	param.append("&classmap=").append(request.getParameter("classmap"));

if(brand!=null&&brand.length()>0)
{
param.append("&pos=");
}else
{
param.append("&brand=");
param.append("&pos=");
}



int count=0;
sql.append(" and n.hidden =0");

%>
<!--
参数说明:
action     点击"对比选中商品",转到的节点号.  必须有
quantity   主题的字数,默认5

//////以下参数,现已没用/////////
brand      品牌
goodstype  类型
father     父节
path       路径
supplier   供应商

attribute  属性ID
attrvalue  属性值
-->
<script src="/tea/viewimage.js"></script>
<script>

function initialize(obj)
{

   var wl=parseInt(event.clientX) + parseInt(document.body.scrollLeft)+65;
   var ht=parseInt(event.clientY) + parseInt(document.body.scrollTop)-150;

   var image="<img style=\"width:200px;height:200px;\" src='"+obj.src+"'  >";
   var a = new xWin("1",300,500,wl,ht,obj.alt,image);
}

function go(){
var form1=document.forms['form1'];
if(fonsubmit_goodslist(form1)){
 form1.submit();
}
}
function fonsubmit_goodslist(obj)
{
	var f = false;
	

  for(var i=0;i<obj.length;i++)
  {
    if(obj[i].checked)
    {
        f=  true;
    }
  }

  if(!f){
     alert('请先选中您要对比的商品.');
   }
  return f;
}

function f_che(obj,igd)
{
	if(obj.checked){
		
		  sendx("?act=value&node_che="+igd,
					 function(data)
					 {
					 }
					 );
		//send_request("?act=value&node_che="+igd);
	}else
	{
		//send_request("?act=delete&node_che="+igd);
		 sendx("?act=delete&node_che="+igd,
				 function(data)
				 {
				 }
				 );
	}
	  
}

</script>
<span id ="sid"></span>
<script language="javascript" src="/tea/tea.js"  type="text/javascript"></script>
<div id="cptypelist">
<div class="navtbg2">
<!--排序方式--><%--
<div id="paix_page">
	商品排序方式：<select name="desc">
	<option value="" >---------------</option>
	</select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 每页显示数量&nbsp;
	<%

	boolean falg=false;

	if(5==size)
	{
		out.println("5");
	}else
	{

		out.println("<a href="+param.toString().replaceFirst("&size=","&")+"&size=5>5</a>");
	}
	if(20==size)
	{
		out.println("20");
	}else
	{
		out.println("<a href="+param.toString().replaceFirst("&size=","&")+"&size=20>20</a>");
	}
	if(50==size)
	{
		out.println("50");
	}else
	{
		out.println("<a href="+param.toString().replaceFirst("&size=","&")+"&size=50>50</a>");
	}

	%>
</div>

--%>

<form name="form1" action="/jsp/type/goods/9000_GoodsCompare.jsp?community=<%=DbAdapter.cite(node.getCommunity())%>" target="_blank" onsubmit="return fonsubmit_goodslist(this);" >

<input type="hidden" name="comm" id="comm" value="<%=DbAdapter.cite(node.getCommunity())%>">
<%
DbAdapter db=new DbAdapter();
	boolean falg=false;
try
{
  //上下架时间判断
  sql.append(" AND n.finished=1 AND ( n.starttime IS NULL OR n.starttime>").append(db.citeCurTime()).append(" ) AND ( n.stoptime IS NULL OR n.stoptime<").append(db.citeCurTime()).append(" )");

  count=db.getInt("SELECT COUNT(n.node) "+sql.toString());

String order=request.getParameter("order");
if(order==null)
order="n.node";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

//sql.append(" ORDER BY ").append(order).append(" ").append(desc);
sql.append(" ORDER BY c.moneys desc ");

System.out.println(sql.toString());
  db.executeQuery("SELECT n.node "+sql.toString());
 //out.print(sql.toString());


%>


<%-- <div id="pagetop"><%=new tea.htmlx.FPNL(teasession._nLanguage,("?"+request.getQueryString()).replaceFirst("&pos=","&")+"&pos=",pos,count,pagesize)%></div>--%>
 <table border="0" cellpadding="0" cellspacing="0" id="biaog2">


  <a href="/jsp/type/goods/9000_GoodsCompare.jsp"  id="xx" target="_blank"></a>
    <tr>
      <td scope="col" id="dtop">&nbsp;</td>
      <td scope="col" width="140"><input name="Submit3" type="button" class="nav_compare" value="对比选中商品" onclick="go()" id="duibi1"/></td>
      <td scope="col" width="260" class="shptitle">商品名称</td>
      <td scope="col" class="shptitle">供应商</td>

     </tr></table>
 <table border="0" cellpadding="0" cellspacing="0" id="biaog"><tr>
<%
  falg=false;
  for (int l = 0; l < pos + pagesize && db.next(); l++)
  {
    if (l >= pos)
    {
      falg=true;
      int node_id=db.getInt(1);
      Node node_obj=Node.find(node_id);
      String subject=node_obj.getSubject(teasession._nLanguage);

      //if(subject!=null&&subject.length()>quantity)
      // subject=subject.substring(0,quantity)+"...";

      Goods goods_obj=Goods.find(node_id);
      String smallpic=goods_obj.getSmallpicture(teasession._nLanguage);
      Commodity c = Commodity.find(node_id, Commodity.findSupplierByGoods(node_id));
      Brand brd=Brand.find(goods_obj.getBrand());

      String fonclick=null;

      int cc=Commodity.findSupplierByGoods(node_obj._nNode);
      Supplier obj2=Supplier.find(cc);
      if(teasession._rv==null)
      {
        fonclick="window.open('/servlet/StartLogin?Node="+node_id+"','_self');";
      }else
      {
        java.util.Enumeration enumer=Commodity.findByGoods(node_id);
        if(enumer.hasMoreElements())
        {
          int commodity_id=((Integer)enumer.nextElement()).intValue();
          //    Commodity commodity_obj=(Commodity)enumer.nextElement();

          fonclick="window.open('/servlet/OfferBuy?Node="+node_id+"&commodity="+commodity_id+"&currency=1&quantity=1','dialog_frame');";//,'height=170,width=370,left=250,top=150'
        }
      }
      
       
      Goodscon goobj = Goodscon.find(node_id, session.getId());

      //if(l%5==0)
      //out.print("<tr><td class=nav_list_rowone >");
      %>
     <tr>
      <td><input type="checkbox" name="nodes" value="<%=node_id%>" id="for<%=node_id%>" <%if(goobj.isExists()){out.println("checked");} %> onclick="f_che(this,'<%=node_id %>');"  />
      <label for="for<%=node_id%>" ></label>
	  </td>
      <td>
	    <a href="/servlet/Node?Node=<%=node_id%>&Language=<%=teasession._nLanguage%>" >
		<img src="<%if(smallpic!=null && smallpic.length()>0){out.print(smallpic);}else{out.print("/tea/image/company_1.jpg");}%>" width="82" height="74" onmousemove="initialize(this)" onmouseout="ShowHide()"  alt="<%=subject%>"  />
		</a>
	  </td>
      <td id="shpname"><span id="sname"><a href="/servlet/Node?Node=<%=node_id%>&Language=<%=teasession._nLanguage%>" ><%if(subject!=null && subject.length()>0){out.println(subject);}%></a></span><br />
      <%
//      if(HtmlElement.htmlToText(node_obj.getText(teasession._nLanguage))!=null){
//        if(HtmlElement.htmlToText(node_obj.getText(teasession._nLanguage)).length()>20)
//        {
//          out.print(HtmlElement.htmlToText(node_obj.getText(teasession._nLanguage)).substring(0,20)+"...............");
//        }else
//        {
//          out.print(HtmlElement.htmlToText(node_obj.getText(teasession._nLanguage)));
//        }
//      }
      %>
      </td>

    <td><%
    Node ncom = Node.find(goods_obj.getCompany());

    out.print("<a href=/servlet/Node?Node="+goods_obj.getCompany()+"&Language="+teasession._nLanguage+"> ");
    if(ncom.getSubject(teasession._nLanguage)!=null && ncom.getSubject(teasession._nLanguage).length()>0)
    {
    	out.print(ncom.getSubject(teasession._nLanguage));
    }
    
    out.print("</a>");
    //obj2.getName(teasession._nLanguage) %></td>

      <%--品牌：<%=brd.getName()%></span><br /><span id="ppai">型号：&nbsp;<%=goods_obj.getSpec()%></span>&nbsp;&nbsp;<span id='ppai'>计量单位：&nbsp;<%=goods_obj.getMeasure()%></span><br /><input id="buybutton" type="button" onclick="window.open('/jsp/add/AddToFavorite_1.jsp?Node=<%=node_id%>','_self');" value="收藏"/> </td>
    <td><%=c.getSerialNumber()%></td>
    <td><span id="price">￥<%=goods_obj.getPrice()%></span><br />
--%>
</td>
    </tr>

<%
	}
  }
}finally
{
  db.close();
}
%>
</tbody>
</table>
<div id="msgbox"></div>
<%if(!falg){%>
<center><font color="red"><b>当前没有您所要的商品！</b></font></center>
<%}%>
 <table border="0" cellpadding="0" cellspacing="0" id="biaog1">
  <tbody>
    <tr id="nav_bt">
      <td>&nbsp;</td>
      <td><input name="Submit2" type="submit" class="nav_compare" value="对比选中商品" id="duibi2"/> </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td width="300" id="pagebottom">
       <%=new tea.htmlx.FPNL(teasession._nLanguage,("?"+request.getQueryString()).replaceFirst("&pos=","&")+"&pos=",pos,count,pagesize)%>
      </td>
    </tr>
  </tbody>
</table>
</form>
</div>


</div>


