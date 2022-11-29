package tea.ui.yl.shopnew;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.write.WriteException;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.*;
import tea.entity.yl.shopnew.BackInvoice;
import tea.entity.yl.shopnew.ChangeLiziData;
import tea.entity.yl.shopnew.ChangeYingshouData;
import tea.entity.yl.shopnew.Invoice;
import tea.entity.yl.shopnew.InvoiceData;
import tea.entity.yl.shopnew.UrgedRecord;
import util.CommonUtils;
import util.Config;
import util.DateUtil;

/**
 * 提交索要发票
 * */
public class Invoices extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
		
		//out.println("<script src=\"/tea/mt.js\" type=\"text/javascript\"></script>");
		//out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
		CommonUtils utils = new CommonUtils();
		if("exp_invoice".equals(act)){
        	try{
        		int category = h.getInt("category");
        		int exflag = h.getInt("exflag");
        		int puid = h.getInt("puid");
        		resp.setContentType("application/x-msdownload");
        		resp.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("发票" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = resp.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("发票", 0);
                int index = 0;
                	
                    ws.addCell(new jxl.write.Label(index++, 0, "订货日期"));
                    ws.addCell(new jxl.write.Label(index++, 0, "订单号"));
                    ws.addCell(new jxl.write.Label(index++, 0, "销售编码"));
                    ws.addCell(new jxl.write.Label(index++, 0, "生产编码"));
                    ws.addCell(new jxl.write.Label(index++, 0, "收件人"));
                    ws.addCell(new jxl.write.Label(index++, 0, "服务商"));
					ws.addCell(new jxl.write.Label(index++, 0, "服务商公司"));
                    ws.addCell(new jxl.write.Label(index++, 0, "订货单位"));
                    ws.addCell(new jxl.write.Label(index++, 0, "开票数量"));
                    ws.addCell(new jxl.write.Label(index++, 0, "活度"));
                    ws.addCell(new jxl.write.Label(index++, 0, "开票价"));
                    ws.addCell(new jxl.write.Label(index++, 0, "开票金额"));
					if(puid!=Config.getInt("tongfu")){
						ws.addCell(new jxl.write.Label(index++, 0, "计提服务费"));
					}
                    ws.addCell(new jxl.write.Label(index++, 0, "备注"));
                    ws.addCell(new jxl.write.Label(index++, 0, "发票号"));
                    ws.addCell(new jxl.write.Label(index++, 0, "票面备注"));
					ws.addCell(new jxl.write.Label(index++, 0, "开票日期"));
					ws.addCell(new jxl.write.Label(index++, 0, "状态"));
                    
                String sql = h.get("sql");
                List<Invoice> lstinvoice=Invoice.find(sql+" order by createdate desc ", 0, Integer.MAX_VALUE);
                int hang=0;//行数
                int num=0;//用于记录合并的行数
                for(int i=0;i<lstinvoice.size();i++)
                {
                  Invoice invoice=lstinvoice.get(i);
              	  
              	  Profile profile=Profile.find(invoice.getMember());
              	
    			//新加3.14(展示订单内容）
    			List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid="+invoice.getId(), 0, Integer.MAX_VALUE);
    			
    			for(int j=0;j<lstdata.size();j++){
    				InvoiceData data=lstdata.get(j);
    				ShopOrder so=ShopOrder.findByOrderId(data.getOrderid());
    				ShopOrderExpress soe = ShopOrderExpress.findByOrderId(data.getOrderid());
    				ShopOrderDispatch sodh = ShopOrderDispatch.findByOrderId(data.getOrderid());
    				List<ShopOrderData> lstod=ShopOrderData.find(" and order_id="+DbAdapter.cite(data.getOrderid()), 0, 1);
    				Profile profile2 = Profile.find(so.getMember());//下单人
    				
    				String huodu="";//活度
    				int count=0;//订单数量
    				double price = 0;//单价
    				double prices=0;//总价
    				double agent_unit = 0;//开票价
    				double agent_amount = 0;//开票金额
    				if(lstod.size()>0){
    					ShopOrderData od=lstod.get(0);
    					huodu=od.getActivity()+"";//活度
    					count=od.getQuantity();//订单数量
    					if(so.isLzCategory()){
    						price=od.getUnit();
    						prices=od.getAmount();
    						if(profile2.membertype==2){
    							price=od.getAgent_price_s();
    							prices=od.getAgent_price_s()*od.getQuantity();
    							agent_unit = od.getAgent_price();		//服务商开票价
    							agent_amount = od.getAgent_amount(); 	//服务商开票金额
    						}else{
    							agent_unit = price;
    							agent_amount = prices;
    						}
    					}else{
    						price=od.getUnit();
    						prices=od.getAmount();
    					}
    					
    				}
					int phpuid = InvoiceData.getPuid(invoice.getId());

					//ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember());
					ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember(),invoice.getHospitalid());
    				index=0;
    				hang++;
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(so.getCreateDate())));
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(so.getOrderId())));
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(soe.NO1)));//销售编码
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(soe.NO2)));//生产编码
					//ws.addCell(new jxl.write.Label(index++, hang,MT.f(sodh.getN_consignees())));//收件人
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(invoice.getConsigness())));//收件人
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(profile.member)));//服务商
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(puj.getCompany())));//服务商
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(invoice.getHospital())));//订货单位
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(invoice.getNum())));//购买数量
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(huodu)));//活度
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(agent_unit,2)));//开票价
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(invoice.getAmount(),2)));//开票金额
					if(puid!=Config.getInt("tongfu")){
						//Profile profile = Profile.find(invoice.getMember());
						Map<String,Double> imap =  Invoice.getTaxAmount(puj.tax, invoice.getId(), 0.9844, 1.13);
						double mysum = imap.get("chargeamountsum")+imap.get("taxamount");
						BigDecimal b2=new BigDecimal(mysum);
						double taxamount2=b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

						ws.addCell(new jxl.write.Label(index++, 0, taxamount2+""));
					}

					ws.addCell(new jxl.write.Label(index++, hang,MT.f(invoice.getRemark())));//备注
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(invoice.getInvoiceno())));//发票号
					ws.addCell(new jxl.write.Label(index++, hang,MT.f(invoice.getNominalremark())));//票面备注
					ws.addCell(new jxl.write.Label(index++, hang,invoice.getStatus()==2?MT.f(invoice.getMakeoutdate()):""));//开票日期
					//ws.addCell(new jxl.write.Label(index++, hang,MT.f(invoice.getInvoiceno())));//发票号
					String statuscontent="";
					if(invoice.getStatus()==0){
						statuscontent="未开具";
					}else if(invoice.getStatus()==1){
						statuscontent="已审核";
					}else if(invoice.getStatus()==2){
						statuscontent="已开具";
					}else if(invoice.getStatus()==3){
						statuscontent="审核不通过";
					}else if(invoice.getStatus()==4){
						statuscontent="退票申请中";
					}else if(invoice.getStatus()==5){
						statuscontent="已退票";
					}
					ws.addCell(new jxl.write.Label(index++, hang,statuscontent));

    			}
    			//合并开始
    			List<InvoiceData> lstidata=InvoiceData.find(" and invoiceid="+invoice.getId(), 0, Integer.MAX_VALUE);
				int lsize=lstidata.size();
				num+=lsize;
    			if(lstidata.size()>0){
					ws.mergeCells(7, (num-lsize+1), 7, num);//合并申请开票数量
					ws.mergeCells(10, (num-lsize+1), 10, num);//合并申请开票金额
					ws.mergeCells(8, (num-lsize+1), 8, num);//合并申请开票数量
					ws.mergeCells(4, (num-lsize+1), 4, num);//合并收件人
					ws.mergeCells(5, (num-lsize+1), 5, num);//合并服务商
					ws.mergeCells(6, (num-lsize+1), 6, num);//合并医院
					ws.mergeCells(9, (num-lsize+1), 9, num);//合并	开票价
					ws.mergeCells(11, (num-lsize+1), 11, num);//合并备注
					ws.mergeCells(12, (num-lsize+1), 12, num);//合并发票号
					ws.mergeCells(13, (num-lsize+1), 13, num);//合并票面备注
					ws.mergeCells(14, (num-lsize+1), 14, num);//合并开票日期
				}
    			
				//合并结束
    			
                }
	            wwb.write();
	            wwb.close();
	            os.close();
	            return;
            }catch (Exception e) {
			}
        }else if("exp_invoice_cw".equals(act)){

        	try{
        		int category = h.getInt("category");
        		int exflag = h.getInt("exflag");
        		resp.setContentType("application/x-msdownload");
        		resp.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("发票" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = resp.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("发票", 0);
                int index = 0;
                	ws.addCell(new jxl.write.Label(index++, 0, "发票号"));
                    ws.addCell(new jxl.write.Label(index++, 0, "服务商"));
                    ws.addCell(new jxl.write.Label(index++, 0, "医院"));
                    
                    ws.addCell(new jxl.write.Label(index++, 0, "索要发票时间"));
                    ws.addCell(new jxl.write.Label(index++, 0, "申请开票数量"));
                    
                    ws.addCell(new jxl.write.Label(index++, 0, "申请开票金额"));
                    ws.addCell(new jxl.write.Label(index++, 0, "状态"));
                    
                   
                    
                String sql = h.get("sql");
                List<Invoice> lstinvoice=Invoice.find(sql.toString(), 0, Integer.MAX_VALUE);
                for(int i=0;i<lstinvoice.size();i++)
                {
              	  Invoice invoice=lstinvoice.get(i);
              	  String statuscontent="";
              	  if(invoice.getStatus()==0){
              		  statuscontent="未开具";
              	  }else if(invoice.getStatus()==1){
              		  statuscontent="已审核";
              	  }else if(invoice.getStatus()==2){
              		  statuscontent="已开具";
              	  }
              	  Profile profile=Profile.find(invoice.getMember());
              	index = 0;
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(invoice.getInvoiceno())));
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(profile.getMember())));
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(invoice.getHospital())));
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(invoice.getCreatedate(),1)));
    			ws.addCell(new jxl.write.Label(index++, i+1,String.valueOf(invoice.getNum())));
    			ws.addCell(new jxl.write.Label(index++, i+1,String.valueOf(invoice.getAmount())));
    			ws.addCell(new jxl.write.Label(index++, i+1,statuscontent));
    			
                }
	            wwb.write();
	            wwb.close();
	            os.close();
	            return;
            }catch (Exception e) {
			}
        
        }else if("mateOrder".equals(act)){
			String ids = h.get("ids");
			System.out.println(ids);
		}else if("exp_invoice_web".equals(act)){//服务商导出发票

			javax.servlet.ServletOutputStream os = null;
			jxl.write.WritableWorkbook wwb = null;
			try {
				String sql = h.get("sql");
				resp.setContentType("application/x-msdownload");
				resp.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("发票" + ".xls", "UTF-8"));
				os = resp.getOutputStream();
				wwb = jxl.Workbook.createWorkbook(os);
				jxl.write.WritableSheet ws = wwb.createSheet("发票", 0);
				int index = 0;
				ws.addCell(new jxl.write.Label(index++, 0, "序号"));
				ws.addCell(new jxl.write.Label(index++, 0, "发票号"));
				ws.addCell(new jxl.write.Label(index++, 0, "医院"));
				ws.addCell(new jxl.write.Label(index++, 0, "索要发票时间"));
				ws.addCell(new jxl.write.Label(index++, 0, "申请开票数量"));
				ws.addCell(new jxl.write.Label(index++, 0, "申请开票金额"));
				ws.addCell(new jxl.write.Label(index++, 0, "状态"));
				ws.addCell(new jxl.write.Label(index++, 0, "开票单位"));
				ArrayList<Invoice> invoices = Invoice.find(sql + " order by createdate desc", 0, Integer.MAX_VALUE);
				for (int i = 0; i < invoices.size(); i++) {
                    Invoice invoice = invoices.get(i);
					String statuscontent="";
					if(invoice.getStatus()==0||invoice.getStatus()==1){
						statuscontent="未开具";
					}else if(invoice.getStatus()==2){
						statuscontent="已开具";
					}else if(invoice.getStatus()==3){
						statuscontent="审核不通过";
					}else if(invoice.getStatus()==4){
						statuscontent="退票申请中";
					}else if(invoice.getStatus()==5){
						statuscontent="已退票";
					}
                    index = 0;
                    ws.addCell(new jxl.write.Label(index++, i+1,MT.f(i+1)));
                    ws.addCell(new jxl.write.Label(index++, i+1,MT.f(invoice.getInvoiceno())));
                    ws.addCell(new jxl.write.Label(index++, i+1,MT.f(invoice.getHospital())));
                    ws.addCell(new jxl.write.Label(index++, i+1,MT.f(invoice.getCreatedate(),1)));
                    ws.addCell(new jxl.write.Label(index++, i+1,MT.f(invoice.getNum())));
                    ws.addCell(new jxl.write.Label(index++, i+1,MT.f(invoice.getAmount())));
                    ws.addCell(new jxl.write.Label(index++, i+1,statuscontent));
					ws.addCell(new jxl.write.Label(index++, i+1,MT.f(ProcurementUnit.findName(invoice.getPuid()))));

				}


			wwb.write();
			wwb.close();
			os.close();
			return;
			} catch (WriteException e) {
				e.printStackTrace();
			}

		}
		PrintWriter out = resp.getWriter();
		try {
			if("iscanback".equals(act)){
				//判断是否可以退票，未提交匹配回款申请并且未匹配回款的发票才可以退票
				int invoiceid=h.getInt("invoiceid");
				List<BackInvoice> lstback=BackInvoice.find(" and invoiceid like "+Database.cite("%"+invoiceid+"%")+" AND status <> 2 ", 0, Integer.MAX_VALUE);
				if(lstback.size()>0){
					out.print("1");
				}else{
					out.print("0");
				}
				return;
			}
			if("orderAddress".equals(act)){
				insertAddress(h);
				resp.sendRedirect(nexturl);
				return;
			}else if("nvoice".equals(act)){
				int hospitalid=h.getInt("hospitalid");//医院id
				ShopHospital shophospital=ShopHospital.find(hospitalid);
				if((shophospital.getInvoicePuid()+"").equals(Config.getString("gaoke"))||(shophospital.getInvoicePuid()+"").equals(Config.getString("junan"))) {
					if(CommonUtils.checkNoSubmitOrder()){
						out.print("2");

						return;
					}
				}
				//服务商索要发票
				insertNvoice(h);//发送短信内容先隐藏
				
        		/*ShopOrder so = ShopOrder.findByOrderId(h.get("orderid"));
				so.setAskInvoiceDate(new Date());
				so.set();
				Profile profile = Profile.find(h.member);
				//订单附加
        		ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
        		//获取短信内容
        		String content = utils.getSms_content("syfp");
    			content = utils.replace(content, profile.getMember(), so.getOrderId(), "", "",sod.getN_company(),sod.getN_consignees(),"");
    			
    			String user = Profile.find(h.member).getMember();
    			
				ArrayList<ShopSMSSetting> list = ShopSMSSetting.find("",0,1);
        		if(list.size() > 0){
	    			ShopSMSSetting sms = list.get(0);
	    			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.syfp);
	    			if(!"".equals(MT.f(mobiles.toString())))
	    				SMSMessage.create("Home", user, mobiles.toString(), h.language, content);
        		}
        		if(!"".equals(MT.f(profile.mobile,"")))
    				SMSMessage.create("Home", user, profile.mobile, h.language, content);
        		*/
				out.print("1");
        		//out.print("<script>parent.parent.mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        		return;
			}else if("confirm".equals(act)){
				int invoiceid=h.getInt("invoiceid");
				Invoice invoice=Invoice.find(invoiceid);
				
			}else if("submit".equals(act)){
				//订单管理员同意开票（审核通过）
				int invoiceid=h.getInt("invoiceid");
				Invoice invoice=Invoice.find(invoiceid);
				/*//推送CRM
				int send = CreatInvoiceSendCrm.send(invoice);
				if(send!=1){
					out.print("<script>parent.mt.show('CRM推送失败，发票审核失败！',1,'" + nexturl + "');</script>");
					return;
				}*/
				int status=h.getInt("status");
				if(status==2){
					//补填快递单号
					String courierno=h.get("courierno");
					invoice.set("courierno", courierno);
					//审核后可修改开票号和开票日期
					invoice.set("invoiceno", h.get("invoiceno"));
					invoice.set("makeoutdate",MT.f(h.getDate("makeoutdate")));
					//短信通知服务商
					String user = Profile.find(h.member).getMember();
					Profile fprofile=Profile.find(invoice.getMember());
					String fmobile=fprofile.getMobile();
					if(!"".equals(fmobile)){
						SMSMessage.create("Home", user, fmobile, h.language, invoice.getHospital()+invoice.getNum()+"粒已开具发票，快递单号："+MT.f(courierno)+"。");
					}
				}else{
					//订单管理员开具发票
					
					invoice.setInternalremark(MT.f(h.get("internalremark")));
					invoice.setNominalremark(MT.f(h.get("nominalremark")));
					invoice.setStatus(1);//状态变为已审核
					invoice.set();
					List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid="+invoiceid, 0, Integer.MAX_VALUE);
					for(int i=0;i<lstdata.size();i++){
						InvoiceData data=lstdata.get(i);
						data.set("status", "1");
					}
					//发送短信通知财务开具发票
					String user = Profile.find(h.member).getMember();
					ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+invoice.getPuid(),0,1);
					if(list.size() > 0){
						ShopSMSSetting sms = list.get(0);
						List<String> mobiles = ShopSMSSetting.getUserMobile(sms.fpkj);
						if(!"".equals(MT.f(mobiles.toString())))
							SMSMessage.create("Home", user, mobiles.toString(), h.language, invoice.getHospital()+invoice.getNum()+"粒发票已审核，请及时开具。");
					}
				}
				
			}else if("submitcaiwu".equals(act)){
				//财务开具发票
				int invoiceid=h.getInt("invoiceid");
				Invoice invoice=Invoice.find(invoiceid);
				String invoiceno=h.get("invoiceno");//发票号
				Date makeoutdate=h.getDate("makeoutdate");//开票日期
				invoice.setInvoiceno(invoiceno);
				invoice.setMakeoutdate(makeoutdate);
				invoice.setStatus(2);//发票已开

				String courierno = MT.f(h.get("courierno"));
				if(courierno.length()>0){
					invoice.setCourierno(courierno);
				}

				invoice.set();
				//发送短信通知订单管理员
				String user = Profile.find(h.member).getMember();
				ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+invoice.getPuid(),0,1);
				if(list.size() > 0){
					ShopSMSSetting sms = list.get(0);
					List<String> mobiles = ShopSMSSetting.getUserMobile(sms.cwykp);
					if(!"".equals(MT.f(mobiles.toString())))
						SMSMessage.create("Home", user, mobiles.toString(), h.language, invoice.getHospital()+invoice.getNum()+"粒已开具发票。");
				}
				
				List<InvoiceData> lstinvoicedata=InvoiceData.find(" and invoiceid="+invoiceid, 0, Integer.MAX_VALUE);
				//计算已开发票数量
				for(int i=0;i<lstinvoicedata.size();i++){
					InvoiceData data=lstinvoicedata.get(i);
					data.set("status", "2");
					String orderid=data.getOrderid();
					List<InvoiceData> lstdata=InvoiceData.find(" and orderid="+Database.cite(orderid)+" and status in(2,4,6)", 0, Integer.MAX_VALUE);
					int yinum=0;
					float yiamount=0;
					for(int j=0;j<lstdata.size();j++){
						InvoiceData idata=lstdata.get(j);
						yinum+=idata.getNum();
						yiamount+=idata.getAmount();
					}
					ShopOrder shoporder=ShopOrder.findByOrderId(orderid);
					shoporder.set("isinvoicenum", String.valueOf(yinum));//已开发票数量
					shoporder.set("isinvoiceamount", String.valueOf(yiamount));//已开发票金额
					//改变invoicestatus
					List<ShopOrderData> lstorderdata=ShopOrderData.find(" and order_id="+Database.cite(orderid), 0, Integer.MAX_VALUE);
					if(lstorderdata.size()>0){
						ShopOrderData orderdata=lstorderdata.get(0);
						if(orderdata.getQuantity()==yinum){
							shoporder.set("invoicestatus", "3");
						}
					}
					
				}
				//开具发票后导致未开票粒子数减少，未开票粒子数增加
				ChangeLiziData.makenoinvoice(invoice.getHospitalid(), invoice.getNum(), invoice.getMakeoutdate(), h.member, invoice.getId());
				//开具发票后导致应收账款增加
				ChangeYingshouData.addyingshou(invoice.getHospitalid(), invoice.getAmount(), invoice.getMakeoutdate(), h.member, invoice.getId());
				
			}else if("refuse".equals(act)){
				//订单管理员拒绝开票
				//订单管理员添加拒绝原因
				int invoiceid=h.getInt("invoiceid");
				String reason=h.get("reason");
				Invoice invoice=Invoice.find(invoiceid);
				invoice.set("reason", reason);
				invoice.set("status", "3");
				//修改未开票数量和未开票金额
				List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid="+invoiceid, 0, Integer.MAX_VALUE);
				for(int i=0;i<lstdata.size();i++){
					InvoiceData data=lstdata.get(i);
					data.set("status", "3");
					String orderid=data.getOrderid();
					ShopOrder shoporder=ShopOrder.findByOrderId(orderid);
					int nonum=shoporder.getNoinvoicenum()+data.getNum();
					float noamount=shoporder.getNoinvoiceamount()+data.getAmount();
					
					shoporder.set("noinvoicenum",String.valueOf(nonum));
					shoporder.set("noinvoiceamount", String.valueOf(noamount));
				}
				//短信通知服务商
				String user = Profile.find(h.member).getMember();
				Profile fprofile=Profile.find(invoice.getMember());
				String fmobile=fprofile.getMobile();
				if(!"".equals(fmobile)){
					SMSMessage.create("Home", user, fmobile, h.language, invoice.getHospital()+invoice.getNum()+"粒的发票申请审核不通过。");
				}
				
				
			}else if("backinvoice".equals(act)){
				//服务商申请退票
				int invoiceid=h.getInt("invoiceid");
				Invoice invoice=Invoice.find(invoiceid);
				String backreason=h.get("backreason");//退票原因
				String backcourierno=h.get("backcourierno");//快递单号
				invoice.set("backreason", backreason);
				invoice.set("backcourierno", backcourierno);
				invoice.set("status", "4");
				List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid="+invoiceid, 0, Integer.MAX_VALUE);
				for(int i=0;i<lstdata.size();i++){
					InvoiceData data=lstdata.get(i);
					data.set("status", "4");
				}
				//发送短信通知订单管理员
				String user = Profile.find(h.member).getMember();
				ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+invoice.getPuid(),0,1);
				if(list.size() > 0){
					ShopSMSSetting sms = list.get(0);
					List<String> mobiles = ShopSMSSetting.getUserMobile(sms.syfp);
					if(!"".equals(MT.f(mobiles.toString())))
						SMSMessage.create("Home", user, mobiles.toString(), h.language, invoice.getHospital()+invoice.getNum()+"粒发票申请退票，请及时处理。");
				}
			}else if("backyes".equals(act)){
				//订单管理员同意退票
				int invoiceid=h.getInt("invoiceid");
				Invoice invoice=Invoice.find(invoiceid);
				invoice.set("status", "5");//同意退票
				//发送短信通知服务商
				String user = Profile.find(h.member).getMember();
				Profile fmember=Profile.find(invoice.getMember());
				String fmobile=fmember.getMobile();
				if(!"".equals(fmobile)){
					SMSMessage.create("Home", user, fmobile, h.language, invoice.getHospital()+invoice.getNum()+"粒发票已退票！");
				}


				if(invoice.getPuid()!= Config.getInt("tongfu")){//不等于同辐都退

					List<ServiceFeeRecord> sflist = ServiceFeeRecord.find(" AND oids like '%"+invoiceid+"%'",0,1);
					if(sflist.size()>0){
						int phpuid = InvoiceData.getPuid(invoice.getId());
						//ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember());
						ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember(),invoice.getHospitalid());
						Profile profile = Profile.find(invoice.getMember());

						ServiceInvoice oldsi = ServiceInvoice.findOldSi(invoiceid);//之前匹配的服务费发票

						Map<String,Double> imap =  Invoice.getTaxAmount(puj.tax, invoice.getId(), 0.9844, 1.13);
						double mysum = imap.get("chargeamountsum")+imap.get("taxamount");
						BigDecimal b2=new BigDecimal(mysum);
						double taxamount2=b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
						ServiceInvoice si = ServiceInvoice.find(0);
						si.setInvoiceCode("td"+ Seq.get());
						si.setProfile(invoice.getMember());
						si.setMoney((float)taxamount2);
						si.setTime(new Date());
						si.setPuj_id(oldsi.getPuj_id());//和之前服务商公司统一
						si.setPuid(invoice.getPuid());
						si.set();
					}

				}

				//把订单恢复为开票前的数量和金额
				List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid = "+invoiceid, 0, Integer.MAX_VALUE);
				for(int i=0;i<lstdata.size();i++){
					InvoiceData data=lstdata.get(i);
					data.set("status", "5");
					//开票数量
					int num=data.getNum();
					//开票金额
					float amount=data.getAmount();
					String orderid=data.getOrderid();
					ShopOrder order=ShopOrder.findByOrderId(orderid);
					//恢复未开票数量和未开票金额
					order.set("noinvoicenum",String.valueOf(num+order.getNoinvoicenum()));
					order.set("noinvoiceamount", String.valueOf(amount+order.getNoinvoiceamount()));
					//恢复已开票数量和已开票金额
					order.set("isinvoicenum", String.valueOf(order.getIsinvoicenum()-num));
					order.set("isinvoiceamount", String.valueOf(order.getIsinvoiceamount()-amount));
					order.set("invoicestatus", "0");//0：未完成开票的订单

				}
				//退票导致未开票粒子数增加，已开票粒子数减少
				ChangeLiziData.makenoinvoice2(invoice.getHospitalid(), invoice.getNum(), new Date(), h.member, invoice.getId());
				//退票导致应收账款减少
				ChangeYingshouData.jianyingshou(invoice.getHospitalid(), invoice.getAmount(), new Date(), h.member, invoice.getId());
			}else if("backno".equals(act)){
				//订单管理员不同意退票
				int invoiceid=h.getInt("invoiceid");
				Invoice invoice=Invoice.find(invoiceid);
				invoice.set("status", "2");
				String nobackreason=h.get("nobackreason");
				invoice.set("nobackreason", nobackreason);
				List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid="+invoiceid, 0, Integer.MAX_VALUE);
				for(int i=0;i<lstdata.size();i++){
					InvoiceData data=lstdata.get(i);
					data.set("status", "2");
				}
				//发送短信通知订单管理员
				String user = Profile.find(h.member).getMember();
				Profile fmember=Profile.find(invoice.getMember());
				String fmobile=fmember.getMobile();
				if(!"".equals(fmobile)){
					SMSMessage.create("Home", user, fmobile, h.language, invoice.getHospital()+invoice.getNum()+"粒发票拒绝退票，拒绝原因："+invoice.getNobackreason()+"！");
				}
			}else if("urgedprofile".equals(act)){
				//催缴服务商开票
				String pids=h.get("pids");//服务商id
				String[] pidarr=pids.split(",");
				String hospital="";//医院id
				String orderids="";//订单id
				for(int i=0;i<pidarr.length;i++){
					int pid=Integer.parseInt(pidarr[i]);
					Profile profile=Profile.find(pid);
					//获取医院
					String sql=" and sod.order_id in(select order_id from shoporder so where 1=1 and status!=5 and status!=6 and (isinvoicenum < (select quantity from shopOrderData where order_id=so.order_id ) or order_id in(select order_id from shoporderdata where quantity<0 ) and isinvoicenum=0 and noinvoicenum<0 ) and DATEDIFF(y, createdate, GETDATE()) >=365 and member="+pid+") group by a_hospital";
					List<String> lstd=ShopOrderDispatch.searchHospital(sql, 0, Integer.MAX_VALUE);
					for(int j=0;j<lstd.size();j++){
						String hname=lstd.get(j);
						if(j==lstd.size()-1){
							hospital+=hname;
						}else{
							hospital+=hname+",";
						}
						
					}
					//发送通知短信
					//SMSMessage.create("Home", profile.member, profile.mobile, h.language, "您好，您有逾期未开票订单，具体的订单信息您可以在“逾期未开票订单”中查看。");
					//根据当前用户id查询orderid
					String sql2="and status!=5 and status!=6 and (isinvoicenum < (select quantity from shopOrderData where order_id=so.order_id ) or order_id in(select order_id from shoporderdata where quantity<0 )and isinvoicenum=0 and noinvoicenum<0 ) and DATEDIFF(y, createdate, GETDATE()) >=365 and member="+pid;
					List<String> lsts=ShopOrder.searchOrderid(sql2, 0, Integer.MAX_VALUE);
					for(int j=0;j<lsts.size();j++){
						String orderid=lsts.get(j);
						ShopOrder so=ShopOrder.findByOrderId(orderid);
						so.set("isurged", "1");
						so.set("urgedtime",MT.f(new Date(),1) );
						//获取orderid
						if(j==lsts.size()-1){
							orderids+=orderid;
						}else{
							orderids+=orderid+",";
						}
					}
					//生成催缴记录
					UrgedRecord ur=UrgedRecord.find(0);
					ur.setMember(h.member);
					ur.setFmember(pid);
					ur.setCreatedate(new Date());
					ur.setOrderid(orderids);
					ur.setHospitalid(hospital);
					ur.setType(0);
					ur.set();
				}
				
			}else if("urgedprofilereply".equals(act)){
				//催缴服务商回款
				String pids=h.get("pids");//服务商id
				String[] pidarr=pids.split(",");
				String hospital="";//医院id
				String orderids="";//订单id
				for(int i=0;i<pidarr.length;i++){
					int pid=Integer.parseInt(pidarr[i]);
					Profile profile=Profile.find(pid);
					//获取医院
					String sql=" and sod.order_id in(select order_id from shoporder so where 1=1 and status!=5 and status!=6 AND order_id in (select orderid from invoicedata where invoiceid in(select id from invoice where status=2 and matchstatus!=2 and DATEDIFF(y, makeoutdate, GETDATE()) >=15)) ) group by sod.a_hospital ";
					List<String> lstd=ShopOrderDispatch.searchHospital(sql, 0, Integer.MAX_VALUE);
					for(int j=0;j<lstd.size();j++){
						String hname=lstd.get(j);
						if(j==lstd.size()-1){
							hospital+=hname;
						}else{
							hospital+=hname+",";
						}
						
					}
					//发送通知短信
					//SMSMessage.create("Home", profile.member, profile.mobile, h.language, "您好，您有逾期未回款订单，具体的订单信息您可以在“逾期未回款订单”中查看。");
					//根据当前用户id查询orderid
					String sql2="and status!=5 and status!=6 and member="+pid+" AND order_id in (select orderid from invoicedata where invoiceid in(select id from invoice where status=2 and matchstatus!=2 and DATEDIFF(y, makeoutdate, GETDATE()) >=15)) ";
					List<String> lsts=ShopOrder.searchOrderid(sql2, 0, Integer.MAX_VALUE);
					for(int j=0;j<lsts.size();j++){
						String orderid=lsts.get(j);
						ShopOrder so=ShopOrder.findByOrderId(orderid);
						so.set("isurgedreply", "1");
						so.set("urgedtimereply",MT.f(new Date(),1) );
						//获取orderid
						if(j==lsts.size()-1){
							orderids+=orderid;
						}else{
							orderids+=orderid+",";
						}
					}
					//生成催缴记录
					UrgedRecord ur=UrgedRecord.find(0);
					ur.setMember(h.member);
					ur.setFmember(pid);
					ur.setCreatedate(new Date());
					ur.setOrderid(orderids);
					ur.setHospitalid(hospital);
					ur.setType(1);
					ur.set();
				}
				
			
			}
			out.print("<script>parent.mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
	}

	/**
	 * 收货人信息
	 * @throws SQLException 
	 * */
	private void insertAddress(Http h) throws SQLException{
		ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member);
		soa.setId(h.getInt("id"));
		soa.setConsignees(h.get("consignees"));
		soa.setConsignees_id(h.getInt("consignees_id"));
		soa.setAddress(h.get("address"));
		soa.setMobile(h.get("mobile"));
		soa.setTelphone(h.get("telphone"));
		soa.setMember(h.member);
		soa.setCity(h.getInt("city2"));
		soa.setDepartment(h.get("department"));
		soa.setHospitalId(h.getInt("hospital_id"));
		soa.setHospital(h.get("hospital"));
		soa.setZipcode(h.get("zipcode"));
		soa.setSor_id(h.getInt("sor_id"));
		soa.set();
		//收货人 -- 收货人改为后台设置，用户选择  此表废弃
//		ShopOrderRecipient sor = ShopOrderRecipient.find(h.getInt("sor_id"));
//		sor.setConsignees(h.get("consignees"));
//		sor.setMobile(h.get("mobile"));
//		sor.setTelphone(h.get("telphone"));
//		sor.setMember(h.member);
//		sor.set();
	}
	
	/**
	 * 发票
	 * @throws SQLException 
	 * */
	private String insertNvoice(Http h) throws SQLException{
		/*ShopNvoice sn = ShopNvoice.getObjByMember(h.member);
		sn.setTelphone(h.get("telphone"));
		sn.setAddress(h.get("address"));
		sn.setCompany(h.get("company"));
		sn.setConsignees(h.get("consignees"));
		sn.setMember(h.member);
		sn.setRemark(h.get("remark"));
		sn.set();
		ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(h.get("orderid"));
		sod.setN_address(h.get("address"));
		sod.setN_telphone(h.get("telphone"));
		sod.setN_company(h.get("company"));
		sod.setN_consignees(h.get("consignees"));
		sod.setN_remark(h.get("remark"));
		sod.set();
		ShopOrder so = ShopOrder.findByOrderId(h.get("orderid"));
		so.set("invoiceStatus","1");*/
		
		String ids=h.get("ids");//订单表id
		String nums=h.get("nums");//索要发票数量
		String amounts=h.get("amounts");//索要发票金额
		int hospitalid=h.getInt("hospitalid");//医院id
		ShopHospital shophospital=ShopHospital.find(hospitalid);
		String hospital=shophospital.getName();//医院
		String consignees=h.get("consignees");//发票接收人
		String telphone=h.get("telphone");//收票人电话
		String address=h.get("address");//收票人地址
		String remark=h.get("remark");//备注
		float totalamount=h.getFloat("totalamount");//申请总金额
		int totalnum=h.getInt("totalnum");//申请总数量
		Profile profile=Profile.find(h.member);
		
		int applyUnit = 0;

		//添加发票附加表
		int puid = 0;
		String[] idarr=ids.split(",");
		if(idarr!=null){
			for(int i=0;i<idarr.length;i++) {
				int oid = Integer.parseInt(idarr[i]);//订单表id
				ShopOrder order = ShopOrder.find(oid);//订单表
				puid = order.getPuid();
			}
		}

		/*ArrayList<Invoice> invoices = Invoice.find(" AND member=" + h.member + " order by createdate desc ", 0, 1);
		if(invoices.size()>0){
            Invoice invoice = invoices.get(0);
            Date createDate = invoice.getCreatedate();
            Date date = new Date(System.currentTimeMillis() - 2 * 60 * 1000);
            if(date.before(createDate)){
               return  "0";
            }
        }*/
		//添加发票主表
		Invoice invoice=new Invoice(0);
		invoice.setStatus(0);//状态，未开票
		invoice.setMember(h.member);//索要发票人
		invoice.setHospitalid(hospitalid);//医院id
		invoice.setHospital(hospital);//医院
		invoice.setConsigness(consignees);//收票人
		invoice.setAddress(address);//收票人地址
		invoice.setTelphone(telphone);//收票人电话
		invoice.setCreatedate(new Date());//索要时间
		invoice.setNum(totalnum);//数量
		invoice.setAmount(totalamount);//金额
		invoice.setRemark(remark);//备注
		invoice.setActivity(h.get("activity"));
		invoice.setMembername(profile.member);




		invoice.setPuid(puid);

		invoice.set();
		//发送短信
		String user = Profile.find(h.member).getMember();
		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+invoice.getPuid(),0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.syfp);
			if(!"".equals(MT.f(mobiles.toString())))
				SMSMessage.create("Home", user, mobiles.toString(), h.language, hospital+"索要发票"+totalnum+"粒，请及时处理。");
		}

		String[] numarr=nums.split(",");
		Map map = new HashMap();//存储索要数量
		for(int i=0;i<numarr.length;i++){
			map.put(idarr[i], numarr[i]);
		}
		String[] amountarr=amounts.split(",");
		Map map2 = new HashMap();//存储索要金额
		for(int i=0;i<amountarr.length;i++){
			map2.put(idarr[i], amountarr[i]);
		}
		for(int i=0;i<idarr.length;i++){
			int oid=Integer.parseInt(idarr[i]);//订单表id
			ShopOrder order=ShopOrder.find(oid);//订单表
			applyUnit = order.getApplyUnit();
			InvoiceData data=new InvoiceData(0);//附加表
			data.setInvoiceid(invoice.getId());//主表id
			data.setOrderid(order.getOrderId());//订单id
			int anum=Integer.parseInt(map.get(String.valueOf(oid)).toString());
			data.setNum(anum);//数量
			float aamount=Float.parseFloat(map2.get(String.valueOf(oid)).toString());
			data.setAmount(aamount);//金额
			data.setStatus(0);//和主表状态一致
			data.set();
			
			//改变订单表的未开票数量和未开票金额
			
			//改变订单表的invoicestatus
			int weinum=0;//未开数量
			int yinum=0;//已开数量
			
			float weiamount=0;//未开金额
			float yiamount=0;//已开金额
			
			List<InvoiceData> lstdata=InvoiceData.find(" and orderid = "+Database.cite(order.getOrderId())+" and status in(0,1,2,4,6)", 0, Integer.MAX_VALUE);
			if(lstdata.size()>0){
				for(int j=0;j<lstdata.size();j++){
					InvoiceData d=lstdata.get(j);
					yinum+=d.getNum();
					yiamount+=d.getAmount();
				}
			}
			List<ShopOrderData> lstorderdata=ShopOrderData.find(" and order_id= "+Database.cite(order.getOrderId()), 0, 1);
			
			ShopOrderData orderdata=lstorderdata.get(0);
			weinum=orderdata.getQuantity()-yinum;
			weiamount=orderdata.getAgent_amount()-yiamount;
			
			/*if(weinum==0){
				order.set("invoiceStatus","1");
			}*/
			order.set("noinvoicenum", String.valueOf(weinum));//赋值未开票数量
			order.set("noinvoiceamount", String.valueOf(weiamount));//设置未开票金额
			order.set("invoiceStatus", "1");//发票状态改为已索要

			invoice.setApplyUnit(applyUnit);
			
			invoice.set();
		}

		return "1";
		
	}
	
}
