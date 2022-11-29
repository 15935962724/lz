<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.*"  %><%@ page import="java.util.*"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");

java.util.Calendar c=java.util.Calendar.getInstance();

String fy=request.getParameter("fromYear");
Date from;
if(fy!=null)
from=Node.sdf.parse(fy+"-"+request.getParameter("fromMonth")+"-"+request.getParameter("fromDay"));
else
{
  c.set(c.MONTH,c.get(c.MONTH)-1);
  from=c.getTime();
}

String ey=request.getParameter("endYear");
Date end;
if(ey!=null)
end=Node.sdf.parse(ey+"-"+request.getParameter("endMonth")+"-"+request.getParameter("endDay"));
else
{
  end=new java.util.Date();
}
java.math.BigDecimal total=null;
java.util.Hashtable h=new java.util.Hashtable();
c.setTime(end);
DbAdapter db=new DbAdapter();
//System.out.println("SELECT SUM(ti.price*ti.squantity) FROM TradeItem ti INNER JOIN Trade t ON ti.trade=t.trade WHERE t.community="+db.cite(community)+" AND t.status="+Trade.TRADES_FINISHED);
try
{
  total=db.getBigDecimal("SELECT SUM(ti.price*ti.squantity) FROM TradeItem ti INNER JOIN Trade t ON ti.trade=t.trade WHERE t.community="+db.cite(community)+" AND t.status="+Trade.TRADES_FINISHED,2);

  db.executeQuery("SELECT SUM(ti.price*ti.squantity),DATEDIFF (dd,t.time,"+db.cite(end)+") FROM TradeItem ti INNER JOIN Trade t ON ti.trade=t.trade WHERE t.community="+db.cite(community)+" AND t.status="+Trade.TRADES_FINISHED+" AND t.time>="+db.cite(from)+" AND t.time<"+db.cite(end)+" GROUP BY DATEDIFF (dd,t.time,"+db.cite(end)+" )");
  while(db.next())
  {
    java.math.BigDecimal sum=db.getBigDecimal(1,2);
    int time=db.getInt(2);
    c.setTime(end);
    c.set(c.DAY_OF_YEAR,c.get(c.DAY_OF_YEAR)-time);
    h.put(c.getTime(),sum);
  }
}finally
{
  db.close();
}


if(total==null)
total=new java.math.BigDecimal("0.00");

  %><html>
    <head>
      <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
      <script src="/tea/tea.js" type="text/javascript"></script>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
          <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
            <META HTTP-EQUIV="Expires" CONTENT="0">
  </head>
  <body>

  <h1>统计</h1>
  <div id="head6"><img height="6" src="about:blank"></div>

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr><td>销售统计:</td><td><%=total%></td></tr>
    </table>

    <form action="<%=request.getRequestURI()%>">
    <input type="hidden" name="community" value="<%=community%>"/>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr><td>从:<%=new tea.htmlx.TimeSelection("from", from)%></td><td>到:<%=new tea.htmlx.TimeSelection("end", end)%></td><td><input type="submit" value="GO"/></td></tr>
    </table>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <%
    total=new java.math.BigDecimal("0.00");
    for(c.setTime(from);c.getTime().getTime()<end.getTime();c.set(c.DAY_OF_YEAR,c.get(c.DAY_OF_YEAR)+1))
    {
      out.print("<tr onmouseover=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' ><td>"+Node.sdf.format(c.getTime())+"</td>");
      java.math.BigDecimal sum=(java.math.BigDecimal)h.get(c.getTime());
      if(sum==null)
      sum=new java.math.BigDecimal("0.00");
      else
      total=total.add(sum);
      out.print("<td>"+sum+"</td>");
    }
    %>
    <tr><td></td><td><%=total%></td></tr>
    </table>
    </form>
    <br>
    <div id="head6"><img height="6" src="about:blank"></div>
      <br>
  </body>
</html>

