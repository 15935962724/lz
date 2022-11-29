package tea.ui.os;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.os.IpSec;

public class IpSecs extends HttpServlet
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
                response.sendRedirect("/servlet/StartLogin?community=" + h.community);
                return;
            }
            String info = "操作执行成功！";
            IpSec t = new IpSec();
            t.srcaddr = h.get("srcaddr");
            if("add".equals(act)) //添加
            {
                int dstaddr = h.getInt("dstaddr");
                t.dstaddr = dstaddr == 6 ? h.get("dstaddr6") : IpSec.SERVER_TYPE[dstaddr];
                t.protocol = h.get("protocol");
                t.srcport = h.getInt("srcport");
                t.dstport = h.getInt("dstport");
                t.description = h.get("description");
                info += t.add();
            } else if("del".equals(act)) //删除
            {
                t.dstaddr = h.get("dstaddr");
                info += t.delete(); //末尾有\r\n
            } else if("clear".equals(act)) //清空
            {
                ArrayList al = IpSec.find(0,200);
                for(int i = 0;i < al.size();i++)
                {
                    t = (IpSec) al.get(i);
                    t.delete();
                }
            }
            out.print("<script>mt.show('" + info.trim() + "',1,'" + nexturl + "');</script>");
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
