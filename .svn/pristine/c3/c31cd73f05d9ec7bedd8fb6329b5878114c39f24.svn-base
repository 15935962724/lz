package tea.ui.admin.office;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.office.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import java.sql.*;
import javax.imageio.*;

import java.util.Date;

public class EditSealapply extends TeaServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");

		TeaSession teasession = new TeaSession(request);
		if (teasession._rv == null)
		{
			response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
			return;
		}
		String act = request.getParameter("act");
		String nexturl = teasession.getParameter("nexturl");
		try
		{
                        int sealapply = 0;
                        if(request.getParameter("sealapply")!=null && request.getParameter("sealapply").length()>0)
                            sealapply = Integer.parseInt(request.getParameter("sealapply"));
                        Sealapply obj = Sealapply.find(sealapply);

			if("EditApply".equals(act)){//添加--修改
				int cachet =Integer.parseInt(request.getParameter("cachet"));
				Date usetime = null;

				if(request.getParameter("usetime")!=null && request.getParameter("usetime").length()>0)
				{
					usetime  =Sealapply.sdf.parse(teasession.getParameter("usetime"));
				}
				int item =0;
				if(request.getParameter("item")!=null && request.getParameter("item").length()>0)
					item = Integer.parseInt(request.getParameter("item"));
				int share = 0;
				if(request.getParameter("share")!=null && request.getParameter("share").length()>0)
					share = Integer.parseInt(request.getParameter("share"));
				String usecausation = request.getParameter("usecausation");

                                if(sealapply>0)
                                {
                                    obj.set(cachet,usetime,share,0,0,usecausation,null, teasession._strCommunity, teasession._rv.toString(), item);
                                    if(obj.getExaminetype()==-1)
                                    {
                                         obj.set(0,"examinetype",teasession._rv.toString(),"member");
                                    }
                                }else{

                                    Sealapply.create(cachet, usetime, share, 0, 0, usecausation, null, teasession._strCommunity, teasession._rv.toString(), item);
                                }
			}

                        if("delete".equals(act))//删除
                        {
                            obj.delete();
                        }

                         if("Auditing".equals(act)){//审核批准
                               int examinetype = Integer.parseInt(request.getParameter("examinetype"));
                               obj.set(examinetype,"examinetype",teasession._rv.toString(),"auditingmember");
                         }
                         if("stamp".equals(act)){//印章盖章
                             int sealtype = Integer.parseInt(request.getParameter("sealtype"));
                             obj.set(sealtype,"sealtype",teasession._rv.toString(),"sealmember");
                         }

                         if("Noauditying".equals(act)){////审核不批准 填写原因
                               int examinetype = Integer.parseInt(request.getParameter("examinetype"));
                               String notcausation = request.getParameter("notcausation");
                                 obj.set(examinetype,"examinetype",teasession._rv.toString(),"auditingmember");
                                 obj.set(notcausation);

                         }
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		response.sendRedirect(nexturl);
	}



	// Clean up resources
	public void destroy()
	{
	}
}
