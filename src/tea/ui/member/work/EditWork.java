package tea.ui.member.work;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.work.WorkTable;
import tea.html.*;
import tea.htmlx.Languages;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditWork extends TeaServlet
{

	public EditWork()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);
			if (teasession._rv == null)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			String s = request.getRequestURI();
			boolean flag = s.substring(s.lastIndexOf("/") + 1).equals("EditWork");
			boolean flag1 = s.endsWith("NewWork");
			int i = teasession._nLanguage;
			if (request.getMethod().equals("GET"))
			{
				Form form = new Form("foEdit", "POST", "EditWork");
				form.setMultiPart(true);
				String EditWorktableUI = r.getString(i, "EditWorktableUI");
				form.add(new Text(EditWorktableUI));
				PrintWriter printwriter = response.getWriter();
				printwriter.print(form);
				printwriter.print(new Languages(teasession._nLanguage, request));
				printwriter.close();
			} else
			{
				String projectname = teasession.getParameter("projectname");
				String reciever = teasession.getParameter("reciever");
				String senddpt = teasession.getParameter("senddpt");
				String manager = teasession.getParameter("manager");
				String pstartdatee = teasession.getParameter("pstartdate");
				Date pstartdate = WorkTable.sdf.parse(pstartdatee); // new Date(pstartdatee);
				String pstopdatee = teasession.getParameter("pstopdate");
				Date pstopdate = WorkTable.sdf.parse(pstopdatee); // new Date(pstopdatee);
				String require = teasession.getParameter("require");
				String filename = teasession.getParameter("FileName");
				byte abyte[] = teasession.getBytesParameter("File");
				WorkTable wt = WorkTable.Create(projectname, i, senddpt, teasession._rv._strV, reciever, pstartdate, pstopdate, manager, require, filename, abyte);
				int wtn = wt._nWorks;
				response.sendRedirect("Work?Work=".concat(String.valueOf(String.valueOf(wtn))));
			}
		} catch (Exception exception)
		{
			exception.printStackTrace();
		}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		r.add("tea/ui/member/work/EditWork");
	}
}
