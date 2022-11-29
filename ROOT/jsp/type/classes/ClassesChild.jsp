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

StringBuffer  sql= new StringBuffer(" AND community="+DbAdapter.cite(teasession._strCommunity));
String rt=teasession.getParameter("type");
int cid=0;
if(teasession.getParameter("cid")!=null && teasession.getParameter("cid").length()>0)
{
  cid =Integer.parseInt(teasession.getParameter("cid"));
  sql.append(" and class_id="+cid);
}
int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);

StringBuffer par=new StringBuffer();
par.append("?community=").append(java.net.URLEncoder.encode(teasession._strCommunity,"UTF-8"));
par.append("&pos=");
int sum=ClassesChild.count(teasession._strCommunity,sql.toString());
String title=r.getString(teasession._nLanguage, "ManageClasses");
%>
<html>
<head>
<title><%=title%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function f_edit(id)
{
  var rs=window.showModalDialog('/jsp/type/classes/EditClassesChild.jsp?community='+form2.community.value+"&classid="+id,self,'status:0;help:0;dialogWidth:300px;dialogHeight:200px;scroll:0;');
  if(rs)window.open(location.href+"&t="+new Date().getTime(),window.name);
}
</script>
</head>
<body>
<h1><%=title%>(<%=sum%>)</h1>

<form name="form2" action="/servlet/EditClasses" method="post">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="classid" value="0"/>
<input type="hidden" name="act" value="del2"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>&nbsp;</td>
    <td><%=r.getString(teasession._nLanguage, "类型名称")%></td>
    <td><%=r.getString(teasession._nLanguage, "子类名称")%></td>
    <td>&nbsp;</td>
  </tr>
<%
Enumeration e=ClassesChild.findByCommunity("",sql.toString(),pos,10);
for(int i=0;e.hasMoreElements();i++)
{
  int j=((Integer)e.nextElement()).intValue();
  ClassesChild ccobj=ClassesChild.find(j);
  Classes cobj=Classes.find(ccobj.getClass_id());
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td>"+(i+1));
  out.print("<td>"+cobj.getName());
  out.print("<td>"+ccobj.getName());
  out.print("<td><input type='button' value="+r.getString(teasession._nLanguage, "CBEdit")+" onClick=f_edit("+j+");>");
  out.print("<input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" onClick=if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"')){form2.classid.value="+j+";form2.submit();}>");
}
if(sum>10)
{
  out.print("<tr><td colspan='4' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,10));
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="f_edit(0)">
</form>
</body>
</html>
