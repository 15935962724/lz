package tea.ui.node.type.media;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;

public class EditMedia extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String act = h.get("act"),nexturl = h.get("nexturl");
            if("exists".equals(act))
            {
                out.print(Media.count(" AND m.community=" + DbAdapter.cite(h.community) + " AND m.type=" + h.getInt("type") + " AND ml.name=" + DbAdapter.cite(h.get("q"))));
                return;
            }
            int media = h.getInt("media");
            if("del".equals(act))
            {
                Media obj = Media.find(media);
                obj.delete(h.language);
            } else
            {
                Media t = Media.find(media);
                t.community = h.community;
                t.type = Integer.parseInt(h.get("type"));
                String name = h.get("name","").replaceAll("\"","&quot;");
                if(Media.count(" AND m.community=" + DbAdapter.cite(h.community) + " AND m.type=" + t.type + " AND m.media!=" + media + " AND ml.name=" + DbAdapter.cite(name)) > 0)
                {
                    out.print("<script>alert('抱歉，“标题”重复！');</script>");
                    return;
                }
                String logo = h.get("picture");
                if(h.getBool("clear"))
                    logo = null;
                else if(logo == null)
                    logo = t.getLogo(h.language);
                t.set(h.language,name,logo,h.get("url"));
            }
            out.print("<script>window.open('" + nexturl + "','dialog');</script>");
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
