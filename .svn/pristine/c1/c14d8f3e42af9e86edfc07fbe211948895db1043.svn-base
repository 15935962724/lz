package tea.ui.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.yl.shop.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Moneys extends HttpServlet
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
            if (h.member <1 )
            {
                out.println("<script>mt.show('您还没有登陆或登陆已超时！请重新登陆',2,'/admin/Login.jsp');</script>");
                return;
            }
            int money = h.getInt("money");
            if ("edit".equals(act))
            {
                int member = h.getInt("member");
                if (member>0)
                {
                    if (Member.find(member).time == null)
                    {
                        out.println("<script>mt.show('“" + member + "”不存在！');</script>");
                        return;
                    }
                } else
                    member = h.member;
                Money.create(member, h.getFloat("value"), h.member, h.get("content", "充值："));
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
