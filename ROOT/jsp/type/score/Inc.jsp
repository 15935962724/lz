<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.entity.node.*" %><%

TeaSession teasession=new TeaSession(request);


//int t=Integer.parseInt(request.getParameter("t"));
//if(t==1)
{
  if(teasession._rv==null)
  out.print("<!--您还没有登陆!-->");
  else
  {
    String member=teasession._rv.toString();
    out.print("欢迎"+member+"回来!<br/>您的即时差点指数:");
    if(Score.getIndex(member)!=-10000)
    {
    	out.print(Score.getIndex(member));
    }else
    {
    	out.print("无");
    }
  }
}
%>
