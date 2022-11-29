package tea.ui.admin.express;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import tea.ui.*;
import tea.entity.admin.express.*;
import java.math.*;

public class EditExpress extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet
{
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");

		TeaSession teasession = new TeaSession(request);
		if (teasession._rv == null)
		{
			response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
			return;
		}
		try
		{
			String act = request.getParameter("act");
			String nexturl = request.getParameter("nexturl");
			if ("editexpresspricezjs".equals(act))
			{
				int expresspricezjs = Integer.parseInt(request.getParameter("expresspricezjs"));
				float wfrom = Float.parseFloat(request.getParameter("wfrom"));
				float wto = Float.parseFloat(request.getParameter("wto"));
				BigDecimal province = new BigDecimal(request.getParameter("province"));
				BigDecimal capital = new BigDecimal(request.getParameter("capital"));
				BigDecimal interim = new BigDecimal(request.getParameter("interim"));
				if (expresspricezjs < 1)
				{
					ExpressPricezjs.create(teasession._strCommunity, wfrom, wto, province, capital, interim);
				} else
				{
					ExpressPricezjs obj = ExpressPricezjs.find(expresspricezjs);
					obj.set(wfrom, wto, province, capital, interim);
				}
			} else if ("deleteexpresspricezjs".equals(act))
			{
				int expresspricezjs = Integer.parseInt(request.getParameter("expresspricezjs"));
				ExpressPricezjs obj = ExpressPricezjs.find(expresspricezjs);
				obj.delete();
			}
			response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + java.net.URLEncoder.encode(nexturl, "UTF-8"));
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}
}