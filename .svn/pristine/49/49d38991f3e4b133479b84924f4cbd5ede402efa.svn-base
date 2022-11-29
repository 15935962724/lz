<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	TeaSession teasession = new TeaSession(request);
	if (teasession._rv == null) 
	{
		response.sendRedirect("/servlet/StartLogin?node="+ teasession._nNode);
		return;
	}
	String community = request.getParameter("community");

	Enumeration enumer = Bulletin.findByCommunity(teasession._strCommunity, "");

	String Time = DutyClass.GetNowDate();

	String members = teasession._rv.toString();//当前用户

	AdminUsrRole au_obj = AdminUsrRole.find(teasession._strCommunity,members);
	if (au_obj.isExists()) 
	{
 
		StringBuffer sql=new StringBuffer();
		sql.append(" AND l.time=").append(DbAdapter.cite(Time)).append(" AND ( l.member=").append(DbAdapter.cite(members));
		String classes=au_obj.getClasses();
		if(classes.length()>2)
		{
			String str=classes.substring(1,classes.length()-1).replace('/',',');
			sql.append(" OR dept IN(").append(str).append(")");
		}
		sql.append(" )");
		Enumeration e = DayOrder.findByCommunity(teasession._strCommunity, sql.toString());
		if (!e.hasMoreElements()) 
		{
			out.print("暂无日程安排");
		}else
		while (e.hasMoreElements()) 
		{
			int ids = ((Integer) e.nextElement()).intValue();
			DayOrder obj = DayOrder.find(ids);
			out.print("<br>");
			if (obj.getBegintime() < 10) 
			{
				out.print("0" + obj.getBegintime() + ":");
			} else 
			{
				out.print(obj.getBegintime() + ":");
			}
			if (obj.getBegintime1() < 10) 
			{
				out.print("0" + obj.getBegintime1());
			} else 
			{
				out.print(obj.getBegintime1());
			}
			out.print("-");
			if (obj.getEndtime() < 10) 
			{
				out.print("0" + obj.getEndtime() + ":");
			} else 
			{
				out.print(obj.getEndtime() + ":");
			}
			if (obj.getEndtime1() < 10) 
			{
				out.print("0" + obj.getEndtime1());
			} else 
			{
				out.print(obj.getEndtime1());
			}
			String year = Time.substring(0, 4);
			String month = Time.substring(5, 7);
			String date = Time.substring(8, 10);
			//out.print(year+"<br>"+month+"<br>"+date);
			out.print(":<a href =\"/jsp/admin/flow/AffairContent.jsp?community="
			+ community
			+ "&year="
			+ year
			+ "&month="
			+ month
			+ "&date="
			+ date
			+ "&aid="
			+ ids
			+ "\" target=\"_blank \" > "
			+ obj.getAffaircontent() + "</a>");
		}

	}//if
%>




