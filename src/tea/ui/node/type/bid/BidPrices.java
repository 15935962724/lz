package tea.ui.node.type.bid;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class BidPrices extends TeaServlet
{

	public BidPrices()
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
			if (request.getMethod().equals("GET"))
			{
				response.sendRedirect("/jsp/type/bid/BidPrices.jsp?" + request.getQueryString());

				// Table table = new
				// Table(super.r.getString(teasession._nLanguage, "BidPrices"));
				// table.setTitle(super.r.getString(teasession._nLanguage,
				// "Currency") + "\n" + super.r.getString(teasession._nLanguage,
				// "BidPSupply") + "\n" +
				// super.r.getString(teasession._nLanguage, "BidPList") + "\n" +
				// super.r.getString(teasession._nLanguage, "BidPAsk") + "\n" +
				// super.r.getString(teasession._nLanguage, "BidPReserve") +
				// "\n" + super.r.getString(teasession._nLanguage,
				// "BidPIncrement"));
				// Row row;
				// for(Enumeration enumeration =
				// BidPrice.find(teasession._nNode);
				// enumeration.hasMoreElements(); table.add(row))
				// {
				// int i = ((Integer)enumeration.nextElement()).intValue();
				// BidPrice bidprice = BidPrice.find(teasession._nNode, i);
				// row = new Row(new Cell(new
				// Text(super.r.getString(teasession._nLanguage,
				// Common.CURRENCY[i]))));
				// row.add(new Cell(new Text(bidprice.getSupply().toString())));
				// row.add(new Cell(new Text(bidprice.getList().toString())));
				// row.add(new Cell(new Text(bidprice.getAsk().toString())));
				// row.add(new Cell(new
				// Text(bidprice.getReserve().toString())));
				// row.add(new Cell(new
				// Text(bidprice.getIncrement().toString())));
				// row.add(new Cell(new Anchor("DeleteBidPrice?node=" +
				// teasession._nNode + "&Currency=" + i,
				// super.r.getCommandImg(teasession._nLanguage, "Delete"),
				// "return(confirm('" + super.r.getString(teasession._nLanguage,
				// "ConfirmDelete") + "'));")));
				// row.add(new Cell(new Anchor("EditBidPrice?node=" +
				// teasession._nNode + "&Currency=" + i,
				// super.r.getCommandImg(teasession._nLanguage, "Edit"))));
				// }
				//
				// PrintWriter printwriter = response.getWriter();
				// printwriter.print(node.getAncestor(teasession._nLanguage,
				// "Path"));
				// printwriter.print(table);
				// printwriter.print(new Anchor("EditBidPrice?node=" +
				// teasession._nNode,
				// super.r.getCommandImg(teasession._nLanguage, "New")));
				// Form form = new Form("foEdit", "POST", "BidPrices");
				// form.add(new HiddenField("Node",
				// Integer.toString(teasession._nNode)));
				// form.add(new Go(teasession._nLanguage, 1));
				// printwriter.print(form);
				// printwriter.print(new Languages(teasession._nLanguage,
				// request));
				// printwriter.close();
			} else if (request.getParameter("GoBack") != null)
				response.sendRedirect("EditBid?node=" + teasession._nNode);
			else if (request.getParameter("GoFinish") != null)
				response.sendRedirect("Bid?node=" + teasession._nNode + "&edit=ON");
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("tea/ui/node/type/bid/BidPrices");
	}
}
