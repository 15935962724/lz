<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@page import="tea.entity.*"%>
<%@ page import="tea.ui.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

OnlineList o=OnlineList.find(session.getId());
if(o.getTime()==null)
{
  OnlineList.create(session.getId(),teasession._strCommunity,request.getRemoteAddr());
}else
{
  o.set(teasession._strCommunity,request.getRemoteAddr());
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
<body>
<!--
<h1>在线会员</h1>
<div id=head6><img height=6 src=about:blank></div>
<br>
-->
<%
int old=-1;
ArrayList al=new ArrayList();
DbAdapter db = new DbAdapter(1);
try
{
  db.executeQuery("SELECT ol.member FROM OnlineList ol INNER JOIN AdminUsrRole aur ON ol.member=aur.member AND ol.community="+db.cite(teasession._strCommunity,1)+" AND aur.community="+db.cite(teasession._strCommunity,1)+" ORDER BY aur.unit DESC,aur.sequence");
  while (db.next())
  {
    String member=db.getString(1);
    if(al.indexOf(member)==-1)//防重
    {
      al.add(member);
      Profile p=Profile.find(member);
      AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,member);
      if(old!=aur.getUnit())
      {
        old=aur.getUnit();
        out.print("</table><h2>");
        if(old==0)
        out.print("无部门");
        else
        out.print(AdminUnit.find(old).getName());
        out.print("</h2><div id=head6><img height=6 src=about:blank></div> <table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
      }
      out.print("<tr><td>"+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
      out.print("<td><A href=\"/jsp/message/NewMessage.jsp?community="+teasession._strCommunity+"&receiver="+java.net.URLEncoder.encode(member,"UTF-8")+"\" target=_blank ><img src=/tea/image/public/message.gif></a>");
      out.print(" <A href=\"/jsp/sms/EditSMSMessage.jsp?community="+teasession._strCommunity+"&to="+p.getMobile()+"\" target=_blank ><img src=/tea/image/public/sms.gif></a>");
    }
  }
  out.print("</table>");
} finally
{
  db.close();
}

%>
</body>
</html>

