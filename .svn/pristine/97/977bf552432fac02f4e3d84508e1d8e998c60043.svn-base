package tea.ui.node.type.file;

import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.ui.TeaSession;
import tea.entity.member.*;
import tea.entity.admin.*;
import java.io.*;
import java.util.*;
import java.sql.*;

public class FileDownload extends HttpServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        TeaSession teasession = new TeaSession(request);
        String sn = request.getServerName();
        ///权限判断//
        String member = null;
        ProfileCsv procsv = null;
        AdminUsrRole adminuser = null;
        if (teasession._rv == null)
        {

        } else
        {
            member = teasession._rv.toString();
            try
            {
                procsv = ProfileCsv.find(member);
                adminuser = AdminUsrRole.find(teasession._strCommunity, member);
            } catch (SQLException ex1)
            {

            }
        }
        if (sn.indexOf("csvclub") != -1)
        {
            if (adminuser.isExists() || (procsv.getMembernumber() != null && procsv.getMembernumber().length() > 0))
            {
            } else
            {
                PrintWriter out = response.getWriter();
                out.print("<script>");
                if (teasession._rv == null)
                {
                    out.print("alert('登陆后才能下载');");
                } else
                {
                    out.print("alert('成为交费会员才能下载');");
                }
                out.print("history.back();</script>");
                out.close();
                return;
            }
        }
        try
        {
            Files obj = Files.find(teasession._nNode, teasession._nLanguage);
            // 下载次数加1/////////////
            obj.setHits(obj.getHits() + 1);
            String url = "/res/" + teasession._strCommunity + "/files/" + teasession._nNode + "_" + teasession._nLanguage + ".doc";
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-disposition", "attachment; filename=" + java.net.URLEncoder.encode(obj.getName(), "UTF-8"));
            this.getServletContext().getRequestDispatcher(url).forward(request, response);
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
