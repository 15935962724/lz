<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.icard.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>批量发卡</title>
<script>
function f_act(act,id)
{
  switch(act)
  {
    case "del":
    if(!confirm('确认删除?'))
    {
      return;
    }
    break;
    case "exp":
    break;
    case "edit":
    window.open('/jsp/erp/icard/BatICard.jsp?community=<%=teasession._strCommunity%>','_self');
    return;
  }
  form1.act.value=act;
  form1.baticard.value=id;
  form1.nexturl.value=location.pathname+location.search;
  form1.submit();
}
function f_exp()
{
  var ps=form1.baticards;
  if(!ps.length)ps=new Array(ps);
  for(var i=0;i<ps.length;i++)
  {
    if(ps[i].checked)
    {
      return true;
    }
  }
  return false;
}
function f_load()
{
  setInterval("document.getElementById('exp').disabled=!f_exp()",200);
}
</script>
</head>
<body id="bodynone" onload="f_load()">
<h1>批量发卡</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditICard" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="baticard" value="0"/>
<input type="hidden" name="act" value=""/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap></td>
      <td nowrap>起始卡号</td>
      <td nowrap>结束卡号</td>
      <td nowrap>发行日期</td>
      <td nowrap>作废日期</td>
      <td nowrap>卡类型</td>
	  <td nowrap>操作</td>
    </tr>
    <%
    Enumeration e=BatICard.find(teasession._strCommunity,"",0,200);
    while(e.hasMoreElements())
    {
      int id=((Integer)e.nextElement()).intValue();
      BatICard obj=BatICard.find(id);
      int ict=obj.getICardType();
      out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
      out.print("<td><input type='checkbox' name='baticards' value='"+id+"'>");
      out.print("<td>"+obj.getStartCode());
      out.print("<td>"+obj.getEndCode());
      out.print("<td>"+obj.getTimeToString());
      out.print("<td>"+obj.getInvalidDateToString());
      out.print("<td>"+ICardType.find(ict).getName());
      out.print("<td>");
      if(!ICard.find(teasession._strCommunity," AND time="+DbAdapter.cite(obj.getTime())+" AND shopicard>0",0,1).hasMoreElements())
      {
        out.print("<input type='button' value='删除' onclick=f_act('del',"+id+")>");
      }
    }
    %>
  </table>
<input type="button" value="发行新卡" onClick="f_act('edit');">
<input type="button" value="导出选中项" id="exp" onClick="f_act('exp');" disabled="disabled"/>
</form>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>注: 已被加盟商领走的卡,不能被删除</td></tr>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
