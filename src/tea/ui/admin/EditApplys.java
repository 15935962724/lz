package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.RV;
import tea.entity.admin.*;
import tea.entity.member.Message;
import tea.entity.node.Node;

import java.text.*;

public class EditApplys extends TeaServlet
{

	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		TeaSession teasession = new TeaSession(request);

		teasession = new tea.ui.TeaSession(request);
		Node node = Node.find(teasession._nNode);
		try
		{
			int apid = 0;
			if (teasession.getParameter("apid") != null && teasession.getParameter("apid").length() > 0)
			{
				apid = Integer.parseInt(teasession.getParameter("apid"));
			}

			String vehicle1 = teasession.getParameter("vehicle");// 车牌id 和车辆的司机
			String a[] = vehicle1.split("#");
			String vehicle = a[0];// 车辆的ID（int）

			int aid = 0;
			if (vehicle1 != null && vehicle1.length() > 0)
				aid = Integer.parseInt(a[0]);

			Manage obj = Manage.find(aid);

			String chauffeur = a[1];// 司机
			String man = teasession.getParameter("man");
			int unit = 0;
			if (teasession.getParameter("unit") != null && teasession.getParameter("unit").length() > 0)// 用车部门ID
				unit = Integer.parseInt(teasession.getParameter("unit"));

			String timek = teasession.getParameter("timek");// 年月日
			String begintime = teasession.getParameter("begintime");// 时分秒
			String begintime1 = teasession.getParameter("begintime1");

			String timej = teasession.getParameter("timej");
			String begintime2 = teasession.getParameter("begintime2");
			String begintime22 = teasession.getParameter("begintime22");

			String timesd1 = timek + " " + begintime + ":" + begintime1;// 开始时间
			String timesd2 = timej + " " + begintime2 + ":" + begintime22;// 结束时间
			Date times1 = null, times2 = null;
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm");
			if (timesd1 != null && timesd1.length() > 0)
			{
				times1 = format.parse(timesd1);
			}
			if (timesd2 != null && timesd2.length() > 0)
			{
				times2 = format.parse(timesd2);
			}

			String destination = teasession.getParameter("destination");
			int mileage = 0;
			if (teasession.getParameter("mileage") != null && teasession.getParameter("mileage").length() > 0)
				mileage = Integer.parseInt(teasession.getParameter("mileage"));
			String findingmanid = teasession.getParameter("findingmanid");

			String attemper = teasession.getParameter("attemper");
			// 在线调度人员空缺
			String cause = teasession.getParameter("cause");
			String remark = teasession.getParameter("remark");
			int type = 0;
			int uses = 0;

			String checkbox1 = teasession.getParameter("checkbox1");
			String checkbox2 = teasession.getParameter("checkbox2");

			if (checkbox1 != null)
			{
				tea.entity.member.Profile profile1 = tea.entity.member.Profile.find(node.getCreator()._strR);
				String s11 = profile1.getMember();
				RV _rv = new RV(findingmanid);
				Message.create(teasession._strCommunity, _rv._strV, s11, teasession._nLanguage, "车辆--" + obj.getVehicle() + "--审批", "<font color=red>：</font>用户" + teasession._rv + "申请了车辆");
			}
			if (checkbox2 != null)
			{
				tea.entity.member.Profile profile1 = tea.entity.member.Profile.find(teasession._rv.toString());
				String s11 = profile1.getMember();
				Message.create(teasession._strCommunity, teasession._rv._strV, s11, teasession._nLanguage, "我申请的车辆", "<font color=red>：</font>用户" + teasession._rv + "您的车辆已经申请成功，请等待管理员的审批");
			}

			if (apid > 0)
			{
				Applys apobj = Applys.find(apid);
				apobj.set(vehicle, chauffeur, man, unit, times1, times2, destination, mileage, findingmanid, attemper, cause, remark, type, uses);
			} else
			{
				Applys.create(vehicle, chauffeur, man, unit, times1, times2, destination, mileage, findingmanid, attemper, cause, remark, type, uses, teasession._strCommunity, teasession._rv);
			}

			response.sendRedirect("/jsp/admin/vehicle/applying.jsp?us=0");
		} catch (Exception ex)
		{
			ex.printStackTrace();

		}

	}

	// Clean up resources
	public void destroy()
	{
	}
}
