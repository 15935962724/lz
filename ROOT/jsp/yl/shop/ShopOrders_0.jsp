<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.Profile"%><%

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
//设置了截止日期未开票粒子数后
sql.append(" AND (ishidden=0 or ishidden is null) ");
String order_id=h.get("order_id","");
if(order_id.length()>0)
{
  sql.append(" AND so.order_id LIKE "+Database.cite("%"+order_id+"%"));
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

String[] TAB={"全部订单","待初审","待复核","确认发货","出库","买家已收货","已取消","已退货"};
String[] SQL={" AND so.status!=6","  AND so.status=-1 "," AND so.status=-2 "," AND so.status=1"," AND (so.status=2 or so.status=3)"," AND so.status=4"," AND so.status=5"," AND so.status=7"};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");



%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<h1>订单管理</h1>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
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
<!-- <h2></h2>
 --><%out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+ShopOrder.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type='hidden' name='soeid' value=''>
<input type='hidden' name='type' value=''>
<input type="hidden" name="status"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type='hidden' name='remarks'>
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<tr>
  <th width='60'>序号</th>
  <th>订单编号</th>
  <th>用户</th>
  <th>医院</th>
  <th>数量</th>
  <th>下单时间</th>
  <th>确认退货时间</th>
  <th>原订单编号</th>
  <%if(tab==0){%><th>状态</th><%}%>
  <th>操作</th>
</tr>
<%
sql.append(SQL[tab]);
int lizinum=0,othernum=0;
int sum=ShopOrder.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
}else
{
  //sql.append(" order by createDate desc");
  Iterator it=ShopOrder.find(sql.toString()+ " order by so.createDate desc ",pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  int role=AdminRole.findByName("同辐复核管理员", "Home");//角色
	  Enumeration e= AdminUsrRole.findByRole(role);

	  int drole=AdminRole.findByName("同辐初审管理员", "Home");//角色
	  Enumeration de=AdminUsrRole.findByRole(drole);
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
      if("aaa".equals(uname)||"AAA".equals(uname)){
    	  Filex.logs("ytlz.txt", "member==="+uname);
      }
      ShopOrderExpress soe=null;
      ArrayList list =ShopOrderExpress.find(" and order_id="+DbAdapter.cite(t.getOrderId()),0,1);
      soe = list.size() < 1 ? new ShopOrderExpress(0):(ShopOrderExpress)list.get(0);
      
      int status = t.getStatus();
      String statusContent = "";
      if(status==0)
    	  statusContent = "未付款";
      else if(status==1)
    	  statusContent = "确认发货";
      else if(status==2)
    	  statusContent = "未出库";
      else if(status==3)
    	  statusContent = "已出库1";
      else if(status==4)
    	  statusContent = "已完成";
      else if(status==5)
    	  statusContent = "已取消";
      else if(status==7)
    	  statusContent = "已退货";
      else if(status==-1)
    	  statusContent = "等待初审";
      else if(status==-2)
    	  statusContent = "等待复核";
      else if(status==-3)
    	  statusContent = "初审不通过";
      else if(status==-4)
    	  statusContent = "复核不通过";
  %>
  <tr>
    <td><%=i%></td>
    <td><%=t.getOrderId()%></td>
    <td><%=uname%></td>
    <%
    	if(t.getStatus()==7){
    		String oldorderid=t.getOldorderid();
    		ShopOrderDispatch oldsod=ShopOrderDispatch.findByOrderId(oldorderid);
    		out.print("<td>"+MT.f(oldsod.getA_hospital())+"</td>");
    	}else{
    		out.print("<td>"+MT.f(sod.getA_hospital())+"</td>");
    	}
    %>
    <td><%=odata.getQuantity() %></td>
    <td><%=MT.f(t.getCreateDate(),1)%></td>
    <td><%=MT.f(t.getReturntime(),1)%></td>
    <td><%=MT.f(t.getOldorderid())%></td>
    <%if(tab==0){%><td><%=statusContent%></td><%}%>
    <td>
    	<%
    	if(status==0){
    		out.println("<a href=\"javascript:mt.act('orderPayment','"+orderId+"');\">用于测试付款</a>");
    	}
    	if(status==1||(status==0&&Profile.find(t.getMember()).isvip==1))
    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',2,'发货');\">确认发货</button>");
    	/* if(status==2)
    	{
    		 out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('exp','"+orderId+"',"+soe.id+",1);\">"+(soe.time==null?"添加出厂信息":"修改出厂信息")+"</button>");
    		if(soe.time!=null)
    			out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',3,'出库');\">完成出库</button>"); 
    	} */
    	if(status==-1){//待初审 只能是订单管理员能看到
    		while(de.hasMoreElements()){
    			int dpro=Integer.parseInt(String.valueOf(de.nextElement()));
    			if(dpro==h.member){
    				out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('chushen','"+orderId+"',"+soe.id+",1);\">初审出厂信息</button>");
    				break;
    			}
    		}
    		
    	}
    	if(status==-2){//待复核（初审通过）
    		//只能是复核出库管理员可复核
    		while(e.hasMoreElements()){
    			int pro=Integer.parseInt(String.valueOf(e.nextElement()));
    			if(h.member==pro){
    				out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('fuhe','"+orderId+"',"+soe.id+",1);\">复核出厂信息</button>");
    				break;
    			}
    		}
    		
    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('chakan','"+orderId+"',"+soe.id+",1);\">查看出厂信息</button>");
    	
    	}else if(status==-3){
    		while(de.hasMoreElements()){
    			int dpro=Integer.parseInt(String.valueOf(de.nextElement()));
    			if(dpro==h.member){
    				out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('chushen','"+orderId+"',"+soe.id+",1);\">查看出厂信息</button>");
    				break;
    			}
    		}
    		
    	}else if(status==-4){//复核不通过  复核管理员都能看到
    		while(e.hasMoreElements()){
    			int pro=Integer.parseInt(String.valueOf(e.nextElement()));
    			if(h.member==pro){
    				out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('chakan','"+orderId+"',"+soe.id+",1);\">查看出厂信息</button>");
    				break;
    			}
    		}
    		
    	}
    	if(!t.isPayment()&&status==1&&status==4)
    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('payment','"+orderId+"');\">确认收款</button>");
    	%>
    	 <button type="button" class="btn btn-link" onclick="mt.act('data','<%=orderId%>')">查看详情</button>
    	 <%
    	 if("webmaster".equals(Profile.find(h.member).member))
    	 {
    	 %>
    	 <button type="button" class="btn btn-link" onclick="mt.act('del','<%=orderId%>')">删除</button>
    	 <%
    	 }
    	 if(status < 3 && ("zyadmin".equals(Profile.find(h.member).member)||"admin".equals(Profile.find(h.member).member)||"quzq_admin".equals(Profile.find(h.member).member)||"zyadmin2".equals(Profile.find(h.member).member)))
    	 	out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+t.getOrderId()+"',5,'取消订单');\" >取消订单</button>");
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
<div class='center mt15'><button class="btn btn-primary" type="button" onclick="dcorder()">导出</button></div>
</form>
<form action="/ShopOrders.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="exp_sh" type="hidden" />
	<input name="exflag" value="0" type="hidden"/>
	<input type='hidden' name='category' value="2">
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
  }else if(a=='payment')
  {
	  mt.show('你确定要“确认收款”吗？',2,'form2.submit()');
  }else if(a=='exp')
  {
	  form2.soeid.value=status;
	  form2.type.value=statusContent;
	  form2.action=("/jsp/yl/shop/ShopExpressEdit.jsp");
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
  }else if(a == 'orderPayment'){
	  mt.show('你确定要支付吗？',2,'form2.submit()');
  }else if(a=='chushen'){
	  form2.soeid.value=status;
	  form2.type.value=statusContent;
	  form2.action=("/jsp/yl/shop/ShopExpressChuShen.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='chakan'){
	  form2.soeid.value=status;
	  form2.type.value=statusContent;
	  form2.action=("/jsp/yl/shop/ShopExpressShow.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='fuhe'){
	  form2.soeid.value=status;
	  form2.type.value=statusContent;
	  form2.action=("/jsp/yl/shop/ShopExpressFuHe.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }
};

function dcorder(){
	form3.submit();
}
</script>
</body>
</html>
