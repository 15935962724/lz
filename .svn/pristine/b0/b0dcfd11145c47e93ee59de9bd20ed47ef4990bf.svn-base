package tea.ui.util;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.ui.TeaServlet;
import tea.entity.*;

public class SwitchLanguage extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        Http h = new Http(request,response);

        String nu = h.get("nexturl");
        int i = h.getInt("language", -1);
        if(i == -1)
            i = h.getInt("Language",1);
        HttpSession session = request.getSession(true);
        if(nu == null)
        {
            nu = request.getHeader("referer");
        } else if(nu.contains("//"))
        {
            response.sendError(404);
            return;
        }
        if(nu == null)
        {
            String teanode = String.valueOf(session.getAttribute("tea.Node"));
            int node = 0;
            if(teanode != null && teanode.length() > 0 && !"null".equals(teanode))
            {
                node = Integer.parseInt(teanode);
            }
            if(node > 0)
            {
                nu = "/html/node/" + node + "-" + i + ".htm?";
            } else
            {
                nu = "http://" + request.getServerName() + ":" + request.getServerPort();
            }
        }
        h.setCook("language",String.valueOf(i), -1);

        nu = nu.replaceFirst("html\\d/","html" + i + "/").replaceFirst("&language=\\d","&language=" + i);
        response.sendRedirect(nu);
    }
}
