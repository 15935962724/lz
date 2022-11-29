<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@page import="tea.service.*" %><%@page import="tea.entity.netdisk.*" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int filecenter=0;
String tmp=request.getParameter("filecenter");
if(tmp!=null)
{
  filecenter=Integer.parseInt(tmp);
}

String info=request.getParameter("info");

%><html>
<head>
<title><%=info%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_submit()
{
  if(form1.filecenter)
  {
    dialogArguments.document.form1.filecenter.value=form1.filecenter.value;
  }
  window.returnValue=true;
  window.close();
  return false;
}
</script>
</head>
<body>
<h1>结束流程</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="?" method="POST">

<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>
<%
FileCenter fc=FileCenter.find(filecenter);
if(fc.isExists())
{
  out.print("<tr><td>请指定文件归档位置:</td><td><select name='filecenter'>");
  Enumeration e=FileCenter.findByFather(teasession._strCommunity,fc.getFather(),null,false);
  while(e.hasMoreElements())
  {
    int fid=((Integer)e.nextElement()).intValue();
    fc=FileCenter.find(fid);
    out.print("<option value="+fid);
    if(filecenter==fid)
    out.print(" selected");
    out.print(">"+fc.getSubject());
  }
  out.print("</select>");
}
%>
<tr>
  <td colspan="2"><%=info%></td>
</tr>
</table>
<input type="submit" value="提交" onclick="return f_submit();"/>
<input type="button" value="关闭" onclick="window.close();"/>

</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
