package tea.ui.member.messagefolder;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.MessageFolder;
import tea.html.*;
import tea.htmlx.MessageUI;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditMessageFolder extends TeaServlet
{

	public EditMessageFolder()
	{
	}

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
			if (!teasession._rv.isSupport())
			{
				response.sendError(403);
				return;
			}

			if (request.getMethod().equals("GET"))
			{
				response.sendRedirect("/jsp/message/EditMessageFolder.jsp?" + request.getQueryString());
				return;
			}
			int messagefolder = Integer.parseInt(request.getParameter("messagefolder"));
			String name = request.getParameter("name");
			int type = Integer.parseInt(request.getParameter("nType"));
			int options = 0;
			if (request.getParameter("OpenSubscriberList") != null)
			{
				options |= 1;
			}
			if (!RequestHelper.isIdentifier(name))
			{
				outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidMessageFolder"));
				return;
			}
			if (messagefolder == 0)
			{
				MessageFolder.create(teasession._rv._strR, type, options, teasession._nLanguage, name);
			} else
			{
				MessageFolder obj = MessageFolder.find(messagefolder);
				obj.set(type, options, teasession._nLanguage, name);
			}
			response.sendRedirect("ManageMessageFolders");
			return;
		} catch (Exception exception)
		{
			response.sendError(400, exception.toString());
			exception.printStackTrace();
			return;
		}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("tea/ui/member/contact/EditCGroup").add("tea/ui/member/message/MessageFolders").add("tea/ui/member/message/Messages").add("tea/ui/member/email/EmailBoxs").add("tea/ui/member/contact/CGroups").add("tea/ui/member/messagefolder/ManageMessageFolders");
	}
}
