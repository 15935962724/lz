<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Calendar" %>
<%@page import="java.util.GregorianCalendar" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.math.BigDecimal"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

int type =0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
	type = Integer.parseInt(teasession.getParameter("type"));	
}

String nexturl = request.getRequestURI()+"?"+request.getContextPath();//teasession.getParameter("nexturl");
StringBuffer sql = new StringBuffer(" and po.type = 4 and ( po.frontreartype =1 or po.frontreartype=3 or po.frontreartype=4)");//后台管理员打票 订单
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
param.append("&type=").append(type);

if(type==1)//定位到当前登录者打出的票
{
	sql.append(" and po.adminmember = ").append(DbAdapter.cite(teasession._rv.toString()));
}

//演出时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND pstime >= ").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND pstime <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}
//当天
String daytime= teasession.getParameter("daytime");
if(daytime!=null && daytime.length()>0)
{
	sql.append(" AND pstime >=").append(DbAdapter.cite(daytime+" 00:00"));
	sql.append(" AND pstime <=").append(DbAdapter.cite(daytime+" 23:59"));
	param.append("&daytime=").append(daytime);
}
//本周
String weektime = teasession.getParameter("weektime");
if(weektime!=null && weektime.length()>0)
{

	//取得当前日期所在周的第一天
		Calendar c = new GregorianCalendar();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.setTime(OrderDetails.sdf.parse(weektime));
		c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek()); // Monday
		sql.append(" AND pstime >=").append(DbAdapter.cite(OrderDetails.sdf.format(c.getTime ())+" 00:00"));
	//取得当前日期所在周的最后一天
		Calendar c2 = new GregorianCalendar();
		c2.setFirstDayOfWeek(Calendar.MONDAY);
		c2.setTime(OrderDetails.sdf.parse(weektime));
		c2.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek() + 6); // Sunday
		sql.append(" AND pstime <=").append(DbAdapter.cite(OrderDetails.sdf.format(c2.getTime ())+"  23:59"));
		param.append("&weektime=").append(weektime);
		
	
}
//本月
String monthtime = teasession.getParameter("monthtime");
if(monthtime!=null && monthtime.length()>0)
{
	//当月时间的第一天
		sql.append(" AND pstime >=").append(DbAdapter.cite(monthtime.substring(0,7)+"-01"+" 00:00"));
	//当月最后一天
	
     Calendar now =Calendar.getInstance();
     now.setTime(OrderDetails.sdf.parse(monthtime));//传入日期
     now.set(Calendar.MONTH, now.get(Calendar.MONTH)+1);
     now.set(Calendar.DATE, 1);
     now.set(Calendar.DATE, now.get(Calendar.DATE)-1);
     now.set(Calendar.HOUR, 11);
     now.set(Calendar.MINUTE, 59);
     now.set(Calendar.SECOND, 59);
    sql.append(" AND pstime <=").append(DbAdapter.cite(OrderDetails.sdf.format(now.getTime())+" 23:59"));
    param.append("&monthtime=").append(monthtime);

}
//价格
int price = 0;
if(teasession.getParameter("price")!=null && teasession.getParameter("price").length()>0)
{
	price = Integer.parseInt(teasession.getParameter("price"));	
}
if(price>0)
{
	sql.append(" and price = ").append(price);
	param.append("&price=").append(price);
}
//演出
int perform =0;
if(teasession.getParameter("perform")!=null && teasession.getParameter("perform").length()>0)
{
	perform = Integer.parseInt(teasession.getParameter("perform"));	
}
if(perform>0)
{
	sql.append(" and od.psid in (select psid from PerformStreak where node ="+perform+" ) ");
	param.append("&perform=").append(perform);
}
//场次
int performstreak = 0;
if(teasession.getParameter("performstreak")!=null && teasession.getParameter("performstreak").length()>0)
{
	performstreak = Integer.parseInt(teasession.getParameter("performstreak"));	
}
if(performstreak>0)
{
	sql.append(" and od.psid = "+performstreak);
	param.append("&performstreak=").append(performstreak);
}

//场馆
int venues = 0;
if(teasession.getParameter("venues")!=null && teasession.getParameter("venues").length()>0)
{
	venues = Integer.parseInt(teasession.getParameter("venues"));	
}
if(venues>0)
{
	sql.append(" and od.psid in (select psid from PerformStreak where venues ="+venues+" )");
	param.append("&venues= ").append(venues);
}
//票种
int vote = -1;
if(teasession.getParameter("vote")!=null && teasession.getParameter("vote").length()>0)
{
	vote = Integer.parseInt(teasession.getParameter("vote"));	
	sql.append(" and po.vote = "+vote);
	param.append("&vote= ").append(vote);
}
//是否非会员
int membertype = -1;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
	membertype = Integer.parseInt(teasession.getParameter("membertype"));
	sql.append(" and od.orderid in (select ordersid from PerformOrders where membertype ="+membertype+")");
	param.append("&membertype=").append(membertype);
}



int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = OrderDetails.count2(teasession._strCommunity,sql.toString());

//sql.append(" order by times desc ");


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>售票统计</title>
</head>


<body id="bodynone" onLoad="f_onload();">
<script>
function f_onload()
{
	f_perform();
	
}
function checkRate()//判断是否编号是数字
{
     var re = /^[0-9]+.?[0-9]*$/;   //判断字符串是否为数字     //判断正整数 /^[1-9]+[0-9]*]*$/  
    var nubmer = document.getElementById("price").value;
    
     if (!re.test(nubmer))
    {
    	showTooltips(null,"只能输入数字。");
        document.getElementById("price").value = "";
        return false;
     }
}
//选择演出 显示场次
function f_perform()
{
	sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=TicketStatistice_f_perform&perform="+form1.perform.value+"&community="+form1.community.value+"&performstreak=<%=performstreak%>",
		  function(data)
		  {
		    document.getElementById("showxx").innerHTML=data.trim();
		       f_performstreak();
		  }
		  );
}
//选择场次 显示票种
function f_performstreak()
{
	 sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=TicketStatistice_f_performstreak&performstreak="+form1.performstreak.value+"&community="+form1.community.value+"&vote=<%=vote%>",
		  function(data)
		  {
	
		    document.getElementById("showxx2").innerHTML=data.trim();
		  }
		  );
}
</script>

<h1>售票统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="get">
<input type="hidden" name="act" value="AdminDrawabill">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="id" value="<%=teasession.getParameter("id") %>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>


<table border="0" cellpadding="0" cellspacing="0" id="tableSearch">
 <tr>
 <td>
  <table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="50%" nowrap>
            从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />　<a href="?id=<%=teasession.getParameter("id") %>&daytime=<%=OrderDetails.sdf.format(new Date()) %>">当天</a>&nbsp;
       <a href="?id=<%=teasession.getParameter("id") %>&weektime=<%=OrderDetails.sdf.format(new Date()) %>">本周</a>&nbsp;
        <a href="?id=<%=teasession.getParameter("id") %>&monthtime=<%=OrderDetails.sdf.format(new Date()) %>">本月</a></td>
          
     <td  width="25%">票种:&nbsp;
  		<span id ="showxx2">
	         <select name="vote" >
	             <option value="">-选择票种-</option>
	        </select>
         </span>
     </td>
     <td  width="25%">演出:&nbsp;
  			<select name="perform" onChange="f_perform();">
  			<option value="0">--选择演出--</option>
		<%
		Enumeration pfen = Node.find(" and type = 55 and hidden = 0 and community = "+DbAdapter.cite(teasession._strCommunity),0,Integer.MAX_VALUE);
		while(pfen.hasMoreElements())
		{
			int nid = ((Integer)pfen.nextElement()).intValue();
			Node nobj = Node.find(nid);
			out.print("<option value= "+nid);
			if(perform==nid)
			{
				out.print(" selected ");
			}
			out.print(">"+nobj.getSubject(teasession._nLanguage));
			out.print("</option>");
		}
		%>
      </select>　
       </td></tr>
       </table>
  		</td>
     </tr>
  <tr>
  		<td>
      <table border="0" cellpadding="0" cellspacing="0">
  <tr>
 <td width="25%">
  			场馆:&nbsp;
  			<select name="venues"><option value="0">--选择场馆--</option>
  			<%
  				java.util.Enumeration ve  = Node.find(" and type = 92 and hidden = 0 and community = "+DbAdapter.cite(teasession._strCommunity),0,Integer.MAX_VALUE);
  			while(ve.hasMoreElements())
  			{
  				int nid = ((Integer)ve.nextElement()).intValue();
  				Node nobj = Node.find(nid);
  				out.print("<option value ="+nid);
  				if(venues==nid)
  				{
  					out.print(" selected ");
  				}
  				out.print(">"+nobj.getSubject(teasession._nLanguage));
  				out.print("</option>");
  			}
  			%>	
  			</select>	
            </td>
        	<td width="25%">
        价格：&nbsp;<input type="text" name="price" id="price" value="<%if(price>0)out.print(price); %>" onKeyUp="checkRate();">
     </td>
        <td  width="25%">
  		是否会员:&nbsp;<select name="membertype">
  			<option value="">-------</option>
  			<option value="1" <%if(membertype==1)out.print(" selected "); %>>-是会员-</option>
  			<option value="0" <%if(membertype==0)out.print(" selected "); %>>-非会员-</option>
  			</select>
  		</td>
  		<td  width="25%">场次:&nbsp;
  			<span id ="showxx">
  				<select name="performstreak"   onchange="f_performstreak();"><option value=0>--选择场次--</option></select>
  			</span>
  		</td>
  	
  		</tr></table>
  		</td>
  			
  </tr>
  <tr><td class="tdp09"><input type="submit" value="" class="SearchInput"> </td></tr>
</table>  
</form>
    
   <form name="form2" action="/servlet/ExportPerformExcel" method="POST">
    <input type="hidden" name="files" value="售票统计表">
  <input type="hidden" name="act" value="WebDrawabill">
  <input type="hidden" name="sql" value="<%=sql.toString() %>">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <TD nowrap>票据编号</TD>
      <td nowrap>演出名称</td>
      <TD nowrap>演出场馆</TD>
      <TD nowrap>座位</TD>
      <TD nowrap>演出时间</TD>
      <TD nowrap>演出价格</TD>
      <%if(type==0)out.print("<td nowrap>售票员</td>"); %>
    </tr>
   <%
   java.util.Enumeration e = OrderDetails.find2(teasession._strCommunity,sql.toString(),pos,pageSize);
   BigDecimal  tp = new BigDecimal("0");
		   if(!e.hasMoreElements())
		   {
		       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
		   }
   			while(e.hasMoreElements())
   			{
   				int orid =((Integer)e.nextElement()).intValue();
   				OrderDetails odobj = OrderDetails.find(orid);
   				PerformOrders poobj =PerformOrders.find(odobj.getOrderid());
   				tp = tp.add(odobj.getTotalprice());
   	
   				 
   %>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   <td nowrap><%=orid%></td>
   <td nowrap><%=odobj.getPerformname() %></td>
   <td nowrap><%=odobj.getPsname() %></td>
    <td nowrap><%out.print(odobj.getRegion()+"&nbsp;"+odobj.getLinage()+"&nbsp;排&nbsp;"+odobj.getSeat()+"&nbsp;号"); %></td>
   <td nowrap><%=odobj.getPstime() %></td>
   <td nowrap><%=odobj.getTotalprice()%>&nbsp;元</td>
   <%if(type==0)out.print("<td>"+poobj.getAdminMember()+"</td>"); %>
   </tr>     
    <%
   			}
    %>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
<table>
	<tr>
		<td>合计:&nbsp;售出&nbsp;<%=OrderDetails.count2(teasession._strCommunity,sql.toString()) %>&nbsp;张票&nbsp;&nbsp;总金额:&nbsp;<%=tp %>&nbsp;元</td>
	</tr>
</table>
	<table>
		<tr>
			<td><input type="submit" value="" class="Export"></td>
		</tr>
	</table>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
 

</body>

</html>
