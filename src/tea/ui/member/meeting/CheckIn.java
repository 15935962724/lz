package tea.ui.member.meeting;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.member.*;
import tea.ui.*;


public class CheckIn extends TeaServlet
{

    public CheckIn()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            String s = "";
            if (teasession._rv != null)
            {
                OnlineList online = OnlineList.find(teasession._rv._strV); ///告诉系统,当前会员在线
                online.set(teasession._strCommunity, request.getRemoteAddr()); ///
                Meeting meeting = Meeting.findIn(teasession._rv);
                if (meeting != null) //是否有会员呼叫当前会员
                {
                    s = meeting.getFrom().toString() + "\n" + meeting.getText(0);
                    meeting.delete();
                }
            }
            java.io.PrintWriter out = response.getWriter();
            out.print(s);
            out.close();
            //outText(teasession,response, s);
        } catch (Exception ex)
        {
            response.sendError(400, ex.toString());
            ex.printStackTrace();
        }
    }
}
