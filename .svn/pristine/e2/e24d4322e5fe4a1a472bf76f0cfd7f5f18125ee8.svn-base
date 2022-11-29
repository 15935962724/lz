package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LmsPlans extends HttpServlet
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
            String key = h.get("lmsplan");
            int lmsplan = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
            LmsPlan t = LmsPlan.find(lmsplan);
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.lmsorg = h.getInt("lmsorg");
                t.name = h.get("name");
                t.city = h.getInt("city");
                t.starttime = h.getDate("starttime");
                t.endtime = h.getDate("endtime");
//                t.status = h.getInt("status");
                t.pstarttime = h.getDate("pstarttime");
                t.pendtime = h.getDate("pendtime");
//                t.emember = h.getInt("emember");
//                t.etime = h.getDate("etime");
//                t.remark1 = h.get("remark1");
//                t.remark2 = h.get("remark2");
//                t.remark3 = h.get("remark3");
//                t.remark4 = h.get("remark4");
//                t.remark5 = h.get("remark5");
                if(t.lmsplan < 1)
                {
                    t.father = h.getInt("father");
                    if(t.father > 0 && LmsPlan.count(" AND lmsplan!=" + lmsplan + " AND father=" + t.father + " AND city=" + t.city) > 0)
                    {
                        out.print("<script>mt.show('该省已存在！不可重复添加！');</script>");
                        return;
                    }
                    t.status = 1;
                    t.member = h.member;
                    t.time = new Date();
                }
                t.set();
            } else if("state".equals(act))
            {
                t.status = h.getInt("status");
                t.emember = h.member;
                t.etime = new Date();
                t.set();
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
