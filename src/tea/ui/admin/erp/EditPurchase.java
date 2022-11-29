package tea.ui.admin.erp;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.admin.erp.*;
import javax.servlet.http.HttpSession;
import tea.entity.member.*;
import tea.entity.admin.erp.*;

public class EditPurchase extends TeaServlet
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
        int flowtype = 0;
        if(teasession.getParameter("flowtype") != null && teasession.getParameter("flowtype").length() > 0)
        {
            flowtype = Integer.parseInt(teasession.getParameter("flowtype"));
        }
    //审核时候同样和不同意的标示 noyestype 1同意 0 不同意
        int noyestype = 0;
        if(teasession.getParameter("noyestype") != null && teasession.getParameter("noyestype").length() > 0)
        {
            noyestype = Integer.parseInt(teasession.getParameter("noyestype"));
        }
        try
        {
            Purchase pobj = Purchase.find(purid);
            if("EditPurchase".equals(act))
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
                Date time_s = null;
                if(teasession.getParameter("time_s") != null && teasession.getParameter("time_s").length() > 0)
                {
                    time_s = Purchase.sdf.parse(teasession.getParameter("time_s"));
                }
                StringBuffer sp1 = new StringBuffer();
                StringBuffer sp2 = new StringBuffer();
			  String purchase = teasession.getParameter("purchase");
                String rsgoods = GoodsDetails.getNodearr(teasession._strCommunity,purchase,2); //teasession.getParameter("rsgoods");

                String quantity = teasession.getParameter("quantity");
                String total = teasession.getParameter("total");

                String member = teasession.getParameter("member");
                String remarks = teasession.getParameter("remarks");
				GoodsDetails.setTime_s(purchase,time_s,waridname);
                if(pobj.isExists())
                {
                  pobj.set(supplname,waridname,sp1.toString(),sp2.toString(),quantity,total,time_s,member,teasession._strCommunity,remarks,rsgoods,0);
				  if(flowtype==1)//表示审核
				  {
					  if(noyestype==1)//同意
					  {
						  pobj.setFlowType(flowtype);
						  //添加实际采购数量
						  GoodsDetails.setQuantity22(purchase);

					  }else
					  {
						  pobj.delete();
					  }
				  }else if(flowtype==2)//已审核，未到货 审核入库商品
				  {
					  //添加入库的商品和数量
					  java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," and  paid="+DbAdapter.cite(purchase),0,Integer.MAX_VALUE);
					  while(e.hasMoreElements())
					  {
                          int gdid = ((Integer) e.nextElement()).intValue();
                          GoodsDetails gdobj = GoodsDetails.find(gdid);
                          OrdersBatch.create(gdobj.getPaid(),gdobj.getNode(),gdobj.getQuantity(),member,teasession._rv.toString(),teasession._strCommunity,time_s,2);
                          //剩余数量计算
                          int quan = gdobj.getQuantity22() - gdobj.getQuantity();
                          gdobj.setQuantity2(quan);
                          //添加库存
                          Inventory.setQuantity(teasession._strCommunity,gdobj.getNode(),waridname,gdobj.getQuantity(),"+");
					  }
					  //判断如果没有了剩余商品 ，说明商品全部到货
					  if(!GoodsDetails.isQuantity2(purchase))
					  {
						  pobj.setFlowType(4);
					  }else{
                          pobj.setFlowType(flowtype);
                      }



				  }else if(flowtype==3)//添加剩余的商品入库
				  {
                      java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," and quantity2!=0 and  paid=" + DbAdapter.cite(purchase),0,Integer.MAX_VALUE);

                      for(int i = 1;e.hasMoreElements();i++)
                      {
                          int quantity2 = 0; //获取的剩余数量
                          if(teasession.getParameter("quantity2" + i) != null && teasession.getParameter("quantity2" + i).length() > 0)
                          {
                              quantity2 = Integer.parseInt(teasession.getParameter("quantity2" + i));
                          }
						  String totals = teasession.getParameter("total" + i);
                          int gdid = ((Integer) e.nextElement()).intValue();
                          GoodsDetails gdobj = GoodsDetails.find(gdid);
                          OrdersBatch.create(gdobj.getPaid(),gdobj.getNode(),quantity2,member,teasession._rv.toString(),teasession._strCommunity,time_s,2);
                          //剩余数量计算
                          int quan = gdobj.getQuantity22() - gdobj.getQuantity() - quantity2;
                          gdobj.setQuantity2(quan);
                          //修改进货数量
                          gdobj.setQuantity(gdobj.getQuantity() + quantity2);
						  //修改金额
						  gdobj.setTotal(new java.math.BigDecimal(gdobj.getTotal()).add(new java.math.BigDecimal(totals)));
                          //添加库存
                          Inventory.setQuantity(teasession._strCommunity,gdobj.getNode(),waridname,quantity2,"+");
                      }
					  //判断如果没有了剩余商品 ，说明商品全部到货
					  if(!GoodsDetails.isQuantity2(purchase))
					  {
						  pobj.setFlowType(4);
					  }
					  //修改采购单中的总金额和数量
					  int q = Integer.parseInt(pobj.getQuantity()) + Integer.parseInt(quantity);
					 java.math.BigDecimal t =  new java.math.BigDecimal(pobj.getTotal()).add(new java.math.BigDecimal(total));
					 pobj.setQuantityTotal(String.valueOf(q),String.valueOf(t));

				  }
                } else
                {
                    Purchase.create(purchase,supplname,waridname,sp1.toString(),sp2.toString(),quantity,total,time_s,member,teasession._strCommunity,remarks,rsgoods,0,0);
                }

            }else if("delete".equals(act))
			{
				pobj.delete();
			}else if("delete2".equals(act))
			{
				if(flowtype==2)//删除已审核未到货
				{
					pobj.delete();
				}
				else if(flowtype==3)//部分到货
				{
					pobj.setFlowType(4);
				}
			}


            response.sendRedirect(nexturl+"&flowtype="+flowtype);
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
