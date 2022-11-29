package tea.ui.member.profile;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.member.*;
import tea.html.*;
import tea.htmlx.Languages;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.*;
import java.util.*;

public class EditAddress extends TeaServlet
{
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
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
			if (!teasession._rv.isReal())
			{
				response.sendError(403);
				return;
			}

			if ("GET".equals(request.getMethod()))
			{
				response.sendRedirect("/jsp/user/EditAddress.jsp");
			} else
			{
				String community = teasession.getParameter("community");
				String email = teasession.getParameter("Email");
				Date birth = null;
				try
				{
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
					birth = sdf.parse(teasession.getParameter("BirthYear") + "-" + teasession.getParameter("BirthMonth") + "-" + teasession.getParameter("BirthDay"));
				} catch (Exception e)
				{
					e.printStackTrace();
				}
				String firstname = teasession.getParameter("FirstName");
				String lastname = teasession.getParameter("LastName");
				String organization = request.getParameter("Organization");
				String address = request.getParameter("Address");
				String city = request.getParameter("City");
				String state = request.getParameter("State");
				String zip = request.getParameter("Zip");
				String country = request.getParameter("Country");
				String telephone = request.getParameter("Telephone");
				String fax = request.getParameter("Fax");
				// int j = Integer.parseInt(request.getParameter("Age"));
				String webpage = request.getParameter("WebPage");
				int type = request.getParameter("AddressTPublic") != null ? 1 : 0;
				if (firstname == null || firstname.length() == 0)
				{
					outText(teasession, response, r.getString(teasession._nLanguage, "InvalidFirstName"));
					return;
				}
				/*
				 * if (s1.length() == 0) { outText(teasession,response, r.getString(teasession._nLanguage, "InvalidLastName")); return; }
				 */
				if (!RequestHelper.isEmail(email))
				{
					outText(teasession, response, r.getString(teasession._nLanguage, "InvalidEmailAddress"));
					return;
				}
				Profile obj;
				if (request.getParameter("Member") != null)
				{
					obj = Profile.find(request.getParameter("Member"));
				} else
				{
					obj = Profile.find(teasession._rv._strR);
				}

				obj.set(email, birth, type, obj.getMobile(), obj.isSex(), teasession._nLanguage, firstname, lastname, organization, address, city, state, zip, country, telephone, fax, webpage);

				String nexturl = request.getParameter("nexturl");
				if (nexturl == null)
				{
					nexturl = "/jsp/info/Succeed.jsp?community=" + community;
				}
				response.sendRedirect(nexturl);
			}
		} catch (Exception ex)
		{
			response.sendError(400, ex.toString());
			ex.printStackTrace();
		}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		// r.add("tea/ui/util/SignUp1").add("tea/ui/member/profile/EditAddress");
	}
}
