<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
  if (teasession._rv.toString() == null) {
    response.sendRedirect("/servlet/Node?node=14856&language=1");
    return;
  }
  String member = request.getParameter("mem");
  if(member!=null && member.length()>0)
  {
    if(Profile.isExisted(member))
    {
      out.print("<font color=red><b>次用户已经存在，请您重新填写!</b></font>");
    }else
    {
      out.print("<font color=green><b>恭喜您，次用户可以使用，请您继续填写下面内容!</b></font>");
    }
  }


%>
<html><head>
<title>
<tr>
<td>
<font color="red"></font>
</td>
</tr>
</title>
</head></html>
