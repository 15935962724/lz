package tea.ui.admin.erp;

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
import tea.entity.admin.erp.*;
import tea.entity.node.*;
import tea.entity.league.*;
import tea.db.*;

public class EditReturnedShop extends TeaServlet
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
		if(teasession._rv == null)
		{
			response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
			return;
		}
		HttpSession session = request.getSession();
		String act = teasession.getParameter("act");
		String nexturl = teasession.getParameter("nexturl");
		String purid = teasession.getParameter("purid");

		try
		{
			ReturnedShop pobj = ReturnedShop.find(purid);
			if("EditReturnedShop".equals(act))
			{
				//加盟店名称
				int supplname = 0;
				if(teasession.getParameter("supplnamehidden") != null && teasession.getParameter("supplnamehidden").length() > 0)
				{
					supplname = Integer.parseInt(teasession.getParameter("supplnamehidden"));
				}


				String subimt1 = teasession.getParameter("subimt1");
				//仓库名称
				int waridname = 0;
				if(teasession.getParameter("waridname") != null && teasession.getParameter("waridname").length() > 0)
				{
					waridname = Integer.parseInt(teasession.getParameter("waridname"));
				}
				//销售日期
				Date time_s = null;
				if(teasession.getParameter("time_s") != null && teasession.getParameter("time_s").length() > 0)
				{
					time_s = Purchase.sdf.parse(teasession.getParameter("time_s"));
				}

				 String purchase = teasession.getParameter("purchase"); //销售单号

                int type = 0;
                if(teasession.getParameter("type") != null && teasession.getParameter("type").length() > 0)
                {
                    type = Integer.parseInt(teasession.getParameter("type"));
                }



				String quantity = teasession.getParameter("quantity"); //数量总计

				String total = teasession.getParameter("total"); //折价前的金额
				String total_2 = teasession.getParameter("total_2"); //折后的金额
				if(total_2 != null && total_2.length() > 0)
				{} else
				{
					total_2 = total;
				}

				String member = teasession.getParameter("member"); //经办人
				if(member != null && member.length() > 0)
				{} else
				{
					member = teasession._rv.toString();
				}
				String remarks = teasession.getParameter("remarks"); //备注
				String member2 = null;
				if(!"0".equals(teasession.getParameter("member2")))
				{
					member2 = teasession.getParameter("member2").split("/")[1];
				}
				String telephone = teasession.getParameter("telephone");
				String address = teasession.getParameter("address");
				//审核时候标示
				String audit = teasession.getParameter("audit");
				GoodsDetails.setTime_s(purchase,time_s,waridname);
				int goods = 0;
				if(pobj.isExists())
				{
					pobj.set(supplname,waridname,null,null,quantity,total,time_s,member,teasession._strCommunity,remarks,null,null,null,total_2,null,0,member2,telephone,address,null,new Date());

				} else
				{
					ReturnedShop.create(purchase,supplname,waridname,null,null,quantity,total,time_s,member,teasession._strCommunity,remarks,null,null,null,total_2,null,0,member2,telephone,address,null,new Date());
				}
				//审核
                if(type > 0) //审核
                {
					   //修改库存中的数量和金额
					   //添加入库的商品和数量
					   java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," and  paid=" + DbAdapter.cite(purchase),0,Integer.MAX_VALUE);
					   for(int i =1;e.hasMoreElements();i++)
					   {
						   int gdid = ((Integer) e.nextElement()).intValue();
						   GoodsDetails gdobj = GoodsDetails.find(gdid);
                           int w = 0;
                           if(teasession.getParameter("waridname" + i) != null && teasession.getParameter("waridname" + i).length() > 0)
                           {
                               w = Integer.parseInt(teasession.getParameter("waridname" + i));
                               if(w == 0) //判断，如果有一个没有选择退货仓库的，则不能添加
                               {
                                   java.io.PrintWriter out = response.getWriter();
                                   out.println("<script  language='javascript'>alert('请选择存放仓库！');window.location.href='/jsp/erp/EditReturnedShop.jsp?purid=" + purid + "&refundtype=" + teasession.getParameter("refundtype") + "&nexturl=" + nexturl + "';</script> ");
                                   out.flush();
                                   out.close();
                                   return;
                               }else if(w>0)
							   {
								  gdobj.setWarehouse(w);
							   }
                           }

						   //给采购单添加退货数量
						   //获取上次的采购单 退货数量
						   GoodsDetails gb222= GoodsDetails.find(GoodsDetails.getGDid(gdobj.getPurchaseid(),gdobj.getNode()));

						   gdobj.setRgquantity(gdobj.getCommunity(),"rsquantity",gdobj.getQuantity()+gb222.getRsquantity(),gdobj.getPurchaseid(),gdobj.getNode(),2);

						   //给商品流水表添加记录
						   OrdersBatch.create(gdobj.getPaid(),gdobj.getNode(),gdobj.getQuantity(),member,teasession._rv.toString(),teasession._strCommunity,time_s,3);


						   //添加库存
						   Inventory.setQuantity(teasession._strCommunity,gdobj.getNode(),gdobj.getWarehouse(),Integer.parseInt(quantity),"+");

						   //修改了商品细节表中的商品退货数量
						   //gdobj.setRgquantity(gdobj.get);
					   }
					   //获取折后总金额
					   java.math.BigDecimal t2 = new java.math.BigDecimal("0");
					   t2 = GoodsDetails.getTotal_2(purid);
					   //判断是否有预付款
					   LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());
					   if(lsobj.getSummoney().compareTo(t2) == -1)
					   {
						   java.io.PrintWriter out = response.getWriter();
						   out.println("<script  language='javascript'>alert('抱歉!您的预付款余额不够，不能通过审核!');window.location.href='" + nexturl + "';</script> ");
						   out.flush();
						   out.close();
						   return;
					   } else
					   {
						   LeagueShopImprest.set(0,pobj.getSupplname(),new java.math.BigDecimal(pobj.getTotal_2()),new Date(),teasession._rv.toString(),new Date(),teasession._strCommunity,3,0,1,1,"退货单","退货单");
						   LeagueShop.setUpdatemoney(pobj.getSupplname(),new java.math.BigDecimal(pobj.getTotal_2()),0);
					   }


					      pobj.setType(type);
                }

			} else if("delete".equals(act))
			{
				pobj.delete();
			} else if("delete2".equals(act))//审核了以后的软删除
			{
				pobj.setType(3);
			} else if("sd".equals(act))//收到退货
			{
				pobj.setType(4);
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
