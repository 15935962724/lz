package tea.ui.node.type.news;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditNews extends TeaServlet
{
	public EditNews()
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
			Node node = Node.find(teasession._nNode);
			if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview() < 2)
			{
				response.sendError(403);
				return;
			}
			News news = News.find(teasession._nNode);
			if (request.getMethod().equals("GET"))
			{
				response.sendRedirect("/jsp/type/news/EditNews.jsp?" + request.getQueryString());

				// Form form = new Form("foEdit", "POST", "EditNews");
				// form.add(new HiddenField("Node", teasession._nNode));
				// Table table = new Table();
				// Row row = new Row(new Cell(new Anchor("Search?Type=27", "_blank", new Text(super.r.getString(teasession._nLanguage, "Reporter") + ":")), true));
				// row.add(new Cell(new TextField("Reporter", news.getReporter(teasession._nLanguage), 40, 40)));
				// table.add(row);
				// Row row1 = new Row(new Cell(new Anchor("Search?Type=22", "_blank", new Text(super.r.getString(teasession._nLanguage, "Press") + ":")), true));
				// row1.add(new Cell(new TextField("Press", news.getPress(teasession._nLanguage), 40, 40)));
				// table.add(row1);
				// Row row2 = new Row(new Cell(new Anchor("Search?Type=16", "_blank", new Text(super.r.getString(teasession._nLanguage, "Location") + ":")), true));
				// row2.add(new Cell(new TextField("Location", news.getLocation(teasession._nLanguage), 40, 40)));
				// table.add(row2);
				// Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "media") + ":"), true));
				// Cell cell = new Cell();
				// DropDown dropdown = new DropDown("dropdown");
				// dropdown.addOption("1", "\u65B0\u534E\u793E");
				// dropdown.addOption("2", "\u4EBA\u6C11\u65E5\u62A5");
				// dropdown.addOption("32", "\u5149\u660E\u65E5\u62A5");
				// cell.add(dropdown);
				// cell.add(new Break());
				// row3.add(cell);
				// table.add(row3);
				// Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "class") + ":"), true));
				// Cell cell1 = new Cell();
				// DropDown dropdown1 = new DropDown("class");
				// dropdown1.addOption("1", "\u5A92\u4F53");
				// dropdown1.addOption("2", "\u80A1\u7968");
				// dropdown1.addOption("3", "\u5DE5\u7A0B");
				// cell1.add(dropdown1);
				// cell1.add(new Break());
				// row4.add(cell1);
				// table.add(row4);
				// Row row5 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "IssueTime") + ":"), true));
				// row5.add(new Cell(new TimeSelection("Issue", news.getIssueTime())));
				// table.add(row5);
				// form.add(table);
				// form.add(new Go(teasession._nLanguage, 1));
				// PrintWriter printwriter = response.getWriter();
				// printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
				// printwriter.print(form);
				// printwriter.print(new Languages(teasession._nLanguage, request));
				// printwriter.close();
			} else
			{
				String s = request.getParameter("Reporter");
				String s1 = request.getParameter("Press");
				String s2 = request.getParameter("Location");
				java.util.Date date = TimeSelection.makeTime(request.getParameter("IssueYear"), request.getParameter("IssueMonth"), request.getParameter("IssueDay"), request.getParameter("IssueHour"), request.getParameter("IssueMinute"));
				news.set(date, teasession._nLanguage, s, s1, s2);
				if (request.getParameter("GoBack") != null)
				{
					response.sendRedirect("EditNode?node=" + teasession._nNode);
				} else if (request.getParameter("GoFinish") != null)
				{
					node.finished(teasession._nNode);
					response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
				}
			}
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("tea/ui/node/type/news/EditNews");
	}
}
