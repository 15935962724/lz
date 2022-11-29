package tea.ui.member.profile;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
public class EditSummary extends HttpServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
			tea.entity.member.Summary summary = tea.entity.member.Summary.find(teasession._rv.toString(), teasession._nLanguage);
			//org.apache.jasper.runtime.JspRuntimeLibrary.introspect(summary, request);
			java.util.Enumeration e= request.getParameterNames();
			while(e.hasMoreElements())
			{
			String name=(String)e.nextElement();
			System.out.println(name+":"+request.getParameter("name"));
			}

			boolean bool;
			if (teasession.getParameter("Has_Abroad").equalsIgnoreCase("True"))
			{
				bool = true;
			} else
			{
				bool = false;
			}
			summary.setHasAbroad(bool);
			int ExpectWorkKind = 0;
			if (teasession.getParameter("ExpectWorkKind:0") != null)
			{
				ExpectWorkKind |= 2;
			}
			if (teasession.getParameter("ExpectWorkKind:1") != null)
			{
				ExpectWorkKind |= 4;
			}
			if (teasession.getParameter("ExpectWorkKind:2") != null)
			{
				ExpectWorkKind |= 8;
			}
			if (teasession.getParameter("ExpectWorkKind:3") != null)
			{
				ExpectWorkKind |= 16;
			}
			summary.setExpectWorkKind(ExpectWorkKind);
			summary.set();
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
