package tea.entity.qcjs;

import java.io.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;

import tea.entity.node.*;
import tea.entity.photography.Photography;
import tea.entity.photography.PhotographyPoll;
import tea.htmlx.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.ui.member.profile.newcaller;
import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.RV;
import java.util.regex.*;

import tea.entity.admin.orthonline.NodePoints;
import tea.entity.integral.IntegralRecord;
import tea.entity.member.*;
import tea.entity.util.*;

import java.util.*;
import javax.imageio.*;

import java.awt.image.*;

import tea.entity.site.*;

public class EditQcReservation extends TeaServlet
{
	public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		try
		{

			TeaSession teasession = new TeaSession(request);
			
			String nexturl = teasession.getParameter("nexturl");
			String act = teasession.getParameter("act");

			
			if("EditQcReservation".equals(act))
			{
				 
				int rid =0;
				if(teasession.getParameter("rid")!=null && teasession.getParameter("rid").length()>0)
				{
					rid = Integer.parseInt(teasession.getParameter("rid"));
				}
				QcReservation robj = QcReservation.find(rid);
				
				String name = teasession.getParameter("name");
				String telephone = teasession.getParameter("telephone");
				String card = teasession.getParameter("card");
			
				int activity = 0;
				if(teasession.getParameter("activity")!=null && teasession.getParameter("activity").length()>0)
				{
					activity = Integer.parseInt(teasession.getParameter("activity"));
				}
				int manner = 0;
				if(teasession.getParameter("manner")!=null && teasession.getParameter("manner").length()>0)
				{
					manner = Integer.parseInt(teasession.getParameter("manner"));
				}
				
				String mannerlocation = teasession.getParameter("mannerlocation");
				 int forms = 0;
				if(teasession.getParameter("forms")!=null && teasession.getParameter("forms").length()>0)
				{
					 forms = Integer.parseInt(teasession.getParameter("forms"));
				}
				
				String notes = teasession.getParameter("notes");
				int mid =0;
				if(teasession.getParameter("mid")!=null && teasession.getParameter("mid").length()>0)
				{
					mid = Integer.parseInt(teasession.getParameter("mid"));
				}
				int forms3 =-1;
				if(teasession.getParameter("forms3")!=null && teasession.getParameter("forms3").length()>0)
				{
					forms3 = Integer.parseInt(teasession.getParameter("forms3"));
				}
				if(robj.isExists())
				{
					robj.set(name, telephone, card, activity, manner, mannerlocation, forms, notes, mid,forms3);
				}else {
					QcReservation.create(name, telephone, card, activity, manner, mannerlocation, forms, notes, new Date(), teasession._strCommunity, mid,forms3);
				} 
				
			}else if("delete".equals(act))
			{
				if(teasession._rv==null)
				{
				  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
				  return;
				}
				String value[] = request.getParameterValues("rid");
	            
	            if(value != null)
	            {
	            	String next_str ="删除成功";
	            	//boolean f = false;
	                for(int index = 0;index < value.length;index++)
	                {
	                    int i = Integer.parseInt(value[index]);
	                    QcReservation robj = QcReservation.find(i);
	                 	robj.delete();
	                }
	                java.io.PrintWriter out = response.getWriter();
					out.print("<script  language='javascript'>alert('" + next_str + "');window.location.href='" + nexturl + "&id="+teasession.getParameter("id")+"';</script> ");
					out.close();
					return;
	            }
			}
 
				response.sendRedirect(nexturl);
	

		} catch (Exception exception)
		{
			// response.sendError(400,"新闻添加错误,请检查您的网络是否正常");//exception.toString()
			// response.sendRedirect("/jsp/admin");
			response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您添加的会员出错了,请重新添加&nbsp;", "UTF-8"));
			System.out.println("EditQcMember类出错");
			exception.printStackTrace();
		}

	}
}