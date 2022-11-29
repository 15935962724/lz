package tea.ui.node.section;

import java.io.*;
import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.member.*;

public class EditSection extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        Http h = new Http(request,response);
        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            int section = h.getInt("section");
            if(section < 1)
            {
                if(h.node > 0 && !Node.find(h.node).isCreator(teasession._rv) && AccessMember.find(h.node,teasession._rv).getPurview() < 2)
                {
                    response.sendError(403);
                    return;
                }
                String act = h.get("act");
                if("hiden".equals(act))
                {
                    String secs = h.get("secs");
                    String thiden = h.get("thiden");
                    if(secs != null && secs.length() > 0 && (!"|".equals(secs)) && thiden != null && thiden.length() > 0)
                    {
                        Node node = Node.find(h.node);
                        String se[] = secs.split("[|]");
                        int hiden = Integer.parseInt(thiden);
                        for(int i = 0;i < se.length;i++)
                        {
                            if(se[i] != null && se[i].length() > 0 && (!"|".equals(se[i])))
                            {
                                int setid = Integer.parseInt(se[i]);
                                Section sections = Section.find(setid);
                                if(sections.time!=null)
                                {
                                    Sectionhide sh = Sectionhide.find(setid,h.node);
                                    sh.set(hiden);
                                }
                            }
                        }
                        delete(node);
                    }
                    String nexturl = h.get("nexturl");
                    //out.print("<script>var pmt=parent.mt,doc=parent.document;</script>");
                    out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
//            		 out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
                    //out.print("<script>alert(doc);</script>");
//            		  out.print("<script>mt.show('隐藏成功！',1,'http://www.baidu.com');</script>");
                    // out.print("<script>mt.show('用户名或密码错误！');</script>");
                    out.print("<script>parent.location.replace('" + nexturl + "');</script>");
                    return;
                }
            }
            int realnode = h.node;
            Section obj = null;
            if(section != 0)
            {
                obj = Section.find(section);
                realnode = obj.getNode();
            }
            Node node = Node.find(realnode);
            if(realnode > 0 && !node.isCreator(teasession._rv) && AccessMember.find(realnode,teasession._rv).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            if("GET".equals(request.getMethod()))
            {
                response.sendRedirect("/jsp/section/EditSection.jsp?" + request.getQueryString());
            } else
            {
                RV rv = teasession._rv;
                if(rv == null)
                {
                    rv = new RV("<" + request.getRemoteAddr() + ">");
                }
				String name=h.get("themename");
                Section s = Section.find(section);
                s.status = h.getInt(("status"));
                s.style = h.getInt(("style"));
                s.styletype = h.getInt(("type"));
                s.stylecategory = h.getInt("stylecategory");
                s.node = h.node;
                s.position = h.getInt(("position"));
                s.sequence = h.getInt("sequence");
                s.visible = h.getInt(("visible"));
                s.options = h.getInt(("textorhtml"));
                s.time = h.getDate("Issue");
                if(s.section > 0)
                {
                    Logs.create(teasession._strCommunity,rv,6,s.section,name);
                }
                s.set();

                //
                String picture = h.get("Picture");
                if(h.getBool("ClearPicture"))
                {
                    picture = "";
                }
                String voice = h.get("Voice");
                if(h.getBool("ClearVoice"))
                {
                    voice = "";
                }
                String file = h.get("File");
                String filename = h.get("FileName");
                if(h.getBool("ClearFile"))
                {
                    file = "";
                }
                s.setLayer(h.language,name,h.get("content").replaceAll("%u3c","<"),picture,h.get("ClickUrl"),h.get("Alt"),h.getInt(("Align")),voice,filename,file);
                //
                String tmp = h.get("hiden");
                if(tmp != null)
                {
                    int ht = Integer.parseInt(tmp);
                    Sectionhide ch = Sectionhide.find(section,h.node);
                    ch.set(ht);
                }
                delete(node);
                String nu = h.get("nexturl");
                if(h.get("example") != null)
                {
                    nu = "/jsp/site/EditExample.jsp?act=step2&extype=S&exid=" + section;
                } else if(nu == null)
                {
                    nu = "/servlet/Node?node=" + h.node + "&language=" + h.language + "&status=" + s.status + "&edit=ON";
                }
                response.sendRedirect(nu);
            }
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/section/EditSection").add("tea/ui/node/general/NodeServlet");
    }
}
