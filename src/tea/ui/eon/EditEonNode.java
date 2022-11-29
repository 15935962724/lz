package tea.ui.eon;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.math.*;
import tea.ui.*;
import java.sql.SQLException;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.entity.eon.*;
import java.net.URLEncoder;

public class EditEonNode extends TeaServlet
{
	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		TeaSession teasession = new TeaSession(request);

		String act = teasession.getParameter("act");
		String nexturl = teasession.getParameter("nexturl");
		try
		{
			AccessMember am = AccessMember.find(teasession._nNode, teasession._rv);
			if (am.getPurview() < 1)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			if ("edit".equals(act))
			{
				boolean side = Boolean.parseBoolean(teasession.getParameter("side"));
				BigDecimal price = new BigDecimal(teasession.getParameter("price"));
				String introduce = teasession.getParameter("introduce");
				boolean extend = Boolean.parseBoolean(teasession.getParameter("extend"));
				boolean reg = Boolean.parseBoolean(teasession.getParameter("reg"));
				EonNode en = EonNode.find(teasession._nNode);
				en.set(side, price, extend, reg, introduce);
			} else if ("delete".equals(act))
			{
				EonNode en = EonNode.find(teasession._nNode);
				en.delete();
			} else if (act.startsWith("member"))
			{
				EonNode en = EonNode.find(teasession._nNode);
				String member = en.getMember();
				String old = request.getParameter("old");
				String name = request.getParameter("name");
				if (act.equals("memberdelete"))
				{
					member = member.replaceFirst("/" + old + "/", "/");
				} else
				{
					if (!Profile.isExisted(name))
					{
						response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidMember"), "UTF-8"));
						return;
					}
					if (act.equals("membernew"))
					{
						member = member + name + "/";
					} else if (act.equals("memberedit"))
					{
						member = member.replaceFirst("/" + old + "/", "/" + name + "/");
					}
				}
				en.setMember(member);
			}
		} catch (SQLException ex)
		{
			ex.printStackTrace();
		}
		response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + URLEncoder.encode(nexturl, "UTF-8"));
	}

	// Clean up resources
	public void destroy()
	{
	}
}
