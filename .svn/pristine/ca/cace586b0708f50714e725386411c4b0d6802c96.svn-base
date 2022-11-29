<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member=teasession._rv._strV;

Resource r=new Resource();
String nu=request.getParameter("nexturl");

String name=null;
int cgroup=Integer.parseInt(request.getParameter("cgroup"));
if(cgroup>0)
{
  CGroup cg=CGroup.find(cgroup);
  name=cg.getName(teasession._nLanguage);
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.name.focus();">

<h1>我的组别</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<FORM name="form1" action="/servlet/EditCGroup" onsubmit="return submitText(this.name,'无效-名称');">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="cgroup" value="<%=cgroup%>">
<input type=hidden name="nexturl" value="<%=nu%>">
<input type=hidden name="act" value="edit">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>名称</td>
    <td><input name="name" value="<%if(name!=null)out.print(name);%>"></td>
  </tr>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
<input type="button" value="<%=r.getString(teasession._nLanguage,"返回")%>" onclick="history.back();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
