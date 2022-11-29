<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
//tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
//tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String from =getNull(request.getParameter("from"));
String to =getNull(request.getParameter("to"));
String memberlike=getNull(request.getParameter("memberlike"));

String community=node.getCommunity();
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT>
function ShowCalendar(fieldname)
{
  if(window.showModalDialog)
  {
    myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
    mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
    window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
  }else
  {
    window.open("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,"","height=205,width=280,left=600,top=400,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes");
  }
}</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "客户消费管理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<FORM NAME="form1">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
  if(request.getParameter("id")!=null)
  out.print("<input type=hidden name=id value="+request.getParameter("id")+" >");
  %>
  <tr>
    <td>ID:<input  NAME="memberlike" value="<%=memberlike%>"></td>
      <td>FROM:
        <input name="from" readonly="" value="<%=from%>" ondblclick="this.value='';" TITLE="双击清空"   type="text" size="9">
        <input type="button" name="timeselect" value="..." onClick="ShowCalendar('form1.from')"></td>
        <TD>TO: <INPUT NAME="to" value="<%=to%>" ondblclick="this.value='';" TITLE="双击清空"   TYPE="text" SIZE="9" READONLY="">
          <input type="button" name="timeselect" value="..." onClick="ShowCalendar('form1.to')"></td>
          <td><input TYPE="SUBMIT" VALUE="GO"></td>
  </tr>
</table>
</FORM>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id=tableonetr>
    <td>用户ID</td><td>姓名</td>
    <td>累计消费次数</td>
    <td>累计消费金额</td>
        <td>积分</td>
    <td>余额</td>
    <td>最后消费时间</td>
  </tr>
  <%
  tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();

  try
  {
    StringBuffer sql=new StringBuffer();
    if(from.length()>0)
    sql.append(" AND SOrder.signtime>="+dbadapter.cite(from));
    if(to.length()>0)
    sql.append(" AND SOrder.signtime<"+dbadapter.cite(to));

    dbadapter.executeQuery("SELECT Node.rcreator,COUNT(*),SUM(cash+ABS(subtract)) FROM SOrder,Node WHERE Node.community="+dbadapter.cite(community)+" AND Node.node=SOrder.node AND status=3 AND Node.rcreator LIKE '%"+memberlike+"%'  "+sql.toString() + " GROUP BY Node.rcreator");
    while (dbadapter.next())
    {
      String member=dbadapter.getString(1);
      tea.entity.member.SClient sclient=tea.entity.member.SClient.find(community,member);
      tea.entity.member.Profile profile=tea.entity.member.Profile.find(member);

      //member=new String(member.getBytes("ISO-8859-1"));
      %>
      <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
        <td><A href="/jsp/type/sorder/PurchaseSOrder.jsp?member="><%=member%></A></td>
        <td><%=profile.getFirstName(teasession._nLanguage)%></td>
        <td><%=dbadapter.getInt(2)%></td>
        <td><%=dbadapter.getBigDecimal(3,2)%></td>
        <td><%=sclient.getPoint()%></td>
        <td><%=sclient.getPrice()%></td>
        <TD><%=sclient.getLastTime()%></td>
      </tr>
      <%
      }
    } catch (Exception exception1)
    {
      exception1.printStackTrace();
    } finally
    {
      dbadapter.close();
    }
    %>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
