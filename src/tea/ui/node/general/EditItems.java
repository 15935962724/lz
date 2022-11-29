package tea.ui.node.general;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Node;
import tea.html.Anchor;
import tea.html.Text;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditItems extends TeaServlet
{

	public EditItems()
	{
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		r.add("tea/ui/node/general/EditItems");
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
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
			String s = request.getParameter("NextUrl");
			PrintWriter printwriter = response.getWriter();
			String as[] = request.getParameterValues("Items");
			if (as != null)
			{
				for (int i = 0; i < as.length; i++)
				{
					String s1 = as[i];
					int j = Integer.parseInt(s1);
					Node node = Node.find(j);
					if (node.isCreator(teasession._rv))
					{
						int k = 0;
						int l = 0;
						int i1 = 0;
						boolean flag = false;
						try
						{
							k = Integer.parseInt(request.getParameter("LastDays" + s1));
							flag = true;
						} catch (Exception _ex)
						{
						}
						try
						{
							l = Integer.parseInt(request.getParameter("LastHours" + s1));
							flag = true;
						} catch (Exception _ex)
						{
						}
						try
						{
							i1 = Integer.parseInt(request.getParameter("LastMinutes" + s1));
							flag = true;
						} catch (Exception _ex)
						{
						}
						if (flag)
						{
							long l1 = System.currentTimeMillis();
							Date date = new Date(l1);
							node.set(date, new Date(l1 + (long) k * 24L * 60L * 60L * 1000L + (long) (l * 60 * 60 * 1000) + (long) i1 * 60L * 1000L));
						}
					}
				}

			}
			printwriter.print(RequestHelper.format(r.getString(teasession._nLanguage, "InfItemsEdited"), new Anchor(s, new Text(r.getString(teasession._nLanguage, "ClickHere")))));
			printwriter.close();
		} catch (Exception exception)
		{
			response.sendError(400, exception.toString());
			exception.printStackTrace();
		}
	}
}
