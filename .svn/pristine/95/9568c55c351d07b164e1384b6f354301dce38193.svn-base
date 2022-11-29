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
<%@page import="java.net.URLEncoder"%>
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


String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer(" and (type = 1 or type = 3 or type = 4 ) and ( frontreartype = 0 or frontreartype = 2)");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

//订单号
String ordersid = teasession.getParameter("ordersid");
if(ordersid!=null && ordersid.length()>0)
{
	sql.append(" and ordersid =").append(DbAdapter.cite(ordersid));
	param.append("&ordersid=").append(ordersid);
}
//演出
int perform =0;
if(teasession.getParameter("perform")!=null && teasession.getParameter("perform").length()>0)
{
	perform = Integer.parseInt(teasession.getParameter("perform"));	
}
if(perform>0)
{
	sql.append(" and psid in (select psid from PerformStreak where node ="+perform+" ) ");
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
	sql.append(" and psid = "+performstreak);
	param.append("&performstreak=").append(performstreak);
}
//姓名
String names = teasession.getParameter("names");
if(names!=null && names.length()>0)
{
	sql.append(" and names like ").append(DbAdapter.cite("%"+names+"%"));
	param.append("&names=").append(URLEncoder.encode(names,"UTF-8"));
}
//证件号
String zjhm = teasession.getParameter("zjhm");
if(zjhm!=null && zjhm.length()>0)
{
	sql.append(" and zjhm = ").append(DbAdapter.cite(zjhm));
	param.append("&zjhm=").append(zjhm);
}
//手机
String yddh = teasession.getParameter("yddh");
if(yddh!=null && yddh.length()>0)
{
	sql.append(" and yddh = ").append(DbAdapter.cite(yddh));
	param.append("&yddh=").append(yddh);
}
//是否非会员
int membertype = -1;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
	membertype = Integer.parseInt(teasession.getParameter("membertype"));
	sql.append(" and membertype =").append(membertype);
	param.append("&membertype=").append(membertype);
}



int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos")); 
}
count = PerformOrders.count(teasession._strCommunity,sql.toString());



sql.append(" order by times desc ");


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>订单管理</title>
</head>

<body id="bodynone" onLoad="f_onload();" >
<script>
function f_onload()
{
	f_perform();
	
}
//选择演出 显示场次
function f_perform()
{
	      sendx("/jsp/type/perform/PerformOrders_ajax.jsp?acttype=OrderPiaoList&act=TicketStatistice_f_perform&perform="+form1.perform.value+"&community="+form1.community.value+"&performstreak=<%=performstreak%>",
		  function(data)
		  {
		    document.getElementById("showxx").innerHTML=data.trim();
		  }
		  );
}
</script>

<h1>订单管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" action="?" method="POST">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
  <table border="0" cellpadding="0" cellspacing="0" id="tableSearch">
    <tr>
    	<td>订 单 号：&nbsp;<input type="text" name="ordersid" value="<%if(ordersid!=null)out.print(ordersid); %>"></td>
    	<td>演　出：&nbsp;<select name="perform" onChange="f_perform();">
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
      </td>
    	<td>场次：&nbsp;<span id ="showxx">
  				<select name="performstreak" ><option value=0>--选择场次--</option></select>
  			</span></td>
     </tr>
     <tr>
     	<td>姓　　名：&nbsp;<input type="text" name="names" value="<%if(names!=null)out.print(names); %>"></td>
     	<td>证件号：&nbsp;<input type="text" name="zjhm" value="<%if(zjhm!=null)out.print(zjhm); %>"></td>
     	<td>手机：&nbsp;<input type="text" name="yddh" value="<%if(yddh!=null)out.print(yddh); %>"></td>
     </tr>
     <tr>
     	<td colspan="3">是否会员：&nbsp;<select name="membertype">
     			<option value="">--请选择--</option>
     			<option value="1" <%if(membertype==1)out.print(" selected "); %>>-是会员-</option>
  			   <option value="0" <%if(membertype==0)out.print(" selected "); %>>-非会员-</option>
     		</select>
     	</td>
     </tr>
     <tr>
     	<td colspan="3" align="center"><input type="submit" value="" class="QueryOrder"></td>
     </tr>
  </table>
  </form>
  
  <form name="form2" action="/servlet/ExportPerformExcel" method="POST">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
    <input type="hidden" name="files" value="订单管理表">
    <input type="hidden" name="act" value="OrderPiaoList">
	<input type="hidden" name="sql" value="<%=sql.toString() %>">
	
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR id="tableonetr">
      <TD nowrap>序号</TD>
      <TD nowrap>订单号</TD>
      <TD nowrap>姓名</TD>
      <TD nowrap>手机</TD>
      <TD nowrap>电话</TD>
      <TD nowrap>证件</TD>
      <TD nowrap>证件号</TD>
      <TD nowrap>数量</TD>
      <TD nowrap>总价</TD>
      <TD nowrap>操作</TD>
    </TR>
   <%
   		int countod = 0;//订单中有多少个票
   		BigDecimal tp = new BigDecimal("0");
   	  Enumeration pen = PerformOrders.find(teasession._strCommunity,sql.toString(),pos,pageSize);
      if(!pen.hasMoreElements())
      {
          out.print("<tr><td colspan=10 align=center>暂无订单号记录</td></tr>");
      }
      	for(int i =1;pen.hasMoreElements();i++)
      	{
      		String poid = ((String)pen.nextElement());
      		PerformOrders  poobj = PerformOrders.find(poid); 
      		countod = countod + OrderDetails.count(teasession._strCommunity," and orderid = "+poid);
      		tp = tp.add(poobj.getTotalprice().add(new BigDecimal(poobj.getFare())));
      		
   %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td width="1"><%=i+pos %></td>
        <td><%=poid %></td>
        <td><%=poobj.getNames() %></td>
        <td><%=poobj.getYddh() %></td>
        <td><%=poobj.getGddh() %></td>
        <td><%=PerformOrders.ZJLX_TYPE[poobj.getZjlx()] %></td>
        <td><%=poobj.getZjhm() %></td>
        <td><%=poobj.getQuantity() %></td>
        <td><%=poobj.getTotalprice().add(new BigDecimal(poobj.getFare())) %>&nbsp;元</td>
        <td><a href="/jsp/type/perform/OrderPiaoShow.jsp?poid=<%=poid %>"><img src="/res/REDCOME/0911/0911992.gif"></a></td>
      </tr>
    <%} %>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
	
	<table>
		<tr>
			<td>合计：&nbsp;<%=count %>&nbsp;张订单&nbsp;&nbsp;共预定&nbsp;<%=countod %>&nbsp;张票&nbsp;&nbsp;总金额：&nbsp;<%=tp %>&nbsp;元</td>
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
