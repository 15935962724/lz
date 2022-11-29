package tea.ui.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.yl.shop.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Reviews extends HttpServlet
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
                out.println("<script>mt.show('您还没有登陆或登陆已超时！请重新登陆',2,'/');</script>");
                return;
            }
            int review = h.getInt("review");
            Review t = Review.find(review);
            if ("edit".equals(act))
            {
                t.product = h.getInt("product");
                t.member = h.member;
                t.title = h.get("title");
                t.score = h.getInt("score");
                t.content = h.get("content");
                t.advantages = h.get("advantages");
                t.shortcomings = h.get("shortcomings");
                t.time = new Date();
                t.set();
                out.print("<script>mt.show('操作执行成功！<br/>审核通过后显示！',1,'/product.jsp?product=" + t.product + "');</script>");
                return;
            } else if ("del".equals(act))
            {
                t.delete();
            } else if ("mark".equals(act))
            {
                if (h.getBool("mark"))
                    t.set("good", String.valueOf(t.good + 1));
                else
                    t.set("poor", String.valueOf(t.poor + 1));
                return;
            } else if ("repay".equals(act))
            {
                Repay r = new Repay(0);
                r.member = h.member;
                r.review = h.getInt("review");
                r.content = h.get("q");
                r.time = new Date();
                r.set();
            } else if ("state".equals(act))
            {
                t.set("state", h.get("state"));
                //好评度
                int[] stat = Review.stat(t.product);
                Product p = Product.find(t.product);
                p.set("praise", String.valueOf(stat[0] < 1 ? 0 : (stat[4] + stat[5]) * 100 / stat[0]));
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
