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

public class EditCallout extends TeaServlet
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
        String purid = teasession.getParameter("purid");
		int type = 0;
		if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
		{
			type = Integer.parseInt(teasession.getParameter("type"));
		}
        try
        {
           Callout pobj = Callout.find(purid);
            if("EditCallout".equals(act))
            {
                int supplname = 0;
                if(teasession.getParameter("supplname") != null && teasession.getParameter("supplname").length() > 0)
                {
                    supplname = Integer.parseInt(teasession.getParameter("supplname"));
                }
                int waridname = 0;
                if(teasession.getParameter("waridname") != null && teasession.getParameter("waridname").length() > 0)
                {
                    waridname = Integer.parseInt(teasession.getParameter("waridname"));
                }
                Date time_s =null;
                if(teasession.getParameter("time_s")!=null && teasession.getParameter("time_s").length()>0 )
                {
                    time_s = Callout.sdf.parse(teasession.getParameter("time_s"));
                }
                StringBuffer sp1 = new StringBuffer();
                StringBuffer sp2 = new StringBuffer();
                String purchase = teasession.getParameter("purchase");
                String rsgoods = GoodsDetails.getNodearr(teasession._strCommunity,purchase,4); //teasession.getParameter("rsgoods");

                String quantity = teasession.getParameter("quantity");
                String total = teasession.getParameter("total");

                String member = teasession.getParameter("member");
                String remarks = teasession.getParameter("remarks");
				//修改商品细节表中的数据
				GoodsDetails.setTime_s(purchase,time_s,waridname);
                int noyestype = 0;
                if(teasession.getParameter("noyestype") != null && teasession.getParameter("noyestype").length() > 0)
                {
                    noyestype = Integer.parseInt(teasession.getParameter("noyestype"));
                }
                if(pobj.isExists())
                {
                    pobj.set(supplname,waridname,sp1.toString(),sp2.toString(),quantity,total,time_s,member,teasession._strCommunity,remarks,rsgoods,1);
                }else{
                    Callout.create(purchase,supplname,waridname,sp1.toString(),sp2.toString(),quantity,total,time_s,member,teasession._strCommunity,remarks,rsgoods,1);
                }
				if(type==1)//审核
				{
					if(noyestype==1)//同意
					{
						pobj.setType(2);
					   //修改库存中的数量和金额
					   //添加入库的商品和数量
					   java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," and type = 4 and  paid=" + DbAdapter.cite(purchase),0,Integer.MAX_VALUE);
					   while(e.hasMoreElements())
					   {
                           int gdid = ((Integer) e.nextElement()).intValue();
                           GoodsDetails gdobj = GoodsDetails.find(gdid);

                           //给采购单添加调拨数量
                           gdobj.setCOquantity(gdid,"coquantity");

						   //调拨一个商品，就是添加一个采购单

                           //给商品流水表添加记录
                           OrdersBatch.create(gdobj.getPaid(),gdobj.getNode(),gdobj.getQuantity(),member,teasession._rv.toString(),teasession._strCommunity,time_s,4);
                           //剩余数量计算使用库存里面的数量 减去 退货的数量 等于 开始数量
                           //  int quan =  gdobj.getQuantity()-Integer.parseInt(quantity);
                           //添加库存,调查的仓库
                           Inventory.setQuantity(teasession._strCommunity,gdobj.getNode(),supplname,Integer.parseInt(quantity),"-");
                           //调入的仓库
                           Inventory.setQuantity(teasession._strCommunity,gdobj.getNode(),waridname,Integer.parseInt(quantity),"+");
						   //GoodsDetails.create("DB"+purchase,gdobj.getNode(),gdobj.getSupply(),gdobj.getDiscount(),gdobj.getDsupply(),Integer.parseInt(quantity),"",null,gdobj.getCommunity(),2,waridname,null);
                           //修改了商品细节表中的商品退货数量waridname
                           //gdobj.setRgquantity(gdobj.get);
					   }

						 //
					}else if(noyestype==-1)
					{
						pobj.delete();
					}
				}


            } else if("delete".equals(teasession.getParameter("act")))
            {
                pobj.delete();
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























