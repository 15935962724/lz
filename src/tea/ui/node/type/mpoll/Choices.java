package tea.ui.node.type.mpoll;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.node.type.mpoll.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Choices extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            if(h.member<1)
            {
                out.println("<script>mt.show('您还没有登录或登录已超时！请重新登录',2,'/');</script>");
                return;
            }

            if ("add".equals(act))
            {
                Choice t = new Choice(0);
                t.question = h.getInt("question");
                t.sequence = (int) (System.currentTimeMillis() / 1000);
                t.set();
            } else if ("del".equals(act)) //删除
            {
                int choice = h.getInt("choice");
                Choice t = Choice.find(choice);
                t.delete();
            }
            out.println("<script>mt.refresh();</script>");
        } catch (Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
