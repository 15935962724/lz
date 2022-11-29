package tea.ui.node.type.tender;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.htmlx.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.*;

//86
public class EditTender extends TeaServlet
{
    public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        try
        {
            String act = request.getParameter("act");
            if("down".equals(act))
			{
				Http h=new Http(request);
                String nu = Tender.check(h);
                if(nu != null)
                {
                    response.sendRedirect(nu);
                    return;
                }
                Tender s = Tender.find(teasession._nNode,teasession._nLanguage);
                String path = s.getFilePath();
                String name = s.getFileName();
                ServletContext application = getServletContext();
                response.setHeader("Content-Disposition","attachment; filename=" + new String(name.getBytes("GBK"),"ISO-8859-1"));
                File f = new File(application.getRealPath(path));
                response.setContentLength((int) f.length());
                byte by[] = new byte[8192];
                OutputStream os = response.getOutputStream();
                FileInputStream fis = new FileInputStream(f);
                try
                {
                    int i = 0;
                    while((i = fis.read(by)) != -1)
                    {
                        os.write(by,0,i);
                    }
                } finally
                {
                    fis.close();
                    os.close();
                }
                return;
            }
            int father = Integer.parseInt(teasession.getParameter("father"));
            Node node = Node.find(father);
            if((node.getOptions1() & 1) == 0)
            {
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                if(!node.isCreator(teasession._rv) && !AccessMember.find(node._nNode,teasession._rv._strV).isProvider(85))
                {
                    response.sendError(403);
                    return;
                }
            } else if(teasession._rv == null)
            {
                teasession._rv = RV.ANONYMITY;
            }
            String subject = teasession.getParameter("subject");
            if(subject.length() < 1)
            {
                outText(teasession,response,r.getString(teasession._nLanguage,"InvalidSubject"));
                return;
            }
            String text = teasession.getParameter("content");
            String keywords = teasession.getParameter("keywords");
            boolean mostly = teasession.getParameter("mostly") != null;
            boolean mostly1 = teasession.getParameter("mostly1") != null;
            boolean mostly2 = teasession.getParameter("mostly2") != null;
            boolean textorhtml = "1".equals(teasession.getParameter("TextOrHtml"));
            Date stop = TimeSelection.makeTime(teasession.getParameter("StopYear"),teasession.getParameter("StopMonth"),teasession.getParameter("StopDay"),teasession.getParameter("StopHour"),teasession.getParameter("StopMinute"));
            if(teasession.getParameter("NewNode") != null)
            {
                int sequence = Node.getMaxSequence(father) + 10;
                long options = node.getOptions();
                int options1 = node.getOptions1();
                if(textorhtml)
                {
                    options |= 0x40;
                }
                Category cat = Category.find(father);
                int defautllangauge = node.getDefaultLanguage();
                teasession._nNode = Node.create(father,sequence,node.getCommunity(),teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,stop,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,teasession._nLanguage,subject,keywords,"",text,null,"",0,null,"","","","",null,null);
                node = Node.find(teasession._nNode);
            } else
            {
                node = Node.find(teasession._nNode);
                if(father != node.getFather())
                {
                    node.move(father,false);
                }
                node.set(teasession._nLanguage,subject,text);
                long options = node.getOptions();
                if(textorhtml)
                {
                    options |= 0x40;
                }
				node.set("stoptime",stop);
                node.setOptions(options);
                node.setHidden((node.getOptions1() & 2) != 0);
                node.setKeywords(keywords,teasession._nLanguage);
                Logs.create(node.getCommunity(),teasession._rv,2,teasession._nNode,subject);
            }
            node.set(mostly,mostly1,mostly2,"");

            Tender obj = Tender.find(teasession._nNode,teasession._nLanguage);
            int media = Integer.parseInt(teasession.getParameter("media"));
            String locus = teasession.getParameter("locus");
            String subhead = teasession.getParameter("subhead");
            String author = teasession.getParameter("author");
            String filepath = null,filename = null;
            byte[] by = teasession.getBytesParameter("file");
            boolean clearfile = teasession.getParameter("clearfile") != null;
            if(by != null)
            {
                filepath = write(node.getCommunity(),"tender",by,teasession._nNode + "_" + System.currentTimeMillis() + Math.random() + ".doc");
                filename = teasession.getParameter("fileName");
            } else if(!clearfile)
            {
                filepath = obj.getFilePath();
                filename = obj.getFileName();
            }
            String logograph = (teasession.getParameter("logograph"));
            Date issue = TimeSelection.makeTime(teasession.getParameter("IssueYear"),teasession.getParameter("IssueMonth"),teasession.getParameter("IssueDay"),teasession.getParameter("IssueHour"),teasession.getParameter("IssueMinute"));
            obj.set(media,subhead,author,locus,filepath,filename,logograph,issue);
            ////////
            delete(node);
            String nu = teasession.getParameter("nexturl");
            if("back".equals(teasession.getParameter("act")))
            {
                nu = "/servlet/EditNode?node=" + teasession._nNode;
            } else
            {
                node.finished(teasession._nNode);
                if(nu == null)
                {
                    nu = "/servlet/Tender?node=" + teasession._nNode;
                }
            }
            response.sendRedirect(nu);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }
}
