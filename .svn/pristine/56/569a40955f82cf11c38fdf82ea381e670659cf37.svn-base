<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*"%>
<%@page import="tea.entity.node.access.*" %><%@page import="tea.ui.*"%><%@page import="tea.resource.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="java.text.DecimalFormat"%>
<%
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
long lo=System.currentTimeMillis();

Resource r=new Resource();
r.add("/tea/resource/fun");

StringBuffer sql = new StringBuffer(),par=new StringBuffer();
String community=teasession._strCommunity;
String nexturl = teasession.getParameter("nexturl");
String strPos=request.getParameter("pos");
int pos=0;
if(strPos!=null)
	pos=Integer.parseInt(strPos);
sql.append(" AND community=").append("'"+teasession._strCommunity+"'");
par.append("?community="+community);
int apkid = Integer.parseInt(request.getParameter("apkid"));
sql.append(" AND apkid=").append(apkid);
par.append("&apkid="+apkid);
par.append("&nexturl="+nexturl);
par.append("&pos=");
int sum=NodeAccessApk.count(sql.toString());
%>
<html>
<head>
<title>访问统计</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<style type="text/css">
.gra{border:1px solid #666666;width:12px;height:12px}
</style>
</head>
<body id="bodynone">
<h1>Apk下载信息</h1>
<div id=load >
<br>
<br>
<br>
<img src="/tea/image/public/load.gif" align="top"><%=r.getString(teasession._nLanguage,"1216023262720")%>...
</div>

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr id="tableonetr" >
    <td>&nbsp;</td>
    <td><%=r.getString(teasession._nLanguage,"1216087426584")%></td>
    <td><%=r.getString(teasession._nLanguage,"1216087580849")%></td>
    <td><%=r.getString(teasession._nLanguage,"1216087624896")%></td>
  </tr>
  <%
  if(sum>0)
  {
  %>
        <%
       
        ArrayList al=new ArrayList();
        	sql.append(" order by time desc");
        	Iterator it=NodeAccessApk.find(sql.toString(),pos,50).iterator();
        	for(int i=1+pos;it.hasNext();i++)
        	{
        		NodeAccessApk naa=(NodeAccessApk)it.next();
        		SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        		out.write("<tr>");
        		out.write("<td>"+i+"</td>");
        		out.write("<td>"+sdf3.format(naa.getTime()));
	            out.print("<td>"+naa.getAddress()+"</td>");
	            out.write("<td>"+naa.getIp());
          }
        %>
  <%
  	if(sum>50)out.print("<tr><td colspan='4' align='center'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,50)+"</td></tr>");
  }else
  {
    out.print("<tr><td colspan='4' align='center'>暂无Apk下载信息");
  }
  %>
</table>
<br>
<input type="button" value="返回" onclick="javascript:window.location.href='<%=nexturl %>'">
<br><br>
<%=r.getString(teasession._nLanguage,"1216023344003")%>:<%=(System.currentTimeMillis()-lo)/1000f%><%=r.getString(teasession._nLanguage,"Seconds")%><br>


<script>
var load=document.getElementById('load');
load.style.display='none';
</script>

</body>
</html>