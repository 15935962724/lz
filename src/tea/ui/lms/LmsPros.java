package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LmsPros extends HttpServlet
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
            String key = h.get("lmspro");
            int lmspro = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
            LmsPro t = LmsPro.find(lmspro);
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.code = h.get("code");
                t.name = h.get("name");
                t.content = h.get("content");
                t.credit = h.getFloat("credit");
                t.utime = new Date();
                if(t.lmspro < 1)
                {
                    t.member = h.member;
                    t.time = t.utime;
                }
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
