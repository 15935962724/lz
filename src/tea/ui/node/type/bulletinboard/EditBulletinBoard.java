package tea.ui.node.type.bulletinboard;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.htmlx.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.RV;
import tea.entity.member.*;

public class EditBulletinBoard extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        try
        {
            Node node = Node.find(teasession._nNode);
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
            String nu = teasession.getParameter("nexturl");
            String subject = teasession.getParameter("subject");
            if(subject.length() < 1)
            {
                outText(teasession,response,r.getString(teasession._nLanguage,"InvalidSubject"));
                return;
            }
            String text = teasession.getParameter("content");
            if(node.getType() == 1)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                long options = node.getOptions();
                int options1 = node.getOptions1();
                Category cat = Category.find(teasession._nNode);
                int defautllangauge = node.getDefaultLanguage();
                teasession._nNode = Node.create(teasession._nNode,sequence,node.getCommunity(),teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,teasession._nLanguage,subject,"","",text,null,"",0,null,"","","","",null,null);
                node = Node.find(teasession._nNode);
            } else
            {
                node.set(teasession._nLanguage,subject,text);
            }
            node.finished(teasession._nNode);
            delete(node);

            response.sendRedirect(nu);
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
