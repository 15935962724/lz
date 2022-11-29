package tea.ui.node.adword;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditAdwordClick extends TeaServlet
{
	public EditAdwordClick()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			int adword = Integer.parseInt(request.getParameter("adword"));
			String referer = request.getHeader("referer");
			Adword obj = Adword.find(adword);
			if (referer != null && referer.startsWith("http://"+request.getServerName()))
			{
				AdwordClick.create(adword, request.getRemoteAddr());
				obj.setClick();
			}
			response.sendRedirect(obj.getAdurl());
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		// super.r.add("tea/ui/node/ading/EditAding");
	}
}