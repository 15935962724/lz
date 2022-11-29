package tea.ui.admin.orthonline;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.erp.*;
import javax.servlet.http.HttpSession;
import tea.entity.member.*;
import tea.entity.admin.*;
import tea.entity.node.*;
import tea.entity.admin.orthonline.*;


public class EditDoctoradmin extends TeaServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		TeaSession teasession = new TeaSession(request);
//		if(teasession._rv == null)
//		{
//			response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
//			return;
//		}
		String act = teasession.getParameter("act");
		String community = teasession.getParameter("community");
		String nexturl = teasession.getParameter("nexturl");
		int  daid = 0;
		if(teasession.getParameter("daid")!=null && teasession.getParameter("daid").length()>0)
		{
			daid = Integer.parseInt(teasession.getParameter("daid"));
		}

		try
		{
			Doctoradmin daobj = Doctoradmin.find(daid);
			if("EditDoctoradmin".equals(act))
			{
				String membername = teasession.getParameter("membername");//姓名
				String member = teasession.getParameter("member");//用户名
				String members = teasession.getParameter("members");
				if(members!=null&& members.length()>0)
				{
					member=members;
				}
				String paw = teasession.getParameter("paw");//密码

				int datype = Integer.parseInt(teasession.getParameter("datype"));//级别
				int sheng =0;//管理省份
				if(teasession.getParameter("sheng")!=null && teasession.getParameter("sheng").length()>0)
				{
				     sheng =  Integer.parseInt(teasession.getParameter("sheng"));
				}
				int shi = 0;//市
				if(teasession.getParameter("shi")!=null && teasession.getParameter("shi").length()>0)
				{
					 shi =  Integer.parseInt(teasession.getParameter("shi"));
				}

				int yiyuanid = 0;
				if(teasession.getParameter("yiyuanid")!=null && teasession.getParameter("yiyuanid").length()>0)
				{
				    yiyuanid = Integer.parseInt(teasession.getParameter("yiyuanid"));
				}

				//知道医院 添加 医院所在的省份
				if(yiyuanid>0)
				{
					Hospital hobj = Hospital.find(yiyuanid);
					sheng = Provinces.getProid(" and type = 0 and  provincity = '"+hobj.getProvincial()+"' ");
					shi   = Provinces.getProid(" and type > 0 and  provincity = '"+hobj.getCity()+"' ");
				}
				//添加用户
				if(Doctoradmin.isProfile(community,member))//如果添加的用户在用户表中有
				{
					Profile pobj = Profile.find(member);
					int sex= 0;
					if(pobj.isSex())
					{
						sex=1;
					}
					pobj.set(member,community,paw,pobj.getMobile(),sex,pobj.getCard(),pobj.getCardType(),membername,pobj.getEmail(),teasession._nLanguage,null);
				}else{
                    Profile.create(member,teasession._nLanguage,null,paw,null,membername,0,community,0,null,0);
                }

                 //权限用户表
                 if(AdminUsrRole.find(community,member).isExists())
                 {
                     AdminUsrRole arobj = AdminUsrRole.find(community,member);
					 StringBuffer role = new StringBuffer();//"/366/367/368/369/";
					// role.append(arobj.getRole());
                     if(arobj.getRole().indexOf("/366/") != -1)
                     {
                         role.append(arobj.getRole().replaceAll("/366/",""));
                     }else if(arobj.getRole().indexOf("/373/") != -1)
					 {
						  role.append(arobj.getRole().replaceAll("/373/",""));
					 }
                    else if(arobj.getRole().indexOf("/367/") != -1)
                     {
                         role.append(arobj.getRole().replaceAll("/367/",""));
                     }
                     else if(arobj.getRole().indexOf("/368/") != -1)
                     {
                         role.append(arobj.getRole().replaceAll("/368/",""));
                     }
                     else if(arobj.getRole().indexOf("/369/") != -1)
                     {
                         role.append(arobj.getRole().replaceAll("/369/",""));
                     }else
					 {
						 role.append(arobj.getRole());
					 }

                     role.append("/" + datype + "/");
					 String r = "/";
					 for(int i =1;i<role.toString().split("/").length;i++)
					 {
						 if(role.toString().split("/")[i]!=null&&role.toString().split("/")[i].length()>0)
						 {
							 r=r+role.toString().split("/")[i]+"/";
						 }
					 }
                     arobj.setRole(r);

                 } else
                 {
                     AdminUsrRole.create(community,member,"/" + datype + "/",null,0,null,null);
                 }
				if(daid>0)
				{

					daobj.set(member,datype,sheng,shi,yiyuanid);
				}else
				{
					Doctoradmin.create(member,datype,sheng,shi,yiyuanid,community);
				}

			} else if("delete".equals(act))//删除
			{
				//Profile p = Profile.find(daobj.getMember());
				//AdminUsrRole arobj = AdminUsrRole.find(community,daobj.getMember());
				 AdminUsrRole arobj = AdminUsrRole.find(community,daobj.getMember());
				 String role = arobj.getRole().replaceAll(String.valueOf(daobj.getDatype()),"/");
				 if(role.split("/")!=null && role.split("/").length>0)
				 {
					 arobj.setRole(role);
				 }else
				 {
					 arobj.delete();
				 }
				daobj.delete();

				//p.delete(teasession._nLanguage);
				//arobj.delete();

			}
			response.sendRedirect(nexturl+"&community="+community);
			return;
		} catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}

	// Clean up resources
	public void destroy()
	{
	}
}
