package tea.ui.member.meeting;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Meeting;
import tea.html.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class MeetingServlet extends TeaServlet
{

    public MeetingServlet()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/meeting/Meeting.jsp" + qs);

            /* PrintWriter printwriter = new PrintWriter(new OutputStreamWriter(response.getOutputStream()));
               printwriter.println("<HTML><HEAD><META HTTP-EQUIV=Content-Type CONTENT=\"text/html; charset=" + TeaServlet.CHARSET[teasession._nLanguage] + "\">" + "</HEAD>");
               int i = 0;
               do
               {
                   for(Enumeration enumeration = Meeting.findByMember(teasession._rv, i); enumeration.hasMoreElements(); printwriter.flush())
                   {
                       i = ((Integer)enumeration.nextElement()).intValue();
                       Meeting meeting = Meeting.find(i);
                       RV rv = meeting.getFrom();
                       int j = meeting.getAction();
                       if(j == 2 || j == 3)
                       {
                           printwriter.print(rv);
                           printwriter.print(" (" + (new SimpleDateFormat("HH:mm")).format(meeting.getTime()) + ") ");
                           if(meeting.getPictureFlag())
                               printwriter.print(new Image("MeetingPicture?Meeting=" + i, meeting.getAlt(teasession._nLanguage), meeting.getAlign()));
                           printwriter.print(meeting.getText(teasession._nLanguage));
                           if(meeting.getVoiceFlag())
                               printwriter.print(new Anchor("MeetingVoice?Meeting=" + i, super.r.getCommandImg(teasession._nLanguage, "Play")));
                           if(meeting.getFileFlag())
                               printwriter.print(new Anchor("MeetingFile?Meeting=" + i, super.r.getCommandImg(teasession._nLanguage, "Download")));
                           printwriter.print(new Break(2));
                       }
                       if(j == 3 && rv.equals(teasession._rv))
                       {
                           printwriter.close();
                           return;
                       }
                       printwriter.print(new Script("self.scrollBy(0,801);"));
                   }

                   printwriter.print(" ");
                   try
                   {
                       Thread.currentThread();
                       Thread.sleep(5000L);
                   }
                   catch(Exception exception1)
                   {
                       exception1.printStackTrace();
                   }
               } while(true);*/
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
            return;
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
//        super.r.add("tea/ui/member/meeting/MeetingServlet");
    }
}
