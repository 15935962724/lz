package tea.ui.node.type.job;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;

public class JobTypes extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            if("sequence".equals(act))
            {
                String[] jt = h.get("jobtypes").split("[|]");
                for(int i = 1;i < jt.length;i++)
                {
                    JobType t = new JobType(Integer.parseInt(jt[i]));
                    t.set("sequence",String.valueOf(i * 10));
                }
                return;
            }

            int jobtype = h.getInt("jobtype");
            out.print("<script>var mt=parent.mt;</script>");
            JobType t = JobType.find(jobtype);
            if("del".equals(act)) //删除
            {
                t.set("state",String.valueOf(t.state = 2));
            } else if("edit".equals(act)) //编辑
            {
                t.community = h.community;
                t.name = h.get("name");
                t.state = 0;
                t.sequence = (int) (System.currentTimeMillis() / 1000);
                t.time = new Date();
                t.set();
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
