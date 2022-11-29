<%@page import="util.Config"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%@page import="tea.entity.yl.shop.SetExchangedRecord"%>
<%@page import="tea.entity.admin.AdminUsrRole"%><%@page import="tea.entity.member.SMSMessage"%>
<%@page import="util.CommonUtils"%><%
	Http h=new Http(request,response);
	if(h.member<1)
	{
	  response.sendRedirect("/servlet/StartLogin?community="+h.community);
	  return;
	}
	String act=h.get("act");
	int seid=h.getInt("seid");
	int menuid=h.getInt("id");
	ShopExchanged se=ShopExchanged.find(seid);
	String pname = "";
	ShopProduct sp = ShopProduct.find(se.product_id);
	if(sp.isExist){
		pname=sp.getAnchor(h.language);
	}else{
		ShopPackage spage = ShopPackage.find(se.product_id);
		pname="[套装]"+MT.f(spage.getPackageName());
	}
	
	//根据订单id查询订单信息
	ShopOrder so = ShopOrder.findByOrderId(se.orderId);
	int ordernum=0;
	List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id="+Database.cite(so.getOrderId()), 0, 1);
	if(lstdata.size()>0){
		ShopOrderData data=lstdata.get(0);
		ordernum=data.getQuantity();
	}
	
	String nexturl = h.get("nexturl");
	String nexturl1=MT.dec(h.get("nexturl1"));
	if(nexturl==null&&nexturl1!=null){
		nexturl=nexturl1;
	}
	
	//上海管理员  14122306
	AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);
%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<%
ShopExchanged sec = ShopExchanged.find(seid);
String nexturl0=request.getServletPath()+"?seid="+sec.id+"&nexturl1="+MT.enc(nexturl);

if(request.getMethod().equals("POST")){
	if("addrecord".equals(act)){
		
		
		
		
		int num=h.getInt("num");//修改后的数量
		if(h.get("num")==""){
			out.print("<script>mt.show('请填写修改数量！',1,'"+nexturl0+"');</script>");
			return;
		}
		/* if(num>sec.quantity){
			out.print("<script>mt.show('修改数量不能大于申请退货数量！',1,'"+nexturl0+"');</script>");
			return;
		} */
		/* if(num==sec.quantity){
			out.print("<script>mt.show('同意退货数量请返回上一页点击完成！',1,'"+nexturl0+"');</script>");
			return;
		} */
		
		//给setExchangedrecord增加记录
		SetExchangedRecord record=SetExchangedRecord.find(0);
		record.setExchangeid(sec.id);
		record.setNum(num);
		record.setMember(h.member);
		record.setCreatedate(new Date());
		record.set();
		sec.set("status","2");
		sec.set("exchangednum ",String.valueOf(num));
		//获取短信内容
		CommonUtils utils = new CommonUtils();
		//String content = utils.getSms_content("thwc_f");
		//content = utils.replace(content, "", "", "", sec.exchanged_code);
		
		int mypuid = ShopOrderData.findPuid(so.getOrderId());
		ProcurementUnit pu = ProcurementUnit.find(mypuid);
		String mobstr = MT.f(pu.telephone);
		
		String content="申请退货的订单号为"+sec.orderId+"的订单，退货单"+sec.exchanged_code+"退货数量已由"+sec.quantity+"被修改为"+num+"。请在7天内确认，如超过7天内未确认，系统默认确认。如有疑问请与管理员联系，电话："+mobstr+"。";
		String user = Profile.find(h.member).getMember();
		
		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+mypuid,0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.thwc);
			if(!"".equals(MT.f(mobiles.toString())))
				SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
		}
		//给服务商发信息    up-data:20150623
		Profile pro = Profile.find(so.getMember());
		if(!"".equals(MT.f(pro.mobile,"")))
			SMSMessage.create(h.community, user, pro.mobile, h.language, content);
		
		out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
	}
}
%>
<body>
<h1>修改退货数量</h1>
<form name="form2" action="?" method="post">
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="act" value="addrecord"/>
<input type="hidden" name="seid" value="<%=seid %>"/>

<table id="tablecenter" cellspacing="0" style="margin-top:10px">

<tr style="font-weight:bold;"><td colspan="4" align='left'>退货单信息</td></tr>
<tr>
	<td nowrap align='right'>类型</td><td colspan="3" align='left'><%=se.type==1?"退货":"换货" %></td>
</tr>

<tr>
	<td nowrap align='right'>商品名称</td><td align='left'><%=pname%></td>
	<td nowrap align='right'>退货运单号</td><td align='left'><%=MT.f(se.expressNo) %></td>
</tr>
<tr>
	<td nowrap align='right'>订单原数量</td><td colspan="3" align='left'><%=ordernum %></td>
</tr>
<tr>
	<td nowrap align='right'>退货数量</td><td align='left'><%=se.quantity %></td>
	<td nowrap align='right'>退货描述</td><td align='left'><%=MT.f(se.description) %></td>
</tr>
<tr>
	<td nowrap align='right'>退换货图片</td><td align='left' colspan="3"><%
String pics=se.picture;
if(pics.length()>0){
	for(int i=1;i<pics.split("[|]").length;i++){
		int pic=Integer.parseInt(pics.split("[|]")[i]);
		out.print("<a href='"+Attch.find(pic).path+"' target='_blank'><img width='50px' src='"+Attch.find(pic).path+"'>");
	}
}else{
	out.print("无");
}

%></td>
</tr>
<tr>
	<td>修改数量</td>
	<%
		List<SetExchangedRecord> lstex=SetExchangedRecord.find(" and exchangeid = "+se.id, 0, Integer.MAX_VALUE);
		String exnum="";
		if(lstex.size()>0){
			exnum=String.valueOf(se.exchangednum);
		}
	%>
	<td><input type="text" name="num" value="<%=exnum %>" /></td>
</tr>
</table>
<div class="center mt15"><input class="btn btn-default" type="submit"  value="提交"/></div>
<div class="center mt15"><input class="btn btn-default" type="button" onclick="location.href='<%=nexturl %>'" value="返回"></div>

</form>
</body>
</html>
