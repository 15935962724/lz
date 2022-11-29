package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.member.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.htmlx.TimeSelection;
import tea.entity.node.*;
import tea.ui.*;
import java.sql.SQLException;

public class AuditingEnterprise extends HttpServlet
{
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			TeaSession teasession = new TeaSession(request);
			String member[] = request.getParameterValues("members");
			/*
			 * if (request.getParameter("delete") != null) { for (int index = 0; index < member.length; index++) { ProfileEnterprise pe = ProfileEnterprise.find(member[index]); pe.delete(); } response.sendRedirect("/jsp/user/AuditingEnterprise.jsp"); return; }
			 */
			String community = teasession._strCommunity;
			for (int index = 0; index < member.length; index++)
			{
				ProfileEnterprise pe = ProfileEnterprise.find(member[index], community);
				Profile pf = Profile.find(member[index]);
				String url = request.getParameter("starturl");
				if (url != null)
				{
					pf.setStartUrl(url.trim(), teasession._nLanguage);
				} else
				{
					pf.setStartUrl("", teasession._nLanguage);
				}
				pe.setAuditing(true);
				pe.setValidity(TimeSelection.makeTime(request.getParameter("validityYear"), request.getParameter("validityMonth"), request.getParameter("validityDay"), "0", "0"));
				pe.set();

				/** ***********添加权限*********************************************** */
				int i = 0;
				int j = 0;
				int TYPE[] = { 34, 21, 39 }; // "Goods","Company","Report"
				for (int l = 2; l < Node.NODE_TYPE.length; l++)
				{
					if (l < 32)
					{
						i |= 1 << l;
					} else
					{
						j |= 1 << l % 32;
					}
				}
				Provider.create(community, member[index], i, j);
				/** ********************************************************** */
				Profile profile = Profile.find(member[index]);
				Community community_obj = Community.find(community);
				try
				{ 
					String webn = community_obj.getWebName();
					String subject = "中国-拉丁美洲经贸合作网网员通过审核";
					String content = "您好:<br>您注册的信息已通过，欢迎您成为中国-拉丁美洲经贸合作网网员.<br>您的用户是：" + new String(member[index].getBytes("ISO-8859-1"), "UTF-8") + "     密码是：" + profile.getPassword() + "   请注意保存！<br>感谢您对本网工作的支持，希望多提宝贵意见和建议。<br> 联系人：李红<br> 咨询电话：010-85322794<br> E-mail:service@china-latin.com ";
					int k = Message.create(community, teasession._rv._strV, member[index], teasession._nLanguage, subject, content);
					//tea.service.Robot.activateRoboty(community, k);
					 tea.service.SendEmaily se = new tea.service.SendEmaily(community);
			            se.sendEmail(profile.getEmail(),subject,content);  
					
				} catch (Exception ex)
				{
					ex.printStackTrace();
				}
			}
			response.sendRedirect("/jsp/user/ProfileEnterprises.jsp?community=" + community);
		} catch (IOException ex)
		{
			ex.printStackTrace();
		} catch (SQLException ex)
		{
			ex.printStackTrace();
		}
	}

	// Clean up resources
	public void destroy()
	{
	}
}
