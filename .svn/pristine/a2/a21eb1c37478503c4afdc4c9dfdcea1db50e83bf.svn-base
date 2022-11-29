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


public class Coupons extends HttpServlet
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
            if ("activate".equals(act))
            {
                Iterator it = Coupon.find(" AND password=" + Database.cite(h.get("coupon")), 0, 1).iterator();
                if (!it.hasNext())
                {
                    out.print("<script>mt.show('您输入的优惠券不存在！');</script>");
                    return;
                }
                Coupon t = (Coupon) it.next();
                if (t.activate >0)
                {
                    out.print("<script>mt.show('您输入的优惠券已被激活！');</script>");
                    return;
                }
                if (t.trade > 0)
                {
                    out.print("<script>mt.show('您输入的优惠券已被使用！');</script>");
                    return;
                }
//                Date vtime = Publish.find(t.publish).vtime;
//                if(vtime == null || vtime.getTime() < System.currentTimeMillis())
//                {
//                    out.print("<script>mt.show('您输入的优惠券已过期！');</script>");
//                    return;
//                }
                t.set("activate", String.valueOf(h.member));
                if (nexturl.length() < 1) //订单页 优惠券 列表
                {
                    act = "list";
                    out.print("<script>window.onload=function(){$('CList').innerHTML=document.body.innerHTML;var t=doc.form1.coupon;for(var i=0;i<t.length;i++)if(t[i].value=='" + h.get("def") + "')t[i].checked=true;}</script>");
                }
            }
            //订单页 优惠券 列表
            if ("list".equals(act))
            {
                Iterator it = Coupon.find(" AND activate=" + h.member + " AND trade=0", 0, 100).iterator();
                if (it.hasNext())
                    out.print("<input name='coupon' type='radio' onclick='coupon_sel(this)' value='0' id='_c0' checked /><label for='_c0'>不使用优惠券</label><br/>");
                while (it.hasNext())
                {
                    Coupon c = (Coupon) it.next();
                    Date vtime = Publish.find(c.publish).vtime;
                    out.print("<input name='coupon' type='radio' onclick='coupon_sel(this)' value='" + c.coupon + "' id='_c" + c.coupon + "' " + (vtime.getTime() < System.currentTimeMillis() ? " disabled" : "") + " /><label for='_c" + c.coupon + "'>优惠券编号[" + Publish.DF8.format(c.coupon) + "] 有效期[" + MT.f(vtime) + "]</label><br/>");
                }
                return;
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch (Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            if (!"list".equals(act))
                out.close();
        }
    }
}
