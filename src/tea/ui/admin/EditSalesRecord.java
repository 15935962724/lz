package tea.ui.admin;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.erp.*;
import javax.servlet.http.HttpSession;
import tea.entity.member.*;
import tea.entity.admin.*;

public class EditSalesRecord extends TeaServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
		HttpSession session = request.getSession();
		String act = teasession.getParameter("act");
		String nexturl = teasession.getParameter("nexturl");
		int srid = 0;
		if(teasession.getParameter("srid")!=null && teasession.getParameter("srid").length()>0)
		{
			srid = Integer.parseInt(teasession.getParameter("srid"));
		}


		try
		{
		   SalesRecord srobj = SalesRecord.find(srid);
			if("EditSalesRecord".equals(act))
			{
				int goods = Integer.parseInt(teasession.getParameter("goods"));
				int workproject= Integer.parseInt(teasession.getParameter("workproject"));
				Date buytime = null;
				if(teasession.getParameter("buytime")!=null && teasession.getParameter("buytime").length()>0)
				{
					 buytime =  SalesRecord.sdf.parse(teasession.getParameter("buytime"));
				}
				int squantity = Integer.parseInt(teasession.getParameter("squantity"));
				if(srid>0)
				{
					srobj.set(goods,workproject,buytime,squantity);
				}else
				{
					SalesRecord.create(goods,workproject,buytime,squantity,teasession._strCommunity,teasession._rv.toString());
				}

			} else if("delete".equals(act))
			{
				srobj.delete();
			}
			response.sendRedirect(nexturl);
			return;

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
