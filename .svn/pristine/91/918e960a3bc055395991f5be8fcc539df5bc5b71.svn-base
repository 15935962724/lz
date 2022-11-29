package tea.ui.node.type.custom;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditCustom extends TeaServlet
{

	public EditCustom()
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
			if (!node.isCreator(teasession._rv) && AccessMember.find(teasession._nNode, teasession._rv._strV).getPurview() < 2)
			{
				response.sendError(403);
				return;
			}
			Custom custom = Custom.find(teasession._nNode);
			if (request.getMethod().equals("GET"))
			{
				Form form = new Form("foEdit", "POST", "EditCustom");
				form.add(new HiddenField("Node", teasession._nNode));
				Table table = new Table();
				String s2 = " ";
				Row row = new Row();
				Cell cell = new Cell();
				cell.add(new Text(r.getString(teasession._nLanguage, "Name") + "  "));
				cell.add(new TextField("cname", s2, 25, 255));
				row.add(cell);
				table.add(row);
				Row row1 = new Row();
				Cell cell1 = new Cell();
				cell1.add(new Text(r.getString(teasession._nLanguage, "Sex") + "  "));
				cell1.add(new TextField("sex", s2, 25, 255));
				row1.add(cell1);
				table.add(row1);
				Row row2 = new Row();
				Cell cell2 = new Cell();
				cell2.add(new Text(r.getString(teasession._nLanguage, "Adress") + "  "));
				cell2.add(new TextField("adress", s2, 25, 255));
				row2.add(cell2);
				table.add(row2);
				Row row3 = new Row();
				Cell cell3 = new Cell();
				cell3.add(new Text(r.getString(teasession._nLanguage, "Telephone") + "  "));
				cell3.add(new TextField("telephone", s2, 25, 255));
				row.add(cell3);
				table.add(row3);
				form.add(table);
				form.add(new Go(teasession._nLanguage, 1));
				PrintWriter printwriter = response.getWriter();
				printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
				printwriter.print(form);
				printwriter.print(new Languages(teasession._nLanguage, request));
				printwriter.close();
			} else
			{
				String s = request.getParameter("cname");
				String s1 = request.getParameter("sex");
				String s3 = request.getParameter("adress");
				String s4 = request.getParameter("telephone");
				custom.set(teasession._nLanguage, s, s1, s3, s4);
				if (request.getParameter("GoBack") != null)
				{
					response.sendRedirect("EditNode?node=" + teasession._nNode);
				} else if (request.getParameter("GoFinish") != null)
				{
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
		r.add("tea/ui/node/type/custom/EditCustom");
	}
}
