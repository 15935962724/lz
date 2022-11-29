<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.icard.*" %>
<%@page import="tea.entity.league.*" %>
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
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>卡类型管理</title>
<script>
function f_edit(id)
{
  window.open('/jsp/erp/icard/EditICardType.jsp?icardtype='+id,'_self');
}
function f_del(id)
{
  if(confirm('确认删除?'))
  {
    window.open('/servlet/EditICardType?act=del&icardtype='+id+'&nexturl='+encodeURIComponent(location.href),'_self');
  }
}
</script>
</head>
<body id="bodynone">
<h1>卡类型管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="/jsp/erp/icard/ICardTypes.jsp"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>类型名称</td>
       <td nowrap>分店类型</td>
      <td nowrap>运行模式</td>
      <td nowrap>积分</td>
      <td nowrap>折扣</td>
      <td nowrap>操作</td>
    </tr>
<%
Enumeration e=ICardType.find(teasession._strCommunity,"",0,200);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  ICardType ct=ICardType.find(id);
  LeagueShopType objtype= LeagueShopType.find(ct.getLstypeid());
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td>"+ct.getName());
  out.print("<td>"+objtype.getLstypename());
  out.print("<td>"+ICardType.MODE_TYPE[ct.getMode()]);
  out.print("<td>"+ct.getIntegral());
  out.print("<td>"+ct.getDiscount());
  out.print("<td><input type='button' value='编辑' onclick='f_edit("+id+")'>");
  if(!ICard.find(teasession._strCommunity," AND icardtype=" + id,0,1).hasMoreElements())
  {
    out.print("<input type='button' value='删除' onclick='f_del("+id+")'>");
  }
}
%>
</table>
<input type="button" value="添加卡类型" onClick="f_edit(0);">
</form>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>注: 已发行新卡的卡类型,不能被删除</td>
</tr>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
