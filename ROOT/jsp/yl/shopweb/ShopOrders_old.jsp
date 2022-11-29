<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

sql.append(" AND member="+h.member);
par.append("&member="+h.member);

sql.append(" AND status!=6");
par.append("&status!=6");
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
  par.append("&createDate="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND createDate<"+DbAdapter.cite(time1));
  par.append("&createDate="+MT.f(time1));
}

int puid = h.getInt("puid",-1);
if(puid!=-1){
	sql.append(" AND puid = "+puid);
	  par.append("&puid="+puid);
}


String[] TAB={"全部订单","等待付款","等待发货","等待收货","已完成","已取消","已退货"};
String[] SQL={"  "," AND status=0"," AND (status=1 or status=2 or status=-1 or status=-2 or status=-3 or status=-4 or status=-5)"," AND status=3"," AND status=4"," AND status=5"," AND status = 7"};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

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
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="query">
<table id="tablecenter" cellspacing="0">
<tr>
  <td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>" readonly/>
	<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopwebnew/Selhospital.jsp',1,'选择医院',500,500)" type="button" value="请选择"/>  
  </td>
  <td>订单编号：<input name="orderId" value="<%=MT.f(orderId)%>"/></td>
  <td>厂商：
  <select name='puid'>
	  <option value=''>请选择</option>
	  <option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
	  <option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
	  <option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
  </select>
  </td>
</tr>
<tr>
  <td style="text-align:left">订单时间：<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/>　　至</td>
  <td style="text-align:left"><input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/>　　<input type="submit" class="button" value="查询"/></td>
  
</tr>

</table>
</div>
</form>

<%out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+ShopOrder.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="cancelReason"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class="results">
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>订单编号</td>
  <!-- <td>用户</td> -->
  <td>医院</td>
  <td>数量</td>
  <td>已开票数量</td>
  <td>下单时间</td>
  <td>厂商</td>
  <%if(tab==0){%><td>状态</td><%}%>
  <td>操作</td>
</tr>
<%
sql.append(SQL[tab]);

int sum=ShopOrder.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='7' align='center'>暂无记录!</td></tr>");
}else
{
  //sql.append(" order by createDate desc");
  Iterator it=ShopOrder.find(sql.toString()+" order by createDate desc ",pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopOrder t=(ShopOrder)it.next();
	  
	  ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(t.getOrderId());

	  String querySql = " AND order_id="+DbAdapter.cite(t.getOrderId());
  	  List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
  	ShopOrderData odata=null;
  	  if(sodList.size()>0){
  		 
  		//Filex.logs("yt.txt",t.getOrderId());
  		 odata=sodList.get(0);
  	  }
  	  
  		
  	  
  	  
  	  
      String uname = MT.f(Profile.find(t.getMember()).member);
      int status = t.getStatus();
      String statusContent = "";
      if(status==0)
    	  statusContent = "等待付款";
      else if(status==1||status==2||status==-1||status==-2||status==-3||status==-4||status==-5)
    	  statusContent = "等待发货";
      else if(status==3)
    	  statusContent = "等待收货";
      else if(status==4)
    	  statusContent = "已完成";
      else if(status==5)
    	  statusContent = "<a href='###' onclick=\"mt.show('"+MT.f(t.getCancelReason())+"');\">已取消</a>";
   	  else if(status==7)
       	  statusContent = "已退货";
  %>
  <tr>
    <td><%=i%></td>
    <td class="orderId"><%=t.getOrderId()%></td>
    <%-- <td><%=uname%></td> --%>
    <td><%=MT.f(sod.getA_hospital()) %></td>
    <td>
    <%
    if(sodList.size()>0){
    	out.print(odata.getQuantity());
    }
    %>
    
    </td>
    <td><%=t.getIsinvoicenum() %></td>
    <td><%=MT.f(t.getCreateDate(),1)%></td>
    <td><%= ProcurementUnit.findName(t.getPuid()) %></td>
    <%if(tab==0){%><td><%=statusContent%></td><%}%>
    <td>
    	<%
    	/* if(Profile.find(h.member).membertype!=2){
   		 if(status>0){
   			 if(t.getInvoiceStatus()==0){
		    	out.println("<a href=\"javascript:mt.act('getfp','"+t.getOrderId()+"');\">索要发票</a>");
   			 }
   		 }
   	 }else{
   		if(t.getInvoiceStatus()==0){
	    	out.println("<a href=\"javascript:mt.act('getfp','"+t.getOrderId()+"');\">索要发票</a>");
			 }
   	 } */
   	 //2017.1.12加 小屈说有一票PO1611020010的订单用户下单后，订单状态是已完成的了，这时他办理了退货，但是在用户的个人中心还能看到“索要发票”。（yt改为已退换货的订单不能再索要发票了）
   	 List<ShopExchanged> exchangelst=ShopExchanged.find(" and order_id="+Database.cite(t.getOrderId()), 0, Integer.MAX_VALUE);
   	 if(exchangelst.size()==0){
    	if(status!=5&&t.getInvoiceStatus()==0){
    		if(Profile.find(h.member).membertype!=2){
    			if(status>0){
    				//out.println("<a href=\"javascript:mt.act('getfp','"+MT.enc(t.getOrderId())+"');\">索要发票</a>");
    			}
    		}else{
        	    //out.println("<a href=\"javascript:mt.act('getfp','"+MT.enc(t.getOrderId())+"');\">索要发票</a>");
           	}
    	}
     }
   	 /*
    	if(status==0){
			int count = ShopOrderData.count(" AND order_id = "+Database.cite(t.getOrderId())+" AND sp.state <> 0");
			if(count==0){
	    		out.println("<a href=\"javascript:mt.act('payment','"+MT.enc(t.getOrderId())+"');\">付款</a>");
			}
    	}
    	*/
    	out.println("<a href=\"javascript:mt.act('data','"+MT.enc(t.getOrderId())+"');\">查看</a>");
    	
    	if(status==0)
    		out.println("<a href=\"javascript:mt.act('status','"+t.getOrderId()+"',5,'取消订单');\" >取消订单</a>");
    	if(status==3){
    		/* 
    		暂时放开-2016-02-15*/
    		/*
    		服务商不能确认收货 2017-5-15日，小屈通知改回来
    		*/
    		Profile m=Profile.find(h.member);
    		if(m.membertype==2)
    			out.println("<a href=\"javascript:mt.act('printOrder','"+t.getOrderId()+"');\">打印发货单</a>");
    		//if(m.membertype != 2) //服务器，不允许确认收货，只能通过签收人微信扫码 
    			out.println("<a href=\"javascript:mt.act('status','"+t.getOrderId()+"',4,'确认收货');\">确认收货</a>");
    	}
    	//if(status==4||status==5)
    	//	out.println("|<a href=\"javascript:mt.act('status','"+t.getOrderId()+"',6,'删除订单');\">删除</a>");
    	if(status==4){
    		ShopExchanged ex=ShopExchanged.findByOrderId(t.getOrderId());
    		if(ex.id>0){
    			out.println("<a href=\"javascript:mt.act('refund','"+MT.enc(t.getOrderId())+"');\">查看退换货</a>");
        		
    		}else{
    			out.println("<a href=\"javascript:mt.act('refund','"+MT.enc(t.getOrderId())+"');\">申请退换货</a>");
        		
    		}
    		Profile m=Profile.find(h.member);
    		if(m.membertype==2){
    			out.println("<a href=\"javascript:mt.act('printOrder','"+t.getOrderId()+"');\">打印发货单</a>");
    		}
    	}
    		
    	%>
    	 
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='12' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
<%
Profile pro = Profile.find(h.member);
if(pro.getMembertype() == 2){
	sql.append(" AND isLzCategory=1");
	sql.append(" order by createDate desc");
%>
	<div class='center mt15'><button class="btn btn-primary" type="button" onclick="dcorder()">导出</button></div>
<%} %>
</form>
<form action="/ShopOrders.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="exp_sh" type="hidden" />
	<input name="exflag" value="0" type="hidden"/>
	<input type='hidden' name='category' value="14102669">
		<input type='hidden' name="sql" value="<%= sql.toString() %>" />
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
		  mt.show("<textarea id='_content' cols='33' rows='6' title='请填写取消订单原因...'></textarea>",2,'取消订单原因',348);
	      mt.ok=function()
	      {
	        var t=parent.$$('_content');
	        if(t.value=='')
	        {
	          alert('“取消订单原因”不能为空！');
	          return false;
	        }
	        form2.cancelReason.value=t.value;
	        form2.submit();
	      };
	  }else{
	  	mt.show('你确定要"'+statusContent+'"吗？',2,'form2.submit()');
	  }
  }else if(a=='data')
  {
	  //window.open("ShopOrderDatas.jsp?orderId="+orderId);
	  parent.location="/html/folder/14110832-1.htm?orderId="+orderId;

  }else if(a=='payment')
  {
	  //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
	  window.open("/html/folder/14110391-1.htm?orderId="+orderId);
  }else if(a=='refund')
  {
	  //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
	  parent.location="/html/folder/14111279-1.htm?orderId="+orderId;
  }else if(a=='getfp'){
	  //parent.location="/jsp/yl/shopweb/ShopGetFp.jsp?orderId="+orderId;
	  parent.location="/html/folder/14113269-1.htm?orderId="+orderId;
  }else if(a=='printOrder'){
	  /* form2.action=("/jsp/yl/shop/ShopOrderDatasReceipt.jsp");
	  form2.target='_self';form2.method='get';form2.submit(); */
	 // parent.location="/jsp/yl/shop/ShopOrderDatasReceipt.jsp";
	  parent.location="/html/folder/17072660-1.htm?orderId="+orderId;
  }
};
function dcorder(){
	form3.submit();
}
mt.receive=function(v,n,h){
	  document.getElementById("hname").value=v;
	};
mt.fit();
</script>
</body>
</html>
