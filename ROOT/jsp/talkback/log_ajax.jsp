<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="javax.servlet.http.*"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);

String act = teasession.getParameter("act");
String nexturl = teasession.getParameter("nexturl");
if("Talkbacks_f_submit_3".equals(act))
{
  String yonghuming = teasession.getParameter("yonghuming");
  String mima = teasession.getParameter("mima");
  RV rv = new RV(yonghuming);

  if(!Profile.isPassword(rv._strV,mima)) // lt,
  {
    out.print("您填写的用户名或密码错误,请重新填写");
    return;
  }else
  {
    Profile p = Profile.find(yonghuming);
    Cookie cs = new Cookie("tea.RV",java.net.URLEncoder.encode(yonghuming + "," +tea.service.SMS.md5(String.valueOf(p.getTime().getTime())),"UTF-8"));
    cs.setPath("/");
    String sn = request.getServerName();
    int j = sn.indexOf(".");
    if(j != -1 && sn.charAt(sn.length() - 1) > 96)
    {
      cs.setDomain(sn.substring(j));
    }
    response.addCookie(cs);

    out.print(yonghuming+"&nbsp;|&nbsp;");
    out.print("<a  href=\"/servlet/Logout?community="+teasession._strCommunity+"&nexturl="+nexturl+" target=\"_top\">退出</a>");


  }
}
%>

