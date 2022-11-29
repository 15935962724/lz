package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LmsCourses extends HttpServlet
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
            String key = h.get("lmscourse");
            int lmscourse = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
            if("del".equals(act)) //删除
            {
                LmsCourse t = LmsCourse.find(lmscourse);
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                LmsCourse t = LmsCourse.find(lmscourse);
                t.code = h.get("code");
                //t.type = h.getInt("type");
                t.name = h.get("name");
                t.address = h.get("address");
                int tmp = h.getInt("problem.attch");
                if(tmp > 0)
                    t.problem = tmp;
                t.content = h.get("content");
                t.lmscert = h.getInt("lmscert");
                //t.aspid = h.getInt("aspid");
                //t.planning = h.get("planning");
                //t.catalogid = h.getInt("catalogid");
                //t.objectid = h.getInt("objectid");
                t.period = h.getFloat("period");
                t.credit = h.getFloat("credit");
                t.status = h.getInt("status");
                t.operator = h.get("operator");
                t.utime = new Date();
                if(t.time == null)
                {
                    t.member = h.member;
                    t.time = t.utime;
                }
                t.set();
            } else if("status".equals(act))
            {
                int status = h.getInt("status");
                String[] arr = h.getValues("lmscourses");
                for(int i = 0;i < arr.length;i++)
                {
                    LmsCourse t = LmsCourse.find(Integer.parseInt(arr[i]));
                    t.set("status",String.valueOf(t.status = status));
                }
            }
            //
            StringBuilder sb = new StringBuilder();
            ArrayList al = LmsCourse.find("",0,Integer.MAX_VALUE);
            for(int i = 0;i < al.size();i++)
            {
                LmsCourse t = (LmsCourse) al.get(i);
                sb.append(",").append(t);
            }
            Filex.write(Http.REAL_PATH + "/res/" + h.community + "/cache/lmscourse.js","COURSE=[" + sb.append(" ").substring(1) + "];");

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
