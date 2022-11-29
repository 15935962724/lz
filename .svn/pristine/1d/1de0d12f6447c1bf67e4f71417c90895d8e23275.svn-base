package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LmsChapters extends HttpServlet
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
            String key = h.get("lmschapter");
            LmsChapter t = LmsChapter.find(key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key)));
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                t.name = h.get("name");
                t.content = h.get("content");
                t.vurl = h.get("vurl");
                t.durl = h.get("durl");
                if(t.lmschapter < 1)
                {
                    t.lmscourse = Integer.parseInt(MT.dec(h.get("lmscourse")));
                    t.sequence = (int) (System.currentTimeMillis() / 1000);
                }
                t.set();
            } else if("view".equals(act))
            {
                t.set("hits",String.valueOf(++t.hits));
				out.print("<html><script src='/tea/mt.js'></script><body class='iframe' style='margin:0'><script>mt.embed('http://player.youku.com/player.php/sid/" + LmsChapter.f(t.vurl) + "/v.swf','100%','100%');</script>");
                out.print("<div style='position:absolute;width:64px;height:39px;background-color:#F5F5F5;right:0;bottom:1;background-image:url(/res/" + h.community + "/logo_30.gif);background-repeat:no-repeat;background-position:center;' onclick=top.location.replace('/')></div>");
                return;
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
