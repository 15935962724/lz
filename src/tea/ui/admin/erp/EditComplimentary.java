

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
import tea.entity.admin.erp.*;
import tea.db.*;

public class EditComplimentary extends TeaServlet
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
		String dibid = teasession.getParameter("purchase");//配送单号
		int type = 0;
		if(teasession.getParameter("type") != null && teasession.getParameter("type").length() > 0)
		{
			type = Integer.parseInt(teasession.getParameter("type"));
		}
		int noyestype = 0;
		if(teasession.getParameter("noyestype") != null && teasession.getParameter("noyestype").length() > 0)
		{
			noyestype = Integer.parseInt(teasession.getParameter("noyestype"));
		}
		try
		{
			Complimentary diobj =Complimentary.find(dibid);
			if("EditComplimentary".equals(act))
			{
				int supplname = 0;
				if(teasession.getParameter("supplnamehidden") != null && teasession.getParameter("supplnamehidden").length() > 0)
				{
					supplname = Integer.parseInt(teasession.getParameter("supplnamehidden"));
				}
				int warid = 0;
				if(teasession.getParameter("warid") != null && teasession.getParameter("warid").length() > 0)
				{
					warid = Integer.parseInt(teasession.getParameter("warid"));
				}
				Date time_s = null;
				if(teasession.getParameter("time_s") != null && teasession.getParameter("time_s").length() > 0)
				{
					time_s = Purchase.sdf.parse(teasession.getParameter("time_s"));
				}


				int quantity = 0;//总数量
				if(teasession.getParameter("quantity")!=null&&teasession.getParameter("quantity").length()>0)
				{
					quantity = Integer.parseInt(teasession.getParameter("quantity"));
				}


				String member = teasession.getParameter("member");
				String member2=teasession.getParameter("member2");
				String telephone=teasession.getParameter("telephone");
				String address=teasession.getParameter("address");
				String remarks = teasession.getParameter("remarks");
					GoodsDetails.setTime_s(dibid,time_s,warid);
				if(diobj.isExists())
				{
					diobj.set(supplname,warid,time_s,member,member2,telephone,address,remarks,teasession._strCommunity,quantity,null,1);
				} else
				{
					Complimentary.create(dibid,supplname,warid,time_s,member,member2,telephone,address,remarks,teasession._strCommunity,quantity,null,1);
				}
				if(type==1)
				{
					if(noyestype == 1) //同意
					{
						diobj.setType(2);
						//修改库存中的数量和金额
						//添加入库的商品和数量
						java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," and type = 7 and  paid=" + DbAdapter.cite(dibid),0,Integer.MAX_VALUE);
						while(e.hasMoreElements())
						{
							int gdid = ((Integer) e.nextElement()).intValue();
							GoodsDetails gdobj = GoodsDetails.find(gdid);

							//给采购单添加调拨数量
							gdobj.setCOquantity(gdid,"clquantity");

							//给商品流水表添加记录
							OrdersBatch.create(gdobj.getPaid(),gdobj.getNode(),gdobj.getQuantity(),member,teasession._rv.toString(),teasession._strCommunity,time_s,7);
							//剩余数量计算使用库存里面的数量 减去 退货的数量 等于 开始数量
							//  int quan =  gdobj.getQuantity()-Integer.parseInt(quantity)
						   //仓库
							Inventory.setQuantity(teasession._strCommunity,gdobj.getNode(),warid,quantity,"-");
							//修改了商品细节表中的商品退货数量
							//gdobj.setRgquantity(gdobj.get);

						}
						//
					} else if(noyestype == -1)
					{
						diobj.delete();
					}

				}
			}else if("delete".equals(act))
			{
				diobj.delete();
			}else if("ComDisButprepara".equals(act)&&type==2)//完成库房备货
			{
				  diobj.setType(3);
			}else if("ComDisButprepara".equals(act)&&type==3)//完成库房发货
			{
				String city = teasession.getParameter("city");
				String address2 = teasession.getParameter("address2");
				String consignee = teasession.getParameter("consignee");
				String zip = teasession.getParameter("zip");
				String telephone2 = teasession.getParameter("telephone2");
				java.util.Date stime = Complimentary.sdf.parse(teasession.getParameter("stimeYear") + "-" + teasession.getParameter("stimeMonth") + "-" + teasession.getParameter("stimeDay"));
				java.util.Date ftime = Complimentary.sdf.parse(teasession.getParameter("ftimeYear") + "-" + teasession.getParameter("ftimeMonth") + "-" + teasession.getParameter("ftimeDay"));
				diobj.set(city,address2,consignee,zip,telephone2,stime,ftime);
				diobj.setType(4);
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
