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

int choose=0;
String tmp=request.getParameter("choose");
if(tmp!=null)
{
  choose=Integer.parseInt(tmp);
}

Resource r=new Resource();

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

<h1>调查统计</h1>
<div id="head6"><img height="6" src="about：blank"></div>
<br/>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<div id="mihu2">
应用系统:
<select name="choose" onChange="form1.submit();">
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
</select></div>
<table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'>
  <tr id='tableonetr'>
    <td id='xuhao'>&nbsp;序号&nbsp;</td>
    <td id='ruanj_gys'>&nbsp;软件供应商&nbsp;</td>
    <td id='yingy_qyj'>&nbsp;应用的企业(家)&nbsp;</td>
    <td id='ruanj_xjbj'>&nbsp;软件性价比评价好的企业&nbsp;</td>
    <td id='ruanj_ybqy'>&nbsp;软件性价比评价一般的企业&nbsp;</td>
  </tr>
<%
Enumeration e=CioPoll.find(teasession._strCommunity,choose,0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();i++)
{
  Object obj[]=(Object[])e.nextElement();
  String name=(String)obj[0];
  int s0=((Integer)obj[2]).intValue();
  int s1=((Integer)obj[3]).intValue();
  out.print("<tr><td id='xuhao'>"+i);
  out.print("<td id='ruanj_gys'><a href='/jsp/cio/ViewCioPoll.jsp?choose="+choose+"&name="+java.net.URLEncoder.encode(name,"UTF-8")+"'>"+name+"</a>");
  //out.print("<td>"+name);
  out.print("<td id='yingy_qyj'>"+obj[1]);
  out.print("<td id='ruanj_xjbj'>"+(s0<1?"--":""+s0+"</a>"));
  out.print("<td id='ruanj_ybqy'>"+(s1<1?"--":""+s1+"</a>"));
}
%>
</table>
</form>

</body>
</html>
