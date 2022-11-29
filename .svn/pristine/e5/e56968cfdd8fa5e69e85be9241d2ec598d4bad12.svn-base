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
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

String _strTrade=request.getParameter("trade");
String _strStatus=request.getParameter("tstatus");
String _strPaystate=request.getParameter("paystate");
String _strTime_from=request.getParameter("time_from");
String _strTime_to=request.getParameter("time_to");

if(_strTrade!=null&&(_strTrade=_strTrade.trim()).length()>0)
{
  sql.append(" AND trade LIKE ").append(DbAdapter.cite("%"+_strTrade+"%"));
  param.append("&trade=").append(_strTrade);
}

int status=-1;
if(_strStatus!=null&&_strStatus.length()>0)
{
  sql.append(" AND status=").append(_strStatus);
  param.append("&tstatus=").append(_strStatus);
  status=Integer.parseInt(_strStatus);
}
int paystate=-1;
if(_strPaystate!=null&&_strPaystate.length()>0)
{
  sql.append(" AND paystate=").append(_strPaystate);
  param.append("&paystate=").append(_strPaystate);
  paystate=Integer.parseInt(_strPaystate);
}
if(_strTime_from!=null&&(_strTime_from=_strTime_from.trim()).length()>0)
{
  sql.append(" AND time>=").append(DbAdapter.cite(_strTime_from));
  param.append("&time_from=").append(_strTime_from);
}
if(_strTime_to!=null&&(_strTime_to=_strTime_to.trim()).length()>0)
{
  sql.append(" AND time < ").append(DbAdapter.cite(_strTime_to));
  param.append("&time_to=").append(_strTime_to);
}


int count=TradeMember.countLastByMember(teasession._rv.toString(),sql.toString());

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
  form2.action='/jsp/order/EditSaleConfirmed.jsp';
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
<h1><%=r.getString(teasession._nLanguage, "订单回滚")%> 只能对24小时内的订单进行回滚操作</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=get action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>

<h2>查询</h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td width="203">订单:<input type="text" name="trade" value="<%if(_strTrade!=null)out.print(_strTrade);%>"></td>
<td colspan="2">状态:<select name="tstatus"><option value="">----------------</option>
<%
for(int i=0;i<Trade.TRADE_STATUS.length;i++)
{
  out.print("<option value="+i);
  if(i==status)
  {
    out.print(" SELECTED ");
  }
  out.print(">"+r.getString(teasession._nLanguage,Trade.TRADE_STATUS[i]));
}
%>
</select></td>
</tr>
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
  <td>支付:
    <select name="paystate" >
      <option value="">----------------</option>
      <%
for(int i=0;i<Trade.PAYSTATE_TYPE.length;i++)
{
  out.print("<option value="+i);
  if(i==paystate)
  out.print(" selected ");
  out.print(" >"+r.getString(teasession._nLanguage,Trade.PAYSTATE_TYPE[i]));
}
%>
    </select></td>
  <td width="325">时间:
    <input type="text" name="time_from" size="15" value="<%if(_strTime_from!=null)out.print(_strTime_from);%>">
    <img src="/tea/image/public/Calendar2.gif" onClick="showCalendar('form1.time_from');">
    <input type="text" name="time_to" size="15" value="<%if(_strTime_to!=null)out.print(_strTime_to);%>">
    <img src="/tea/image/public/Calendar2.gif" onClick="showCalendar('form1.time_to');"></td>
  <td><input name="submit" type="submit" onClick="" value="查询"/></td>
  </tr>
</table>
</form>
<FORM name=form2 METHOD=POST action="/servlet/EditTrade">
<script>document.write('<input type=hidden name=nexturl value='+location+'>');</script>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="salerollback"/>
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
  if("status".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "状态")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=status"+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "状态")+"</a>");
  }
  out.print("</td><td>");
  if("paystate".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "支付")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=paystate"+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "支付")+"</a>");
  }
  out.print("</td><td>");
  if("time".equals(order))
  {
    out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "Time")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
  }else
  {
    out.print("<A href=?order=time"+param.toString()+pos+" >"+r.getString(teasession._nLanguage, "Time")+"</a>");
  }
  out.print("</td><td>&nbsp;</td></tr>");

Enumeration e=TradeMember.findLastByMember(teasession._rv._strV,sql.toString(),pos,20);
for(int i=1;e.hasMoreElements();i++)
{
  String trade=(String)e.nextElement();
  //Trade obj=Trade.find(trade);
  //RV rv=obj.getCustomer();
  //Profile p=Profile.find(rv._strR);

  int id=TradeMember.getLast(trade);
  TradeMember tm=TradeMember.find(id);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=i%></td>
    <td nowrap><a href="/jsp/order/ViewTrade.jsp?trade=<%=trade%>" ><%=trade%></a></td>
    <td nowrap><%=r.getString(teasession._nLanguage,Trade.TRADE_STATUS[tm.getStatus()])%></td>
    <td nowrap><%=r.getString(teasession._nLanguage,Trade.PAYSTATE_TYPE[tm.getPaystate()])%></td>
    <td nowrap><%=tm.getTime()%></td>
    <td>
    <%
    if(teasession._rv.toString().equals(tm.getMember()))
    {
      out.print("<input type=button value=回滚 onClick=\"if(confirm('确认回滚?')){ form2.trade.value='"+trade+"'; form2.submit(); }\">");
    }
    %>
    </td>
  </tr>
<%
}
%>
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
  <td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count,20)%></td></tr>
</table>

</FORM>

<div id="head6"><img height="6" src="about:blank"></div>

<div id="jspafter" style="display:none">
<script>if(top.location==self.location)jspafter.style.display='';</script>
<%=community.getJspAfter(teasession._nLanguage)%>
</div>

</body>
</html>



