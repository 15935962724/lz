package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.site.*;

public class Sites extends HttpServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request);

        ServletContext application = getServletContext();
        String act = h.get("act"),nexturl = h.get("nexturl","");
        PrintWriter out = response.getWriter();
        try
        {
//            if (h.member < 1)
//            {
//                out.print("<script>top.location.replace('/admin/Login.jsp');</script>");
//                return;
//            }
            if(!"POST".equals(request.getMethod()) || request.getHeader("referer") == null)
                act = null;
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            int site = h.getInt("site");
            Site t = Site.find(site);
            if("edit".equals(act))
            {
                t.name[0] = h.get("name0");
                t.name[1] = h.get("name1");
                t.summary[0] = h.get("summary0");
                t.summary[1] = h.get("summary1");
                t.domain = h.get("domain");
                t.term = h.get("term");
                t.header[0] = h.get("header0");
                t.header[1] = h.get("header1");
                t.footer[0] = h.get("footer0");
                t.footer[1] = h.get("footer1");
                t.mailserver = h.get("mailserver");
                t.mailuser = h.get("mailuser");
                t.mailpassword = h.get("mailpassword");
                t.homepage[0] = h.get("homepage0");
                t.homepage[1] = h.get("homepage1");
                t.set();
            } else if("style".equals(act))
            {
                String style = h.get("style");
                Filex.write(application.getRealPath("/res/cssjs/admin.css"),style);
            } else if("sms".equals(act))
            {
                t.smsserver = h.getInt("smsserver");
                t.smsuser = h.get("smsuser");
                t.smspassword = h.get("smspassword");
                t.smsremind = h.getBool("smsremind");
                t.set();
            } else if("watermark".equals(act))
            {
                t.wposition = h.getInt("wposition");
                String tmp = h.get("wlogo");
                if(tmp != null)
                    t.wlogo = tmp;
                t.set();
            } else if("register".equals(act))
            {
                t.register[0] = h.get("register0");
                t.register[1] = h.get("register1");
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
