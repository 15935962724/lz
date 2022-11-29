package tea.ui.member.community;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.community.*;
import tea.ui.*;

public class Medals extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        PrintWriter out = response.getWriter();
        try
        {
            String act = h.get("act");
            String nexturl = h.get("nexturl");
            int medal = h.getInt("medal");
            Medal t = Medal.find(medal);
            out.print("<script>var mt=parent.mt;</script>");
            if("del".equals(act))
            {
                t.delete();
            } else if("edit".equals(act))
            {
                t.community = h.community;
                t.name = h.get("name");
                String tmp = h.get("picture");
                if(tmp != null)
                    t.picture = tmp;
                if(medal < 1)
                    t.sequence = (int) (System.currentTimeMillis() / 10000);
                t.set();
            }
            out.print("<script>mt.show('数据操作成功！',1,'" + nexturl + "');</script>");
        } catch(Exception ex1)
        {
            ex1.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
