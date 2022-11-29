<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.lang.*,java.util.*,java.text.SimpleDateFormat,java.text.DateFormat" %>
<%@page import="tea.entity.node.access.*" %>

<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community=request.getParameter("community");
int hour  =Integer.parseInt(request.getParameter("hour"));
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

   <h1>访问 <%=hour%>时IP统计图表</h1>
   <div id="head6"><img height="6" src="about:blank"></div>
   <br>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td align=center>IP</td>
          <td align=center>图表</td>
          <td align=center>数量</td>
        </tr>

<%
int pos=0;
if(request.getParameter("pos")!=null)
pos=Integer.parseInt(request.getParameter("pos"));


java.util.Calendar c=java.util.Calendar.getInstance() ;
c.set(java.util.Calendar.HOUR_OF_DAY,hour);
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
tea.db.DbAdapter dbadapter2=new tea.db.DbAdapter();
int count=dbadapter.getInt("SELECT COUNT(DISTINCT ip) FROM NodeAccess WHERE DATEDIFF(hh,time,"+dbadapter.cite(c.getTime())+")=0 AND node IN(SELECT node FROM Node WHERE community="+dbadapter.cite(community)+")");
dbadapter.executeQuery("SELECT DISTINCT TOP "+((pos+1)*25)+"  ip FROM NodeAccess WHERE DATEDIFF(hh,time,"+dbadapter.cite(c.getTime())+")=0 AND node IN(SELECT node FROM Node WHERE community="+dbadapter.cite(community)+")");
for(int index=0;dbadapter.next();index++)
{
if(index>pos*25)
{
  String ip=dbadapter.getString(1);
%>
              <tr valign=bottom >
                <td nowap><%=dbadapter.getString(1)%></td>

                <td nowap><%=dbadapter2.getInt("SELECT COUNT(DISTINCT ip) FROM NodeAccess WHERE ip="+dbadapter.cite(ip)+" AND DATEDIFF(hh,time,"+dbadapter.cite(c.getTime())+")=0 AND node IN(SELECT node FROM Node WHERE community="+dbadapter.cite(community)+")")%></td>
              </tr>
              <%}
			}
                        dbadapter.close();                        dbadapter2.close();
            %>

<tr><td colspan="20">
   <%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+"?community=" + community +"&hour="+hour+ "&pos=", pos,count)%>
</td>
</tr>
</table>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

</body>
</html>


