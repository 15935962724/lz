package tea.ui.node.type.account;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
public class EditTransfer extends TeaServlet
{
	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			tea.entity.node.Transfer transfer = new tea.entity.node.Transfer();
			// org.apache.jasper.runtime.JspRuntimeLibrary.introspect(transfer,
			// request);
			transfer.setDate(tea.htmlx.TimeSelection.makeTime(request.getParameter("datetime")));
			transfer.create();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		response.sendRedirect("/jsp/type/account/EditTransfer.jsp");
	}

	// Clean up resources
	public void destroy()
	{
	}
}
