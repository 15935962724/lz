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

Flow f=Flow.find(flow);
Flowbusiness fb=Flowbusiness.find(flowbusiness);

%><html>
<head>
<title>流程图</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="window.focus();">


<%=fb.getFlowviewToHtml(teasession._nLanguage)%>


<%--
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr class="TableHeader">
    <td nowrap align="center"> 步骤号 </td>
    <td nowrap align="center"> 步骤名称 </td>
    <td nowrap> 办理状态、经办人、办理时间 </td>
  </tr>
  <tr class="TableLine2">
    <td nowrap align="center" colspan="3">
      开始 <br>      ↓</td>
  </tr>
<%
java.util.Enumeration enumer=Flowprocess.find(flow," ORDER BY sequence");
for(int index=1;enumer.hasMoreElements();index++)
{
  int flowprocess=((Integer)enumer.nextElement()).intValue();
  Flowprocess fp=Flowprocess.find(flowprocess);

  Flowview fv_fp=Flowview.find(flowbusiness,fp.getStep());

  String member=fv_fp.getMember();
  String consign=fv_fp.getConsign();
%>
    <tr class="TableLine1">
      <td nowrap align="center">第 <%=fp.getStep()%> 步</td>
      <td nowrap align="center"><%=fp.getName(teasession._nLanguage)%></td>
      <td nowrap>
      <%
      if(fv_fp.isExists())
      {
        if(fb.getStep()==fp.getStep())
        {
          out.println("已接收");
        }else
        if(fb.getStep()>fp.getStep())
        {
          out.println("已结束");
        }
        out.print(member);
        Profile p=Profile.find(member);
        out.print(p.getName(teasession._nLanguage));

        if(consign!=null&&consign.length())
        {
          p=Profile.find(consign);
          out.print(" → "+p.getName(teasession._nLanguage));
        }
        out.print(" [<font color=green>"+fv_fp.getTimeToString()+"</font>]");
      }else
      {
        out.println("未接收");
      }
      %><br></td>
    </tr>
    <tr class="TableLine2">
      <td nowrap align="center" colspan="3">↓</td>
    </tr>

<%}%>
<tr class="TableLine2">
  <td class=huiditable  nowrap align="center" colspan="3">  结束 </td>
</tr>
</table>

--%>

<br>
<div align="center">
<input type="button" value="关闭" class="BigButton" onClick="window.close();">
</div>

</body>
</html>
