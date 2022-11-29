<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();

r.add("/tea/resource/Classes");




int type =0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  type = Integer.parseInt(teasession.getParameter("type"));
}

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);

String sql=" AND type = "+type+" AND community="+DbAdapter.cite(teasession._strCommunity);
StringBuffer par=new StringBuffer();
par.append("?community=").append(java.net.URLEncoder.encode(teasession._strCommunity,"UTF-8"));
par.append("&type=").append(type);

String q=request.getParameter("q");
if(q!=null)
{
  sql=sql+" AND name LIKE "+DbAdapter.cite("%"+q+"%");
  par.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}
par.append("&pos=");

int sum=Classes.count(sql);

String title=r.getString(teasession._nLanguage, "类别选择...");

%>
<html>
<head>
<title><%=title%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
window.name="dialog";
function f_click(id)
{
  window.returnValue=id;
  window.close();
}
</script>
</head>
<body>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" method="get" target="dialog">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>名称:<input name="q" value="<%if(q!=null)out.print(q);%>" type="text"><input type="submit" value="GO"></td>
  </tr>
</table>
</form>
<br>

<h2>列表 ( <%=sum %> )</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>&nbsp;</td>
    <td><%=r.getString(teasession._nLanguage, "名称")%></td>
    <td><%=r.getString(teasession._nLanguage, "使用数")%></td>
  </tr>
<%
Enumeration e=Classes.find(sql,pos,10);

for(int i=pos+1;e.hasMoreElements();i++)
{
  int j=((Integer)e.nextElement()).intValue();
  Classes c=Classes.find(j);
  int use=Node.count(" AND node IN(SELECT node FROM Report WHERE classes="+j+")");
  out.print("<tr onMouseOver=bgColor='#BCD1E9'  style='cursor:pointer' onMouseOut=bgColor='' style='cursor:hand' onclick='f_click("+j+")'>");
  out.print("<td>"+i);
  out.print("<td>"+c.getName());
  out.print("<td>"+use);
}
if(sum>10)
{
  out.print("<tr><td colspan='4' align='right' style='input{display:none}'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,10));
}
%>
</table>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
