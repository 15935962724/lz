<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.entity.*"%>
<%@ page import="tea.ui.*"%>
<%@ page import="tea.db.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

if(!teasession._rv.isPurchaser())
{
  response.sendError(403);
  return;
}

Resource r = new Resource();
r.add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/SaleOrders").add("/tea/ui/member/order/TradeServlet").add("/tea/ui/member/offer/Offers");

String s = request.getParameter("Type");
if(s==null)s = request.getParameter("type");//不区分大小写

String s1 = request.getParameter("Status");
boolean flag = s == null;
boolean flag1 = s != null && s1 == null;
boolean flag2 = s != null && s1 != null;

String community=teasession._strCommunity;

int type=0;

int pos=0;
String _strPos = request.getParameter("Pos");
if(_strPos!=null)
	pos=Integer.parseInt(_strPos);

StringBuffer sql=new StringBuffer();
sql.append(" AND rcustomer=").append(DbAdapter.cite(teasession._rv._strR));
sql.append(" AND community=").append(DbAdapter.cite(teasession._strCommunity));

StringBuffer param=new StringBuffer();
String _strFrom=request.getParameter("from");
if(_strFrom!=null&&_strFrom.length()>0)
{
	sql.append(" AND time>=").append(DbAdapter.cite(_strFrom));
	param.append("&from=").append(_strFrom);
}
String _strTo=request.getParameter("to");
if(_strTo!=null&&_strTo.length()>0)
{
	sql.append(" AND time<").append(DbAdapter.cite(_strTo));
	param.append("&to=").append(_strTo);
}
String _strStatus=request.getParameter("tstatus");
if(_strStatus!=null&&_strStatus.length()>0)
{
	sql.append(" AND status=").append(_strStatus);
	param.append("&tstatus=").append(_strStatus);
}

int count=Trade.countAll(sql.toString());

sql.append(" ORDER BY time DESC");

//int count=Trade.count(true, teasession._rv, type,community);
%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "PurchaseOrders")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<from name=form1 >
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr><td>时间:<input type=text name=from ><a href=javascript:showCalendar('form1.from');><img src=/tea/image/public/Calendar2.gif></a>-<input type=text name=to ><a href=javascript:showCalendar('form1.to');><img src=/tea/image/public/Calendar2.gif></a></td>
<td>状态:<select name="tstatus">
<option value="" >-----------------
<%
for(int i=0;i<Trade.TRADE_STATUS.length;i++)
{
	out.print("<option value="+i);
	if(String.valueOf(i).equals(_strStatus))
		out.print(" selected ");
	out.print(">"+r.getString(teasession._nLanguage,Trade.TRADE_STATUS[i]));
}
%>
</select>
</td>
<td><input type=submit value=查询 ></td></tr>
</TABLE>
</form>

<h2>列表 ( <%=count%> )</h2>
<%         

%>
  <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
       <tr id="tableonetr">
         <TD width=1></TD>
         <TD>时间</TD>
         <td>订单号</td>
         <TD>状态</TD>
         <TD>总计</TD>
       </tr>
<%
if(count > 0)
{
      for(java.util.Enumeration enumeration=Trade.findAll(sql.toString(),pos,15); enumeration.hasMoreElements(); )
      {
        int j2 = ((Integer)enumeration.nextElement()).intValue();
        Trade trade = Trade.find(j2);
        RV rv = trade.getVendor();
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
          <td width=1><input type=checkbox ></td>
          <td><%=(new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(trade.getTime())%></td>
          <td><%=("<a href=/jsp/order/Purchase"+Trade.TRADE_STATUS[trade.getStatus()]+".jsp?Trade="+j2+" >#"+j2+"</a")%></td>
          <td><%=r.getString(teasession._nLanguage,Trade.TRADE_STATUS[trade.getStatus()])%></td>          
          <td><%=trade.getTotal()%></td>
        </tr>
       <%
	}
}%>
</table>

<%=new tea.htmlx.FPNL(teasession._nLanguage, "?type=" + type + "&Pos=", pos, count,15)%>

<input type=button value=合并订单 > <input type=button value=拆分订单 >

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div>

</body>
</html>
