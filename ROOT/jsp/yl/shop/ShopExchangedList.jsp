<%@page import="tea.entity.yl.shop.ProcurementUnit"%>
<%@page import="tea.entity.yl.shop.ShopOrderExpress"%>
<%@page import="tea.entity.Database"%>
<%@page import="tea.entity.yl.shop.ShopOrderData"%>
<%@page import="tea.entity.yl.shop.ShopOrder"%>
<%@page import="tea.entity.yl.shop.ShopMyPoints"%>
<%@page import="tea.entity.yl.shop.ShopPackage"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.yl.shop.ShopOrderDispatch" %>
<%@page import="tea.entity.MT"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.yl.shop.ShopProduct"%>
<%@page import="tea.entity.yl.shop.ShopExchanged"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.yl.shop.ShopCategory"%>
<%@page import="tea.entity.yl.shop.ShopSMSSetting"%>
<%@page import="tea.entity.member.SMSMessage"%>
<%@page import="util.CommonUtils"%>
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
if(request.getMethod().equals("POST")){
	if("finish".equals(act)){
		ShopExchanged sec = ShopExchanged.find(seid);
		sec.set("status","1");
		
		//获取短信内容
		CommonUtils utils = new CommonUtils();
		String content = utils.getSms_content("thwc");
		content = utils.replace(content, "", "", "", sec.exchanged_code);

		int mypuid = ShopOrderData.findPuid(sec.orderId);
		ProcurementUnit pu = ProcurementUnit.find(mypuid);


		content = content.replace("telephone", MT.f(pu.getTelephone()));
		//ProcurementUnit pu = ProcurementUnit.find(sec.puid);
		//String mobstr = MT.f(pu.mobile);
		//content = content.replace("mob", mobstr);
		
		
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
		
		if(sec.type==1){
			try{
				ShopOrderData sod = ShopOrderData.find(" AND order_id = "+Database.cite(sec.orderId)+" and product_id = "+sec.product_id, 0, 1).get(0);
				double prices = sod.getUnit() * sec.quantity;
				int status= ShopMyPoints.creatPoint(sec.member,"退货减积分"+(int)prices,(-(int)prices), null);
			}catch(Exception e){
				
			}
		}
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
		
		//给用户发信息   up-data:20150623
		ShopOrder so = ShopOrder.findByOrderId(sec.orderId);
		Profile pro = Profile.find(so.getMember());
		if(!"".equals(MT.f(pro.mobile,"")))
			SMSMessage.create(h.community, user, pro.mobile, h.language, content);
		
		/*
		Profile profile = Profile.find(h.member);
		if(!"".equals(MT.f(profile.mobile,"")))
			SMSMessage.create(h.community, user, profile.mobile, h.language, content);
		*/
	}
}
int tab=h.getInt("tab");
par.append("&tab="+tab);

sql.append(" AND pro_type=0 ");

//String[] TAB={"全部","内部专家","外部专家"};
String[] TAB={"全部","等待退货","已完成"};
String[] SQL={""," AND se.status=0"," AND se.status in(1,2)"};
int pos=h.getInt("pos");
par.append("&pos=");
int size=20;
String exchanged_code=h.get("exchanged_code","");
if(exchanged_code.length()>0)
{
  sql.append(" AND exchanged_code LIKE "+DbAdapter.cite("%"+exchanged_code+"%"));
  par.append("&exchanged_code="+exchanged_code);
}
//8.18新增医院条件查询
String hospital = h.get("hospital","");
if(!"".equals(hospital)){
	sql.append(" AND sod.a_hospital LIKE "+Database.cite("%"+hospital+"%"));
	par.append("&hospital="+h.enc(hospital));
}
String orderid=h.get("orderid","");
if(orderid.length()>0)
{
  sql.append(" AND se.order_id LIKE "+DbAdapter.cite("%"+orderid+"%"));
  par.append("&orderid="+orderid);
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

//int count=ShopExchanged.count(sql.toString());

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

<!-- <h2>查询</h2> -->
<form name="form1" action="?"  method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="td">订单编号：</td><td><input name="orderid" value="<%=orderid%>"/></td>
  <td class="td">退货编号：</td><td><input name="exchanged_code" value="<%=exchanged_code%>"/></td>
  <td class="td">医院:</td><td><input name="hospital" value="<%=MT.f(hospital)%>"/></td>
  <td class="td" >退货下单时间：</td>
  <td><input name="beginDate" value="<%=MT.f(beginDate)%>"  readonly onClick="mt.date(this)" class="date" />至<input name="endDate" value="<%=MT.f(endDate) %>"  readonly onClick="mt.date(this)" class="date" /></td>
  
</tr>
<tr>
  <td colspan="10" align="center"><button class="btn btn-primary" type="submit">查询</button></td>
</tr>
</table>
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
  <th align="center">退货单编号</th>
  <th align="center">快递单号</th>
  <th align="center">用户</th>
  <th align="center">医院</th>
  <th align="center">商品名称</th>
  <th align="center">退单类型</th>
  <th align="center">退单商品数量</th>
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
	sql.append(" order by se.status asc,time desc");
    ArrayList list = ShopExchanged.find(sql.toString(),pos,size);
	for (int i = 0;i<list.size(); i++) {
		ShopExchanged se = (ShopExchanged) list.get(i);
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
  %>
  <tr>
    
    <td align="center"><%=i+pos+1 %></td>
    <td align="center"><%=se.orderId %></td>
		<td align="center" ><a href="###" onclick=mt.act('view',"<%=se.id %>")><%=se.exchanged_code %></a></td>
		<td align="center"><%=MT.f(se.expressNo) %></td>
		<td align="center"><%=uname %></td>
		<td align="center"><%=MT.f(sod.getA_hospital()) %></td>
		<td align="center">
			<%
			if(sp.isExist){
				out.print(pname);
			}else{
				out.println("<table width='100%'>");
				out.println("<tr><td>"+pname+"</td></tr>");
				for(int n=0;n<spagePList.size();n++){
					ShopProduct s1 = spagePList.get(n);
					out.println("<tr><td style='text-align:left;'>"+s1.getAnchor(h.language)+"</td></tr>");
				}
				out.println("</table>");
			}
			%>
		</td>
		<td align="center"><%=se.type==1?"退货":"换货" %></td>
		<td align="center"><%=se.quantity %></td>
		<td align="center"><%=MT.f(se.time,1) %></td>
		<td align="center" style="display:<%=tab==2?"none":""%>">
		<%
		if(se.status==0)out.print("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('finish','"+se.id+"')\">完成</button>");
		if(se.status==0)out.print("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('reject','"+se.id+"')\">拒绝</button>");
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
<input type="hidden" name="act" value="thdexp"/>
<input type="hidden" name="orderid" value="<%=MT.f(orderid)%>"/>
<input type="hidden" name="exchanged_code" value="<%=exchanged_code %>"/>
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
		mt.show("/jsp/yl/shop/ShopExchangedDetail.jsp?seid="+id,1,"退货单明细",410,300);
		return;
	}else if(a=="finish"){
		mt.show("确认完成吗？",2,"form2.submit()");
	}else if(a=="reject"){
		mt.show("确定要拒绝退货吗？",2,"form2.submit()");
	}
	
}

setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
