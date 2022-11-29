package tea.ui.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.yl.shop.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Refunds extends HttpServlet
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
            int refund = h.getInt("refund");
            if ("edit".equals(act))
            {
                String tcode = h.get("trade");
                Iterator it = Trade.find(" AND code=" + Database.cite(tcode), 0, 1).iterator();
                if (!it.hasNext())
                {
                    out.println("<script>mt.show('对不起，您输入的“订单号”不存在！');</script>");
                    return;
                }
                int trade = ((Trade) it.next()).trade;

                Refund t = Refund.find(refund);
                if (refund < 1)
                {
                    t.member = h.member;
                    t.time = new Date();
                }
                t.trade = trade;
                t.type = h.getInt("type");
                t.bank = h.getInt("bank");
                int city = 0;
                for (int i = 2; i > -1 && city < 1; i--)
                    city = h.getInt("bcity" + i);
                t.bcity = city;
                t.baddress = h.get("baddress");
                t.bname = h.get("bname");
                t.baccount = h.get("baccount");
                t.content = h.get("content");
                //t.money = h.getFloat("money");
                t.set();
            } else if ("del".equals(act))
            {
                Refund t = Refund.find(refund);
                t.delete();
            } else if ("state".equals(act))
            {
                Refund t = Refund.find(refund);
                t.state = h.getInt("state");
                t.set();
            }else if("tstate".equals(act)){
            	Trade ta = Trade.find(h.getInt("trade"));
            	Refundview rv = new Refundview(0);
            	rv.rcont = h.get("rcont");
            	rv.tstate = h.getInt("tstate");
            	rv.trade = h.getInt("trade");
            	rv.rdate = new Date();
            	rv.member = h.member;
            	rv.set();
            	ta.set("tstateid",rv.rid+"");
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
