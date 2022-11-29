package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LmsCerts extends HttpServlet
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
            String key = h.get("lmscert");
            int lmscert = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
            LmsCert t = LmsCert.find(lmscert);
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.code = h.get("code");
                t.name = h.get("name");
                t.content = h.get("content");
                t.type = h.getInt("type");
                t.rank = h.getInt("rank");
                //t.status = h.getInt("status");
                t.price = h.getFloat("price");
                //t.orgid = h.getInt("orgid");
                //t.aspid = h.getInt("aspid");
                //t.utime = h.getDate("utime");
                if(t.lmscert < 1)
                {
                    t.member = h.member;
                    t.time = new Date();
                }
                t.utime = t.time;
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
