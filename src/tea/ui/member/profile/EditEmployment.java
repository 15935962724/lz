package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class EditEmployment extends HttpServlet
{
    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect(request.getContextPath() + "/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            int id = 0;
            if (teasession.getParameter("id") != null)
            {
                id = Integer.parseInt(teasession.getParameter("id"));
            }

            tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
            tea.entity.member.Employment employment = tea.entity.member.Employment.find(id);
            if (!node.isCreator(teasession._rv) || (id != 0 && employment.getNode() != teasession._nNode))
            {
                response.sendError(403);
                return;
            }

            employment.setOrgName(teasession.getParameter("tbOrgName"));
            String tbOrgInfo = null;//teasession.getParameter("tbOrgInfo");
//            if (tbOrgInfo.length() > 300)
//            {
//                tbOrgInfo = tbOrgInfo.substring(0, 300);
//            }
            employment.setOrgInfo(tbOrgInfo);
            employment.setWorkSite(teasession.getParameter("tbWorkSite"));
            employment.setDepartment(teasession.getParameter("tbDepartment"));
            employment.setPositionName(teasession.getParameter("tbPositionName"));
            employment.setStartDate(tea.htmlx.TimeSelection.makeTime(teasession.getParameter("ymStartDate:ymYear"), teasession.getParameter("ymStartDate:ymMonth"), "1", "0", "0"));
            employment.setEndDate(tea.htmlx.TimeSelection.makeTime(teasession.getParameter("ymEndDate:ymYear"), teasession.getParameter("ymEndDate:ymMonth"), "1", "0", "0"));
            String tbFunction = teasession.getParameter("tbFunction");
            if (tbFunction.length() > 2000)
            {
                tbFunction = tbFunction.substring(0, 2000);
            }
            employment.setFunction(tbFunction);
            employment.setReasonOfLeaving(teasession.getParameter("tbReasonOfLeaving"));
//            employment.setNode(teasession._nNode);

           int zzjllx= 0;
           if(teasession.getParameter("zzjllx")!=null && teasession.getParameter("zzjllx").length()>0)
                 zzjllx = Integer.parseInt(teasession.getParameter("zzjllx"));
          int zzdcyy= 0;
          if(request.getParameter("zzdcyy")!=null && request.getParameter("zzdcyy").length()>0)
               zzdcyy = Integer.parseInt(request.getParameter("zzdcyy"));
            employment.setBranc(teasession.getParameter("branc"));
            employment.setZzmr(teasession.getParameter("zzmr"));
            employment.setZzlxfs(teasession.getParameter("zzlxfs"));
            employment.setZzjllx(zzjllx);
            employment.setZzjrfs(teasession.getParameter("zzjrfs"));
            employment.setZzpcdw(request.getParameter("zzpcdw")); //派出单位
            employment.setZzpcyy(request.getParameter("zzpcyy")); //派出原因
            employment.setZzjrll("true".equals(request.getParameter("zzjrll"))); //兼职
            employment.setZzyglx(request.getParameter("zzyglx")); //用工类型
            employment.setZzdcyy(zzdcyy); //调出原因
            employment.setLanguage(teasession._nLanguage);

            employment.setNode(teasession._nNode);
            employment.set();

            String nexturl = request.getParameter("nexturl");

            //response.sendRedirect(request.getContextPath() + "/jsp/type/resume/EditEmployment.jsp?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(nexturl, "UTF-8"));
            response.sendRedirect(nexturl+"&nexturl=" + nexturl+"&node="+teasession._nNode);
            return;
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }

    }

    //Clean up resources
    public void destroy()
    {
    }
}
