<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page import="tea.entity.admin.office.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

int sealapply = Integer.parseInt(request.getParameter("sealapply"));
String nexturl = request.getParameter("nexturl");
String examinetype = request.getParameter("examinetype");


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>

<body>

<h1>用印审批不同意-填写原因</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name=form1 METHOD=post action="/servlet/EditSealapply">
<input type=hidden name="act" value="Noauditying"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="examinetype" value="<%=examinetype%>"/>
<input type=hidden name="sealapply" value="<%=sealapply%>"/>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>不批准使用原因:</td>
   <td><textarea name="notcausation" rows="5" cols="30"></textarea></td>
  </tr>

</table>
<input type="submit" value="提交原因" >
<input type="button" value="返回" onClick="history.back();">
</FORM>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
