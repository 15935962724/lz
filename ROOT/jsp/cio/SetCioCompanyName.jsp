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

int ciocompany=Integer.parseInt(request.getParameter("ciocompany"));

CioCompany cc=CioCompany.find(ciocompany);


Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.name.focus();">

<h1>更改企业名称</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditCioCompany" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="ciocompany" value="<%=ciocompany%>"/>
<input type="hidden" name="act" value="setname"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenterbottom">
  <tr>
    <td nowrap><input name="name" type="text" value="<%=cc.getName()%>" size="40" /></td>
  </tr>
  <tr>
    <td class="td_02">
      <input type="submit" value="提交" onClick="return submitText(form1.name,'无效-企业集团名称');"/>
      <input type="button" value="关闭" onclick="window.close();"/>
    </td>
  </tr>
</table>
</form>

</div>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
