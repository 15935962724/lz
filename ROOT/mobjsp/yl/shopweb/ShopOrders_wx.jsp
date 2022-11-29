<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
String community = h.get("community","");
if(community.equals("")){
community = h.getCook("community", "Home");
}
h.setCook("community", community, Integer.MAX_VALUE);


    String openid=h.getCook("openid",null);
    //out.print("<script>alert('"+openid+"');</script>");
	
    //Filex.logs("openid.txt", openid);
    //Filex.logs("openid.txt", openid);
	if(openid==null){
		response.sendRedirect("/PhoneProjectReport.do?act=openid&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()+"&r="+Math.random()));
		return;
	}
	
	List<Profile> lstp= Profile.find1(" and openid="+DbAdapter.cite(openid), 0, 1);
	if(lstp.size()==0){
		String param = request.getQueryString();
		String url = request.getRequestURI();
		if(param != null)
			url = url + "?" + param;
		response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
		return;
	}
	Profile p1=lstp.get(0);
	if(p1.profile>0){
		h.member=p1.profile;
		session.setAttribute("member",h.member);
		//out.print("<script>alert('a:"+h.member+"');</script>");
		
	}
	Filex.logs("openid.txt", "profile:"+p1.profile);
	Filex.logs("openid.txt", "profile2:"+h.member);
/* if(h.member<1){
	String param = request.getQueryString();
	String url = request.getRequestURI();
	if(param != null)
		url = url + "?" + param;
	response.sendRedirect("/mobjsp/yl/user/login_wx.jsp?nexturl="+url);
	return;
} */

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

Profile profile=Profile.find(h.member);
//签收的订单
/* int sign_openid = h.getInt("sign_openid",0);
if(sign_openid > 0){
	Profile p = Profile.find(h.member);
	sql.append(" AND sign_user_openid = "+DbAdapter.cite(p.openid));
	par.append("&sign_openid="+sign_openid);
}else{
	sql.append(" AND member="+h.member);
	par.append("&member="+h.member);
} */
//2017.11.21改为服务商和签收人都能看到此页面。

int sign_openid = h.getInt("sign_openid",0);
if(sign_openid > 0){
	Profile p = Profile.find(h.member);
	sql.append(" AND sign_user_openid = "+DbAdapter.cite(p.openid));
	par.append("&sign_openid="+sign_openid);
}else if(profile.membertype==2){
	//服务商
	
	sql.append(" AND member="+h.member);
	par.append("&member="+h.member);
}else if(profile.membertype==0){
	//签收人
	sql.append(" AND order_id in (select order_id from shoporderdispatch where a_consignees="+DbAdapter.cite(profile.member)+")");
}
// 添加只查询粒子订单

//索要发票 - 查询未开票的订单
int invoiceStatus = h.getInt("isFP",0);
if(invoiceStatus > 0){
	sql.append(" AND invoiceStatus=0 AND status!=5");
	par.append("&isFP=1");
}
//标记索要发票时不显打印发货单按钮
int flag=0;
if(invoiceStatus==1){
	flag=1;
}

sql.append(" AND status!=6");
par.append("&status!=6");

//设置了截止日期未开票粒子数后
sql.append(" AND (ishidden=0 or ishidden is null) ");
//订单状态
String[] TAB={"全部订单","尚未付款","等待发货","等待收货","已收货","已取消","索要发票"};
String[] SQL={"  "," AND status=0"," AND (status=1 or status=2 or status=-1 or status=-2 or status=-3 or status=-4 or status=-5)"," AND status=3"," AND status=4"," AND status=5",""};
//获取当前状态下的订单列表
int tab = h.getInt("status",6);
if(tab > 0){
	sql.append(SQL[tab]);
	par.append("&status="+tab);
}
//按条件查询
//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and order_id in (select order_id from shoporderdispatch where a_hospital like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}
String orderId=h.get("orderId","");
if(orderId.length()>0)
{
  sql.append(" AND order_Id LIKE "+Database.cite("%"+orderId+"%"));
  par.append("&orderId="+h.enc(orderId));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND createDate>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND createDate<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}
int pos=h.getInt("pos");
par.append("&pos=");

%>
<!DOCTYPE html><html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="/mobjsp/yl/shopwebnew/webcss.css" rel="stylesheet" type="text/css">
<title>我的订单-<%=TAB[tab] %></title>
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
<form name="form1" action="?">
<input type="hidden" name="status" value="<%=tab %>" />
<div class="query">
<table  id="tableweb" cellspacing="0">
<tr>
  <td >医院：<input type="text" name="hname" id="hname" value="<%=hname %>" readonly/>
  <input id="hospitalsel" onclick="mt.show('/mobjsp/yl/shopwebnew/Selhospital.jsp',1,'选择医院',500,500)" type="button" value="请选择"/>
  </td>
  </tr>
  <tr>
  <td >订单编号：<input type="text"  name="orderId" value="<%=MT.f(orderId)%>"/></td>
<tr>
  <td>订单时间：<input type="text" name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date" style="width:100px;"/>　至　
  <input type="text" name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date" style="width:100px;"/></td>
</tr>
<tr>
  <td style="text-align:center;"><input type="submit" class="button" value="查询"/></td>
</tr>

</table>
</div>
</form>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="cancelReason"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class="results newlist ">

<%

/* if(profile.member.equals("mawenya")){
	Filex.logs("openid.txt", "if");
	sql.delete(0, sql.length());
	sql.append(" and order_id="+DbAdapter.cite("po1812030006"));
} */
Filex.logs("openid.txt", "sql:"+sql.toString());
int sum=ShopOrder.count(sql.toString());
if(sum<1){
  out.print("<ul class='contcenter'><li>您还没有相关订单</li></ul>");
}else{
  sql.append(" order by createDate desc");
  
  Iterator it=ShopOrder.find(sql.toString(),pos,10).iterator();
  for(int i=1+pos;it.hasNext();i++){
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
    <span class="td01"><%=statusContent%></span>
    </li>
    <li class="tr_tit">
    <span nowrap align="right" style="color:#999999;"><%=MT.f(t.getCreateDate(),1)%></span>
  </li>
  
  <%
//根据订单id查询订单详情信息
  Iterator it2=ShopOrderData.find(" AND order_id="+DbAdapter.cite(t.getOrderId()),pos,Integer.MAX_VALUE).iterator();
  for(int j=1;it2.hasNext();j++){
	  ShopOrderData sod=(ShopOrderData)it2.next();
	  ShopOrderDispatch disp = ShopOrderDispatch.findByOrderId(sod.getOrderId());
	  out.println("<li>");
	  out.println("<span>"+disp.getA_hospital()+"</span>");
	  out.println("<span>活度："+sod.getActivity()+"</span>");
	  out.println("<span>数量："+sod.getQuantity()+"</span>");
	  out.println("</li>");
	  
	  //签收人查看订单，没有操作权限
	  if(sign_openid == 0){
		  //out.println("<li><span class='td_all'>订单金额：<em>&yen&nbsp;"+MT.f((double)t.getAmount(),2)+"</em></span></li>");
		  out.println("<li class='td_but'>");
		  out.println("<input type='button' onclick=\"mt.act('data','"+MT.enc(t.getOrderId())+"');\" value='订单详情'/>");
		  /*
		  if(status!=5&&t.getInvoiceStatus()==0){
	  		if(Profile.find(h.member).membertype!=2){
	  			if(status>0){
	  				out.println("<input type='button' onclick=\"mt.act('getfp','"+MT.enc(t.getOrderId())+"');\" value='索要发票'/>");
	  			}
	  		}else{
	  			out.println("<input type='button' onclick=\"mt.act('getfp','"+MT.enc(t.getOrderId())+"');\" value='索要发票'/>");
	        }
	      }
		  */
		  if(invoiceStatus > 0){
			  out.println("<input type='button' onclick=\"mt.act('getfp','"+MT.enc(t.getOrderId())+"');\" value='索要发票'/>");
		  }else{
			  if(status==0)
				  out.println("<input type='button' onclick=\"mt.act('status','"+t.getOrderId()+"',5,'取消订单');\" value='取消订单'/>");
		  }
		  
		  
		  if(status==3){
			  /* 
	    		暂时放开-2016-02-15
	    		Profile m=Profile.find(h.member);
	    		if(m.membertype != 2) //服务器，不允许确认收货，只能通过签收人微信扫码 */
    			Profile m=Profile.find(h.member);
	    		if(m.membertype == 2||m.membertype==0){
	    			if(flag==0){
	    				out.println("<input type='button' onclick=\"mt.act('printOrder','"+t.getOrderId()+"');\" value='打印发货单'/>");
	    			}
	    		}
	    		//if(m.membertype != 2) //服务器，不允许确认收货，只能通过签收人微信扫码 
			  	//out.println("<input type='button' onclick=\"mt.act('status','"+t.getOrderId()+"',4,'确认收货');\" value='确认收货'/>");
		  }
		  if(status==4){
			  Profile m=Profile.find(h.member);
			  if(m.membertype == 2){
				  if(flag==0){
	    	      	out.println("<input type='button' onclick=\"mt.act('printOrder','"+t.getOrderId()+"');\" value='打印发货单'/>");
				  }
			  }
			  ShopExchanged exchanged=ShopExchanged.findByOrderId(t.getOrderId());
	    		if(exchanged.id==0){
	    			out.println("<input type='button' onclick=\"mt.act('refund','"+t.getOrderId()+"');\" value='申请退换货'/>");
	        	}else{
	        		out.println("<input type='button' onclick=\"mt.act('refund','"+t.getOrderId()+"');\" value='查看退换货'/>");
	        	}
			 
		  }
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
	      location = '/mobjsp/yl/shopweb/ShowTextarea_wx.jsp?orderid='+orderId;
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
  }else if(a=='printOrder'){
	  parent.location="/mobjsp/yl/shopweb/ShopOrderDatasReceipt.jsp?orderId="+orderId+"&nexturl="+nurl;
  }
};
mt.receive=function(v,n,h){
	  document.getElementById("hname").value=v;
	};

</script>
</body>
</html>
