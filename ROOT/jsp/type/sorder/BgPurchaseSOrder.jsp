<%@page contentType="text/html;charset=UTF-8" %><%@include file="/jsp/Header.jsp"%>
<%
String community=node.getCommunity();
if(!tea.entity.site.Organizer.isOrganizer(community,teasession._rv._strR))
{
response.sendError(403,"对不起，你没有权限查看本页的内容");
return;
}
r.add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/TradeServlet");r.add("/tea/ui/member/order/SaleOrders");

String from =getNull(request.getParameter("from"));
String to =getNull(request.getParameter("to"));
String memberlike=getNull(request.getParameter("memberlike"));
String status=getNull(request.getParameter("tstatus"));


%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT type="">
function ShowCalendar(fieldname)
{
  eval(fieldname).value='';
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</SCRIPT>
</head>
<body><h1><%=r.getString(teasession._nLanguage, "BgPurchaseSOrder")%></h1>
<div id="head6"><img height="6" src="about:blank"></div><br><br>

<FORM NAME="form1" action="/jsp/type/sorder/BgPurchaseSOrder.jsp">
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr><td>ID:<input  NAME="memberlike" value="<%=memberlike%>">
    <td>FROM:
     <input name="from" readonly="" value="<%=from%>" onDblClick="this.value='';" TITLE="双击清空" type="text" size="9">
              <input type="button" name="timeselect" value="..." onClick="ShowCalendar('form1.from')">
<TD>TO:
        <INPUT NAME="to" value="<%=to%>"  ondblclick="this.value='';" TITLE="双击清空"  TYPE="text" SIZE="9" READONLY=""> <input type="button" name="timeselect" value="..." onClick="ShowCalendar('form1.to')">
          <td>STATUS:<SELECT NAME="tstatus">
            <option value="">----不限---</option>
            <%
            for(int index=0;index<tea.entity.node.SOrder.TRADE_STATUS.length;index++)
            {
              %>
                          <option value="<%=index%>" <%=getSelect(status.equals(String.valueOf(index)))%>><%=r.getString(teasession._nLanguage,tea.entity.node.SOrder.TRADE_STATUS[index])%></option>
              <%
            }
            %>
</SELECT><td><input TYPE="SUBMIT" VALUE="GO">

  <tr id=tableonetr>
    <td>订单编号</td>
    <td>下单时间</td>
    <td>合计金额</td>
    <td>订单状态</td>
    <td>会员ID</td>
  </tr>
  <%/*
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
  java.util.Enumeration fs_enumer=null;
if(  tea.entity.site.Organizer.isOrganizer(node.getCommunity(),teasession._rv._strR))
fs_enumer= tea.entity.node.Node.findSons(father);
else
fs_enumer= tea.entity.node.Node.findSons(father,teasession._rv,0,Integer.MAX_VALUE);*/
          StringBuffer sql=new StringBuffer();
          if(from.length()>0)
          sql.append(" AND Node.time>="+tea.db.DbAdapter.cite(from));
          if(to.length()>0)
          sql.append(" AND Node.time<"+tea.db.DbAdapter.cite(to));
          if(status.length()>0)
          sql.append(" AND SOrder.status="+status);
          tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
        try
        {
//          System.out.println("SELECT Node.node FROM Node,SOrder WHERE SOrder.node=Node.node AND Node.type=66  AND Node.rcreator LIKE '%"+memberlike+"%'  "+sql.toString() + " GROUP BY SOrder.status");
          dbadapter.executeQuery("SELECT Node.node FROM Node,SOrder WHERE  Node.finished=1 AND Node.community="+dbadapter.cite(community)+" AND SOrder.node=Node.node AND Node.type=66  AND Node.rcreator LIKE '%"+memberlike+"%'  "+sql.toString() + " ORDER BY SOrder.status");
            while ( dbadapter.next())
            {

int j2=dbadapter.getInt(1);
  tea.entity.node.Node node=tea.entity.node.Node.find(j2);
  tea.entity.node.SOrder trade =  tea.entity.node.SOrder.find(j2,teasession._nLanguage);
  %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" ><!--EditSOrder.jsp-->
    <td><A href="/servlet/Node?node=<%=j2%>" ><%=j2%></A></td>
    <td><%=node.getTimeToString()%></td>
    <td><%=trade.getTotal().add(trade.getAtotal())%></td>
    <td><%=r.getString(teasession._nLanguage,trade.TRADE_STATUS[trade.getStatus()])%></td>
    <td><%=ts.hrefGlance(node.getCreator())%></td>
  </tr>
  <%
            }
        } catch (Exception exception)
        {
          exception.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
%>
</table>
</FORM>

<br><br>
<div id="head6"><img height="6" alt=""></div>
</body>
</html>
