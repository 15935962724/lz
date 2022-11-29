package tea.ui.admin.erp;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.erp.*;
import tea.entity.node.*;
import javax.servlet.http.HttpSession;
import tea.entity.member.*;
import tea.entity.admin.erp.*;
import java.math.BigDecimal;
import tea.db.*;


public class EditBatchPrice extends TeaServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		request.setCharacterEncoding("UTF-8");
		TeaSession teasession = new TeaSession(request);
		if(teasession._rv == null)
		{
			response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
			return;
		}
		HttpSession session = request.getSession();
		String act = teasession.getParameter("act");
		String nexturl = teasession.getParameter("nexturl");
		int bpid = 0;
		if(teasession.getParameter("bpid")!=null && teasession.getParameter("bpid").length()>0)
		{
			bpid = Integer.parseInt(teasession.getParameter("bpid"));
		}
		String sql = teasession.getParameter("sql");
		try
		{
		  BatchPrice bpobj = BatchPrice.find(bpid);
			if("EditBatchPrice".equals(act))
			{
				//加盟店
                int joinhidden = 0;
                if(teasession.getParameter("joinhidden") != null && teasession.getParameter("joinhidden").length() > 0)
                {
                    joinhidden = Integer.parseInt(teasession.getParameter("joinhidden"));
                }
				//折扣 discount
				float discount = 0;
				if(teasession.getParameter("bapr")!=null && teasession.getParameter("bapr").length()>0)
				{
					discount = Float.parseFloat(teasession.getParameter("bapr"));
				}
				if(bpid>0)
				{
					bpobj.set(joinhidden,bpobj.getNode(),new java.math.BigDecimal(teasession.getParameter("price"+bpobj.getNode())) ,teasession._rv.toString(),discount);

				}else
				{
                    java.util.Enumeration e = Node.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
                    while(e.hasMoreElements())
                    {
                        int nid = ((Integer) e.nextElement()).intValue();
                        Node nobj = Node.find(nid);
                        Goods gobj = Goods.find(nid);
                        java.math.BigDecimal p = new java.math.BigDecimal("0");
                        if(teasession.getParameter("price" + nid) != null && teasession.getParameter("price" + nid).length() > 0)
                        {
                            p = new java.math.BigDecimal(teasession.getParameter("price" + nid));
                        }
						if(BatchPrice.isJN(teasession._strCommunity,joinhidden,nid)>0)
						{
							BatchPrice bobj = BatchPrice.find(BatchPrice.isJN(teasession._strCommunity,joinhidden,nid));
							bobj.set(joinhidden,nid,p,teasession._rv.toString(),discount);
						}else
						{
                            BatchPrice.create(joinhidden,nid,p,teasession._strCommunity,teasession._rv.toString(),discount);
                        }
                    }
                }

			} else if("delete".equals(teasession.getParameter("act")))
			{
				bpobj.delete();
				response.sendRedirect(nexturl);
				return;
			}


			response.sendRedirect(nexturl);
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
