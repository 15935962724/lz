<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession.getParameter("community");
int flow=Integer.parseInt(request.getParameter("flow"));
int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));

Flowbusiness fbobj=Flowbusiness.find(flowbusiness);
if(request.getMethod().equals("POST")||request.getParameter("back")!=null)
{
  //回传上一步骤
  if(request.getParameter("back")!=null)
  {
  }else
  {
  }
}


%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
</head>
<body onLoad="">
<h1>转交下一步骤 </h1>
<div id="head6"><img height="6" src="about:blank"></div>
<BR>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
Flowprocess nextobj=null;
java.util.Enumeration enumer=Flowprocess.find(flow," ORDER BY sequence");
for(int index=1;enumer.hasMoreElements();index++)
{
int flowprocess=((Integer)enumer.nextElement()).intValue();
Flowprocess obj=Flowprocess.find(flowprocess);

Flowview fvobj=Flowview.find(flowbusiness,obj.getSequence());


%>
<tr class="TableLine1">
  <td >第 <%=obj.getSequence()%> 步</td>
  <td ><%=obj.getName(teasession._nLanguage)%>
    <%
    if(fbobj.getStep()==obj.getSequence())
    out.print("(当前步骤)");
    else
    if(fbobj.getStep()<obj.getSequence()&&nextobj==null)
    {
      nextobj=obj;
      out.print("(下一步骤)");
    }
    %></td>
  <td nowrap><%if(fvobj.isExists()){out.print(fvobj.getMember());out.print(" [<font color=green>"+fvobj.getTime()+"</font>]");}%><br></td>
</tr>


<%}%>
</table>

  <%
  if(nextobj==null)
  {%>

  <input type="submit" value="结束流程"/>
<input type="button" value="返回" onClick="window.history.back();"/>

  <%
  }else
  {%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>请指定下一步骤的经办人:</td>
  <td>
  <%
    String members[]=nextobj.getMember().split("/");
    for(int i=0;i<members.length;i++)
    {
      if(members[i].length()>0)
      {
        out.println("<input name=member checked type=radio value="+members[i]+" />"+members[i]);
      }
    }
    %>

  </td></tr>
</table>
<input type="submit" value="提交"/>
<input type="button" value="返回" onClick="window.history.back();"/>
    <%
  }
  %>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
<BR>
</body>
</html>



