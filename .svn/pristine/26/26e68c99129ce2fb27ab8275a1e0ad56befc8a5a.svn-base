<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member=teasession._rv._strV;


Resource r=new Resource("/tea/resource/Dynamic");

//Http h=new Http(request);
//int dynamictype=h.getInt("dynamictype");


%><html>
<head>
<title>所属机构</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script LANGUAGE=JAVASCRIPT src="/tea/tea.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/mt.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin:10px;
 background-color:menu;
}
-->
</style>
<script>

var subor=(opener?opener:dialogArguments).form1.adminunitorg;
function f_submit()
{
  window.returnValue=mt.value(form1.adminunitorg);
  window.close();
}
function f_load()
{
  var arr=form1.adminunitorg,v=subor.value;
  for(var i=0;i<arr.length;i++)
  {
    if(arr[i].value==v||i==0)arr[i].checked=true;
  }
  $('submit').focus();
}
</script>
</head>
<body onLoad="f_load()">
<br/>
<form name="form1" action="?" method="post" onSubmit="f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<table>
<tr class="Radio">
  <td>请选择来文单位:</td>
  <td>
<%
Iterator it=AdminUnitOrg.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,100).iterator();
while(it.hasNext())
{
  AdminUnitOrg auo=(AdminUnitOrg)it.next();
  out.print("<input type='radio' name='adminunitorg' value=\""+auo.adminunitorg+";"+MT.f(auo.org)+"\" id='s"+auo.adminunitorg+"' /><label for=s"+auo.adminunitorg+">"+auo.name+"</label> ");
}
%>
  </td>
</tr>
</table>
<input id="submit" type="submit" value=" 确 定 "/>
</form>

</body></html>
