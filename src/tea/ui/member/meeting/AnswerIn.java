package tea.ui.member.meeting;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Meeting;
import tea.html.*;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class AnswerIn extends TeaServlet
{

    public AnswerIn()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String s = request.getParameter("Caller");
            if (s == null)
            {
                return;
            }

            String s1 = request.getParameter("InviteToChat");
            boolean flag = s1 != null;
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/meeting/AnswerIn.jsp" + qs);
                /*
                 PrintWriter printwriter = response.getWriter();
                 printwriter.print("<bgsound src=\"/tea/audio/ringin.au\" loop=infinite>");
                 printwriter.flush();
                 Form form = new Form("foAnswer", "POST", "AnswerIn");
                 form.add(new Text(RequestHelper.format(super.r.getString(teasession._nLanguage, "InfIncomingCall"), s)));
                 form.add(new HiddenField("Caller", s));
                 if(flag)
                     form.add(new HiddenField("InviteToChat", s1));
                 form.add(new Button(super.r.getString(teasession._nLanguage, "Accept")));
                 form.add(new Button("Ignore", super.r.getString(teasession._nLanguage, "Ignore"), "window.close();"));
                 printwriter.print(form);
                 printwriter.close();*/
            } else
            {
                String community = request.getParameter("community");
                Meeting.create(teasession._rv, new RV(s, community), 1);
                if (flag)
                {
                    response.sendRedirect("ChatFrameSet?node=" + s1 + "&community=" + community);
                } else
                {
                    response.sendRedirect("MeetingFrameSet?To=" + s + "&community=" + community);
                }
            }
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        //super.r.add("tea/ui/member/meeting/AnswerIn");
    }
}
