package tea.ui.node.type.job;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.entity.node.*;
import tea.entity.*;
import tea.ui.*;
import java.util.*;

public class EditJob extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new tea.ui.TeaSession(request);
        try
        {
            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/job/EditJob.jsp?node=" + teasession._nNode);
            } else
            {
                String nu = request.getParameter("nexturl");
                Node node = Node.find(teasession._nNode);
                String subject = teasession.getParameter("subject");
                String text = teasession.getParameter("text");
                if(node.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                    int options1 = 0;
                    String community = teasession._strCommunity;
                    long options = node.getOptions();
                    int defautllangauge = node.getDefaultLanguage();
                    Category cat = Category.find(teasession._nNode);
                    teasession._nNode = Node.create(teasession._nNode,sequence,community,teasession._rv,cat.getCategory(),false,options,options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,null,teasession._nLanguage,subject,"","",text,null,"",0,null,"","","","",null,null);
                    node=Node.find(teasession._nNode);
					node.finished(teasession._nNode);
                } else
                {
                    node.set(teasession._nLanguage,subject,text);
                }

                //
                int reqwyearid = 0;
                String tmp = request.getParameter("sltReqWyearId");
                if(tmp != null)
                {
                    reqwyearid = Integer.parseInt(tmp);
                }
                //
                int headcount = 0;
                tmp = request.getParameter("txtHeadCount");
                if(tmp != null)
                {
                    headcount = Integer.parseInt(tmp);
                }
                //
                String occid = request.getParameter("occid"); //职位类别
                //
                String locid = request.getParameter("locid");

                //
                int company = Integer.parseInt(request.getParameter("company"));
                String jobtype = request.getParameter("jobtype"); //职位性质
                String adcode = teasession.getParameter("adcode");
                Date validity = Job.sdf.parse(teasession.getParameter("ValidityYear") + "-" + teasession.getParameter("ValidityMonth") + "-" + teasession.getParameter("ValidityDay"));
                String requirements = request.getParameter("requirements");
                String salaryid = request.getParameter("sltSalaryId");
                String reqdegid = request.getParameter("sltReqDegId");
                String name = request.getParameter("name")==null?subject:request.getParameter("name");
                String email = request.getParameter("email");
                String tel = request.getParameter("tel");
                String refcode =request.getParameter("txtRefCode");
                //
                Job job = new Job(teasession._nNode,teasession._nLanguage);
                if(job.isExists())
                {
                    job.set(company,jobtype,occid,validity,headcount,salaryid,locid,reqwyearid,reqdegid,requirements,name,email,tel,refcode);
                } else
                {
                    Job.create(teasession._nNode,teasession._nLanguage,company,jobtype,occid,validity,headcount,salaryid,locid,reqwyearid,reqdegid,requirements,name,email,tel,refcode);
                }
                node.setHidden(teasession.getParameter("save") != null || request.getParameter("Preview") != null);
                delete(node);
                if(request.getParameter("Preview") != null)
                {
                    response.sendRedirect(request.getContextPath() + "/jsp/type/job/cnoocjobpreviewedit.jsp?node=" + teasession._nNode);
                } else if(request.getParameter("GoBack") != null)
                {
                    response.sendRedirect("EditNode?node=" + teasession._nNode);
                } else
                {
                    if(nu == null)
                    {
                        nu = "/servlet/Node?node=" + teasession._nNode;
                    }
                    response.sendRedirect(nu);
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

}
