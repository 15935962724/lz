<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%>
<%tea.ui.TeaSession teasession = new tea.ui.TeaSession(request); %>
<html>
<head>
<script   language="Javascript" type="text/javascript">

function f_type()
{
  window.open('/jsp/profile/attendance/AddType.jsp','','width=300px,height=175px,top=200px,left=600px');
}
function f_clo(){
window.opener.location.reload();
window.close();
}
  </script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>

<title>
类型自定义管理
</title>
</head>
<body bgcolor="#ffffff">
<h1 align="center">
自定义类型
</h1>
<form action="?" name="form1" method="POST">
<h2>列表</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="1">&nbsp;</td>
    <td>名称</td>
    <td>&nbsp;</td>
  </tr>
<%
DbAdapter db = new DbAdapter();
  db.executeQuery("select tid,typename from atttype where community="+db.cite(teasession._strCommunity));
for(int i = 1; db.next();i++){
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">

  <td width="1"><%=i%>
  <input type="hidden" name="tid" value="<%=db.getInt(1)%>"/>
  </td>
  <td><%=db.getString(2)%></td>
  <td align="center">
    <input type=button value="<%=r.getString(teasession._nLanguage,"CBEdit")%>"  onClick="window.location.href='/jsp/profile/attendance/EditType.jsp?tid=<%=db.getInt(1)%>'">
    <input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>"  onClick="if(confirm('确定删除此类型？')){window.location.href='/jsp/profile/attendance/DeleteType.jsp?tid=<%=db.getInt(1)%>';}">
  </td>
</tr>
<%
}
db.close();
%>
</table>
<center>
<input type="button" value="创建" onclick="f_type();"/>
<input type="button" value="关闭" onclick="f_clo();"/>
</center>
</form>
</body>
</html>
