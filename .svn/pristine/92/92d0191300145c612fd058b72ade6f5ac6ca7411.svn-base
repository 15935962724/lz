package tea.ui.node.type.bid;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Bid;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class BidHistory extends TeaServlet
{

	public BidHistory()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			TeaSession teasession = new TeaSession(request);
			Date date = new Date(Long.parseLong(request.getParameter("StopTime")));
			Table table = new Table();
			Row row;
			for (Enumeration enumeration = Bid.find(teasession._nNode, date); enumeration.hasMoreElements(); table.add(row))
			{
				int i = ((Integer) enumeration.nextElement()).intValue();
				Bid bid = Bid.find(i);
				row = new Row(new Cell(new Text((new SimpleDateFormat("MM.dd HH:mm")).format(bid.getTime()))));
				row.add(new Cell(new Text(hrefGlance(bid.getMember()))));
				row.add(new Cell(new Text(r.getString(teasession._nLanguage, Common.CURRENCY[bid.getCurrency()]) + bid.getPrice())));
				row.add(new Cell(new Text(Integer.toString(bid.getQuantity()))));
				row.add(new Cell(new Text(bid.getRemark(teasession._nLanguage))));
				if (bid.getVoiceFlag())
					row.add(new Cell(new Anchor("BidVoice?node=" + teasession._nNode + "&Bid=" + i, r.getCommandImg(teasession._nLanguage, "Play"))));
			}

			PrintWriter printwriter = response.getWriter();
			printwriter.print(Node.find(teasession._nNode).getAncestor(teasession._nLanguage, "Path"));
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
		r.add("tea/ui/node/type/bid/BidHistory");
	}
}
