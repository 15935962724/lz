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




//订单号
String ordersid = teasession.getParameter("ordersid");

PerformOrders pfoobj = PerformOrders.find(ordersid);
int psid = pfoobj.getPsid();
//购票金额
BigDecimal price = OrderDetails.getTotalprice(ordersid);
//购票数量
int odcount = OrderDetails.count(teasession._strCommunity," AND orderid ="+DbAdapter.cite(ordersid));

PerformStreak psobj = PerformStreak.find(psid);

    	//演出名称
    	Node nobj1= Node.find(psobj.getNode());
    	//演出场馆
    	Node nobj2 = Node.find(psobj.getVenues());




String names = teasession.getParameter("names");
int zjlx = 0;
if(teasession.getParameter("zjlx")!=null && teasession.getParameter("zjlx").length()>0)
{
	zjlx = Integer.parseInt(teasession.getParameter("zjlx"));
}

String zjhm = teasession.getParameter("zjhm");
String yddh = teasession.getParameter("yddh");
String gddh = teasession.getParameter("gddh");
String dzyx = teasession.getParameter("dzyx");

int sfsp = 0;
if(teasession.getParameter("sfsp")!=null && teasession.getParameter("sfsp").length()>0)
{
	sfsp = Integer.parseInt(teasession.getParameter("sfsp"));
}

int sffp = 0;
if(teasession.getParameter("sffp")!=null && teasession.getParameter("sffp").length()>0)
{
	sffp = Integer.parseInt(teasession.getParameter("sffp"));
}

int spdz1 = 0;
if(teasession.getParameter("spdz1")!=null && teasession.getParameter("spdz1").length()>0)
{
	spdz1 = Integer.parseInt(teasession.getParameter("spdz1"));
}

String spdz2 = teasession.getParameter("spdz2");
String qtsm = teasession.getParameter("qtsm");
String member =teasession.getParameter("member");
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>登记信息</title>
</head>

<body id="bodynone2" onLoad="f_sfsp();"  >
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<DIV class="bodyFramework">
<div class="content">
<script type="text/javascript">
window.history.forward(1);
	function f_submit()
	{
		if(form1.names.value=="")
		{
			alert("【您的姓名】不能为空!");
			document.form1.names.focus();
			return false;
		}
		if(form1.zjlx.value==0)
		{
			alert("【证件类型】不能为空!");
			document.form1.zjlx.focus();
			return false;
		}
		if(form1.zjhm.value=="")
		{
			alert("【证件号码】不能为空!");
			document.form1.zjhm.focus();
			return false;
		}
		if(form1.yddh.value=="")
		{
			alert("【移动电话】不能为空!");
			document.form1.yddh.focus();
			return false;
		}
		if(form1.gddh.value=="")
		{
			alert("【固定电话】不能为空!");
			document.form1.gddh.focus();
			return false;
		}
		if(form1.dzyx.value=="")
		{
			alert("【电子邮箱】不能为空!");
			document.form1.dzyx.focus();
			return false;
		}else if(form1.dzyx.value.indexOf("@")=="-1" || form1.dzyx.value.indexOf(".")=="-1" )
		{
		   alert("您输入的【电子邮箱】有误！");
		   document.form1.dzyx.focus();
		    return false;
		}

		if(form1.spdz1.value==0 && form1.sfsp.value==1)
		{
			alert("【送票地址-区域】不能为空!");
			document.form1.spdz1.focus();
			return false;
		}
		if(form1.spdz2.value=="" && form1.sfsp.value==1)
		{
			alert("【送票地址-详细地址】不能为空!");
			document.form1.spdz2.focus();
			return false;
		}
		if(form1.od.value==1)
		{
			alert("您还没有订票,请重新选择座位!");
			return false;
		}

		//判断时间超时问题 清楚选定的座位
		 sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=performorders1_session&ordersid="+form1.ordersid.value,
		  function(data)
		  {
		    //document.getElementById('show').innerHTML=data;

		    if(data.trim()!=null && data.trim().length>0 )
		    {
		    	alert(data.trim());
		    	window.open('/jsp/type/perform/OnlineReservations.jsp?psid='+form1.psid.value+'&community='+form1.community.value,'_self');


		    }
		  }
		  );
	}
	//会员卡号判断
	function f_member()
	{
		//alert(form1.member.value);
		  sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=performorders1&member="+form1.member.value,
		  function(data)
		  {
		    //document.getElementById('show').innerHTML=data;

		    if(data.trim()!=null && data.trim().length==21 )
		    {
		    	alert(data.trim());
		    	form1.member.value='';
		    }else
		    {
		    	document.getElementById('show').innerHTML=data;
		    }

		  }
		  );
	}
	//判断是否送票
	function f_sfsp()
	{

		if(form1.sfsp.value==1)
		{
			 document.getElementById('tridspdz1').style.display='';

		}
		if(form1.sfsp.value==0)
		{
			 document.getElementById('tridspdz1').style.display='none';
			 form1.spdz1.value=0;
			 form1.spdz2.value='';

		}
	}
	//删除座位
	function f_delete(igd)
	{
		  sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=performorders1_delete&ordersid="+form1.ordersid.value+"&odid="+igd,
		  function(data)
		  {
		    //document.getElementById('show').innerHTML=data;

		    if(data.trim()!=null && data.trim().length>0 )
		    {
		    	document.getElementById('showpiao').innerHTML=data;
		    }
		  }
		  );
	}
	//重新选择座位
	function f_cxxz(igd)
	{
		  sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=performorders1_cxxzdelete&ordersid="+form1.ordersid.value+"&odid="+igd,
		  function(data)
		  {
		      window.open('/jsp/type/perform/OnlineReservations.jsp?psid='+igd+'&community='+form1.community.value,'_self');
		  }
		  );

	}
</script>
<form name="form1" action="/jsp/type/perform/PerformOrders2.jsp" method="POST" onSubmit="return f_submit();">
<input type="hidden" name="ordersid" value="<%=ordersid %>">
<input type="hidden" name="psid" value="<%=psid %>">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">

<span id="showpiao">
<input type="hidden" name="price" value="<%=price %>">
<div class="header">
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099950.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
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
    <td><img src="/res/REDCOME/0909/09099973.gif"></td>
    <td><img src="/res/REDCOME/0909/09099953.gif"></td>
    <td><img src="/res/REDCOME/0909/09099954.gif"></td>
    <td><img src="/res/REDCOME/0909/09099955.gif"></td>
  </tr>
</table>
</div>

<div class="MyBooking">
    	<div class="left">我的购票夹</div>
        <div class="right">您现在已经有&nbsp;<font color=red><%=odcount%></font>&nbsp;张票在购票夹中&nbsp;总价金额:&nbsp;<font color=red><%=price %></font>&nbsp;元</div>
</div>
    <div class="SeatingTable">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr class="title">
    	<td width="142">演出名称</td>
        <td width="88">场馆名称</td>
        <td width="152">演出时间</td>
        <td width="174">座位</td>
        <td width="62">价格</td>
        <td>操作</td>
	</tr>
	<%
	int od = 0;
	Enumeration e = OrderDetails.find(teasession._strCommunity," AND orderid ="+DbAdapter.cite(ordersid),0,200);
	if(!e.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
      od = 1;
   }
		for(int i = 1;e.hasMoreElements();i++)
		{
		//座位
		int odid =((Integer)e.nextElement()).intValue();
		OrderDetails odobj = OrderDetails.find(odid);
		int numbers = odobj.getNumbers();
		SeatEditor seobj = SeatEditor.find(numbers,psobj.getVenues());//显示场馆设置好的分布图
		 PriceDistrict pdobj = PriceDistrict.find(numbers,psid);//分区价格显示图
		   PriceSubarea psobj2 = PriceSubarea.find(pdobj.getPricesubareaid());
	%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">

		<td><%=nobj1.getSubject(teasession._nLanguage) %></td>
		<td><%=nobj2.getSubject(teasession._nLanguage) %></td>
		<td><%=psobj.getPftimeToString() %></td>
		<td><%out.print(seobj.getRegion()+seobj.getLinagenumber()+"排"+seobj.getSeatnumber()+"号"); %></td>
		<td><%=psobj2.getPrice() %>&nbsp;元</td>
		<td><input class="del" name="" type="button" value="移除" onClick="f_delete('<%=odid %>');"/></td>
</tr>
	<%
		}
	 %>
<input type =hidden name=od value=<%=od %>>
</table>
<a href="#" onClick="f_cxxz('<%=psid %>');"><img src="/res/REDCOME/0909/09099978.gif"></a>
</div>
</span>
<div class="MyBooking">
    	<div class="left">登记购票人信息</div>
        <div class="right">( *为必填项目)</div>
    </div>
<div class="TicketInt">
<span id="show">
<table border="0" cellspacing="0" cellpadding="0">
    <tr>
    	<td class="td01">&nbsp;会员卡号:</td>
        <td class="td02"><input type="text" name="member" value="<%if(member!=null && member.length()>0)out.print(member); %>" size="40" onblur="f_member();"> </td>
		<td class="td03">如果你是会员，请在此输入会员卡号，如果您还不是会员可以去注册成为会员。会员购票可打九折！</td>
	</tr>
	<tr>
		<td class="td01">*&nbsp;您的姓名:</td>
        <td class="td02"><input type="text" name="names" value="<%if(names!=null)out.print(names);%>" size="40" > </td>
		<td class="td03">请填写真实姓名，以便领票时核对。</td>
	</tr>
	<tr>
		<td class="td01">*&nbsp;证件类型:</td>
		<td class="td02">
			<select name="zjlx" >
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
<td class="td03">请选择有效证件，领票时需出示核对。</td>
</tr>
<tr>
		<td  class="td01">*&nbsp;证件号码:</td>
        <td class="td02"><input type="text" name="zjhm" value="<%if(zjhm!=null)out.print(zjhm); %>" size="40" mask="float" maxlength="18"></td>
<td class="td03">请输入正确证件号码，以便领票时核对。</td>
	</tr>
	<tr>
		<td class="td01">*&nbsp;移动电话:</td>
        <td class="td02"><input type="text" name="yddh" value="<%if(yddh!=null)out.print(yddh); %>" size="40" mask="float" maxlength="11"></td>
<td class="td03">请输入真实号码，我们会给您发送确认短信。</td>
	</tr>
<tr>
		<td class="td01">*&nbsp;固定电话:</td>
        <td class="td02"><input type="text" name="gddh" value="<%if(gddh!=null)out.print(gddh); %>" size="40" mask="float" maxlength="11"></td>
<td class="td03">请输入真实号码，我们的工作人员会拨打，与您联系。</td>
	</tr>
<tr>
		<td class="td01">*&nbsp;电子邮箱:</td>
        <td class="td02"><input type="text" name="dzyx" value="<%if(dzyx!=null)out.print(dzyx); %>" size="40" ></td>
<td class="td03">请输入真实邮箱，我们会给你发送确认信息。</td>
	</tr>
<tr>
		<td class="td01">*&nbsp;是否送票:</td>
        <td class="td02">
			<select name="sfsp" onChange="f_sfsp();"  ><option value="0" <%if(sfsp==0)out.print(" selected "); %>>-否-</option><option value="1" <%if(sfsp==1)out.print(" selected "); %>>-是-</option></select>&nbsp;&nbsp;
			是否要发票:&nbsp;
			<select name="sffp" ><option value="0" <%if(sffp==0)out.print(" selected "); %>>-否-</option><option value="1"  <%if(sffp==1)out.print(" selected "); %>>-是-</option></select>
		</td>
<td class="td03">&nbsp;</td>
	</tr>
    <tr id="tridspdz1" style="display:none">
		<td class="td01">*&nbsp;送票地址:</td>
        <td class="td02">
			<select name="spdz1" ><option value="0">--选择区域--</option>
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

</select><input type="text" name="spdz2" value="<%if(spdz2!=null)out.print(spdz2); %>" size="25" >

		</td>
<td class="td03">城八区运费15元每单，48小时内递出，远近郊20元，72小时内递出，送票只限北京市，演出前三日内不在送票。</td>
	</tr>
<tr>
	<td class="td01">&nbsp;其他说明:</td>
	<td colspan="2" class="td04"><textarea rows="2" cols="30" name="qtsm" ><%if(qtsm!=null)out.print(qtsm); %></textarea>　还有什么要告诉我们的请写这里。</td>
</tr>
</table>
</span>
 <div class="submit">
 <input type="submit" value="">
</div>
    </div>


</form>
</div></div>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
