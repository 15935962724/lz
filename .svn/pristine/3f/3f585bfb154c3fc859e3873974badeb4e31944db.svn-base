<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession.getParameter("community");
int flow=Integer.parseInt(request.getParameter("flow"));
int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));
int setp=Integer.parseInt(request.getParameter("setp"));

Flow f=Flow.find(flow);
Flowprocess fp=Flowprocess.find(flow,setp);
Flowbusiness fb=Flowbusiness.find(flowbusiness);

%><html>
<head>
<title><%=fp.getName(teasession._nLanguage)%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="window.focus();">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr class="TableHeader">
    <td nowrap>经办人 </td>
    <td nowrap>办理状态 </td>
    <td nowrap>办理时间 </td>
  </tr>
<%
int fvid=0;
DbAdapter db = new DbAdapter();
try
{
  db.executeQuery("SELECT flowview FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess=" + fp.getFlowprocess());
  while (db.next())
  {
    fvid=db.getInt(1);
    Flowview fv=Flowview.find(fvid);
    String member=fv.getTransactor();
    String consign=fv.getConsign();
    out.print("<tr class='TableLine2'><td>");
    out.print(member);
    if(consign!=null&&consign.length()>0)
    {
      out.print(" → "+consign);
    }
    out.print("<td>"+Flowview.STATE_TYPE[fv.getState()]);
    out.print("<td><font color=green>"+fv.getTimeToString()+"</font>");
  }
} finally
{
  db.close();
}
if(fvid<1)
{
  out.println("<tr><td colspan='3' align='center'>无记录</td>");
}
%>
</table>

<br>
<div align="center">
<input type="button" value="关闭" class="BigButton" onClick="window.close();">
</div>

</body>
</html>
