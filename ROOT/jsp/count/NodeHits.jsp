<%@page contentType="text/html;charset=utf-8" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%@page import="java.util.*" %>
<%
TeaSession teasession=new TeaSession (request);
Node node=Node.find(teasession._nNode);

String menuid=request.getParameter("id");
String q=request.getParameter("q");
StringBuffer par=new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
par.append("&id=").append(menuid);

String sql="";
if(q!=null&&q.length()>0)
{
  sql=" AND node IN(SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+q+"%")+")";
  par.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}
int count=Node.count(sql);

sql+=" ORDER BY click DESC";

String tmp=request.getParameter("pos");
int pos=tmp==null?0:Integer.parseInt(tmp);

par.append("&pos=");

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>

<h1>页面访问量</h1>
<form action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>标题:<input name="q" type="text" value="<%if(q!=null)out.print(q);%>"><input type="submit" value="GO"/></td></tr>
</table>
</form>

<h1>结果 <%=count%></h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
  <td nowrap>序号</td>
  <td nowrap>标题</td>
  <td nowrap>点击量</td>
</tr>
<%
Enumeration e=Node.find(sql,pos,15);
for(int i=pos+1;e.hasMoreElements();i++)
{
  int nid=((Integer)e.nextElement()).intValue();
  Node n=Node.find(nid);
  String str=n.getSubject(teasession._nLanguage);
  if(q!=null&&q.length()>0)
  {
    str=str.replaceAll(q,"<font color='red'>"+q+"</font>");
  }
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td>"+i);
  out.print("<td><a href='/servlet/Node?node="+nid+"' target='_blank'>"+str+"</a>");
  out.print("<td>"+n.getClick());
}
out.print("<tr><td colspan='3' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,15));
%>
</table>

</body>
</html>
