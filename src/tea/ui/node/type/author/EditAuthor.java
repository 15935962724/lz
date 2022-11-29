package tea.ui.node.type.author;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditAuthor extends TeaServlet
{

	public EditAuthor()
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
			String s = request.getRequestURI();
			int i = 0;
			if (s.endsWith("BookTranslator"))
			{
				i = 1;
			}
			String s1 = request.getParameter("Author");
			boolean flag = s1 == null;
			int j = teasession._nNode;
			if (!flag)
			{
				j = Author.find(Integer.parseInt(s1)).getNode();
			}
			Node node = Node.find(j);
			if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview()<2)
			{
				response.sendError(403);
				return;
			}
			if (request.getMethod().equals("GET"))
			{

				StringBuilder sb = new StringBuilder("?");
				boolean bool = false;
				java.util.Enumeration enumeration = request.getParameterNames();
				while (enumeration.hasMoreElements())
				{
					String str = enumeration.nextElement().toString();
					if (str.equalsIgnoreCase("URI"))
					{
						bool = true;
						sb.append(str + "=" + s + "&");
					} else
					{
						sb.append(str + "=" + request.getParameter(str) + "&");
					}
				}
				if (!bool)
				{
					sb.append("URI=" + s);
				}
				response.sendRedirect("/jsp/type/author/EditAuthor.jsp" + sb.toString());

				// String s2 = "";
				// int k = 0;
				// if (!flag)
				// {
				// Author author = Author.find(Integer.parseInt(s1));
				// s2 = author.getName(teasession._nLanguage);
				// k = author.getSequence();
				// }
				// Form form = new Form("foNew", "POST", s);
				// form.setOnSubmit("return(submitText(this.Name,'" + super.r.getString(teasession._nLanguage, "InvalidName") + "')" + "&&submitInteger(this.Sequence,'" + super.r.getString(teasession._nLanguage, "InvalidSequence") + "')" + ");");
				// form.add(new HiddenField("Node", teasession._nNode));
				// Table table = new Table();
				// Row row = new Row(new Cell(new Anchor("Search?Type=" + 26, "_blank", new Text(super.r.getString(teasession._nLanguage, "Author") + ":")), true));
				// row.add(new Cell(new TextField("Name", s2, 40, 40)));
				// table.add(row);
				// Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Sequence") + ":"), true));
				// row1.add(new Cell(new TextField("Sequence", Integer.toString(k))));
				// table.add(row1);
				// form.add(table);
				// form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
				// PrintWriter printwriter = response.getWriter();
				// printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
				// printwriter.print(form);
				// printwriter.print(new Languages(teasession._nLanguage, request));
				//				printwriter.close();
			} else
			{
				String s3 = request.getParameter("Name");
				if (s3.length() == 0)
				{
					outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidName"));
					return;
				}
				int l = 0;
				try
				{
					l = Integer.parseInt(request.getParameter("Sequence"));
				} catch (Exception _ex)
				{
					outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidSequence"));
					return;
				}
				node.finished(teasession._nNode);
				if (flag)
				{
					Author.create(teasession._nNode, i, l, teasession._nLanguage, s3);
				} else
				{
					Author author1 = Author.find(Integer.parseInt(s1));
					author1.set(l, teasession._nLanguage, s3);
				}
				response.sendRedirect("Node?node=" + teasession._nNode);
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
		super.r.add("tea/ui/node/type/author/EditAuthor");
	}
}
