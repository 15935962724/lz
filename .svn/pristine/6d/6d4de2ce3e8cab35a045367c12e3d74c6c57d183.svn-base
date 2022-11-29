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

Resource r=new Resource();

String name=null;
int tid=Integer.parseInt(request.getParameter("tid"));
if(tid>0)
{
name = Attenddance.findTname(tid,teasession._strCommunity);
}

%><HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>
<body onload="form1.name.focus();">

<h1>值班类型</h1>

<br>

<FORM name="form1" action="/servlet/EditType" method="POST" onsubmit="return submitText(this.name,'无效-名称');">
<input type="hidden" name="tid" value="<%=tid%>"/>
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
</HTML>
