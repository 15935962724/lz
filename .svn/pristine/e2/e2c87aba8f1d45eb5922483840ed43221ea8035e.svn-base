<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=request.getParameter("id");
String nexturl=request.getParameter("nexturl");

//member="0152";

String  ciocompany=null;

String sname="";
String stel="";
int cioclerk=0;
if(teasession.getParameter("cioclerk")!=null && teasession.getParameter("cioclerk").length()>0)
{
  cioclerk=Integer.parseInt(teasession.getParameter("cioclerk"));
  CioClerk cioobj=CioClerk.find(cioclerk);
  sname=cioobj.getSname();
  stel=cioobj.getStel();
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<script  language="JAVASCRIPT">
function table_js()
{
  if(form1.sname.value=="" )
  {
    alert("姓名不能为空,请重新填写！");
    return false;
  }
  if(form1.stel.value=="" )
  {
    alert("联系方式不能为空,请重新填写！");
    return false;
  }
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="qiyelog">
<form name="form1" action="/servlet/EditCioPart" method="post">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

<input type="hidden" name="cioclerk" value="<%=cioclerk%>"/>
<input type="hidden" name="act" value="cioclerk"/>
<input type="hidden" name="ciocompany" value="<%=ciocompany%>"/>
<h1>参会接送人员列表</h1>
<table border="0" cellpadding="0" cellspacing="0" id="qiy_xx_table">
  <tr><td>姓名：</td><td><input name="sname"  value="<%if(sname!=null && sname.length()>0){out.print(sname);}%>" /></td></tr>
  <tr><td>联系方式：</td><td><input name="stel"  value="<%if(stel!=null && stel.length()>0){out.print(stel);}%>" /></td></tr>
    <tr><td  colspan="2" align="center">

      <input align="middle"  type="submit" value="提交"  onclick="return table_js()" />
      <input type="button" value="返回" onclick="history.back();" />
</td></tr>
</table>
</form>
</body>
</html>
