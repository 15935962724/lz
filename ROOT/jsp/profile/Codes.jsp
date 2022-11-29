<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


if (!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(teasession._strCommunity))
{
    response.sendError(403);
    return;
}

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function flen(obj,text)
{
  if(obj.value<1||obj.value>1000)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
</head>
<body>

<h1>会员充值情况</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>面值</td><td><%=request.getParameter("parvalue")%></td></tr>
<tr id="tableonetr"><td>卡号</td>
<td>会员</td>
<td>充值日期</td>
</tr>
<%
int pos=0;
java.util.Date time = new java.util.Date(Long.parseLong(request.getParameter("time")));
java.util.Enumeration enumer=Code.find(teasession._strCommunity,time,pos,Integer.MAX_VALUE);
while(enumer.hasMoreElements())
{
  Code obj=(Code)enumer.nextElement();
  %>
<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
<td><%=obj.getSymbol()+obj.getCode()%></td>
<td>&nbsp;<%=obj.getMember()%></td>
<td>&nbsp;<%=obj.getTime2ToString()%></td>
</tr>
<%
}
%>
</table>

<div id="head6"><img height="6" alt=""></div>
</body>
</html>
