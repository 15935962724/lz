// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   CounterOfferBargain.java

package tea.ui.node.type.bargain;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.node.AccessMember;
import tea.entity.node.Bargain;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.FileInput;
import tea.htmlx.Languages;
import tea.http.MultipartRequest;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class CounterOfferBargain extends TeaServlet
{

	public CounterOfferBargain()
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
			if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview() > 1)
			{
				response.sendError(403);
				return;
			}
			int i = Integer.parseInt(teasession.getParameter("Bargain"));
			Bargain bargain = Bargain.find(i);
			if (request.getMethod().equals("GET"))
			{
				String s = r.getString(teasession._nLanguage, Common.CURRENCY[bargain.getCurrency()]);
				Form form = new Form("foOffer", "POST", "CounterOfferBargain");
				form.setMultiPart(true);
				form.setOnSubmit("return(submitInteger(this.Price,'" + r.getString(teasession._nLanguage, "InvalidPrice") + "')" + ");");
				form.add(new HiddenField("Node", teasession._nNode));
				form.add(new HiddenField("Bargain", i));
				Table table = new Table();
				Row row = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Price") + ":"), true));
				row.add(new Cell(new Text(s + new TextField("Price", "", 4))));
				table.add(row);
				Row row1 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Quantity") + ":"), true));
				row1.add(new Cell(new Text(Integer.toString(bargain.getQuantity()))));
				table.add(row1);
				table.add(new FileInput(teasession._nLanguage, "Voice"));
				Row row2 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Remark") + ":"), true));
				row2.add(new Cell(new TextArea("Remark", "", 8, 60)));
				table.add(row2);
				form.add(table);
				form.add(new Button(r.getString(teasession._nLanguage, "CounterBargain")));
				PrintWriter out = response.getWriter();
				out.print(form);
				out.print(new Languages(teasession._nLanguage, request));
				out.close();
			} else
			{
				BigDecimal bigdecimal = null;
				try
				{
					bigdecimal = new BigDecimal(teasession.getParameter("Price"));
				} catch (Exception _ex)
				{
				}
				String s1 = teasession.getParameter("Remark");
				byte abyte0[] = teasession.getBytesParameter("Voice");
				if (bigdecimal == null)
				{
					outText(teasession, response, r.getString(teasession._nLanguage, "InvalidPrice"));
					return;
				}
				Bargain.create(teasession._nNode, bargain.getMember(), 1, node.getStopTime(), bargain.getCurrency(), bigdecimal, bargain.getQuantity(), teasession._nLanguage, s1, abyte0);
				response.sendRedirect("Bargain?node=" + teasession._nNode);
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
		r.add("tea/ui/node/type/bargain/CounterOfferBargain");
	}
}
