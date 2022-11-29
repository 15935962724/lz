package tea.ui.os;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.os.*;

public class DNSZones extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request);
        PrintWriter out = response.getWriter();
        try
        {
            String act = h.get("act"),nexturl = h.get("nexturl","");
            if("hosts".equals(act))
            {
                response.setHeader("Content-Disposition","attachment; filename=\"hosts.txt\"");
                StringBuilder sb = new StringBuilder();
                ArrayList al = DNSZone.find("",0,Integer.MAX_VALUE);
                for(int i = 0;i < al.size();i++)
                {
                    DNSZone z = (DNSZone) al.get(i);
                    sb.append("127.0.0.1  " + z.name + "\r\n");
                }
                out.print(sb.toString());
                return;
            }
            out.println("<script>var mt=parent.mt;</script>");
            String info = "操作执行成功！";
            if("redit".equals(act))
            {
                DNSRecord r = new DNSRecord(h.get("zone"),h.get("name"));
                r.type = h.get("type");
                r.content = h.get("content",request.getRemoteAddr());
                r.set();
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
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
