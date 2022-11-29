package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;

public class EditBooks extends TeaServlet
{

	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		tea.ui.TeaSession teasession = null;
		teasession = new tea.ui.TeaSession(request);
		try
		{
			int unit = Integer.parseInt(teasession.getParameter("unit"));
			String bookname = teasession.getParameter("bookname");
			int booksort = 0;
			if (teasession.getParameter("booksort") != null)
				;
			booksort = Integer.parseInt(teasession.getParameter("booksort"));
			String author = teasession.getParameter("author");
			String number = teasession.getParameter("number");
			String concern = teasession.getParameter("concern");

			Date times = null;
			if (teasession.getParameter("times") != null && teasession.getParameter("times").length() > 0)
			{
				String str = teasession.getParameter("times");
				times = Books.sdf.parse(str);

			}

			String locus = teasession.getParameter("locus");
			int amount = 0;
			if (teasession.getParameter("amount") != null && teasession.getParameter("amount").length() > 0)
			{
				amount = Integer.parseInt(teasession.getParameter("amount"));
			}
			float price = 0;
			if (teasession.getParameter("price") != null && teasession.getParameter("price").length() > 0)
			{
				price = Float.parseFloat(teasession.getParameter("price"));
			}

			String content = teasession.getParameter("content");
			int bound = 0;
			if (teasession.getParameter("bound") != null && teasession.getParameter("bound").length() > 0)
			{
				bound = Integer.parseInt(teasession.getParameter("bound"));
			}
			String human = teasession.getParameter("human");
			String remark = teasession.getParameter("remark");
			int fettle = Integer.parseInt(teasession.getParameter("fettle"));
			int id = 0;
			if (teasession.getParameter("id") != null)
				id = Integer.parseInt(teasession.getParameter("id"));
			if (id > 0)
			{
				Books obj = Books.find(id);
				obj.set(unit, bookname, booksort, author, number, concern, times, locus, amount, price, content, bound, human, remark, fettle);
			} else
			{
				Books.create(unit, bookname, booksort, author, number, concern, times, locus, amount, price, content, bound, human, remark, teasession._strCommunity, teasession._rv, fettle);
			}
			response.sendRedirect("/jsp/admin/books/record.jsp?community="+teasession._strCommunity);
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
