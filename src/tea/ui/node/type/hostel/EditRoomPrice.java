package tea.ui.node.type.hostel;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.ui.*;
import java.util.Date;

public class EditRoomPrice extends TeaServlet
{

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);

			int roomprice = Integer.parseInt(request.getParameter("roomprice"));
			RoomPrice obj = RoomPrice.find(roomprice);
			if (request.getParameter("delete") != null)
			{
				obj.delete();
				response.sendRedirect("/jsp/type/hostel/EditRoomPrice.jsp?node=" + teasession._nNode);
				return;
			}
			float retail = 0;
			try
			{
				retail = Float.parseFloat(request.getParameter("retail"));
			} catch (Exception ex)
			{
			}
			float proscenium = 0;
			try
			{
				proscenium = Float.parseFloat(request.getParameter("proscenium"));
			} catch (Exception ex)
			{
			}
			float net = 0;
			try
			{
				net = Float.parseFloat(request.getParameter("net"));
			} catch (Exception ex)
			{
			}
			float weekend = 0;
			try
			{
				weekend = Float.parseFloat(request.getParameter("weekend"));
			} catch (Exception ex)
			{
			}
			String roomtype = request.getParameter("roomtype");
			String breakfast = request.getParameter("breakfast");
			String remark = request.getParameter("remark");
                        Date periodtime =null;
                        if(request.getParameter("periodtime")!=null && request.getParameter("periodtime").length()>0)
                            periodtime = RoomPrice.sdf.parse(request.getParameter("periodtime"));

                        Date periodtime2 =null;
                        if(request.getParameter("periodtime2")!=null && request.getParameter("periodtime2").length()>0)
                            periodtime2 = RoomPrice.sdf.parse(request.getParameter("periodtime2"));



			if (roomprice != 0)
			{
				obj.set(roomprice, teasession._nNode, retail, proscenium, net, weekend, teasession._nLanguage, roomtype, breakfast, remark,periodtime,periodtime2);
			} else
			{
				obj.create(teasession._nNode, retail, proscenium, net, weekend, teasession._nLanguage, roomtype, breakfast, remark,periodtime,periodtime2);
			}
			response.sendRedirect("/jsp/type/hostel/EditRoomPrice.jsp?node=" + teasession._nNode);
		} catch (Throwable t)
		{
			t.printStackTrace();
		}
	}

	// Clean up resources
	public void destroy()
	{
	}
}
