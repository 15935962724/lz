package tea.ui.netdisk;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

import tea.db.DbAdapter;
import tea.entity.admin.*;
import tea.ui.*;
import tea.entity.netdisk.*;
import java.sql.SQLException;
import tea.entity.netdisk.*;

public class EditSafety extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if (teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getHeader("referer"), "UTF-8"));
            return;
        }
        String act = request.getParameter("act");
        String path = request.getParameter("path");
        try
        {
            if ("edit".equals(act))
            {
                int safety = Integer.parseInt(request.getParameter("safety"));
                int purview = Integer.parseInt(request.getParameter("purview"));
                int style = Integer.parseInt(request.getParameter("style"));
                String role = request.getParameter("role");
                String unit = request.getParameter("unit");
                String member = request.getParameter("member");
                member = member.replaceAll("; ", "/");
                if (!member.startsWith("/"))
                {
                    member = "/" + member;
                }
                if (safety == 0)
                {
                    Safety.create(teasession._strCommunity, path, style, purview, role, unit, member);
                } else
                {
                    Safety obj = Safety.find(safety);
                    obj.set(style, purview, role, unit, member);
                }
            } else if ("delete".equals(act))
            {
                int safety = Integer.parseInt(request.getParameter("safety"));
                Safety obj = Safety.find(safety);
                obj.delete();
            } else if ("extend".equals(act))
            {
            	NetDisk obj=NetDisk.find(teasession._strCommunity,path);
            	boolean extend=request.getParameter("extend")!=null;
            	obj.setExtend(extend);
            } else if ("reset".equals(act))
            {
            	DbAdapter db = new DbAdapter();
                try
                {
                    db.executeUpdate("DELETE FROM Safety WHERE community=" + DbAdapter.cite(teasession._strCommunity) + " AND path LIKE " + DbAdapter.cite(path+"_%"));
                    db.executeUpdate("UPDATE NetDisk SET extend=1 WHERE community=" + DbAdapter.cite(teasession._strCommunity) + " AND path LIKE " + DbAdapter.cite(path+"_%"));
                } finally
                {
                    db.close();
                }
                NetDisk._cache.clear();
            }
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect("/jsp/netdisk/Safetys.jsp?path=" + java.net.URLEncoder.encode(path, "UTF-8"));
    }

    //Clean up resources
    public void destroy()
    {
    }
}
