<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String order_id=h.get("order_id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&order_id="+order_id);
sql.append(" AND order_id="+DbAdapter.cite(order_id));

int pos=h.getInt("pos");
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>商品名称</td>
  <td>商品单价</td>
  <td>商品数量</td>
</tr>
<%
int sum=ShopOrderData.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
	  //根据订单id查询订单详情信息
	  Iterator it=ShopOrderData.find(sql.toString(),pos,Integer.MAX_VALUE).iterator();
	  for(int i=1;it.hasNext();i++)
	  {
		  ShopOrderData t=(ShopOrderData)it.next();
		  
		  //判断product_id是否商品的id，如果不是则为套装id；最后产品或套装中的商品存入list中
	      int product_id=t.getProductId();
		  
	      ShopProduct sp = ShopProduct.find(product_id);
	      ShopPackage spage = new ShopPackage(0);
	      List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
	      String pname = "";
	      boolean isSell = false;
		  if(sp.isExist){
			  pname=sp.getAnchor(h.language);
			  if(sp.state==0)
				  isSell = true;
		  }else{
			  spage = ShopPackage.find(product_id);
			  pname="[套装]"+MT.f(spage.getPackageName());
			  ShopProduct s = ShopProduct.find(spage.getProduct_id());
			  if(s.state==0)
				  isSell = true;
			  spagePList.add(0,s);
			  String [] sarr = spage.getProduct_link_id().split("\\|");
			  for(int m=1;m<sarr.length;m++){
				  spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
			  }
		  }
		  
		  out.println("<tr><td align='center'>"+i+"</td>");
		  out.println("<td align='left'>"+pname);
		  if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals(""))
			  out.println("&nbsp;&nbsp;<span style='color:red;'>(粒子的校准时间："+MT.f(t.getCalibrationDate())+")</span>");
		  out.println("</td>");
		  out.println("<td align='center'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
		  out.println("<td align='center'>"+t.getQuantity()+"</td>");
		  /* //操作项
		  out.println(operateBuff.toString()); */
		  out.println("</tr>");
		  
		  if(!sp.isExist){
			  for(int n=0;n<spagePList.size();n++){
				    ShopProduct s1 = spagePList.get(n);
				    out.println("<tr class='tzP'><td style='text-align:center;'></td>");
			    	out.println("<td style='text-align:left;'>"+s1.getAnchor(h.language)+"</td>");
			    	out.println("<td style='text-align:center;'><span style='font-size:13px;'>&yen;</span>"+MT.f(s1.price,2)+"</td>");
			    	out.println("<td style='text-align:center;'>"+t.getQuantity()+"</td>");
			    	out.println("</tr>");
	  	  	  }
		  }
	  }
}%>
</table>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,oid,did)
{
  if(a=='refund')
  {
	  window.open("/jsp/yl/shopweb/ShopExchangedAdd.jsp?oid="+oid+"&did="+did);
  }
};
</script>
</body>
</html>
