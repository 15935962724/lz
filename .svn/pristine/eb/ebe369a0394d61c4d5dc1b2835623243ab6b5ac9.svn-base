package tea.ui.member.sms;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.member.*;
import tea.entity.admin.*;
import tea.ui.*;
import java.sql.SQLException;
import java.net.*;

public class EditSMSMessage extends TeaServlet
{

    // Initialize global variables
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/resource/SMS");
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if(request.getParameter("delete") != null)
            {
                String smsmessage[] = request.getParameterValues("smsmessage");
                if(smsmessage != null)
                {
                    for(int index = 0;index < smsmessage.length;index++)
                    {
                        SMSMessage obj = SMSMessage.find(Integer.parseInt(smsmessage[index]));
                        obj.delete();
                    }
                }
                if("true".equals(request.getParameter("type")))
                { // 删除回复的内容
                    response.sendRedirect("/jsp/sms/SMSRMessageList.jsp?node=" + teasession._nNode);
                } else
                { // 删除发送的内容
                    response.sendRedirect("/jsp/sms/SMSMessageList.jsp?node=" + teasession._nNode);
                }
            } else
            {
                //String mobile = request.getParameter("mobile");
                StringBuilder m = new StringBuilder();
                String tmember = request.getParameter("tmember");
                String tms[] = tmember.split("/");
                for(int i = 1;i < tms.length;i++)
                {
                    Profile p = Profile.find(tms[i]);
                    m.append(p.getMobile()).append(",");
                }
                String tunit = request.getParameter("tunit");
                String tus[] = tunit.split("/");
                for(int i = 1;i < tus.length;i++)
                {
                    Enumeration e = AdminUsrRole.find(teasession._strCommunity," AND (unit=" + tus[i] + " OR classes LIKE '%/" + tus[i] + "/%')",0,Integer.MAX_VALUE);
                    while(e.hasMoreElements())
                    {
                        String member = (String) e.nextElement();
                        Profile p = Profile.find(member);
                        String mob = p.getMobile();
                        if(m.indexOf(mob) == -1)
                        {
                            m.append(mob).append(",");
                        }
                    }
                }
                String content = request.getParameter("content");
                String rs = SMSMessage.create(teasession._strCommunity,teasession._rv._strV,m.toString(),teasession._nLanguage,content);
                if(rs == null)
                {
                    rs = "发送成功";
                }
                response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(rs,"UTF-8"));
            }
        } catch(Exception e)
        {
            e.printStackTrace();
            response.sendError(500,e.getMessage());
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
