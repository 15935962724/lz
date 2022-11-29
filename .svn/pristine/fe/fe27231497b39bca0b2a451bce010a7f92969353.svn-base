

package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.member.Message;
import java.text.*;


// bian ji wei hu!维护, 保持, 生活费用, 扶养
public class EditMaintenance extends TeaServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);
        try
        {
        	int vehicle = 0;
        	int maid=0;
        	if(teasession.getParameter("maid")!=null && teasession.getParameter("maid").length()>0)
        		maid = Integer.parseInt(teasession.getParameter("maid"));
        	if(teasession.getParameter("vehicle")!=null && teasession.getParameter("vehicle").length()>0)
        		vehicle = Integer.parseInt(teasession.getParameter("vehicle"));
        	Date times=null;
        	if(teasession.getParameter("times")!=null && teasession.getParameter("times").length()>0)
        		times = Maintenance.sdf.parse(teasession.getParameter("times"));
        	int vtype =0;
        	if(teasession.getParameter("vtype")!=null && teasession.getParameter("vtype").length()>0)
        		vtype = Integer.parseInt(teasession.getParameter("vtype"));
        	String cause = teasession.getParameter("cause");
        	String man = teasession.getParameter("man");
        	float charge =0;
        	if(teasession.getParameter("charge")!=null && teasession.getParameter("charge").length()>0)
        		charge = Float.parseFloat(teasession.getParameter("charge"));
        	String remark = teasession.getParameter("remark");
        	if(maid>0)
        	{
        		Maintenance maobj = Maintenance.find(maid);
        		maobj.set(vehicle, times, vtype, cause, man, charge, remark);
        	}else
        	{
        		Maintenance.create(vehicle, times, vtype, cause, man, charge, remark, teasession._strCommunity, teasession._rv);
        	}
        	  response.sendRedirect("/jsp/admin/vehicle/query1.jsp");
        }catch (Exception ex)
        {
            ex.printStackTrace();

        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}

