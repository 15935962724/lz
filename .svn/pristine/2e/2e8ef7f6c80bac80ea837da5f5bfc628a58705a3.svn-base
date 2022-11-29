package tea.ui.member.feedback;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Feedback;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class NewFeedback extends TeaServlet
{

    public NewFeedback()
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
            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/feedback/NewFeedback.jsp?" + request.getQueryString());
            } else
            {
                String member = teasession.getParameter("member");
                String act = teasession.getParameter("act");
                int i = Integer.parseInt(teasession.getParameter("hint"));
                String s1 = teasession.getParameter("subject");
                if (s1.length() == 0)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidSubject"));
                    return;
                }
                String s2 = teasession.getParameter("content");
                String picture = null;
                byte abyte0[] = teasession.getBytesParameter("picture");
                if (abyte0 != null)
                {
                    picture = super.write(teasession._strCommunity, abyte0, ".gif");
                }
                String voice = null;
                byte abyte1[] = teasession.getBytesParameter("voice");
                if (abyte1 != null)
                {
                    voice = super.write(teasession._strCommunity, abyte1, ".gif");
                }

                String s3 = teasession.getParameter("fileName");
                String file = null;
                byte abyte2[] = teasession.getBytesParameter("file");
                if (abyte2 != null)
                {
                    file = super.write(teasession._strCommunity, abyte2, ".gif");
                }
                Feedback.create(teasession._strCommunity, member, teasession._rv, i, teasession._nLanguage, s1, s2, picture, voice, s3, file);
                response.sendRedirect("/jsp/feedback/Feedbacks.jsp?member=" + java.net.URLEncoder.encode(member, "UTF-8"));
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
        super.r.add("tea/ui/member/feedback/NewFeedback");
    }
}
