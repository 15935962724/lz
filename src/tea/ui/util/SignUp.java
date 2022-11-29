// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-5-17 17:27:00
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   SignUp.java

package tea.ui.util;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Node;
import tea.entity.site.Community;
import tea.html.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class SignUp extends TeaServlet
{

	public SignUp()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			TeaSession teasession = new TeaSession(request);
			Community community = Community.find(Node.find(teasession._nNode).getCommunity());
			String s = community.getTerm(teasession._nLanguage);
			PrintWriter printwriter = response.getWriter();
			printwriter.print(s);
			if (s.indexOf("foSignUp") == -1 || s.indexOf("SignUp1") == -1)
			{
				Form form = new Form("foSignUp", "POST", "SignUp1");
				String s1 = request.getParameter("NextUrl");
				if (s1 == null)
					s1 = "/servlet/Node?node=" + teasession._nNode;
				form.add(new HiddenField("NextUrl", s1));
				form.add(new Button(super.r.getString(teasession._nLanguage, "Agree")));
				form.add(new Button("DoNotAgree", super.r.getString(teasession._nLanguage, "DoNotAgree"), "javascript:location.href='" + s1 + "';return(false);"));
				printwriter.print(form);
			}
			printwriter.close();
			return;
		} catch (Exception exception)
		{
			response.sendError(400, exception.toString());
			exception.printStackTrace();
			return;
		}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("tea/ui/util/SignUp");
	}
}