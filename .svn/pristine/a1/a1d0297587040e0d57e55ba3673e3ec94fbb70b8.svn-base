package tea.ui.os;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.os.*;

public class Firewalls extends HttpServlet
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
            String info = null;
            out.println("<script>var mt=parent.mt;</script>");
            Firewall t = new Firewall();
            t.protocol = h.getInt("protocol");
            t.port = h.getInt("port");
            t.profile = h.getInt("profile");
            t.program = h.get("program");
            if("edit".equals(act))
            {
                //删除旧的
                Firewall f = new Firewall();
                f.protocol = h.getInt("oldprotocol");
                f.port = h.getInt("oldport");
                f.program = h.get("oldprogram");
                f.delete();
                //
                t.name = h.get("name","");
                t.mode = h.getInt("mode");
                t.scope = h.getInt("scope");
                t.addresses = h.get("addresses","");
                info = t.set();
            } else if("del".equals(act))
            {
                info = t.delete(); //末尾有\r\n
            } else if("reset".equals(act))
            {
                info = t.reset();
                t.protocol = 1;
                t.port = request.getLocalPort();
                t.name = "Web 服务器(HTTP)/" + request.getServerName();
                t.set();
            } else if("notifications".equals(act))
            {
                info = t.set(h.getBool("notifications"));
            } else if("opmode".equals(act))
            {
                info = t.set(h.getBool("opmode"),h.getBool("exceptions"));
            }
            info = "确定。\r\n\r\n".equals(info) ? "操作执行成功！" : info.replaceAll("\r\n","<br/>");
            out.print("<script>mt.show(\"" + info + "\",1,'" + nexturl + "');</script>");
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
