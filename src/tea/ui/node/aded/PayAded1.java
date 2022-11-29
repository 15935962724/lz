package tea.ui.node.aded;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.html.*;
import tea.http.MultipartRequest;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class PayAded1 extends TeaServlet
{

	public PayAded1()
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
			int j = aded.getAding();
			Ading.find(j);
			Node node = Node.find(teasession._nNode);
			tea.entity.RV rv = node.getCreator();
			int k = Integer.parseInt(request.getParameter("Currency"));
			BigDecimal bigdecimal = new BigDecimal(request.getParameter("Price"));
			int l = Integer.parseInt(request.getParameter("Shipping"));
			int i1 = Shipping.PAYMETHOD_OFFLINE;
			String s = null;
			if (l != 0)
			{
				Shipping shipping = Shipping.find(l);
				i1 = shipping.getPayMethod();
				s = shipping.getParameters();
			}
			int j1 = Integer.parseInt(teasession.getParameter("Coupon"));
			Coupon.find(j1);
			BigDecimal bigdecimal1 = null;
			try
			{
				bigdecimal1 = new BigDecimal(teasession.getParameter("Discount"));
			} catch (Exception _ex)
			{
			}
			if (bigdecimal1 == null)
			{
				outText(response, teasession._nLanguage, super.r.getString(teasession._nLanguage, "InvalidDiscount"));
				return;
			}
			String s1 = null;
			String s2 = null;
			String s3 = null;
			String s4 = null;
			String s5 = null;
			String s6 = null;
			String s7 = null;
			String s8 = null;
			String s9 = null;
			String s10 = null;
			String s11 = null;
			boolean flag = false;
			if (k == 0 && i1 == Shipping.PAYMETHOD_ITRANSACT)
			{
				String s12 = request.getParameter("signature");
				if (s12 == null || !s12.startsWith("-----BEGIN PGP SIGNED MESSAGE-----"))
				{
					return;
				}
				flag = true;
				s1 = request.getParameter("email");
				s2 = request.getParameter("first_name");
				s3 = request.getParameter("last_name");
				s4 = "";
				s5 = request.getParameter("address");
				s6 = request.getParameter("city");
				s7 = request.getParameter("state");
				s8 = request.getParameter("zip");
				s9 = request.getParameter("country");
				s10 = request.getParameter("phone");
				s11 = "";
			} else
			{
				s1 = request.getParameter("bEmail");
				s2 = request.getParameter("bFirstName");
				s3 = request.getParameter("bLastName");
				s4 = request.getParameter("bOrganization");
				s5 = request.getParameter("bAddress");
				s6 = request.getParameter("bCity");
				s7 = request.getParameter("bState");
				s8 = request.getParameter("bZip");
				s9 = request.getParameter("bCountry");
				s10 = request.getParameter("bTelephone");
				s11 = request.getParameter("bFax");
			}
			PrintWriter printwriter = response.getWriter();
			int k1 = 0;// Trade.createByAded(rv, teasession._rv, i, bigdecimal, flag, teasession._nLanguage, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, k, l, j1, bigdecimal1, teasession._nLanguage, null, null);
			if (k1 != 0)
			{
				String s13 = RequestHelper.format(super.r.getString(teasession._nLanguage, "InfViewOrder"), (new Anchor("http://" + request.getServerName() + "/servlet/Trade?Trade=" + k1, super.r.getString(teasession._nLanguage, "ClickHere"))).toString());
				/*
				 * Message.create(rv, null, teasession._rv, null, null, null, 8, 8, 4, 0, 2, teasession._nLanguage, RequestHelper.format(super.r.getString(teasession._nLanguage, "InfAdedNotification"), node.getSubject(teasession._nLanguage)), "<HTML>" + s13 + RequestHelper.format(super.r.getString(teasession._nLanguage, "InfViewNode"), (new Anchor("http://" + request.getServerName() + "/servlet/Adeds?node=" + teasession._nNode, new Text(super.r.getString(teasession._nLanguage,
				 * "ClickHere")))).toString()) + "</HTML>", null, null, null, null); Message.create(teasession._rv, null, rv, null, null, null, 8, 8, 4, 0, 2, teasession._nLanguage, RequestHelper.format(super.r.getString(teasession._nLanguage, "InfAdedRequest"), node.getSubject(teasession._nLanguage)), "<HTML>" + s13 + RequestHelper.format(super.r.getString(teasession._nLanguage, "InfHandleRequest"), (new Anchor("http://" + request.getServerName() + "/servlet/AdRequests?node=" +
				 * teasession._nNode, new Text(super.r.getString(teasession._nLanguage, "ClickHere")))).toString()) + "</HTML>", null, null, null, null);
				 */
				printwriter.print(s13);
			} else if (k == 1 && i1 == Shipping.PAYMETHOD_CYBERBJ)
			{
				int l1 = s.indexOf(' ');
				if (l1 == -1)
				{
					printwriter.print(super.r.getString(teasession._nLanguage, "InfVendorShippingParameters"));
				} else
				{
					Form form = new Form("foCyberBJ", "POST", "http://paymentweb.cyberbj.com.cn/prs/spmode.main");
					form.setTarget("_blank");
					String s14 = s.substring(0, l1);
					String s15 = s.substring(l1 + 1);
					String s16 = "0";
					String s17 = (new SimpleDateFormat("yyyyMMdd")).format(new Date(System.currentTimeMillis()));
					String s18 = bigdecimal.add(bigdecimal1).toString();
					String s19 = s3 + s2;
					String s20 = s17 + "-" + s14 + "-" + k1;
					String s21 = RequestHelper.hmac_md5("0" + s17 + s18 + s19 + s20 + s14, s15);
					form.add(new Button(super.r.getString(teasession._nLanguage, "PayInCyberBJ")));
					form.add(new HiddenField("v_action", "\312\327\266\274\265\347\327\323\311\314\263\307\315\370\311\317\260\262\310\253\326\247\270\266\306\275\314\250"));
					form.add(new HiddenField("v_mid", s14));
					form.add(new HiddenField("v_oid", s20));
					form.add(new HiddenField("v_rcvname", s19));
					form.add(new HiddenField("v_vrcvaddr", s9 + " " + s7 + " " + s6 + " " + s5));
					form.add(new HiddenField("v_rcvtel", s10));
					form.add(new HiddenField("v_rcvpost", s8));
					form.add(new HiddenField("v_amount", s18));
					form.add(new HiddenField("v_ymd", s17));
					form.add(new HiddenField("v_orderstatus", "1"));
					form.add(new HiddenField("v_ordername", s3 + s2));
					form.add(new HiddenField("v_moneytype", s16));
					form.add(new HiddenField("v_md5info", s21));
					printwriter.print(form);
				}
			} else
			{
				printwriter.print(RequestHelper.format(super.r.getString(teasession._nLanguage, "InfContinue"), (new Anchor("Node?node=" + teasession._nNode, new Text(super.r.getString(teasession._nLanguage, "ClickHere")))).toString()));
			}
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
		super.r.add("tea/ui/node/aded/PayAded1");
	}
}
