<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

StringBuffer sb=new StringBuffer(),unit=new StringBuffer();
Iterator it=AdminUnitType.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,200).iterator();
while(it.hasNext())
{
  AdminUnitType aut=(AdminUnitType)it.next();
  sb.append("<option value="+aut.adminunittype+">"+aut.name);
  //
  unit.append("case "+aut.adminunittype+":");
  Enumeration e=AdminUnit.findByCommunity(teasession._strCommunity," AND adminunittype="+aut.adminunittype,0,200);
  while(e.hasMoreElements())
  {
    AdminUnit au=(AdminUnit)e.nextElement();
    unit.append("op[op.length]=new Option('"+au.getName()+"','"+au.getName()+"');");
  }
  unit.append("break;");
}


%><html>
<head>
<title>单位选择</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<style type="text/css">
<!--
body
{
 margin:10px;
 background-color:menu;
}
-->
</style>
<script type="">
function f_sel()
{
  var v=form1.type.value;
  var op=form1.select1.options;
  while(op.length>0)
  {
    op[0]=null;
  }
  switch(parseInt(v))
  {
    <%=unit.toString()%>
  }
}
function f_submit()
{
  var h="";
  var op=form1.select2.options;
  for(var i=0;i<op.length;i++)
  {
    if(h.length>0)h+="　";
    h+=op[i].value;
  }
  window.returnValue=h;
  window.close();
  return false;
}
</script>
</head>
<body onload="f_sel()" class="Pop_up">

<form name="form1" action="?" method="post" onSubmit="f_submit();">

<table class="Views">
  <tr><td nowrap>单位类别</td></tr>
  <tr>
    <td colspan="3"><select name="type" onchange="f_sel();"><%=sb.toString()%></select></td>
  </tr>
  <tr>
    <td><select name="select1" size="12" style="width:150px" multiple="multiple" ondblclick="move(form1.select1,form1.select2,true)">
    </select>
    </td>
    <td>
      <input type="button" value="&gt;&gt;" onclick="form1.select1.ondblclick();" />
      <input type="button" value="&lt;&lt;" onclick="form1.select2.ondblclick();" />
    </td>
    <td>
      <select name="select2" size="12" style="width:150px" multiple="multiple" ondblclick="move(form1.select2,form1.select1,true)">
      </select>
    </td>
  </tr>
</table>

<div align="center">
<input type="submit" value=" 确定 " class="BigButton" >
<input type="button" value=" 取消 " class="BigButton" onClick="window.close();">
</div>
</form>

</body>
</html>
