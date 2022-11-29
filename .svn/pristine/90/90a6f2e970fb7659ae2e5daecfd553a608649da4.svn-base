<%@page import="tea.entity.Database"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Http"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.member.SMSMessage"%>
<%@page import="tea.entity.yl.shopnew.*"%>
<%@page import="util.CommonUtils"%>
<%@page import="tea.SeqShop"%>
<%@ page import="util.Config" %>
<%@ page import="tea.entity.yl.shop.*" %>
<%@ page import="tea.entity.member.ModifyRecord" %>
<%@ page import="tea.entity.Filex" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
String act=h.get("act","");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int menuid=h.getInt("id");
int seid=h.getInt("seid");
par.append("?id="+menuid);

Integer puid = Config.getInt(h.get("puid"));
//int puid1 = h.getInt("puid1");

if(puid != null&&!h.get("puid").equals("gaoke")) {
	sql.append(" and puid=" + puid);
	par.append("&puid=" + h.get("puid"));
//	puid1=puid;
}

if(h.get("puid").equals("gaoke")){
    sql.append("AND  se.order_id in(select order_id from shopOrderData where product_id in(select product from shopproduct where puid=19041188) )");
}
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
		//sql.append(" AND (select count(1) from shopproduct sp where se.product_id = sp.product  and sp.puid = "+sppuid+" ) > 0");
		par.append("&sppuid="+h.get("sppuid"));
	}


/*
if(puid1 > 0){
	sql.append(" and puid="+puid1);
}
*/

if(request.getMethod().equals("POST")){
	if("finish".equals(act)){
		ShopExchanged sec = ShopExchanged.find(seid);
		sec.set("status","1");

		//ProcurementUnit pu = ProcurementUnit.find(sec.puid);
		//获取短信内容
		CommonUtils utils = new CommonUtils();
		String content = utils.getSms_content("thwc");
		int mypuid = ShopOrderData.findPuid(sec.orderId);
		ProcurementUnit pu = ProcurementUnit.find(mypuid);
		content = utils.replace(content, "", "", "", sec.exchanged_code);
		content = content.replace("telephone", MT.f(pu.getTelephone()));
		String user = Profile.find(h.member).getMember();

		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+mypuid,0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.thwc);
			//if(!"".equals(MT.f(mobiles.toString())))
			if(mobiles.size()>0)
				SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
		}
		//给用户发信息    up-data:20150623
		ShopOrder so = ShopOrder.findByOrderId(sec.orderId);
		Profile pro = Profile.find(so.getMember());
		if(!"".equals(MT.f(pro.mobile,"")))
			SMSMessage.create(h.community, user, pro.mobile, h.language, content);
		
		/*
		Profile profile = Profile.find(h.member);
		if(!"".equals(MT.f(profile.mobile,"")))
			SMSMessage.create(h.community, user, profile.mobile, h.language, content);
		*/
		
		if(sec.type==1){
			//退货减积分
			try{
				ShopOrderData sod = ShopOrderData.find(" AND order_id = "+Database.cite(sec.orderId)+" and product_id = "+sec.product_id, 0, 1).get(0);
				double prices = sod.getUnit() * sec.quantity;
				int status= ShopMyPoints.creatPoint(sec.member,"退货减积分"+(int)prices,(-(int)prices), null);
			}catch(Exception e){
				
			}
			//退货增加负数数量和负数金额的订单，同时记录当前时间
			//增加shoporder表记录
			ShopOrder neworder=ShopOrder.find(0);
			neworder.setOrderId("PO"+SeqShop.get());
			neworder.setMember(sec.member);
			neworder.setCreateDate(new Date());//当前确认退货的时间
			neworder.setStatus(7);
			neworder.setReturntime(new Date());
			neworder.setOldorderid(sec.orderId);
			neworder.setLzCategory(so.isLzCategory());
			neworder.setPuid(so.getPuid());
			neworder.set();
			//增加订单日志
			//退货提交
			ModifyRecord modifyRecord = new ModifyRecord(0);
			modifyRecord.setOrder_id(neworder.getOrderId());
			modifyRecord.setContent("退货申请");
			modifyRecord.setContentDetail("提交退货申请，主单号："+sec.orderId);
			modifyRecord.setMember(neworder.getMember());
			modifyRecord.setModifyTime(sec.time);
			modifyRecord.set();
			//退货审批
			ModifyRecord.creatModifyRecord(neworder.getOrderId(),"退货审批",h.member,"同意退货申请");

			//增加shoporderdata表记录
			List<ShopOrderData> lstolddata=ShopOrderData.find(" and order_id = "+Database.cite(sec.orderId), 0, Integer.MAX_VALUE);
			if(lstolddata.size()>0){
				ShopOrderData olddata=lstolddata.get(0);//每个订单只有一种产品，所以只取一个
				double danjia=so.getAmount()/olddata.getQuantity();
				//neworder.setAmount(-(danjia*sec.quantity));//设置订单的amount
				neworder.set("amount", String.valueOf(-(danjia*sec.quantity)));
				neworder.set("noinvoicenum", String.valueOf(-sec.quantity));//未开票数量也为负数
				ShopOrderData newdata=ShopOrderData.find(0);
				newdata.setOrderId(neworder.getOrderId());
				newdata.setProductId(olddata.getProductId());
				newdata.setUnit(olddata.getUnit());
				newdata.setQuantity(-sec.quantity);//负数的退货数量
				newdata.setAmount(-(olddata.getUnit()*sec.quantity));//负数的退货金额
				newdata.setCalibrationDate(olddata.getCalibrationDate());
				newdata.setActivity(olddata.getActivity());
				newdata.setAgent_price_s(olddata.getAgent_price_s());
				newdata.setAgent_price(olddata.getAgent_price());
				newdata.setAgent_amount(-(olddata.getAgent_price()*sec.quantity));//负数的开票金额
				newdata.set();
			}
			//增加ShopOrderDispatch表记录
			ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(neworder.getOrderId());
			ShopOrderDispatch sodold = ShopOrderDispatch.findByOrderId(sec.orderId);
			//添加收货人地址信息
			sod.setA_consignees(MT.f(sodold.getA_consignees()));
			sod.setA_address(MT.f(sodold.getA_address()));
			sod.setA_mobile(MT.f(sodold.getA_mobile()));
			sod.setA_hospital_id(sodold.getA_hospital_id());
			sod.setA_telphone(MT.f(sodold.getA_telphone()));
			sod.setA_zipcode(MT.f(sodold.getA_zipcode()));
			
			sod.setA_hospital(MT.f(sodold.getA_hospital())); 		//医院
			sod.setA_department(MT.f(sodold.getA_department()));	//科室
			sod.set();
		}
		//退货导致未开票粒子数减少
		ShopOrderDispatch orderdispatch=ShopOrderDispatch.findByOrderId(sec.orderId);
		ChangeLiziData.jiannoinvoice(orderdispatch.getA_hospital_id(), sec.quantity, new Date(), h.member, sec.id);
	}else if("reject".equals(act)){
		ShopExchanged sec = ShopExchanged.find(seid);
		sec.set("status","2");
		//获取短信内容
		CommonUtils utils = new CommonUtils();
		String content = utils.getSms_content("thwc_f");
		content = utils.replace(content, "", "", "", sec.exchanged_code);

		int mypuid = ShopOrderData.findPuid(sec.orderId);
		ProcurementUnit pu = ProcurementUnit.find(mypuid);
		content = content.replace("telephone", MT.f(pu.getTelephone()));

		String user = Profile.find(h.member).getMember();
		
		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+mypuid,0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.thwc);
			if(!"".equals(MT.f(mobiles.toString())))
				SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
		}
		//给用户发信息    up-data:20150623
		ShopOrder so = ShopOrder.findByOrderId(sec.orderId);
		Profile pro = Profile.find(so.getMember());
		if(!"".equals(MT.f(pro.mobile,"")))
			SMSMessage.create(h.community, user, pro.mobile, h.language, content);
		
		/*
		Profile profile = Profile.find(h.member);
		if(!"".equals(MT.f(profile.mobile,"")))
			SMSMessage.create(h.community, user, profile.mobile, h.language, content);
		*/
		
	}else if("jujue".equals(act)){//拒绝
		ShopExchanged sec = ShopExchanged.find(seid);
		sec.set("status","3");
	}
}
int tab=h.getInt("tab");
par.append("&tab="+tab);

sql.append(" AND pro_type=1 ");

//String[] TAB={"全部","内部专家","外部专家"};
//String[] TAB={"全部","等待退换货","已退货","已拒绝","已修改"};
//String[] SQL={""," AND se.status=0"," AND se.status =1"," AND se.status =2 and exchangednum is null"," AND se.status =2 "};
String[] TAB={"全部","等待退换货","已退货","已修改未确认","已拒绝"};
String[] SQL={""," AND se.status=0"," AND (se.status =1 or (se.status=2 and se.exchangedstatus !=0))"," AND se.status =2 and (se.exchangedstatus =0 or se.exchangedstatus is null)"," AND se.status=3 "};

int pos=h.getInt("pos");
par.append("&pos=");
int size=20;


String orderid=h.get("orderid","");
if(orderid.length()>0)
{
  sql.append(" AND se.order_id LIKE "+DbAdapter.cite("%"+orderid+"%"));
  par.append("&orderid="+orderid);
}

String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND member in (select profile from profile where member LIKE "+DbAdapter.cite("%"+member+"%")+") ");
  par.append("&member="+member);
}
//8.18新增医院条件查询
String hospital = h.get("hospital","");
if(!"".equals(hospital)){
	sql.append(" AND sod.a_hospital LIKE "+Database.cite("%"+hospital+"%"));
	par.append("&hospital="+h.enc(hospital));
}


Date beginDate=h.getDate("beginDate");
Date endDate=h.getDate("endDate");
if(beginDate!=null)
{
  sql.append(" AND time>="+DbAdapter.cite(beginDate));
  par.append("&beginDate="+beginDate);
}
if(endDate!=null)
{
  sql.append(" and time<"+DbAdapter.cite(endDate));
  par.append("&endDate="+endDate);
}

	Filex.logs("sql.txt",sql.toString());
int count=ShopExchanged.count(sql.toString());
	Filex.logs("sql.txt","count:"+count);

%>
<!doctype html>
<html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<body>
<h1>订单列表</h1><!--列表-->
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='6' class='bornone'>查询</td></tr>
</thead>
<tr>
  <td nowrap="">订单编号：<input name="orderid" value="<%=MT.f(orderid)%>"/></td>
  <td nowrap="">用户名：<input name="member" value="<%=MT.f(member)%>"/></td>
  <td nowrap="">医院：<input name="hospital" value="<%=MT.f(hospital)%>"/></td>
	<%--<%
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
	%>--%>
  <td nowrap="">退货单下单时间：<input name="beginDate" value="<%=MT.f(beginDate)%>"  readonly onClick="mt.date(this)" class="date" />至<input name="endDate" value="<%=MT.f(endDate) %>"  readonly onClick="mt.date(this)" class="date" /></td>
  <td width="" class='bornone'><button class="btn btn-primary" type="submit">查询</button></td>
</tr>
</table>
</div>
</form>


<script>
//sup.hquery();
</script>

<%-- <h2>列表&nbsp;（<%=count%>） </h2> --%>
<form name="form2" action="?" method="post">
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="seid"/>
<input type="hidden" name="id" value="<%=menuid %>"/>
<%
out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+ShopExchanged.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<div class='radiusBox'>
<table id="" cellspacing="0" class='newTable'>
<tr>
  <th align="center">序号</th>
  <th align="center">订单编号</th>
  <th align="center">运单号</th>
  <th align="center">用户</th>
  <th align="center">医院</th>
	<th align="center">开票单位</th>
	<th align="center">商品厂商</th>
  <th align="center">退单类型</th>
  <th align="center">原数量</th>
  <th align="center">退单商品数量</th>
  <th align="center">修改后数量</th>
  <th align="center">提交时间</th>
  <th align="center" style="display:<%=tab==2?"none":""%>">操作</th>
</tr>
<%
sql.append(SQL[tab]);
int sum=ShopExchanged.count(sql.toString());

if(sum<1)
{
  out.print("<tr><td colspan='20' class='noCont'>暂无记录!</td></tr>");
}else
{
	//sql.append(" order by se.status asc,time desc");
    ArrayList list = ShopExchanged.find(sql.toString()+" order by time desc ",pos,size);
    for (int i = 0;i<list.size(); i++) {
		ShopExchanged se = (ShopExchanged) list.get(i);
		
		String querySql = " AND order_id="+DbAdapter.cite(se.orderId);
	  	List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
	  	ShopOrderData odata = ShopOrderData.find(0);
	  	if(sodList.size()>0)
	  	  	odata = sodList.get(0);

		ShopProduct sp=ShopProduct.find(se.product_id);
		ShopPackage spage = new ShopPackage(0);
		//医院
		String orderId=se.orderId;
		ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderId);
	    List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
		String pname = "";
		if(sp.isExist){
			pname=sp.getAnchor(h.language);
		}else{
			spage = ShopPackage.find(se.product_id);
			pname="[套装]"+MT.f(spage.getPackageName());
			spagePList.add(0,ShopProduct.find(spage.getProduct_id()));
			String [] sarr = spage.getProduct_link_id().split("\\|");
			for(int m=1;m<sarr.length;m++){
			    spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
			}
		}
		
		String uname = MT.f(Profile.find(se.member).member);
		String exnum="";
		if(se.exchangednum>=0){
			List<SetExchangedRecord> lstex=SetExchangedRecord.find(" and exchangeid = "+se.id, 0, Integer.MAX_VALUE);
			
			if(lstex.size()>0){
				exnum=String.valueOf(se.exchangednum);
			}
		}
		if(puid==19041185){
		    if(ShopOrderData.findPuid(odata.getOrderId())==19041188){
		        continue;
			}
		}
  %>
  <tr>
    
    <td align="center"><%=i+pos+1 %></td>
    <td align="center"><%=se.orderId %></td>
		<td align="center"><%=MT.f(se.expressNo) %></td>
		<td align="center"><%=uname %></td>
		<td align="center"><%=MT.f(sod.getA_hospital()) %></td>
	  <td align="center"><%=MT.f(ProcurementUnit.findName(puid))%></td>
	  <td><%= MT.f(ProcurementUnit.findName(ShopOrderData.findPuid(odata.getOrderId()))) %></td>
		<td align="center"><%=se.type==1?"退货":"换货" %></td>
		<td align="center"><%=odata.getQuantity() %></td>
		<td align="center"><%=se.quantity %></td>
		<td align="center"><%=exnum %></td>
		<td align="center"><%=MT.f(se.time,1) %></td>
		<td align="center" style="display:<%=tab==2?"none":""%>">
		<%
		out.print("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('detail','"+se.id+"')\">详细</button>");
		if(se.status==0)out.print("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('finish','"+se.id+"')\">完成</button>");
		 if(se.status==0)out.print("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('jujue','"+se.id+"')\">拒绝</button>");
		if(se.status==0||se.status==2){
			if(se.exchangedstatus!=1&&se.exchangedstatus!=2){
				out.print("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('reject','"+se.id+"')\">修改</button>"); 
			}
		}
		%>
		<%-- <%
		if(o.getStatus()==1){out.print("<a href='#' onclick=mt.act('fill','"+o.getId()+"')>填运费</a>");}
		else if(o.getStatus()==3){out.print("<a href='#' onclick=mt.act('fillin','"+o.getId()+"')>确认汇款</a>");}
		else if(o.getStatus()==4){out.print("<a href='#' onclick=mt.act('fillin','"+o.getId()+"')>发货</a>");}
		else if(o.getStatus()==6){out.print("<a href='#' onclick=mt.act('confirm','"+o.getId()+"')>完成</a>");}
		if(o.getStatus()!=8){out.print("<a href='#' onclick=mt.act('cancel','"+o.getId()+"')>取消订单</a>");}
		%> --%>

		</td>
  </tr>
  
  
  
  <%
  }
  if(sum>20){
	out.print("<td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size));
  }
}%>
</table>
</div>
</form>
<form name="form3" target="_ajax" action="/expOrders.do" >
<input type="hidden" name="act" value="shthdexp"/>
<input type="hidden" name="orderid" value="<%=MT.f(orderid)%>"/>
<input type="hidden" name="member" value="<%=MT.f(member)%>"/>
<input type="hidden" name="hospital" value="<%=MT.f(hospital)%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="beginDate" value="<%=MT.f(beginDate)%>" />
<input type="hidden" name="endDate" value="<%=MT.f(endDate) %>"  />
</form>

<div class='center mt15'><button class="btn btn-primary" type="button" onclick="form3.submit();">导出</button></div>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id){
	form2.act.value=a;
	form2.seid.value=id;
	if(a=='view'){
		//mt.show("/jsp/yl/shop/ShopExchangedDetail.jsp?seid="+id,1,"退换单明细",410,300);
		//return;
	}else if(a=="finish"){
		mt.show("确认完成吗？",2,"form2.submit()");
	}else if(a=="reject"){
		//mt.show("确定要拒绝退货吗？",2,"form2.submit()");
		//改为修改
		form2.action=("/jsp/yl/shop/SetExchangedrecord.jsp");
		form2.target='_self';
		form2.method='get';
		form2.submit();
	}else if(a=="detail"){
		form2.action=("/jsp/yl/shop/ShopExchangeDetail2.jsp");
		form2.target='_self';
		form2.method='get';
		form2.submit();
	}else if(a=="jujue"){
        mt.show("确定要拒绝退货吗？",2,"form2.submit()");
	}
	
}
function dcorder(){
	
}

setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
