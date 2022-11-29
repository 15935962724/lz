package tea.ui.util;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.ui.TeaSession;
import tea.ui.TeaServlet;


public class StartLogin extends TeaServlet
{

    public StartLogin()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._strCommunity == null)
            {
                response.sendError(404);
                return;
            }
            String s = request.getParameter("nexturl");
            if(s == null)
            {
                s = "/servlet/Node?node=" + teasession._nNode + "&language=" + teasession._nLanguage;
            }
            s = java.net.URLEncoder.encode(s,"UTF-8");
            Community obj = Community.find(teasession._strCommunity);
            int login = request.getParameter("bg") == null ? obj.getLogin() : obj.getBgLogin();
            if(login != 0)
            {
            	response.sendRedirect("/"+(teasession._nStatus==0?"html":"xhtml")+"/" + teasession._strCommunity + "/folder/" + login + "-" + teasession._nLanguage + ".htm?nexturl=" + s);
            } else
            {
                if(teasession._strCommunity.equals("bigpic"))
                {
                    response.sendRedirect("/jsp/bpicture/regist/StartLogin.jsp?node=" + teasession._nNode + "&language=" + teasession._nLanguage + "&nexturl=" + s);
                } else
                {
                    response.sendRedirect("/jsp/user/StartLogin.jsp?node=" + teasession._nNode + "&language=" + teasession._nLanguage + "&nexturl=" + s);
                }
            }
        } catch(Exception ex)
        {
			ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }
}
