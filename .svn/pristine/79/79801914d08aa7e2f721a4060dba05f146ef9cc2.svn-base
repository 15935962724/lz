<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.*" %>
<%@page import="rath.msnm.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

//http://127.0.0.1:86/jsp/msn/MsnLogin.jsp?community=DEV

if(request.getParameter("connect")!=null)
{
  TeaSession teasession=new TeaSession(request);
  String community=teasession._strCommunity;

  String name=Msntemp.findOffline(community);
  if(name==null)
  {
    out.print("服务器端忙,请稍后连接... ...");
    return;
  }
  Msntemp obj=Msntemp.find(name);
  int type=obj.login(session.getId(),request.getRemoteAddr());
  switch(type)
  {
    case 0:
    out.print("连接失败... ...");
    break;
    case 1:
    out.print("客服不在线... ...");
    break;
    case 2:
    out.println("<script>window.open('MsnFrame.jsp?name="+name+"&community="+community+"','dialog');</script>");
    break;
  }
//  for(int index=0;index<50;index++)
//  {
//    Thread.sleep(1000L);
//    Enumeration enumer=Msnmessage.findByCustomer(name,session.getId(),0);
//    while(enumer.hasMoreElements())
//    {
//      Msnmessage obj=(Msnmessage)enumer.nextElement();
//      if(obj.getType()==2)
//      {
//        out.println("连接在线客服...<br>");
//        out.flush();
//        Thread.sleep(1000L);
//        ArrayList al=new ArrayList();
//        Iterator iterator = msn.getBuddyGroup().getForwardList().iterator();
//        while (iterator.hasNext())
//        {
//          rath.msnm.entity.MsnFriend friend = (rath.msnm.entity.MsnFriend) iterator.next();
//          System.out.println(friend.getLoginName() + ":" + friend.getStatus());
//          if (!rath.msnm.UserStatus.OFFLINE.equals(friend.getStatus()))
//          {
//            al.add(friend.getLoginName());
//          }
//        }
//        if (al.size() > 0)
//        {
//          Random r = new Random();
//          Object friends[] =al.toArray();
//          String service =(String) friends[r.nextInt(friends.length)];
//
//          session.setAttribute("tea.MSNMessenger",msn);
//          session.setAttribute("tea.MSNAdapter",msnadapter);
//          session.setAttribute("tea.MSNService",service);
//          session.setAttribute("tea.MSNCustomer",name);
//          out.println("<script>window.open('MsnFrame.jsp?name="+name+"&service="+service+"&community="+community+"','dialog');</script>");
//          //out.println("<script>window.location.replace('Frame.jsp?name="+name+"&service="+service+"');</script>");
//        }else
//        {
//          //Msnmessage.create(session.getId(), name, service, "无客服人员", 4, request.getRemoteAddr(), community);
//          out.println("客服不在线");
//          msntemp.setStatus(rath.msnm.UserStatus.OFFLINE);
//          msn.logout();
//        }
//        obj.delete();
//        return;
//      }else
//      {
//        if(obj.getType()==3)
//        {
//          out.println("登陆失败");
//          msntemp.setStatus(rath.msnm.UserStatus.OFFLINE);
//          return;
//        }else
//        if(obj.getType()==4)
//        {
//          out.println("客服不在线");
//          msntemp.setStatus(rath.msnm.UserStatus.OFFLINE);
//          msn.logout();
//          return;
//        }
//      }
//    }
//  }
}else
{%>
<html>
<head>
<title></title>
<script type="">
this.name="dialog";
</script>
</head>
<body>
连接中,请稍等.....
<br>
<iframe src="?<%=request.getQueryString()%>&connect=ON" frameborder=0 ></iframe>
<%
}
%>
</body>
</html>
