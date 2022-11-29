<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.TeaSession" %>
<%@ page import="tea.db.DbAdapter" %>
<%
TeaSession teasession=new TeaSession(request);
request.setCharacterEncoding("UTF-8");
DbAdapter db=new DbAdapter();
String id =teasession.getParameter("id");

try {

String sql="delete adminusrrole where community='lankuaiOA' and member!='webmaster'" ;
String flag=request.getParameter("flag");
if(flag!=null&&flag.length()>0){
  db.executeUpdate(sql);
  response.sendRedirect("/jsp/contract/useraudit/useraudit.jsp?role="+request.getParameter("role"));
}

}
catch(Exception e){
  e.printStackTrace();
}
finally{
  db.close();
}
%>
<script type="">
  function f_shenhe()
  {
    alert(111);
    form1.flag.value ='delete';
  }
  </script>
<html>
<head>
</head>
<body >
<h1>

</h1>
<form action="?" name="form1" method="POST" onSubmit="return f_shenhe()";>
<input  type="hidden" name="flag"/>
<input type="hidden" name="id"  value="<%=id%>" />
<input type="submit" value="取消用户审核"/>
</form>
</body>
</html>
