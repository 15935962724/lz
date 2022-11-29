package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LmsIncomes extends HttpServlet
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
            int lmsincome = h.getInt("lmsincome");
            LmsIncome t = LmsIncome.find(lmsincome);
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.starttime = h.getDate("starttime");
                t.endtime = h.getDate("endtime");
                t.price = h.getFloat("price");
                //t.unlimited = h.getInt("unlimited");
                if(t.lmsincome < 1)
                {
                    t.type = h.getInt("type");
                    t.state = 1;
                    t.time = new Date();
                }
                t.set();
            } else if("state".equals(act)) //状态
            {
                t.set("state",String.valueOf(t.state = h.getInt("state")));
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
