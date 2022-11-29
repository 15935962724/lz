package tea.ui.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.yl.shop.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;
import jxl.write.*;


public class Discounts extends HttpServlet
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
            int discount = h.getInt("discount");
            if ("edit".equals(act))
            {
                Discount t = Discount.find(discount);
                t.type = h.getInt("type");
                t.cust = h.getBool("cust");
                t.brand = h.get("brands", "|");
                t.category = h.getInt("category1");
                t.product = h.get("product", "|");
                float f = h.getFloat("value");
                t.value = (int) (f < 10 ? f * 10 : f);
                t.state = h.getInt("state");
                t.member = h.member;
                if (t.time == null)
                    t.time = new Date();
                t.set();
            } else if ("member".equals(act))
            {
                int member = h.getInt("member");
                int quantity = h.getInt("quantity");
                if (Member.find(member).time == null)
                {
                    out.print("<script>alter('“" + member + "”不存在！');</script>");
                    return;
                }
                Coupon.setMember(member, quantity);
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
