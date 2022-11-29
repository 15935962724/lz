<%@page import="tea.entity.admin.AdminFunction"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.AdminRole"%><%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="tea.entity.yl.shop.Quxiaoorder"%><%@page import="java.text.SimpleDateFormat"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

if(h.isIllegal())
{
  out.println("非法操作！");
  return;
}

int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?id="+menu);

String order_id=h.get("order_id","");
if(order_id.length()>0)
{
  sql.append(" AND order_id LIKE "+Database.cite("%"+order_id+"%"));
  par.append("&order_id="+h.enc(order_id));
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

/* String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND ml.lastname+ml.firstname LIKE "+Database.cite("%"+username+"%"));
  par.append("&username="+h.enc(username));
} */

String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND m.member LIKE "+Database.cite("%"+member+"%"));
  par.append("&member="+h.enc(member));
}
String hospital = h.get("hospital","");
if(!"".equals(hospital)){
	sql.append(" AND sod.a_hospital LIKE "+Database.cite("%"+hospital+"%"));
	par.append("&hospital="+h.enc(hospital));
}
//int mystatus=h.getInt("status",5);
String mystatus=h.get("status","");
sql.append(" AND so.status in "+mystatus);
par.append("&status="+mystatus);

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

int isPayment = h.getInt("isPayment",1);
if(isPayment==0){
	sql.append(" AND isPayment=0");
	par.append("&isPayment=0");
}
//sql.append(" and (ishidden is null or ishidden=0)");

int pos=h.getInt("pos");
par.append("&pos=");

int sum=ShopOrder.count(sql.toString());

//上海管理员  14122306
AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);


SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
Date date0=sdf.parse("2017-11-1");//小于11月1日的不变，大于等于11月1日的改。

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<h1>订单管理—<%=AdminFunction.find(menu).getName(h.language) %></h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="status" value="<%=mystatus%>"/>
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='4' class='bornone'>查询</td></tr>
</thead>
<tr>
  <td width="20%">订单编号:<input name="order_id" value="<%=MT.f(order_id)%>"/></td>
  <td width="20%">用户名:<input name="member" value="<%=MT.f(member)%>"/></td>
  <td width="20%">医院:<input name="hospital" value="<%=MT.f(hospital)%>"/></td>
  <td width="35%">订单时间:<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/>  至  <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <td width="25%" class='bornone'><button class="btn btn-primary" type="submit">查询</button></td>
</tr>
</table>
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
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='10'>列表 <%=sum%></td></tr>
</thead>
<tr id="tableonetr">
  <th width='60'>序号</th>
  <th>订单编号</th>
  <th>用户</th>
  <%--if(aur.getRole().indexOf("14122306") < 0){ --%>
  <!-- th>订单金额</th -->
  <%--} --%>
  <th>医院</th>
  <th>数量</th>
  <th>下单时间</th>
  <th>发货时间</th>
  <th>签收时间</th>
  <th>状态</th> 
  <th>操作</th>

</tr>
<%
int lizinum=0,othernum=0;
if(sum<1)
{
  out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
}else
{
  sql.append(" order by so.createDate desc");
  Iterator it=ShopOrder.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopOrder t=(ShopOrder)it.next();
      String orderId=t.getOrderId();
      
      ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderId);

	  String querySql = " AND order_id="+DbAdapter.cite(orderId);
  	  List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
  	  
  	  ShopOrderData odata = ShopOrderData.find(0);
	  if(sodList.size()>0)
	  	odata = sodList.get(0);
	  
      /* String uname = MT.f(Profile.find(t.getMember()).getName(h.language));
      if(uname.trim()==null||uname.trim().equals("")||uname.trim().length()<1){
    	  uname = Profile.find(t.getMember()).member;
      } */
      String uname = MT.f(Profile.find(t.getMember()).member);
      
      int status = t.getStatus();
      
      ShopOrderExpress soe=null;
      ArrayList list =ShopOrderExpress.find(" and order_id="+DbAdapter.cite(t.getOrderId()),0,1);
      soe = list.size() < 1 ? new ShopOrderExpress(0):(ShopOrderExpress)list.get(0);
      Quxiaoorder qorder=Quxiaoorder.findByOrderId(t.getOrderId());
  %>
  <tr>
    <td><%=i%></td>
    <td><%=t.getOrderId()%></td>
    <td><%=uname%></td>
    <td><%=MT.f(sod.getA_hospital()) %></td>
    <td><%=odata.getQuantity() %></td>
    <td><%=MT.f(t.getCreateDate(),1)%></td>
    <td><%=MT.f(soe.time,1)%></td>
    <td><%=MT.f(t.getReceiptTime(),1)%></td>
    <td>
	    <%
	    	if(t.getStatus()==-1){
	    		out.print("报告待初审");
	    	}else if(t.getStatus()==-2){
	    		out.print("报告初审通过");
	    	}else if(t.getStatus()==-3){
	    		out.print("报告初审不通过");
	    	}else if(t.getStatus()==-4){
	    		out.print("报告复核不通过");
	    	}else if(t.getStatus()==3){
	    		out.print("已出库");
	    	}else if(t.getStatus()==2){
	    		out.print("未出库");
	    	}else if(t.getStatus()==4){
	    		out.print("已完成");
	    	}else if(t.getStatus()==5){
	    		out.print("已取消");
	    	}else if(t.getStatus()==6){
	    		out.print("已删除");
	    	}else if(t.getStatus()==7){
	    		out.print("已退货");
	    	}
	    %>
    </td>
    <%-- <td><%=statusContent%></td> --%>
    <td>
    	<%
    	if(isPayment==0){
	    	if(!t.isPayment()&&status!=0)
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('payment','"+orderId+"');\">确认收款</button>");
    	}else{
	    	if(status==1||(status==0&&Profile.find(t.getMember()).isvip==1))
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',2,'发货');\">确认发货</button>");
	    	if(status==-1||status==-2){//等待审核
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('exp','"+orderId+"',"+soe.id+",1);\">"+(soe.time==null?"添加出厂信息":"修改出厂信息")+"</button>");
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('showchuchang','"+orderId+"',"+soe.id+",1);\">查看出厂信息</button>");
	    	}else if(status==2)
	    	{
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('exp','"+orderId+"',"+soe.id+",1);\">"+(soe.time==null?"添加出厂信息":"修改出厂信息")+"</button>");
	    		/* if(soe.time!=null)
	    			out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',3,'出库');\">完成出库</button>");  */
	    		if(soe.id>0)	
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('expbao','"+orderId+"',"+soe.id+",1);\">上传检验报告</button>");
	    	}else if(status==-3||status==-4){//初审不通过和复核不通过
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('exp','"+orderId+"',"+soe.id+",1);\">"+(soe.time==null?"添加出厂信息":"修改出厂信息")+"</button>");
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('expbao','"+orderId+"',"+soe.id+",1);\">修改检验报告</button>");
	    	}else if(status==3){
	    		//out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('printOrder','"+orderId+"');\">打印发货单</button>");
	    		if(sdf.parse(MT.f(soe.time)).getTime()>=date0.getTime()){
		    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('printOrder','"+orderId+"');\">打印客户发货单</button>");
		    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('printOrder0','"+orderId+"');\">打印同辐出库单</button>");
		    	}else{
		    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('printOrder_old','"+orderId+"');\">打印发货单</button>");
		    	}
	    	}
    	}
    	%>
    	<%
    	    if(status==4){
    	%>
    	 <%
    	     if(sdf.parse(MT.f(soe.time)).getTime()>=date0.getTime()){
    	 %>
    	 <button type="button" class="btn btn-link" onclick="mt.act('datachu','<%=orderId%>')">已完成出库单</button>
    	 <button type="button" class="btn btn-link" onclick="mt.act('printOrder0','<%=orderId%>')">打印同辐出库单</button>
    	 <%
    	     }else{
    	 %>
    	 <button type="button" class="btn btn-link" onclick="mt.act('datachu_old','<%=orderId%>')">已完成出库单</button>
    	 <%  	 
    	     }
    	    }
    	 %>
    	 <button type="button" class="btn btn-link" onclick="mt.act('data','<%=orderId%>')">查看详情</button>
    	 <%
    	 if("webmaster".equals(Profile.find(h.member).member))
    	 {
    	 %>
    	 <button type="button" class="btn btn-link" onclick="mt.act('del','<%=orderId%>')">删除</button>
    	 <%
    	 }
    	 //只有上海出库管理员这个角色可以看到取消订单和拒绝原因
    	 List<AdminRole> lstrole=AdminRole.find(" and name in("+Database.cite("超级管理员")+","+Database.cite("上海出库管理员")+");", 0, Integer.MAX_VALUE);
    	String memberstr="";
    	 for(int k=0;k<lstrole.size();k++){
    		 AdminRole ar=lstrole.get(k);
    		 int rid=ar.getId();
    		 Enumeration enu= AdminUsrRole.findByRole(rid);
    		 while(enu.hasMoreElements()){
   	            String role = (String)enu.nextElement();//调用nextElement方法获得元素
   	            memberstr+=role+",";
    	     }
    	 }
    	 int mflag=memberstr.indexOf(MT.f(h.member));
    	 if((t.getStatus()==2||t.getStatus()==3)&&qorder.getId()==0&&mflag>-1){
    	 %>
    	 <button type="button" class="btn btn-link" onclick="mt.act('quxiaoorder','<%=orderId%>')">取消订单</button>
    	
    	 <%
    	 }
    	 if((t.getStatus()==2||t.getStatus()==3)&&qorder.getId()>0&&qorder.getStatus()==2&&mflag>-1){
    	 %>
    	 <button type="button" class="btn btn-link" onclick="mt.show('<%=qorder.getReason() %>')">取消订单拒绝原因</button>
    	
    	 <%
    	 }
    	 %>
    	 <%
    	 //out.print("<button type='button' class='btn btn-link' onclick=\"mt.act('updateremarks','"+orderId+"',2,'"+MT.f(t.getRemarks())+"');\">备注</button>");
    	 %>
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
<%
if(chukuType==1){
%>
	<div class='center mt15'><button class="btn btn-primary" type="button" onclick="dcorder()">导出</button></div>
<%} %>
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
	  form2.action=("/jsp/yl/shop/ShopOrderDatas.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='datachu'){
	  form2.action=("/jsp/yl/shop/ShopOrderDatasReceipt2.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='payment')
  {
	  mt.show('你确定要“确认收款”吗？',2,'form2.submit()');
  }else if(a=='exp')
  {
	  form2.soeid.value=status;
	  form2.type.value=statusContent;
	  form2.action=("/jsp/yl/shop/ShopExpressEdit.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='expbao')
  {
	  form2.soeid.value=status;
	  form2.type.value=statusContent;
	  form2.action=("/jsp/yl/shop/ShopExpressEdit2.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='updateremarks'){
	  mt.show("<textarea id='_content' cols='33' rows='6' title='备注'>"+statusContent+"</textarea>",2,'备注',348);
      mt.ok=function()
      {
        var t=$$('_content');
        /* if(t.value=='')
        {
          alert('“取消订单原因”不能为空！');
          return false;
        } */
        form2.remarks.value=t.value;
        form2.submit();
      };
  }else if(a=='printOrder'){
	  form2.action=("/jsp/yl/shop/ShopOrderDatasReceipt.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='printOrder0'){
	 
	  form2.action=("/jsp/yl/shop/ShopOrderDatasReceipt_tongfu.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='datachu_old'){
	  form2.action=("/jsp/yl/shop/ShopOrderDatasReceipt2_old.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='printOrder_old'){
	  form2.action=("/jsp/yl/shop/ShopOrderDatasReceipt_old.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='quxiaoorder'){
	  form2.action="/QuxiaoOrders.do";
	  mt.show('你确定要取消“'+id+'”订单吗？',2,'form2.submit()');
  }else if(a=="showchuchang"){
	  form2.soeid.value=status;
	  form2.type.value=statusContent;
	  form2.action=("/jsp/yl/shop/ShopExpressShow.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }
};

function dcorder(){
	form3.submit();
}
</script>
</body>
</html>
