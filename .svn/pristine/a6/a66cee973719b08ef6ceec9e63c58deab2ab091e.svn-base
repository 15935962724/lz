package tea.ui.node.type.mpoll;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.type.mpoll.*;

public class Polls extends HttpServlet
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
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            if(h.member < 1)
            {
                out.println("<script>mt.show('您还没有登录或登录已超时！请重新登录',2,'/');</script>");
                return;
            }

            int poll = h.getInt("poll");
            Poll t = Poll.find(poll);
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.name[0] = h.get("name0");
                t.name[1] = h.get("name1");
                t.content[0] = h.get("content0");
                t.content[1] = h.get("content1");
                t.filter = h.getInt("filter");
                t.question = h.getInt("question");
                t.captcha = h.getBool("captcha");
                t.etime = h.getDate("etime");
                t.elimit = h.getInt("elimit");
                t.score = h.getInt("score");
                if(poll < 1)
                {
                    t.community = h.community;
                    t.time = new Date();
                }
                t.set();
            } else if("clone".equals(act)) //复制
            {
                t.clone(0);
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + Err.get(h,ex) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
