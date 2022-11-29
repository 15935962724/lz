package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LmsLeaves extends HttpServlet
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
            String key = h.get("lmsleave");
            int lmsleave = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
            LmsLeave t = LmsLeave.find(lmsleave);
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.attch = h.getInt("attch");
                t.omember = h.member;
                if(t.lmsleave < 1)
                {
                    t.member = Integer.parseInt(MT.dec(h.get("member")));
                    t.state = 1; //h.getInt("state");
                    //t.amember = h.getInt("amember");
                    //t.atime = h.getDate("atime");
                    t.time = new Date();
                }
                t.set();
            } else if("state".equals(act)) //状态
            {
                t.state = h.getInt("state");
                t.amember = h.member;
                t.atime = new Date();
                t.set();
                if(t.state == 2)
                {
                    Profile p = Profile.find(t.member);
                    p.setType(4);
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
