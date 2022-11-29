<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page  import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="javax.mail.Folder" %>
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

int showcount=Integer.parseInt(request.getParameter("showcount"));
int igd=Integer.parseInt(request.getParameter("menuid"));

String sn=request.getServerName()+":"+request.getServerPort();
String jsessionid=request.getParameter("jsessionid");
if(jsessionid!=null)
	jsessionid="&jsessionid="+jsessionid;
else
	jsessionid="";

if(request.getParameter("ajax")!=null)
{
	Enumeration e=EmailBox.find(teasession._strCommunity,teasession._rv._strR);
    if(!e.hasMoreElements())
    {
      out.print("您没有设置邮箱,点击<a href=/jsp/message/EditEmailBox.jsp?community="+teasession._strCommunity+" target=_blank >这里</a>设置你的邮箱.");
    }else
	for(int j=1;j<showcount&&e.hasMoreElements();j++)
	{
		String s=(String)e.nextElement();
		EmailBox obj=EmailBox.find(teasession._strCommunity,teasession._rv._strR,s);
		Folder folder=obj.openFolder();
		out.print("<div id=ftl_"+igd+"_"+j+"00 class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"00' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+"00)'></a>");
		if(folder!=null)
		{
			int count=folder.getMessageCount();
			out.print("  <a target=_blank href='http://"+sn+"/jsp/message/Emails.jsp?community="+teasession._strCommunity+"&EmailBox="+s+jsessionid+"' >"+s+"　("+count+")</a><br>");
			out.print("  <div id=fb_"+igd+"_"+j+"00 class='fpad fb' style='display:none'>");
			for(int i=count;count-i<10&&i>0;i--)
			{
				javax.mail.Message m=folder.getMessage(i-1);
				java.util.Date date=m.getSentDate();
				String subject=m.getSubject();
                if(subject==null)
                	subject="< No Subject >";
                else
				if(subject.length()>15)
					subject=subject.substring(0,15)+"...";
				out.print("<a target=_blank href=http://"+sn+"/servlet/Email?EmailBox="+s+"&EmailNo="+(i-1)+jsessionid+" >"+subject+"</a>");

				if(date!=null)
					out.print("　　"+Entity.sdf2.format(m.getSentDate()));
				out.print("<br/>");//m.getFrom()[0]+
			}
			out.print("  </div>");
		}else
		{
			out.print("  <a target=_blank href='http://"+sn+"/jsp/message/Emails.jsp?community="+teasession._strCommunity+"&EmailBox="+s+jsessionid+"' >"+s+"　(错误)</a><br>");
			out.print("  <div id=fb_"+igd+"_"+j+"00 class='fpad fb' style='display:none'>");
			out.print("读邮件出错....");
			out.print("  </div>");
		}
		out.print("</div>");
	}
	return;
}

/*out.print("<div id=modboxmenu><a href=javascript:f_im(false)  >内部消息</a> <a href=javascript:f_im(true) >Internet邮箱</a></div>");
out.print("<DIV id=inner_message>");
int j=1;
for(Enumeration e=Message.find("Inbox", teasession._rv, 0, showcount);e.hasMoreElements();j++)
{
	int k = ((Integer)e.nextElement()).intValue();
	Message message=Message.find(k);
	String subject = message.getSubject(teasession._nLanguage);
	String content=message.getContent(teasession._nLanguage);
	if(content.length()>150)
		content=content.substring(0,150)+"...";
	out.print("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
	out.print("  <a target=_blank href='http://"+sn+"/jsp/message/Message.jsp?community="+teasession._strCommunity+"&Folder=Inbox&Message="+k+jsessionid+"' >"+subject+"　　"+message.getTimeToString()+"</a><br>");
	out.print("  <div id=fb_"+igd+"_"+j+" class='fpad fb' style='display:none'>");
	out.print(content);
	out.print("  </div>");
	out.print("</div>");
}
out.print("</DIV>");
*/

out.print("<DIV id=integer_email >");
out.print("<img src=/tea/image/public/load.gif >正在加载...");
out.print("</DIV>");
out.print("<script>sendx('http://"+sn+"/jsp/admin/ig/IgEmail.jsp?ajax=ON&community="+teasession._strCommunity+"&igd="+igd+"&showcount="+showcount+jsessionid+"',function(data){integer_email.innerHTML=data;} );</script>");

%>



