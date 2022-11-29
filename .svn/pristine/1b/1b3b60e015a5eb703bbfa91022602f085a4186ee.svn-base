package tea.ui.yl.shop;

import java.io.*;
import tea.entity.*;
import tea.entity.yl.shop.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ShopOrigins extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        ServletContext application = this.getServletContext();
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            int origin = h.getInt("origin");
            if ("edit".equals(act))
            {
                ShopOrigin t = ShopOrigin.find(origin);
                t.name[0] = h.get("name0");
                t.name[1] = h.get("name1");
                t.set();
            } else if ("del".equals(act))
            {
                ShopOrigin t = ShopOrigin.find(origin);
                t.delete();
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
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
