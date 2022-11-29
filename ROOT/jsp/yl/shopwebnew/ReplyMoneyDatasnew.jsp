 <%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int replyid = h.getInt("replyid");
RemainReplyMoney rm=RemainReplyMoney.find(replyid);
ReplyMoney rm2=ReplyMoney.find(rm.getReplyid());
String nexturl=h.get("nexturl");
%><!DOCTYPE html><html><head>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>

<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>


</head>
<body>
	<table id="tablecenter" cellspacing="0">
		<tr>
			<td class="tdleft">回款编号</td>
			<td class="tdright">
			<%
				if(rm.getType()==0){
					out.print(rm2.getCode());
				}else if(rm.getType()==1){
					out.print(rm.getCode());
				}
			%>
			</td>
		</tr>
		<tr>
			<td class="tdleft">类型</td>
			<td class="tdright"><%=RemainReplyMoney.typeARR[rm.getType()] %></td>
		</tr>
		<tr>
			<td class="tdleft">回款单位</td>
			<%
				ShopHospital hospital=ShopHospital.find(rm.getHid());
			%>
			<td class="tdright"><%=MT.f(hospital.getName()) %></td>
		</tr>
		<tr>
			<td class="tdleft">回款金额</td>
			<td class="tdright"><%=rm.getAmount() %></td>
		</tr>
		<tr>
			<td class="tdleft">回款时间</td>
			<td class="tdright">
				<%
					if(rm.getType()==0){
						out.print(MT.f(rm2.getReplyTime()));
					}else if(rm.getType()==1){
						out.print(MT.f(rm.getReplyTime()));
					}
				%>
			</td>
		</tr>
		<tr>
			<td class="tdleft">状态</td>
			<td class="tdright"><%=RemainReplyMoney.statusmemberARR[rm.getStatusmember()] %></td>
		</tr>
		
	</table>
	
<br>
<button class="btn btn-default" type="button" onclick="history.go(-1)">返回</button>

<script>

mt.fit();
</script>
</body>
</html>
