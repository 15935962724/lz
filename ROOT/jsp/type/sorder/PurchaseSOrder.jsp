<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/TradeServlet");r.add("/tea/ui/member/order/SaleOrders");
String from =getNull(request.getParameter("from"));
String to =getNull(request.getParameter("to"));
String tstatus=getNull(request.getParameter("tstatus"));
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">


<SCRIPT>
function ShowCalendar(fieldname)
{
  eval(fieldname).value='';
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}</SCRIPT>

<h1><%=r.getString(teasession._nLanguage, "我的订单")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


  <FORM NAME="form1" action="">
  <%
  if(request.getParameter("id")!=null)
  out.print("<input type=hidden name=id value="+request.getParameter("id")+" >");
  %>

<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter" >

<tr>
    <td>FROM:
     <input name="from" readonly="" value="<%=from%>" onDblClick="this.value='';" TITLE="双击清空" type="text" size="9">
              <input type="button" name="timeselect" value="..." onClick="ShowCalendar('form1.from')">
</td><TD>TO:
        <INPUT NAME="to" value="<%=to%>"  ondblclick="this.value='';" TITLE="双击清空"  TYPE="text" SIZE="9" READONLY="">
          <input type="button" name="timeselect" value="..." onClick="ShowCalendar('form1.to')">
</td>          <td>状态:<SELECT NAME="tstatus">
            <option value="">----不限---</option>
            <%
            for(int index=0;index<tea.entity.node.SOrder.TRADE_STATUS.length;index++)
            {
              %>
                          <option value="<%=index%>" <%=getSelect(tstatus.equals(String.valueOf(index)))%>><%=r.getString(teasession._nLanguage,tea.entity.node.SOrder.TRADE_STATUS[index])%></option>
              <%
            }
            %>
</SELECT></td>
<td><input TYPE="SUBMIT" VALUE="GO"></td>

    </table> </FORM>
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter" >
  <tr id="tableonetr">
    <td>订单编号</td>
    <td>下单时间</td>
    <td>合计金额</td>
    <td>当前状态</td>
    <td>&nbsp;</td>
  </tr>
  <%
  int father=0;
  java.util.Enumeration enumer=  tea.entity.node.Node.findByType(1,node.getCommunity());
  while(enumer.hasMoreElements())
  {
    int fbt_node=((Integer)  enumer.nextElement()).intValue();
    if(tea.entity.node.Category.find(fbt_node).getCategory()==66)//服务订单
    {
      father=fbt_node;
      break;
    }
  }
  if(father==0)
  {
    out.print(new tea.html.Script("alert('请通知管理员,没有创建服务订单的类别.');history.back();"));
    return;
  }
  //RV rv;
  String member=request.getParameter("member");
  if(member==null)
  member=teasession._rv._strR;
  else
  {
    tea.entity.admin.Conductor con=tea.entity.admin.Conductor.find(member,node.getCommunity());
    if(!con.isExists())
    {
      response.sendError(403);
      return;
    }
  }
// java.util.Enumeration fs_enumer=null;
//fs_enumer= tea.entity.node.Node.findSons(father,rv,0,Integer.MAX_VALUE);
//  for(java.util.Enumeration enumeration =tea.entity.node.SOrder.find(teasession._rv,k,l1,25); enumeration.hasMoreElements(); )
//while(fs_enumer.hasMoreElements())
//{
  tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
  try
  {
    StringBuffer sql=new StringBuffer();
    if(from.length()>0)
    {
      sql.append(" AND Node.time>="+dbadapter.cite(from));
    }

    if(to.length()>0)
    {
      sql.append(" AND Node.time<="+dbadapter.cite(to));

    }
    if(tstatus.length()>0)
    {
      sql.append(" AND SOrder.status="+dbadapter.cite(tstatus));
    }
    dbadapter.executeQuery("SELECT Node.node FROM Node,SOrder WHERE  Node.finished=1 AND Node.community="+dbadapter.cite(node.getCommunity())+" AND  SOrder.node=Node.node AND Node.type=66  AND Node.rcreator = "+dbadapter.cite(member)+sql.toString()+" ORDER BY SOrder.status");
  // out.print("SELECT Node.node FROM Node,SOrder WHERE  Node.finished=1 AND Node.community="+dbadapter.cite(node.getCommunity())+" AND  SOrder.node=Node.node AND Node.type=66  AND Node.rcreator = "+dbadapter.cite(member)+sql.toString()+" ORDER BY SOrder.status");
    while ( dbadapter.next())
    {
      int j2 = dbadapter.getInt(1);//((Integer)fs_enumer.nextElement()).intValue();
      tea.entity.node.Node node=tea.entity.node.Node.find(j2);
      tea.entity.node.SOrder trade =  tea.entity.node.SOrder.find(j2,teasession._nLanguage);
      //  tea.entity. RV rv = trade.getVendor();
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
        <td><%//=ts.hrefGlance(rv)%><A href="/servlet/Node?node=<%=j2%>" ><%=j2%><%//=trade.getID()%></A></td>
        <td><%=node.getTimeToString()%></td>
        <!--td><A href="/servlet/Trade?Trade=<%=j2%>">#<%=j2%></A> </td-->
        <td><%=trade.getTotal().toString()%></td>
        <td><%=r.getString(teasession._nLanguage,trade.TRADE_STATUS[trade.getStatus()])%></td>
        <td>&nbsp;<%
        if(trade.getStatus()==0)
        {
          %>
          <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('/jsp/type/sorder/EditSOrder.jsp?node=<%=j2%>');"/>
          <%
        }
        %></td>
      </tr>
      <%}
    }finally
    {
      dbadapter.close();
    }
  %>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
