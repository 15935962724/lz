<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*"%>
<%@page import="tea.entity.node.access.*" %><%@page import="tea.ui.*"%><%@page import="tea.resource.*" %>
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
DecimalFormat df=new DecimalFormat("#,##0");
DecimalFormat df2=new DecimalFormat("#,##0.00");

String community=teasession._strCommunity;
String _strid=teasession.getParameter("id");
String node=teasession.getParameter("node");

String strPos=request.getParameter("pos");
int pos=0;
if(strPos!=null)
	pos=Integer.parseInt(strPos);

StringBuffer sql = new StringBuffer(),par=new StringBuffer();
sql.append(" AND community=").append("'"+teasession._strCommunity+"'");
par.append("?id="+_strid+"&node="+node+"&community="+community);
sql.append("  AND downsum>0");
par.append("&downsum>0");
par.append("&pos=");
int sum=NodeAccessApkCity.count(sql.toString());

int alltotalcount = 0;

Iterator it=null;
if(sum>0){
	alltotalcount = NodeAccessApkCity.downsum(sql.toString());
}

float total=1F;
float top=1F;

String nexturl = "/jsp/admin/right.jsp?id="+teasession.getParameter("id")+"&node="+teasession.getParameter("node")+"&community="+community;
//System.out.print(nexturl);
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
<h1>apk下载地区统计</h1>
<div id=load >
<br>
<br>
<br>
<img src="/tea/image/public/load.gif" align="top"><%=r.getString(teasession._nLanguage,"1216023262720")%>...
</div>

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <%
  if(sum>0&&alltotalcount>0)
  {
  %>
  <tr>
    <td align="center">
      <table border=0 cellpadding=2>
        <%
       
        ArrayList al=new ArrayList();
        	sql.append(" order by downsum desc");
        	it=NodeAccessApkCity.find(sql.toString(),pos,50).iterator();
        	for(int i=1+pos;it.hasNext();i++)
        	{
        		NodeAccessApkCity a=(NodeAccessApkCity)it.next();
        		
        		int apkSum = a.getDownsum();
        		total=alltotalcount/100F;
        		float p=apkSum/total;
        		out.write("<tr valign=bottom >");
	            out.write("<td>"+a.getAddress());
	            out.write("<td>"+df.format(apkSum));
	            out.print("<td align='right'>"+df2.format(p)+"%</td>");
	            out.print("<td align=left valign=middle width=200><img src='/tea/image/other/bar2.gif' style='width:"+(p>=0.01?apkSum/total:0)+"' height=15></td>");
          }
        %>
            </table>
    </td>
        </tr>
  <%
  	if(sum>50)out.print("<tr><td colspan='5' align='center'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,50)+"</td></tr>");
  }else
  {
    out.print("<tr><td colspan='5' align='center'>暂无apk下载地区");
  }
  %>
</table>
<br>
<%=r.getString(teasession._nLanguage,"1216023344003")%>:<%=(System.currentTimeMillis()-lo)/1000f%><%=r.getString(teasession._nLanguage,"Seconds")%><br>


<script>
var load=document.getElementById('load');
load.style.display='none';
</script>

</body>
</html>