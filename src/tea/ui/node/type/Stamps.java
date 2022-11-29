package tea.ui.node.type;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.ui.*;
import tea.entity.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

public class Stamps extends HttpServlet
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
            out.println("<script>var mt=parent.mt;</script>");

            if("edit".equals(act)) //编辑
            {
                String subject = h.get("subject");
                String keywords = h.get("keywords");
                String content = h.get("content");
                int sequence = h.getInt("sequence");
                Node n = Node.find(h.node);
                if(n.getType() == 1)
                {
                    long options = n.getOptions();
                    int options1 = n.getOptions1();
                    if(h.getBool("html"))
                        options |= 0x40;
                    Category cat = Category.find(h.node); // 11
                    h.node = Node.create(h.node,sequence,n.getCommunity(),ts._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,h.language,null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,subject,keywords,"",content,null,"",0,null,"","","","",null,null);
                    //n = Node.find(h.node);
                    n.finished(h.node);
                } else
                {
                    n.set(h.language,subject,content);
                    n.setSequence(sequence);
                }
                Stamp t = Stamp.find(h.node,h.language);
                t.code = h.get("code");
                //邮票照片
                if(h.getBool("clearpicture"))
                    t.picture = null;
                String tmp = h.get("picture");
                if(tmp != null)
                {
                    t.picture = tmp;
                    if(h.getBool("tbn"))
                    {
                        File f = new File(application.getRealPath(t.picture));
                        BufferedImage bi = ImageIO.read(f);
                        bi = Img.scale(bi,500,500,false);
                        ImageIO.write(bi,"JPEG",f);
                    }
                }
                //推荐图片
                if(h.getBool("clearrecommend"))
                    t.recommend = null;
                tmp = h.get("recommend");
                if(tmp != null)
                    t.recommend = tmp;
                t.inumber = h.get("inumber");
                t.denomination = h.getFloat("denomination");
                t.designer = h.get("designer");
                t.dimension = h.get("dimension");
                t.perforation = h.get("perforation");
                t.part = h.get("part");
                t.printers = h.get("printers");
                t.printing = h.get("printing");
                t.rtime = h.getDate("rtime");
                t.set();
                if(nexturl.length() < 1)
                    nexturl = "/html/" + h.community + "/stamp/" + h.node + "-" + h.language + ".htm";
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta' style='display:none'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
