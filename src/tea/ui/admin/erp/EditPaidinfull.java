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

public class EditPaidinfull extends TeaServlet
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
        String act = teasession.getParameter("act");
        String nexturl = teasession.getParameter("nexturl");
        String purid = teasession.getParameter("purid");
        try
        {
            Paidinfull pobj = Paidinfull.find(purid);
            if("EditPaidinfull".equals(act))
            {
                //加盟店名称
                int supplname = 0;
                if(teasession.getParameter("supplnamehidden") != null && teasession.getParameter("supplnamehidden").length() > 0)
                {
                    supplname = Integer.parseInt(teasession.getParameter("supplnamehidden"));
                }
                int type = 0;

                int t = GoodsDetails.getGoodsTYPE(teasession._strCommunity,purid); //说明商品细节里面的订单是 进货的还是销售的

                String subimt1 = teasession.getParameter("subimt1");
                String shops = teasession.getParameter("shops");
                if("保存销售单".equals(subimt1))
                {
                    type = 8;
                }
                if("EditShopstock".equals(shops)) //说明是进货单
                {
                    //如果是个人下的进货单 则 type为 1
                    type = 1;
                }

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
                String rsgoods = GoodsDetails.getNodearr(teasession._strCommunity,purchase,t); //teasession.getParameter("rsgoods");


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
                String rsarr[] = rsgoods.split("/");
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
                if("EditAuditSale".equals(audit))//总部审核加盟店下的订单
                {

                    type = 3;
                    //判断是否有预付款
                    LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());
                    if(lsobj.getSummoney().compareTo(new java.math.BigDecimal(total_2)) == -1)
                    {
                        java.io.PrintWriter out = response.getWriter();
                        out.println("<script  language='javascript'>alert('抱歉!您的预付款余额不够，不能通过审核!');window.location.href='" + nexturl + "';</script> ");
                        out.flush();
                        out.close();
                        return;
                    }else
					{
                        LeagueShopImprest.set(0,pobj.getSupplname(),new java.math.BigDecimal(pobj.getTotal_2()),new Date(),teasession._rv.toString(),new Date(),teasession._strCommunity,3,1,1,1,"销售单","销售单");
                        LeagueShop.setUpdatemoney(pobj.getSupplname(),new java.math.BigDecimal(pobj.getTotal_2()),1);
					}
                    //审核成功了，修改商品销售的库存

                    GoodsDetails.setZQuantity(teasession._strCommunity,0,purid,"paiquantity",pobj.getWaridname(),pobj.getMember(),teasession._rv.toString(),pobj.getTime_s());
                    pobj.setType(3);
                }

                if(pobj.isExists())
                {
                    pobj.set(supplname,waridname,"","",quantity,total,time_s,member,teasession._strCommunity,remarks,rsgoods,"","",total_2,"",type,member2,telephone,address,"",new Date());
                } else
                {
                    Paidinfull.create(purchase,supplname,waridname,"","",quantity,total,time_s,member,teasession._strCommunity,remarks,rsgoods,"","",total_2,"",type,member2,telephone,address,"",new Date());
                }

            } else if("delete".equals(act))
            {
                pobj.setType(7);
            } else if("AuditShopstock".equals(act)) //审核 总部下的订单，加盟店去审核
            {
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
                    LeagueShopImprest.set(0,pobj.getSupplname(),new java.math.BigDecimal(pobj.getTotal_2()),new Date(),teasession._rv.toString(),new Date(),teasession._strCommunity,3,1,1,1,"销售单","销售单");
                    LeagueShop.setUpdatemoney(pobj.getSupplname(),new java.math.BigDecimal(pobj.getTotal_2()),1);
                }
				//审核成功了，修改商品销售的库存

				GoodsDetails.setZQuantity(teasession._strCommunity,pobj.getType(),purid,"paiquantity",pobj.getWaridname(),pobj.getMember(),teasession._rv.toString(),pobj.getTime_s());

				pobj.setType(2);

            } else if("StockupDetail".equals(act)) //库房备货修改type数值
            {
            	String sdmember1 = teasession.getParameter("sdmember1");
            	String sdmember2 = teasession.getParameter("sdmember2");
            	String sdmember3 = teasession.getParameter("sdmember3");
            	String sdmember4 = teasession.getParameter("sdmember4");
            	
            	if(pobj.getSdmember3()!=null && pobj.getSdmember3().length()>0 && sdmember4!=null && sdmember4.length()>0)
            	{ 
            		pobj.setType(4);
            	}
            	
            	pobj.setSdmember(sdmember1, sdmember2, sdmember3, sdmember4);
            	
            } else if("DeliveryDetail".equals(act)) //库房发货
            {
                String city = teasession.getParameter("city");
                String shipaddress = teasession.getParameter("shipaddress");
                String consignee = teasession.getParameter("consignee");
                String zip = teasession.getParameter("zip");
                String tel = teasession.getParameter("telephone");
                java.util.Date stime = Flowitem.sdf.parse(teasession.getParameter("stimeYear") + "-" + teasession.getParameter("stimeMonth") + "-" + teasession.getParameter("stimeDay"));
                java.util.Date ftime = Flowitem.sdf.parse(teasession.getParameter("ftimeYear") + "-" + teasession.getParameter("ftimeMonth") + "-" + teasession.getParameter("ftimeDay"));
				//发货选项
				int deltype = Integer.parseInt(teasession.getParameter("deltype"));
				String deltype2 = teasession.getParameter("deltype2");
                pobj.setType(5);
                pobj.set(city,shipaddress,consignee,zip,tel,stime,ftime,deltype,deltype2);

            } else if("ConfirmShopstock".equals(act)) //确认货物是否收到
            {
                pobj.setType(6);
            } else if("delete2".equals(act)) //加盟店的软删除，只是让加盟店看不到这个订单，但是管理员可以看到
            {
                pobj.setType(7);
            }
            response.sendRedirect(nexturl);
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
