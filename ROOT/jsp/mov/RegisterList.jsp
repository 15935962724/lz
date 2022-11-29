<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
//if(teasession._rv==null)
//{
//  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
//  return;
//}
String nexturl =null;

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<%

  java.util.Enumeration typee = MemberType.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
  if(typee.hasMoreElements())
  {
    out.print("<form action=\"/jsp/mov/Transfer.jsp\" name=\"form2\" method=\"POST\" >");
    out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
    out.print("<tr><td align=center colspan=5>&nbsp;您可以选择下列会员注册</td></tr>");
    out.print(" <tr id=tableonetr> <td width=1>&nbsp;</td> <td nowrap>会员类型</td> <td nowrap>服务费用</td><td nowrap>服务说明</td></tr>");
  }
  boolean fa = false;
  for(int i =0;typee.hasMoreElements();i++)
  {
    int membertype = ((Integer)typee.nextElement()).intValue();
    MemberType mtyobj = MemberType.find(membertype);
    out.print("<tr>");

    out.print("<td width=1><input type=\"radio\" name=\"membertype\"  value="+membertype);
    if(i==0)
      out.print(" checked=checked");
    out.print("></td>");

    out.print("<td>");
    out.print(mtyobj.getMembername());
    out.print("</td>");
    out.print("<td>");
    java.util.Enumeration mpe = MemberPay.find(teasession._strCommunity," AND membertype="+membertype,0,Integer.MAX_VALUE);
    while(mpe.hasMoreElements())
    {
      int payid = ((Integer)mpe.nextElement()).intValue();
      MemberPay mpobj = MemberPay.find(payid);
      out.print(mpobj.getPaytime()+"年"+mpobj.getPaymoney()+"元<br>");
    }
    out.print("</td>");

    out.print("<td>");
    out.print(mtyobj.getCaption());
    out.print("</td>");

    out.print("</tr>");
    fa=true;
}


  out.print("</table><p><input type=\"submit\" value=\"下一步\" /></p></form>");

%>
</body>
</html>

