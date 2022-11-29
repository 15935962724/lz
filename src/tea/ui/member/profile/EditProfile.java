package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;

public class EditProfile extends TeaServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			TeaSession teasession = new TeaSession(request);
			if (teasession._rv == null)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			String act = teasession.getParameter("act");
			String nexturl = teasession.getParameter("nexturl");
			if ("setphoto".equals(act))
			{
				Profile p = Profile.find(teasession._rv._strV);
				byte by[] = teasession.getBytesParameter("photo");
				if (by != null)
				{
					String path = write(teasession._strCommunity, by, ".gif");
					p.setPhotopath("http://" + request.getServerName() + ":" + request.getServerPort() + path, teasession._nLanguage);
				}
			}
			response.sendRedirect(nexturl);
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}

	// Clean up resources
	public void destroy()
	{
	}
}
