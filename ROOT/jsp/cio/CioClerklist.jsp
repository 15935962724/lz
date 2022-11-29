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
String ccid = teasession.getParameter("ccid");

StringBuilder sql=new StringBuilder();
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script>
  window.name="ccldclerklist";
  function test(theform)
  {

    theform.submit();
    window.close();
  }
  </script>


</head>
<body bgcolor="#ffffff">
<h1>
接送人员列表
</h1>
<form name="form1" action="/servlet/EditCioPart" enctype="multipart/form-data"  target="ccldclerklist">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenterleft2" style="background:none;">
<input type="hidden" value="<%=ccid%>" name="ccid">
<input type="hidden" value="CioClerklist" name="act">
 <tr><td  align="left" style="background:none;"><select name="sname">
<%
Enumeration cioclerk = CioClerk.find("",0,Integer.MAX_VALUE) ;
if(!cioclerk.hasMoreElements())
{
  %>
   <option>暂无联系人</option>
  <%
}
while(cioclerk.hasMoreElements())
{
  CioClerk cc=(CioClerk)cioclerk.nextElement();
  out.print("<option value="+cc.getId()+">"+cc.getSname()+":"+cc.getStel()+"</option>");
}
%>
</select></td>
</tr>
</table>
<input type="submit"  value="提交" onClick="test(this.form);">
</form>
</body>
</html>
