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
String nexturl =request.getRequestURI()+"?"+request.getContextPath();
Community community = Community.find(teasession._strCommunity);
%>
 
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script type="text/javascript">
function f_edit()
{

  if(form2.membertype.value==-1)
  {
    alert("系统没有设置注册的会员类型，暂不能注册！");
    return false;
  }
}
</script>
<%=community.getJspBefore(teasession._nLanguage)%>
<h1>请选择注册会员类型</h1>
<%


 

  out.print("<form action=\"/jsp/mov/Transfer.jsp\" name=\"form2\" method=\"POST\" onsubmit=\"return f_edit();\" >");
	out.print("<input type=hidden name = nexturl value ="+nexturl+">");
  out.print("<input type=hidden name = next value=no> ");
  out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
 // out.print("<tr><td align=center colspan=5>");
 //out.print("以下是本站的会员类型，请选择注册！");
  out.print("</td></tr>");;
  out.print(" <tr id=tableonetr><td >会员类型</td> <td nowrap>服务说明</td></tr>");

  java.util.Enumeration typee = MemberType.find(teasession._strCommunity," AND type = 0 ",0,Integer.MAX_VALUE);
  if(!typee.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>系统暂不提供会员注册功能<input type=\"hidden\" name=\"membertype\"  value=-1></td></tr>");
   }
  boolean fa = false;
  for(int i =0;typee.hasMoreElements();i++)
  {
    int membertype = ((Integer)typee.nextElement()).intValue();
    MemberType mtyobj = MemberType.find(membertype);
    out.print("<tr>");

    out.print("<td nowrap><input type=\"radio\" name=\"membertype\"  value="+membertype);
    if(i==0)
      out.print(" checked=checked");
    out.print(">&nbsp;&nbsp;");


    out.print(mtyobj.getMembername());
    out.print("</td>");
 

    out.print("<td>");
    out.print(mtyobj.getCaption());
    out.print("</td>");

    out.print("</tr>");
    fa=true;
}
  out.print("</table><p><input type=\"submit\" value=\"下一步\" /></p></form>");

%>
<%=community.getJspAfter(teasession._nLanguage)%>
</body>
</html>

