package tea.ui.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.weixin.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class WxRules extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            if (h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            int rule = h.getInt("rule");
            WxRule t = WxRule.find(rule);
            if ("del".equals(act)) //删除
            {
                t.delete();
            } else if ("edit".equals(act)) //编辑
            {
                t.name = h.get("name");
                //关键字
                Arrays.fill(t.keyword, null);
                String[] arr = h.getValues("keyword");
                int i = Math.min(arr.length, t.keyword.length);
                while (i-- > 0)
                    t.keyword[i] = arr[i];
                //内容
                t.type = h.getInt("type");
                t.content[1] = h.get("content1");
                t.content[2] = h.get("content2");
                if (t.wxrule < 1)
                {
                    t.community = h.community;
                    t.time = new Date();
                }
                t.set();
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch (Throwable ex)
        {
            out.print("<textarea id=ta>" + Err.get(h,ex) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
