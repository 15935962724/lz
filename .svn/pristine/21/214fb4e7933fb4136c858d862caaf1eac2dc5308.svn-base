package tea.ui.util;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.member.*;

public class LogoutNew extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            HttpSession session = request.getSession(true);
            session.removeAttribute("tea.RV");
            OnlineList obj = OnlineList.find(session.getId());
            obj.setMember(null);
            String s = request.getParameter("nexturl");
            if (s == null)
            {
                s = "http://www.goldenholiday.com/";
            }
            response.sendRedirect(s);
        } catch (Exception ex)
        {
            response.sendError(400, ex.toString());
            ex.printStackTrace();
        }
    }
}
