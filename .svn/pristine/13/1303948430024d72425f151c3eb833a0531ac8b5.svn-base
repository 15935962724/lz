<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Http h=new Http(request);
String pflow=h.get("flow");

%><html>
<head>
<title>请选择流程类型</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
body
{
 margin:10px;
 background-color:menu;
}
-->
</style>
</head>
<body>


<form name="form1" action="?" onsubmit="window.returnValue=form1.flow.value;window.close();">
<table border='0' cellpadding='0' cellspacing='0' id="TableAnnex" >
  <tr><td class="TableAnnextitle">请选择:
<tr>
<td>
<select name="flow" size='15' style='width:300px' mask="div" ondblclick="form1.onsubmit();">
<%
java.util.Enumeration enumer=Flow.find(teasession._strCommunity," AND flow IN("+pflow+")");
for(int i=1;enumer.hasMoreElements();i++)
{
  int flow=((Integer)enumer.nextElement()).intValue();
  Flow obj=Flow.find(flow);
  out.print("<option value="+flow+">"+obj.getName(teasession._nLanguage)+"</option>");
}
%>
</select>
</td>
<td valign='top'  id="inputbutton">
<input type="submit" value=" 确 定 ">
<input type="button" value=" 取 消 " onclick="window.close();"/>
</td>
</tr>
</table>
</form>
<script>
form1.flow.selectedIndex=0;
</script>

</body>
</html>
