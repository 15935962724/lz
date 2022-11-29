package tea.ui.node.type;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Reserves extends HttpServlet
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
                out.print("<script>mt.show('对不起，您还没有登陆，请先登陆！',2,'/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            Node n = Node.find(h.node);
            if("del".equals(act)) //删除
            {
                n.delete(h.language);
            } else if("hidden".equals(act)) //发布
            {
                n.setHidden(!n.isHidden());
            } else if("edit".equals(act)) //编辑
            {
                String code = h.get("code");
                Iterator it = Reserve.find(" AND node!=" + h.node + " AND code=" + DbAdapter.cite(code),0,1).iterator();
                if(it.hasNext())
                {
                    Reserve t = (Reserve) it.next();
                    out.print("<script>mt.show('“" + t.code + "”已被使用！');</script>");
                    return;
                }
                String subject = h.get("subject");
                String content = h.get("content");
                String picture = h.get("picture");
                Date starttime = h.getDate("starttime");
                if(n.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(h.node) + 10;
                    int options1 = n.getOptions1();
                    Category cat = Category.find(h.node); //102
                    h.node = Node.create(h.node,sequence,n.getCommunity(),new RV(h.username),cat.getCategory(),(options1 & 2) != 0,n.getOptions(),options1,h.language,starttime,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,subject,"","",content,picture,"",0,null,"","","","",null,null);
                    n.finished(h.node);
                } else
                {
                    n.set(h.language,subject,content);
                    if(h.getBool("clear") || picture != null)
                        n.setPicture(picture,h.language);
                    n.setStartTime(starttime);
                }
                Reserve t = Reserve.find(h.node,h.language);
                t.code = code;
                t.level = h.getInt("level");
                t.type = h.getInt("type");
                t.dept = h.getInt("dept");
                t.city = h.getInt("city");
                t.adminarea = h.get("adminarea");
                t.protect = h.get("protect");
                t.map = h.get("map");
                t.area = h.getFloat("area");
                t.years = h.getInt("years");
                t.longitude = Reserve.f(h.get("longitude"));
                t.latitude = Reserve.f(h.get("latitude"));
                t.set();
                if(nexturl.length() < 1)
                    nexturl = "/html/reserve/" + h.node + "-" + h.language + ".htm";
            }
            TeaServlet.delete(n);

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
