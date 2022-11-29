package tea.ui.node.general;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.ui.*;
import tea.entity.member.*;

public class DeleteNode extends TeaServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		request.setCharacterEncoding("UTF-8");
		Http h = new Http(request);
		try
		{
			RV rv = h.member < 1 ? new RV("<" + request.getRemoteAddr() + ">") : new RV(h.username);
			String nexturl = h.get("nexturl");
			if(request.getParameter("operate") != null) /////删除多个记录
			{
				String cb[] = h.getValues("cb");
				for(int j = 0;j < cb.length;j++)
				{
					int nid = Integer.parseInt(cb[j]);

					Node node = Node.find(nid);
					node.delete(h.language);
					Node.delete(nid,node.getType(),h.language);
					Logs.create(h.community,rv,3,h.node,node.getSubject(h.language));
					delete(node);
				}
				response.sendRedirect(nexturl);
				return;
			}

			AccessMember am = AccessMember.find(h.node,h.username);
			if(am.getPurview() < 3)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + h.node);
				return;
			}
			Node node = Node.find(h.node);

			//只有文件夹和类别才执行的
			//Node.delete(h.node, node.getType(),h.language);

			int i = node.getFather();
			node.delete(h.language);
			if(node.getType() == 34)
			{
				Goods gobj = Goods.find(h.node);
				gobj.delete();
			}
			Logs.create(h.community,rv,3,h.node,node.getSubject(h.language));
			delete(node);
			String nu = h.get("nexturl");
			if(nu != null)
			{
				response.sendRedirect(nu + (nu.indexOf("?") != -1 ? "&" : "?") + "node=" + i);
			} else
			{
				response.sendRedirect("Node?node=" + i);
			}
		} catch(Exception ex)
		{
			response.sendError(400,ex.toString());
			ex.printStackTrace();
		}
	}
}
