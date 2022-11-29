<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.integral.*" %>

<%@page import="java.io.*" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.util.*"%>
<%@page import="java.lang.*"%>
<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);

String value = teasession.getParameter("value");
String name =  teasession.getParameter("name");
String username = teasession.getParameter("username");
String password =  teasession.getParameter("password");

 
    if(Profile.isExist(username,password))
    {
      Profile p=Profile.find(username);
      float point=p.getIntegral();
      CommunityPoints cp= CommunityPoints.find( CommunityPoints.getIgid(teasession._strCommunity));
      if(point<cp.getSjhyjf())
      {out.print("<div class=Sorry>"+username+"您好! 您的积分是<span>"+point+"</span><div>很抱歉,只有积分达到"+cp.getSjhyjf()+"分才能升级为高级会员,请继续努力，增加您的积分。<a href=/html/node/2204515-1.htm target=\"_blan;\">积分增加方式</a></div></div>");
      }else
      {out.print("<div class=Cong>"+username+"您好! 恭喜您,您的积分已经达到"+cp.getSjhyjf()+"分,可以升级为高级会员 <br/><input type='button' value='下一步' onclick='editmember()'></div>");
      }
    }else
    {
      out.print("<div class=No><font color=green>对不起,不存在该账户!</font></div>");
    }
  


%>

