<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl=request.getRequestURI()+"?"+request.getQueryString();
}
String member=teasession._rv._strV;

String menuid=request.getParameter("id");


String name=request.getParameter("name");

int choose=0;
String tmp=request.getParameter("choose");
if(tmp!=null)
{
  choose=Integer.parseInt(tmp);
}

Resource r=new Resource();


StringBuilder sb[]=new StringBuilder[2];
sb[0]=new StringBuilder();
sb[1]=new StringBuilder();
Enumeration cpe=CioPoll.find(teasession._strCommunity," AND choose"+choose+"="+DbAdapter.cite(name),0,Integer.MAX_VALUE);
while(cpe.hasMoreElements())
{
  CioPoll cp=(CioPoll)cpe.nextElement();
  int ccid=cp.getCioCompany();
  CioCompany cc=CioCompany.find(ccid);
  sb[cp.getScore()[choose]].append(cc.getName());
}
for(int i=0;i<sb.length;i++)
{
  if(sb[i].length()<1)
  {
    sb[i].append("暂无");
  }
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_edit(cpid)
{
  form1.action="?";
  form1.ciopart.value=cpid;
  form1.submit();
}
</script>
</head>
<body>


<h1>调查统计 <%=CioPoll.CHOOSE_TYPE[choose]+"　"+name%></h1>

<div id="head6"><img height="6" src="about：blank"></div>
<br/>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="choose" value="<%=choose%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>

<div id="mihu2">
<!--
应用系统:
<select name="choose">
<%
for(int i=0;i<CioPoll.CHOOSE_TYPE.length;i++)
{
  out.print("<option value="+i);
  if(choose==i)
  {
    out.print(" selected='true'");
  }
  out.print(">"+CioPoll.CHOOSE_TYPE[i]);
}
%>
</select>
-->

软件供应商:
<select name="name" onchange="form1.submit();">
<%
Enumeration e=CioPoll.find(teasession._strCommunity,choose,0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  Object obj[]=(Object[])e.nextElement();
//  int s0=((Integer)obj[2]).intValue();
//  int s1=((Integer)obj[3]).intValue();
  out.print("<option value="+obj[0]);
  if(obj[0].equals(name))
  {
    out.print(" selected='true'");
  }
  out.print(">"+obj[0]+" ( "+obj[1]+" )");
}
%>
</select>
</div>
</form>

<table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'>
  <tr id='tableonetr'>
 <td>&nbsp;软件性价比评价好的企业&nbsp;</td>
 <td>&nbsp;软件性价比评价一般的企业&nbsp;</td>
 </tr>
 <tr><td>&nbsp;<%=sb[0].toString()%>&nbsp;</td><td>&nbsp;<%=sb[1].toString()%>&nbsp;</td></tr>
</table>



</body>
</html>
