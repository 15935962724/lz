<%@page import="tea.entity.yl.shopnew.ReplyMoney"%>
<%@page import="tea.entity.yl.shopnew.RemainReplyMoney"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int rid = h.getInt("rid");

RemainReplyMoney r = RemainReplyMoney.find(rid);
ReplyMoney rm=ReplyMoney.find(r.getReplyid());

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看回款</h1>

<form name="form1" action="/ShopOrderDispatchs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="act" value="invoice"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
 <tr>
		<td>回款编号：</td>
		<td>
			<%
				/* if(r.getType()==0){
					out.print(rm.getCode());
				}else if(r.getType()==1){
					out.print(r.getType());
				} */
				if(r.getType()==0){
	    			if(rm.getCode()!=null){
	    				out.print(rm.getCode());
	    			}else{
	    				out.print(r.getCode());
	    			}
	    			
	    		}else if(r.getType()==1){
	    			out.print(r.getCode());
	    		}
			%>
		</td>
	</tr>
 <tr>
		<td>汇款时间：</td>
		<td>
			<%
				if(r.getType()==0){
					out.print(MT.f(rm.getReplyTime()));
				}else if(r.getType()==1){
					out.print(MT.f(r.getReplyTime()));
				}
			%>
		</td>
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
		<td><%= MT.f(r.getAmount()) %></td>
	</tr>
	<tr>
		<td>备注：</td>
		<td><%= MT.f(rm.getContext()) %></td>
	</tr>
	<tr>
		<td>类型：</td>
		<td><%= RemainReplyMoney.typeARR[r.getType()] %></td>
	</tr>
	<tr>
		<td>回款状态：</td>
		<td>已通过</td>
	</tr>
	<tr>
		<td>匹配状态：</td>
		<td><%= RemainReplyMoney.statusmemberARR[r.getStatusmember()] %></td>
	</tr>
	
</table>
<div class="center mt15">
<button class="btn btn-default" type="button" onclick="history.back();">返回</button></div>
</form>
<script type="text/javascript">

</script>
</body>
</html>
