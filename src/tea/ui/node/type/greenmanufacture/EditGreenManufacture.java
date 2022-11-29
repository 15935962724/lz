package tea.ui.node.type.greenmanufacture;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import java.sql.SQLException;
import java.text.ParseException;
import tea.entity.node.*;

public class EditGreenManufacture extends TeaServlet
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
			TeaSession teasession = new TeaSession(request);
			if (teasession._rv == null)
			{
				teasession._rv = RV.ANONYMITY;
			}
			Node node = Node.find(teasession._nNode);
			String subject = teasession.getParameter("Subject");
			String text = teasession.getParameter("Text");
			if (teasession.getParameter("NewNode") != null)
			{
				int sequence = Node.getMaxSequence(teasession._nNode) + 10;
				long options = node.getOptions();
				int options1 = node.getOptions1();
				int defautllangauge = node.getDefaultLanguage();
				Category obj = Category.find(teasession._nNode);
				teasession._nNode = Node.create(teasession._nNode, sequence, node.getCommunity(), teasession._rv, obj.getCategory(),  (options1 & 2) != 0, options, options1, defautllangauge, null, null,  new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, null,"", text, null, "", 0, null, "", "", "", "", null,null);
			} else
			{
				node.set(teasession._nLanguage, subject, text);
			}
			GreenManufacture obj = GreenManufacture.find(teasession._nNode, teasession._nLanguage);
			String photo = null;
			byte by[] = teasession.getBytesParameter("brand");
			if (by != null)
			{
				photo = request.getContextPath() + super.write(node.getCommunity(), by, ".gif");
			} else
			{
				photo = teasession.getParameter("brandpath");
			}

			obj.set(teasession.getParameter("faren"), teasession.getParameter("companyadd"), teasession.getParameter("postalcode"), teasession.getParameter("quality"), teasession.getParameter("ep"), teasession.getParameter("medal"), teasession.getParameter("attestation"), teasession.getParameter("company"), teasession.getParameter("content"), teasession.getParameter("linkman"), teasession.getParameter("phone"), teasession.getParameter("fax"), teasession.getParameter("email"), teasession
					.getParameter("remark"), photo);
			node.finished(teasession._nNode);
			response.sendRedirect("GreenManufacture?node=" + teasession._nNode);
		} catch (IOException ex)
		{
			ex.printStackTrace();
		} catch (SQLException ex)
		{
			ex.printStackTrace();
		}
	}

	// Clean up resources
	public void destroy()
	{
	}
}
