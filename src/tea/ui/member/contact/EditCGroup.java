package tea.ui.member.contact;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.ui.*;
import java.util.*;

public class EditCGroup extends TeaServlet
{

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if (teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        String nu = request.getParameter("nexturl");
        try
        {
            int cgroup = Integer.parseInt(request.getParameter("cgroup"));

            String act = request.getParameter("act");
            //int i = Integer.parseInt(request.getParameter("type"));
            if ("edit".equals(act))
            {
                String name = request.getParameter("name");
                if (cgroup == 0)
                {
                    CGroup.create(teasession._rv._strR, teasession._nLanguage, name);
                } else
                {
                    CGroup cg = CGroup.find(cgroup);
                    cg.set(teasession._nLanguage, name);
                }
            } else if ("delete".equals(act))
            {
                CGroup cg = CGroup.find(cgroup);
                cg.delete(teasession._nLanguage);
            } else if ("move".equals(act))
            {
                boolean sequence = "true".equals(teasession.getParameter("sequence"));
                Enumeration e = CGroup.find(teasession._rv._strR, "", 0, Integer.MAX_VALUE);
                for (int i = 10; e.hasMoreElements(); i = i + 2)
                {
                    int j = ((Integer) e.nextElement()).intValue();
                    CGroup au = CGroup.find(j);
                    if (j == cgroup)
                    {
                        au.setSequence(i + (sequence ? -3 : 3));
                    } else
                    {
                        au.setSequence(i);
                    }
                }
            }
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
        response.sendRedirect(nu); //"/jsp/message/CGroups.jsp?community=" + teasession._nNode
    }

}
