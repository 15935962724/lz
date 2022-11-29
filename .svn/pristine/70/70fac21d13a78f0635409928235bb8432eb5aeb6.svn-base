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

public class Animals extends HttpServlet
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
                String subject = h.get("subject");
                String content = h.get("content");
                int attch=h.getInt("filename.attch");
                if(n.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(h.node) + 10;
                    int options1 = n.getOptions1();
                    Category cat = Category.find(h.node); //103
                    h.node = Node.create(h.node,sequence,n.getCommunity(),new RV(h.username),cat.getCategory(),(options1 & 2) != 0,n.getOptions(),options1,h.language,null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,subject,"","",content,"|"+attch+"|","",0,null,"","","","",null,null);
                    n.finished(h.node);
                } else
                {
                    n.set(h.language,subject,content);
                    if(attch>0)
                    {
                      n.setPicture("|"+attch+"|", h.language);
                      Attch a=Attch.find(attch);
                      a.path2="/res/attch/600/image/beast/"+h.node+"_"+a.attch+".jpg";
                      Img img=new Img(application.getRealPath(a.path));
                      img.width=img.height=600;
                      img.gravity = "Center";
                      img.composite = Http.REAL_PATH + "/res/papc/1303/watermark.png";
                      boolean rs=img.start(application.getRealPath(a.path2));
                      if(rs)a.set("path2",a.path2);
                    }
                }
                Animal t = Animal.find(h.node);
                t.type = h.getInt("type");
                //t.picture = h.get("picture");
                //t.wzdm = h.getInt("wzdm");
                t.code = h.get("code");
                t.name = subject;
                t.latin = h.get("latin");
                t.cites = h.get("cites");
                t.iucn = h.get("iucn");
                t.alevel = h.get("alevel");
                t.rlevel = h.get("rlevel");
                t.city = h.get("city");
                t.reserve = h.get("reserve");
                t.range = h.get("range");
                t.endanger = h.get("endanger");
                t.environment = h.get("environment");
                t.feature = h.get("feature");
                t.genus = h.get("genus");
                t.family = h.get("family");
                t.order1 = h.get("order1");
                t.set();
                if(nexturl.length() < 1)
                    nexturl = "/html/animal/" + h.node + "-" + h.language + ".htm";
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
