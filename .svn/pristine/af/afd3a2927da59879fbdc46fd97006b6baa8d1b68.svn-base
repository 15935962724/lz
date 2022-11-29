package tea.ui.member.community;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.ui.*;

public class EditWatermark extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
		response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        Http h = new Http(request,response);
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }

        String nexturl = h.get("nexturl");

        PrintWriter out = response.getWriter();
        try
        {
            out.print("<script>var mt=parent.mt,$=parent.$;</script>");
            String info = h.get("info","操作执行成功！");

            Watermark obj = Watermark.find(teasession._strCommunity);
            int location = h.getInt("location");
            String logo = obj.getLogo();
            String tmp = h.get("logo");
            if(tmp != null)
                logo = tmp;
            int alpha = h.getInt("alpha");
            int zoom = h.getInt("zoom");
            String ext = h.get("ext");
            obj.type = h.get("type","|");
            obj.set(location,logo,alpha,ext,zoom);

            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Exception ex)
        {
            out.print("<script>mt.show(\"<textarea cols=29 rows=3>" + ex.toString() + "</textarea>\",1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
