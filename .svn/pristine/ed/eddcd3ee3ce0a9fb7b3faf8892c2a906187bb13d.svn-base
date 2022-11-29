package tea.ui.admin.erp;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;


import java.util.*;
import java.net.*;
import tea.ui.*;
import tea.entity.admin.cebbank.*;
import java.math.*;
import jxl.write.*;
import tea.entity.admin.sales.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import tea.entity.league.*;
import tea.entity.util.*;
import tea.entity.admin.erp.*;
import tea.entity.node.*;
import tea.db.*;
import jxl.format.UnderlineStyle;
import jxl.format.Colour;
import tea.entity.admin.orthonline.*;



public class ExportExcel extends TeaServlet
{
	public void init(ServletConfig servletconfig) throws ServletException
	{
	   super.init(servletconfig);
		super.r.add("/tea/resource/Annuity");
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// response.setHeader("Expires", "0");
		// response.setHeader("Cache-Control", "no-cache");
		// response.setHeader("Pragma", "no-cache");

		request.setCharacterEncoding("UTF-8");

		TeaSession teasession = new TeaSession(request);

		String sql = request.getParameter("sql");
		String files = request.getParameter("files");
		String act = teasession.getParameter("act");

		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(files + ".xls", "UTF-8"));
		javax.servlet.ServletOutputStream os = response.getOutputStream();
		try
		{
			jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
			jxl.write.WritableSheet ws = wwb.createSheet(files, 0);


            //设置字体
            WritableFont font = new WritableFont(WritableFont.ARIAL,10,WritableFont.BOLD,false,UnderlineStyle.NO_UNDERLINE,Colour.BLACK);
            WritableCellFormat cFormat = new WritableCellFormat(font);


			int i = 0,j=0;
			if("CaseCollection".equals(act))
			{

                ws.addCell(new jxl.write.Label(j++,0,"加盟店名称"));
                ws.addCell(new jxl.write.Label(j++,0,"所属区域"));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店类型"));
                ws.addCell(new jxl.write.Label(j++,0,"会员消费笔数"));
                ws.addCell(new jxl.write.Label(j++,0,"非会员消费笔数"));
                ws.addCell(new jxl.write.Label(j++,0,"会员消费金额"));
                ws.addCell(new jxl.write.Label(j++,0,"非会员消费金额"));
                java.util.Enumeration e = CaseCollection.findByCommunity(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
                while(e.hasMoreElements())
                {
                    int lsid = ((Integer) e.nextElement()).intValue();
                    LeagueShop leobj = LeagueShop.find(lsid);
                    Card card1 = Card.find(leobj.getProvince());
                    Card card2 = Card.find(leobj.getCity());
                    LeagueShopType objty = LeagueShopType.find(leobj.getLsstype());

                    ws.addCell(new jxl.write.Label(0,i + 1,leobj.getLsname()));
                    ws.addCell(new jxl.write.Label(1,i + 1,LeagueShop.CSAREA[leobj.getCsarea()] + card1.getAddress() + card2.getAddress()));
                    ws.addCell(new jxl.write.Label(2,i + 1,objty.getLstypename()));
                    ws.addCell(new jxl.write.Label(3,i + 1,String.valueOf(ICSalesList.getMemberTotal(lsid,"  and ic.icard!=''"))));
                    ws.addCell(new jxl.write.Label(4,i + 1,String.valueOf(ICSalesList.getSQLB(lsid,"count(distinct(ic.icsales)) "," and ics.icard!=''"))));
                    ws.addCell(new jxl.write.Label(5,i + 1,String.valueOf(ICSalesList.getJiE(lsid," sum(ic.price) "," and ics.icard!=''"))));
                    ws.addCell(new jxl.write.Label(6,i + 1,String.valueOf(ICSalesList.getJiE(lsid," sum(ic.price) "," and ics.icard  is null "))));
                    i++;
                }

			}
			if ("SalesStatistics".equals(act)) //我的任务
			{
                ws.addCell(new jxl.write.Label(0,0,"加盟店名称"));
                ws.addCell(new jxl.write.Label(1,0,"所属区域"));
                ws.addCell(new jxl.write.Label(2,0,"加盟店类型"));
                ws.addCell(new jxl.write.Label(3,0,"会员消费笔数"));
                ws.addCell(new jxl.write.Label(4,0,"非会员消费笔数"));
                ws.addCell(new jxl.write.Label(5,0,"会员消费金额"));
                ws.addCell(new jxl.write.Label(6,0,"非会员消费金额"));
                java.util.Enumeration e = LeagueShop.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
				while (e.hasMoreElements())
				{
                    int lsid = ((Integer) e.nextElement()).intValue();
                    LeagueShop leobj = LeagueShop.find(lsid);
                    Card card1 = Card.find(leobj.getProvince());
                    Card card2 = Card.find(leobj.getCity());
                    LeagueShopType objty = LeagueShopType.find(leobj.getLsstype());

					ws.addCell(new jxl.write.Label(0, i + 1, leobj.getLsname()));
					ws.addCell(new jxl.write.Label(1, i + 1, LeagueShop.CSAREA[leobj.getCsarea()]+card1.getAddress()+card2.getAddress()));
					ws.addCell(new jxl.write.Label(2, i + 1, objty.getLstypename()));
					ws.addCell(new jxl.write.Label(3, i + 1, String.valueOf(ICSalesList.getMemberTotal(lsid,"  and ic.icard!=''"))));
					ws.addCell(new jxl.write.Label(4, i + 1, String.valueOf(ICSalesList.getSQLB(lsid,"count(distinct(ic.icsales)) "," and ics.icard!=''") )));
					ws.addCell(new jxl.write.Label(5, i + 1, String.valueOf(ICSalesList.getJiE(lsid," sum(ic.price) "," and ics.icard!=''"))));
					ws.addCell(new jxl.write.Label(6, i + 1, String.valueOf(ICSalesList.getJiE(lsid," sum(ic.price) "," and ics.icard  is null "))));
					i++;
				}
			} else if("SalesMonitor".equals(act))//加盟店销售情况监测
			{
				ws.addCell(new jxl.write.Label(0,0,"消费单号"));
				ws.addCell(new jxl.write.Label(1,0,"会员名称"));
				ws.addCell(new jxl.write.Label(2,0,"消费卡号"));
				ws.addCell(new jxl.write.Label(3,0,"消费商品数量"));
				ws.addCell(new jxl.write.Label(4,0,"消费总金额"));

				java.util.Enumeration e =ICSales.findIcsales(sql.toString(),0,Integer.MAX_VALUE);
				while (e.hasMoreElements())
				{
                    String icid = ((String) e.nextElement());
                    ICSales icobj = ICSales.find(icid);
					tea.entity.member.Profile pobj = tea.entity.member.Profile.find(ICSales.getIcMember(icid));
					ws.addCell(new jxl.write.Label(0, i + 1, icid));
					ws.addCell(new jxl.write.Label(1, i + 1,pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)));
					ws.addCell(new jxl.write.Label(2, i + 1, ICSales.getIcMember(icid)));
					ws.addCell(new jxl.write.Label(3, i + 1, String.valueOf(icobj.getQuantity())));
					ws.addCell(new jxl.write.Label(4, i + 1, String.valueOf(icobj.getPrice())));
					i++;
				}
			} else if("GoodsStatistics".equals(act))//加盟店商品销售情况统计
			{
				ws.addCell(new jxl.write.Label(0,0,"条形码或编号"));
				ws.addCell(new jxl.write.Label(1,0,"商品名称"));
				ws.addCell(new jxl.write.Label(2,0,"商品类别"));
				ws.addCell(new jxl.write.Label(3,0,"商品品牌"));
				ws.addCell(new jxl.write.Label(4,0,"消费数量"));
				ws.addCell(new jxl.write.Label(5,0,"消费金额"));


                java.util.Enumeration e = ICSalesList.findNo(sql.toString(),0,Integer.MAX_VALUE);
                while(e.hasMoreElements())
                {
                    String nuid = ((String) e.nextElement());
                    int nid = Node.findNumber(teasession._strCommunity,nuid);
                    Node nobj = Node.find(nid);
                    Goods gobj = Goods.find(nid);
                    String gts[] = gobj.getGoodstype().split("/");
                    StringBuffer sp = new StringBuffer();
                    for(int index = 2;index < gts.length;index++)
                    {
                        GoodsType gtobj = GoodsType.find(Integer.parseInt(gts[index]));
                        sp.append(gtobj.getName(teasession._nLanguage) + "\r\n\r\n");
                    }
                    Commodity cobj = Commodity.find_goods(nid);
                    BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
                    Brand b = null;
					String btri = null;
                    if(gobj.getBrand() > 0 && (b = Brand.find(gobj.getBrand())).isExists())
                    {
                        if(b.getNode() > 0)
                            btri=(b.getName(teasession._nLanguage));
                    }
					ws.addCell(new jxl.write.Label(0, i + 1, nuid));
					ws.addCell(new jxl.write.Label(1, i + 1,nobj.getSubject(teasession._nLanguage)));
					ws.addCell(new jxl.write.Label(2, i + 1, sp.toString()));
					ws.addCell(new jxl.write.Label(3, i + 1, btri));
					ws.addCell(new jxl.write.Label(4, i + 1, String.valueOf(ICSalesList.getNoTotal(nuid))));
					ws.addCell(new jxl.write.Label(5, i + 1, String.valueOf(ICSalesList.getPriceTotal(nuid))));
					i++;

                }
			} else if("ShopMember".equals(act))//加盟店会员信息
			{
				ws.addCell(new jxl.write.Label(0,0,"会员卡号"));
				ws.addCell(new jxl.write.Label(1,0,"会员名称"));
				ws.addCell(new jxl.write.Label(2,0,"性别"));
				ws.addCell(new jxl.write.Label(3,0,"加盟店名称"));
				ws.addCell(new jxl.write.Label(4,0,"入会日期"));
				ws.addCell(new jxl.write.Label(5,0,"手机号"));  

			  java.util.Enumeration e = Profile.findByCommunity(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
				while (e.hasMoreElements())
				{
                    String memberid = ((String) e.nextElement());
                    Profile pobj = Profile.find(memberid);
                    
					String s = null;
                    LeagueShop lsobj = LeagueShop.find(pobj.getAgent());
					if(pobj.isSex())
					{
						s="男";
					}
					else{
						s="女";
					}
					ws.addCell(new jxl.write.Label(0, i + 1, memberid));
					ws.addCell(new jxl.write.Label(1, i + 1,pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)));
					ws.addCell(new jxl.write.Label(2, i + 1, s));
					ws.addCell(new jxl.write.Label(3, i + 1, lsobj.getLsname()));
					ws.addCell(new jxl.write.Label(4, i + 1, pobj.getTimeToString()));
					ws.addCell(new jxl.write.Label(5, i + 1, pobj.getMobile()));
					i++;
				}

			} else if("InventoryWarning".equals(act))//加盟店商品库存预警表
			{
                ws.addCell(new jxl.write.Label(0,0,"条形码或编号"));
                ws.addCell(new jxl.write.Label(1,0,"商品名称"));
                ws.addCell(new jxl.write.Label(2,0,"加盟店名称"));
                ws.addCell(new jxl.write.Label(3,0,"所属区域"));
                ws.addCell(new jxl.write.Label(4,0,"加盟店类型"));
                ws.addCell(new jxl.write.Label(5,0,"预警商品数量"));

				 java.util.Enumeration e = ICInventory.find(sql.toString(),0,Integer.MAX_VALUE);
                while(e.hasMoreElements())
                {
                    int icid = ((Integer) e.nextElement()).intValue();
                    ICInventory icobj = ICInventory.find(icid);
                    Node nobj = Node.find(icobj.getNode());
                    LeagueShop leobj = LeagueShop.find(icobj.getLeagueshop());
                    Card card1 = Card.find(leobj.getProvince());
                    Card card2 = Card.find(leobj.getCity());
                    LeagueShopType objty = LeagueShopType.find(leobj.getLstype());

                    ws.addCell(new jxl.write.Label(0,i + 1,nobj.getNumber() ));
                    ws.addCell(new jxl.write.Label(1,i + 1,nobj.getSubject(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(2,i + 1,leobj.getLsname() ));
                    ws.addCell(new jxl.write.Label(3,i + 1,LeagueShop.CSAREA[leobj.getCsarea()]+card1.getAddress()+card2.getAddress()));
                    ws.addCell(new jxl.write.Label(4,i + 1,objty.getLstypename()));
                    ws.addCell(new jxl.write.Label(5,i + 1,String.valueOf(icobj.getQuantity() )));
                    i++;
                }
			} else if("InventorySta".equals(act))
			{
                int radioname = 1;
                if(teasession.getParameter("radioname") != null)
                {
                    radioname = Integer.parseInt(teasession.getParameter("radioname"));
                }
				if(radioname==1)//按加盟店
				{
                    ws.addCell(new jxl.write.Label(0,0,"加盟店名称"));
                    ws.addCell(new jxl.write.Label(1,0,"所属区域"));
                    ws.addCell(new jxl.write.Label(2,0,"加盟店类型"));
                    ws.addCell(new jxl.write.Label(3,0,"库存"));

					 java.util.Enumeration e = ICInventory.findLeagueshop(" ic.leagueshop ",sql.toString(),0,Integer.MAX_VALUE);
                    while(e.hasMoreElements())
                    {
                        int leid = ((Integer) e.nextElement()).intValue();
                        LeagueShop leobj = LeagueShop.find(leid);
                        Card card1 = Card.find(leobj.getProvince());
                        Card card2 = Card.find(leobj.getCity());
                        LeagueShopType objty = LeagueShopType.find(leobj.getLstype());


                        ws.addCell(new jxl.write.Label(0,i + 1,leobj.getLsname()));
                        ws.addCell(new jxl.write.Label(1,i + 1,LeagueShop.CSAREA[leobj.getCsarea()]+card1.getAddress()+card2.getAddress()));
                        ws.addCell(new jxl.write.Label(2,i + 1,objty.getLstypename()));
                        ws.addCell(new jxl.write.Label(3,i + 1,String.valueOf(ICInventory.getLeQuantity("leagueshop",leid))));
                        i++;
                    }

				} else if(radioname==2)//按商品
				{
                    ws.addCell(new jxl.write.Label(0,0,"条形码或编号"));
                    ws.addCell(new jxl.write.Label(1,0,"商品名称"));
                    ws.addCell(new jxl.write.Label(2,0,"商品类别"));
                    ws.addCell(new jxl.write.Label(3,0,"库存"));

                    java.util.Enumeration e2 = ICInventory.findLeagueshop(" ic.node ",sql.toString(),0,Integer.MAX_VALUE);
                    while(e2.hasMoreElements())
                    {
                        int nid = ((Integer) e2.nextElement()).intValue();
                        Node nobj = Node.find(nid);
                        Goods gobj = Goods.find(nid);
                        String gts[] = gobj.getGoodstype().split("/");
                        StringBuffer sp = new StringBuffer();
                        for(int index = 2;index < gts.length;index++)
                        {
                            GoodsType gtobj = GoodsType.find(Integer.parseInt(gts[index]));
                            sp.append(gtobj.getName(teasession._nLanguage) + "&nbsp;&nbsp;");
                        }

                        ws.addCell(new jxl.write.Label(0,i + 1,nobj.getNumber()));
                        ws.addCell(new jxl.write.Label(1,i + 1,nobj.getSubject(teasession._nLanguage)));
                        ws.addCell(new jxl.write.Label(2,i + 1,sp.toString()));
                        ws.addCell(new jxl.write.Label(3,i + 1,String.valueOf(ICInventory.getLeQuantity("node",nid))));
                        i++;
                    }

				}

			} else if("PaidinfullPrint".equals(act))//导出销售单
			{
                Paidinfull pobj = Paidinfull.find(sql.toString());
                tea.entity.member.Profile p = tea.entity.member.Profile.find(pobj.getMember());
                LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());
                String m = "";
                if(pobj.getMember() != null)
                {
                    tea.entity.member.Profile p2 = tea.entity.member.Profile.find(pobj.getMember());
                    m = (p2.getLastName(teasession._nLanguage) + p2.getFirstName(teasession._nLanguage));
                }

                //
                ws.addCell(new jxl.write.Label(0,0,"入单日期",cFormat));
                ws.addCell(new jxl.write.Label(1,0,pobj.getTime_sToString()));
                ws.addCell(new jxl.write.Label(2,0,"单据编号",cFormat));
                ws.addCell(new jxl.write.Label(3,0,sql.toString()));
                ws.addCell(new jxl.write.Label(4,0,"发货仓库",cFormat));
                ws.addCell(new jxl.write.Label(5,0,Warehouse.find(pobj.getWaridname()).getWarname()));
                ws.addCell(new jxl.write.Label(0,1,"经办人",cFormat));
                ws.addCell(new jxl.write.Label(1,1,p.getLastName(teasession._nLanguage) + p.getFirstName(teasession._nLanguage)));
                ws.addCell(new jxl.write.Label(2,1,"购买单位",cFormat));
                ws.addCell(new jxl.write.Label(3,1,lsobj.getLsname()));
                ws.addCell(new jxl.write.Label(4,1,"联系方式",cFormat));
                ws.addCell(new jxl.write.Label(5,1,pobj.getTelephone()));
                ws.addCell(new jxl.write.Label(0,2,"联系人",cFormat));
                ws.addCell(new jxl.write.Label(1,2,m));
                ws.addCell(new jxl.write.Label(2,2,"联系地址",cFormat));
                ws.addCell(new jxl.write.Label(3,2,pobj.getAddress()));

	//////////

                ws.addCell(new jxl.write.Label(0,3,"条形码或编号",cFormat));
                ws.addCell(new jxl.write.Label(1,3,"商品名称",cFormat));
                ws.addCell(new jxl.write.Label(2,3,"规格型号",cFormat));
                ws.addCell(new jxl.write.Label(3,3,"商品单位",cFormat));
				ws.addCell(new jxl.write.Label(4,3,"商品单价",cFormat));
				ws.addCell(new jxl.write.Label(5,3,"商品折扣",cFormat));
				ws.addCell(new jxl.write.Label(6,3,"折后单价",cFormat));
				ws.addCell(new jxl.write.Label(7,3,"商品数量",cFormat));
				ws.addCell(new jxl.write.Label(8,3,"商品金额",cFormat));
				ws.addCell(new jxl.write.Label(9,3,"商品备注",cFormat));


                java.util.Enumeration e2 = GoodsDetails.find(teasession._strCommunity," AND time_s  is not  null AND paid=" + DbAdapter.cite(sql.toString()),0,Integer.MAX_VALUE);
                while(e2.hasMoreElements())
                {
                    int gdid = ((Integer) e2.nextElement()).intValue();
                    GoodsDetails gdobj = GoodsDetails.find(gdid);
                    int nid = gdobj.getNode();
                    Node nobj = Node.find(nid);
                    Goods gobj = Goods.find(nid);

                    ws.addCell(new jxl.write.Label(0,i + 4,nobj.getNumber()));
                    ws.addCell(new jxl.write.Label(1,i + 4,nobj.getSubject(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(2,i + 4,gobj.getSpec(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(3,i + 4,gobj.getMeasure(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(4,i + 4,gdobj.getSupply()));
                    ws.addCell(new jxl.write.Label(5,i + 4,gdobj.getDiscount()));
                    ws.addCell(new jxl.write.Label(6,i + 4,gdobj.getDsupply()));
                    ws.addCell(new jxl.write.Label(7,i + 4,String.valueOf(gdobj.getQuantity())));
                    ws.addCell(new jxl.write.Label(8,i + 4,gdobj.getTotal()));
                    ws.addCell(new jxl.write.Label(9,i + 4,gdobj.getRemarksarr()));

                    i++;
                }

                ws.addCell(new jxl.write.Label(4,i + 4,"折前金额",cFormat));
                ws.addCell(new jxl.write.Label(5,i + 4,pobj.getTotal()));
                ws.addCell(new jxl.write.Label(6,i + 4,"折后数量和金额",cFormat));
                ws.addCell(new jxl.write.Label(7,i + 4,String.valueOf(pobj.getQuantity())));
                ws.addCell(new jxl.write.Label(8,i + 4,pobj.getTotal_2()));


			}else if("Inventory".equals(act))//库存统计导出
			{
                ws.addCell(new jxl.write.Label(0,0,"仓库名称",cFormat));
                ws.addCell(new jxl.write.Label(1,0,"商品名称",cFormat));
                ws.addCell(new jxl.write.Label(2,0,"商品品牌",cFormat));
                ws.addCell(new jxl.write.Label(3,0,"商品规格",cFormat));
                ws.addCell(new jxl.write.Label(4,0,"商品单价",cFormat));
                ws.addCell(new jxl.write.Label(5,0,"库存数量",cFormat));
                ws.addCell(new jxl.write.Label(6,0,"商品总价",cFormat));

			 java.util.Enumeration e = Inventory.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
			   while(e.hasMoreElements())
			   {
                   int invid = ((Integer) e.nextElement()).intValue();
                   Inventory iobj = Inventory.find(invid);
                   Warehouse warobj = Warehouse.find(iobj.getWarname());
                   Node nobj = Node.find(iobj.getGoods());

                   Goods g = Goods.find(iobj.getGoods());
                   Commodity cobj = Commodity.find_goods(iobj.getGoods());
                   BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
				   String br =null;
                   Brand b = Brand.find(g.getBrand());
                  


                   ws.addCell(new jxl.write.Label(0,i + 1,warobj.getWarname()));
                   ws.addCell(new jxl.write.Label(1,i + 1,nobj.getSubject(teasession._nLanguage)));
                   ws.addCell(new jxl.write.Label(2,i + 1,b.getName(teasession._nLanguage)));
                   ws.addCell(new jxl.write.Label(3,i + 1,g.getSpec(teasession._nLanguage) ));
                   ws.addCell(new jxl.write.Label(4,i + 1,String.valueOf(bpobj.getPrice())));
                   ws.addCell(new jxl.write.Label(5,i + 1,String.valueOf(iobj.getQuantity())));
                   ws.addCell(new jxl.write.Label(6,i + 1,String.valueOf(iobj.setInvenTotal(teasession._strCommunity,iobj.getGoods(),iobj.getWarname()))));

                   i++;
			   }

			}else if("Goods".equals(act))//商品导出
			{
                ws.addCell(new jxl.write.Label(0,0,"编号",cFormat));//
				ws.addCell(new jxl.write.Label(1,0,"条形码",cFormat));
                ws.addCell(new jxl.write.Label(2,0,"商品名称",cFormat));
                ws.addCell(new jxl.write.Label(3,0,"商品类别",cFormat));
                ws.addCell(new jxl.write.Label(4,0,"商品品牌",cFormat));
                ws.addCell(new jxl.write.Label(5,0,"商品单位",cFormat));
                ws.addCell(new jxl.write.Label(6,0,"商品规格",cFormat));
                ws.addCell(new jxl.write.Label(7,0,"使用类型",cFormat));
                ws.addCell(new jxl.write.Label(8,0,"商品供货商",cFormat));
                ws.addCell(new jxl.write.Label(9,0,"库存数量",cFormat));
                ws.addCell(new jxl.write.Label(10,0,"进货价",cFormat));
                ws.addCell(new jxl.write.Label(11,0,"供货价",cFormat));
                ws.addCell(new jxl.write.Label(12,0,"销售价",cFormat));
                ws.addCell(new jxl.write.Label(13,0,"商品所在位置",cFormat));
                ws.addCell(new jxl.write.Label(14,0,"商品内容",cFormat));
               // ws.addCell(new jxl.write.Label(13,0,"小图片",cFormat));
               // ws.addCell(new jxl.write.Label(14,0,"大图片",cFormat));
               // ws.addCell(new jxl.write.Label(15,0,"ID号",cFormat));
//                java.util.Enumeration aEnumeration=Attribute.findByGoodstype(4237);
//                int id=0;
//                int ai=16;
//                while(aEnumeration.hasMoreElements())
//                {
//                  id=((Integer)aEnumeration.nextElement()).intValue();
//                  tea.entity.node.Attribute atobj=tea.entity.node.Attribute.find(id);
//                  ws.addCell(new jxl.write.Label(ai,0,atobj.getName(teasession._nLanguage),cFormat));
//                  ai++;
//                }

				java.util.Enumeration  e = Node.find(teasession._strCommunity,sql.toString(),0,5000);
				//System.out.println(sql.toString());
				for(int is =1;e.hasMoreElements();is++){
                    int nid = ((Integer) e.nextElement()).intValue();
                    Node nobj = Node.find(nid);
                    Goods gobj = Goods.find(nid);
                    String gts[] = gobj.getGoodstype().split("/");
                    StringBuffer sp = new StringBuffer("/");
                    for(int index = 2;index < gts.length;index++)
                    {
                        GoodsType gtobj = GoodsType.find(Integer.parseInt(gts[index]));
                        sp.append(gtobj.getName(teasession._nLanguage) + "/");
                    }
					String brs = null;
                    Brand b = null;
                    if(gobj.getBrand() > 0 && (b = Brand.find(gobj.getBrand())).isExists())
                    {
                        if(b.getNode() > 0){
                            brs = (b.getName(teasession._nLanguage));
                        }
                    }
					String useds = null;
					if(gobj.getUsed()==1)
					{
						useds = "前台展示";
					}else if(gobj.getUsed()==2)
					{
						useds = "卡管理使用";
					}
                    Commodity cobj = Commodity.find_goods(nid);

                    tea.entity.admin.Supplier sobj = tea.entity.admin.Supplier.find(cobj.getSupplier());
                    BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
                   // System.out.println(is+nobj.getText(teasession._nLanguage));
                    ws.addCell(new jxl.write.Label(0,i + 1,nobj.getNumber()));
					ws.addCell(new jxl.write.Label(1,i + 1,gobj.getBarcode()));
                    ws.addCell(new jxl.write.Label(2,i + 1,nobj.getSubject(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(3,i + 1,sp.toString()));
                    ws.addCell(new jxl.write.Label(4,i + 1,brs));
                    ws.addCell(new jxl.write.Label(5,i + 1,gobj.getMeasure(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(6,i + 1,gobj.getSpec(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(7,i + 1,useds));
                    ws.addCell(new jxl.write.Label(8,i + 1,sobj.getName(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(9,i + 1,String.valueOf(cobj.getMinQuantity())));
                    ws.addCell(new jxl.write.Label(10,i + 1,String.valueOf(bpobj.getList())));
                    ws.addCell(new jxl.write.Label(11,i + 1,String.valueOf(bpobj.getSupply())));
                    ws.addCell(new jxl.write.Label(12,i + 1,String.valueOf(bpobj.getPrice())));
                    ws.addCell(new jxl.write.Label(13,i + 1,String.valueOf(nobj.getFather())));
                    ws.addCell(new jxl.write.Label(14,i + 1,nobj.getText(teasession._nLanguage)));
                   // ws.addCell(new jxl.write.Label(13,i + 1,gobj.getSmallpicture(teasession._nLanguage)));
                   // ws.addCell(new jxl.write.Label(14,i + 1,gobj.getBigpicture(teasession._nLanguage)));
                 //   ws.addCell(new jxl.write.Label(15,i + 1,String.valueOf(nid)));
//                    int safda = 16;
//                    java.util.Enumeration aa2=Attribute.findByGoodstype(4237);
//                    while(aa2.hasMoreElements())
//                    {
//                      int sssssid=((Integer)aa2.nextElement()).intValue();
//
//                      AttributeValue av = AttributeValue.find(nid, sssssid);
//                      System.out.println(sssssid);
//                      ws.addCell(new jxl.write.Label(safda,i + 1,av.getAttrvalue(teasession._nLanguage)));
//                      safda++;
//                    }

                    i++;
                }
			}else if ("PuGoodsStatis".equals(act))//采购单商品销售情况统计
			{
				ws.addCell(new jxl.write.Label(0,0,"序号",cFormat));
                ws.addCell(new jxl.write.Label(1,0,"条形码或编号",cFormat));
                ws.addCell(new jxl.write.Label(2,0,"商品名称",cFormat));
                ws.addCell(new jxl.write.Label(3,0,"商品类别",cFormat));
                ws.addCell(new jxl.write.Label(4,0,"商品品牌",cFormat));
                ws.addCell(new jxl.write.Label(5,0,"消费数量",cFormat));
                ws.addCell(new jxl.write.Label(6,0,"消费金额",cFormat));

                java.util.Enumeration e = GoodsDetails.findPurNode(teasession._strCommunity,"Purchase",sql.toString(),0,Integer.MAX_VALUE); // ICSalesList.findNo(sql.toString(),pos,pageSize);
                for(int js=1 ;e.hasMoreElements();js++)
                {
                    int nid = ((Integer) e.nextElement()).intValue();

                    Node nobj = Node.find(nid);
                    Goods gobj = Goods.find(nid);
                    String gts[] = gobj.getGoodstype().split("/");
                    StringBuffer sp = new StringBuffer();
                    for(int index = 2;index < gts.length;index++)
                    {
                        GoodsType gtobj = GoodsType.find(Integer.parseInt(gts[index]));
                        sp.append(gtobj.getName(teasession._nLanguage) + "\n\r");
                    }

                    StringBuffer br = new StringBuffer();
                    Brand b = null;
                    if(gobj.getBrand() > 0 && (b = Brand.find(gobj.getBrand())).isExists())
                    {
                        if(b.getNode() > 0)
                            br.append(b.getName(teasession._nLanguage));
                    }
                    ws.setColumnView(1,30); // 设置列宽,第11列
                    ws.setColumnView(2,30); // 设置列宽,第11列
                    ws.setColumnView(3,30); // 设置列宽,第11列

                    ws.addCell(new jxl.write.Label(0,i + 1,String.valueOf(js)));
                    ws.addCell(new jxl.write.Label(1,i + 1,nobj.getNumber()));
                    ws.addCell(new jxl.write.Label(2,i + 1,nobj.getSubject(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(3,i + 1,sp.toString()));
                    ws.addCell(new jxl.write.Label(4,i + 1,br.toString()));
                    ws.addCell(new jxl.write.Label(5,i + 1,String.valueOf(GoodsDetails.countQuantity(teasession._strCommunity,"Purchase","and gd.node ="+nid))));
                    ws.addCell(new jxl.write.Label(6,i + 1,String.valueOf(GoodsDetails.countTotal(teasession._strCommunity,"Purchase","and gd.node ="+nid))));
                    i++;
                }
			}
			else if("Sale2".equals(act))//消费单商品销售情况统计
			{
				ws.addCell(new jxl.write.Label(0,0,"序号",cFormat));
				ws.addCell(new jxl.write.Label(1,0,"条形码或编号",cFormat));
				ws.addCell(new jxl.write.Label(2,0,"商品名称",cFormat));
				ws.addCell(new jxl.write.Label(3,0,"商品类别",cFormat));
				ws.addCell(new jxl.write.Label(4,0,"商品品牌",cFormat));
				ws.addCell(new jxl.write.Label(5,0,"消费数量",cFormat));
				ws.addCell(new jxl.write.Label(6,0,"消费金额",cFormat));
                java.util.Enumeration e = GoodsDetails.findPurNode(teasession._strCommunity,"Paidinfull",sql.toString(),0,Integer.MAX_VALUE); // ICSalesList.findNo(sql.toString(),pos,pageSize);

                for(int js = 1;e.hasMoreElements();js++)
                {
                    int nid = ((Integer) e.nextElement()).intValue();

                    Node nobj = Node.find(nid);
                    Goods gobj = Goods.find(nid);
                    String gts[] = gobj.getGoodstype().split("/");
                    StringBuffer sp = new StringBuffer();
                    for(int index = 2;index < gts.length;index++)
                    {
                        GoodsType gtobj = GoodsType.find(Integer.parseInt(gts[index]));
                        sp.append(gtobj.getName(teasession._nLanguage) + "\n\r");
                    }

                    StringBuffer br = new StringBuffer();
                    Brand b = null;
                    if(gobj.getBrand() > 0 && (b = Brand.find(gobj.getBrand())).isExists())
                    {
                        if(b.getNode() > 0)
                            br.append(b.getName(teasession._nLanguage));
                    }
					ws.setColumnView(1, 30); // 设置列宽,第11列
					ws.setColumnView(2, 30); // 设置列宽,第11列
					ws.setColumnView(3, 30); // 设置列宽,第11列

                    ws.addCell(new jxl.write.Label(0,i + 1,String.valueOf(js)));
                    ws.addCell(new jxl.write.Label(1,i + 1,nobj.getNumber()));
                    ws.addCell(new jxl.write.Label(2,i + 1,nobj.getSubject(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(3,i + 1,sp.toString()));
                    ws.addCell(new jxl.write.Label(4,i + 1,br.toString()));
                    ws.addCell(new jxl.write.Label(5,i + 1,String.valueOf(GoodsDetails.countQuantity(teasession._strCommunity,"Paidinfull","and gd.node ="+nid))));
                    ws.addCell(new jxl.write.Label(6,i + 1,String.valueOf(GoodsDetails.countTotal(teasession._strCommunity,"Paidinfull","and gd.node =" + nid))));
                    i++;
                }
			}
			wwb.write();
			wwb.close();
			os.close();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}


}
