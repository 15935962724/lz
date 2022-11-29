package tea.ui;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;

public class Utils extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		response.setContentType("text/html; charset=UTF-8");
		Http h = new Http(request,response);
		HttpSession session = request.getSession();
		ServletContext application = this.getServletContext();
		String act = h.get("act"),nexturl = h.get("nexturl");;
		if("down".equals(act))
		{
			String url = h.get("url");
			if(!url.startsWith("/res/") || url.contains(".."))
			{
				response.sendError(404,url);
				return;
			}
			if(url.contains("WEB-INF"))
			{
				Filex.logs("Utils.txt",url);
				return;
			}
			String name = h.get("name");
			if(name == null)
				name = url.substring(url.lastIndexOf('/') + 1);
			name = name.replace(':','：');
			response.setHeader("Cache-Control","private");
			response.setContentType("application/octet-stream");
			//ISO:“专业”在GG下乱码
			response.setHeader("Content-Disposition","attachment; filename=\"" + Http.enc(name) + "\""); //new String(name.getBytes("GBK"),"ISO-8859-1")
			application.getRequestDispatcher(url).forward(request,response);
			return;
		} else if("lang".equals(act))
		{
			//session.setAttribute("tea.Language", h.getInt("language"));
			response.addCookie(new Cookie("language",h.get("language")));
			if(nexturl == null)
				nexturl = request.getHeader("referer");
			response.sendRedirect(nexturl);
		}
	}

	public static String f(String file)
	{
		return file == null ? "" : "<a href='/Utils.do?act=down&url=" + Http.enc(file) + "'><img src='/tea/image/netdisk/" + file.substring(file.lastIndexOf(".") + 1) + ".gif' align='top'>&nbsp;" + file.substring(file.lastIndexOf("/") + 1) + "</a>";
	}


}
