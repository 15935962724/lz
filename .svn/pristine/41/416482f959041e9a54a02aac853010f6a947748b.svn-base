package tea.ui.node.access;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.html.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.db.DbAdapter;
import java.sql.SQLException;

public class EditAccessMember extends TeaServlet
{

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);
			Node node = Node.find(teasession._nNode);
			AccessMember am = AccessMember.find(teasession._nNode, teasession._rv);
			boolean flag = false;
			RV rv = teasession._rv;
			if (rv != null)
				flag = teasession._rv.isWebMaster() || teasession._rv.isOrganizer(node.getCommunity());
			else
				rv = new RV("<" + request.getRemoteAddr() + ">");
			if (!flag && !node.isCreator(teasession._rv) && am.getPurview() != 3)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			String act = request.getParameter("act");
			if ("edit".equals(act))
			{
				int accessmember = Integer.parseInt(request.getParameter("accessmember"));
				String member = null, role = null, unit = null;
				int otype = Integer.parseInt(request.getParameter("otype"));
				switch (otype)
				{
				case 1: // 所有会员
					role = unit = member = "/";
					break;
				case 2: // 自定义
					member = request.getParameter("member");
					member = "/" + member.replaceAll("; ", "/");
					role = request.getParameter("role");
					unit = request.getParameter("unit");
				}
				int style = Integer.parseInt(request.getParameter("style"));
				int purview = Integer.parseInt(request.getParameter("purview"));
				boolean auditing = Boolean.parseBoolean(request.getParameter("auditing"));
				int picshow =1;
				if(request.getParameter("picshow")!=null && request.getParameter("picshow").length()>0)
				{
					picshow = Integer.parseInt(request.getParameter("picshow"));
				}


				String type = request.getParameter("type");
				String category = request.getParameter("category");

				StringBuffer sptype = new  StringBuffer("/");
				StringBuffer spcategory = new  StringBuffer("/");

				if(type!=null && type.length()>0)
				{
					String typevalue [] = teasession.getParameterValues("type");
					for(int i =0;i<typevalue.length;i++)
					{
						sptype.append(typevalue[i]).append("/");
					}
				}

				if(category!=null && category.length()>0)
				{
					String categoryvalue [] = teasession.getParameterValues("category");
					for(int i =0;i<categoryvalue.length;i++)
					{
						spcategory.append(categoryvalue[i]).append("/");
					}
				}
				// 段落
				String section = teasession.getParameter("section");
				StringBuffer spsection = new StringBuffer("/");
				if(section!=null && section.length()>0)
				{
					String sectionvalue[]=teasession.getParameterValues("section");
					for(int i =0;i<sectionvalue.length;i++)
					{
						spsection.append(sectionvalue[i]).append("/");
					}
				}
				// 列举
				String listing = teasession.getParameter("listing");
				StringBuffer splisting = new StringBuffer("/");
				if(listing!=null && listing.length()>0)
				{
					String listingvalue[]=teasession.getParameterValues("listing");
					for(int i =0;i<listingvalue.length;i++)
					{
						splisting.append(listingvalue[i]).append("/");
					}
				}
				 //css

				String cssjs = teasession.getParameter("cssjs");
				StringBuffer spcssjs = new StringBuffer("/");
				if(cssjs!=null && cssjs.length()>0)
				{
					String cssjsvalue[]=teasession.getParameterValues("cssjs");
					for(int i =0;i<cssjsvalue.length;i++)
					{
						spcssjs.append(cssjsvalue[i]).append("/");
					}
				}
				// 推荐栏目
				String listings = teasession.getParameter("listings");
				StringBuffer splistings = new StringBuffer("/");
				if (listings != null && listings.length() > 0) {
					String listingvalue[] = teasession
							.getParameterValues("listings");
					for (int i = 0; i < listingvalue.length; i++) {
						splistings.append(listingvalue[i]).append("/");
					}
				}
				 /**
                 * 审核权限
                 * 2012-04-06
                 * zjs
                 */
                int i3 = 0;
                if(request.getParameter("Permissions1") != null)
                {
                	i3 |= 1;
                }
                if(request.getParameter("Permissions2") != null)
                {
                	i3 |= 2;
                }

                if(request.getParameter("Permissions3") != null)
                {
                	i3 |= 4;
                }
                if(request.getParameter("Permissions4") !=null )
                {
                	i3 |= 8;
                }

				if (accessmember == 0)
				{
					AccessMember.create(teasession._nNode, member, role, unit, rv._strV, style, purview, auditing, sptype.toString(), spcategory.toString(),spsection.toString(),
							splisting.toString(),spcssjs.toString(),splistings.toString(),picshow,i3);
				} else
				{
					AccessMember obj = AccessMember.find(accessmember);
					obj.set(member, role, unit, style, purview, auditing, sptype.toString(), spcategory.toString(),spsection.toString(),splisting.toString(),
							spcssjs.toString(),splistings.toString(),picshow,i3);
				}
			} else if ("extend".equals(act)) // 允许将来自父系的可继承权限传播给该对象
			{
				boolean extend = teasession.getParameter("extend") != null;
				node.setExtend(extend);
			} else if ("reset".equals(act)) // 重置所有子对象的权限并允许传播可继承权限
			{
				AccessMember.reset(teasession._nNode);
			} else if ("delete".equals(act))
			{
				int accessmember = Integer.parseInt(request.getParameter("accessmember"));
				AccessMember obj = AccessMember.find(accessmember);
				obj.delete();
			}
			String nu = request.getParameter("nexturl");
			if (nu == null)
			{
				nu = "/jsp/access/AccessMembers.jsp?node=" + teasession._nNode;
			}
			response.sendRedirect(nu);
		} catch (Exception exception)
		{
			response.sendError(400, exception.toString());
			exception.printStackTrace();
		}
	}
}
