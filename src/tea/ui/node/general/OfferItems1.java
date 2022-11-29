package tea.ui.node.general;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.Anchor;
import tea.html.Text;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class OfferItems1 extends TeaServlet
{

	public OfferItems1()
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
			int i = 0;
			String as[] = request.getParameterValues("Items");
			if (as != null)
			{
				for (int j = 0; j < as.length; j++)
				{
					int k = Integer.parseInt(as[j]);
					int l = Integer.parseInt(request.getParameter("Currency" + k));
					BigDecimal bigdecimal = new BigDecimal(request.getParameter("Price" + k));
					int i1 = Integer.parseInt(request.getParameter("Quantity" + k));
					Node node = Node.find(k);
					i = node.getType();
					java.util.Date date = node.getStopTime();
					if (i == 4)
					{
						int community = 0; // /////////
						Buy.create(node.getCommunity(), teasession._rv, k, community, l,bigdecimal, i1); // 购买节点,当前会员,货币种类,价格,数量,产品节点
					} else if (i == 5)
					{
						Bid.create(k, teasession._rv, date, l, bigdecimal, i1, teasession._nLanguage, null, null);
					} else if (i == 6)
					{
						Bargain.create(k, teasession._rv, 0, date, l, bigdecimal, i1, teasession._nLanguage, null, null);
					}
				}

			}
			PrintWriter printwriter = response.getWriter(); // beginOut(response, teasession);
			if (i == 4)
			{
				printwriter.print(RequestHelper.format(r.getString(teasession._nLanguage, "InfViewBuys"), (new Anchor("ShoppingCarts", new Text(r.getString(teasession._nLanguage, "ClickHere"))))
						.toString()));
			} else if (i == 5)
			{
				printwriter.print(RequestHelper.format(r.getString(teasession._nLanguage, "InfViewBids"), (new Anchor("Bids", new Text(r.getString(teasession._nLanguage, "ClickHere")))).toString()));
			} else if (i == 5)
			{
				printwriter.print(RequestHelper.format(r.getString(teasession._nLanguage, "InfViewBargains"), (new Anchor("Bargains", new Text(r.getString(teasession._nLanguage, "ClickHere"))))
						.toString()));
			}
			printwriter.print(RequestHelper.format(r.getString(teasession._nLanguage, "InfContinue"), (new Anchor(request.getParameter("NextUrl"), new Text(r.getString(teasession._nLanguage,
					"ClickHere")))).toString()));
			printwriter.close(); // printwriter.close();
		} catch (Exception ex)
		{
			response.sendError(400, ex.toString());
			ex.printStackTrace();
		}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		r.add("tea/ui/node/general/OfferItems1");
	}
}
