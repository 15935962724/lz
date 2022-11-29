package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.entity.util.*;
import tea.ui.*;

public class EditExample extends TeaServlet
{

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);
			AccessMember am = AccessMember.find(teasession._nNode, teasession._rv);
			if (am.getPurview() < 1)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			ServletContext application = getServletContext();
			String nu = teasession.getParameter("nexturl");
			String act = teasession.getParameter("act");
			int example = 0;
			String tmp = teasession.getParameter("example");
			if (tmp != null && tmp.length() > 0)
			{
				example = Integer.parseInt(tmp);
			}
			if ("edit".equals(act))
			{
				String subject = teasession.getParameter("subject");
				String picture = null;
				byte by[] = teasession.getBytesParameter("picture");
				if (by != null)
				{
					picture = "/tea/image/example/" + Spell.getSpell(subject) + ".jpg";
					FileOutputStream fos = new FileOutputStream(application.getRealPath(picture));
					fos.write(by);
					fos.close();
				} else if (teasession.getParameter("clear") != null)
				{
					picture = "";
				}
				String exids = null;
				tmp = teasession.getParameter("exid");
				if (tmp != null)
				{
					char extype = teasession.getParameter("extype").charAt(0);
					int exid = Integer.parseInt(tmp);
					switch (extype)
					{
					case 'C':
						exid = CssJs.find(exid).clone(0, 0).cssjs;
						break;
					case 'S':
						exid = Section.find(exid).clone(0, 0).section;
						break;
					case 'L':
						exid = Listing.find(exid).clone(0, 0).listing;
						break;
					}
					exids = String.valueOf(extype) + exid + "/";
				}
				if (example == 0 || "0".equals(teasession.getParameter("type")))
				{
					Example.create("/" + exids, subject, picture);
				} else
				{
					Example e = Example.find(example);
					if (exids != null)
					{
						e.setExid(e.getExid() + exids);
					} else
					{
						e.set(subject, picture);
					}
				}
			} else if ("del".equals(act))
			{
				Example.find(example).delete();
			} else if ("delexid".equals(act))
			{
				char extype = teasession.getParameter("extype").charAt(0);
				int exid = Integer.parseInt(teasession.getParameter("exid"));
				boolean flag = true;
				switch (extype)
				{
				case 'C':
					CssJs c = CssJs.find(exid);
					c.delete(teasession._nLanguage);
					flag = c.isExists();
					break;
				case 'S':
					Section s = Section.find(exid);
					s.delete(teasession._nLanguage);
					flag = s.time==null;
					break;
				case 'L':
					Listing l = Listing.find(exid);
					l.delete(teasession._nLanguage);
					flag = l.isExisted();
					break;
				}
				if (flag == false) // 如果已经不存在了
				{
					Example e = Example.find(example);
					String exids = e.getExid();
					exids = exids.replaceAll("/" + extype + exid + "/", "/");
					e.setExid(exids);
				}
			} else if ("use".equals(act))
			{
				Example e = Example.find(example);
				String exs[] = e.getExid().split("/");
				for (int j = 1; j < exs.length; j++)
				{
					int exid = Integer.parseInt(exs[j].substring(1));
					char extype = exs[j].charAt(0);
					switch (extype)
					{
					case 'C':
						CssJs c = CssJs.find(exid);
						c.clone(teasession._nNode, teasession._nStatus);
						break;
					case 'S':
						Section s = Section.find(exid);
						s.clone(teasession._nNode, teasession._nStatus);
						break;
					case 'L':
						Listing l = Listing.find(exid);
						l.clone(teasession._nNode, teasession._nStatus);
						break;
					}
				}
				nu = "/servlet/Node?node=" + teasession._nNode;
			}
			if (nu == null)
			{
				nu = "/jsp/site/Examples.jsp?community=" + teasession._strCommunity;
			}
			response.sendRedirect(nu);
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}

}
