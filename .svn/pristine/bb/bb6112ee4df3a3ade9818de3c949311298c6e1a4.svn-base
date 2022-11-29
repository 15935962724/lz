<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1){
	String param = request.getQueryString();
	String url = request.getRequestURI();
	if(param != null)
		url = url + "?" + param;
	response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
	return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

//签收的订单
int sign_openid = h.getInt("sign_openid",0);
if(sign_openid > 0){
	Profile p = Profile.find(h.member);
	sql.append(" AND sign_user_openid = "+DbAdapter.cite(p.openid));
	par.append("&sign_openid="+sign_openid);
}else{
	sql.append(" AND member="+h.member);
	par.append("&member="+h.member);
}

sql.append(" AND status!=6");
par.append("&status!=6");


//订单状态
String[] TAB={"全部订单","等待付款","等待发货","等待收货","已收货","已取消"};
String[] SQL={"  "," AND status=0"," AND (status=1 or status=2)"," AND status=3"," AND status=4"," AND status=5"};
//获取当前状态下的订单列表
int tab = h.getInt("status");
if(tab > 0){
	sql.append(SQL[tab]);
	par.append("&status="+tab);
}

int pos=h.getInt("pos");
par.append("&pos=");

%>
<!DOCTYPE html><html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<title><%=TAB[tab] %></title>
</head>
<body>
<style>
body{background-color:#eee;}
    .results{width:100%;padding:0;}
 #tablecenter{width:100%;background:#ffffff;display:block;margin-top:15px;box-shadow:3px 3px 5px #ddd}
#tablecenter {}
 #tablecenter li{padding:10px 5px;border-bottom:1px solid #ddd;display:-webkit-box}
 #tablecenter li span{display:block;    -webkit-box-flex: 1;}
 #tablecenter .tr_tit  em{color:#0078C3;}
#tablecenter .td01{width:60px;color:#d80000;text-align:right;}
 #tablecenter .redsize{font-weight:bold;width:30px;text-align:center;color:#FF7F26;}
.td_all em{font-style:normal;color:#FF7F26;font-weight:bold;}
 #tablecenter li.td_but{display:block;text-align:right;}
.td_but input{padding:8px 12px;border:1px #7F9DB9 solid;border-radius:5px;background:#fff;margin:0px 3px;cursor:pointer;}
#dialog{top:45px !Important;}
.results .page{width:100%;height:30px;line-height:30px;text-align:center;color:#0079D2;float:left;margin-top:8px;}
.results .page a{padding:3px 8px;height:24px;color:#333;border:1px #ddd solid;border-radius:4px;}
.results .page input{border:1px #ddd solid;border-radius:5px;padding:3px 3px;margin-right:4px;position:relative;top:-2px;background:#ffffff;}


.write{text-align:center;padding:20px 20px 10px;font-size:17px}
.write textarea{border-radius:3px;vertical-align:top;min-height:80px;width:100%;margin-top:5px}
.subt{text-align:center;padding-top:10px}
.subt input{border-radius:3px;background:#00A2E8;padding:8px 60px;color:#fff;border:none;font-size:17px/*padding: 5px 10px;
border: 1px #7F9DB9 solid;
border-radius: 5px;*/}</style>

<header class="header"><%=TAB[tab] %></header>

<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="cancelReason"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class="results newlist ">

<%

int sum=ShopOrder.count(sql.toString());
if(sum<1)
{
  out.print("<ul class='contcenter'><li>您还没有相关订单</li></ul>");
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
  <ul id="tablecenter" cellspacing="0">
  <li class="tr_tit">
    <span class="orderId" colspan="2">订单号：<em><%=t.getOrderId()%></em></span>
    <span nowrap align="right" style="color:#999999;"><%=MT.f(t.getCreateDate(),1)%></span>
    <span class="td01"><%=statusContent%></span>
  </li>
  
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
	  
	  out.println("<li>");
	  out.println("<span align='center'>");
	  if(sp.isExist&&sp.picture!=null&sp.picture.length()>0)
		  out.println("<img src='"+MT.f(sp.getPicture('b'))+"' alt="+sp.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
	  out.println("</span>");
	  out.println("<span>"+pname+"</span>");
	  out.println("<span align='center' style='color:#0079D2;'>");
	  if(sp.isExist&&sp.model_id>0){
		  ShopProductModel spm = ShopProductModel.find(sp.model_id);
		  if(spm.getModel()!=null&spm.getModel().length()>0)
		  	out.print(MT.f(spm.getModel()));
	  }
	  out.println("</span>");
	  out.println("<span class='redsize'>"+sod.getQuantity()+"</span>");
	  out.println("</li>");
	  
	  if(!sp.isExist){
		  for(int n=0;n<spagePList.size();n++){
			    ShopProduct s1 = spagePList.get(n);
			    String s1name = s1.getAnchorX(h.language);
			    out.println("<li class='tzP'>");
		    	out.println("<span style='text-align:center;'>");
		    	if(s1.picture!=null&s1.picture.length()>0)
		    		out.println("<img src='"+MT.f(s1.getPicture('b'))+"' alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
		    	out.println("</span>");
		  	    out.println("<span>"+s1name+"</span>");
		  	    out.println("<span align='center' style='color:#0079D2;' nowrap>");
		    	if(s1.isExist&&s1.model_id>0){
		  		  ShopProductModel spm = ShopProductModel.find(s1.model_id);
		  		  if(spm.getModel()!=null&spm.getModel().length()>0)
		  		  	out.print(MT.f(spm.getModel()));
		  	    }
		    	out.println("</span>");
		    	
		    	out.println("<span style='text-align:right;'><span>&yen&nbsp;"+MT.f(s1.price,2)+"</span>*"+sod.getQuantity()+"</span>");
		    	out.println("</li>");
  	  	  }
	  }
	  //签收人查看订单，没有操作权限
	  if(sign_openid == 0){
		  //out.println("<li><span class='td_all'>订单金额：<em>&yen&nbsp;"+MT.f((double)t.getAmount(),2)+"</em></span></li>");
		  out.println("<li class='td_but'>");
		  if(status!=5&&t.getInvoiceStatus()==0){
	  		if(Profile.find(h.member).membertype!=2){
	  			if(status>0){
	  				out.println("<input type='button' onclick=\"mt.act('getfp','"+MT.enc(t.getOrderId())+"');\" value='索要发票'/>");
	  			}
	  		}else{
	  			out.println("<input type='button' onclick=\"mt.act('getfp','"+MT.enc(t.getOrderId())+"');\" value='索要发票'/>");
	        }
	      }
		  if(status==0)
			  out.println("<input type='button' onclick=\"mt.act('payment','"+MT.enc(t.getOrderId())+"');\" value='付款'/>");
		  
		  out.println("<input type='button' onclick=\"mt.act('data','"+MT.enc(t.getOrderId())+"');\" value='查看'/>");
		    	
		  if(status==0)
			  out.println("<input type='button' onclick=\"mt.act('status','"+t.getOrderId()+"',5,'取消订单');\" value='取消订单'/>");
		  /*
		  if(status==3)
			  out.println("<input type='button' onclick=\"mt.act('status','"+t.getOrderId()+"',4,'确认收货');\" value='确认收货'/>");
		  */
		  //if(status==4)
			  //out.println("<input type='button' onclick=\"mt.act('refund','"+MT.enc(t.getOrderId())+"');\" value='申请退换货'/>");
		  out.println("</li>");
		  
	  }
  }
  %>
  </ul>
  <%}
  if(sum>10)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,10)+"</div>");
}%>
</div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,orderId,status,statusContent)
{
  form2.act.value=a;
  form2.orderId.value=orderId;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='status')
  {
	  form2.status.value=status;
	  if(status==5){
	      location = '/mobjsp/yl/shopweb/ShowTextarea.jsp?orderid='+orderId;
	  }else{
		  if(confirm('你确定要"'+statusContent+'"吗？')){
			  form2.submit();
		  }
	  	//mt.show('你确定要"'+statusContent+'"吗？',2,'form2.submit()');
	  }
  }else if(a=='data'){
	  parent.location="/mobjsp/yl/shopweb/ShopOrderDatas_wx.jsp?orderId="+orderId;
  }else if(a=='payment'){
	  window.open("/mobjsp/yl/shopweb/ShopOrderPayment_wx.jsp?orderId="+orderId);
  }else if(a=='refund'){
	  parent.location="/mobjsp/yl/shopweb/ShopOrderDatasRefund_wx.jsp?orderId="+orderId;
  }else if(a=='getfp'){
	  var nurl = location.pathname+location.search;
	  parent.location="/mobjsp/yl/shopweb/ShopGetFp_wx.jsp?orderId="+orderId+"&nexturl="+nurl;
	  //parent.location="/xhtml/folder/14113269-1.htm?orderId="+orderId;
  }
};

</script>
</body>
</html>
