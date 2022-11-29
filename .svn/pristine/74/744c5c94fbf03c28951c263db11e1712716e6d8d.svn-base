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
String numbers = teasession.getParameter("numbers");
   
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
%> 
<html>  
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/jsp/type/perform/eme.js" type="text/javascript"></script>
<title>会员卡购票</title>
</head>
<script>
window.name='tar';
	function f_member()
   	{
   		if(form1.member.value=='')
   		{
   			alert("请您输入会员卡号！");
   			form1.member.focus();
   			return false;
   		}
   		//判断用户是否存在
  		  
		  sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=performorders1&member="+form1.member.value,
		  function(data)
		  { 
		    //document.getElementById('show').innerHTML=data;
			          
		    if(data.trim()!=null && data.trim().length==21 )
		    { 
		    	alert(data.trim().split("/"));
		    	form1.member.focus();
		    }else
		    { 
			    var odids = form1.odids.value;
			    var pisid = form1.pisid.value;
			   var zpshowzj = 0;
			    for(var i = 1;i<odids.split("/").length-1;i++)
			    {
			    	var odids_1  =odids.split("/")[i];
			    	var pisid_1 =pisid.split("/")[i];
			    	//获取选择的票价 并修改
			    	document.getElementById("p"+odids_1).innerText=(pisid_1*0.9).toFixed(0);
			    	//计算票价的总和
			    	//alert(zpshowzj+":"+document.getElementById("p"+price_id_m_1_1+"#"+numbers_m_1_1).innerText);
			    	zpshowzj = parseInt(zpshowzj) + parseInt(document.getElementById("p"+odids_1).innerText);
			    }    
			   
			    document.getElementById("pricesaasd").innerText = zpshowzj;
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
		      window.returnValue=1;
             window.close();
		  }
		  );

	}
	//打印
	function f_dy()
	{
		if(confirm('确认出票?')){
			  var printApplet = document.getElementById("printApplet");              
		       var member_js = form1.member.value;//会员
		       var numbers_js = form1.numbers.value;
		       var psid_js= form1.psid.value; 
		       var ip =form1.ip.value;
		       var sp = '?act=AdminOnlineReservations&member='+member_js+'&numbers='+numbers_js+'&psid='+psid_js;

		       openNewDiv('newDiv');
		           printApplet.openPrintApplet(ip,sp);
		       f_close('newDiv'); 
	
		      window.returnValue=1;
				window.close();
		}
		
	}
</script> 
<body id="bodynone2">
<object    
     classid = "clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"    
     codebase = "http://ntcc.redcome.com/print/jre-6u17-windows-i586-iftw-rv.exe#Version=1,6,0,0"    
     WIDTH = 1 HEIGHT = 1 NAME = "printApplet" >    
     <PARAM NAME = CODE VALUE = "PrintApplet.class" >
     <PARAM NAME = ID VALUE = "printApplet" >    	 
     <PARAM NAME = CODEBASE VALUE = "." >    
     <PARAM NAME = ARCHIVE VALUE = "printApplet.jar" >    
     <PARAM NAME = NAME VALUE = "printApplet" >    
     <param name = "type" value = "application/x-java-applet;version=1.6">     
     <param name = "scriptable" value = "true">    
 </object> 
<div class="content">

<form name="form1" action="?" method="GET"  target="tar">
<input type="hidden" name="ip" value="<%out.print(request.getServerName()+":"+request.getServerPort()); %>">
<input type="hidden" name="ordersid" value="<%=ordersid %>">
<input type="hidden" name="numbers" value="<%=numbers %>">
<input type="hidden" name="act" value="AdminOnlineReservations">
<input type="hidden" name="psid" value="<%=psid %>">
<span id="showpiao">
  
 
<div class="MyBooking2">
会员卡号:&nbsp;<input type="text" name="member" value="" >&nbsp;<input type="button" value="刷新" onClick="f_member();">
</div>
<div class="MyBooking">
    	<div class="left">会员卡购票夹</div>
        <div class="right">您现在已经有&nbsp;<font color=red><%=odcount%></font>&nbsp;张票在购票夹中&nbsp;总价金额:&nbsp;<font color=red><span id ="pricesaasd"><%=price %></span></font>&nbsp;元</div>
</div>
    <div class="SeatingTable">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr class="title">
    	<td width="142">演出名称</td>
        <td width="88">场馆名称</td>
        <td width="152">演出时间</td>
        <td width="174">座位</td>
        <td width="62">原价格</td>
        <td width="62">折扣价格</td>
       
	</tr>
	<%
	StringBuffer sp = new StringBuffer("/");
	StringBuffer pi = new StringBuffer("/");
	Enumeration e = OrderDetails.find(teasession._strCommunity," AND orderid ="+DbAdapter.cite(ordersid),0,200);
	if(!e.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
     
   }
		for(int i = 1;e.hasMoreElements();i++)
		{
		//座位
		int odid =((Integer)e.nextElement()).intValue();
		sp.append(odid).append("/");
		
		OrderDetails odobj = OrderDetails.find(odid);
		int numberscc = odobj.getNumbers();
		SeatEditor seobj = SeatEditor.find(numberscc,psobj.getVenues());//显示场馆设置好的分布图
		 PriceDistrict pdobj = PriceDistrict.find(numberscc,psid);//分区价格显示图
		   PriceSubarea psobj2 = PriceSubarea.find(pdobj.getPricesubareaid());
		   pi.append(psobj2.getPrice()).append("/");
	%>  
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">

		<td><%=nobj1.getSubject(teasession._nLanguage) %></td>
		<td><%=nobj2.getSubject(teasession._nLanguage) %></td>
		<td><%=psobj.getPftimeToString() %></td>
		<td><%out.print(seobj.getRegion()+seobj.getLinagenumber()+"排"+seobj.getSeatnumber()+"号"); %></td>
			<td><%=psobj2.getPrice() %>&nbsp;元</td>
		<td><span id ="p<%=odid %>"><%=psobj2.getPrice() %></span>&nbsp;元</td>
		
</tr> 
	<% 
		}
	 %> 
<input type =hidden name=odids value=<%=sp.toString() %>>
<input type =hidden name=pisid value=<%=pi.toString() %>>
</table> 
<a href="#" onClick="f_dy();"><img src="/res/REDCOME/0910/09109944.gif"></a>　　　
<a href="#" onClick="f_cxxz('<%=psid %>');"><img src="/res/REDCOME/0910/09109945.gif"></a>
</div>
</span>   



</form>
</div>

</body>
</html>
