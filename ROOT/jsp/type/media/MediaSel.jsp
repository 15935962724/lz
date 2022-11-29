<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

int type=Integer.parseInt(request.getParameter("type"));

StringBuffer par=new StringBuffer();
StringBuffer sql=new StringBuffer();
par.append("?type=").append(type);

String name=request.getParameter("name");
if(name!=null)
{
  sql.append(" AND ml.name LIKE ").append(DbAdapter.cite("%"+name+"%"));
  par.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}
par.append("&pos=");

int count=Media.count(teasession._strCommunity,type,sql.toString());

int pos=0;
String tmp = request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

Resource r = new Resource("/tea/resource/Media");

String title="媒体选择...";

%>
<html>
<head>
<title><%=title%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>
function f_click(id)
{
  window.returnValue=id;
  window.close();
}
</script>
</head>
<body>
<div id="head6"><img height="6" src="about:blank"></div>


<h1><%=title%></h1>
<form action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="type" value="<%=type%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>名称:<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
  <td><input type="submit" value="GO"></td>
</tr>
</table>
</form>

<h2>列表 ( <%=count%> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td width=1></td>
    <td>名称</td>
    <td>Logo</td>
  </tr>
<%
Enumeration e=Media.find(teasession._strCommunity,type,sql.toString(),pos,10);
for(int i=1;e.hasMoreElements();i++)
{
  int id=((Integer)e.nextElement()).intValue();
  Media obj=Media.find(id);
  String logo=obj.getLogo(teasession._nLanguage);
  out.print("<tr onmouseover=bgColor='#BCD1E9'; onMouseOut=bgColor=''; style=cursor:hand onclick=f_click("+id+")>");
  out.print("<td width=1>"+i+"</td>");
  out.print("<td>"+obj.getName(teasession._nLanguage));
  out.print("<td>");
  if(logo!=null&&logo.length()>0)
  {
    out.print("<img src=\""+logo+"\">");
  }
}
out.print("<style type='text/css'>.fpnl input{display:none}</style><tr><td colspan=20 align='right' class='fpnl'>"+new tea.htmlx.FPNL(teasession._nLanguage, par.toString(), pos,count, 10)+"</td></tr>");
%>
</table>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
