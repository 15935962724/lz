package tea.ui.node.type.golf;

import javax.servlet.*;
import javax.servlet.http.*;
import tea.ui.*;
import java.util.*;
import tea.htmlx.*;
import tea.entity.*;
import java.io.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.entity.admin.map.*;
import java.sql.SQLException;

public class EidtGolfSite extends TeaServlet
{
	public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		try
		{

			TeaSession teasession = new TeaSession(request);
			if(teasession._rv==null)
			{ 
				
			  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
			  return;
			}
			String nexturl = teasession.getParameter("nexturl");
			String act = teasession.getParameter("act");
			int gsid = 0;
			if(teasession.getParameter("gsid")!=null && teasession.getParameter("gsid").length()>0)
			{
				gsid = Integer.parseInt(teasession.getParameter("gsid"));
			}
			
			GolfSite obj  = GolfSite.find(gsid);
			if("EidtGolfSite".equals(act))
			{
				String gsname = teasession.getParameter("gsname");
				String seq = teasession.getParameter("seq");
				int standard1=0,standard2=0,standard3=0,standard4=0,standard5=0,standard6=0,standard7=0,standard8=0,standard9=0;
				int yardage1=0,yardage2=0,yardage3=0,yardage4=0,yardage5=0,yardage6=0,yardage7=0,yardage8=0,yardage9=0;
				String  hole1=null,hole2=null,hole3=null,hole4=null,hole5=null,hole6=null,hole7=null,hole8=null,hole9=null;
				String  latlong1=null,latlong2=null,latlong3=null,latlong4=null,latlong5=null,latlong6=null,latlong7=null,latlong8=null,latlong9=null;
				for(int i=1;i<10;i++)
				{
					if(teasession.getParameter("standard"+i)!=null && teasession.getParameter("standard"+i).length()>0)
					{
						if(i==1)
						{
							standard1 = Integer.parseInt(teasession.getParameter("standard"+i));
						}else if(i==2)
						{
							standard2 = Integer.parseInt(teasession.getParameter("standard"+i));
						}else if(i==3)
						{
							standard3 = Integer.parseInt(teasession.getParameter("standard"+i));
						}else if(i==4)
						{
							standard4 = Integer.parseInt(teasession.getParameter("standard"+i));
						}else if(i==5)
						{
							standard5 = Integer.parseInt(teasession.getParameter("standard"+i));
						}else if(i==6)
						{
							standard6 = Integer.parseInt(teasession.getParameter("standard"+i));
						}else if(i==7)
						{
							standard7 = Integer.parseInt(teasession.getParameter("standard"+i));
						}else if(i==8)
						{
							standard8 = Integer.parseInt(teasession.getParameter("standard"+i));
						}else if(i==9)
						{
							standard9 = Integer.parseInt(teasession.getParameter("standard"+i));
						}
						 
					}
					if(teasession.getParameter("yardage"+i)!=null && teasession.getParameter("yardage"+i).length()>0)
					{
						if(i==1)
						{
							yardage1 = Integer.parseInt(teasession.getParameter("yardage"+i));
						}else if(i==2)
						{
							yardage2 = Integer.parseInt(teasession.getParameter("yardage"+i));
						}else if(i==3)
						{
							yardage3 = Integer.parseInt(teasession.getParameter("yardage"+i));
						}else if(i==4)
						{
							yardage4 = Integer.parseInt(teasession.getParameter("yardage"+i));
						}else if(i==5)
						{
							yardage5 = Integer.parseInt(teasession.getParameter("yardage"+i));
						}else if(i==6)
						{
							yardage6 = Integer.parseInt(teasession.getParameter("yardage"+i));
						}else if(i==7)
						{
							yardage7 = Integer.parseInt(teasession.getParameter("yardage"+i));
						}else if(i==8)
						{
							yardage8 = Integer.parseInt(teasession.getParameter("yardage"+i));
						}else if(i==9)
						{
							yardage9 = Integer.parseInt(teasession.getParameter("yardage"+i));
						}
					}
					 boolean clearhole = teasession.getParameter("clearhole" + i) != null;
					 
					
					if(i==1)
					{
						 hole1 = clearhole ? "" :teasession.getParameter("hole" + i);
					}else if(i==2)
					{
						 hole2 = clearhole ? "" :teasession.getParameter("hole" + i);
					}else if(i==3)
					{
						 hole3 = clearhole ? "" :teasession.getParameter("hole" + i);
					}else if(i==4)
					{
						 hole4 = clearhole ? "" :teasession.getParameter("hole" + i);
					}else if(i==5)
					{
						 hole5 = clearhole ? "" :teasession.getParameter("hole" + i);
					}else if(i==6)
					{
						 hole6 = clearhole ? "" :teasession.getParameter("hole" + i);
					}else if(i==7)
					{
						 hole7 = clearhole ? "" :teasession.getParameter("hole" + i);
					}else if(i==8)
					{
						 hole8 = clearhole ? "" :teasession.getParameter("hole" + i);
					}else if(i==9)
					{
						 hole9 = clearhole ? "" :teasession.getParameter("hole" + i);
					}
					
					
					if(i==1)
					{
						 latlong1 =teasession.getParameter("latlong" + i);
					}else if(i==2)
					{
						 latlong2 =teasession.getParameter("latlong" + i);
					}else if(i==3)
					{
						 latlong3 =teasession.getParameter("latlong" + i);
					}else if(i==4)
					{
						 latlong4 =teasession.getParameter("latlong" + i);
					}else if(i==5)
					{
						 latlong5 =teasession.getParameter("latlong" + i);
					}else if(i==6)
					{
						 latlong6 =teasession.getParameter("latlong" + i);
					}else if(i==7)
					{
						 latlong7 =teasession.getParameter("latlong" + i);
					}else if(i==8)
					{
						 latlong8 =teasession.getParameter("latlong" + i);
					}else if(i==9)
					{
						 latlong9 =teasession.getParameter("latlong" + i);
					}
				}
			     float difficulty = 0f; // 球场难度系数
			     float gradient = 0f; // 球场坡度系数
				if(obj.isExists())
				{
					obj.set(gsname, standard1, standard2, standard3, standard4, standard5, standard6, standard7, standard8, standard9, 
							yardage1, yardage2, yardage3, yardage4, yardage5, yardage6, yardage7, yardage8, yardage9,
							hole1, hole2, hole3, hole4, hole5, hole6, hole7, hole8, hole9,seq,
							latlong1, latlong2, latlong3, latlong4, latlong5, latlong6, latlong7, latlong8, latlong9);
				}else
				{
					GolfSite.create(gsname, teasession._nNode, new Date(), teasession._strCommunity, standard1, standard2, standard3, standard4, standard5, standard6, standard7, standard8, standard9,
							yardage1, yardage2, yardage3, yardage4, yardage5, yardage6, yardage7, yardage8, yardage9, hole1, hole2, hole3, hole4, hole5, hole6, hole7, hole8, hole9,
							difficulty,gradient,seq,latlong1, latlong2, latlong3, latlong4, latlong5, latlong6, latlong7, latlong8, latlong9);
				}
				 
				
				java.io.PrintWriter out = response.getWriter();
       		 	 out.print("<script  language='javascript'>alert('数据插入成功!');window.returnValue=1;window.close();</script> ");
                   out.close();
                   return; 
				
			}else if("delete".equals(act))
			{
				java.io.PrintWriter out = response.getWriter();
				 obj.delete();
				 out.print("<script  language='javascript'>alert('数据删除成功!');window.location.href='"+nexturl+"';</script> ");
                 out.close();
                 return; 
				
			} 
 
			//response.sendRedirect(nexturl);
	

		} catch (Exception exception)
		{
			// response.sendError(400,"新闻添加错误,请检查您的网络是否正常");//exception.toString()
			// response.sendRedirect("/jsp/admin");
			response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您球场场地错误了,请重新添加&nbsp;", "UTF-8"));
		
			exception.printStackTrace();
		}

	}
}