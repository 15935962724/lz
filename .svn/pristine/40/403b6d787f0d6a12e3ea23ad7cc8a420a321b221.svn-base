package tea.ui.member;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import tea.entity.site.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.ui.TeaSession;

public class SMessages extends HttpServlet
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
            TeaSession ts = new TeaSession(request);
            if(ts._rv == null)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }
            h.username = ts._rv._strR;

            Profile p = Profile.find(h.username);
            if("count".equals(act)) //短信剩余
            {
                out.print(SMessage.count());
                return;
            }
            if(!"POST".equals(request.getMethod()) || request.getHeader("referer") == null)
                act = null;

            out.println("<script>var mt=parent.mt;</script>");
            String info = "操作执行成功！";
            if("add".equals(act)) //编辑
            {
                for(int i = 0;i < 20;i++)
                {
                    out.print("// 显示进度条  \n");
                }
                //手机号
                String mob = "|" + h.get("mobile","").trim();
                if(mob.length() > 1)
                    mob = mob.replaceAll("[\r\n]+","|") + "|";

                int[] rs = SMessage.send(p.getProfile(),h.get("members","|"),mob,h.get("content"),out);
                if(rs == null)
                    info = "短信通道已被“禁用”，不可发送短信！";
                else
                    info = "发送完成！<br/><br/>成功：" + rs[0] + "<br/>失败：" + rs[1];
            } else
            {
                int smessage = h.getInt("smessage");
                String[] arr = smessage < 1 ? h.getValues("smessages") : new String[]
                               {String.valueOf(smessage)};
                if("del".equals(act)) //删除
                {
                    for(int i = 0;i < arr.length;i++)
                    {
                        SMessage t = SMessage.find(Integer.parseInt(arr[i]));
                        t.set("folder",String.valueOf(t.folder = 4));
                    }
                }
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
