package tea.ui.weixin;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.weixin.*;

public class WxReds extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            int wxred = h.getInt("wxred");
            WxRed t = WxRed.find(wxred);
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.community = h.community;
                t.city = h.getInt("city2");
                if(t.city < 1 || t.city == 1101 || t.city == 1201 || t.city == 3101 || t.city == 5001)
                    t.city = h.getInt("city1");
                if(WxRed.count(" AND community=" + DbAdapter.cite(h.community) + " AND city=" + t.city + " AND wxred!=" + t.wxred) > 0)
                {
                    out.print("<script>mt.show('该“地区”已存在！');</script>");
                    return;
                }
                t.limit = h.getInt("limit");
                t.total = h.getInt("total");
                for(int i = 1;i < WxRed.PROBABILITY.length;i++)
                {
                    t.probability[i] = h.getInt("probability" + i);
                }
                t.pline = h.getInt("pline");
                t.hidden = h.getBool("hidden");
                t.set();
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id=ta>" + Err.get(null,ex) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
