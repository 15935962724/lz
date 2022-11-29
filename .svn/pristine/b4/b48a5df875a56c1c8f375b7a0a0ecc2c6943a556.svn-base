

package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.member.Message;
import java.text.*;



public class EditCargenre extends TeaServlet
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
        	int caid=0;
        	if(teasession.getParameter("caid")!=null && teasession.getParameter("caid").length()>0)
        			caid = Integer.parseInt(teasession.getParameter("caid"));
        	String cargenrename = teasession.getParameter("cargenrename");
        	
        	if(caid>0)
        	{
        		Cargenre caobj = Cargenre.find(caid);
        		caobj.set(cargenrename);
        	}else
        	{
        		Cargenre.create(cargenrename, teasession._strCommunity,teasession._rv);
        	}
        	
        	  response.sendRedirect("/jsp/admin/vehicle/cargenre.jsp");
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

