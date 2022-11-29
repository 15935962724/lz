<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
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
sql.append(" AND rcustomer=").append(DbAdapter.cite(teasession._rv._strR));
sql.append(" AND vcustomer=").append(DbAdapter.cite(teasession._rv._strV));
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

String _strTrade=request.getParameter("trade");
String _strPrice_from=request.getParameter("price_from");
String _strPrice_to=request.getParameter("price_to");
String _strDefray=request.getParameter("defray");
String _strStatus=request.getParameter("tstatus");
if(_strTrade!=null&&(_strTrade=_strTrade.trim()).length()>0)
{
  sql.append(" AND trade LIKE ").append(DbAdapter.cite(_strTrade));
  param.append("&trade=").append(_strTrade);
}
boolean _bPf=_strPrice_from!=null&&(_strPrice_from=_strPrice_from.trim()).length()>0;
boolean _bPt=_strPrice_to!=null&&(_strPrice_to=_strPrice_to.trim()).length()>0;
if(_bPf||_bPt)
{
  sql.append(" AND trade IN ( SELECT trade FROM tradeitem WHERE 1=1 ");
  if(_bPf)
  {
    sql.append(" AND price>=").append(_strPrice_from);
    param.append("&price_from=").append(java.net.URLEncoder.encode(_strPrice_from,"UTF-8"));
  }
  if(_bPt)
  {
    sql.append(" AND price<").append(_strPrice_to);
    param.append("&price_to=").append(java.net.URLEncoder.encode(_strPrice_to,"UTF-8"));
  }
  sql.append(")");
}
int defray=-1;
if(_strDefray!=null&&_strDefray.length()>0)
{
  sql.append(" AND defray=").append(_strDefray);
  param.append("&defray=").append(_strDefray);
  defray=Integer.parseInt(_strDefray);
}
int tstatus=-1;
if(_strStatus!=null&&_strStatus.length()>0)
{
  sql.append(" AND status=").append(_strStatus);
  param.append("&tstatus=").append(_strStatus);
  tstatus=Integer.parseInt(_strStatus);
}

param.append("&pos=");

Resource r=new Resource("/tea/ui/member/offer/Offers");

Community community=Community.find(teasession._strCommunity);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null&&_strPos.length()>0)
{
  pos=Integer.parseInt(_strPos);
}

int count=Trade.count(teasession._strCommunity,sql.toString());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_edit(t)
{


  form2.action='/jsp/order/EditPurchaseOrder.jsp';
  form2.method='GET';
  form2.trade.value=t;
  form2.submit();
}
</script>
</head>
<body id="bodynone">

<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>

<div id="tablebgnone">
<h1><%=r.getString(teasession._nLanguage, " 我的购买单")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=get action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>

<h2>查询</h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
<tr>
  <td>订单:<input type="text" name="trade" value="<%if(_strTrade!=null)out.print(_strTrade);%>"/></td>
  <td colspan="2" nowrap="nowrap">价格:<input type="text" name="price_from" size="8" value="<%if(_bPf)out.print(_strPrice_from);%>"/>
    <input type="text" name="price_to" size="8" value="<%if(_bPt)out.print(_strPrice_to);%>"/></td>
    <td>状态:<select name="tstatus" >
<option value="">----------------</option>
<%
for(int i=0;i<Trade.TRADE_STATUS.length;i++)
{
  out.print("<option value="+i);
  if(i==tstatus)
  out.print(" selected ");
  out.print(" >"+r.getString(teasession._nLanguage,Trade.TRADE_STATUS[i]));
}
%>
</select></td>
<td><input type="submit" value="查询" onclick=""/></td>
</tr>
<%--<tr>
  <td>支付方式:<select name="defray" >
<option value="">----------------</option>
<%
for(int i=0;i<Trade.DEFRAY_TYPE.length;i++)
{
  out.print("<option value="+i);
  if(i==defray)
  out.print(" selected ");
  out.print(" >"+Trade.DEFRAY_TYPE[i]);
}
%>
</select></td>


</tr>--%>
</table>
</form>

<FORM name=form2 METHOD=POST action="/servlet/EditTrade">
<script>document.write('<input type=hidden name=nexturl value='+location+'>');</script>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="salecancelorder"/>
<input type="hidden" name="trade" value=""/>

<h2>列表 <%=count%></h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
  <tr ID=tableonetr>
    <td width="1"><input type="checkbox" onclick="selectAll(form2.trades,this.checked);"/></td>
    <td>订单号</td>
    <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "总价")%></TD>
    <td>积分</td>
    <TD>支付方式</TD>
    <TD><%=r.getString(teasession._nLanguage, "状态")%></TD>
    <td></td>
  </tr>
<%
Enumeration e=Trade.find(teasession._strCommunity,sql.toString(),pos,20);
while(e.hasMoreElements())
{
  String trade=(String)e.nextElement();
  Trade obj=Trade.find(trade);



  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><input type="checkbox" name="trades" value="<%=trade%>"/></td>
    <td nowrap><a href="/jsp/order/ViewTrade.jsp?trade=<%=trade%>" ><%=trade%></a></td>
    <td nowrap><%=obj.getTimeToString()%></td>
    <td><%=TradeItem.sumByTrade(trade)%></td>
    <td><%=obj.getPoint()%></td>
    <td><%=Trade.DEFRAY_TYPE[obj.getDefray()]%></td>
    <td><%=r.getString(teasession._nLanguage,Trade.TRADE_STATUS[obj.getStatus()])+" "+Trade.PAYSTATE_TYPE[obj.getPaystate()]%></td>
    <td>
    <%
    if(obj.getStatus()<Trade.TRADES_CONFIRMED&&obj.getPaystate()<1)//如果地址和财务都没有确认
    {
      out.print("<input type=button value=详细 onclick=f_edit('"+trade+"');>");
    }
    if(obj.getPaystate()==0)//没有支付
    {
      out.print("<input type=button value=支付 onclick=\"window.open('/jsp/offer/CheckoutCart3.jsp?community="+teasession._strCommunity+"&trade="+trade+"','_self');\">");
    }
    %>
    </td>
  </tr>
<%
}
%>
<tr>
  <td width="1"><input type="checkbox" onclick="selectAll(form2.trades,this.checked);"/></td>
  <td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,20)%></td></tr>
</table>

</FORM>

<div id="head6"><img height="6" src="about:blank"></div>

<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
<script>
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}
</script>

</body>
</html>
