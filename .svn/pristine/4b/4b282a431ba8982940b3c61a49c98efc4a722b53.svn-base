package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.text.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LmsPays extends HttpServlet
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
            String key = h.get("lmspay");
            int lmspay = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
            LmsPay t = LmsPay.find(lmspay);
            if("del".equals(act)) //删除
            {
                t.delete();
                t.setMember(false);
            } else if("add".equals(act)) //编辑
            {
                t.quantity = h.getInt("quantity");
                t.price = h.getFloat("price");
                t.payment = h.getInt("payment");
                t.lmsmembercourse = h.key;
                t.status = 1;
                if(t.lmspay < 1)
                {
                    String str = new DecimalFormat("000").format(Profile.find(h.member).getAgent()) + new SimpleDateFormat("yyMMdd").format(new Date());
                    t.code = "GXYHBM" + str + t.payment + Seq.DF4.format(Seq.get(str));
                    t.member = h.member;
                    t.time = new Date();
                }
                t.set();
                t.setMember(true);
            } else if("voucher".equals(act)) //上传汇款凭证
            {
                int val = h.getInt("voucher.attch");
                if(val > 0)
                    t.set("voucher",String.valueOf(t.voucher = val));
            } else if("status".equals(act))
            {
                t.status = h.getInt("status");
                t.emember = h.member;
                t.etime = new Date();
                t.set();
                if(t.status == 2) //缴费成功， 未注册 改为 注册
                {
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        db.executeUpdate("UPDATE Profile SET type=2,verifgtime=CASE WHEN verifgtime IS NULL THEN " + DbAdapter.cite(t.time) + " ELSE verifgtime END WHERE type=0 AND profile IN(SELECT member FROM lmsmembercourse WHERE lmspay=" + t.lmspay + ")");
                    } finally
                    {
                        db.close();
                    }
                    Profile._cache.clear();
                }
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
