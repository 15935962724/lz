<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
int pos=h.getInt("pos");
par.append("&pos=");



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

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<style>
.mt_data td,.mt_data th{padding:3px}
</style>
</head>
<body style='min-height:300px'>

<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="cancelReason"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class="results">

<%
sql.append(" AND so.status in(1) OR so.status in(0) AND m.isvip =1");
int sum=ShopOrder.count(sql.toString());
if(sum<1)
{
  out.print("<table id='tablecenter' cellspacing='0'><tr><td colspan='7' align='center'>暂无记录!</td></tr></table>");
}else
{
  sql.append(" order by createDate desc");
  Iterator it=ShopOrder.find(sql.toString(),pos,10).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopOrder t=(ShopOrder)it.next();
      String uname = MT.f(Profile.find(t.getMember()).getName(h.language));
      if(uname.trim()==null||uname.trim().equals("")||uname.trim().length()<1){
    	  uname = Profile.find(t.getMember()).member;
      }
      int status = t.getStatus();
      String statusContent = "";
      if(status==0)
    	  statusContent = "待付款";
      else if(status==1||status==2)
    	  statusContent = "待发货";
      else if(status==3)
    	  statusContent = "待收货";
      else if(status==4)
    	  statusContent = "已完成";
      else if(status==5)
    	  statusContent = "<a href='###' onclick=\"mt.show('"+MT.f(t.getCancelReason())+"');\">已取消</a>";
  %>
  <table id="tablecenter" cellspacing="0">
  <tr><td colspan='7' align='center' style='background:#f2f2f2;padding:0px;height:10px;'></td></tr>
  <tr class="tr_tit">
    <td class="orderId" colspan="2">订单号：<em><%=t.getOrderId()%></em></td>
    <td class="td01"><%=statusContent%></td>
    <td nowrap align="right" style="color:#999999;"><%=MT.f(t.getCreateDate(),1)%></td>
  </tr>
  
  <%
//根据订单id查询订单详情信息
  Iterator it2=ShopOrderData.find(" AND order_id="+DbAdapter.cite(t.getOrderId()),pos,Integer.MAX_VALUE).iterator();
  for(int j=1;it2.hasNext();j++)
  {
	  ShopOrderData sod=(ShopOrderData)it2.next();
	  
	  //判断product_id是否商品的id，如果不是则为套装id；最后产品或套装中的商品存入list中
      int product_id=sod.getProductId();
	  
      ShopProduct sp = ShopProduct.find(product_id);
      ShopPackage spage = new ShopPackage(0);
      List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
      String pname = "";
      boolean isSell = false;
	  if(sp.isExist){
		  pname=sp.getAnchorX(h.language);
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
	  
	  out.println("<tr>");
	  out.println("<td align='center'>");
	  if(sp.isExist&&sp.picture!=null&sp.picture.length()>0)
		  out.println("<img src='"+MT.f(sp.getPicture('b'))+"' alt="+sp.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
	  out.println("</td>");
	  out.println("<td>"+pname+"</td>");
	  out.println("<td align='center' style='color:#0079D2;'>");
	  if(sp.isExist&&sp.model_id>0){
		  ShopProductModel spm = ShopProductModel.find(sp.model_id);
		  if(spm.getModel()!=null&spm.getModel().length()>0)
		  	out.print(MT.f(spm.getModel()));
	  }
	  out.println("</td>");
	  out.println("<td align='right' class='redsize'>"+sod.getQuantity()+"</td>");
	  out.println("</tr>");
	  
	  if(!sp.isExist){
		  for(int n=0;n<spagePList.size();n++){
			    ShopProduct s1 = spagePList.get(n);
			    String s1name = s1.getAnchorX(h.language);
			    out.println("<tr class='tzP'>");
		    	out.println("<td style='text-align:center;'>");
		    	if(s1.picture!=null&s1.picture.length()>0)
		    		out.println("<img src='"+MT.f(s1.getPicture('b'))+"' alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
		    	out.println("</td>");
		  	    out.println("<td>"+s1name+"</td>");
		  	    out.println("<td align='center' style='color:#0079D2;' nowrap>");
		    	if(s1.isExist&&s1.model_id>0){
		  		  ShopProductModel spm = ShopProductModel.find(s1.model_id);
		  		  if(spm.getModel()!=null&spm.getModel().length()>0)
		  		  	out.print(MT.f(spm.getModel()));
		  	    }
		    	out.println("</td>");
		    	
		    	out.println("<td style='text-align:right;'><span>&yen&nbsp;"+MT.f(s1.price,2)+"</span>*"+sod.getQuantity()+"</td>");
		    	out.println("</tr>");
  	  	  }
	  }
	  out.println("<tr><td colspan='4' style='text-align:right;' class='td_all'>订单金额：<em>&yen&nbsp;"+MT.f((double)t.getAmount(),2)+"</em></td></tr>");
	  out.println("<tr><td colspan='4' style='text-align:right;' class='td_but'>");
	  
	  if(status==1||(status==0&&Profile.find(t.getMember()).isvip==1))
  		out.println("<input type='button' onclick=\"mt.act('status','"+t.getOrderId()+"',2,'发货');\" value=\"确认发货\" />");
	  
	  out.println("<input type='button' onclick=\"mt.act('data','"+MT.enc(t.getOrderId())+"');\" value='查看'/>");
	    	
	  out.println("</td></tr>");
  }
  %>
  </table>
  <%}
  if(sum>10)out.print("<tr><td colspan='10' align='right'><div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,10)+"</div>");
}%>
</div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,orderId,status,statusContent)
{
  form2.act.value=a;
  form2.orderId.value=orderId;
  if(a=='status'){
	  form2.status.value=status;
	  mt.show('你确定要“'+statusContent+'”吗？',2,'form2.submit()');
  }else if(a=='data'){
	  parent.location="/xhtml/folder/14110832-1.htm?orderId="+orderId;
  }
};

mt.fit();
</script>
</body>
</html>
