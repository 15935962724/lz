// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-23 9:42:20
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   JoinRequestCommunities.java

package tea.ui.member.request;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.site.JoinRequest;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class JoinRequestCommunities extends TeaServlet
{

	public JoinRequestCommunities()
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

			String qs = request.getQueryString();
			qs = qs == null ? "" : "?" + qs;
			response.sendRedirect("/jsp/request/JoinRequestCommunities.jsp" + qs);

			// Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Requests", super.r.getString(teasession._nLanguage, "Requests")) + ">" + super.r.getString(teasession._nLanguage, "JoinRequestCommunities"));
			// text.setId("PathDiv");
			// String s = request.getParameter("Pos");
			// int i = s != null ? Integer.parseInt(s) : 0;
			// Table table = new Table();
			// int j = JoinRequest.countRequestCommunities(teasession._rv);
			// table.setCaption(j + " " + super.r.getString(teasession._nLanguage, "JoinRequestCommunities"));
			// Row row;
			// for(Enumeration enumeration = JoinRequest.findRequestCommunities(teasession._rv); enumeration.hasMoreElements(); table.add(row))
			// {
			// String s1 = (String)enumeration.nextElement();
			// row = new Row(new Cell(new Anchor("Node?Community=" + s1, s1)));
			// row.add(new Cell(new Anchor("JoinRequests?Community=" + s1, Integer.toString(JoinRequest.countRequests(s1)))));
			// }
			//
			// PrintWriter printwriter = response.getWriter();
			// printwriter.print(text);
			// printwriter.print(table);
			// printwriter.print(new FPNL(teasession._nLanguage, "JoinRequestCommunities?Pos=", i, j));
			// printwriter.print(new Languages(teasession._nLanguage, request));
			// printwriter.close();
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("tea/ui/member/request/Requests").add("tea/ui/member/request/JoinRequestCommunities");
	}
}
