package tea.ui.confab;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.confab.*;
import java.math.*;

public class EditConfab extends HttpServlet
{


    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            String action = teasession.getParameter("action");
            String community = teasession.getParameter("community");
            String nexturl = teasession.getParameter("nexturl");
            if ("reception".equals(action))
            {
                String dest = teasession.getParameter("dest");
                String flight = teasession.getParameter("flight");
                int human = Integer.parseInt(teasession.getParameter("human"));
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
                java.util.Date time = sdf.parse(teasession.getParameter("time_0") + "-" + teasession.getParameter("time_1") + "-" + teasession.getParameter("time_2") + " " + teasession.getParameter("time_3") + ":" + teasession.getParameter("time_4"));
                Confabreception obj = Confabreception.find(teasession._nNode, teasession._nLanguage);
                obj.set(dest, flight, human, time);
            } else if ("hostel".equals(action))
            {
                String linkman = teasession.getParameter("linkman");
                String cabaret = teasession.getParameter("cabaret");
                String roots = teasession.getParameter("roots");
                int human = Integer.parseInt(teasession.getParameter("human"));
                int days = Integer.parseInt(teasession.getParameter("days"));
                BigDecimal outlay = null;
                try
                {
                    outlay = new java.math.BigDecimal(teasession.getParameter("outlay"));
                } catch (Exception ex1)
                {
                    outlay = new java.math.BigDecimal("0.00");
                }
                java.util.Date time1 = Confabhostel.sdf.parse(teasession.getParameter("time1Year") + "-" + teasession.getParameter("time1Month") + "-" + teasession.getParameter("time1Day"));
                java.util.Date time2 = Confabhostel.sdf.parse(teasession.getParameter("time2Year") + "-" + teasession.getParameter("time2Month") + "-" + teasession.getParameter("time2Day"));
                Confabhostel obj = Confabhostel.find(teasession._nNode, teasession._nLanguage);
                obj.set(linkman, cabaret, roots, human, days, outlay, time1, time2);
            }
            response.sendRedirect("/jsp/info/Succeed.jsp?community=" + community + "&nexturl=" + java.net.URLEncoder.encode(nexturl, "UTF-8"));
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
