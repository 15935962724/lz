package tea.ui.admin.orthonline;

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
import tea.entity.node.*;
import tea.entity.admin.orthonline.*;

/*
 * 2009-08-20 添加
 * 张金舒
 * 医院添加
 *
 *
 *
 *
*/
public class EditHospital extends TeaServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		TeaSession teasession = new TeaSession(request);
		if(teasession._rv == null)
		{
			response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
			return;
		}
		String act = teasession.getParameter("act");
		String community = teasession.getParameter("community");
		String nexturl = teasession.getParameter("nexturl");
		int hoid = 0;
		if(teasession.getParameter("hoid") != null && teasession.getParameter("hoid").length() > 0)
		{
			hoid = Integer.parseInt(teasession.getParameter("hoid"));
		}

		try
		{
			Hospital hobj = Hospital.find(hoid);
			if("EditHospital".equals(act))
			{
				String honame = teasession.getParameter("honame");//医院名称
				String provincial = teasession.getParameter("provincial");//所在省份
				String city = teasession.getParameter("city");//所在市区
				String grade = teasession.getParameter("grade");//医院级别
				String hotype = teasession.getParameter("hotype");//医院性质
				String telephone = teasession.getParameter("telephone");//医院电话
				String email = teasession.getParameter("email");//电子邮箱
				String zip = teasession.getParameter("zip");//邮政编码
				String weburl = teasession.getParameter("weburl");//医院网址
				String address = teasession.getParameter("address");//医院地址
				String introduce = teasession.getParameter("introduce");//医院介绍

				if(hoid>0)
				{
					hobj.set( honame, provincial, city, grade, hotype, null, null, null, null, null,
                     null, address, zip, telephone, email, weburl, null, introduce,  null, null, 0);
				}
				else
				{
					Hospital.create(honame, provincial, city, grade, hotype, telephone, email, zip, weburl, address, introduce);
				}

			}else if("delete".equals(act))
			{
				hobj.delete();
			}


			response.sendRedirect(nexturl + "&community=" + community);
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
