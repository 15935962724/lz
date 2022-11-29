package tea.ui.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.yl.shop.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Specials extends HttpServlet
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
            out.println("<script>var mt=parent.mt,$=parent.$,doc=parent.document;</script>");
            if (h.member <1 )
            {
                out.println("<script>mt.show('您还没有登陆或登陆已超时！请重新登陆',2,'/my/Login.jsp');</script>");
                return;
            }
            if ("sequence".equals(act))
            {
                String[] arr = h.get("specials").split("[|]");
                for (int i = 1; i < arr.length; i++)
                {
                    Special t = new Special(Integer.parseInt(arr[i]));
                    t.set("sequence", String.valueOf(i * 10));
                }
                return;
            }
            int special = h.getInt("special");
            if ("edit".equals(act))
            {
                String[] arr = h.get("product").split("[|]");
                int type = h.getInt("type");
                for (int i = 1; i < arr.length; i++)
                {
                    if (Special.find(" AND type=" + type + " AND product=" + arr[i], 0, 1).size() > 0)
                        continue;
                    Special t = new Special(0);
                    t.type = type;
                    t.product = Integer.parseInt(arr[i]);
                    t.sequence = (int) System.currentTimeMillis() / 1000;
                    t.set();
                }
            } else if ("del".equals(act))
            {
                Special t = Special.find(special);
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
