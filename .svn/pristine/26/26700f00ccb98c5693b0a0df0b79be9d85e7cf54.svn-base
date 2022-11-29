<%@page import="tea.entity.yl.shopnew.ReplyMoney"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.yl.shopnew.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


int rid = h.getInt("rid");

ReplyMoney r = ReplyMoney.find(rid);
String chargecode="";//服务费编号
List<BackInvoice> lstback=BackInvoice.find(" and replyid like "+DbAdapter.cite("%"+rid+"%"), 0, Integer.MAX_VALUE);
if(lstback.size()>0){
	for(int i=0;i<lstback.size();i++){
		BackInvoice back=lstback.get(i);
		int backid=back.getId();
		List<Charge> lstcharge=Charge.find(" and backid = "+backid, 0, Integer.MAX_VALUE);
		if(lstcharge.size()>0){
			chargecode=lstcharge.get(0).getChargecode();
		}
	}
}
%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1>查看回款</h1>

<form name="form1" action="/ShopOrderDispatchs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="act" value="invoice"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
 <tr>
		<td>回款编号：</td>
		<td><%= r.getCode() %></td>
	</tr>
 <tr>
		<td>回款时间：</td>
		<td><%= MT.f(r.getReplyTime()) %></td>
	</tr>
	<tr>
		<td>回款单位：</td>
		<%
			ShopHospital sh1 = ShopHospital.find(r.getHid());
		%>
		<td><%= MT.f(sh1.getName()) %></td>
	</tr>
	<tr>
		<td>回款金额：</td>
		<td><%= r.getReplyPrice() %></td>
	</tr>
	<%
	int bid = HangWith.findbid(rid);
	float deductprice = HangWith.findDeductPriceBid(bid);
	if(Config.getInt("gaoke")==r.getPuid()&&r.getType()==1){//高科 挂款 
		if(r.getStatusmember()==0){//未通知可改
			%>
			<tr>
				<td>调整后挂款金额：</td>
				<td><input type="hidden" name='backid' value="<%= bid %>" /><input mask='float' name='deductprice' value="<%= deductprice %>" /></td>
			</tr>
			<tr>
				<td colspan="2"><input onclick="savedeductprice()" type="button" value="保存" /></td>
			</tr>	
			<%
		}else{
			if(deductprice>0){
				%>
				<tr>
						<td>调整挂款金额：</td>
						<td><%= deductprice %></td>
					</tr>	
					<%
			}
		}
	}
	%>
	<tr>
		<td>备注：</td>
		<td><%= MT.f(r.getContext()) %></td>
	</tr>
	<tr>
		<td>类型：</td>
		<td><%= ReplyMoney.typeARR[r.getType()] %></td>
	</tr>
	<tr>
		<td>回款状态：</td>
		<td><%= ReplyMoney.statusARR[r.getStatus()] %></td>
	</tr>
	<tr>
		<td>匹配状态：</td>
		<td><%= ReplyMoney.statusmemberARR[r.getStatusmember()] %></td>
	</tr>
	<%
		if(r.getStatus()==2){
			%>
			<tr>
		<td>退回原因：</td>
		<td><%= MT.f(r.getReturnStr()) %></td>
	</tr>
	<%
			if(r.getThmember()>0){
				Profile p=Profile.find(r.getThmember());
				
		%>
	<tr>
		<td>退回人：</td>
		
		<td><%=p.getName(h.language) %></td>
	</tr>
			<%
		}
		}
	%>
	<%
		if(r.getType()==1){
			List<BackInvoice> lstback2=BackInvoice.find(" and hangid = "+r.getId() , 0, Integer.MAX_VALUE);
			if(lstback2.size()>0){
				for(int i=0;i<lstback2.size();i++){
					BackInvoice back=lstback2.get(i);
					String rids=back.getReplyid();
					String[] ridarr=rids.split(",");
					//获取回款金额和回款编号
					for(int j=0;j<ridarr.length;j++){
						String rid1=ridarr[j];
						if(rid1.length()>0){
							int rid2=Integer.parseInt(rid1);
							ReplyMoney rm=ReplyMoney.find(rid2);
							out.print("<tr><td>回款编号：</td><td>"+rm.getCode()+"</td></tr>");
							out.print("<tr><td>回款金额：</td><td>"+rm.getReplyPrice()+"</td></tr>");
						}
					}
					//服务商匹配金额
					out.print("<tr><td>服务行匹配金额：</td><td>"+ShopHospital.getDecimal((double)back.getMatchamount())+"</td></tr>");
					//应收账款
					out.print("<tr><td>应收账款：</td><td>"+ShopHospital.getDecimal((double)back.getOldnoreply())+"</td></tr>");
					//剩余应收账款
					out.print("<tr><td>剩余应收账款：</td><td>"+ShopHospital.getDecimal((double)back.getSoldnoreply())+"</td></tr>");
					
				}
			}
	
		}
	%>
	<tr>
		<td>服务费编号：</td>
		<td><%=chargecode %></td>
	</tr>
</table>
<div class="center mt15">
<button class="btn btn-default" type="button" onclick="history.back();">返回</button></div>
</form>
<script type="text/javascript">
function savedeductprice(){
	mt.send("/mobjsp/yl/shop/ajax.jsp?act=savedeductprice&backid="+form1.backid.value+"&deductprice="+form1.deductprice.value,function(data){
		data = eval('(' + data + ')');
	if(data.type>0){
		/* if(data.type==1){
			//location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
			return;
		} */
		/* mtDiag.close();
		mtDiag.show(data.mes); */
		mt.show(data.mes);
		return;
	}else{
		mt.show("操作成功！");
		mt.ok = function(){
			location = form1.nexturl.value;
		}
	}
	});
}
</script>
</body>
</html>
