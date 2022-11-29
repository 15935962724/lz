package tea.ui.node.type.scholar;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.RV;
import tea.entity.admin.*;
import tea.db.*;
import java.sql.SQLException;

public class ScholarDowns extends TeaServlet
{
    public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
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
        String member = teasession._rv._strV;
        try
        {
            ScholarDown sd = ScholarDown.find(teasession._nNode, member);
            if (!sd.isExists())
            {
                int hits = 100;//AdminRole.getMaxHits(teasession._strCommunity, member);
                int count = ScholarDown.count(" AND member=" + DbAdapter.cite(member) + " AND time>" + DbAdapter.cite(new Date(), true));
                if (count >= hits)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("日下载量已过.", "UTF-8"));
                    return;
                }
                ScholarDown.create(teasession._nNode, member);
            }
            Scholar s = Scholar.find(teasession._nNode, teasession._nLanguage);
            String path = s.getFilePath();
            String name = s.getFileName();
            ServletContext application = getServletContext();
            response.setHeader("Content-Disposition", "attachment; filename=" + new String(name.getBytes("GBK"), "ISO-8859-1"));
            File f = new File(application.getRealPath(path));
            response.setContentLength((int) f.length());
            byte by[] = new byte[8192];
            OutputStream os = response.getOutputStream();
            FileInputStream fis = new FileInputStream(f);
            try
            {
                int i = 0;
                while ((i = fis.read(by)) != -1)
                {
                    os.write(by, 0, i);
                }
            } finally
            {
                fis.close();
                os.close();
            }
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }
}
