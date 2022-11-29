package tea.ui.member.community;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.ui.*;
import tea.resource.Common;

public class EditCommunityOption extends TeaServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		request.setCharacterEncoding("UTF-8");
		Http h = new Http(request);
		if(h.member < 1)
		{
			response.sendRedirect("/servlet/StartLogin?community=" + h.community);
			return;
		}

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try
		{
			out.println("<script>var mt=parent.mt;</script>");
			CommunityOption co = CommunityOption.find(h.community);
			String name = h.get("name");
			String[] ns = name.split("/");
			for(int i = 1;i < ns.length;i++)
			{
				String value = h.get(ns[i]);
				if(value.length() == 0)
					co.delete(ns[i]);
				else
					co.set(ns[i],value);
				if(ns[i].equals("editortoolbar"))
				{
					value = value.substring(1,value.length() - 1);
					value = value.replaceAll("/","','").replaceAll(",'\\\\n',","],'/',[");
					value = "FCKConfig.ToolbarSets['community'] = [['" + value + "']];";
					FileWriter fw = new FileWriter(Common.REAL_PATH + "/res/" + h.community + "/cssjs/editortoolbar.js");
					fw.write(value);
					fw.close();
				} else if(ns[i].equals("proxyhost"))
				{
					Entity.init();
				}
			}
			out.print("<script>mt.show('操作执行成功！');</script>");
		} catch(Throwable ex)
		{
			ex.printStackTrace();
		} finally
		{
			out.close();
		}
	}
}
