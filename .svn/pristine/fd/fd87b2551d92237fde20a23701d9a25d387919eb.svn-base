// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   BuyerDetail.java

package tea.ui.node.type.buy;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Buy;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class BuyerDetail extends TeaServlet
{

	public BuyerDetail()
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
			tea.entity.node.AccessMember obj_am = tea.entity.node.AccessMember.find(node._nNode, teasession._rv.toString());
			if (!node.isCreator(teasession._rv) && obj_am.getPurview()<2)
			{
				response.sendError(403);
				return;
			}
			String s = request.getParameter("RMember");
			String s1 = request.getParameter("VMember");
			Table table = new Table();
			Row row;
			for (Enumeration enumeration = Buy.find(teasession._nNode, new RV(s, s1)); enumeration.hasMoreElements(); table.add(row))
			{
				int i = ((Integer) enumeration.nextElement()).intValue();
				Buy buy = Buy.find(i);
				row = new Row(new Cell(new Text((new SimpleDateFormat("MM.dd HH:mm")).format(buy.getTime()))));
				row.add(new Cell(new Text(r.getString(teasession._nLanguage, Common.CURRENCY[buy.getCurrency()]) + buy.getPrice())));
				row.add(new Cell(new Text(Integer.toString(buy.getQuantity()))));
			}

			PrintWriter printwriter = response.getWriter();
			printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
			printwriter.print(new Anchor("Buyers?node=" + teasession._nNode, r.getCommandImg(teasession._nLanguage, "Buyers")));
			printwriter.print(table);
			printwriter.print(new Languages(teasession._nLanguage, request));
			printwriter.close();
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		r.add("tea/ui/node/type/buy/BuyerDetail");
	}
}
