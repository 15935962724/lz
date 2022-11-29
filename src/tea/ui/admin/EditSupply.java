package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.*;
import tea.entity.node.*;
import tea.db.*;
import java.text.SimpleDateFormat;

public class EditSupply extends TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        try
        {
            String act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            if("EditSupply".equals(act))
            {
                Supply sobj = Supply.find(teasession._nNode);
                String subject = teasession.getParameter("subject");
                int newstype = Integer.parseInt(teasession.getParameter("newstype"));

                Calendar c = Calendar.getInstance();
                if(sobj.isExists())
                {
                    c.setTime(sobj.getTimes());
                }

                int industrytype1 = 0;
                if(teasession.getParameter("big") != null && teasession.getParameter("big").length() > 0)
                {
                    industrytype1 = Integer.parseInt(teasession.getParameter("big"));
                }
                int industrytype2 = 0;
                if(teasession.getParameter("father") != null && teasession.getParameter("father").length() > 0)
                {
                    industrytype2 = Integer.parseInt(teasession.getParameter("father"));
                }
                int city = 0;
                if(teasession.getParameter("city") != null && teasession.getParameter("city").length() > 0)
                {
                    city = Integer.parseInt(teasession.getParameter("city"));
                }
                int city1 = 0;
                if(teasession.getParameter("city1") != null && teasession.getParameter("city1").length() > 0)
                {
                    city1 = Integer.parseInt(teasession.getParameter("city1"));
                }

                int term = Integer.parseInt(teasession.getParameter("term"));
                Date date = null;
                //int timethis = 0;
                if(term == 0)
                {
                    c.add(Calendar.DATE,3);
                    date = c.getTime();
                } else if(term == 1)
                {
                    c.add(Calendar.DATE,7);
                    date = c.getTime();
                } else if(term == 2)
                {
                    c.add(Calendar.DATE,30);
                    date = c.getTime();
                } else if(term == 3)
                {
                    c.add(Calendar.DATE,90);
                    date = c.getTime();
                }

                String picname = "";
                String picpath = "";
                byte by[] = teasession.getBytesParameter("picpath");
                if(teasession.getParameter("clear1") != null)
                {
                    picpath = "";
                    picname = "";
                } else if(by != null)
                {
                    picpath = write(teasession._strCommunity,by,".gif");
                    picname = teasession.getParameter("picpathName");
                } else
                {
                    picname = sobj.getPicname();
                    picpath = sobj.getPicpath();
                }
                String website = teasession.getParameter("website");
                String content = teasession.getParameter("content");
                int company = 0;
                java.util.Enumeration e = Node.find("  and rcreator =" + DbAdapter.cite(teasession._rv.toString()) + " and type = 21 order by time desc",0,Integer.MAX_VALUE);
                if(e.hasMoreElements())
                {
                    int nid = ((Integer) e.nextElement()).intValue();
                    company = nid;
                }
                int father = Integer.parseInt(teasession.getParameter("father"));

                //Node node = Node.find(teasession._nNode);
                Node node = Node.find(father);
                if(node.getType() == 1)
                {
                    long options = node.getOptions();
                    int options1 = node.getOptions1();
                    int defautllangauge = node.getDefaultLanguage();
                    Category cat = Category.find(teasession._nNode); //21
                    teasession._nNode = Node.create(father,0,teasession._strCommunity,teasession._rv,cat.getCategory(),true,options,options1,defautllangauge,null,date,new java.util.Date(),0,0,0,0,null,teasession._nLanguage,subject,"","",content,null,"",0,null,"","","","",null,"");
                    node.finished(teasession._nNode);
                } else
                {
                    node.set(teasession._nLanguage,subject,content);
                    node.setHidden(true);
                    if(father != node.getFather())
                    {
                        node.move(father,false);
                    }
                    node.setStopTime(date);
                }
                if(sobj.isExists())
                {
                    sobj.set(subject,newstype,industrytype1,industrytype2,city,term,picname,picpath,website,content,0,city1,company,sobj.getNode());
                } else
                {
                    Supply.create(subject,newstype,industrytype1,industrytype2,city,term,picname,picpath,website,content,0,company,teasession._rv.toString(),teasession._strCommunity,city1,teasession._nNode,teasession._nLanguage);
                }
                if(nexturl == null)
                {
                    nexturl = "/servlet/Node?node=" + teasession._nNode;
                }
                System.out.println(teasession._strCommunity);
                response.sendRedirect("/jsp/info/.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode("供应信息操作成功，请等待管理员审核通过 !","UTF-8") + "&nexturl=" + URLEncoder.encode(nexturl,"UTF-8"));
                return;
            } else if("SupplyList".equals(act))
            {
                int nodes = 0;
                if(teasession.getParameter("nodes") != null && teasession.getParameter("nodes").length() > 0)
                {
                    nodes = Integer.parseInt(teasession.getParameter("nodes"));
                }
                Supply sobj = Supply.find(nodes);

                sobj.delete();
                Node ns = Node.find(nodes);
                ns.delete(teasession._nLanguage);
                response.sendRedirect("/jsp/info/Succeed.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode("供应信息已经删除成功!","UTF-8") + "&nexturl=" + URLEncoder.encode(nexturl,"UTF-8"));
            } else if("qbdelete".equals(act))
            {
                String s[] = teasession.getParameterValues("checkbox_1");
                for(int i = 0;i < s.length;i++)
                {
                    Supply suobj = Supply.find(Integer.parseInt(s[i]));
                    suobj.delete();
                    // Node ns = Node.find(teasession._nNode); //以前的
                    Node ns = Node.find(Integer.parseInt(s[i]));
                    ns.delete_nodeid(teasession._nLanguage);
                }

                response.sendRedirect("/jsp/info/Succeed.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode("供应信息已经删除成功!","UTF-8") + "&nexturl=" + URLEncoder.encode(nexturl,"UTF-8"));
                return;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }

    }

    // Clean up resources
    public void destroy()
    {
    }
}
