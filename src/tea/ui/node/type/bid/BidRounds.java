package tea.ui.node.type.bid;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Bid;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class BidRounds extends TeaServlet
{

	public BidRounds()
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
			Table table = new Table();
			Date date;
			for (Enumeration enumeration = Bid.findStopTime(teasession._nNode); enumeration.hasMoreElements(); table.add(new Row(new Cell(new Anchor("BidHistory?node=" + teasession._nNode + "&StopTime=" + date.getTime(), new Text((new SimpleDateFormat("MM.dd HH:mm")).format(date)))))))
				date = (Date) enumeration.nextElement();

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
		r.add("tea/ui/node/type/bid/BidRounds");
	}
}
