// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-10-9 14:37:31
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   MeetingFrameSet.java

package tea.ui.member.meeting;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class MeetingFrameSet extends TeaServlet
{

    public MeetingFrameSet()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String s = request.getParameter("To");

String qs=request.getQueryString();
qs=qs==null?"":"?"+qs;
response.sendRedirect("/jsp/meeting/MeetingFrameSet.jsp"+qs);

   //         outText(response, teasession._nLanguage, "<FRAMESET ROWS=*,150 BORDER=1 FRAMEBORDER=YES> <FRAME NAME=frMeeting SRC=Meeting SCROLLING=YES RESIZE> <FRAME SRC=SendToMeeting?To=" + s + " SCROLLING=YES RESIZE>" + "</FRAMESET>");
        }
        catch(Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
