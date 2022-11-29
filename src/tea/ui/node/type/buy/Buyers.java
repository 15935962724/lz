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
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Buyers extends TeaServlet
{

	public Buyers()
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
			String s = request.getParameter("Order");
			if (s == null)
				s = "lasttime";
			Table table = new Table();
			table.setTitle(new Anchor("Buyers?node=" + teasession._nNode + "&Order=rmember", new Text(r.getString(teasession._nLanguage, "MemberId"))) + "\n" + new Anchor("Buyers?node=" + teasession._nNode + "&Order=lasttime", new Text(r.getString(teasession._nLanguage, "Time"))) + "\n" + new Anchor("Buyers?node=" + teasession._nNode + "&Order=sumquantity", new Text(r.getString(teasession._nLanguage, "Quantity"))) + "\n");
			Row row;
			for (Enumeration enumeration = Buy.find(teasession._nNode, s); enumeration.hasMoreElements(); table.add(row))
			{
				BuyGroup buygroup = (BuyGroup) enumeration.nextElement();
				row = new Row();
				row.add(new Cell(hrefGlance(buygroup._rv)));
				row.add(new Cell(new Text((new SimpleDateFormat("MM.dd HH:mm")).format(buygroup._lastTime))));
				row.add(new Cell(new Text(Integer.toString(buygroup._nSumQuantity))));
				row.add(new Cell(new Anchor("BuyerDetail?node=" + teasession._nNode + "&RMember=" + buygroup._rv._strR + "&VMember=" + buygroup._rv._strV, r.getCommandImg(teasession._nLanguage, "Detail"))));
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
		r.add("tea/ui/node/type/buy/Buyers");
	}
}
