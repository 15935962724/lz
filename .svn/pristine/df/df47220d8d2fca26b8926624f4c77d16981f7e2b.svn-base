// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   RequestProfile.java

package tea.ui.member.profile;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.ProfileRequest;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class RequestProfile extends TeaServlet
{

    public RequestProfile()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String s = request.getParameter("Member");
            ProfileRequest.create(s,teasession._rv);
            response.sendRedirect("Glance?Member=" + s);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }
}
