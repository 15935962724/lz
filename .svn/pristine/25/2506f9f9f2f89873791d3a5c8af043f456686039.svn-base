package tea.ui.admin.erp.semi;


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
import java.math.BigDecimal;
import tea.entity.admin.erp.semi.SemiGoods;
import tea.entity.node.Node;
import tea.entity.admin.erp.semi.SemiGoodsDetails;
import tea.entity.admin.erp.semi.*;
import tea.db.DbAdapter;

public class EditSemiGoods extends TeaServlet
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
        String ids = teasession.getParameter("ids");
        String purid = teasession.getParameter("purid");
        try
        {
            Purchase pobj = Purchase.find(purid);
            if(act.equals("EditSemipurchase")) //半成品合成规则
            {
                Date time_s = new Date();
                if(teasession.getParameter("time_s") != null && teasession.getParameter("time_s").length() > 0)
                {
                    time_s = Purchase.sdf.parse(teasession.getParameter("time_s"));
                }
                StringBuffer sp1 = new StringBuffer();
                StringBuffer sp2 = new StringBuffer();
                String purchase = teasession.getParameter("purchase");
                String rsgoods = SemiGoodsDetails.getSemiGoodsarr(teasession._strCommunity,purchase,2); //半成品
                String rsgoods2 = GoodsDetails.getNodearr(teasession._strCommunity,purchase,2); //成品
                if(rsgoods != null && rsgoods.length() > 0) //半成品
                {
                    String rsarr[] = rsgoods.split("/");
                    for(int i = 1;i < rsarr.length;i++)
                    {
                        sp1.append(teasession.getParameter("quantity" + i)).append("/");
                        sp2.append(teasession.getParameter("total" + i)).append("/");
                        SemiGoodsDetails.set(purchase,Integer.parseInt(rsarr[i]),teasession.getParameter("supply" + i),Integer.parseInt(teasession.getParameter("quantity" + i)),teasession.getParameter("total" + i),"",time_s,2,0);
                    }
                }
                if(rsgoods2 != null && rsgoods2.length() > 0) //成品//添加详细列表
                {
                    String rsarr[] = rsgoods2.split("/");
                    sp1.append("/");
                    sp2.append("/");
                    for(int i = 1;i < rsarr.length;i++)
                    {
                        GoodsDetails.set(purchase,Integer.parseInt(rsarr[i]),teasession.getParameter("supplysg" + i),"","",Integer.parseInt(teasession.getParameter("quantitysg" + i)),teasession.getParameter("totalsg" + i),"",time_s,2,0,"10");
                    }
                }
                String member = teasession._rv.toString();
                String community = teasession._strCommunity;

                SemiPurchase.set(purchase,sp1.toString(),rsgoods,rsgoods2,time_s,member,community,"",1);
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=/jsp/erp/semi/Semipurchase.jsp");
                return;
            }
            if(act.equals("EditSemiGoodsSupplier"))
            { ///添加半成品与供应商的关联
                int id = 0;
                if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("ids"));
                }
                int sgid = 0;
                if(teasession.getParameter("sgid") != null && teasession.getParameter("sgid").length() > 0)
                {
                    sgid = Integer.parseInt(teasession.getParameter("sgid"));
                }
                int num = 0; //最小进货数量

                if(teasession.getParameter("num") != null && teasession.getParameter("num").length() > 0)
                {
                    num = Integer.parseInt(teasession.getParameter("num"));
                }
                int sid = 0; //供货商id
                if(teasession.getParameter("Supplier") != null && teasession.getParameter("Supplier").length() > 0)
                {
                    sid = Integer.parseInt(teasession.getParameter("Supplier"));
                }
                BigDecimal supply = new BigDecimal("0"); //商品进货价 supply ---BuyPrice
                if(teasession.getParameter("supply") != null && teasession.getParameter("supply").length() > 0)
                {
                    supply = new BigDecimal(teasession.getParameter("supply"));
                }
                String measure = teasession.getParameter("measure"); //商品单位 measure ---Goods
                String spec = teasession.getParameter("spec"); //商品规格 spec ---Goods
                Date date = new Date();
                String info = teasession.getParameter("info");
                //判断半成品是否与这个供应商关联过。

                if(SemiSupplier.auditSeim(sgid,sid,teasession._strCommunity) > 0 && id == 0)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("此半成品已经与供应商关联过！","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode("/jsp/erp/semi/EditSemiGoodsSupplier.jsp?ids=" + id + "&sgid=" + sgid,"UTF-8"));
                    return;
                } else if(id != 0 && SemiSupplier.auditSeim2(sgid,id,sid,teasession._strCommunity) > 1)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("此半成品已经与供应商关联过！","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode("/jsp/erp/semi/EditSemiGoodsSupplier.jsp?ids=" + id + "&sgid=" + sgid,"UTF-8"));
                    return;
                } else
                {
                    SemiSupplier.set(id,sgid,sid,supply,measure,spec,teasession._strCommunity,teasession._rv.toString(),date,num,info);
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode("/jsp/erp/semi/EditSemiGoodsSupplier.jsp?ids=" + id + "&sgid=" + sgid,"UTF-8"));
                    return;
                }
            }
            if(act.equals("EditSemiCatecargo")) //配货单
            {

                int supplname = 0; //供货商
                if(teasession.getParameter("supplname") != null && teasession.getParameter("supplname").length() > 0)
                {
                    supplname = Integer.parseInt(teasession.getParameter("supplname"));
                }
                int waridname = 0;
                if(teasession.getParameter("waridname") != null && teasession.getParameter("waridname").length() > 0)
                {
                    waridname = Integer.parseInt(teasession.getParameter("waridname"));
                }
                Date time_s = new Date();
                if(teasession.getParameter("time_s") != null && teasession.getParameter("time_s").length() > 0)
                {
                    time_s = Purchase.sdf.parse(teasession.getParameter("time_s"));
                }
                StringBuffer sp1 = new StringBuffer();
                StringBuffer sp2 = new StringBuffer();

                String purchase = teasession.getParameter("purchase"); //半成品合成成品的订单号
                String purchasesg = teasession.getParameter("purchasesg"); //生成规则

                SemiPurchase spobj = SemiPurchase.find(purchasesg);

                spobj.getSemigoods(); ///规则规定的半成品
                spobj.getGoods(); ///规则规定的商品

                String rsgoods = SemiGoodsDetails.getSemiGoodsarr(teasession._strCommunity,purchase,2); //teasession.getParameter("rsgoods");半成品
                String rsgoods2 = GoodsDetails.getNodearr(teasession._strCommunity,purchase,2); //teasession.getParameter("rsgoods");成品

                //判断合成的成品是否与规则相同。
                String rsg2[] = rsgoods2.split("/");
                for(int i = 0;i < rsg2.length;i++)
                {
                    if(rsg2[i] != null && rsg2[i].length() > 0)
                    {
                        if(spobj.getGoods().indexOf(rsg2[i]) == -1)
                        {

                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("合成的成品不符合规则！","UTF-8") + "&nexturl=/jsp/erp/semi/SemiCatecargo.jsp");
                            return;
                        }
                    }
                }
                //判断合成的半成品是否与规则相同。
                String rsg1[] = rsgoods.replaceAll("//","/").split("/");
                String guize[] = spobj.getSemigoods().split("/");
                int j = 0;

                for(int i = 0;i < rsg1.length;i++)
                {
                    if(rsg1[i] != null && rsg1[i].length() > 0)
                    {
                        SemiSupplier ssobj = SemiSupplier.find(Integer.parseInt(rsg1[i]));

                        if(spobj.getSemigoods().indexOf(String.valueOf(ssobj.getSgid())) == -1)
                        {

                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("合成的半成品不符合规则！","UTF-8") + "&nexturl=/jsp/erp/semi/SemiCatecargo.jsp");
                            return;
                        } else
                        {
                            j++;
                        }
                    }
                }
                if(guize.length < (j + 1))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("合成的半成品不符合规则！","UTF-8") + "&nexturl=/jsp/erp/semi/SemiCatecargo.jsp");
                    return;
                }

                if(rsgoods != null && rsgoods.length() > 0) //半成品
                {
                    String rsarr[] = rsgoods.split("/");
                    for(int i = 1;i < rsarr.length;i++)
                    {
                        //修改详细表中的数量
                        SemiGoodsDetails.set(purchase,Integer.parseInt(rsarr[i]),teasession.getParameter("supply" + i),Integer.parseInt(teasession.getParameter("quantity" + i)),teasession.getParameter("total" + i),"",time_s,10,waridname);
                        //根据详细表中的 商品id 仓库 订单号原有
                        SemiGoodsDetails.setTime_s(purchase,time_s,waridname);
                    }
                }

                if(rsgoods2 != null && rsgoods2.length() > 0) //成品//添加详细列表
                {
                    String rsarr[] = rsgoods2.split("/");
                    sp1.append("/");
                    sp2.append("/");
                    for(int i = 1;i < rsarr.length;i++)
                    {
                        sp1.append(teasession.getParameter("quantitysg" + i)).append("/");
                        sp2.append(teasession.getParameter("totalsg" + i)).append("/");
                        GoodsDetails.set(purchase,Integer.parseInt(rsarr[i]),"","","",Integer.parseInt(teasession.getParameter("quantitysg" + i)),"","",time_s,10,waridname,"10");
                    }
                }

                String quantity = teasession.getParameter("quantitysg");
                String total = teasession.getParameter("totalsg");
                String member = teasession.getParameter("member");
                String remarks = teasession.getParameter("remarks");
                String rsarr[] = rsgoods.split("/");
                String rsarr2[] = rsgoods2.split("/");
                int goods = 0;
                String rs = null;
                //添加订单详细表  添加订单完成的成品表
                Purchase.create(purchase,supplname,waridname,sp1.toString(),sp2.toString(),quantity,total,time_s,member,teasession._strCommunity,remarks,rsgoods2,0,4);
                //添加库存表
                for(int i = 1;i < rsarr.length;i++) ///减少半成品的库存
                {
                    goods = Integer.parseInt(rsarr[i]);

                    if(SemiInventory.isGoods(teasession._strCommunity,goods,waridname)) //说明库存表中有这个商品
                    {
                        SemiInventory.setQuantity(teasession._strCommunity,goods,waridname,Integer.parseInt(teasession.getParameter("quantity" + i)),"-");
                    } else
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("半成品库存不足！","UTF-8") + "&nexturl=/jsp/erp/semi/SemiCatecargo.jsp");
                        return;
                    }
                }

                for(int i = 1;i < rsarr2.length;i++) ///增加成品的库存
                {
                    goods = Integer.parseInt(rsarr2[i]);

                    if(Inventory.isGoods(teasession._strCommunity,goods,waridname)) //说明库存表中有这个商品
                    {
                        OrdersBatch.create(purchase,goods,Integer.parseInt(teasession.getParameter("quantitysg" + i)),member,teasession._rv.toString(),teasession._strCommunity,time_s,10);
                        Inventory.setQuantity(teasession._strCommunity,goods,waridname,Integer.parseInt(teasession.getParameter("quantitysg" + i)),"+");
                    }
                }
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=/jsp/erp/semi/SemiCatecargo.jsp");
                return;

            }
            if(act.equals("EditSemiCatecargocai")) //成品拆分
            {
                int supplname = 0; //供货商
                if(teasession.getParameter("supplname") != null && teasession.getParameter("supplname").length() > 0)
                {
                    supplname = Integer.parseInt(teasession.getParameter("supplname"));
                }
                int waridname = 0;
                if(teasession.getParameter("waridname") != null && teasession.getParameter("waridname").length() > 0)
                {
                    waridname = Integer.parseInt(teasession.getParameter("waridname"));
                }
                Date time_s = new Date();
                if(teasession.getParameter("time_s") != null && teasession.getParameter("time_s").length() > 0)
                {
                    time_s = Purchase.sdf.parse(teasession.getParameter("time_s"));
                }
                StringBuffer sp1 = new StringBuffer();
                StringBuffer sp2 = new StringBuffer();

                String purchase = teasession.getParameter("purchase"); //半成品合成成品的订单号
                String purchasesg = teasession.getParameter("purchasesg"); //生成规则

                SemiPurchase spobj = SemiPurchase.find(purchasesg);

                String rsgoods = SemiGoodsDetails.getSemiGoodsarr(teasession._strCommunity,purchase,2); //teasession.getParameter("rsgoods");半成品
                String rsgoods2 = GoodsDetails.getNodearr(teasession._strCommunity,purchase,2); //teasession.getParameter("rsgoods");成品

                //判断合成的成品是否与规则相同。
                String rsg2[] = rsgoods2.split("/");
                for(int i = 0;i < rsg2.length;i++)
                {
                    if(rsg2[i] != null && rsg2[i].length() > 0)
                    {
                        if(spobj.getGoods().indexOf(rsg2[i]) == -1)
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("拆卸的成品不符合规则！","UTF-8") + "&nexturl=/jsp/erp/semi/SemiCatecargo.jsp");
                            return;
                        }
                    }
                }
                //判断合成的半成品是否与规则相同。
                String rsg1[] = rsgoods.replaceAll("//","/").split("/");
                String guize[] = spobj.getSemigoods().split("/");
                int j = 0;

                for(int i = 0;i < rsg1.length;i++)
                {
                    if(rsg1[i] != null && rsg1[i].length() > 0)
                    {
                        SemiSupplier ssobj = SemiSupplier.find(Integer.parseInt(rsg1[i]));

                        if(spobj.getSemigoods().indexOf(String.valueOf(ssobj.getSgid())) == -1)
                        {

                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("拆卸的半成品不符合规则！","UTF-8") + "&nexturl=/jsp/erp/semi/SemiCatecargo.jsp");
                            return;
                        } else
                        {
                            j++;
                        }
                    }
                }
                if(guize.length < (j + 1))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("拆卸的半成品不符合规则！","UTF-8") + "&nexturl=/jsp/erp/semi/SemiCatecargo.jsp");
                    return;
                }

                if(rsgoods != null && rsgoods.length() > 0) //半成品
                {
                    String rsarr[] = rsgoods.split("/");
                    for(int i = 1;i < rsarr.length;i++)
                    {
                        //修改详细表中的数量
                        SemiGoodsDetails.set(purchase,Integer.parseInt(rsarr[i]),teasession.getParameter("supply" + i),Integer.parseInt(teasession.getParameter("quantity" + i)),teasession.getParameter("total" + i),"",time_s,11,waridname);
                        //根据详细表中的 商品id 仓库 订单号原有
                        SemiGoodsDetails.setTime_s(purchase,time_s,waridname);
                    }
                }

                if(rsgoods2 != null && rsgoods2.length() > 0) //成品//添加详细列表
                {
                    String rsarr[] = rsgoods2.split("/");
                    sp1.append("/");
                    sp2.append("/");
                    for(int i = 1;i < rsarr.length;i++)
                    {
                        sp1.append(teasession.getParameter("quantitysg" + i)).append("/");
                        sp2.append(teasession.getParameter("totalsg" + i)).append("/");
                        GoodsDetails.set(purchase,Integer.parseInt(rsarr[i]),"","","",Integer.parseInt(teasession.getParameter("quantitysg" + i)),"","",time_s,11,waridname,"10");
                    }
                }

                String quantity = teasession.getParameter("quantitysg");
                String total = teasession.getParameter("totalsg");
                String member = teasession.getParameter("member");
                String remarks = teasession.getParameter("remarks");
                String rsarr[] = rsgoods.split("/");
                String rsarr2[] = rsgoods2.split("/");
                int goods = 0;

				int ccnum=0;
				if(teasession.getParameter("quantitysg")!=null && teasession.getParameter("quantitysg").length()>0)
				{
					ccnum=Integer.parseInt(teasession.getParameter("quantitysg"));
				}
                String rs = null;
                //添加订单详细表  添加订单完成的成品表
                Purchase.create(purchase,supplname,waridname,sp1.toString(),sp2.toString(),quantity,total,time_s,member,teasession._strCommunity,remarks,rsgoods2,4,4);
                //添加库存表
                for(int i = 1;i < rsarr.length;i++) ///增加半成品的库存
                {
                    goods = Integer.parseInt(rsarr[i]);

                    if(SemiInventory.isGoods(teasession._strCommunity,goods,waridname)) //说明库存表中有这个商品
                    {
                        OrdersBatch.create(purchase,goods,Integer.parseInt(teasession.getParameter("quantity" + i))*ccnum,member,teasession._rv.toString(),teasession._strCommunity,time_s,11);
						SemiInventory.setQuantity(teasession._strCommunity,goods,waridname,Integer.parseInt(teasession.getParameter("quantity" + i))*ccnum,"+");
                    } else
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("半成品库存不足！","UTF-8") + "&nexturl=/jsp/erp/semi/SemiCatecargo.jsp");
                        return;
                    }
                }

                for(int i = 1;i < rsarr2.length;i++) ///减少成品的库存
                {
                    goods = Integer.parseInt(rsarr2[i]);

                    if(Inventory.isGoods(teasession._strCommunity,goods,waridname)) //说明库存表中有这个商品
                    {
//                        OrdersBatch.create(purchase,goods,Integer.parseInt(teasession.getParameter("quantitysg" + i)),member,teasession._rv.toString(),teasession._strCommunity,time_s,11);
                        Inventory.setQuantity(teasession._strCommunity,goods,waridname,Integer.parseInt(teasession.getParameter("quantitysg" + i)),"-");
                    }
                }
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=/jsp/erp/semi/SemiCatecargo.jsp");
                return;

            }

            if(act.equals("EditSemiGoodsadd"))
            { //添加半成品
                int id = 0;
                if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("ids"));
                }
                String goodsnumber = null;
                if(teasession.getParameter("goodsnumber") != null && teasession.getParameter("goodsnumber").length() > 0)
                {
                    goodsnumber = teasession.getParameter("goodsnumber"); //商品编号 goodsnumber  ---node
                }
                String subject = teasession.getParameter("subject"); //商品名称 subject ---  Nodelayer
                BigDecimal supply = new BigDecimal("0"); //商品进货价 supply ---BuyPrice
                if(teasession.getParameter("supply") != null && teasession.getParameter("supply").length() > 0)
                {
                    supply = new BigDecimal(teasession.getParameter("supply"));
                }
                String measure = teasession.getParameter("measure"); //商品单位 measure ---Goods
                String spec = teasession.getParameter("spec"); //商品规格 spec ---Goods

                Date date = new Date();
                if(id == 0 && goodsnumber == null)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("请填写商品编号！","UTF-8") + "&nexturl=/jsp/erp/semi/EditSemiGoodsadd.jsp");
                }
                String info = teasession.getParameter("info");

                if(Node.isNumber(goodsnumber))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"商品编号已经存在，请重新输入！"),"UTF-8") + "&nexturl=/jsp/erp/semi/EditSemiGoodsadd.jsp");
                    return;
                }
                if(SemiGoods.isNumber(goodsnumber) && id == 0)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"商品编号已经存在，请重新输入！"),"UTF-8") + "&nexturl=/jsp/erp/semi/EditSemiGoodsadd.jsp");
                    return;
                }

                SemiGoods.set(id,goodsnumber,subject,supply,measure,spec,teasession._strCommunity,teasession._rv.toString(),date,info);
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=/jsp/erp/semi/SemiGoodsadd.jsp");
                return;
            }
            if(act.equals("EditSemiGoods"))
            {
                //审核时候同样和不同意的标示 noyestype 1同意 0 不同意
                int noyestype = 0;
                if(teasession.getParameter("noyestype") != null && teasession.getParameter("noyestype").length() > 0)
                {
                    noyestype = Integer.parseInt(teasession.getParameter("noyestype"));
                }

                //添加半成品采购单，第一部分
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
                Date time_s = new Date();
                if(teasession.getParameter("time_s") != null && teasession.getParameter("time_s").length() > 0)
                {
                    time_s = Purchase.sdf.parse(teasession.getParameter("time_s"));
                }
                StringBuffer sp1 = new StringBuffer();
                StringBuffer sp2 = new StringBuffer();
                String purchase = teasession.getParameter("purchase");
                String rsgoods = SemiGoodsDetails.getSemiGoodsarr(teasession._strCommunity,purchase,2); //teasession.getParameter("rsgoods");
//                int quantity2 = 0; //剩余数量quantity2,quantity22
                int quantity22 = 0; //采购商品数量
                if(rsgoods != null && rsgoods.length() > 0)
                {
                    String rsarr[] = rsgoods.split("/");
                    sp1.append("/");
                    sp2.append("/");
                    for(int i = 1;i < rsarr.length;i++)
                    {
                        sp1.append(teasession.getParameter("quantity" + i)).append("/"); //数量
                        sp2.append(teasession.getParameter("total" + i)).append("/"); //总金额
                        SemiGoodsDetails.set(purchase,Integer.parseInt(rsarr[i]),teasession.getParameter("supply" + i),Integer.parseInt(teasession.getParameter("quantity" + i)),teasession.getParameter("total" + i),"",time_s,2,waridname);
                    }
                }
                String quantity = teasession.getParameter("quantity");
                String total = teasession.getParameter("total");
                String member = teasession.getParameter("member");
                String remarks = teasession.getParameter("remarks");
                String rsarr[] = rsgoods.split("/");
                int goods = 0;
                String rs = null;
                int flowtype = 0;
                if(teasession.getParameter("flowtype") != null && teasession.getParameter("flowtype").length() > 0)
                {
                    flowtype = Integer.parseInt(teasession.getParameter("flowtype"));

                }
                SemiGoodsDetails.setTime_s(purchase,time_s);
                if(pobj.isExists()) //修改
                {
//					if(flowtype>1)
//					{
//						quantity= pobj.getQuantity();
//					}
                    pobj.set(supplname,waridname,sp1.toString(),sp2.toString(),quantity,total,time_s,member,teasession._strCommunity,remarks,rsgoods,1);
                    if(flowtype == 1) //表示审核
                    {
                        if(noyestype == 1) //同意
                        {
                            pobj.setFlowType(flowtype);
                            //添加实际采购数量
                            SemiGoodsDetails.setQuantity22(purchase);
                        } else
                        {
                            pobj.delete();
                        }
                    } else if(flowtype == 2) //已审核，未到货 审核入库商品
                    {
                        //添加入库的商品和数量
                        java.util.Enumeration e = SemiGoodsDetails.find(teasession._strCommunity," and  paid=" + DbAdapter.cite(purchase),0,Integer.MAX_VALUE);
                        while(e.hasMoreElements())
                        {
                            int gdid = ((Integer) e.nextElement()).intValue();
                            SemiGoodsDetails gdobj = SemiGoodsDetails.find(gdid);
                            SemiSupplier ssobg = SemiSupplier.find(gdobj.getSgid());
                            BigDecimal bb = new BigDecimal("0");
                            if(gdobj.getSupply() != null && gdobj.getSupply().length() > 0)
                            {
                                bb = new BigDecimal(gdobj.getSupply());
                            }

                            OrdersBatch.createSemi(gdobj.getPaid(),gdobj.getSgid(),gdobj.getQuantity(),member,teasession._rv.toString(),teasession._strCommunity,time_s,9,ssobg.getSgid(),bb);
                            //剩余数量计算
                            int quan = gdobj.getQuantity22() - gdobj.getQuantity();
                            gdobj.setQuantity2(quan);
                            //添加库存

                            if(SemiInventory.isGoods(teasession._strCommunity,gdobj.getSgid(),waridname))
                            {
                                SemiInventory.subtractTotal("ture",teasession._strCommunity,ssobg.getSgid(),waridname,gdobj.getQuantity(),gdobj.getTotal());
                            } else
                            {
                                SemiInventory.setQuantity(teasession._strCommunity,ssobg.getSgid(),waridname,gdobj.getQuantity(),ssobg.getSgid());
                            }

                        }
                        //判断如果没有了剩余商品 ，说明商品全部到货
                        if(!SemiGoodsDetails.isQuantity2(purchase))
                        {
                            pobj.setFlowType(4);
                        } else
                        {
                            pobj.setFlowType(flowtype);
                        }

                    } else if(flowtype == 3) //添加剩余的商品入库
                    {
                        java.util.Enumeration e = SemiGoodsDetails.find(teasession._strCommunity," and quantity2!=0 and  paid=" + DbAdapter.cite(purchase),0,Integer.MAX_VALUE);

                        for(int i = 1;e.hasMoreElements();i++)
                        {
                            int quantity2 = 0; //获取的剩余数量
                            if(teasession.getParameter("quantity" + i) != null && teasession.getParameter("quantity" + i).length() > 0)
                            {
                                quantity2 = Integer.parseInt(teasession.getParameter("quantity" + i));
                            }
                            int quantitydd = 0;
                            if(teasession.getParameter("quantitydd" + i) != null && teasession.getParameter("quantitydd" + i).length() > 0)
                            {
                                quantitydd = Integer.parseInt(teasession.getParameter("quantitydd" + i));
                            }

                            int gdid = ((Integer) e.nextElement()).intValue();
                            SemiGoodsDetails gdobj = SemiGoodsDetails.find(gdid);
                            SemiSupplier ssobg = SemiSupplier.find(gdobj.getSgid());
                            BigDecimal bb = new BigDecimal("0");
                            if(gdobj.getSupply() != null && gdobj.getSupply().length() > 0)
                            {
                                bb = new BigDecimal(gdobj.getSupply());
                            }
                            OrdersBatch.createSemi(gdobj.getPaid(),gdobj.getSgid(),gdobj.getQuantity(),member,teasession._rv.toString(),teasession._strCommunity,time_s,9,ssobg.getSgid(),bb);
                            //剩余数量计算
                            int quan = gdobj.getQuantity22() - quantitydd - quantity2;
                            gdobj.setQuantity2(quan);
                            //修改进货数量
                            gdobj.setQuantity(quantitydd + quantity2);
                            //添加库存
                            SemiInventory.setQuantity(teasession._strCommunity,ssobg.getSgid(),waridname,quantity2,ssobg.getSgid());
                        }
                        //判断如果没有了剩余商品 ，说明商品全部到货
                        if(!SemiGoodsDetails.isQuantity2(purchase))
                        {
                            pobj.setFlowType(4);
                        }
                        //修改采购单中的总金额和数量
                        int q = Integer.parseInt(pobj.getQuantity()) + Integer.parseInt(quantity);
                        java.math.BigDecimal t = new java.math.BigDecimal(pobj.getTotal()).subtract(new java.math.BigDecimal(total));
                        pobj.setQuantityTotal(String.valueOf(q),String.valueOf(t));
                    }
                } else
                {
                    Purchase.create(purchase,supplname,waridname,sp1.toString(),sp2.toString(),quantity,total,time_s,member,teasession._strCommunity,remarks,rsgoods,1,0);
                }
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
