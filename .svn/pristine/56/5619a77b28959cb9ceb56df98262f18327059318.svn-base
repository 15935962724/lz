package tea.ui.member.community;


import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.http.RequestHelper;
import tea.ui.*;
import tea.db.*;
import tea.resource.*;
import tea.entity.admin.*;

public class EditCommunityXml extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            String act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            int xmlid = 0;
            if(teasession.getParameter("xmlid") != null && teasession.getParameter("xmlid").length() > 0)
            {
                xmlid = Integer.parseInt(teasession.getParameter("xmlid"));
            }
            CommunityXml cxobj = CommunityXml.find(xmlid);
            if("EditCommunityXml".equals(act))
            {
                String subject = teasession.getParameter("subject");
                String content = teasession.getParameter("content");
                String charset = teasession.getParameter("charset");

                if(cxobj.isExist())
                {
                    cxobj.set(subject,content,charset,teasession._strCommunity);
                } else
                {
                    CommunityXml.create(subject,content,charset,teasession._strCommunity);
                }

                String xmlpath = Common.REAL_PATH + "/res/" + teasession._strCommunity + "/xml/";
                cxobj.newFile(xmlpath,subject + ".xml",content);
            } else if("DELETE".equals(act))
            {
                String xmlpath = Common.REAL_PATH + "/res/" + teasession._strCommunity + "/xml/";
                cxobj.delete();
                cxobj.delFile(xmlpath + cxobj.getSubject() + ".xml");
            } else if("EditCommunityXmlAjax".equals(act))
            {

                String subject = teasession.getParameter("subject");
                System.out.print(subject);
                if(cxobj.isExist()) //修改
                {
                    if(!cxobj.getSubject().equals(subject) && CommunityXml.isSubject(teasession._strCommunity,subject))
                    {
                        out.print("你输入的名称已经重复,请重新输入!");
                    }

                } else
                { //添加时候
                    if(CommunityXml.isSubject(teasession._strCommunity,subject))
                    {
                        out.print("你输入的名称已经重复,请重新输入!");
                    }
                }
                return;
            }

            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            response.sendError(400,ex.toString());
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/ui/member/community/EditCommunity");
    }
}
