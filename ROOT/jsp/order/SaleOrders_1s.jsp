<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String _strId=request.getParameter("id");

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);


String trades= teasession.getParameter("trades");
if(trades!=null && trades.length()>0)
{
  trades = trades.trim();
  sql.append(" and trade like "+DbAdapter.cite("%"+trades+"%")+"");
  param.append("&trades=").append(trades);
}

String members = teasession.getParameter("members");
if(members!=null && members.length()>0)
{
  members = members.trim();
  sql.append(" and rvendor in (select member from ProfileLayer where lastname like "+DbAdapter.cite("%"+members+"%")+" or firstname like "+DbAdapter.cite("%"+members+"%")+" ) ");
  param.append("&members = ").append(members);
}

String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND time >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}


int pos = 0, pageSize = 30, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Trade.count(teasession._strCommunity,sql.toString());

sql.append(" order by time desc ");
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">

</script>
</head>
<body id="bodynone">




<h1>订单管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=get action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>

<h2>查询</h2>
<table cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>订单号:<input type="text" name="trades" value="<%if(trades!=null)out.print(trades);%>"/></td>
   <td>下单会员:<input type="text" name="members" value="<%if(members!=null)out.print(members);%>"/></td>

 <tr>
 <td>
从&nbsp; <input name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>">
<A href="###"><img onclick="showCalendar('form1.time_c');" src="/tea/image/public/Calendar2.gif" align="top"/></a> &nbsp;到&nbsp;
<input name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>">
<A href="###"><img onclick="showCalendar('form1.time_d');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
 </td>
<td><input type="submit" value="查询"></td>
</tr>
</table>


<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="saleneworder"/>
<input type="hidden" name="trade" value="0"/>

<h2>列表 (目前的订单记录是&nbsp;<font color="#000" size="3"><%=count%></font>&nbsp;条)</h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
  <tr ID=tableonetr>
    <td nowrap>订单号</td>
    <TD>下单时间</TD>
    <TD>下单会员</TD>
    <TD>下单总价</TD>
    <td>操作</td>
  </tr>
<%


Enumeration e=Trade.find2(teasession._strCommunity,sql.toString(),pos,pageSize);
  if(!e.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
   }
while(e.hasMoreElements())
{
  String trade=(String)e.nextElement();
  Trade obj=Trade.find(trade);

  Profile p=Profile.find(obj.getCustomer().toString(),teasession._strCommunity);//obj.getTradeCode()
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td nowrap><a href="/jsp/order/ViewTrade2.jsp?trade=<%=trade%>" ><%=trade%></a></td>
    <td nowrap><%=obj.getTimeToString()%></td>
    <td><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%></td>
    <td><%=TradeItem.sumByTrade(trade)%></td>

    <td><input type=button value="详细" onclick="window.open('/jsp/order/ViewTrade2.jsp?trade=<%=trade%>','_self');">
    </td>
  </tr>
<%
}
%>
  <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
</table>

</FORM>

<div id="head6"><img height="6" src="about:blank"></div>


</body>
</html>

