package tea.ui.admin.sales;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.admin.sales.*;


import tea.entity.admin.sales.Saleschance;
 
/**
 * Servlet implementation class for Servlet: SaleschanceServlet
 *
 */
 public class SaleschanceServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public SaleschanceServlet() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);  
        String submit = request.getParameter("submit");
        
        try{
        String bschanceholder =teasession._rv.toString();
		String bschancename = request.getParameter("bschancename");
		int clientname=0;
		if(teasession.getParameter("client")!=null && teasession.getParameter("client").length()>0)
		  clientname= Integer.parseInt(request.getParameter("client"));
		boolean clienttype = "true".equals(teasession.getParameter("clienttype"));
		
		int type= 0;
		if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
			type = Integer.parseInt(teasession.getParameter("type"));
		Date dates=null;
		if(teasession.getParameter("dates")!=null && teasession.getParameter("dates").length()>0)
			dates = Saleschance.sdf.parse(teasession.getParameter("dates"));
		int moment= 0;
		if(teasession.getParameter("moment")!=null && teasession.getParameter("moment").length()>0)
			moment = Integer.parseInt(teasession.getParameter("moment"));
		String chance= request.getParameter("chance");
		String money= request.getParameter("money");
		int latencyclient= 0;
		if(teasession.getParameter("latencyclient")!=null && teasession.getParameter("latencyclient").length()>0)
			latencyclient = Integer.parseInt(teasession.getParameter("latencyclient"));
		String nexts= request.getParameter("nexts");
		String remark= request.getParameter("remark");
		Date timelook = null;
		if(teasession.getParameter("timelook")!=null && teasession.getParameter("timelook").length()>0)
			timelook = Saleschance.sdf.parse(teasession.getParameter("timelook"));
		//查看时间
		Date timeupdate=null;//修改时间
		if(teasession.getParameter("timeupdate")!=null && teasession.getParameter("timeupdate").length()>0)
			timeupdate = Saleschance.sdf.parse(teasession.getParameter("timeupdate"));
		
		String bsupdatename =request.getParameter("bsupdatename");//修改人]
		Date timecreate = null;	
		if(teasession.getParameter("timecreate")!=null && teasession.getParameter("timecreate").length()>0)
			timecreate = Saleschance.sdf.parse(teasession.getParameter("timecreate"));
		int laid = 0;
		if(teasession.getParameter("laid")!=null && teasession.getParameter("laid").length()>0)
			laid = Integer.parseInt(teasession.getParameter("laid"));

        if(submit.toString().equals("保存"))
        {				
     			if(laid>0)
     	    	{
     				
     				Saleschance laobj=Saleschance.find(laid); 	
     	    		laobj.setUpdate(bschanceholder,bschancename,clientname,clienttype,type,dates,moment,chance,money,latencyclient,nexts,remark,teasession._strCommunity,teasession._rv,bsupdatename,timelook,timeupdate);
     	    		response.sendRedirect("/jsp/admin/sales/saleschanceinfo.jsp?laid="+laid);
     	    	}
     			else
     	    	{
     				Saleschance.create(bschanceholder,bschancename, clientname,clienttype,type,dates,moment,chance,money,latencyclient,nexts,remark, teasession._strCommunity,teasession._rv,bsupdatename,timelook,timeupdate,timecreate);
     	    		int bid=0;
         			java.util.Enumeration lame =Saleschance.findByCommunity(teasession._strCommunity,"");
         			while(lame.hasMoreElements())
         			{
         					bid = ((Integer)lame.nextElement()).intValue();
         			}
         			 response.sendRedirect("/jsp/admin/sales/saleschanceinfo.jsp?laid="+bid);
     	    	}
     			
     	  }
        else if(submit.toString().equals("保存并新建"))
        {
        	  
        			Saleschance laobj=Saleschance.find(laid); 	
     			if(laid>0)
     	    	{
     				
     	    		laobj.setUpdate(bschanceholder,bschancename,clientname,clienttype,type,dates,moment,chance,money,latencyclient,nexts, remark,teasession._strCommunity,teasession._rv,bsupdatename,timelook,timeupdate);
     	    		response.sendRedirect("/jsp/admin/sales/saleschance.jsp?laid="+0);
     	    	}
     			else
     	    	{
     	    		laobj.create(bschanceholder,bschancename, clientname,clienttype,type,dates,moment,chance,money,latencyclient,nexts,remark, teasession._strCommunity,teasession._rv,bsupdatename,timelook,timeupdate,timecreate);
     	    		int bid=0;
         			java.util.Enumeration lame =Saleschance.findByCommunity(teasession._strCommunity,"");
         			while(lame.hasMoreElements())
         			{
         					bid = ((Integer)lame.nextElement()).intValue();
         			}
         			 response.sendRedirect("/jsp/admin/sales/saleschance.jsp?laid="+0);
     	    	} 	 
        }
    
        else if(submit.toString().equals("删除"))
        	{
        		Saleschance laobj=Saleschance.find(laid); 		
        		laobj.delete();
        		
        		response.sendRedirect("/jsp/admin/sales/Saleschanceview.jsp");
        	}
	}
        catch (Exception ex)
        {
		ex.printStackTrace();
		throw new ServletException(ex.getMessage());
        }
	}
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}   	  	    
}