// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   PayAded.java

package tea.ui.node.aded;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Shipping;
import tea.entity.node.*;
import tea.html.*;
import tea.http.RequestHelper;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class PayAded extends TeaServlet
{

	public PayAded()
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
			int i = Integer.parseInt(request.getParameter("Aded"));
			Aded aded = Aded.find(i);
			if (aded.getNode() != teasession._nNode || !aded.isCreator(teasession._rv) || aded.getStatus() != 0)
			{
				response.sendError(403);
				return;
			}
			PrintWriter printwriter = response.getWriter();
			int j = aded.getAding();
			Ading ading = Ading.find(j);
			int k = ading.getCurrency();
			BigDecimal bigdecimal = ading.getCpm();
			int l = aded.getExpectedImpression();
			BigDecimal bigdecimal1 = bigdecimal.multiply(new BigDecimal(l / 1000));
			printwriter.print(RequestHelper.format(r.getString(teasession._nLanguage, "InfConfirmPay"), r.getString(teasession._nLanguage, Common.CURRENCY[k]) + bigdecimal1.toString()));
			Form form = new Form("foSelect", "GET", "/servlet/PayAded0");
			form.add(new HiddenField("Node", teasession._nNode));
			form.add(new HiddenField("Aded", i));
			form.add(new HiddenField("Currency", k));
			form.add(new HiddenField("Price", bigdecimal1));
			Shipping shipping;
			Node node = Node.find(teasession._nNode);
			for (Enumeration enumeration = Shipping.find(node.getCommunity(), node.getCreator()._strR, k, 16384); enumeration.hasMoreElements(); form.add(new Text(shipping.getName(teasession._nLanguage))))
			{
				int i1 = ((Integer) enumeration.nextElement()).intValue();
				shipping = Shipping.find(i1);
				form.add(new Radio("Shipping", Integer.toString(i1), true));
			}

			form.add(new Text(r.getString(teasession._nLanguage, "CouponCode") + ":"));
			form.add(new TextField("CouponCode"));
			form.add(new Button(r.getString(teasession._nLanguage, "Continue")));
			printwriter.print(form);
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
		r.add("tea/ui/node/aded/PayAded");
	}
}
