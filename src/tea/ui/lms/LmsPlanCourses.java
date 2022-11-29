package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LmsPlanCourses extends HttpServlet
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
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            if("edit".equals(act)) //编辑
            {
                StringBuilder ids = new StringBuilder();
                int lmsplan = h.getInt("lmsplan");
                String[] lmsplancourse = h.getValues("lmsplancourse");
                String[] lmscert = h.getValues("lmscert");
                String[] lmscourse = h.getValues("lmscourse");
                String[] time = h.getValues("time");
                String[] start = h.getValues("start");
                String[] end = h.getValues("end");
                for(int i = 1;i < lmsplancourse.length;i++)
                {
                    LmsPlanCourse t = LmsPlanCourse.find(Integer.parseInt(lmsplancourse[i]));
                    t.lmsplan = lmsplan;
                    t.starttime = MT.SDF[1].parse(time[i] + " " + start[i]);
                    t.endtime = MT.SDF[1].parse(time[i] + " " + end[i]);
                    t.lmscert = Integer.parseInt(lmscert[i]);
                    t.lmscourse = Integer.parseInt(lmscourse[i]);
                    if(t.lmsplancourse < 1)
                    {
                        t.member = h.member;
                        t.time = new Date();
                    }
                    t.set();
                    ids.append(t.lmsplancourse + ",");
                }
                //记录创建人及时间
                LmsPlan lp = LmsPlan.find(lmsplan);
                if(lp.ctime == null)
                {
                    lp.cmember = h.member;
                    lp.ctime = new Date();
                    lp.set();
                }
                DbAdapter db = new DbAdapter();
                try
                {
                    System.out.println("DELETE FROM LmsPlanCourse WHERE lmsplan=" + lmsplan + " AND lmsplancourse NOT IN(" + ids.toString() + "0)");
                    db.executeUpdate("DELETE FROM LmsPlanCourse WHERE lmsplan=" + lmsplan + " AND lmsplancourse NOT IN(" + ids.toString() + "0)");
                } finally
                {
                    db.close();
                }
            } else if("pdel".equals(act))
            {
                int lmsplan = h.getInt("lmsplan");
                LmsPlan lp = LmsPlan.find(lmsplan);
                lp.cmember = 0;
                lp.ctime = null;
                lp.set();
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeUpdate("DELETE FROM LmsPlanCourse WHERE lmsplan=" + lmsplan);
                } finally
                {
                    db.close();
                }
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
