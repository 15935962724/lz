package tea.ui.node.type.newspaper;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import tea.entity.node.*;
import tea.htmlx.*;
import tea.ui.*;

public class EditNewsPaper extends TeaServlet
{

    public EditNewsPaper()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);

            if((node.getOptions1() & 1) == 0)
            {
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" +teasession._nNode);
                    return;
                }
                if(!node.isCreator(teasession._rv) && !AccessMember.find(node._nNode,teasession._rv._strV).isProvider(44))
                {
                    response.sendError(403);
                    return;
                }
            }

            String subject = teasession.getParameter("subject");
            if(subject == null || ((subject = subject.trim()).length() < 1))
            {
                outText(teasession,response,r.getString(teasession._nLanguage,"InvalidSubject"));
                return;
            }
            String content = teasession.getParameter("content");

            String keywords = teasession.getParameter("keywords");
            int sequence = Integer.parseInt(teasession.getParameter("sequence"));
            if(teasession.getParameter("NewNode") != null)
            {
                int options1 = node.getOptions1();
                Category cat = Category.find(teasession._nNode);
                // int defautllangauge = 0; //defaultlanguage node.getDefaultLanguage();
                teasession._nNode = Node.create(teasession._nNode,sequence,node.getCommunity(),teasession._rv,cat.getCategory(),(options1 & 2) != 0,node.getOptions(),options1,node.getDefaultLanguage(),null,null,new java.util.Date(),0,0,0,0,null,teasession._nLanguage,subject,keywords,"",content,null,"",0,null,"","","","",null,null);
                // node = Node.find(teasession._nNode);
            } else
            {
                node.setSequence(sequence);
                node.set(teasession._nLanguage,subject,content);
                node.setKeywords(keywords,teasession._nLanguage);
            }

            Date pubdate = TimeSelection.makeTime(teasession.getParameter("IssueYear"),teasession.getParameter("IssueMonth"),teasession.getParameter("IssueDay"),teasession.getParameter("IssueHour"),teasession.getParameter("IssueMinute"));

            String subtitle = teasession.getParameter("subtitle");
            int issue = Integer.parseInt(teasession.getParameter("issue"));
            String column = teasession.getParameter("column");
            String edition = teasession.getParameter("edition");
            String editor = teasession.getParameter("editor");
            String author = teasession.getParameter("author");

            NewsPaper newsPaper = NewsPaper.find(teasession._nNode,teasession._nLanguage);
            newsPaper.set(subtitle,issue,edition,column,pubdate,author,editor);

            delete(node);

            node.finished(teasession._nNode);
            if(teasession.getParameter("GoBack") != null)
            {
                response.sendRedirect("EditNode?node=" + teasession._nNode);
            } else
            {
                response.sendRedirect("Node?node=" + teasession._nNode);
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
        super.r.add("tea/ui/node/type/newspaper/EditNewsPaper");
    }
}
