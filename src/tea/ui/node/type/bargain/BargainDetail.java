// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   BargainDetail.java

package tea.ui.node.type.bargain;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Bargain;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class BargainDetail extends TeaServlet
{

	public BargainDetail()
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
			Date date = new Date(Long.parseLong(request.getParameter("StopTime")));
			RV rv = new RV(request.getParameter("RMember"), request.getParameter("VMember"));
			Table table = new Table();
			Row row;
			for (Enumeration enumeration = Bargain.find(teasession._nNode, date, rv); enumeration.hasMoreElements(); table.add(row))
			{
				int i = ((Integer) enumeration.nextElement()).intValue();
				Bargain bargain = Bargain.find(i);
				int j = bargain.getType();
				row = new Row(new Cell(new Text(r.getString(teasession._nLanguage, j != 0 ? "CounterBargain" : "Bargain"))));
				row.add(new Cell(new Text((new SimpleDateFormat("MM.dd HH.mm")).format(bargain.getTime()))));
				row.add(new Cell(new Text(r.getString(teasession._nLanguage, Common.CURRENCY[bargain.getCurrency()]) + bargain.getPrice())));
				row.add(new Cell(new Text(Integer.toString(bargain.getQuantity()))));
				row.add(new Cell(new Text(bargain.getText(teasession._nLanguage))));
				if (bargain.getVoiceFlag())
					row.add(new Cell(new Anchor("BargainVoice?node=" + teasession._nNode + "&Bargain=" + i, r.getCommandImg(teasession._nLanguage, "Play"))));
				Date date1 = new Date(System.currentTimeMillis());
				if (bargain.getStatus() == 0)
				{
					Cell cell = new Cell();
					if (j == 1 && rv.equals(teasession._rv) && date.after(date1))
						cell.add(new Anchor("DealBargain?node=" + teasession._nNode + "&Bargain=" + i, new Text(r.getString(teasession._nLanguage, "Deal"))));
					if (j == 0 && node.isCreator(teasession._rv) && date.after(date1))
					{
						cell.add(new Anchor("CounterOfferBargain?node=" + teasession._nNode + "&Bargain=" + i, new Text(r.getString(teasession._nLanguage, "CounterBargain"))));
						cell.add(new Anchor("CounterDealBargain?node=" + teasession._nNode + "&Bargain=" + i, new Text(r.getString(teasession._nLanguage, "Deal"))));
					}
					row.add(cell);
				}
			}

			PrintWriter printwriter = response.getWriter();
			printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
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
		r.add("tea/ui/node/type/bargain/BargainDetail");
	}
}
