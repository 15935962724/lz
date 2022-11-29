<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.ui.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();


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
<!--
<h1>全体人员</h1>
<div id=head6><img height=6 src=about:blank></div>
<br>
-->

<%

java.util.Enumeration e=AdminUnit.findByCommunity(teasession._strCommunity,"");
for(int j=1;e.hasMoreElements();j++)
{
  AdminUnit au=(AdminUnit)e.nextElement();
  int unltid=au.getId();
  out.print(toHtml(teasession,unltid, au.getPrefix()+ au.getName()));
}
out.print(toHtml(teasession,0,"无部门"));

%>

</body>
</html>


<%!
public String toHtml(TeaSession teasession,int unilid,String name)throws Exception
{
  StringBuffer sb=new StringBuffer();
  java.util.Enumeration enumer_pro=AdminUsrRole.findByUnit(unilid,teasession._strCommunity);
  if(enumer_pro.hasMoreElements())
  {
    sb.append("<h2>").append(name).append("</h2><div id=head6><img height=6 src=about:blank></div> <table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
    while(enumer_pro.hasMoreElements())
    {
      String member=(String)enumer_pro.nextElement();
      Profile p=Profile.find(member);
      if(p!=null)
      {
        sb.append("<tr><td>").append(p.getName(teasession._nLanguage));
        sb.append("<td><A href=\"/jsp/message/NewMessage.jsp?community=").append(teasession._strCommunity).append("&receiver=").append(java.net.URLEncoder.encode(member,"UTF-8")).append("\" target=_blank ><img src=/tea/image/public/message.gif></a>");
        sb.append(" <A href=\"/jsp/sms/EditSMSMessage.jsp?community=").append(teasession._strCommunity).append("&to=").append(p.getMobile()).append("\" target=_blank ><img src=/tea/image/public/sms.gif></a>");
      }
    }
    sb.append("</table>");
  }
  return sb.toString();
}
%>

