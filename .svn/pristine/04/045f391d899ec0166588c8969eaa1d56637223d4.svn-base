package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

import tea.ui.TeaServlet;
import tea.entity.admin.*;

public class EditLeave extends TeaServlet
{

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);
        try
        {

            String cause = teasession.getParameter("cause");

            int cl = 0; //Integer.parseInt(teasession.getParameter("cl"));
            int un = 0; //Integer.parseInt(teasession.getParameter("un"));

            Date time_k = null,time_j = null;
            String name = teasession.getParameter("name");

            ///String a[] = names.split(":");
            //String name = a[0];
            int classs = 0; //Integer.parseInt(a[1]);
            int unit = 0; //Integer.parseInt(a[2]);

          
          
            if(request.getParameter("time_kYear")!=null && request.getParameter("time_kYear").length()>0)
            {
            	time_k = Leavec.sdf2.parse(request.getParameter("time_kYear") + "-" + request.getParameter("time_kMonth") + "-" + request.getParameter("time_kDay")+" "+request.getParameter("time_kHour")+":"+request.getParameter("time_kMinute"));
            }
 
            
          
            if(request.getParameter("time_jYear")!=null && request.getParameter("time_jYear").length()>0)
            {
            	time_j = Leavec.sdf2.parse(request.getParameter("time_jYear") + "-" + request.getParameter("time_jMonth") + "-" + request.getParameter("time_jDay")+" "+request.getParameter("time_jHour")+":"+request.getParameter("time_jMinute"));
            }
             
            
            int leavetype = 0;
            if(request.getParameter("leavetype") != null && request.getParameter("leavetype").length() > 0)
            {
                leavetype = Integer.parseInt(request.getParameter("leavetype"));
            }
            tea.entity.member.Profile obj = tea.entity.member.Profile.find(teasession._rv.toString());

            Leavec.create(cause,time_k,time_j,classs,unit,name,teasession._strCommunity,teasession._rv,un,cl,leavetype,0);

            response.sendRedirect("/jsp/admin/manage/leave.jsp");

        } catch(Exception ex)
        {
            ex.printStackTrace();
        }

    }

    // Clean up resources
    public void destroy()
    {
    }
}
