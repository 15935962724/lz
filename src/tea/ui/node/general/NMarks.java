package tea.ui.node.general;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import java.util.*;
import tea.entity.node.*;
import tea.ui.*;
import tea.entity.*;

public class NMarks extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act");
        PrintWriter out = response.getWriter();
        try
        {
			out.print("<script>var mt=parent.mt;</script>");
            if("add".equals(act))
            {
                String nmrak = h.getCook("nmark","|");
                if(nmrak.indexOf("|" + h.node + "|") != -1)
                {
                    out.print("<script>mt.show('您已经投过票了，不能重复投票！');</script>");
                    return;
                }
                NMark t = NMark.find(h.node);
                if(h.getBool("mark"))
                    t.good++;
                else
                    t.poor++;
                t.set();
                Cookie c = new Cookie("nmark",nmrak + h.node + "|");
                c.setMaxAge(60 * 60 * 24 * 30);
                c.setPath("/");
                response.addCookie(c);
                out.print("<script>mt.show('投票成功！感谢您的参与！');parent.mt.nmark(0," + t.good + "," + t.poor + ");</script>");
                return;
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + h.get("nexturl","") + "');</script>");
        } catch(Exception ex)
        {
			ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }
}
