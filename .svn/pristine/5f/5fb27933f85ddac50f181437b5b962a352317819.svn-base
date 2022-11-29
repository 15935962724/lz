package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;


public class EditRankclass extends TeaServlet
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
	        	if(teasession.getParameter("rankclass")!=null){
	        	
		        	String rankclass = teasession.getParameter("rankclass");
		        	String enrol1 = teasession.getParameter("enrol1");
		        	String duty1= teasession.getParameter("duty1");
		        	String enrol2 = teasession.getParameter("enrol2");
		        	String duty2 = teasession.getParameter("duty2");
		        	String enrol3 =  teasession.getParameter("enrol3");
		        	String duty3 = teasession.getParameter("duty3");
		        	String enrol4 = teasession.getParameter("enrol4");
		        	String duty4 = teasession.getParameter("duty4");
		        	String enrol5 = teasession.getParameter("enrol5");
		        	String duty5  = teasession.getParameter("duty5");
		        	String enrol6 = teasession.getParameter("enrol6");
		        	String duty6 = teasession.getParameter("duty6");
	        	
		        
		        	int  id = Integer.parseInt(teasession.getParameter("id"));
		        	
		        	if(id>0)
		        	{
		        		RankClass obj =  RankClass.find(id); 
		        		obj.set(rankclass, enrol1, duty1, enrol2, duty2, enrol3, duty3, enrol4, duty4, enrol5, duty5, enrol6, duty6, teasession._strCommunity, teasession._rv);
		        	}else
		        	{
		        		RankClass.create(rankclass, enrol1, duty1, enrol2, duty2, enrol3, duty3, enrol4, duty4, enrol5, duty5, enrol6, duty6, teasession._strCommunity, teasession._rv);
		        	}
		        	response.sendRedirect("/jsp/admin/manage/rankclass.jsp"); 
	        	}
	        	
	        	if(teasession.getParameter("ranid")!=null)
	        	{
	        		int ranid = Integer.parseInt(teasession.getParameter("ranid"));
	        		
	        		String time2 = teasession.getParameter("time2");
	        		int  unit = Integer.parseInt(teasession.getParameter("unit"));
	        		int arrclass = Integer.parseInt(teasession.getParameter("arrclass"));
	        		String b1 = teasession.getParameter("b1");
		        	String b2= teasession.getParameter("b2");
		        	String b3 = teasession.getParameter("b3");
		        	String b4 = teasession.getParameter("b4");
		        	String b5 =  teasession.getParameter("b5");
		        	String b6 = teasession.getParameter("b6");
		        	DutyClass dobj = DutyClass.find(ranid);
		        	dobj.set(b1, b2, b3, b4, b5, b6);
		        	response.sendRedirect("/jsp/admin/manage/inquire2.jsp?time2="+time2+"&unit="+unit+"&arrclass="+arrclass+"  ");
		        	return;
	        	}
	        	
	        	
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
