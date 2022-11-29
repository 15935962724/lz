package tea.ui.admin.sales;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.util.*;
import tea.entity.admin.sales.*;
import tea.ui.TeaSession;

public class EditSalesLinkman extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet
{

	public EditSalesLinkman()
	{
		super();
	}

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);
			if (teasession._rv == null)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			String nexturl = java.net.URLEncoder.encode(teasession.getParameter("nexturl"), "UTF-8");
			String act = teasession.getParameter("act");
			if ("editsaleslinkman".equals(act))
			{
				int saleslinkman = Integer.parseInt(request.getParameter("saleslinkman"));
				String name = teasession.getParameter("name");
				String tel = teasession.getParameter("tel");
				String mobile = teasession.getParameter("mobile");
				String email = teasession.getParameter("email");
				int client = Integer.parseInt(teasession.getParameter("client"));// 客户
				boolean clienttype = "true".equals(teasession.getParameter("clienttype"));
				int supervisor = Integer.parseInt(teasession.getParameter("supervisor"));// 直属上司
				String job = teasession.getParameter("job");
				// /////////邮寄地址
				String country = teasession.getParameter("country");
				String postcode = teasession.getParameter("postcode");
				String state = teasession.getParameter("state");
				String city = teasession.getParameter("city");
				String street = teasession.getParameter("street");
				// /////////其他地址
				String country2 = teasession.getParameter("country2");
				String postcode2 = teasession.getParameter("postcode2");
				String state2 = teasession.getParameter("state2");
				String city2 = teasession.getParameter("city2");
				String street2 = teasession.getParameter("street2");

				String fax = teasession.getParameter("fax");
				int origin = Integer.parseInt(teasession.getParameter("origin"));
				String hometel = teasession.getParameter("hometel");
				Date birth = null;
				try
				{
					birth = SalesLinkman.sdf.parse(teasession.getParameter("birth"));
				} catch (Exception ex)
				{
				}
				String othertel = teasession.getParameter("othertel");
				String unit = teasession.getParameter("unit");
				String assistant = teasession.getParameter("assistant");
				String assistanttel = teasession.getParameter("assistanttel");

				String content = teasession.getParameter("content");
				if (saleslinkman < 1)
				{
					SalesLinkman.create(teasession._strCommunity, teasession._rv.toString(), name, tel, mobile, email, client, clienttype, supervisor, job, country, postcode, state, city, street,
							country2, postcode2, state2, city2, street2, fax, origin, hometel, birth, othertel, unit, assistant, assistanttel, content);
				} else
				{
					SalesLinkman obj = SalesLinkman.find(saleslinkman);
					obj.set(name, tel, mobile, email, client, clienttype, supervisor, job, country, postcode, state, city, street, country2, postcode2, state2, city2, street2, fax, origin, hometel,
							birth, othertel, unit, assistant, assistanttel, content);
				}
				if (teasession.getParameter("newnext") != null)
				{
					response.sendRedirect("/jsp/admin/sales/EditSalesLinkman.jsp?saleslinkman=0&community=" + teasession._strCommunity + "&nexturl=" + nexturl);
					return;
				}
			} else if ("deletesaleslinkman".equals(act))
			{
				int saleslinkman = Integer.parseInt(request.getParameter("saleslinkman"));
				SalesLinkman obj = SalesLinkman.find(saleslinkman);
				obj.delete();
			}
			response.sendRedirect("/jsp/info/Succeed.jsp?community=" + teasession._strCommunity + "&nexturl=" + nexturl);
		} catch (Exception ex)
		{
			ex.printStackTrace();
			throw new ServletException(ex.getMessage());
		}
	}

}