package tea.ui.util;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.util.*;
import tea.ui.TeaSession;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.resource.*;

public class Caijis extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Content-Encoding","nogzip");
		Http h = new Http(request,response);
		String act = h.get("act"),nexturl = h.get("nexturl","");
		ServletContext application = this.getServletContext();
		PrintWriter out = response.getWriter();
		try
		{
			out.println("<script>var mt=parent.mt,$$=parent.$$;</script>");
			if(h.member < 1)
			{
				out.print("<script>top.location.replace('/servlet/StartLogin?node=" + h.node + "');</script>");
				return;
			}
			String info = "操作执行成功！";
			int caiji = h.getInt("caiji");
			if("del".equals(act))
			{
				Caiji cj = Caiji.find(caiji);
				cj.delete();
			} else if("edit".equals(act))
			{
				Caiji cj = Caiji.find(caiji);
				cj.url = h.get("url");
				cj.name = h.get("name");
				cj.father = h.getInt("father");
				cj.count = h.getInt("count");
				cj.listbegin = h.get("listbegin");
				cj.listend = h.get("listend");
				//cj.linkbegin = h.get("linkbegin");
				//cj.linkend = h.get("linkend");
				cj.kickerbegin = h.get("kickerbegin");
				cj.kickerend = h.get("kickerend");
				cj.titlebegin = h.get("titlebegin");
				cj.titleend = h.get("titleend");
				cj.subheadbegin = h.get("subheadbegin");
				cj.subheadend = h.get("subheadend");
				cj.authorbegin = h.get("authorbegin");
				cj.authorend = h.get("authorend");
				cj.timebegin = h.get("timebegin");
				cj.timeend = h.get("timeend");
				cj.sourcebegin = h.get("sourcebegin");
				cj.sourceend = h.get("sourceend");
				cj.contentbegin = h.get("contentbegin");
				cj.contentend = h.get("contentend");
				//cj.code = h.get("code");
				//cj.imgpath = h.get("imgpath");
				//cj.rimgpath = application.getRealPath(cj.imgpath);
				cj.repeat = h.getInt("repeat");
				if(cj.caiji < 1)
				{
					cj.community = h.community;
					cj.time = new Date();
				}
				cj.set();
			} else if("run".equals(act))
			{
				Caiji t = Caiji.find(caiji);
				info = t.run(h);
				if(info.startsWith("抱歉，"))
					nexturl = "";
			}
			out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
		} catch(Throwable ex)
		{
			out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
			ex.printStackTrace();
		} finally
		{
			out.close();
		}
	}
}
