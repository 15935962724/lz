<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.math.BigDecimal"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
//if (teasession._rv == null) {
 // response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
 // return;
//}


//String arrodid[] = teasession.getParameterValues("odid");//选择的座位编号
String ordersid = teasession.getParameter("ordersid");//订单号


//购票数量
int odcount = OrderDetails.count(teasession._strCommunity," AND orderid ="+DbAdapter.cite(ordersid));
PerformOrders pfoobj = PerformOrders.find(ordersid);
int psid = pfoobj.getPsid();
PerformStreak psobj = PerformStreak.find(psid);


//演出名称
Node nobj1= Node.find(psobj.getNode());
//演出场馆
Node nobj2 = Node.find(psobj.getVenues());
Seat sobj = Seat.find(psobj.getVenues());

String member = teasession.getParameter("member");

/*
boolean f = false;
if(member!=null && member.length()>0)
{
	if(Profile.isExisted(member))
	{
		//如果有这个用户 则打折处理
		price2 =

	}
}
*/

String names = teasession.getParameter("names");
int zjlx = Integer.parseInt(teasession.getParameter("zjlx"));

String zjhm = teasession.getParameter("zjhm");
String yddh = teasession.getParameter("yddh");
String gddh = teasession.getParameter("gddh");
String dzyx = teasession.getParameter("dzyx");
int sfsp = Integer.parseInt(teasession.getParameter("sfsp"));
int sffp = Integer.parseInt(teasession.getParameter("sffp"));
int spdz1 =Integer.parseInt(teasession.getParameter("spdz1"));

String spdz2 = teasession.getParameter("spdz2");
String qtsm = teasession.getParameter("qtsm");
String nexturl = teasession.getParameter("nexturl");

//运费
int fare =0;
if(sfsp==1)//有送票记录
{
	if(spdz1<9)//城八区的 15元
	{
		fare = 15;
	}else
	{
		fare = 20;//
	}
}

//购票总金额

BigDecimal price = OrderDetails.getTotalprice(ordersid,member);
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>确认订单</title>
</head>

<body id="bodynone2"  >
<script type="text/javascript">
window.history.forward(1);
	function f_cx()
	{
		form1.action ="/jsp/type/perform/PerformOrders1.jsp";
		form1.submit();
	}
	function f_subimt()
	{
		//判断时间超时问题 清楚选定的座位
		 sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=performorders1_session&ordersid="+form1.ordersid.value,
		  function(data)
		  {
		    if(data.trim()!=null && data.trim().length>0 )
		    {
		    	alert(data.trim());
		    	window.open('/jsp/type/perform/OnlineReservations.jsp?psid='+form1.psid.value+'&community='+form1.community.value,'_self');
		    }
		  }
		  );
	}
</script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

<DIV class="bodyFramework">
   <form action="/servlet/EditPerformOrders" method="POST" name="form1" onSubmit="return f_subimt();">
<input type="hidden" name="act" value="PerformOrders2">
<input type="hidden" name="psid" value="<%=psid %>">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
<input type="hidden" name="ordersid" value="<%=ordersid %>">

<input type="hidden" name="totalprice" value="<%=price.setScale(0,BigDecimal.ROUND_HALF_UP) %>">
<input type="hidden" name="odcount" value="<%=odcount %>">
<input type="hidden" name="fare" value="<%=fare %>">
<input type="hidden" name="member" value="<%=member %>">
<div class="header">
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099950.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
  </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" class="title">
  <tr>
    <td><img src="/res/REDCOME/0909/09099972.gif"></td>
    <td><img src="/res/REDCOME/0909/09099952.gif"></td>
    <td><img src="/res/REDCOME/0909/09099974.gif"></td>
    <td><img src="/res/REDCOME/0909/09099954.gif"></td>
    <td><img src="/res/REDCOME/0909/09099955.gif"></td>
  </tr>
</table>
</div>
<div class="content">
<!--登记信息-->
<div class="MyBooking">
    	<div class="left">订单信息</div>
        <div class="right">您现在共预定了&nbsp;<font color=red><%=odcount%></font>&nbsp;张票
        <%
        if(fare>0)
        {
          out.print("&nbsp;您的运费是：&nbsp;<font color=red>"+fare+"</font>&nbsp;元");
        }
        %>
        总价金额:&nbsp;<font color=red><span id="price"><%=price.setScale(0,BigDecimal.ROUND_HALF_UP) %></span></font>&nbsp;元</div>
    </div>
<div class="SeatingTable2">
    <table border="0" cellspacing="0" cellpadding="0" class="table01">
    <tr class="title">
    	<td>演出名称</td>
        <td>场馆名称</td>
        <td>演出时间</td>
        <td>座位</td>
        <td>价格</td>
   		<%
		boolean f = false;
			if(Profile.isExisted(member))
			{
				out.print("<td>折扣价格</td>");
				f=true;

			}
		 %>



	</tr>

	<%
		Enumeration e = OrderDetails.find(teasession._strCommunity," AND orderid ="+DbAdapter.cite(ordersid),0,200);
		for(int i = 1;e.hasMoreElements();i++)
		{
		//座位
		int odid = ((Integer)e.nextElement()).intValue();
		OrderDetails odobj = OrderDetails.find(odid);

		 SeatEditor seobj = SeatEditor.find(odobj.getNumbers(),psobj.getVenues());//显示场馆设置好的分布图
		 PriceDistrict pdobj = PriceDistrict.find(odobj.getNumbers(),psid);//分区价格显示图
		 PriceSubarea psobj2 = PriceSubarea.find(pdobj.getPricesubareaid());

		   //判断member是否有折扣
		   BigDecimal price2 = new BigDecimal("0");

		   if(Profile.isExisted(member))//有折扣
		   {
		   		price2 = psobj2.getPrice().multiply(new BigDecimal("0.9"));
		   }else
		   {
		   	   price2 = psobj2.getPrice();
		   }

	%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">

		<td><%=nobj1.getSubject(teasession._nLanguage) %></td>
		<td><%=nobj2.getSubject(teasession._nLanguage) %></td>
		<td><%=psobj.getPftimeToString() %></td>
		<td><%out.print(seobj.getRegion()+seobj.getLinagenumber()+"排"+seobj.getSeatnumber()+"号"); %></td>
		<td><%=psobj2.getPrice() %>&nbsp;元</td>
		<%if(f){out.print("<td>"+price2.setScale(0,BigDecimal.ROUND_HALF_UP)+"&nbsp;元</td>");} %>


  </tr>
	<%
		}
	 %>

</table>
 <table border="0" cellspacing="0" cellpadding="0" class="table02">
    <tr>
    	<td width="77" align="right">&nbsp;会员卡号:</td>
        <td><input type="text" name="member" value="<%if(member!=null && member.length()>0)out.print(member); %>" size="40" readonly style="background:#cccccc"> </td>
	</tr>
	<tr>
		<td align="right">&nbsp;您的姓名:</td>
        <td><input type="text" name="names" value="<%=names%>" size="40" readonly style="background:#cccccc"> </td>

	</tr>
	<tr>
		<td align="right">&nbsp;证件类型:</td>
		<td>
			<select name="zjlx" onFocus="this.defOpt=this.selectedIndex" onChange="this.selectedIndex=this.defOpt;"  style="background:#cccccc">
				<option value="0">--证件类型--</option>
				<%
					for(int zj=1;zj<PerformOrders.ZJLX_TYPE.length;zj++)
					{
						out.print("<option value="+zj);
						if(zjlx==zj)
						{
							out.print(" selected ");
						}
						out.print(">"+PerformOrders.ZJLX_TYPE[zj]);
						out.print("</option>");
					}
				 %>

			</select>
		</td>
</tr>
<tr>
		<td align="right">&nbsp;证件号码:</td>
        <td><input type="text" name="zjhm" value="<%=zjhm %>" size="40" readonly="readonly" style="background:#cccccc"></td>

	</tr>
	<tr>
		<td align="right">&nbsp;移动电话:</td>
        <td><input type="text" name="yddh" value="<%=yddh %>" size="40" readonly="readonly" style="background:#cccccc"></td>

	</tr>
<tr>
		<td align="right">&nbsp;固定电话:</td>
        <td><input type="text" name="gddh" value="<%=gddh %>" size="40" readonly="readonly" style="background:#cccccc"></td>

	</tr>
<tr>
		<td align="right">&nbsp;电子邮箱:</td>
        <td><input type="text" name="dzyx" value="<%=dzyx %>" size="40" readonly="readonly" style="background:#cccccc"></td>

	</tr>
<tr>
		<td align="right">&nbsp;是否送票:</td>
        <td>
			<select name="sfsp"  style="background:#cccccc"  onfocus="this.defOpt=this.selectedIndex" onChange="this.selectedIndex=this.defOpt;"  ><option value="0" <%if(sfsp==0)out.print(" selected "); %>>-否-</option><option value="1" <%if(sfsp==1)out.print(" selected "); %>>-是-</option></select>&nbsp;&nbsp;
			是否要发票:&nbsp;
			<select name="sffp" style="background:#cccccc"  onfocus="this.defOpt=this.selectedIndex" onChange="this.selectedIndex=this.defOpt;"  ><option value="0" <%if(sffp==0)out.print(" selected "); %>>-否-</option><option value="1"  <%if(sffp==1)out.print(" selected "); %>>-是-</option></select>
		</td>

	</tr>
<%
	if(sfsp==1){
 %>
<tr>
		<td align="right">&nbsp;送票地址:</td>
        <td>
			<select style="background:#cccccc" name="spdz1"  onfocus="this.defOpt=this.selectedIndex" onChange="this.selectedIndex=this.defOpt;"  ><option value="0">--选择区域--</option>
<%
	for(int sp1=1;sp1<PerformOrders.SPDZ1_TYPE.length;sp1++)
	{
		out.print("<option value="+sp1);
		if(spdz1 == sp1)
		{
			out.print(" selected ");
		}
		out.print(">"+PerformOrders.SPDZ1_TYPE[sp1]);
		out.print("</option>");
	}
 %>

</select>　<input type="text" name="spdz2" value="<%=spdz2 %>" size="25" readonly="readonly" style="background:#cccccc">

		</td>

	</tr>

<%} %>
<tr>
	<td align="right">&nbsp;其他说明:</td>
	<td><textarea rows="2" cols="30" name="qtsm" readonly="readonly" style="background:#cccccc"><%=qtsm %></textarea></td>
</tr>
</table>
<div class="bottom"><input class="Confirmation" type="submit" value="">　　　<input type="button" class="Reset" value="" onClick="f_cx();"></div>
</form>
</div>
</div>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
