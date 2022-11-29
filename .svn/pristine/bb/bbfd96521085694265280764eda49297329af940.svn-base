package tea.ui.member.message;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.entity.admin.*;
import tea.entity.site.*;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.service.Robot;
import tea.ui.*;
import java.sql.SQLException;

public class UserMessage extends TeaServlet
{
  public void init(ServletConfig servletconfig) throws ServletException
  {
	super.init(servletconfig);
	super.r.add("tea/ui/member/message/NewMessage").add("tea/ui/member/messagefolder/ManageMessageFolders");
  }

  public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
	request.setCharacterEncoding("UTF-8");
	TeaSession teasession = new TeaSession(request);
	if (teasession._rv == null)
	{
	  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
	  return;
	}
	try
	{
	  String s = request.getRequestURI();


	  if (request.getMethod().equals("GET"))
	  {
		response.sendRedirect("/jsp/message/UserMessage.jsp?" + request.getQueryString());
	  } else
	  {
		int message = Integer.parseInt(teasession.getParameter("message"));
		Message obj = Message.find(message);
		String act = teasession.getParameter("act");

		//发送类型
		int radiotype = Integer.parseInt(teasession.getParameter("radiotype"));
		//会员ID if radiotype 等于1是
		String name = teasession.getParameter("name");
		//同时发送到该人员的外部邮箱
        boolean sendemail = teasession.getParameter("sendemail") != null; //同时发送到该人员的外部邮箱
        String sms = teasession.getParameter("sms"); //短信内容

		//外部邮件 if radiotype 等于2是
		String emailname = teasession.getParameter("emailname");
		String to ="/";
		String sj ="/";
	   if(radiotype==1 && sendemail )// 发送会员
	   {
		   for(int i=1;i<name.split("/").length;i++)
		   {
			   String member = name.split("/")[i];
			   Profile pobj = Profile.find(member);
			   to = to+member+"/";
			   sj = sj+pobj.getMobile()+"/";
		   }
	   }else if (radiotype==2)
	   {
		   sms="";
		   to = emailname;
		   if(emailname.indexOf(",")==-1)
		   {
			   to = "/"+emailname+"/";
		   }else
		   {
			   to=","+emailname.replaceAll(",","/");

		   }
		   sendemail=true;
	   }

//		if(to.length()>1){//验证邮件发送人员是否合法
//			String[] tm = to.split("/");
//			if(!Profile.isExisted(tm[1])){
//				response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidMemberId"), "UTF-8"));
//				return;
//			}
//		}

		String tunit = teasession.getParameter("tunit"); // 部门
		String trole = teasession.getParameter("trole"); // 角色
		//String tgroup = teasession.getParameter("tgroup"); // 通讯录
		//String tcommunity = teasession.getParameter("tcommunity"); // 社区

		int hint = Integer.parseInt(teasession.getParameter("hint"));//提示符
		String subject = teasession.getParameter("subject");//主题
		String content = teasession.getParameter("content");//内容


		if (subject.length() < 1)
		{
		  outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidSubject"));
		  return;
		}


		int status = 5;//保存到发件箱
		if (teasession.getParameter("sent") != null)
		{
		  status = 1;
		}
		if (teasession.getParameter("draft") != null)//草稿
		{
		  status = 2;
		}
		boolean feedback = teasession.getParameter("feedback") != null;//收件人查看时自动给我发送回馈


		String picture = null;
		byte abyte0[] = teasession.getBytesParameter("picture");
		if (abyte0 != null)
		{
		  picture = write(teasession._strCommunity, abyte0, ".gif");
		}
		String voice = null;
		byte abyte1[] = teasession.getBytesParameter("voice");
		if (abyte1 != null)
		{
		  voice = write(teasession._strCommunity, abyte1, ".wmv");
		}
		String filename = null, filepath = null;
		byte abyte2[] = teasession.getBytesParameter("file");
		if (abyte2 != null)
		{
		  filepath = write(teasession._strCommunity, abyte2, ".doc");
		  filename = teasession.getParameter("fileName");
		}

		obj.set(status, to, trole, tunit, hint, teasession._nLanguage, subject, content, feedback);

		if (sms != null && sendemail)//发送短信
		{
            for(int i = 1;i < sj.split("/").length;i++)
            {
              // tea.entity.member.SMSMessage.create(teasession._strCommunity, teasession._rv._strV, "手机号码", "信息资源提示您：你有一个质疑未查看，请及时处理!");
			   SMSMessage.create(teasession._strCommunity, teasession._rv._strR, sj.split("/")[i], teasession._nLanguage, sms);
            }
		}

		if (sendemail)//发送外部邮件
		{
		  //Robot.activateRoboty(teasession._nNode, message);
		  for(int i = 1;i<to.split("/").length;i++)
		  {
              tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
              se.sendEmail(to.split("/")[i],subject,content);
          }
		}


		String nexturl = request.getParameter("nexturl");
		if (nexturl == null)
		{
		  nexturl = "/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InfMessageSent"), "UTF-8")+"&nexturl=/html/node/"+teasession._nNode+"-"+teasession._nLanguage+".htm";
		}
		response.sendRedirect(nexturl);
	  }
	} catch (Exception exception)
	{
	  response.sendError(400, exception.toString());
	  exception.printStackTrace();
	}
  }
}
