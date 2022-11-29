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
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
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

String act = teasession.getParameter("act");
String member = teasession.getParameter("member");

if("performorders1".equals(act))
{
	//Profile pobj = Profile.find(member);
	if(!Profile.isExisted(member))
	{
		out.print("对不起,您输入的会员卡号有误,请重新输入!");
	}else
	{
	   Profile pobj = Profile.find(member);
	
%>

<div class="TicketInt">
<table border="0" cellspacing="0" cellpadding="0">
    <tr>
    	<td class="td01">&nbsp;会员卡号:</td>		
        <td class="td02"><input type="text" name="member" value="<%=member%>" size="40" onchange="f_member();"> </td>	
		<td class="td03">如果你是会员，请在此输入会员卡号，如果您还不是会员可以去注册成为会员。会员购票可打九折！</td>
	</tr>
	<tr>
		<td class="td01">*&nbsp;您的姓名:</td>		
        <td class="td02"><input type="text" name="names" value="<%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage) %>" size="40" > </td>	
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
						if(pobj.getCardType()==zj)
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
		<td class="td01">*&nbsp;证件号码:</td>		
        <td class="td02"><input type="text" name="zjhm" value="<%if(pobj.getCard()!=null)out.print(pobj.getCard()); %>" size="40" mask="float" maxlength="18"></td>	
<td class="td03">请输入正确证件号码，以便领票时核对。</td>
	</tr>
	<tr>
		<td class="td01">*&nbsp;移动电话:</td>		
        <td class="td02"><input type="text" name="yddh" value="<%if(pobj.getMobile()!=null)out.print(pobj.getMobile()); %>" size="40" mask="float" maxlength="11"></td>	
<td class="td03">请输入真实号码，我们会给您发送确认短信。</td>
	</tr>
<tr>
		<td class="td01">*&nbsp;固定电话:</td>		
        <td class="td02"><input type="text" name="gddh" value="<%if(pobj.getTelephone(teasession._nLanguage)!=null)out.print(pobj.getTelephone(teasession._nLanguage)); %>" size="40" mask="float" maxlength="11"></td>	
<td class="td03">请输入真实号码，我们的工作人员会拨打，与您联系。</td>
	</tr>
<tr>
		<td class="td01">*&nbsp;电子邮箱:</td>		
        <td class="td02"><input type="text" name="dzyx" value="<%if(pobj.getEmail()!=null)out.print(pobj.getEmail()); %>" size="40" ></td>	
<td class="td03">请输入真实邮箱，我们会给你发送确认信息。</td>
	</tr>
<tr  >
		<td class="td01">*&nbsp;是否送票:</td>		
        <td class="td02">
			<select name="sfsp"  onchange="f_sfsp();"  ><option value="0" >-否-</option><option value="1">-是-</option></select>&nbsp;&nbsp;
			是否要发票:&nbsp;
			<select name="sffp" ><option value="0" >-否-</option><option value="1"  >-是-</option></select>
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
		//if(pobj.getCity(teasession.) == sp1)
		//{
			//out.print(" selected ");
		//}
		out.print(">"+PerformOrders.SPDZ1_TYPE[sp1]);
		out.print("</option>");
	}
 %>

</select><input type="text" name="spdz2" value="<%if(pobj.getAddress(teasession._nLanguage)!=null)out.print(pobj.getAddress(teasession._nLanguage)); %>" size="25" >
			
		</td>	
<td class="td03">城八区运费15元每单，48小时内递出，远近郊20元，72小时内递出，送票只限北京市，演出前三日内不在送票。</td>
	</tr>
<tr>
	<td class="td01">&nbsp;其他说明:</td>
	<td colspan="2" class="td04"><textarea rows="2" cols="30" name="qtsm" ></textarea>　还有什么要告诉我们的请写这里。</td>
</tr>

</table>
</div>
<%
	
	
	}
	return;
}
else if("performorders1_delete".equals(act))
{
	int odid1 = Integer.parseInt(teasession.getParameter("odid"));
	OrderDetails odobj1 = OrderDetails.find(odid1);
	odobj1.delete();
	//String ordersid = teasession.getParameter("ordersid");
	PerformOrders pfoobj = PerformOrders.find(ordersid);
    int psid = pfoobj.getPsid();
    PerformStreak psobj = PerformStreak.find(psid);
    	//演出名称
    Node nobj1= Node.find(psobj.getNode());
    	//演出场馆
    Node nobj2 = Node.find(psobj.getVenues());
    //购票金额
BigDecimal price = OrderDetails.getTotalprice(ordersid);
//购票数量
int odcount = OrderDetails.count(teasession._strCommunity," AND orderid ="+DbAdapter.cite(ordersid));
%>
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
<%
	return;
}
else if("performorders1_session".equals(act))
{
	
	   // HttpSession session = request.getSession();
		String sessionidString = (String)session.getId();
		String timeString = (String)session.getAttribute(sessionidString);//截止时间
		
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		 Date times = new Date();//当前时间
		 if(times.compareTo(sdf.parse(timeString))>0)
		 {
		 	PerformOrders porobj = PerformOrders.find(ordersid);
		 	porobj.delete();
		 	OrderDetails.delete(ordersid);
		 	out.print("您的购票过程已超时,请重新选择座位!");
		 }
		 
	//	out.print(timeString);
		
		return;
}else if("performorders1_cxxzdelete".equals(act))//重新选座要删除订单
{
	PerformOrders porobj = PerformOrders.find(ordersid);
	porobj.delete();
    OrderDetails.delete(ordersid);
}else if("f_member".equals(act))//会员卡购票
{  
	 
	 int psids = Integer.parseInt(teasession.getParameter("psid"));
	 String members = teasession.getParameter("member");
	  if(members!=null && members.length()>0){}
	  else
	  { 
		  members = session.getId();
	  }  

	  String numbers2 = teasession.getParameter("numbers");//选择的座位编号
	  String ordersids = PerformOrders.getOridsString(psids,numbers2,members,teasession.getParameter("community"),teasession._nLanguage,0); 
	 // HashMap hm = new HashMap();
	 session.setAttribute("ordersids",ordersids);
	 
	  out.print(ordersids);
	  return;  
}else if("Hmordersids".equals(act)) //删除订单
{
	 HashMap hm = new HashMap();
	   ordersid = (String)session.getAttribute("ordersids");
		PerformOrders porobj = PerformOrders.find(ordersid);
		porobj.delete();
	    OrderDetails.delete(ordersid);
	    session.removeAttribute("ordersids");
	   
	    return;
}else if("f_frontreartype".equals(act))//修改支付方式
{
	PerformOrders porobj = PerformOrders.find(ordersid);
	int FrontrearType = Integer.parseInt(teasession.getParameter("frontreartype"));
	porobj.setFrontrearType(FrontrearType);
	if(FrontrearType==2)//货到付款
	{
		porobj.setType(3);
	}
	return;
}else if("xiangxi".equals(act))//查看详细
{
	int type = 0;
	if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
	{
		type = Integer.parseInt(teasession.getParameter("type"));
	}
	PerformOrders porobj_1 = PerformOrders.find(ordersid);
	//运费
	int fare = porobj_1.getFare();
	
%>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter2">
   <tr id="tableonetr">
      <td nowrap>演出名称</td>
      <TD nowrap>演出场馆</TD>
      <TD nowrap>座位</TD>
      <TD nowrap>时间</TD>
      <TD nowrap>价格</TD>
      <TD nowrap>
      <%
      	 if(type>0)
      	 {
      		 if(fare>0)//有运费
      		 {
      			out.print("运费"); 
      		 }else
      		 {
      		 	out.print("领票人");
      		 }
      	 }else{
      		 out.print("操作");
      	 }
      %>
      </TD>
    </tr>

    <%
    	Enumeration e = OrderDetails.find(teasession._strCommunity," and orderid ="+DbAdapter.cite(ordersid),0,100);
    	int counts = OrderDetails.count(teasession._strCommunity," and orderid ="+DbAdapter.cite(ordersid));
    	for(int i = 1;e.hasMoreElements();i++)
    	{
    		int odid = ((Integer)e.nextElement()).intValue();
    		OrderDetails odobj = OrderDetails.find(odid);
    %>
    
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td><%=odobj.getPerformname() %></td>
<td><%=odobj.getPsname() %></td>
<td><%out.print(odobj.getRegion()+"&nbsp;"+odobj.getLinage()+"&nbsp;排"+odobj.getSeat()+"&nbsp;号"); %></td>
<td><%=PerformStreak.sdf(OrderDetails.sdf.parse(odobj.getPstime())) %></td>
<td><%=odobj.getTotalprice() %>&nbsp;元</td>
<% 

	if(i==1){
		out.print("<td rowspan = "+(counts+2)+" style=text-align:center;padding:0px;>");
		if(type>0)
		{
			
			if(fare>0)//有运费显示
			{
				out.print(fare+"&nbsp;元");
			}
			else 
			{
				if(porobj_1.getLingpiao()==1)//本人
				{
					out.print("本人");
				}else if(porobj_1.getLingpiao()==2)//其他人
				{
					out.print("他人代领<br>");
					out.print(" 姓名："+porobj_1.getLpname()+"<br>");
					out.print("身份证号 ："   +porobj_1.getLpzjhm());
				}
			}
			
		}else
		{ 
		
			out.print("<a href=# onclick=f_qrcp('"+ordersid+"');><img src=\"/res/REDCOME/0911/0911991.gif\"></a>");
		}
		out.print("</td>");
	}
%>
</tr>
<%} %>  
<%

	if(type==0){
%>
<tr> 

	<td>
		<%
		if(fare>0)
		{
			out.print("&nbsp;");
		}else
		{
			out.print("领票人：&nbsp;");
		}
	%>
	</td>
	
	<td colspan="4"> 
	<%if(fare==0){ %>
	本人&nbsp;<input type="radio" id="lingpiao<%=ordersid %>"  name="lingpiao<%=ordersid %>" value="1" checked="checked">&nbsp;
	其他人&nbsp;<input type="radio" id=name="lingpiao<%=ordersid %>" name="lingpiao<%=ordersid %>" value="2">&nbsp;
	<%}else if(fare>0){
		out.print("您的运费是:"+fare+"&nbsp;元&nbsp;&nbsp;");
		%>
	出票后快递&nbsp;<input type="radio" id="lingpiao<%=ordersid %>" name="lingpiao<%=ordersid %>" value="3" checked="checked">&nbsp;
	<%} %>
	</td>
</tr>
<%if(fare==0){ %> 
<tr>
	<td>&nbsp;</td>
	<td colspan="4">姓名：&nbsp;<input type="text" id="lpname<%=ordersid %>" name="lpname<%=ordersid %>" value="">&nbsp;身份证号：
	&nbsp;<input type="text" id="lpzjhm<%=ordersid %>" name="lpzjhm<%=ordersid %>" value=""></td>
</tr>

<% 
}
	}
%>
</table> 
<%
	
	return;	
}else if("OnlineReservations_f_submit".equals(act))//如果有人定了这个座位，提示
{
	String numbers = teasession.getParameter("numbers");
	int psid = Integer.parseInt(teasession.getParameter("psid"));
	if("/".equals(numbers))
	{
		out.print("请选择您的座位");
	}else
	{
		
		for(int i = 1;i<numbers.split("/").length;i++)
		{
			int numid = Integer.parseInt(numbers.split("/")[i]);
			int coum = OrderDetails.count(teasession._strCommunity," AND numbers = "+numid+" AND psid= "+psid);
			if(coum>0)//说明有这个座位
			{
				out.print("您选中的座位已经订出,请重新选择座位!");
				break;
			}
			
		}
	}
	return;
}else if("AdminOnlineReservat_f_perform".equals(act))//判断演出关联的场次
{
	int perform = Integer.parseInt(teasession.getParameter("perform"));
	int psids = Integer.parseInt(teasession.getParameter("psid"));//场次id
	Enumeration psen = PerformStreak.find(teasession._strCommunity," and node =  "+perform,0,100);
	out.print("<select name=\"performstreak\" id=\"select\"  onchange=\"f_performstreak();\">");
	if(!psen.hasMoreElements())
	{
		out.print("<option value=0>--暂没有场次--</option>");
	}
	while(psen.hasMoreElements())
	{
		int ps = ((Integer)psen.nextElement()).intValue();
		PerformStreak psobj = PerformStreak.find(ps);
		out.print("<option value ="+ps);
		if(psids==ps)
		{
			out.print(" selected ");
		}
		out.print(">"+psobj.getPsname());
		out.print("</option>");
		
	}
	out.print("</select>");
	return;
	
}else if("AdminOnlineReservat_f_performstreak".equals(act))// 显示场次的信息
{
	int performstreak = Integer.parseInt(teasession.getParameter("performstreak"));
	if(performstreak>0)
	{
		PerformStreak psobj = PerformStreak.find(performstreak);
		Node nobj = Node.find(psobj.getVenues());
		out.print("演出时间:&nbsp;");
		out.print(PerformStreak.sdf(psobj.getPftime()));
		out.print("&nbsp;演出场馆:&nbsp;");
		out.print(nobj.getSubject(teasession._nLanguage));
	}else{
		out.print("暂无演出时间以及演出场馆信息.");
	}
	return;
}else if("BouncePiao_f_inquiry".equals(act))//退票、废票 中的编号查询
{
	int pjnumber = Integer.parseInt(teasession.getParameter("pjnumber"));
	OrderDetails odpjobj = OrderDetails.find(pjnumber);//座位订单表
	PerformStreak pspjobj = PerformStreak.find(odpjobj.getPsid());//场次表
	Node nobj1 = Node.find(pspjobj.getNode());//演出名称
	Node nobj2 = Node.find(pspjobj.getVenues());//演出场馆 
	String sql = "  and po.ordersid ="+DbAdapter.cite(odpjobj.getOrderid())+" and po.type = 4 and po.frontreartype != 2 ";
	int type = 0;
	boolean f = PerformStreak.isDateBefore(pspjobj.getEndbouncetimeToString());
	if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
	{
		type = Integer.parseInt(teasession.getParameter("type"));

	}
	if(type==1)//废票处理
	{
		sql = " and po.type !=0 ";
		f = true;
	}
  
    int count = OrderDetails.count2(teasession._strCommunity,sql);
    out.print("<table border=0 cellpadding=0 cellspacing=0 id=\"tablecenter\">");
		out.print("<TR id=\"tableonetr\">");
		out.print("<TD nowrap>票据编号</TD>");
		out.print("<TD nowrap>演出名称</TD>");
		out.print("<TD nowrap>演出场馆</TD>");
		out.print("<TD nowrap>座位</TD>");
		out.print(" <TD nowrap>时间</TD>");
		out.print("<TD nowrap>价格</TD>");
		out.print("<TD nowrap>操作</TD>");
		out.print("</tr>");
		 
    
	if(odpjobj.isExist()&&count>0&&f)  
	{ 
		
		out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\">");
			out.print("<td>");
				out.print(pjnumber);
			out.print("</td>");
			
			out.print("<td>");
			 out.print(nobj1.getSubject(teasession._nLanguage));
		    out.print("</td>");
		    
		    out.print("<td>");
			 out.print(nobj2.getSubject(teasession._nLanguage));
		    out.print("</td>");
		    
		    out.print("<td>");
			 out.print(odpjobj.getRegion()+"&nbsp;"+odpjobj.getLinage()+"&nbsp;排&nbsp;"+odpjobj.getSeat()+"&nbsp;号&nbsp;");
		    out.print("</td>");
		    
		    out.print("<td>");
		    if(odpjobj.getPstime()!=null && odpjobj.getPstime().length()>0)
		    {
			  out.print(PerformStreak.sdf(OrderDetails.sdf.parse(odpjobj.getPstime())));
		    }
		    out.print("</td>");
		    
		    out.print("<td>");
			 out.print(odpjobj.getPrice()+"&nbsp;元");
		    out.print("</td>");
		    
		    out.print("<td>");
		    if(type==0)//退票
		    {
		    	
		    	 out.print("<a href=# onclick=f_submit_tp();><img src=/res/REDCOME/0911/0911993.gif></a>");
		    }else if(type==1)//废票按钮
		    {
		    	 out.print("<a href=# onclick=f_submit_tp();><img src=/res/REDCOME/0911/0911994.gif></a>");
		    }else if(type==2)//废票中的确认作废
		    {
		    	out.print("<a href=# onclick=f_submit_qr();><img src=/res/REDCOME/0911/0911995.gif></a>");
		    }
		    out.print("</td>");
		out.print("</tr>");
		out.print("</table>");
	}else
	{
		out.print("<tr><td colspan=7>您输入的编号找不到这个座位，请在确认输入!</td></tr>");
	}
	return;
}else if("BouncePiao_f_submit_tp".equals(act))//点击退票、废票确认按钮
{
	int pjnumber = Integer.parseInt(teasession.getParameter("pjnumber"));//票的座位id
	OrderDetails odpjobj = OrderDetails.find(pjnumber);//座位订单表
	out.print("<table border=0 cellpadding=0 cellspacing=0 id=\"tablecenter\">");
	out.print("<TR id=\"tableonetr\">");
	out.print("<TD nowrap>票据编号</TD>");
	out.print("<TD nowrap>原价</TD>");
	out.print("<TD nowrap>扣手续费</TD>");
	out.print("<TD nowrap>退还金额</TD>");
	out.print("<TD nowrap>操作</TD>");
	out.print("</tr>");
	
	out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\">");
	
	out.print("<td>");
		out.print(pjnumber);
	out.print("</td>");
	
	out.print("<td>");
	    out.print(odpjobj.getPrice());
    out.print("</td>");
    
    out.print("<td>");
        out.print(odpjobj.getPrice());
    out.print("</td>");

    out.print("<td>");
        out.print(odpjobj.getPrice());
    out.print("</td>");
    
    out.print("<td>");
       out.print("<a href=# onclick=f_submit_qr();><img src=/res/REDCOME/0911/0911997.gif></a>");
    out.print("</td>");
    
	
	out.print("</tr>");
	out.print("</table>");
	return;
}else if("BouncePiao_f_submit_qr".equals(act))//点击的退票，废票 确认按钮
{
	int pjnumber = Integer.parseInt(teasession.getParameter("pjnumber"));//票的座位id
	OrderDetails odpjobj = OrderDetails.find(pjnumber);//座位订单表
	//在删除这个订单 要减去订单表中的个数和钱数
	PerformOrders poobj = PerformOrders.find(odpjobj.getOrderid());
	if(poobj.getQuantity()>1)
	{
	    poobj.set(poobj.getQuantity()-1,poobj.getTotalprice().subtract(odpjobj.getTotalprice()));
	}else
	{
		poobj.delete();
	}
	 
	//删除订单座位 表中的数据
	odpjobj.delete();
	//往退票和 废票 表中插入数据
	float  poundage =(float)0.2;//退票默认 手续费
	
	int type = 0;
	if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
	{
		type = Integer.parseInt(teasession.getParameter("type"));
	}
	java.math.BigDecimal pr2 = new java.math.BigDecimal("0");
	
	pr2 = odpjobj.getPrice().subtract( odpjobj.getPrice().multiply(new java.math.BigDecimal("0.2")) );//退票加的手续费的价格
	
	
	if(type==1)//废票处理
	{
		poundage=0;//手续费
		pr2=odpjobj.getPrice();
	}
	
	
	BouncePiao.create(pjnumber,odpjobj.getPsid(),odpjobj.getPrice(),poundage,pr2,teasession._rv.toString(),odpjobj.getOrderid(),odpjobj.getNumbers(),type); 
	 
	BouncePiao bpobj = BouncePiao.find(pjnumber);
	//在添加演出时间和座位号
	bpobj.set(BouncePiao.sdf2.parse(odpjobj.getPstime()),odpjobj.getRegion()+odpjobj.getLinage()+"排"+odpjobj.getSeat()+"号"); 
	
	PerformStreak pspjobj = PerformStreak.find(odpjobj.getPsid());//场次表
	Node nobj1 = Node.find(pspjobj.getNode());//演出名称
	Node nobj2 = Node.find(pspjobj.getVenues());//演出场馆 

	out.print("<table border=0 cellpadding=0 cellspacing=0 id=\"tablecenter\">");
	out.print("<TR id=\"tableonetr\">");
	out.print("<TD nowrap>票据编号</TD>");
	out.print("<TD nowrap>演出名称</TD>");
	out.print("<TD nowrap>演出场馆</TD>");
	out.print("<TD nowrap>座位</TD>");
	out.print(" <TD nowrap>时间</TD>");
	out.print("<TD nowrap>价格</TD>");
	out.print("<TD nowrap>操作</TD>");
	out.print("</tr>");
	
	out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\">");
		out.print("<td>");
			out.print(pjnumber);
		out.print("</td>");
		
		out.print("<td>");
		 out.print(nobj1.getSubject(teasession._nLanguage));
	    out.print("</td>");
	    
	    out.print("<td>");
		 out.print(nobj2.getSubject(teasession._nLanguage));
	    out.print("</td>");
	    
	    out.print("<td>");
		 out.print(odpjobj.getRegion()+"&nbsp;"+odpjobj.getLinage()+"&nbsp;排&nbsp;"+odpjobj.getSeat()+"&nbsp;号&nbsp;");
	    out.print("</td>");
	    
	    out.print("<td>");
		 out.print(PerformStreak.sdf(OrderDetails.sdf.parse(odpjobj.getPstime())));
	    out.print("</td>");
	    
	    out.print("<td>");
		 out.print(odpjobj.getPrice()+"&nbsp;元");
	    out.print("</td>");
	    
	    out.print("<td>");
		  out.print("<a href=# onclick=f_submit_cx();><img src=/res/REDCOME/0911/0911996.gif></a>");
	    out.print("</td>");
	out.print("</tr>");
	out.print("</table>");
	return;
	
}else if("TicketStatistice_f_perform".equals(act))//售票统计,订单管理 中显示场次
{
	String acttype = teasession.getParameter("acttype");
	int perform = Integer.parseInt(teasession.getParameter("perform"));
	int performstreak = Integer.parseInt(teasession.getParameter("performstreak"));//场次id
	Enumeration psen = PerformStreak.find(teasession._strCommunity," and node =  "+perform,0,100);
	out.print("<select name=\"performstreak\" ");
	if(!"OrderPiaoList".equals(acttype))//如果不参数相等 售票统计中使用
	{
		out.print("onchange=\"f_performstreak();\" ");	
	}
	out.print(">");
	
	
		out.print("<option value=0>--选择场次--</option>");
	while(psen.hasMoreElements())
	{
		int ps = ((Integer)psen.nextElement()).intValue();
		PerformStreak psobj = PerformStreak.find(ps);
		out.print("<option value ="+ps);
		if(performstreak==ps)
		{
			out.print(" selected ");
		}
		out.print(">"+psobj.getPsname());
		out.print("</option>");
		
	}
	out.print("</select>");
	return;
}else if("TicketStatistice_f_performstreak".equals(act))//售票统计中的 点击场次显示票种
{
	int performstreak = Integer.parseInt(teasession.getParameter("performstreak"));
	int vote = -1;
	if(teasession.getParameter("vote")!=null && teasession.getParameter("vote").length()>0)
	{
		vote = Integer.parseInt(teasession.getParameter("vote"));
	}   
	Enumeration ve  = Vote.find(teasession._strCommunity," and psid = "+performstreak,0,50);
	out.print("<select name=\"vote\">");
	out.print("<option value=\"\">-选择票种-</option>");
	if(ve.hasMoreElements())
	{
		out.print("<option value=0 ");
		if(vote==0)
		{
			out.print(" selected ");
		}
		out.print(">标准票</option>");
	}
	while(ve.hasMoreElements())
	{
		int voteid = ((Integer)ve.nextElement()).intValue();
		Vote voobj = Vote.find(voteid);
		out.print("<option value="+voteid);
		if(vote == voteid)
		{
			out.print(" selected ");
		}
		out.print(">"+voobj.getVotename());
		out.print("</option>");
	}
	return;  
}else if("EditPerformStreak_f_onchange_venues".equals(act))//EditPerformStreak.jsp中 显示场馆相同的场次名称
{
	int venues = Integer.parseInt(teasession.getParameter("venues"));
	int psid = Integer.parseInt(teasession.getParameter("psid"));
	int chevalue = Integer.parseInt(teasession.getParameter("chevalue"));
	Node nobj = Node.find(venues);
	 java.util.Enumeration esEnumeration = PerformStreak.find(teasession._strCommunity," and venues="+venues+" and psid!="+psid+" and community ="+DbAdapter.cite(teasession._strCommunity),0,Integer.MAX_VALUE);
	 out.print("<select name=\"chevalue\">");
	 out.print("<option value=\"0\">--选择票价场次--</option>)");
	 while(esEnumeration.hasMoreElements())
		{
			int psid2 = ((Integer)esEnumeration.nextElement()).intValue();
			PerformStreak psobj2 = PerformStreak.find(psid2);
			out.print("<option value="+psid2);
			if(chevalue==psid2) 
			{
				out.print(" selected ");
			} 
			out.print(">"+nobj.getSubject(teasession._nLanguage)+psobj2.getPsname());
			out.print("</option>");
		}
	 out.print("</select>");
	 return;
}
%>

