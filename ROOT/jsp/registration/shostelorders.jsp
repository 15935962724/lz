<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.db.*" %>
<%@page import="java.text.*" %>
<%

 request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Community community =Community.find(teasession._strCommunity);
String[] str = {"未处理","已处理","已过期"};//输出订单状态
StringBuffer sql2 = new StringBuffer();
int pos=0,count=0;
System.out.println("pos is : "+request.getParameter("pos"));
if(request.getParameter("pos")!=null)
{
pos=Integer.parseInt(request.getParameter("pos"));
}
StringBuffer param = new StringBuffer("?community="+teasession._strCommunity);
if(request.getParameter("submit")!=null&&request.getParameter("submit").length()>0)
{
if(request.getParameter("subject")!=null&&request.getParameter("subject")!=""&&request.getParameter("subject").length()>0)
{
  int node = Integer.parseInt(request.getParameter("subject"));
  sql2.append(" AND node ="+node);
}
if(request.getParameter("from")!=null&&request.getParameter("from")!=""&&request.getParameter("from").length()>0)
{
  SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
  java.util.Date kdate = sdf1.parse(request.getParameter("from"));
  java.sql.Date kipdate1 = new java.sql.Date(kdate.getTime());
  sql2.append(" AND kipdate like "+" '%"+kipdate1+"%' "+"");
}
if(request.getParameter("to")!=null&&request.getParameter("to")!=""&&request.getParameter("to").length()>0)
{
    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date ldate = sdf2.parse(request.getParameter("to"));
    java.sql.Date leavedate1 = new java.sql.Date(ldate.getTime());
    sql2.append(" AND leavedate like"+" '%"+leavedate1+"%' "+" ");
}
if(request.getParameter("member")!=null&&request.getParameter("member").length()>0)
{
  sql2.append(" AND member LIKE "+" '%"+request.getParameter("member")+"%' "+"");
}
if(request.getParameter("by")!=null&&request.getParameter("by").length()>0)
{
sql2.append(" ORDER BY "+request.getParameter("by")+" DESC");
}
}
param.append("&pos=");
count = Destine.countint(sql2.toString());
%>
<html>
<head>
<link  href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<script  language="javascript" type="">
function ShowCalendar(fieldname)
{
 window.showModalDialog("/jsp/registration/Calendar2.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+200+"px;dialogLeft:"+300+"px");
}
</script>
<title>订单列表</title>
</head>
<body>
<h1>查询各酒店订单</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<h2>查询</h2><!--action="Editaudits.jsp"-->
<form name="form1" action="?">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>酒店名称：
<select name="subject">
<%
java.util.Enumeration e = Destine.find(teasession._strCommunity);
while(e.hasMoreElements())
{
  int no =  ((Integer)e.nextElement()).intValue();
  Node node = Node.find(no);
%>
  <option value="<%=no%>"><%=node.getSubject(teasession._nLanguage)%></option>
<%}%>
  </select>
</td>
<td>FROM：<input type="text" name="from"  readonly="readonly" style="width:100px"/>
  <a href="javascript:ShowCalendar('form1.from')" target="_self"> <img id="dimg3" style="POSITION: relative" src="/tea/image/public/Calendar.gif" border="0" align="middle" alt=""></a> 　　</td>
<td>To：<input type="text" name="to" readonly="readonly" style="width:100px" />
<a href="javascript:ShowCalendar('form1.to')" target="_self"> <img id="dimg4" style="POSITION: relative" src="/tea/image/public/Calendar.gif" border="0" align="middle" alt=""></a></td>

<td>会员ID： <input type="text" name="member" style="width:100px"/>
<td>排序:
  <select name="by">
  <option value="">不要求</option>
  <option value="destine">订单编号</option>
  <option value="destinedate">订单日期</option>
  </select>
</td>
</tr>
<tr>
<td><input type="submit" value=" 查询 " name="submit"/></td>
</tr>
</table>
</form>
<h2>列表2(<%=count %>)</h2>
<form action="" name="form3">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>订单会员</td><td>所订酒店</td><td>订单编号</td><td>订单日期</td><td>订单状态</td></tr>
<%
  java.util.Enumeration eh = Destine.find(teasession._strCommunity,sql2.toString(),pos,10);
  while(eh.hasMoreElements())
  {
  int destine = ((Integer)eh.nextElement()).intValue();
   Destine obj = Destine.find(destine);
  Node node = Node.find(obj.getNode());
 %>
<tr>
<td><a href=""><%=obj.getMember() %></a></td>
<td><a href=""><%=node.getSubject(teasession._nLanguage) %></a></td>
<td><a href="">订单<%=obj.getDestine() %></a></td>
<td><%=obj.getDestinedateToString()%></td>
<td><%=str[obj.getDstate()]%></td>
</tr>
<%}%>
</table>
<tr>
<td colspan="5" align="center">
<input type="button" name="excel" value="导出成 EXCEL 表格"/>
<input  type="submit" name="order" value="订单统计"/>
</td>
</tr>
<tr>
  <td colspan="5" align="center">
  <%=new tea.htmlx.FPNL(1,param.toString(),pos,count,10)%>
</td>
</tr>
</form>
</body>
</html>
