<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.admin.*"%><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%
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

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);

StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
par.append("?community=").append(java.net.URLEncoder.encode(teasession._strCommunity,"UTF-8"));

String q=request.getParameter("q");
if(q!=null)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+q+"%"));
  par.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}
par.append("&pos=");

int sum=AdminUsrRole.count(teasession._strCommunity,sql.toString());

String title=r.getString(teasession._nLanguage, "选择用户名...");

%>
<html>
<head>
<title>选择作者</title>
<base target="dialog"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
window.name='dialog';
function f_click(id)
{
  window.returnValue=id;
  window.close();
}
</script>
</head>
<body>
<h1><%=title%></h1>
<form name="form1" action="?" target="dialog">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>用户名:<input name="q" value="<%if(q!=null)out.print(q);%>" type="text"><input type="submit" value="GO"></td>
  </tr>
</table>

<br> 

<h2>列表 ( <%=sum %> )</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td><%=r.getString(teasession._nLanguage, "用户名")%></td>
   
  </tr>
<%
Enumeration e = AdminUsrRole.find(teasession._strCommunity,sql.toString(),pos,10);

for(int i=0;e.hasMoreElements();i++)
{
  String member = ((String)e.nextElement());
  AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,member);
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''  style='cursor:hand; cursor:pointer;' onclick=\"f_click('"+member+"')\">");
  out.print("<td>"+member);

}
if(sum>10)
{
  out.print("<tr><td colspan='4' align='right' style='input{display:none}'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,10));
}
%> 
</table>
</form>
</body>
</html>
