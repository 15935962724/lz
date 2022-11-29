<%@page import="tea.entity.admin.AdminFunction"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@ page import="util.Config" %><%
//企业号-订单管理
Http h=new Http(request,response);
int agentid = h.getInt("agentid",1);
h.setCook("community", "Home", -1);
//String nexturl = h.get("nexturl","/mobjsp/yl/shop/ShopOrder.jsp");
	int qywxMember = h.getInt("qywxMember");
	if(qywxMember>0){
		h.member = qywxMember;
	}
if(h.member<1){
	String param = request.getQueryString();
	String url = request.getRequestURI();
	if(param != null)
		url = url + "?" + param;
  response.sendRedirect("/PhoneProjectReport.do?act=qy&agentid="+agentid+"&nexturl="+Http.enc(url));
  return;
}

int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?id="+menu);

String order_id=h.get("order_id","");
if(order_id.length()>0){
  sql.append(" AND order_id LIKE "+Database.cite("%"+order_id+"%"));
  par.append("&order_id="+h.enc(order_id));
}

Date time0=h.getDate("time0");
if(time0!=null){
  sql.append(" AND createDate>"+DbAdapter.cite(time0));
  par.append("&createDate="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null){
  sql.append(" AND createDate<"+DbAdapter.cite(time1));
  par.append("&createDate="+MT.f(time1));
}

/* String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND ml.lastname+ml.firstname LIKE "+Database.cite("%"+username+"%"));
  par.append("&username="+h.enc(username));
} */

String member=h.get("member","");
if(member.length()>0){
  sql.append(" AND m.member LIKE "+Database.cite("%"+member+"%"));
  par.append("&member="+h.enc(member));
}

//int mystatus=h.getInt("status",5);
String mystatus=h.get("status","");
if(!"".equals(mystatus)){
	sql.append(" AND status in "+mystatus);
	par.append("&status="+mystatus);
}
int chukuType = h.getInt("chukuType");
if(chukuType>0){
	if(chukuType==1){
		sql.append(" AND isLzCategory=1");
		par.append("&isLzCategory=1");
	}else{
		sql.append(" AND isLzCategory=0");
		par.append("&isLzCategory=0");
	}
		
}
    sql.append(" AND (orderType = 0  )");
int isPayment = h.getInt("isPayment",1);
if(isPayment==0){
	sql.append(" AND isPayment=0");
	par.append("&isPayment=0");
}

String puidstr = h.get("puid");
	Integer puid = Config.getInt(h.get("puid"));

	if(puid != null) {
		sql.append(" and puid=" + puid);
		par.append("&puid=" + h.get("puid"));
		//puid1=puid;
	}


int pos=h.getInt("pos");
par.append("&pos=");

int sum=ShopOrder.count(sql.toString());

//上海管理员  14122306
AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);

%>

<!DOCTYPE html>
<html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<!-- <link href="/res/Home/cssjs/14113995L1.css" rel="stylesheet" type="text/css">
 --><link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<style type="text/css">
.info{display:-webkit-box;}
.info span{-webkit-box-flex:1; text-align:left;display:block;}
</style>
</head>
<body>
	<header class="header">订单管理</header>

<%
	if(chukuType != 1){
%>
<div class='switch'>
	<form action="" name="form4">
		<input type="hidden" name="id" value="<%=menu%>"/>
		<input type="hidden" name="status" value=""/>
		<input type="hidden" name="chukuType" value=""/>
		<input type="hidden" name="isPayment" value=""/>
		<input type="hidden" name="puid" value="<%= puidstr%>"/>
		<ul id='ulwidth'>
			<li><a href="javascript:void(0)" onclick="submitStatus(0,'(0)')">未付款</a></li>
			<li><a href="javascript:void(0)" onclick="submitStatus(1,'(1)')">确认发货</a></li>
			<!-- li><a href="javascript:void(0)" onclick="submitStatus(2,'(2,3)')">出库</a></li-->
			<li><a href="javascript:void(0)" onclick="submitStatus(4,'(4)')">已完成</a></li>
			<li><a href="javascript:void(0)" onclick="submitStatus(1234,'(1,2,3,4)')">已发货未付款</a></li>
			<li><a href="javascript:void(0)" onclick="submitStatus(5,'(5)')">已取消</a></li>
		
		</ul>
	</form>
</div>
<%} %>
    <script>
        var sumw = 0;
        var ulWidth = document.getElementById("ulwidth");
        var liWidth = document.getElementById("ulwidth").getElementsByTagName("li");
        for(var i=0;i<liWidth.length;i++){
            var liWidths = liWidth[i].clientWidth;
            sumw += liWidths;
            //alert(liWidths);
            //ulWidth.style.width= liWidths+i;
        }
        ulWidth.style.width=sumw+"px";
        
    </script>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="status" value="<%=mystatus%>"/>
	<input type="hidden" name="puid" value="<%= puidstr%>"/>
<div class='radiusBox bg'>
<ul class="seachr">
<li class='bold'>查询</li>
 <li><span>订单号：</span><input name="order_id" placeholder="订单编号" value="<%=MT.f(order_id)%>"/></li>
 <li><span>用户名：</span><input name="member" placeholder="用户名"  value="<%=MT.f(member)%>"> </li>
<li><span>订单时间：</span><input name="time0" placeholder="订单时间"  type='date' value="<%=MT.f(time0)%>" /></li>
<li><span>至：</span><input name="time1" placeholder="至" type='date' value="<%=MT.f(time1)%>" /></li>
<li style="text-align:center"><button type="submit">查询</button></li>


</ul>
</div>
</form>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type='hidden' name='soeid' value=''>
<input type='hidden' name='type' value=''>
<input type="hidden" name="status" value="<%=mystatus%>"/>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type='hidden' name='remarks'>
<div class='radiusBox newlist'>

<%
int lizinum=0,othernum=0;
if(sum<1)
{
  out.print("<li style='text-align:center;list-style:none;'>暂无记录!</li>");
}else
{
  sql.append(" order by createDate desc");
  Iterator it=ShopOrder.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopOrder t=(ShopOrder)it.next();
      String orderId=t.getOrderId();
      
      ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(t.getOrderId());

	  String querySql = " AND order_id="+DbAdapter.cite(t.getOrderId());
  	  List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
  	  ShopOrderData odata =null;
  	  if(sodList.size()>0){
  		  odata=sodList.get(0);
  	  }
  	  
      String uname = MT.f(Profile.find(t.getMember()).member);
      int status = t.getStatus();
      ShopOrderExpress soe=null;
      ArrayList list =ShopOrderExpress.find(" and order_id="+DbAdapter.cite(t.getOrderId()),0,1);
      soe = list.size() < 1 ? new ShopOrderExpress(0):(ShopOrderExpress)list.get(0);
  %>
<ul>
    <li><span class="pder">订单编号：<%=t.getOrderId()%></span><span class="titme"><%=MT.f(t.getCreateDate(),1)%></span></li>
    <li class='info'>
    <span><%=uname%></span>
    <span><%=MT.f(sod.getA_hospital())%></span>
    <span>
	    <%
	        if(sodList.size()>0){
	        	out.print(odata.getActivity()+"X"+odata.getQuantity());
	        }
	    %>
        <%-- <%=odata.getActivity() %> X <%=odata.getQuantity() %> --%>
    </span>
		<span><%=MT.f(ProcurementUnit.findName((puid==null?0:puid)))%></span>
    </li>
  <li class="btn"> 
    	<%
    	if(isPayment==0){
	    	if(!t.isPayment()&&status!=0)
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('payment','"+orderId+"');\">确认收款</button>");
    	}else{
	    	if(status==1||(status==0))
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',2,'发货');\">确认发货</button>");
	    	if(status==2)
	    	{
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('exp','"+orderId+"',"+soe.id+",1);\">"+(soe.time==null?"添加出厂信息":"修改出厂信息")+"</button>");
	    		if(soe.time!=null)
	    			out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',3,'出库');\">完成出库</button>");
	    	}
    	}
    	%>
    	 <button type="button" class="btn btn-link" onclick="mt.act('data','<%=orderId%>')">查看详情</button>
    	 <%
    	 if("webmaster".equals(Profile.find(h.member).member)){
    	 %>
    	 	<button type="button" class="btn btn-link" onclick="mt.act('del','<%=orderId%>')">删除</button>
    	 <%}%>
    	
    </li>
    </ul>
  <%}
  if(sum>20)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</div>
</form>
<form action="/ShopOrders.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="exp_sh" type="hidden" />
	<input name="exflag" value="0" type="hidden"/>
	<input type='hidden' name='category' value="0">
		<input type='hidden' name="sql" value="<%= sql.toString() %>" />
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,status,statusContent)
{
  form2.act.value=a;
  form2.orderId.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='status')
  {
	  form2.status.value=status;
	  mt.show('你确定要“'+statusContent+'”吗？',2,'form2.submit()');
  }else if(a=='data')
  {
	  form2.action=("/mobjsp/yl/shop/ShopOrderDatas.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='payment')
  {
	  mt.show('你确定要“确认收款”吗？',2,'form2.submit()');
  }else if(a=='exp')
  {
	  form2.soeid.value=status;
	  form2.type.value=statusContent;
	  form2.action=("/mobjsp/yl/shop/ShopExpressEdit.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }
};

function dcorder(){
	form3.submit();
}

function submitStatus(status,value){
	form4.status.value=value;
	
	if(status == 2){ //出库
		form4.chukuType.value = 2;
	}else if(status == 3){  //上海出库
		form4.chukuType.value = 1;
	}else if(status == 1234){	//已发货未付款
		form4.isPayment.value = 0;
	}
	form4.action=("/mobjsp/yl/shop/ShopOrder.jsp");
	form4.target='_self';form4.method='get';form4.submit();
}
</script>
</body>
</html>
