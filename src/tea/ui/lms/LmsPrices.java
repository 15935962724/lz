package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LmsPrices extends HttpServlet
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
            String key = h.get("lmsprice","");
            int lmsprice = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
            LmsPrice t = LmsPrice.find(lmsprice);
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.lmsplan = h.getInt("lmsplan");
                t.city = h.getInt("city");
                t.lmsorg = h.getInt("lmsorg");
                t.price[1] = h.getFloat("price1");
                t.price[2] = h.getFloat("price2");
                t.price[3] = h.getFloat("price3");
                t.price[4] = h.getFloat("price4");
                t.price[5] = h.getFloat("price5");
                t.price[6] = h.getFloat("price6");
                t.price[7] = h.getFloat("price7");
                if(t.lmsprice < 1)
                {
                    t.father = h.getInt("father");
                    t.status = 1;
                    t.member = h.member;
                    t.time = new Date();
                }
                if(LmsPrice.count(" AND deleted=0 AND lmsprice!=" + t.lmsprice + " AND lmsplan=" + t.lmsplan + " AND city=" + t.city) > 0)
                {
                    out.print("<script>mt.show('抱歉，数据已存在！不可重复添加！');</script>");
                    return;
                }
                t.set();
            } else if("status".equals(act)) //状态
            {
                t.status = h.getInt("status");
                t.emember = h.member;
                t.etime = new Date();
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
