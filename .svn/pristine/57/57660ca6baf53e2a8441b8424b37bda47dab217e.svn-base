package tea.ui.node.type.bargain;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class BargainHistory extends TeaServlet
{

	public BargainHistory()
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
			if (!node.isCreator(teasession._rv) && AccessMember.find(teasession._nNode, teasession._rv._strV).getPurview()<2)
			{
				response.sendError(403);
				return;
			}
			Date date = new Date(Long.parseLong(request.getParameter("StopTime")));
			Table table = new Table();
			table.setTitle(r.getString(teasession._nLanguage, "MemberId") + "\n" + r.getString(teasession._nLanguage, "Time") + "\n" + r.getString(teasession._nLanguage, "Price") + "\n" + r.getString(teasession._nLanguage, "Quantity") + "\n");
			Row row;
			for (Enumeration enumeration = Bargain.find(teasession._nNode, date); enumeration.hasMoreElements(); table.add(row))
			{
				BargainGroup bargaingroup = (BargainGroup) enumeration.nextElement();
				row = new Row();
				row.add(new Cell(hrefGlance(teasession._rv)));
				row.add(new Cell(new Text((new SimpleDateFormat("MM.dd HH:mm")).format(bargaingroup._lastTime))));
				row.add(new Cell(new Text(r.getString(teasession._nLanguage, Common.CURRENCY[bargaingroup._nCurrency]) + bargaingroup._bdLastPrice.toString())));
				row.add(new Cell(new Text(Integer.toString(bargaingroup._nMaxQuantity))));
				row.add(new Cell(new Anchor("BargainDetail?node=" + teasession._nNode + "&StopTime=" + date.getTime() + "&RMember=" + bargaingroup._rv._strR + "&VMember=" + bargaingroup._rv._strV, r.getCommandImg(teasession._nLanguage, "Detail"))));
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
		r.add("tea/ui/node/type/bargain/BargainHistory");
	}
}
