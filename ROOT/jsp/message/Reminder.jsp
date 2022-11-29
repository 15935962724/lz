<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.im.*"%><%@page import="java.util.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="tea.db.*"%><% request.setCharacterEncoding("UTF-8");

String sn=request.getRemoteAddr();
//if(sn.equals("127.0.0.1"))return;



TeaSession teasession=new TeaSession(request);
if(request.getParameter("ajax")!=null)
{
  if(teasession._rv!=null)
  {
    String member=teasession._rv._strV;
    //
    if(!"webmaster".equals(member)&&Community.find(teasession._strCommunity).isLUnique()&&OnlineList.find(session.getId()).state==1)
    {
      session.removeAttribute("tea.RV");
      out.print("alert('您的账号在另一地点登录，您被迫下线。\\n\\n如果这不是您本人的操作，那么您的密码很可能\\n已经泄露。\\n建议您修改密码。');window.open('/servlet/Logout?nexturl=/','_top');");
      return;
    }
    //
    Profile p=Profile.find(member);
    String sql=Message.sql(0,p.getProfile())+" AND reader NOT LIKE " + DbAdapter.cite("%/" + member + "/%");
    int sum=Message.count(sql);
    out.print("var str =''; ");
    if(sum>0)
    {
      boolean isNew=true;
      StringBuffer msg=new StringBuffer();
      ArrayList al=Message.find(sql+" ORDER BY message DESC",0,10);
      for(int i=0;isNew&&i<al.size();i++)
      {
        int id=((Integer)al.get(i)).intValue();
        if(i==0)
        {
          isNew=id>MT.f(session.getAttribute("messageclose"),0);
          session.setAttribute("messageclose",new Integer(id));
        }
        Message m=Message.find(id);
        msg.append("<div style=display:"+(i>0?"none":"")+";>发信人:"+MT.f(m.getFrName(teasession._nLanguage),'；')+"<br/>主　题:<a href=/jsp/message/Message.jsp?folder=0&message="+id+">"+MT.f(m.subject,50)+"</a><br/><br/>共"+sum+"条 第"+(i+1)+"条");
        if(i>0)msg.append(" <a href=javascript:; onclick=t=parentNode;t.style.display='none';t.previousSibling.style.display='';>上一条</a>");
        if(i+1<al.size())msg.append(" <a href=javascript:; onclick=t=parentNode;t.style.display='none';t.nextSibling.style.display='';>下一条</a>");
        msg.append("</div>");
      }

      ProfileBBS pb=ProfileBBS.find(teasession._strCommunity,member);
      out.print("str='<a href=/jsp/message/Messages.jsp?folder=0&community="+teasession._strCommunity+" target=m ><img src=/tea/image/public/honglvdeng.gif>　有新信息（"+sum+"）</a>';");
      if(isNew)
      {
        if(pb.getCallSound()>0)
        out.print("str=str+'<bgsound src=/tea/audio/reminder/"+pb.getCallSound()+".wav loop=0 >';");
        if(pb.isMessage())
          out.print("rem_open('message','0',\""+msg.toString()+"\");");
      }
    }
    //
    int id=0,count=0;
    Enumeration e=ImMessage.find(teasession._strCommunity, " AND tmember=" + DbAdapter.cite(teasession._rv._strV)+" AND reader=0",0,Integer.MAX_VALUE);
    while(e.hasMoreElements())
    {
      ImMessage im=(ImMessage)e.nextElement();
      id=im.getImMessage();
      count++;
    }
    if(count>0)
    {
      out.print("str='<a href=/jsp/message/Messages.jsp?folder=0&community="+teasession._strCommunity+" target=m ><img src=/tea/image/public/honglvdeng.gif>　有新短信（"+count+"）</a>';");
      out.print("rem_open('immessage','"+id+"');");
    }
    out.print("document.getElementById('xinxitixing').innerHTML=str;");
  }
  return;
}

%>
//<script>
function rem_open(act,id,msg)
{
  //window.open('/jsp/message/ReminderDiglog.jsp?community=<%=teasession._strCommunity%>&act='+act+'&id='+id+'&list='+ms,'ReminderDialog','width=350,height=120,top='+(screen.height-260)+',left='+(screen.width-360)+',scrollbars=0,resizable=0,status=0');
  popup.show(msg,'收到新消息');
}

document.write("<span id=xinxitixing></span>");

function rem_refresh()
{
  //sendx("/jsp/message/Reminder.jsp?community=<%=teasession._strCommunity%>&ajax=ON",function(d){try{eval(d);}catch(e){}});
}
rem_refresh();
setInterval(rem_refresh,5000);
