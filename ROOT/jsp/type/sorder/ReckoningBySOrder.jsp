<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String from=getNull(request.getParameter("from"));
String to=getNull(request.getParameter("to"));
String memberlike=getNull(request.getParameter("memberlike"));
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script type="">
function td_calendar(fieldname)
{
  eval(fieldname).value='';
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ReckoningBySOrder")%></h1>
<div id="head6"><img height="6" src="about:blank"></div><br>
<form name="form1" method="get" action="">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr><td>ID:<input  NAME="memberlike" value="<%=memberlike%>">
    <td>开始日期</td>
    <td><input name="from" value="<%=(from)%>"  ondblclick="this.value='';" TITLE="双击清空"  readonly="" type="text" size="10"><input name="" type="button" onClick="td_calendar('form1.from');" id="我叫小刘" value="..." ></td>
    <td>结束日期</td>
    <td><input name="to" value="<%=(to)%>"   ondblclick="this.value='';" TITLE="双击清空"  type="text"  readonly=""size="10"><input name="" type="button" id="" value="..."  onClick="td_calendar('form1.to');" ></td>
    <td><input type="submit" name="Submit" value="提交"></td>
  </tr>
<tr id="tableonetr">
     <td>作业员</td>
      <td>订单号</td>
      <td>作业员人数</td>
    <td>总计</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <%
tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
tea.db.DbAdapter dbadapter2 = new tea.db.DbAdapter();
try
{
  StringBuffer sql=new StringBuffer();
  if(from.length()>0)
  sql.append(" AND SOrder.signtime>="+dbadapter.cite(from));
  if(to.length()>0)
  sql.append(" AND SOrder.signtime<"+dbadapter.cite(to));
    dbadapter.executeQuery("SELECT node FROM Waiter WHERE code like "+dbadapter.cite("%"+memberlike+"%"));
      while(dbadapter.next())
      {
        int waiter=dbadapter.getInt(1);
        dbadapter2.executeQuery("SELECT DISTINCT Node.node FROM SOrder,Node WHERE Node.node=SOrder.node AND status=3 AND (SOrder.waiterfigure="+waiter+" OR SOrder.waiter LIKE '%/"+waiter+"/%')"+sql.toString());
        while (dbadapter2.next())
        {
          SOrder obj=SOrder.find(dbadapter2.getInt(1),teasession._nLanguage);
          String waiter_list=obj.getWaiter();

          int i=obj.getWaiter().split("/").length;
          if(i>0)i--;
          %>
<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
    <td><%=tea.entity.node.Waiter.find(waiter,teasession._nLanguage).getCode()%></td>
    <td><a href="BgFinishedSOrder.jsp?node=<%=obj.getNode()%>"><%=obj.getNode()%></A></td>
    <td><%=i%></td>
    <td ><%=getNull(obj.getTotal().add(obj.getAtotal()))%></td>
    <td>&nbsp;</td>
    </tr>
    <%}
  }
  }catch(java.lang.Exception e)
{}finally{
dbadapter.close();
dbadapter2.close();
}%>
</table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

