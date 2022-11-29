<%@page import="tea.entity.util.Card"%>
<%@page import="tea.entity.SeqTable"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import ="tea.entity.member.*" %>
<%@ page import="tea.entity.integral.*"%>
<jsp:directive.page import="java.math.BigDecimal"/>
<jsp:directive.page import="java.net.URLEncoder"/>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  out.println("您还没有登录，系统不能处理您的信息.<a href=\"###\" onclick=\"parent.ymPrompt.close();\" >关闭</a> ");
  return;
}

int icid=0;

if(teasession.getParameter("icid")!=null && teasession.getParameter("icid").length()>0)
{
	icid = Integer.parseInt(teasession.getParameter("icid"));  
}
IntegralChange icobj = IntegralChange.find(icid);

String nexturl = teasession.getParameter("nexturl");
String goodsname = "";
float shop_integral=0;

for(int i=1;i<icobj.getPresent().split("/").length;i++)
{
	int igid = Integer.parseInt(icobj.getPresent().split("/")[i]);
	IntegralPrize obj = IntegralPrize.find(igid);
	goodsname =goodsname+obj.getShopping();
	shop_integral =shop_integral+obj.getShop_integral();
}

String member = teasession.getParameter("member");


Profile pobj = Profile.find(member);

String  q = teasession.getParameter("q");



%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js"></script>
<script src="/tea/mt.js"></script>
<script src="/tea/city.js"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head> 
<script>

function f_sub(igd)
{
	  
	  sendx("/jsp/admin/edn_ajax.jsp?act=integralmymember&icid="+igd,
				 function(data)
				 {

				  //alert("4444->>>>."+data.length);
				   if(data!=''&&data.length>1 && data.trim()=='true')//如果有这个用户  则写入Cookie .trim()
				   { 
						alert("确认收货成功");
						parent.ymPrompt.close();
						parent.window.location.reload();
				   }
				 }
				 );
}
</script>

<body bgcolor="#ffffff">
<h1>商品积分兑换</h1>
<form action="/servlet/EditIntegralManage" method="POST"  name="form1" onsubmit="return f_sub();">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="integralchangeadd">
<input type="hidden" name="icid" value="<%=icid %>">
<input type="hidden" name="member" value="<%=member %>">
<input type="hidden" name="nexturl" value="<%=nexturl %>">
<input type="hidden" name="present" value="<%=icobj.getPresent() %>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"> 

<tr>
	<td align="right">用户兑换订单号：</td>
	<td><%=icobj.getOrderid() %></td>
</tr>

<tr>
	<td align="right">用户兑换的商品：</td>
	<td><%=goodsname %></td>
</tr>

<tr>
	<td align="right">兑换需要积分：</td>
	<td><%=shop_integral %></td>
</tr>

<tr>
	<td align="right"><font color=red>*</font>联系人：</td>
	<td><%=icobj.getConsignee() %></td>
</tr>
<tr>
	<td align="right">
	<font color=red>*</font>联系电话：</td>
		<td>
			<%=icobj.getPhone()%>
		</td>
</tr>

<tr>
	<td align="right">
	<font color=red>*</font>邮编：</td>
		<td>
			<%=icobj.getZip()%>
		</td>
</tr>


 
 <tr>
	<td align="right">
	<font color=red>*</font>现通讯地址：</td>
	<td>
	<%
		Card cobj = Card.find(Integer.parseInt(icobj.getProvince()));
		out.print(cobj.toStringCity1());
		out.print(cobj.toStringCity2());
		out.print(icobj.getAddress());
		
	%>
		
	</td>
</tr>

<tr>

<td colspan="2" align="center">
<%if("1".equals(q)){//确认 %>
<input type="button" value="确认收货" onclick="f_sub('<%=icid%>');" />
<%} %>
<input type="button" value="返回" onclick="parent.ymPrompt.close();" />
 
 </td></tr>

</table>
</form>
</body>
</html>

