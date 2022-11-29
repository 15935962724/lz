<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %><%@ page import="tea.entity.member.*" %>
<%
   TeaSession teasession = new TeaSession(request);
   StringBuffer sql = new StringBuffer();//select
   StringBuffer par = new StringBuffer("?");//canshu
   String fname = request.getParameter("fname");
   String ip = request.getParameter("ip");
   String  content = request.getParameter("content");
   String start = request.getParameter("start");
   String end = request.getParameter("end");
   if(fname!=null&& fname.length()>0)
   {
     sql.append(" AND fname LIKE ").append(DbAdapter.cite("%"+fname+"%"));
     par.append("&fname=").append(fname);
   }
   if(start!=null&&start.length()>0)
   {
     sql.append(" AND time>=").append(DbAdapter.cite(start));
     par.append("&start=").append(start);
   }
   if(end!=null&&end.length()>0)
   {
     sql.append(" AND time<").append(DbAdapter.cite(end));
     par.append("&end=").append(end);
   }
   if(ip!=null && ip.length()>0)
   {
     sql.append("AND ip=").append(DbAdapter.cite(ip));
     par.append("&ip=").append(ip);
   }
   if(content!=null && content.length()>0)
   {
     sql.append("AND content LIKE ").append(DbAdapter.cite("%"+content+"%"));
     par.append("&content=").append(content);
   }
int pos=0;//start page
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
par.append("&pos=");//end
int count=MsnMessage.countByCommunity(teasession._strCommunity,sql.toString());//total columns
%>
<html>
<head>
<LINK href="/res/<%=teasession._strCommunity%>/cssjs/community.css" REL="stylesheet" TYPE="text/css">
<script type="" src="/tea/tea.js"></script>
</head>
<body>
<h1>查询</h1>
<form name="form1" action="?">
<table id="tablecenter">
<tr>
  <td>发送者:<input type="text" name="fname" value="<%if(fname!=null)out.print(fname);%>"/></td>
  <td>发送时间:从：<input type="text" name="start" value="<%if(start!=null)out.print(start);%>" readonly="readonly"/>
    <a href="###" onclick="showCalendar('form1.start');"><img alt="日历" src="/tea/image/public/Calendar2.gif" /></a>
   到 <input type="text" name="end" value="<%if(end!=null)out.print(end);%>" readonly="readonly"/>
    <a href="###" onclick="showCalendar('form1.end');"><img alt="日历" src="/tea/image/public/Calendar2.gif" /></a>
  </td>
  <td>
  发送者 IP:<input type="text" name="ip" value="<%if(ip!=null)out.print(ip);%>"/>
  </td>
  <td>
  发送内容：<input type="text" name="content" value="<%if(content!=null)out.print(content);%>"/>
  </td>
  <td>
   <input type="submit" value= " GO ">
 </td>
</table>
</form>
<h1>列表(<%=count%>)</h1>
<%
java.util.Enumeration e= MsnMessage.findByCommunity("DEV",sql.toString(),pos,25);
//type of enumerate
%>
<table id="tablecenter">
<tr id="tableonetr">
    <td>发信人</td>    <td>收信人</td>    <td>发送内容</td>    <td>发送者IP</td>    <td>发送时间</td>
  </tr>
<%
while(e.hasMoreElements())
{
  MsnMessage obj = ((MsnMessage)e.nextElement());
%>
<tr>
<td><%=obj.getFName()%></td>
<td><%=obj.getTName() %></td>
<td><%=obj.getContent() %></td>
<td><%=obj.getIp() %></td>
<td><%=obj.getTime() %></td>
</tr>
<%
}
%>
<tr>
  <td colspan="9" align="center">
    <%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count)%>
  </td>
</tr>
</table>
</body>
</html>
