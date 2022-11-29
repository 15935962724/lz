<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.member.*" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;


Resource r=new Resource("/tea/resource/Workreport");



%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<!--手动发送工作日志-->
<h1><%=r.getString(teasession._nLanguage,"1173460497110")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

  <form name="form1" METHOD="post" action="/servlet/EditWorkreport" onSubmit="return fsubmit();">
    <input type=hidden name="community" value="<%=community%>"/>
      <input type=hidden name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
        <input type=hidden name="action" value="manualsendworklog"/>
        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr><td><%=r.getString(teasession._nLanguage,"Time")%>:</td>
            <td><%=new tea.htmlx.TimeSelection("time", null)%></td>
</tr>
<tr><td><td>
  <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"  onclick="">
</td></tr>
        </table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


