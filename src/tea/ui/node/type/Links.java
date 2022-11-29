package tea.ui.node.type;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.ui.*;
import tea.resource.*;
import java.net.*;

public class Links extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        TeaSession teasession = new TeaSession(request);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        PrintWriter out = response.getWriter();
        try
        {
            out.print("<script>var mt=parent.mt;</script>");
            String info = h.get("info","操作执行成功！");
            Node node = Node.find(h.node);
            if("edit".equals(act))
            {
                String subject = h.get("subject");
                if(subject == null)
                    return;
                String text = h.get("text");
                String url = h.get("url");
                try
                {
                    new URL(url);
                } catch(MalformedURLException ex)
                {
                    out.print("<script>mt.show('“" + url + "”无效网址.')</script>");
                    return;
                }
                int sequence = h.getInt("sequence");
                String logo = h.get("logo");
                //
                int node_id;
                if(h.get("NewNode") != null)
                {
                    node_id = h.node;
                    if(teasession._rv == null)
                        teasession._rv = RV.ANONYMITY;

                    long options = node.getOptions();
                    int options1 = node.getOptions1();
                    String community = node.getCommunity();
                    Category cat = Category.find(h.node); //78
                    h.node = Node.create(h.node,sequence,community,teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,h.language,null,null,new java.util.Date(),0,0,0,0,null,h.language,subject,subject,"",text,logo,"",0,null,url,"","","",null,null);
                    node = Node.find(h.node);
                    node.finished(h.node);
                } else
                {
                    node.set(h.language,subject,text);
                    node.setSequence(sequence);
                    node.set("clickurl",h.language,url);
                    node.setPicture(logo,h.language);
                    node_id = node.getFather();
                }
                Link t = Link.find(h.node,h.language);
                t.name = h.get("name");
                t.email = h.get("email");
                t.password = h.get("password");
                t.type = h.getBool("type");
                t.classes = h.getInt("classes");
                t.ip = request.getRemoteAddr();
                t.set();
                if(nexturl.length() < 1)
                    nexturl = "/html/" + h.community + "/category/" + node_id + "-" + h.language + ".htm";
                TeaServlet.delete(node);
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "')</script>");
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
