package tea.ui.im;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.site.*;
import tea.entity.member.*;
import java.net.*;
import tea.ui.*;

public class EditMsn extends TeaServlet
{

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
            return;
        }
        String nu = request.getParameter("nexturl");
        String act = request.getParameter("act");
        try
        {
            String member = request.getParameter("member");
            if(member == null)
            {
                member = teasession._rv._strV;
            }
            Profile p = Profile.find(member);
            if("del".equals(act))
            {
                p.setMsnID(null);
            } else if("edit".equals(act))
            {
                String msnid = null,result = request.getParameter("result");
                if(result != null)
                {
                    if("Accepted".equals(result))
                    {
                        msnid = request.getParameter("id");
                    }
                    p.setMsnID(msnid);
                } else
                {
                    CommunityOption obj = CommunityOption.find(teasession._strCommunity);
                    String policy = obj.get("msnpolicy");
                    String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
                    member = URLEncoder.encode(member,"UTF-8");
                    nu = URLEncoder.encode(nu,"UTF-8");
                    response.sendRedirect("http://settings.messenger.live.com/applications/websignup.aspx?returnurl=" + URLEncoder.encode(url + request.getRequestURI() + "?act=edit&member=" + member + "&nexturl=" + nu,"UTF-8") + "&privacyurl=" + java.net.URLEncoder.encode(url + "/servlet/Node?node=" + policy,"UTF-8"));
                    return;
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect(nu);
    }

    // Clean up resources
    public void destroy()
    {
    }
}
