package tea.ui.admin.orthonline;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import tea.entity.*;
import tea.entity.site.*;
import tea.entity.westrac.WestracIntegralLog;
import tea.entity.bbs.BBSPoint;
import tea.entity.integral.IntegralRecord;
import tea.entity.member.*;
import tea.ui.*;
import tea.service.*;

public class OrthSubscribers extends TeaServlet
{

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("/tea/ui/member/community/Communities").add("/tea/ui/member/community/OrganizingCommunities").add("/tea/ui/member/community/Subscribers");
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
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
		//	if (request.getMethod().equals("GET"))
			//{

				//response.sendRedirect("/jsp/orth/Subscribers.jsp?community=" + teasession._strCommunity);
			//} else
			//{
				String members = request.getParameter("members");
				int integral =Integer.parseInt(request.getParameter("integral"));
				String reasonstring = teasession.getParameter("reasonstring");

		        for(int i=1;i<members.split("/").length;i++){
		        	String profile=members.split("/")[i];
		        	//System.out.println(members[i]+integral);
		        		float zin = 0;
						Profile p = Profile.find(profile);
						//p.addIntegral(integral, profile);
						//System.out.println(p.getMembertype()+"--"+teasession.getParameter("act"));
						if(p.getMembertype()==1 && !"Integral".equals(teasession.getParameter("act")))
						{
							//说明是俱乐部会员

							p.setMyintegral(p.getMyintegral()+integral);

							if(String.valueOf(integral).indexOf("-")!=-1)
							{
								//减分
								WestracIntegralLog.create(p.getMember(), 10, null, 0, 0, reasonstring, new Date(), integral, teasession._strCommunity);


							}else
							{
								//加分
								WestracIntegralLog.create(p.getMember(), 9, null, 0, integral, reasonstring, new Date(), 0, teasession._strCommunity);
							}
							zin = p.getMyintegral();


						}else
						{
							//System.out.println((p.getIntegral()+integral)+"::::"+integral+"::::"+p.getIntegral());

								p.setIntegral((p.getIntegral()+integral));

							//System.out.println(p.getIntegral());

							IntegralRecord.create(teasession._strCommunity, p.getMember(),integral, 10, 0, teasession._rv._strV,reasonstring);


							 BBSPoint bp = new BBSPoint(0);
		                     bp.member = profile;
		                     bp.point = (int)integral;
		                     bp.node = 0;
		                     bp.type = 16;
		                     bp.set();
		                     zin = p.getIntegral();

						}
						int issms=0;
						if(teasession.getParameter("lname")!=null && teasession.getParameter("lname").length()>0)
						{
							issms =Integer.parseInt(teasession.getParameter("lname"));
						}
					//	System.out.println("---------"+issms);
						if(issms==1){
							if(String.valueOf(integral).indexOf("-")!=-1)
							{
							//发送短信加分
								String ctext = reasonstring+",为您减了"+integral+"积分，您目前的总积分为"+zin+"分！希望获得您更多的支持！";
		     					SMSMessage.create(teasession._strCommunity,p.getMember(),p.getMobile(),teasession._nLanguage,ctext);
							}else
							{
								//加分
								String ctext = reasonstring+",为您增加了"+integral+"积分，您目前的总积分为"+zin+"分！希望获得您更多的支持！";
		     					SMSMessage.create(teasession._strCommunity,p.getMember(),p.getMobile(),teasession._nLanguage,ctext);

							}
						}


		        }
		        return;
				//response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + java.net.URLEncoder.encode("/jsp/orth/Subscribers.jsp?community=" + teasession._strCommunity, "UTF-8"));
			//}
		} catch (Exception exception)
		{
			response.sendError(400, exception.toString());
			exception.printStackTrace();
		}
	}

}
