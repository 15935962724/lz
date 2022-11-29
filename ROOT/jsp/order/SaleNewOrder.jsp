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
sql.append(" AND status=").append(Trade.TRADES_NEW);

StringBuffer param=new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

String _strTrade=request.getParameter("trade");
String _strPrice_from=request.getParameter("price_from");
String _strPrice_to=request.getParameter("price_to");
if(_strTrade!=null&&(_strTrade=_strTrade.trim()).length()>0)
{
  sql.append(" AND trade LIKE ").append(DbAdapter.cite("%"+_strTrade+"%"));
  param.append("&trade=").append(_strTrade);
}
boolean _bPf=_strPrice_from!=null&&(_strPrice_from=_strPrice_from.trim()).length()>0;
boolean _bPt=_strPrice_to!=null&&(_strPrice_to=_strPrice_to.trim()).length()>0;
if(_bPf||_bPt)
{
  if(_bPf)
  {
    sql.append(" AND total>=").append(_strPrice_from);
    param.append("&price_from=").append(java.net.URLEncoder.encode(_strPrice_from,"UTF-8"));
  }
  if(_bPt)
  {
    sql.append(" AND total<").append(_strPrice_to);
    param.append("&price_to=").append(java.net.URLEncoder.encode(_strPrice_to,"UTF-8"));
  }
}

int count=Trade.count(teasession._strCommunity,sql.toString());

String order=request.getParameter("order");
if(order==null)
order="trade";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

param.append("&pos=");

Resource r=new Resource("/tea/ui/member/offer/Offers");

Community community=Community.find(teasession._strCommunity);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null&&_strPos.length()>0)
{
  pos=Integer.parseInt(_strPos);
}



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
  form2.action="/jsp/order/EditSaleNewOrder.jsp";
  form2.method='GET';
  form2.trade.value=t;
  form2.submit();
}
</script>
</head>
<body id="bodynone">

<div id="jspbefore" style="display:none">
<script>if(top.location==self.location)jspbefore.style.display='';</script>
<%=community.getJspBefore(teasession._nLanguage)%>
</div>

<div id="tablebgnone">
<h1><%=r.getString(teasession._nLanguage, "等待收货地址确认")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=get action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>

<h2>查询</h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td>订单:<input type="text" name="trade" value="<%if(_strTrade!=null)out.print(_strTrade);%>"></td>
<td>价格:<input type="text" name="price_from" value="<%if(_bPf)out.print(_strPrice_from);%>" onKeyPress="inputFloat();"> <input type="text" name="price_to" value="<%if(_bPt)out.print(_strPrice_to);%>" onKeyPress="inputFloat();"></td>
<td><input type="submit" value="查询" onClick=""/></td>
</tr>
</table>
</form>
<FORM name=form2 METHOD=POST action="/servlet/EditTrade">
<script>document.write('<input type=hidden name=nexturl value='+location+'>');</script>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="saleneworder"/>
<input type="hidden" name="trade" value=""/>

<h2>列表 <%=count%></h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
<%
  out.print("<tr ID=tableonetr><td width=1>&nbsp;</td><td>");
  if("trade".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >订单号 "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=trade"+param.toString()+pos+" >订单号</a>");
  }
  out.print("</td><td>");
  if("time".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "Time")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=time"+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "Time")+"</a>");
  }
  out.print("</td><td>");
  if("vcustomer".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "会员")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=vcustomer"+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "会员")+"</a>");
  }
  out.print("</td><td>");
  if("total".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "总价")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=total"+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "总价")+"</a>");
  }
  out.print("</td><td>");
  if("paystate".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "支付状态")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=paystate"+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "支付状态")+"</a>");
  }
  out.print("</td><td>");
  if("city".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "地址")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=city"+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "地址")+"</a>");
  }
  out.print("</td><td>&nbsp;</td></tr>");

Enumeration e=Trade.find(teasession._strCommunity,sql.toString(),pos,20);
while(e.hasMoreElements())
{
  String trade=(String)e.nextElement();
  Trade obj=Trade.find(trade);
  RV rv=obj.getCustomer();
  Profile p=Profile.find(rv._strR);//obj.getTradeCode()
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><input type="checkbox" name="trades" value="<%=trade%>"/></td>
    <td nowrap><a href="/jsp/order/ViewTrade.jsp?trade=<%=trade%>" ><%=trade%></a></td>
    <td nowrap><%=obj.getTimeToString()%></td>
    <td><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%></td>
    <td><%=obj.getTotal()%></td>
    <td><%=Trade.PAYSTATE_TYPE[obj.getPaystate()]%></td>
    <td><%=obj.getCityToString(teasession._nLanguage)%>　</td>
    <td><input type=button value="详细" onClick="f_edit('<%=trade%>');"></td>
  </tr>
<%
}
%>
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
  <td colspan="2" ><input type="checkbox" onClick="selectAll(form2.trades,this.checked);"/>全选</td>
  <td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count,20)%></td></tr>
</table>
<input type="submit" value="审核已选中的订单" onClick="return submitCheckbox(form2.trades,'请选中要审核的订单.');"/>
</FORM>

<div id="head6"><img height="6" src="about:blank"></div>

<div id="jspafter" style="display:none">
<script>if(top.location==self.location)jspafter.style.display='';</script>
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



