package tea.ui.node.type.resume;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.ui.TeaSession;
import java.sql.SQLException;

public class ApplyTableFilter extends HttpServlet implements Filter
{
	private FilterConfig filterConfig;

	// Handle the passed-in FilterConfig
	public void init(FilterConfig filterConfig) throws ServletException
	{
		this.filterConfig = filterConfig;
	}

	// Process the request/response pair
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
	{
		try
		{
			HttpServletRequest srequest = ((HttpServletRequest) request);
			HttpServletResponse sresponse = ((HttpServletResponse) response);

			TeaSession teasession = new TeaSession(srequest);
			if (teasession._rv == null)
			{
				sresponse.sendError(403);
				return;
			}
			sresponse.setContentType("application/x-msdownload;charset=GB2312"); // ms-word
			String url = srequest.getRequestURI();
			try
			{
				url = tea.entity.node.ApplyTable.find(Integer.parseInt(url.replaceAll("/tea/app/at", "").replaceAll(".doc", ""))).getName();
			} catch (NumberFormatException ex)
			{
			} catch (SQLException ex)
			{
			}
			sresponse.setHeader("Content-disposition", "attachment; filename=" + url);
			filterChain.doFilter(request, sresponse);
		} catch (ServletException sx)
		{
			filterConfig.getServletContext().log(sx.getMessage());
		} catch (IOException iox)
		{
			filterConfig.getServletContext().log(iox.getMessage());
		} catch (Exception iox)
		{
			filterConfig.getServletContext().log(iox.getMessage());
		}

	}

	// Clean up resources
	public void destroy()
	{
	}
}
