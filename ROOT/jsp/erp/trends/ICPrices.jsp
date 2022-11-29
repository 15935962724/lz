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
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String menuid=request.getParameter("id");

if("del".equals(request.getParameter("act")))
{
  int icprice=Integer.parseInt(request.getParameter("icprice"));
  ICPrice p=ICPrice.find(icprice);
  p.delete();
}

String nexturl = request.getRequestURI()+"?"+request.getContextPath();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>价位管理</title>
<script>
function f_edit(id)
{
  window.open('/jsp/erp/trends/EditICPrice.jsp?icprice='+id+'&nexturl='+encodeURIComponent(location.href),'_self');
}
function f_del(id)
{
  if(confirm('确认删除?'))
  {
    window.open('?id=<%=menuid%>&act=del&icprice='+id,'_self');
  }
}
</script>
</head>
<body id="bodynone">
<h1>价位管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>序号</td>
    <td nowrap>价位</td>
    <td nowrap>操作</td>
  </tr>
<%
Enumeration e=ICPrice.find(teasession._strCommunity," ORDER BY startprice",0,200);
for(int i=1;e.hasMoreElements();i++)
{
  ICPrice p=(ICPrice)e.nextElement();
  int id=p.getICPrice();
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td>"+i);
  out.print("<td>"+p.getStartPrice()+" - "+p.getEndPrice());
  out.print("<td><input type='button' value='编辑' onclick='f_edit("+id+")'>");
  out.print("<input type='button' value='删除' onclick=f_del("+id+")>");
}
%>
</table>
<%
out.print("<input type='button' value='添加' onClick='f_edit(0);'>");
%>
</form>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>注: 价位 用来销售分析的. 只能创建5个.</td>
</tr>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
