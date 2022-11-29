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

public class EditQcMember extends TeaServlet
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
			if(teasession._rv==null)
			{
			  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
			  return;
			}
			String nexturl = teasession.getParameter("nexturl");
			String act = teasession.getParameter("act");

			
			if("EditMember".equals(act))
			{
				
				int mid =0;
				if(teasession.getParameter("mid")!=null && teasession.getParameter("mid").length()>0)
				{
					mid = Integer.parseInt(teasession.getParameter("mid"));
				}
				QcMember qobj = QcMember.find(mid);
				String name = teasession.getParameter("name");
				int sex = Integer.parseInt(teasession.getParameter("sex"));
				String card = teasession.getParameter("card");
				String telephone = teasession.getParameter("telephone");
				String mobile = teasession.getParameter("mobile");
				String address = teasession.getParameter("address");
				Date registratime = null;
				if(teasession.getParameter("registratime")!=null && teasession.getParameter("registratime").length()>0)
				{
					registratime = Entity.sdf.parse(teasession.getParameter("registratime"));
				}
				String archives = teasession.getParameter("archives");
				
				Date outtime = null;
				if(teasession.getParameter("outtime")!=null && teasession.getParameter("outtime").length()>0)
				{
					outtime = Entity.sdf.parse(teasession.getParameter("outtime"));
				}
				String source = teasession.getParameter("source");
				String drivers = teasession.getParameter("drivers");
				if(qobj.isExists())
				{
					qobj.set(name, sex, card, telephone, mobile, address, registratime, archives, outtime, source, teasession._strCommunity, teasession._rv.toString(),drivers);
				}else {
					QcMember.create(name, sex, card, telephone, mobile, address, registratime, archives, outtime, source, teasession._strCommunity, new Date(), teasession._rv.toString(),drivers);
				} 
				
			}else if("delete".equals(act))
			{
				String value[] = request.getParameterValues("mid");
	            
	            if(value != null)
	            {
	            	String next_str ="删除成功";
	            	//boolean f = false;
	                for(int index = 0;index < value.length;index++)
	                {
	                    int i = Integer.parseInt(value[index]);
	                    QcMember mobj = QcMember.find(i);
	                 	mobj.delete();
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