package tea.ui.agent;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.member.*;

public class EditAgent extends HttpServlet
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
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String action = teasession.getParameter("action");
            String community = teasession.getParameter("community");
            String nexturl = teasession.getParameter("nexturl");
            if ("editagentmember".equals(action))
            {
                int profile = Integer.parseInt(teasession.getParameter("profile"));
                String member = teasession.getParameter("member");
                String password = teasession.getParameter("password");
                String firstname = teasession.getParameter("firstname");
                String lastname = teasession.getParameter("lastname");
                String email = teasession.getParameter("email");
                if (profile == 0)
                {
                    if (Profile.isExisted(member))
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("“" + member + "”已经存在.", "UTF-8"));
                        return;
                    }
                    String sn = request.getServerName() + ":" + request.getServerPort();
                    Profile.create(member, password, community, email, sn);
                    Profile p = Profile.find(teasession._rv._strV);
                    String referer = p.getReferer();
                    if (referer == null || referer.length() < 1)
                    {
                        p.setAgent(1);
                    }
                    Profile p2 = Profile.find(member);
                    p2.setAgent(p.getAgent() + 1);
                    p2.setReferer(teasession._rv._strV);
                }
                Profile p = Profile.find(member);
                p.setFirstName(firstname, teasession._nLanguage);
                p.setLastName(lastname, teasession._nLanguage);
                p.setEmail(email);
            }

            response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + java.net.URLEncoder.encode(nexturl, "UTF-8"));
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
