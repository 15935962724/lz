package tea.ui.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.ui.*;
import tea.entity.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;

public class Videos extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            if("edit".equals(act)) //编辑
            {
                int picture = h.getInt("picture");
                Node n = Node.find(h.node);
                if(n.getType() == 1)
                {
                    n = n.clone();
                    int options1 = n.getOptions1();

                    Category cat = Category.find(h.node);
                    n.father = h.node;
                    n.member = h.member;
                    n.creator = new RV(h.username);
                    n.type = cat.getCategory(); //113
                    n.hidden = (options1 & 2) != 0;
                    n.defaultLanguage = h.language;
                    n.time = new Date();
                } else
                {
                    //if(picture == null)
                    //    picture = n.getPicture(h.language);
                }
                n.starttime = h.getDate("starttime");
                n.sequence = h.getInt("sequence");
                n.mostly = h.get("mostly") != null;
                n.mostly1 = h.get("mostly1") != null;
                n.mostly2 = h.get("mostly2") != null;
                n.mark = h.get("mark","|").replace('|','/');
                n.set();
                n.setLayer(h.language,h.get("subject"),n.getKeywords(h.language),n.getDescription(h.language),h.get("content"),null,null,0,null,null,null,null,null,n.getFile(h.language),null);
                n.set("picture2",h.language,String.valueOf(picture));
                h.node = n._nNode;
                //
                Video t = Video.find(h.node,h.language);
                t.video = h.getInt("video");
                t.set();
                n.finished(h.node);

                // 手动列举
                StringBuffer sb = new StringBuffer();
                sb.append("0");
                String[] ls = h.get("listing").split("/");
                DbAdapter db = new DbAdapter();
                try
                {
                    for(int i = 1;i < ls.length;i++)
                    {
                        sb.append(",").append(ls[i]);
                        db.executeQuery("SELECT listed FROM Listed WHERE node=" + h.node + " AND listing=" + ls[i]);
                        if(!db.next())
                        {
                            Listed.create(h.node,Integer.parseInt(ls[i]),null);
                        }
                    }
                    db.executeUpdate(h.node,"DELETE FROM Listed WHERE node=" + h.node + " AND listing NOT IN(" + sb.toString() + ")");
                } finally
                {
                    db.close();
                }
                TeaServlet.delete(n);
                if(nexturl.length() < 1)
                    nexturl = "/html/video/" + h.node + "-" + h.language + ".htm";
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
