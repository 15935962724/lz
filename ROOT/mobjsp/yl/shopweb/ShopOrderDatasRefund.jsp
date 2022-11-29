<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

String orderId = MT.dec(h.get("orderId"));
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
sql.append(" AND order_id="+DbAdapter.cite(orderId));
par.append("&orderId="+orderId);

int sum=ShopOrderData.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

String nexturl = h.get("nexturl");

%><!DOCTYPE html><html><head>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>

<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>


</head>
<body>
<h1>申请退换货</h1>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act"/>
<div class='results'>
<table id="tablecenter" cellspacing="0">
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Profile pf = Profile.find(so.getMember());
  
  //根据订单id查询订单详情信息
  Iterator it=ShopOrderData.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
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
		  pname=sp.name[1];
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
	  
	  StringBuffer operateBuff = new StringBuffer();
	  if(so.getStatus()==4)
      {
		  operateBuff.append("<tr><td colspan='3' align='right'>");
          ShopExchanged se = ShopExchanged.findByOidPid(orderId,product_id);
          if(se.id>0){
              if(se.status==0)
        	      operateBuff.append("正在进行中");
        	  else
        		  operateBuff.append("已完成");
          }else{
        	  operateBuff.append("<input type='button' class='returnbtn' value='申请退换货' onClick=\"mt.act('refund','"+orderId+"','"+MT.enc(t.getId())+"');\" />");
          }
          operateBuff.append("</td></tr>");
      }
	  
	  out.println("<tr>");
	  out.println("<td align='center'>");
	  if(sp.isExist&&sp.picture!=null&sp.picture.length()>0)
		  out.println("<img src='"+MT.f(sp.getPicture('b'))+"' alt="+sp.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
	  out.println("</td>");
	  out.println("<td align='center'>"+pname);
	  if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals(""))
		  out.println("&nbsp;&nbsp;<span style='color:red;'>(粒子的校准时间："+MT.f(t.getCalibrationDate())+")</span>");
	  out.println("</td>");
	  out.println("<td align='right'><span>&yen&nbsp;"+MT.f((double)t.getUnit(),2)+"</span><span>*"+t.getQuantity()+"</span></td>");
	//操作项
	  
	  out.println("</tr>");
	  
	  if(!sp.isExist){
		  for(int n=0;n<spagePList.size();n++){
			    ShopProduct s1 = spagePList.get(n);
			    out.println("<tr class='tzP'>");
		    	out.println("<td style='text-align:center;'>");
		    	if(s1.picture!=null&s1.picture.length()>0)
		    		out.println("<img src='"+MT.f(s1.getPicture('b'))+"' alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
		    	out.println("</td>");
		    	out.println("<td style='text-align:center;'>"+s1.getAnchorX(h.language)+"</td>");
		    	out.println("<td style='text-align:right;'><span>&yen&nbsp;"+MT.f(s1.price,2)+"</span><span>*"+t.getQuantity()+"</span></td>");
		    	
		    	out.println("</tr>");
  	  	  }
	  }
	  out.println(operateBuff.toString());
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,oid,did)
{
  if(a=='refund')
  {
	  //ShopExchangedAdd.jsp
	  parent.location="/xhtml/folder/14111211-1.htm?oid="+oid+"&did="+did;
  }
};
mt.fit();
</script>
</body>
</html>
