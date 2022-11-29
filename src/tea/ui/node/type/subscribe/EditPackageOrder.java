package tea.ui.node.type.subscribe;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.subscribe.PackageOrder;
import tea.entity.subscribe.Subscribe;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditPackageOrder extends TeaServlet
{
	
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
              response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
              return;
            }
            String act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            
            
            if("PackageOrder1".equals(act))
            { 
            	int sid = 0;
            	if(teasession.getParameter("sid")!=null && teasession.getParameter("sid").length()>0)
            	{
            		sid = Integer.parseInt(teasession.getParameter("sid"));
            	}
            	Subscribe sobj = Subscribe.find(sid);
            	
            	String pkorder = teasession.getParameter("pkorder");
            	PackageOrder pobj = PackageOrder.find(pkorder); 
            	
            	int whethermail = 0;//是否邮寄
            	if(teasession.getParameter("check_1")!=null && teasession.getParameter("check_1").length()>0)
            	{
            		whethermail = Integer.parseInt(teasession.getParameter("check_1"));
            	}
            	String shoujiaren = null;
            	String dizhi =null;//地址
            	String youbian = null;//邮编
            	String dianhua= null;//电话
            	String fapiaotaitou = null;//发票抬头
            	String fapiaoneirong = null;//发票内容
            	String beizhushuoming = null;//备注内容
            	
            	if(whethermail==1)
            	{
	            	 shoujiaren = teasession.getParameter("shoujiaren");//收件人
	            	 dizhi = teasession.getParameter("dizhi");//地址
	            	 youbian = teasession.getParameter("youbian");//邮编
	            	 dianhua= teasession.getParameter("dianhua");//电话
	            	 fapiaotaitou = teasession.getParameter("fapiaotaitou");//发票抬头
	            	 fapiaoneirong = teasession.getParameter("fapiaoneirong");//发票内容
	            	 beizhushuoming = teasession.getParameter("beizhushuoming");//备注内容
            	}  
            	if(pobj.isExists())
            	{
            		pobj.set(sid, sobj.getSubject(),sobj.getMarketprice(),sobj.getPromotionsprice(),sobj.getRemarks(),
            				whethermail, shoujiaren, dizhi, youbian, dianhua, fapiaotaitou, fapiaoneirong, beizhushuoming, teasession._rv.toString()
            				, new Date(), null, 0, 0, teasession._strCommunity,teasession._nNode);
            	}else
            	{
            		pkorder = PackageOrder.create(sid, sobj.getSubject(),sobj.getMarketprice(),sobj.getPromotionsprice(),sobj.getRemarks(),
            				whethermail, shoujiaren, dizhi, youbian, dianhua, fapiaotaitou, fapiaoneirong, beizhushuoming, teasession._rv.toString()
            				, new Date(), null, 0, 0, teasession._strCommunity,teasession._nNode);
            	}
            	response.sendRedirect(nexturl+"?pkorder="+pkorder);
            	return;   
            	
            }

			
        } catch (Exception ex)
        {
            response.sendRedirect("/jsp/info/Error.jsp?info=" + ex.getMessage());
            ex.printStackTrace();
        }
    }
    
    
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

}
