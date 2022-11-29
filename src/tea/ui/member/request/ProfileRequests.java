// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-23 9:23:51
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   ProfileRequests.java

package tea.ui.member.request;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.ProfileRequest;
import tea.html.*;
import tea.htmlx.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class ProfileRequests extends TeaServlet
{

	public ProfileRequests()
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
			response.sendRedirect("/jsp/request/ProfileRequests.jsp" + qs);

			// if (!teasession._rv.isSupport())
			// {
			// response.sendError(403);
			// return;
			// }
			//
			// Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Requests", super.r.getString(teasession._nLanguage, "Requests")) + ">" + super.r.getString(teasession._nLanguage, "ProfileRequests"));
			// text.setId("PathDiv");
			// String s = request.getParameter("Pos");
			// int i = s != null ? Integer.parseInt(s) : 0;
			// Form form = new Form("foGrant", "POST", "GrantProfileRequests");
			// int j = ProfileRequest.countRequests(teasession._rv._strR);
			// form.add(new Text(j + " " + super.r.getString(teasession._nLanguage, "ProfileRequests")));
			// if (j != 0)
			// {
			// form.add(new HiddenField("Pos", Integer.toString(i)));
			// Table table = new Table();
			// Row row;
			// for (Enumeration enumeration = ProfileRequest.findRequests(teasession._rv._strR, i, 25); enumeration.hasMoreElements(); table.add(row))
			// {
			// RV rv = (RV) enumeration.nextElement();
			// form.add(new HiddenField("ProfileRequests", rv.toString()));
			// row = new Row(new Cell(new CheckBox(rv.toString(), true)));
			// row.add(new Cell(getRvDetail(rv, teasession._nLanguage, request.getContextPath())));
			// }
			//
			// form.add(table);
			// form.add(new GrantDeny(teasession._nLanguage));
			// }
			// PrintWriter printwriter = response.getWriter();
			// printwriter.print(text);
			// printwriter.print(form);
			// printwriter.print(new FPNL(teasession._nLanguage, "ProfileRequests?Pos=", i, j));
			// printwriter.print(new Languages(teasession._nLanguage, request));
			//			printwriter.close();
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("tea/ui/member/request/Requests").add("tea/ui/member/request/ProfileRequests");
	}
}
