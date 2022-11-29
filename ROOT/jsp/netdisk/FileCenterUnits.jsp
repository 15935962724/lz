<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource("/tea/resource/NetDisk");

String field=request.getParameter("field");

%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="">
function f_act(id,act)
{
  if(act=='delete')
  {
    if(!confirm('确认删除?'))
    {
      return;
    }
  }
  form1.filecenterunit.value=id;
  form1.act.value=act;
  form1.submit();
}

</script>
</HEAD>
<body>

<h1><%=r.getString(teasession._nLanguage, "编制部门")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="/jsp/netdisk/EditFileCenterUnit.jsp">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="filecenterunit" value="0">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
<input type="hidden" name="act" value="">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr>
  <td>序号</td>
  <td>标题</td>
  <td>操作</td>
</tr>
<%
StringBuffer sb=new StringBuffer();
Enumeration e=FileCenterUnit.findByCommunity(teasession._strCommunity,0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();i++)
{
  int id=((Integer)e.nextElement()).intValue();
  FileCenterUnit fcu=FileCenterUnit.find(id);
  String name=fcu.getName();
  out.print("<tr><td>"+i);
  out.print("<td>"+name);
  out.print("<td><input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=f_act("+id+",'')>");
  out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=f_act("+id+",'delete')>");
  //
  if(sb.length()>0)sb.append(",");
  sb.append("\""+name+"\"");
}
%>
</table>

<input type=button value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onclick=f_act(0,'')>

</form>

<script>
window.onload=function()
{
  var arr=new Array(<%=sb.toString()%>);
  window.opener.f_unit(arr);
}
</script>

</body>
</html>
