package tea.ui.node.section;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

import tea.entity.*;
import tea.entity.node.*;
import tea.ui.*;
import tea.entity.member.*;
import java.util.*;

public class EditCssJs extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request);
        TeaSession teasession = new TeaSession(request);
        PrintWriter out = response.getWriter();
        String nu = teasession.getParameter("nexturl");
        try
        {
            int cssjs = h.getInt("cssjs");
            CssJs obj = null;
            int realnode = h.node;
            if(cssjs > 0)
            {
                obj = CssJs.find(cssjs);
                realnode = obj.getNode();
            }
            String act = h.get("act");
            Node node = Node.find(realnode);
            int purview = node.isCreator(teasession._rv) ? 3 : AccessMember.find(realnode,teasession._rv).getPurview();
            if(realnode > 0 && purview < 2)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                return;
            }
            if("move".equals(act))
            {
                boolean bool = "true".equals(h.get("sequence"));
                Enumeration e = CssJs.findByNode(realnode);
                for(int i = 0;e.hasMoreElements();i = i + 2)
                {
                    int _id = ((Integer) e.nextElement()).intValue();
                    obj = CssJs.find(_id);
                    if(_id == cssjs)
                    {
                        obj.setSequence(i + (bool ? -3 : 3));
                    } else
                    {
                        obj.setSequence(i);
                    }
                }
            } else if("delete".equals(act))
            {
                if(purview < 3)
                {
                    response.sendError(403);
                    return;
                }
                obj.delete(teasession._nLanguage);
                delete(Node.find(realnode));
                Logs.create(teasession._strCommunity,teasession._rv,9,cssjs,obj.getName(teasession._nLanguage));
                nu = "/jsp/section/CssJs.jsp?node=" + h.node + "&language=" + teasession._nLanguage + "&status=" + obj.getStatus();
            } else if("theme".equals(act))
            {
                ArrayList e = CssJs.find(" AND node=" + h.node + " AND theme=1 AND cssjs!=" + cssjs,0,200);
                for(int i = 0;i < e.size();i++)
                {
                    CssJs cj = (CssJs) e.get(i);
                    Cssjshide hi = Cssjshide.find(cj.cssjs,h.node);
                    hi.set(0);
                }
                Cssjshide.find(cssjs,h.node).set(3);
                delete(Node.find(realnode));
                nu = "/jsp/info/Succeed.jsp?community=" + teasession._strCommunity + "&nexturl=" + java.net.URLEncoder.encode("/jsp/section/CssJsTheme.jsp?node=" + h.node,"utf-8");
            } else if("hiden".equals(act))
            {
                String secs = h.get("cssjsids");
                String thiden = h.get("thiden");
                if(secs != null && secs.length() > 0 && (!"|".equals(secs)) && thiden != null && thiden.length() > 0)
                {
                    Node node2 = Node.find(h.node);
                    String se[] = secs.split("[|]");
                    int hiden = Integer.parseInt(thiden);
                    for(int i = 0;i < se.length;i++)
                    {
                        if(se[i] != null && se[i].length() > 0 && (!"|".equals(se[i])))
                        {
                            int setid = Integer.parseInt(se[i]);
                            CssJs sections = CssJs.find(setid);
                            if(sections.isExists())
                            {
                                Cssjshide sh = Cssjshide.find(setid,h.node);
                                sh.set(hiden);
                            }
                        }
                    }
                    delete(node2);
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

            } else
            {
                RV rv = teasession._rv;
                if(rv == null)
                {
                    rv = new RV("<" + request.getRemoteAddr() + ">");
                }
                //
                CssJs t = CssJs.find(cssjs);
                t.theme = h.getBool("theme");
                t.status = Integer.parseInt(h.get("status"));
                t.name = h.get("name");
                t.style = Integer.parseInt(h.get("style"));
                t.styletype = Integer.parseInt(h.get("type"));
                t.stylecategory = Integer.parseInt(h.get("stylecategory"));
                t.node = node._nNode;
                t.picture = h.getBool("pictureDel") ? "" : h.get("picture",t.picture);
                if(t.cssjs > 0)
                    Logs.create(teasession._strCommunity,rv,8,cssjs,t.name);
                t.set();
                t.setLayer(h.language,h.get("css"),h.get("js"));
                delete(node);

                Cssjshide ch = Cssjshide.find(cssjs,h.node);
                ch.set(Integer.parseInt(h.get("hiden")));

                if(h.get("example") != null)
                {
                    nu = "/jsp/site/EditExample.jsp?act=step2&extype=C&exid=" + cssjs;
                } else if(nu == null)
                {
                    nu = "/servlet/Node?node=" + h.node + "&language=" + teasession._nLanguage + "&status=" + t.status;
                }
            }
            response.sendRedirect(nu);
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
