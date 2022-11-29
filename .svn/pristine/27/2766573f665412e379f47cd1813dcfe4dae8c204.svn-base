<%@page import="tea.entity.admin.AdminFunction"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.AdminRole"%><%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="tea.entity.yl.shop.Quxiaoorder"%><%@page import="java.text.SimpleDateFormat"%>
<%@ page import="util.Config" %>
<%@ page import="tea.entity.admin.orthonline.Hospital" %>
<%

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

Integer puid = Config.getInt(h.get("puid"));

if(puid != null) {
	par.append("&puid=" + h.get("puid"));
	if(puid==19041188||puid==19041185) {//高科  看d
		//查该厂商的所有商品
		StringBuilder sbr = new StringBuilder();
		sbr.append("0,");
		//高科的所有产品
		ArrayList arrayList = ShopProduct.find(" AND puid=19041188", 0, Integer.MAX_VALUE);
		for (int i = 0; i < arrayList.size(); i++) {
			ShopProduct shopProduct = (ShopProduct) arrayList.get(i);
			if (i == arrayList.size() - 1) {
				sbr.append(shopProduct.product);
			} else {
				sbr.append(shopProduct.product).append(",");
			}
		}
		if(puid==19041188){
			//多看 君安开票 高科商品的
			sql.append(" AND (so.puid=19041188 OR ( so.puid=19041185 AND soda.product_id in("+sbr.toString()+") ))");
		}else {
			sql.append(" AND so.puid=19041185  AND soda.product_id not in (" + sbr.toString() + ")");
		}
	}else {
		sql.append(" AND so.puid=" + puid);
		//puid1=puid;
	}
	//puid1=puid;
}

/*
if(puid1 > 0){
	sql.append(" and puid="+puid1);
}
*/

sql.append(" and (ishidden=0 or ishidden is null)");
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
int hospital = h.getInt("hospital");
ShopHospital sh1 = ShopHospital.find(hospital);
if(hospital>0){
	sql.append(" AND sod.a_hospital_id = "+hospital);
	par.append("&hospital="+hospital);
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

	Integer sppuid = Config.getInt(h.get("sppuid"));//商品厂家

	if(sppuid != null) {

	    List<ShopProduct> splist = ShopProduct.find(" AND puid = "+sppuid,0,Integer.MAX_VALUE);
	    String psql = " soda.product_Id = 123 ";
        for (int q = 0; q < splist.size(); q++) {
            ShopProduct sp1 = splist.get(q);
            if(MT.f(psql).length()>0){
                psql +=" or ";
            }
            psql += " soda.product_Id ="+sp1.product;
        }
	    //sql.append(" AND soda.product_id in(select product from ShopProduct where puid = "+sppuid+") ");
        sql.append(" AND soda.product_Id <> 0 AND("+psql+")");
        //sql.append(" AND (select count(1) from  ShopOrderdata sd inner join shopproduct sp on sd.product_id = sp.product where  sd.order_id = so.order_id  and sp.puid = "+sppuid+" ) > 0");
		par.append("&sppuid="+h.get("sppuid"));
	}


	int fpstatus = h.getInt("fpstatus",-1);
	if(fpstatus!=-1){
		if(fpstatus==0){
			sql.append(" AND (select count(1) from ShopOrderDatasBatches where ShopOrderDatasBatches.ordercode = so.order_id ) = 0 ");
		}else{
			sql.append(" AND (select count(1) from ShopOrderDatasBatches where ShopOrderDatasBatches.ordercode = so.order_id ) > 0 ");
		}
		par.append("&fpstatus="+fpstatus);
	}

	int allocate = h.getInt("allocate",-1);
	if(allocate==1){//调配
		sql.append(" AND allocate = 1 ");
		par.append("&allocate="+h.get("allocate"));
	}

	String fptime = h.get("fptime");

	int newdate = h.getInt("newdate");//1 查今天

	if(newdate==1){
		fptime = MT.f(new Date());
	}

	if(MT.f(fptime).length()>0){
		//sql.append(" AND spdb.id <> 0  AND CONVERT(varchar(100), spdb.time, 23) = "+Database.cite(fptime));
		sql.append(" AND so.order_Id in (select ordercode from ShopOrderDatasBatches where ShopOrderDatasBatches.ordercode=so.order_Id AND CONVERT(varchar(100), ShopOrderDatasBatches.time, 23) = "+Database.cite(fptime)+" ) ");
		par.append("&fptime="+h.get("fptime"));
	}



int pos=h.getInt("pos");
par.append("&pos=");

int sum=ShopOrder.count(sql.toString());
	List<ShopOrder> solist = ShopOrder.find(" AND so.status!=5 " + sql.toString() +" order by so.createDate desc ", 0, Integer.MAX_VALUE);




//上海管理员  14122306
AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);
//判断当前登录用户的角色
int jflag=0;
if(aur.role.indexOf("14122306")>-1){
	//上海出库管理员
	jflag=1;
}else if(aur.role.indexOf("18011995")>-1){
	//厂家质检员
	jflag=2;
}

    String rolename = AdminRole.f(aur.getRole());//角色名称
    if(rolename.indexOf("出库管理员")!=-1){
        jflag=1;
    }else if(rolename.indexOf("质检员")!=-1){
        //质检员
        jflag=2;
    }





SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
Date date0=sdf.parse("2017-11-1");//小于11月1日的不变，大于等于11月1日的改。


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
</head>
<body>
<h1>订单管理—<%=AdminFunction.find(menu).getName(h.language) %></h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="status" value="<%=mystatus%>"/>
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='6' class='bornone'>查询</td></tr>
</thead>
<tr>
  <td nowrap="">订单编号：<input name="order_id" value="<%=MT.f(order_id)%>"/></td>
  <td nowrap="">用户名：<input name="member" value="<%=MT.f(member)%>"/></td>
  <td class='bornone'  rowspan="3"><button class="btn btn-primary" type="submit">查询</button></td>
</tr>
	<tr><td nowrap="">医院：<input name="hospital" id="hid" type="hidden" value="<%= hospital%>" /><input id="hid1" readonly value="<%= MT.f(sh1.getName())%>"  /><input type="button" onclick="selHospital()" value="选择医院" /><input type="button" value="清除" onclick="delHospital()" /></td>
		<td nowrap="">订单时间：<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/>  至  <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
	</tr>
<%
	if((MT.f(h.get("sppuid")).equals("junan"))||(MT.f(h.get("puid")).equals("junan"))){//君安商品
		%>
	<tr><td nowrap="">分批日期：<input name="fptime" value="<%=MT.f(fptime)%>" onclick="mt.date(this)" class="date"/></td>
		<td nowrap="">分批状态：
		<select name="fpstatus">
			<option value="">请选择</option>
			<option value="0" <%= (fpstatus==0?"selected='selected'":"")%> >未分批</option>
			<option value="1" <%= (fpstatus==1?"selected='selected'":"")%>  >已分批</option>
		</select>
		</td>
	</tr>
	<%
	}
%>
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
<tr><td colspan='21'>列表 <%=sum%></td></tr>
</thead>
<tr id="tableonetr">
  <th width='60'>序号</th>
  <th>订单编号</th>
  <th>用户</th>
  <%--if(aur.getRole().indexOf("14122306") < 0){ --%>
  <!-- th>订单金额</th -->
  <%--} --%>
	<th>服务商公司名称</th>
  <th>医院</th>
  <th>开票单位</th>
	<th>商品厂商</th>
  <th>数量</th>
	<%
		//if(!h.get("puid").equals("tongfu"))
		{
			out.print("<th>活度</th>");
		}
	%>
  <th>下单时间</th>
  <th>发货时间</th>
  <th>签收时间</th>
  <th>状态</th>
	<%
		if(h.get("puid").equals("junan")||(h.get("puid").equals("tongfu")&&h.get("sppuid").equals("junan"))){
			out.print("<th>分批状态</th>");
			out.print("<th>分批时间</th>");
			out.print("<th>是否需要调配</th>");
		}

	%>

  <th>操作</th>

</tr>
<%
int lizinum=0,othernum=0;
if(sum<1)
{
  out.print("<tr><td colspan='21' class='noCont'>暂无记录!</td></tr>");
}else
{
  sql.append(" order by so.createdate desc");
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
	  ProcurementUnit p = ProcurementUnit.find(t.getPuid());
	  int aaa = ShopOrderData.findPuid(t.getOrderId());
	  int ho_id=0;
	  String fwsName ="";
	   List<ShopHospital> list1 = ShopHospital.find("AND name=" + DbAdapter.cite(sod.getA_hospital()), 0, Integer.MAX_VALUE);
	  for (ShopHospital d : list1) {
		  ho_id = d.getId();
	  }



	  if(ho_id !=0){
		 ProcurementUnitJoin pu =  ProcurementUnitJoin.find(aaa,t.getMember(),ho_id);
		  fwsName=pu.getCompany();
	  }






%>
  <tr>
    <td><%=i%></td>
    <td><%=t.getOrderId()%></td>
    <td><%=uname%></td>
	  <td><%=MT.f(fwsName)%></td>
    <td><%=MT.f(sod.getA_hospital()) %></td>
    <td><%=MT.f(p.getName())%></td>
	  <td><%= MT.f(ProcurementUnit.findName(ShopOrderData.findPuid(t.getOrderId()))) %></td>
    <td><%=odata.getQuantity() %></td>
	  <%
		  //if(h.get("puid").equals("gaoke"))
		  {
			  out.print("<td>"+odata.getActivity()+"</td>");
		  }
	  %>
    <td><%=MT.f(t.getCreateDate(),1)%></td>
    <td><%=MT.f(soe.time,1)%></td>
    <td><%=MT.f(t.getReceiptTime(),1)%></td>
    <td>
	    <%
	    	if(t.getStatus()==-1){
	    		out.print("待验收");
	    	}else if(t.getStatus()==-2){
	    		out.print("待入库");
	    	}else if(t.getStatus()==-3){
	    		out.print("验收不通过");
	    	}else if(t.getStatus()==-4){
	    		out.print("入库不通过");
	    	}else if(t.getStatus()==-5){
	    		out.print("待出库");
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

	    int mypuid = ShopOrderData.findPuid(t.getOrderId());
	    /* if(mypuid==Config.getInt("junan")&&t.getAllocate()==1){
	    	out.print("、可调配订单");
	    } */
	    %>
    </td>
    <%-- <td><%=statusContent%></td> --%>
	  <%
		  if(h.get("puid").equals("junan")||(h.get("puid").equals("tongfu")&&h.get("sppuid").equals("junan"))){
			  String sodbsql = " AND ordercode = "+Database.cite(orderId);
			  int sodbcount = ShopOrderDatasBatches.count(sodbsql);
	  %>
	  <td><%

		  if(sodbcount==0){
			  out.print("<font color='red'>未分批</font>");
		  }else{
			  out.print("已分批");
		  }

	  %></td>
	  <td><%
			  if(sodbcount==0){
				  out.print("");
			  }else{
				  ShopOrderDatasBatches sodb = ShopOrderDatasBatches.find(sodbsql,0,1).get(0);
				  out.print(MT.f(sodb.getTime()));
			  }

	  %></td>
	  <td><%
		  if(t.getAllocate()==1){
		  	out.print("调配");
		  }else{
		  	out.print("不调配");
		  }
%>
	  </td>
			  <%
		  }
	  %>
    <td>
    	<%
    	if(isPayment==0){
	    	if(!t.isPayment()&&status!=0)
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('payment','"+orderId+"');\">确认收款</button>");
    	}else{
			//out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('exp','"+orderId+"',"+soe.id+",1);\">"+(soe.time==null?"添加出厂信息":"修改出厂信息")+"</button>");

			if(status==1||(status==0&&Profile.find(t.getMember()).isvip==1)){
	    		if(jflag!=2)
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',2,'发货');\">确认发货</button>");
	    	}
	    	if(status==-1||status==-2){//等待审核
	    		if(jflag!=2)
	    			out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('exp','"+orderId+"',"+soe.id+",1);\">"+(soe.time==null?"添加出厂信息":"修改出厂信息")+"</button>");
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('showchuchang','"+orderId+"',"+soe.id+",1);\">查看出厂信息</button>");
	    	}else if(status==2)
	    	{
	    		if(jflag!=2)
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('exp','"+orderId+"',"+soe.id+",1);\">"+(soe.time==null?"添加出厂信息":"修改出厂信息")+"</button>");
	    		/*if(soe.time!=null)
	    			out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',3,'出库');\">完成出库</button>");*/
	    		/* if(soe.id>0)	
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('expbao','"+orderId+"',"+soe.id+",1);\">上传检验报告</button>"); */
	    	}else if(status==-3||status==-4){//初审不通过和复核不通过
	    		if(jflag!=2)
	    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('exp','"+orderId+"',"+soe.id+",1);\">"+(soe.time==null?"添加出厂信息":"修改出厂信息")+"</button>");
	    		//out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('expbao','"+orderId+"',"+soe.id+",1);\">修改检验报告</button>");
	    	}else if(status==3||status==-1||status==-2||status==-5){

	    		if(Config.getInt("tongfu")!=t.getPuid()&&status!=3){//非同福可修改
		    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('exp','"+orderId+"',"+soe.id+",1);\">"+(soe.time==null?"添加出厂信息":"修改出厂信息")+"</button>");
	    		}
	    		if(Config.getInt("tongfu")!=t.getPuid()&&soe.time!=null&&status==-5){

	    			if(aaa==Config.getInt("junan")){
	    				boolean ischuku = false;
						List<StockOperation> solist1 = StockOperation.find(" AND oid = "+t.getId()+" AND type = 5 AND isRetreat = 0 ",0, Integer.MAX_VALUE);
						int mysum = 0;
						for (int c = 0; c < solist1.size(); c++) {
							StockOperation so1 = solist1.get(c);
							mysum += so1.getAmount();
						}
						if(mysum==odata.getQuantity()){
							ischuku = true;
						}
						if(t.getIsbatche()==1){//取消分批
							out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',3,'出库');\">完成出库</button>");
						}else{
							if(ischuku){
								out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',3,'出库');\">完成出库</button>");
							}else{
								out.println("<button type='button' class='btn btn-link' onclick=\"mt.show('未全部完成分批，请完成分批后进行出库！');\">完成出库</button>");
							}
						}
					}else{
						out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',3,'出库');\">完成出库</button>");
					}


				}

	    		//out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('printOrder','"+orderId+"');\">打印发货单</button>");
				if(soe.time!=null) {
					if (sdf.parse(MT.f(soe.time)).getTime() >= date0.getTime()) {
						out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('printOrder','" + orderId + "');\">打印客户发货单</button>");
						if (Config.getInt("tongfu") == t.getPuid()) {
							out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('printOrder0','" + orderId + "');\">打印同辐出库单</button>");
						}

					} else {
						out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('printOrder_old','" + orderId + "');\">打印发货单</button>");
					}
				}
	    	}
	    	if(soe != null && soe.time != null){//打印分装指令书 Packing instruction
                //out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('printInstruct','"+orderId+"');\">打印分装指令书</button>");
            }
    	}
    	if(mypuid==Config.getInt("junan")){
	    	//out.print("<button type='button' class='btn btn-link' onclick=mt.act('allocate','"+orderId+"')>调配订单</button>");
			if(t.getIsbatche()==0){//未跳过分批
				out.print("<button type='button' class='btn btn-link' onclick=mt.act('Batches','"+orderId+"')>分批</button>");
				out.print("<button type='button' class='btn btn-link' onclick=mt.act('BatchesShow','"+orderId+"')>查看分批</button>");

				out.print("<button type='button' class='btn btn-link' onclick=mt.act('isbatche','"+orderId+"')>跳过分批</button>");
			}

	    }



    	    if(status==4){
    	     if(sdf.parse(MT.f(soe.time)).getTime()>=date0.getTime()){
    	 %>
    	 <button type="button" class="btn btn-link" onclick="mt.act('datachu','<%=orderId%>')">已完成出库单</button>
    	 <%
    	 if(Config.getInt("tongfu")==t.getPuid()){
    		 %>
    		<button type="button" class="btn btn-link" onclick="mt.act('printOrder0','<%=orderId%>')">打印同辐出库单</button>
    		 <%
    	 }
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
    	 <%--<button type="button" class="btn btn-link" onclick="mt.act('del','<%=orderId%>')">删除</button>--%>
    	 <%
    	 }
    	 //只有上海出库管理员这个角色可以看到取消订单和拒绝原因
    	 List<AdminRole> lstrole=AdminRole.find(" and name in("+Database.cite("超级管理员")+","+Database.cite("上海出库管理员")+","+Database.cite("同辐出库管理员")+","+Database.cite("君安出库管理员")+","+Database.cite("高科出库管理员")+");", 0, Integer.MAX_VALUE);
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
    	 if((t.getStatus()==2)&&qorder.getId()==0&&mflag>-1){
    		 if(t.getPuid()==Config.getInt("tongfu")){
    			 %>
    	    	 <button type="button" class="btn btn-link" onclick="mt.act('quxiaoorder','<%=orderId%>')">取消订单</button>
    	    	 <%
    		 }
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
  if(sum>20)out.print("<tr><td colspan='17' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
<%
if(chukuType==1){
%>
	<div class='center mt15'><button class="btn btn-primary" type="button" onclick="dcorder()">导出</button></div>
<%}
    if(h.get("puid").equals("junan")){
        %>
    <div class='center mt15'><button class="btn btn-primary" type="button" onclick="dcorderfp()">分批信息导出</button></div>
    <%
    }
%>
</form>
<form action="/ShopOrders.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="exp_sh" type="hidden" />
	<input name="exflag" value="0" type="hidden"/>
	<input type='hidden' name='category' value="0">
	<input type="hidden" name="status10">
	<input type="hidden" name="puid" value="<%=h.get("puid")%>">
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
  }else if(a=="allocate"){
	  form2.soeid.value=status;
	  form2.type.value=statusContent;
	  form2.action=("/jsp/yl/shop/ShopOrderDatasAllocate.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='printInstruct'){
      form2.action=("/jsp/yl/shop/ShopOrderDatasInstruct.jsp");
      form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='Batches'){
	  form2.action=("/jsp/yl/shop/ShopOrderDatasBatches.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='BatchesShow'){
	  form2.action=("/jsp/yl/shop/ShopOrderDatasBatchesShow.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='isbatche'){
	  form2.status.value=status;
	  mt.show('你确定要跳过分批吗？',2,'form2.submit()');
  }
};

function dcorder(){
    form3.act.value = 'exp_sh';
    form3.status10.value="10";
	form3.submit();
}
function dcorderfp(){
    form3.act.value = 'exp_shfp';
    form3.submit();
}

mt.sethid = function (id, name) {
    $("#hid").val(id);
    $("#hid1").val(name);
};

function selHospital() {
    mt.show("/jsp/yl/shopnew/ShopHospitals.jsp?", 2, "选择", 1000, 600);
    mt.fit();
}

function delHospital() {
    $("#hid").val("");
    $("#hid1").val("");
};
</script>
</body>
</html>
