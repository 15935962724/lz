<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %><%

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
String act=h.get("act");
if("POST".equals(request.getMethod()))
{
	if("wancheng".equals(act)){
		String orderId0=h.get("orderId");
		ShopOrder order0=ShopOrder.findByOrderId(orderId0);
		if(order0.getStatus() == 3){
			order0.setStatus(4); 	//已完成（已签收）
			order0.setReceiptTime(new Date());	//签收时间
    			
    		order0.set();
    		 out.print("<script>parent.mt.show('操作执行成功！',1,'"+h.get("nexturl")+"')</script>");
		}
	}
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
sql.append(" and (ishidden=0 or ishidden is null)");
sql.append(" and so.order_id in(select order_id from shopOrderDispatch where a_hospital in("+DbAdapter.cite("山东省医学影像学研究所CT室")+","+DbAdapter.cite("山东省医学影像学研究所B超室")+","+DbAdapter.cite("山东省医学影像学研究所磁共振室")+","+DbAdapter.cite("新疆医科大学附属肿瘤医院")+","+DbAdapter.cite("上海市第六人民医院东院")+"))");
par.append("?id="+menu);

Integer puid = Config.getInt(h.get("puid"));
int puid1 = h.getInt("puid1");

if(puid != null) {
    sql.append(" and puid=" + puid);
    par.append("&puid=" + h.get("puid"));
    puid1=puid;
}

if(puid1 > 0){
    sql.append(" and puid="+puid1);
}

//设置了截止日期未开票粒子数后
//sql.append(" AND (ishidden=0 or ishidden is null) ");
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
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND createDate<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
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

String[] TAB={"已出库","已完成"};
String[] SQL={" AND so.status=3","  AND so.status=4 "};

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
<tr><td colspan='6' class='bornone'>查询</td></tr>
</thead>
<tr>
  <td nowrap="">订单编号：<input name="order_id" value="<%=MT.f(order_id)%>"/></td>
  <td nowrap="">用户名：<input name="member" value="<%=MT.f(member)%>"/></td>
  <td nowrap="">医院：<input name="hospital" value="<%=MT.f(hospital)%>"/></td>
    <%
        if(puid == null){
    %>
    <td nowrap="">厂商：
        <select name="puid1">
            <option>请选择</option>
            <%
                List<ProcurementUnit> puList = ProcurementUnit.find("", 0, 10);
                for (int i = 0; i < puList.size(); i++) {
                    out.print("<option "+(puid1==puList.get(i).getPuid()?"selected='selected'":"")+" value='"+puList.get(i).getPuid()+"'>"+puList.get(i).getName()+"</option>");
                }
            %>
        </select>
    </td>
    <%
        }
    %>
  <td nowrap="">订单时间>：<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/>  至  <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <td width="" class='bornone'><button class="btn btn-primary" type="submit">查询</button></td>
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
  <th>厂商</th>
  <th>数量</th>
  <th>下单时间</th>
  <!-- <th>确认退货时间</th>
  <th>原订单编号</th> -->
  <th>状态</th>
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
	  //int role=AdminRole.findByName("同辐复核管理员", "Home");//角色
	  int role=AdminRole.findByName("同辐入库管理员", "Home");//角色
	  Enumeration e= AdminUsrRole.findByRole(role);

	  //int drole=AdminRole.findByName("同辐初审管理员", "Home");//角色
	  int drole=AdminRole.findByName("质量验收员", "Home");//角色
	  Enumeration de=AdminUsrRole.findByRole(drole);
	  
	  ShopOrder t=(ShopOrder)it.next();
	  int crole=AdminRole.findByName("同辐出库管理员", "Home");//角色
	  if(Config.getInt("gaoke")==t.getPuid()){
		   crole=AdminRole.findByName("高科出库管理员", "Home");//角色
	  }else if(Config.getInt("junan")==t.getPuid()){
		   crole=AdminRole.findByName("君安出库管理员", "Home");//角色
	  }
	  Enumeration ce=AdminUsrRole.findByRole(crole);
	  
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
      ProcurementUnit p = ProcurementUnit.find(t.getPuid());
      int status = t.getStatus();
      String statusContent = "";
      if(status==0)
    	  statusContent = "未付款";
      else if(status==1)
    	  statusContent = "确认发货";
      else if(status==2)
    	  statusContent = "未出库";
      else if(status==3)
    	  statusContent = "已出库";
      else if(status==4)
    	  statusContent = "已完成";
      else if(status==5)
    	  statusContent = "已取消";
      else if(status==7)
    	  statusContent = "已退货";
      else if(status==-1)
    	  statusContent = "待验收";
      else if(status==-2)
    	  statusContent = "待入库";
      else if(status==-3)
    	  statusContent = "验收不通过";
      else if(status==-4)
    	  statusContent = "入库不通过";
      else if(status==-5)
    	  statusContent = "待出库";
  %>
  <tr>
    <td><%=i%></td>
    <td><%=t.getOrderId()%></td>
    <td><%=uname%></td>
    <%
    	
    	out.print("<td>"+MT.f(sod.getA_hospital())+"</td>");
    %>
      <td><%=MT.f(p.getName())%></td>
    <td><%=odata.getQuantity() %></td>
    <td><%=MT.f(t.getCreateDate(),1)%></td>
    <td><%=statusContent%></td>
    <td>
    	<%
    	
    	if(status==3)
    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('wancheng','"+orderId+"');\">确认订单完成</button>");
    	
    	 %>
    	 <button type="button" class="btn btn-link" onclick="mt.act('data','<%=orderId%>')">查看详情</button>
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
mt.act=function(a,id)
{
  form2.act.value=a;
  form2.orderId.value=id;
  if(a=='wancheng'){
	  form2.action="?";
	  mt.show('你确定订单已完成吗？',2,'form2.submit()');
  }else if(a=='data')
  {
	  form2.action=("/jsp/yl/shop/ShopOrderDatas.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }
};

function dcorder(){
	form3.submit();
}
</script>
</body>
</html>
