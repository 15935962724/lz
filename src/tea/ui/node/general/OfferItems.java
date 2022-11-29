// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   OfferItems.java

package tea.ui.node.general;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.html.*;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class OfferItems extends TeaServlet
{

	public OfferItems()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			TeaSession teasession = new TeaSession(request);
			if (teasession._rv == null)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			String s = request.getParameter("NextUrl");
			Form form = new Form("foOffer", "GET", "OfferItems1");
			form.add(new HiddenField("NextUrl", s));
			boolean flag = false;
			String as[] = request.getParameterValues("Items");
			if (as != null)
			{
				Table table = new Table();
				table.setTitle(r.getString(teasession._nLanguage, "Subject") + "\n" + r.getString(teasession._nLanguage, "SKU") + "\n" + r.getString(teasession._nLanguage, "SerialNumber") + "\n" + r.getString(teasession._nLanguage, "Quality") + "\n" + r.getString(teasession._nLanguage, "Price") + "\n" + r.getString(teasession._nLanguage, "Quantity") + "\n");
				for (int i = 0; i < as.length; i++)
				{
					String s1 = as[i];
					try
					{
						int j = Integer.parseInt(request.getParameter("Currency" + s1));
						new BigDecimal(request.getParameter("Price" + s1));
						Integer.parseInt(request.getParameter("Quantity" + s1));
						r.getString(teasession._nLanguage, Common.CURRENCY[j]);
					} catch (Exception _ex)
					{
					}
				}

				form.add(table);
			}
			if (flag)
			{
				form.add(new Button(r.getString(teasession._nLanguage, "Continue")));
				PrintWriter printwriter = response.getWriter();
				printwriter.print(form);
				printwriter.close();
			} else
			{
				response.sendRedirect(s);
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
		r.add("tea/ui/node/general/OfferItems");
	}
}
