<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.site.License" %><%@ page  import="tea.resource.Resource" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.map.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

int type=Integer.parseInt(request.getParameter("type"));

String nexturl=java.net.URLEncoder.encode(request.getParameter("nexturl"),"UTF-8");

boolean bool=teasession._rv.isOrganizer(teasession._strCommunity)||License.getInstance().getWebMaster().equals(teasession._rv);

StringBuffer param = new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&type=").append(type);
param.append("&nexturl=").append(nexturl);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}
param.append("&pos=");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>选择标点</h1>
<div id="head6"><img height="6" src="about:blank"></div>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1">&nbsp;</td>
       <td>名称</td>
       <td nowrap>时间</td>
       <td nowrap>&nbsp;</td>
     </tr>
<%
StringBuffer sql=new StringBuffer(" AND finished=1");
sql.append(" AND community=").append(DbAdapter.cite(teasession._strCommunity));
sql.append(" AND type=").append(type);
if(!bool)
{
  sql.append(" AND vcreator=").append(DbAdapter.cite(teasession._rv._strV));
}
sql.append(" AND node NOT IN ( SELECT node FROM mapabc )");

int count=Node.count(sql.toString());
java.util.Enumeration enumer=Node.find(sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int node=((Integer)enumer.nextElement()).intValue();
  Node obj=Node.find(node);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getSubject(teasession._nLanguage)%></td>
    <td>&nbsp;<%=obj.getTimeToString()%></td>
    <td>
    <input type=button value=编辑 onclick="window.open('/jsp/admin/map/EditMapabc.jsp?community=<%=teasession._strCommunity%>&node=<%=node%>&nexturl=<%=nexturl%>','_self');" >
    </td>
 </tr>
<%
}
%>
<tr><td colspan="6"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count)%></td></tr>
</table>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


