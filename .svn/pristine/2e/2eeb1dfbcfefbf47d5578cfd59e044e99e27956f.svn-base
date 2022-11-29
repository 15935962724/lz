package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.site.*;
import java.sql.SQLException;


public class FRess extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request);
        ServletContext application = getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.print("<script>var mt=parent.mt;</script>");
            String act = h.get("act"),nexturl = h.get("nexturl","");
            int fres = h.getInt("fres");
            if("upload".equals(act))
            {
                String file = h.get("file");
                if(file != null)
                {
                    FRes t = FRes.find(fres);
                    File f2 = new File(application.getRealPath(t.path));
                    f2.delete();
                    new File(application.getRealPath(file)).renameTo(f2);
                }
            } else if("del".equals(act))
            {
                FRes t = FRes.find(fres);
                t.delete();
                new File(application.getRealPath(t.path)).delete();
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

}
