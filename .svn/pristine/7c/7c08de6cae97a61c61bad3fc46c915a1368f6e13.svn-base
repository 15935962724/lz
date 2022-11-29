package tea.ui.util;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.service.*;
import tea.ui.*;

public class MailTo extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String nu = request.getParameter("nexturl");
        String to = request.getParameter("to");
        String subject = request.getParameter("subject");
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
        Enumeration e;
        String seq = request.getParameter("seq");
        if (seq != null && seq.length() > 1)
        {
            Vector v = new Vector();
            String ss[] = seq.split("/");
            for (int i = 1; i < ss.length; i++)
            {
                v.add(ss[i]);
            }
            e = v.elements();
        } else
        {
            e = request.getParameterNames();
        } while (e.hasMoreElements())
        {
            String name = (String) e.nextElement();
            String value[] = request.getParameterValues(name);
            if (!"to".equals(name) && !"subject".equals(name) && !"community".equals(name) && !"node".equals(name) && !"seq".equals(name) && value != null)
            {
                sb.append("<tr><td>").append(name).append("</td><td>");
                for (int j = 0; j < value.length; j++)
                {
                    sb.append(value[j]).append("　");
                }
            }
        }
        sb.append("</table>");
        if (nu == null)
        {
            nu = "/jsp/info/Succeed.jsp";
        }
        try
        {
            SendEmaily se = new SendEmaily(teasession._strCommunity);
            se.sendEmail(to, subject, sb.toString());
        } catch (Exception ex)
        {
            ex.printStackTrace();
            nu = "/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("邮件发送失败", "UTF-8");
        }
        response.sendRedirect(nu);
    }
}
