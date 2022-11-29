package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.member.Callboard;

public class EditCallboard extends tea.ui.TeaServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&NextUrl=" + request.getRequestURI() + "?" + request.getQueryString());
                return;
            }
            int callboard = Integer.parseInt(request.getParameter("callboard"));
            if(request.getParameter("delete") != null)
            {
                Callboard obj = Callboard.find(callboard);
                obj.delete(teasession._nLanguage);
            } else
            {
                String subject = request.getParameter("subject");
                String content = request.getParameter("content");
                if(callboard == 0)
                {
                    Callboard.create(teasession._rv._strV,teasession._nLanguage,subject,content);
                } else
                {
                    Callboard obj = Callboard.find(callboard);
                    obj.set(teasession._rv._strV,teasession._nLanguage,subject,content);
                }
            }
            String nu = request.getParameter("nexturl");
            if(nu == null)
            {
                nu = "/jsp/profile/EditCallboard.jsp?community=" + teasession._strCommunity;
            }
            response.sendRedirect(nu);
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
