<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
<%


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


int cioclerkd =0;
request.getParameter("cioclerkd");
if(request.getParameter("cioclerkd")!=null && request.getParameter("cioclerkd") .length()>0)
{
   cioclerkd=Integer.parseInt(request.getParameter("cioclerkd"));
   CioClerk.delete(cioclerkd);


}

StringBuilder sql=new StringBuilder();
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


</head>
<body bgcolor="#ffffff">
<h1>
接送人员列表
</h1>
<form action="" enctype="multipart/form-data" >
<table border="0" cellpadding="0" cellspacing="0" id="tablecenterleft2" style="float:left;margin-left:15px;">
  <tr id='tableonetr'>
<td align="center">序号</td><td>姓名</td><td>联系电话</td><td></td>
</tr>
<%
  int j=1;
  int ccid=0;
Enumeration cioclerk = CioClerk.find(sql.toString(),0,Integer.MAX_VALUE) ;
if(!cioclerk.hasMoreElements())
{
  %>
  <tr><td colspan="3">暂无信息</td></tr>
  <%
}
while(cioclerk.hasMoreElements())
{
  CioClerk cc=(CioClerk)cioclerk.nextElement();
  ccid=cc.getId();
  out.print("<tr><td align=\"center\">"+j);
  out.print("<td>"+cc.getSname());
  out.print("<td>"+cc.getStel());
  j++;
  %>
  <td>
    <a href="/jsp/cio/EditCioClerk.jsp?cioclerk=<%=ccid%>">编辑</a>

    <a  href="#"  onClick="if(confirm('确认删除')){window.open('/jsp/cio/CioClerk.jsp?cioclerkd=<%=ccid%>&1=1', '_self');this.disabled=true;};" >删除</a></td>
    <%
    }
    %>
</table>
<div id="tablebottom_button02">
<input  type="button"  onclick="window.open('/jsp/cio/EditCioClerk.jsp','_self')" value="添加接送人员"/></div>
</form>
</body>
</html>
