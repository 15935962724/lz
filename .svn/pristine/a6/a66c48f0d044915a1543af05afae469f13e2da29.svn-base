// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   OfferBid.java

package tea.ui.node.type.bid;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.MessageFormat;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.FileInput;
import tea.htmlx.Languages;
import tea.http.MultipartRequest;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class OfferBid extends TeaServlet
{

	public OfferBid()
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
			Node node = Node.find(teasession._nNode);
			if ((node.getOptions1() & 0x1) != 0 && Bid.isBided(teasession._nNode, teasession._rv))
			{
				outText(teasession, response, r.getString(teasession._nLanguage, "InfAlreadyBided"));
				return;
			}
			int i = Integer.parseInt(teasession.getParameter("Currency"));
			String s = teasession.getParameter("Price");
			BigDecimal bigdecimal = null;
			try
			{
				bigdecimal = new BigDecimal(s);
			} catch (Exception _ex)
			{
			}
			if (bigdecimal == null)
			{
				outText(teasession, response, r.getString(teasession._nLanguage, "Price") + r.getString(teasession._nLanguage, "AlertFloat"));
				return;
			}
			int j = 0;
			try
			{
				j = Integer.parseInt(teasession.getParameter("Quantity"));
			} catch (Exception _ex)
			{
			}
			if (j == 0)
			{
				outText(teasession, response, r.getString(teasession._nLanguage, "Quantity") + r.getString(teasession._nLanguage, "AlertInteger"));
				return;
			}
			Commodity commodity = Commodity.find(teasession._nNode);
			if (commodity.isValidQuantity(j))
			{
				outText(teasession, response, r.getString(teasession._nLanguage, "InvalidQuantity"));
				return;
			}
			if (request.getMethod().equals("GET"))
			{
				PrintWriter printwriter = response.getWriter();
				Object as[] = { Integer.toString(j), r.getString(teasession._nLanguage, Common.CURRENCY[i]) + bigdecimal };
				printwriter.print(MessageFormat.format(r.getString(teasession._nLanguage, "InfBidConfirm"), as));
				Form form = new Form("foOffer", "POST", "OfferBid1");
				form.setMultiPart(true);
				form.add(new HiddenField("Node", Integer.toString(teasession._nNode)));
				form.add(new HiddenField("Currency", Integer.toString(i)));
				form.add(new HiddenField("Price", bigdecimal.toString()));
				form.add(new HiddenField("Quantity", Integer.toString(j)));
				Table table = new Table();
				table.add(new FileInput(teasession._nLanguage, "Voice"));
				Row row = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Remark") + ":"), true));
				row.add(new Cell(new TextArea("Remark", "", 8, 40)));
				table.add(row);
				form.add(table);
				form.add(new Button(r.getString(teasession._nLanguage, "Bid")));
				printwriter.print(form);
				printwriter.print(new Languages(teasession._nLanguage, request));
				printwriter.close();
			} else
			{
				String s1 = teasession.getParameter("Remark");
				byte abyte0[] = teasession.getBytesParameter("Voice");
				Bid.create(teasession._nNode, teasession._rv, node.getStopTime(), i, bigdecimal, j, teasession._nLanguage, s1, abyte0);
				response.sendRedirect("Bid?node=" + teasession._nNode);
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
		r.add("tea/ui/node/type/bid/OfferBid");
	}
}
