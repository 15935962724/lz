package tea.ui.yl.shop;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

import tea.db.DbAdapter;
import tea.entity.Database;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.site.Community;
import tea.entity.yl.shop.ShopExchanged;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.ShopOrderData;
import tea.entity.yl.shop.ShopOrderDispatch;
import tea.entity.yl.shop.ShopOrderExpress;
import tea.entity.yl.shop.ShopPackage;
import tea.entity.yl.shop.ShopProduct;
import tea.ui.TeaServlet;

public class expOrders  extends TeaServlet{

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
		response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act");
        if(act.endsWith("exp"))
        {
            response.setContentType("application/octet-stream");
            OutputStream out = response.getOutputStream();
            try
            {
                if("shthdexp".equals(act)) //导出上海退货单
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("退货单(上海).xls".getBytes("GBK"),"ISO-8859-1"));
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                    WritableSheet ws = wwb.createSheet("工作表",0);
                    ws.setColumnView(0,20);
                    ws.setColumnView(1,20);
                    ws.setColumnView(2,20);
                    ws.setColumnView(3,20);
                    ws.setRowView(0,500);
                    ws.mergeCells(0,0,8,0);
                    WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language),cf));
                    int j = 0;
                    cf = new WritableCellFormat();
                    cf.setBackground(Colour.GRAY_25);
                    ws.addCell(new Label(j++,1,"订单编号",cf));
                    ws.addCell(new Label(j++,1,"运单号",cf));
                    ws.addCell(new Label(j++,1,"用户",cf));
                    ws.addCell(new Label(j++,1,"医院",cf));
                    ws.addCell(new Label(j++,1,"退单类型",cf));
                    ws.addCell(new Label(j++,1,"原数量",cf));
                    ws.addCell(new Label(j++,1,"退单商品数量",cf));
                    ws.addCell(new Label(j++,1,"提交时间",cf));
                    ws.addCell(new Label(j++,1,"销售编号",cf));
                    ws.addCell(new Label(j++,1,"生产批号",cf));
                    ws.addCell(new Label(j++,1,"有效期",cf));
                    ws.addCell(new Label(j++,1,"发货日期",cf));
                    ws.addCell(new Label(j++,1,"发件人",cf));
                    ws.addCell(new Label(j++,1,"联系电话",cf));
                    ws.addCell(new Label(j++,1,"商品名称",cf));
                    ws.addCell(new Label(j++,1,"退货描述",cf));

                    StringBuffer sql=new StringBuffer();
                    int tab=h.getInt("tab");
                    sql.append(" AND pro_type=1 ");
                    String[] SQL={""," AND se.status=0"," AND se.status in(1,2)"};
                    String orderid=h.get("orderid","");
                    if(orderid.length()>0)
                    {
                      sql.append(" AND se.order_id LIKE "+DbAdapter.cite("%"+orderid+"%"));
                    }
                    String member=h.get("member","");
                    if(member.length()>0)
                    {
                      sql.append(" AND member in (select profile from profile where member LIKE "+DbAdapter.cite("%"+member+"%")+") ");
                    }
                    //8.18新加医院搜索条件
                    String hospital = h.get("hospital","");
                    if(!"".equals(hospital)){
                    	sql.append(" AND sod.a_hospital LIKE "+Database.cite("%"+hospital+"%"));
                    }
                    Date beginDate=h.getDate("beginDate");
                    Date endDate=h.getDate("endDate");
                    if(beginDate!=null)
                    {
                      sql.append(" AND time>="+DbAdapter.cite(beginDate));
                    }
                    if(endDate!=null)
                    {
                      sql.append(" and time<"+DbAdapter.cite(endDate));
                    }
                    sql.append(SQL[tab]);
                    sql.append(" order by se.status asc,time desc");
                    ArrayList list = ShopExchanged.find(sql.toString(),0,Integer.MAX_VALUE);
                    int i=2;
                	for (int t = 0;t<list.size(); t++) {
                		j = 0;
                		
                		ShopExchanged se = (ShopExchanged) list.get(t);
                		
                		String querySql = " AND order_id="+DbAdapter.cite(se.orderId);
                	  	List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
                	  	ShopOrderData odata = ShopOrderData.find(0);
                	  	if(sodList.size()>0)
                	  	  	odata = sodList.get(0);

                	  	  
                		ShopProduct sp=ShopProduct.find(se.product_id);
                		ShopPackage spage = new ShopPackage(0);
                		//医院
                		String orderId=se.orderId;
                		ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderId);
                		ShopOrderExpress soe = ShopOrderExpress.findByOrderId(orderId);
                	    List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
                		String pname = "";
                		if(sp.isExist){
                			pname=sp.name[1];
                		}else{
                			spage = ShopPackage.find(se.product_id);
                			pname="[套装]"+MT.f(spage.getPackageName());
                			spagePList.add(0,ShopProduct.find(spage.getProduct_id()));
                			String [] sarr = spage.getProduct_link_id().split("\\|");
                			for(int m=1;m<sarr.length;m++){
                			    spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
                			}
                		}
                		String uname = MT.f(Profile.find(se.member).member);
                		
                		ws.addCell(new Label(j++,i,se.orderId));
                		ws.addCell(new Label(j++,i,MT.f(se.expressNo)));
                		ws.addCell(new Label(j++,i,uname));
                		ws.addCell(new Label(j++,i,MT.f(sod.getA_hospital())));
                		ws.addCell(new Label(j++,i,se.type==1?"退货":"换货"));
                		ws.addCell(new Label(j++,i,odata.getQuantity()+""));
                		ws.addCell(new Label(j++,i,se.quantity+""));
                		ws.addCell(new Label(j++,i,MT.f(se.time,1)));
                		//ws.addCell(new Label(j++,i,MT.f(se.description)));
                		ws.addCell(new Label(j++,i,MT.f(soe.NO1)));
                		ws.addCell(new Label(j++,i,MT.f(soe.NO2)));
                		ws.addCell(new Label(j++,i,MT.f(soe.vtime)));
                		ws.addCell(new Label(j++,i,MT.f(soe.time)));
                		ws.addCell(new Label(j++,i,MT.f(soe.person)));
                		ws.addCell(new Label(j++,i,MT.f(soe.mobile)));
                		ws.addCell(new Label(j++,i,pname));
                		ws.addCell(new Label(j++,i,MT.f(se.description)));
                		i++;
                	}
                    
                    
                    wwb.write();
                    wwb.close();
                }else if("thdexp".equals(act)){

                    response.setHeader("Content-Disposition","attachment; filename=" + new String("退货单.xls".getBytes("GBK"),"ISO-8859-1"));
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                    WritableSheet ws = wwb.createSheet("工作表",0);
                    ws.setColumnView(0,20);
                    ws.setColumnView(1,20);
                    ws.setColumnView(2,20);
                    ws.setColumnView(3,20);
                    ws.setRowView(0,500);
                    ws.mergeCells(0,0,8,0);
                    WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language),cf));
                    int j = 0;
                    cf = new WritableCellFormat();
                    cf.setBackground(Colour.GRAY_25);
                    ws.addCell(new Label(j++,1,"订单编号",cf));
                    ws.addCell(new Label(j++,1,"退换货单编号",cf));
                    ws.addCell(new Label(j++,1,"快递单号",cf));
                    ws.addCell(new Label(j++,1,"用户",cf));
                    ws.addCell(new Label(j++,1,"医院",cf));
                    ws.addCell(new Label(j++,1,"商品名称",cf));
                    ws.addCell(new Label(j++,1,"退单类型",cf));
                    ws.addCell(new Label(j++,1,"退单商品数量",cf));
                    ws.addCell(new Label(j++,1,"提交时间",cf));
                    ws.addCell(new Label(j++,1,"退货详情",cf));

                    StringBuffer sql=new StringBuffer();
                    int tab=h.getInt("tab");
                    sql.append(" AND pro_type=0 ");
                    String[] SQL={""," AND se.status=0"," AND se.status in(1,2)"};
                    String orderid=h.get("orderid","");
                    if(orderid.length()>0)
                    {
                      sql.append(" AND se.order_id LIKE "+DbAdapter.cite("%"+orderid+"%"));
                    }
                    String exchanged_code=h.get("exchanged_code","");
                    if(exchanged_code.length()>0)
                    {
                      sql.append(" AND exchanged_code LIKE "+DbAdapter.cite("%"+exchanged_code+"%"));
                    }
                    //8.18新加医院搜索条件
                    String hospital = h.get("hospital","");
                    if(!"".equals(hospital)){
                    	sql.append(" AND sod.a_hospital LIKE "+Database.cite("%"+hospital+"%"));
                    }
                    Date beginDate=h.getDate("beginDate");
                    Date endDate=h.getDate("endDate");
                    if(beginDate!=null)
                    {
                      sql.append(" AND time>="+DbAdapter.cite(beginDate));
                    }
                    if(endDate!=null)
                    {
                      sql.append(" and time<"+DbAdapter.cite(endDate));
                    }
                    sql.append(SQL[tab]);
                    sql.append(" order by se.status asc,time desc");
                    ArrayList list = ShopExchanged.find(sql.toString(),0,Integer.MAX_VALUE);
                    int i=2;
                	for (int t = 0;t<list.size(); t++) {
                		j = 0;
                		
                		ShopExchanged se = (ShopExchanged) list.get(t);
                		
                		String querySql = " AND order_id="+DbAdapter.cite(se.orderId);
                	  	List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
                	  	ShopOrderData odata = ShopOrderData.find(0);
                	  	if(sodList.size()>0)
                	  	  	odata = sodList.get(0);

                	  	  
                		ShopProduct sp=ShopProduct.find(se.product_id);
                		ShopPackage spage = new ShopPackage(0);
                		//医院
                		String orderId=se.orderId;
                		ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderId);
                	    List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
                		String pname = "";
                		if(sp.isExist){
                			pname=sp.getAnchor(h.language);
                		}else{
                			spage = ShopPackage.find(se.product_id);
                			pname="[套装]"+MT.f(spage.getPackageName());
                			spagePList.add(0,ShopProduct.find(spage.getProduct_id()));
                			String [] sarr = spage.getProduct_link_id().split("\\|");
                			for(int m=1;m<sarr.length;m++){
                			    spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
                			}
                		}
                		String uname = MT.f(Profile.find(se.member).member);
                		
                		ws.addCell(new Label(j++,i,se.orderId));
                		ws.addCell(new Label(j++,i,MT.f(se.exchanged_code)));
                		ws.addCell(new Label(j++,i,MT.f(se.expressNo)));
                		ws.addCell(new Label(j++,i,uname));
                		ws.addCell(new Label(j++,i,MT.f(sod.getA_hospital())));
                		ws.addCell(new Label(j++,i,MT.f(sp.name[1])));
                		ws.addCell(new Label(j++,i,se.type==1?"退货":"换货"));
                		ws.addCell(new Label(j++,i,se.quantity+""));
                		ws.addCell(new Label(j++,i,MT.f(se.time,1)));
                		ws.addCell(new Label(j++,i,MT.f(se.description)));
                		i++;
                	}
                    
                    
                    wwb.write();
                    wwb.close();
                
                }else if("qrskexp".equals(act)) //确认收款导出
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("确认收款单.xls".getBytes("GBK"),"ISO-8859-1"));
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                    WritableSheet ws = wwb.createSheet("工作表",0);
                    ws.setColumnView(0,20);
                    ws.setColumnView(1,20);
                    ws.setColumnView(2,20);
                    ws.setColumnView(3,20);
                    ws.setRowView(0,500);
                    ws.mergeCells(0,0,8,0);
                    WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language),cf));
                    int j = 0;
                    cf = new WritableCellFormat();
                    cf.setBackground(Colour.GRAY_25);
                    ws.addCell(new Label(j++,1,"订单编号",cf));
                    ws.addCell(new Label(j++,1,"用户",cf));
                    ws.addCell(new Label(j++,1,"订单金额",cf));
                    ws.addCell(new Label(j++,1,"下单时间",cf));
                    

                    StringBuffer sql=new StringBuffer();

                    String order_id=h.get("order_id","");
                    if(order_id.length()>0)
                    {
                      sql.append(" AND order_id LIKE "+Database.cite("%"+order_id+"%"));
                    }

                    Date time0=h.getDate("time0");
                    if(time0!=null)
                    {
                      sql.append(" AND createDate>"+DbAdapter.cite(time0));
                    }
                    Date time1=h.getDate("time1");
                    if(time1!=null)
                    {
                      sql.append(" AND createDate<"+DbAdapter.cite(time1));
                    }

                    String member=h.get("member","");
                    if(member.length()>0)
                    {
                      sql.append(" AND m.member LIKE "+Database.cite("%"+member+"%"));
                    }

                    
                    String mystatus=h.get("status","");
                    sql.append(" AND status in "+mystatus);

                    int chukuType = h.getInt("chukuType");
                    if(chukuType>0){
                    	if(chukuType==1){
                    		sql.append(" AND isLzCategory=1");
                    	}else{
                    		sql.append(" AND isLzCategory=0");
                    	}
                    		
                    }

                    int isPayment = h.getInt("isPayment",1);
                    if(isPayment==0){
                    	sql.append(" AND isPayment=0");
                    }


                    sql.append(" order by createDate desc");
                    Iterator it=ShopOrder.find(sql.toString(),0,Integer.MAX_VALUE).iterator();
                    int i=2;
                    while(it.hasNext())
                    {
                    	j = 0;
                  	    ShopOrder t=(ShopOrder)it.next();
                        String orderId=t.getOrderId();
                        String uname = MT.f(Profile.find(t.getMember()).member);
                        
                        int status = t.getStatus();
                        
                        ShopOrderExpress soe=null;
                        ArrayList list =ShopOrderExpress.find(" and order_id="+DbAdapter.cite(t.getOrderId()),0,1);
                        soe = list.size() < 1 ? new ShopOrderExpress(0):(ShopOrderExpress)list.get(0);
                        
                        ws.addCell(new Label(j++,i,t.getOrderId()+""));
                        ws.addCell(new Label(j++,i,uname));
                        ws.addCell(new Label(j++,i,MT.f((double)t.getAmount(),2)+""));
                        ws.addCell(new Label(j++,i,MT.f(t.getCreateDate(),1)+""));
                       
                        i++;
                    }
                    
                    
                    
                    
                    wwb.write();
                    wwb.close();
                }else if("orderexp".equals(act)) //shoporder导出
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("订单.xls".getBytes("GBK"),"ISO-8859-1"));
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                    WritableSheet ws = wwb.createSheet("工作表",0);
                    ws.setColumnView(0,20);
                    ws.setColumnView(1,20);
                    ws.setColumnView(2,20);
                    ws.setColumnView(3,20);
                    ws.setRowView(0,500);
                    ws.mergeCells(0,0,8,0);
                    WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language),cf));
                    int j = 0;
                    cf = new WritableCellFormat();
                    cf.setBackground(Colour.GRAY_25);
                    ws.addCell(new Label(j++,1,"订单编号",cf));
                    ws.addCell(new Label(j++,1,"用户",cf));
                    ws.addCell(new Label(j++,1,"医院",cf));
                    ws.addCell(new Label(j++,1,"数量",cf));
                    ws.addCell(new Label(j++,1,"下单时间",cf));
                    

                    StringBuffer sql=new StringBuffer();

                    String order_id=h.get("order_id","");
                    if(order_id.length()>0)
                    {
                      sql.append(" AND order_id LIKE "+Database.cite("%"+order_id+"%"));
                    }

                    Date time0=h.getDate("time0");
                    if(time0!=null)
                    {
                      sql.append(" AND createDate>"+DbAdapter.cite(time0));
                    }
                    Date time1=h.getDate("time1");
                    if(time1!=null)
                    {
                      sql.append(" AND createDate<"+DbAdapter.cite(time1));
                    }

                    String member=h.get("member","");
                    if(member.length()>0)
                    {
                      sql.append(" AND m.member LIKE "+Database.cite("%"+member+"%"));
                    }

                    
                    String mystatus=h.get("status","");
                    sql.append(" AND status in "+mystatus);

                    int chukuType = h.getInt("chukuType");
                    if(chukuType>0){
                    	if(chukuType==1){
                    		sql.append(" AND isLzCategory=1");
                    	}else{
                    		sql.append(" AND isLzCategory=0");
                    	}
                    		
                    }

                    int isPayment = h.getInt("isPayment",1);
                    if(isPayment==0){
                    	sql.append(" AND isPayment=0");
                    }


                    sql.append(" order by createDate desc");
                    Iterator it=ShopOrder.find(sql.toString(),0,Integer.MAX_VALUE).iterator();
                    int i=2;
                    while(it.hasNext())
                    {
                    	j = 0;
                  	    ShopOrder t=(ShopOrder)it.next();
                        String orderId=t.getOrderId();
                        
                        ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderId);

                  	    String querySql = " AND order_id="+DbAdapter.cite(orderId);
                    	  List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
                    	  
                    	  ShopOrderData odata = ShopOrderData.find(0);
                  	  if(sodList.size()>0)
                  	  	odata = sodList.get(0);
                  	  
                        String uname = MT.f(Profile.find(t.getMember()).member);
                        
                        int status = t.getStatus();
                        
                        ShopOrderExpress soe=null;
                        ArrayList list =ShopOrderExpress.find(" and order_id="+DbAdapter.cite(t.getOrderId()),0,1);
                        soe = list.size() < 1 ? new ShopOrderExpress(0):(ShopOrderExpress)list.get(0);
                        ws.addCell(new Label(j++,i,t.getOrderId()));
                        ws.addCell(new Label(j++,i,uname));
                        ws.addCell(new Label(j++,i,MT.f(sod.getA_hospital())));
                        ws.addCell(new Label(j++,i,odata.getQuantity()+""));
                        ws.addCell(new Label(j++,i,MT.f(t.getCreateDate(),1)));
                        
                        i++;
                      }
                    
                    
                    
                    
                    wwb.write();
                    wwb.close();
                }
            } catch(WriteException wex)
            {
            } catch(Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                out.close();
            }
            return;
        }
    }
}
