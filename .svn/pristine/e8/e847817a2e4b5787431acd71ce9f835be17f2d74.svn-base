package tea.ui.yl.shopnew;

import org.json.JSONObject;
import tea.db.DbAdapter;
import tea.entity.Database;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.Seq;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.*;
import tea.entity.yl.shopnew.*;
import util.Config;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

//import com.yk.utils.JxlsUtils;
//import test.TestJxlsUtils;

public class ReplyMoneys extends HttpServlet
{
    /* (non-Javadoc)
     * @see javax.servlet.http.HttpServlet#service(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        ServletContext application = this.getServletContext();
        HttpSession session = request.getSession(true);
        if("expbackinvoice".equals(act)){

        	try{
        		
        		response.setContentType("application/x-msdownload");
        		response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("回款" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("回款匹配发票", 0);
                int index = 0;
                	ws.addCell(new jxl.write.Label(index++, 0, "回款编号"));
                    ws.addCell(new jxl.write.Label(index++, 0, "类型"));
                    ws.addCell(new jxl.write.Label(index++, 0, "回款单位"));
                    
                    ws.addCell(new jxl.write.Label(index++, 0, "服务商"));
                    ws.addCell(new jxl.write.Label(index++, 0, "回款金额"));
                    
                    ws.addCell(new jxl.write.Label(index++, 0, "服务商匹配金额"));
                    ws.addCell(new jxl.write.Label(index++, 0, "挂款金额"));
                    ws.addCell(new jxl.write.Label(index++, 0, "应收账款"));
                    ws.addCell(new jxl.write.Label(index++, 0, "剩余应收账款"));
                    ws.addCell(new jxl.write.Label(index++, 0, "回款时间"));
                    ws.addCell(new jxl.write.Label(index++, 0, "状态"));
                    ws.addCell(new jxl.write.Label(index++, 0, "进项税返还政策"));
                    
                String sql = h.get("sql");
                List<BackInvoice> lstback=BackInvoice.find(sql.toString()+" order by createdate desc ", 0, Integer.MAX_VALUE);
                int hang=1;
                for(int i=0;i<lstback.size();i++)
                {
                	
                  BackInvoice t= lstback.get(i);
                  ShopHospital hospital=ShopHospital.find(t.getHospitalid());//回款单位
            	  Profile profile=Profile.find(t.getMember());//服务商
            	  String replyids=t.getReplyid();//回款id
            	  String[] replyidarr=replyids.split(",");
              	index = 0;
              	
              	for(int j=0;j<replyidarr.length;j++){
              		
          		  String re=replyidarr[j];
          		  ReplyMoney reply=ReplyMoney.find(Integer.parseInt(re));//回款
          		  
          		 if(replyidarr.length>1){
          			 index=0;
          		 }
          			  
	      			ws.addCell(new jxl.write.Label(index++, hang,MT.f(reply.getCode())));
	    			ws.addCell(new jxl.write.Label(index++, hang,ReplyMoney.typeARR[reply.getType()]));
	    			//if(j==replyidarr.length-1)
	    			ws.mergeCells(index,hang,index,hang+replyidarr.length-1); //回款单位合并单元格
	    			ws.addCell(new jxl.write.Label(index++, hang,MT.f(hospital.getName())));
	    			//if(j==replyidarr.length-1)
	    			ws.mergeCells(index,hang,index,hang+replyidarr.length-1); //服务商合并单元格
	    			ws.addCell(new jxl.write.Label(index++, hang,MT.f(profile.member)));
	    			ws.addCell(new jxl.write.Label(index++, hang,ShopHospital.getDecimal((double)reply.getReplyPrice())));
	    			//if(j==replyidarr.length-1)
	    			ws.mergeCells(index,hang,index,hang+replyidarr.length-1); //服务商匹配金额合并单元格
	    			ws.addCell(new jxl.write.Label(index++, hang,ShopHospital.getDecimal((double)t.getMatchamount())));
	    			//if(j==replyidarr.length-1)
	    			ws.mergeCells(index,hang,index,hang+replyidarr.length-1); //服务商挂款合并单元格
	    			ws.addCell(new jxl.write.Label(index++, hang,ShopHospital.getDecimal((double)t.getHangamount())));
	    			//if(j==replyidarr.length-1)
	    			ws.mergeCells(index,hang,index,hang+replyidarr.length-1); //应收账款合并单元格
	    			ws.addCell(new jxl.write.Label(index++, hang,ShopHospital.getDecimal((double)t.getOldnoreply())));
	    			//if(j==replyidarr.length-1)
	    			ws.mergeCells(index,hang,index,hang+replyidarr.length-1); //剩余应收账款合并单元格
	    			ws.addCell(new jxl.write.Label(index++, hang,ShopHospital.getDecimal((double)t.getSoldnoreply())));
	    			ws.addCell(new jxl.write.Label(index++, hang,MT.f(reply.getReplyTime())));
	    			//if(j==replyidarr.length-1)
	    			ws.mergeCells(index,hang,index,hang+replyidarr.length-1); //状态合并单元格
	    			ws.addCell(new jxl.write.Label(index++, hang,BackInvoice.STATUS[t.getStatus()]));
	    			//if(j==replyidarr.length-1)
	    			ws.mergeCells(index,hang,index,hang+replyidarr.length-1); //进项税返还政策合并单元格
	    			ws.addCell(new jxl.write.Label(index++, hang,Profile.TAX[Integer.parseInt(MT.f(profile.tax,0))]));
	    			hang++;
          		 
          		  
    			}
                }
	            wwb.write();
	            wwb.close();
	            os.close();
	            return;
            }catch (Exception e) {
			}
        
        }else if("expConfirm".equals(act)){
			try{
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("客户回款确认明细表" + ".xls", "UTF-8"));
                ServletOutputStream os = response.getOutputStream();

                Map<String, Object> dataMap = new HashMap<String, Object>();

                int status = h.getInt("status");
                String expSql = " and status="+status;
                int sum=BackInvoice.count(expSql);
                if (sum > 0) {
                	List<Map<String,Object>> backList = new ArrayList<Map<String,Object>>();
                    List<BackInvoice> lstback=BackInvoice.find(expSql+" order by createdate desc ", 0, 60000);
                    for(int i=0;i<lstback.size();i++) {
						Map<String,Object> backMap = new HashMap<String, Object>();
						backMap.put("sn", i + 1);

                        BackInvoice back = lstback.get(i);
						ShopHospital hospital = ShopHospital.find(back.getHospitalid());
						backMap.put("hostpital_name", MT.f(hospital.getName()));//客户汇款名称：医院的名称
						backMap.put("hostpital_code", MT.f(hospital.getH_code()));//客户编号：医院的客商编码
						String provider = Profile.find(back.getMember()).member;
						backMap.put("provider", provider);//代理商：服务商名称

						List<Map<String,Object>> replyMoneyList = new ArrayList<Map<String,Object>>();

                        String[] replyidarr=back.getReplyid().split(",");
                        String[] invoiceidarr=back.getInvoiceid().split(",");
                        int showCount = replyidarr.length>invoiceidarr.length ? replyidarr.length : invoiceidarr.length;
                        if(replyidarr.length < showCount){
							String[] tmp = new String[showCount];
							System.arraycopy(replyidarr, 0, tmp, 0, replyidarr.length);
							replyidarr = tmp;
						}
                        if(invoiceidarr.length < showCount){
							String[] tmp = new String[showCount];
							System.arraycopy(invoiceidarr, 0, tmp, 0, invoiceidarr.length);
							invoiceidarr = tmp;
						}
                        for(int j=0;j<replyidarr.length;j++) {
							Map<String,Object> replyMoneyMap = new HashMap<String, Object>();
                        	String date = "";
                        	String price = "";
                            if (replyidarr[j] != null && replyidarr[j].length() > 0) {
                                int replyMoneyId = Integer.parseInt(replyidarr[j]);
                                ReplyMoney replyMoney = ReplyMoney.find(replyMoneyId);//回款
								date = MT.f(replyMoney.getReplyTime());
								price = replyMoney.getReplyPrice()+"";
                            }
							replyMoneyMap.put("date", date);//电划单日期：回款日期
							replyMoneyMap.put("price", price);//电划单金额：回款金额
							replyMoneyList.add(replyMoneyMap);
                        }
						backMap.put("replyMoneys", replyMoneyList);//回款列表

						List<Map<String,Object>> invoiceList = new ArrayList<Map<String,Object>>();
                        for(int k=0;k<invoiceidarr.length;k++) {
							Map<String,Object> invoiceMap = new HashMap<String, Object>();
							String date = "";
							String no = "";
							String amount = "";
                            if (invoiceidarr[k] != null && invoiceidarr[k].length() > 0) {
                                int invoiceId = Integer.parseInt(invoiceidarr[k]);
                                Invoice invoice = Invoice.find(invoiceId);//发票
								date = MT.f(invoice.getMakeoutdate());
								no = MT.f(invoice.getInvoiceno());
								amount = invoice.getAmount() + "";
                            }
							invoiceMap.put("date", date);//单据日期：开票日期
							invoiceMap.put("no", no);
							invoiceMap.put("amount", amount);
							invoiceList.add(invoiceMap);
                        }
						backMap.put("invoices", invoiceList);//发票列表
						backMap.put("confirm", "");
						backList.add(backMap);
                    }
					dataMap.put("backInvoices", backList);
                }
				String tempPath = Http.REAL_PATH + "/jsp/yl/temp/expConfirmTemp.xls";
                //JxlsUtils.exportExcel(tempPath, os, dataMap);
                //InputStream is = (InputStream) (new FileInputStream("E:\\pro\\IdeaProjects\\jxls_export_demo\\src\\main\\java\\resources\\org\\jxls\\demo\\each-merge.xls"));
                //JxlsUtils.exportExcel(is,os, TestJxlsUtils.generateData());
				//JxlsUtils.exportExcel("E:\\pro\\IdeaProjects\\jxls_export_demo\\src\\main\\java\\resources\\org\\jxls\\demo\\each-merge.xls","d:\\test2.xls", TestJxlsUtils.generateData());
                os.close();
				return;
			}catch (Exception e) {
			}
		}
        if("exp_replymoney".equals(act)){
        	try{
        		
        		response.setContentType("application/x-msdownload");
        		response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("回款" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("回款", 0);
                int index = 0;
                	ws.addCell(new jxl.write.Label(index++, 0, "回款编号"));
                    ws.addCell(new jxl.write.Label(index++, 0, "医院"));
                    ws.addCell(new jxl.write.Label(index++, 0, "回款金额"));
                    
                    ws.addCell(new jxl.write.Label(index++, 0, "类型"));
                    ws.addCell(new jxl.write.Label(index++, 0, "汇款时间"));
                    
                    ws.addCell(new jxl.write.Label(index++, 0, "回款状态"));
                    ws.addCell(new jxl.write.Label(index++, 0, "匹配状态"));
                    ws.addCell(new jxl.write.Label(index++, 0, "创建日期"));
                    
                    
                    
                String sql = h.get("sql");
                List<ReplyMoney> rmlist  =ReplyMoney.find(sql,0,Integer.MAX_VALUE);
                for(int i=0;i<rmlist.size();i++)
                {
              	  ReplyMoney t= rmlist.get(i);
                  ShopHospital sh1 = ShopHospital.find(t.getHid());
              	index = 0;
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(t.getCode())));
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(sh1.getName())));
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(t.getReplyPrice())));
    			ws.addCell(new jxl.write.Label(index++, i+1,ReplyMoney.typeARR[t.getType()]));
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(t.getReplyTime())));
    			ws.addCell(new jxl.write.Label(index++, i+1,ReplyMoney.statusARR[t.getStatus()]));
    			ws.addCell(new jxl.write.Label(index++, i+1,ReplyMoney.statusmemberARR[t.getStatusmember()]));
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(t.getTime(),1)));
                }
	            wwb.write();
	            wwb.close();
	            os.close();
	            return;
            }catch (Exception e) {
			}
        }
        if("exp_replymoneynew".equals(act)){
        	try{
        		
        		response.setContentType("application/x-msdownload");
        		response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("回款" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("回款", 0);
                int index = 0;
                	ws.addCell(new jxl.write.Label(index++, 0, "回款编号"));
                    ws.addCell(new jxl.write.Label(index++, 0, "医院"));
                    ws.addCell(new jxl.write.Label(index++, 0, "回款金额"));
                    
                    ws.addCell(new jxl.write.Label(index++, 0, "类型"));
                    ws.addCell(new jxl.write.Label(index++, 0, "汇款时间"));
                    
                    ws.addCell(new jxl.write.Label(index++, 0, "匹配状态"));
                    ws.addCell(new jxl.write.Label(index++, 0, "创建日期"));
                    
                    
                    
                String sql = h.get("sql");
                List<RemainReplyMoney> rmlist  =RemainReplyMoney.find(sql,0,Integer.MAX_VALUE);
                for(int i=0;i<rmlist.size();i++)
                {
                  RemainReplyMoney t= rmlist.get(i);
                  ReplyMoney rm=ReplyMoney.find(t.getReplyid());
                  ShopHospital sh1 = ShopHospital.find(t.getHid());
              	index = 0;
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(rm.getCode())));
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(sh1.getName())));
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(t.getAmount())));
    			ws.addCell(new jxl.write.Label(index++, i+1,RemainReplyMoney.typeARR[t.getType()]));
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(rm.getReplyTime())));
    			ws.addCell(new jxl.write.Label(index++, i+1,RemainReplyMoney.statusmemberARR[t.getStatusmember()]));
    			ws.addCell(new jxl.write.Label(index++, i+1,MT.f(t.getTime(),1)));
                }
	            wwb.write();
	            wwb.close();
	            os.close();
	            return;
            }catch (Exception e) {
			}
        }
        PrintWriter out = response.getWriter();
        JSONObject jo = new JSONObject();
       try {
    	   if("matchinvoiceajax".equals(act)){
           	//服务商回款匹配发票
           	int member=h.getInt("member");//服务商id
           	int hospitalid=h.getInt("hospitalid");//医院id
           	String replyid=h.get("replyid");//回款id
           	String invoiceid=h.get("invoiceid");//选择的发票id
           	float replyamount=h.getFloat("replyamount");//回款金额
           	float hangamount=h.getFloat("hangamount");//挂款金额
           	float matchamount=h.getFloat("matchamount");//已匹配金额
           	float oldnoreply=(float)h.getDouble("oldnoreply");//应收账款
           	float soldnoreply=(float)h.getDouble("soldnoreply");//剩余应收账款
			   int backflag = h.getInt("backflag");//后台添加为1
           	BackInvoice back=BackInvoice.find(0);
           	if(backflag!=1){
				back.setMember(member);
			}

           	int puid = h.getInt("puid");
           	back.setPuid(puid);

           	boolean qianflag = false;
           	String qianstr = "";
           	int qian = 0;
           	String qianinvoiceid = h.get("qianinvoiceid",",");
        	String[] invoiceidarr=invoiceid.split(",");
           	String [] qianinvoiceids = qianinvoiceid.split(",");
           	if(qianinvoiceids.length>0) {
           		for (int i = 0; i < qianinvoiceids.length; i++) {
           			if(invoiceid.indexOf(""+qianinvoiceids[i])!=-1) {
           				qian++;
           			}else {
           				qianstr += ","+qianinvoiceids[i];
           			}
				}
           		if(qian!=qianinvoiceids.length) {
           			qianflag = true;
           		}
           	}

           	/*String [] ishuanids = h.getValues("ishuanid");
           	if(ishuanids!=null) {
           		for (int i = 0; i < ishuanids.length; i++) {
           			ishuans += ishuanids[i]+",";
                    DeductionRecord dr = DeductionRecord.findByIid(Integer.parseInt(ishuanids[i]));
                    huansum += dr.getDeductprice();
           			//huansum += BackInvoice.findQianKuai(","+ishuanids[i]);
				}
           		if(ishuans.length()>0) {
           			back.setHuanid(ishuans);
           			back.setHuanamount(huansum);
           		}
           	}*/
           	float kou = 0;


           	String [] kous = MT.f(qianstr).split(",");
           	for(int i=1;i<kous.length;i++){
				if(kous[i]!="") {
					int in = Integer.parseInt(kous[i]);
					long daycha = Invoice.finddaycha(in);
					float invoiceWithhold = BackInvoice.invoiceWithhold(in,daycha);

					kou += invoiceWithhold;
				}
			}

           	//float kou = BackInvoice.findQianKuai(qianstr);
               String ishuans = "";//还款的id
               float huansum = 0;//还款的金额
           	float fwf = 0;//服务费



			   int fwsmember = 0;

           	for(int i=0;i<invoiceidarr.length;i++){
           		if(invoiceidarr[i]!=""){
           			int in=Integer.parseInt(invoiceidarr[i]);
                    Invoice invoice = Invoice.find(in);

					fwsmember = invoice.getMember();

                    if(invoice.getDeductionstype()==1){//已扣款 未还款
                        DeductionRecord dr = DeductionRecord.findByIid(in);
                        huansum += dr.getDeductprice();
                        ishuans += in+",";
                    }

           			float myfwf = Invoice.findfwf(in);
           			fwf += myfwf;
           		}
           	}
			   if(backflag!=1){
				   back.setMember(fwsmember);
			   }
               if(ishuans.length()>0) {
                   back.setHuanid(ishuans);
                   back.setHuanamount(huansum);
               }
           	if(qianflag) {//有未选
           	
               	if(kou>fwf) {//扣款比服务费还多
               		jo.put("type", "2");
               		jo.put("mes", "扣款金额大于服务费请重新选择！");
             	   out.print(jo.toString());
             	   return;
               	}
               	back.setQianamount(kou);
               	back.setQianinvoiceid(qianstr);
               	
            	for(int i=0;i<invoiceidarr.length;i++){
               		if(invoiceidarr[i]!=""){
               			int in=Integer.parseInt(invoiceidarr[i]);
               			Invoice inv=Invoice.find(in);
               			//inv.set("matchstatus", "1");//待审核
               			inv.setMatchstatus(1);
               			inv.set();
               		}
               	}
               	
           	}



           	
           	back.setHospitalid(hospitalid);
           	back.setCreatedate(new Date());
           	back.setReplyid(replyid);
           	back.setInvoiceid(invoiceid);
           	back.setStatus(0);//待审核
           	back.setReplyamount(replyamount);
           	back.setHangamount(hangamount);
           	back.setMatchamount(matchamount);
           	back.setOldnoreply(oldnoreply);
           	back.setSoldnoreply(soldnoreply);
           	back.set();



			   for(int i=1;i<kous.length;i++){
				   if(kous[i]!="") {
					   int in = Integer.parseInt(kous[i]);

					   long daycha = Invoice.finddaycha(in);
					   float invoiceWithhold = BackInvoice.invoiceWithhold(in,daycha);
					   DeductionRecord dr = DeductionRecord.find(0);
					   dr.setDeductprice(invoiceWithhold);
					   dr.setTime(new Date());
					   dr.setBid(back.getId());
					   dr.setIid(in);
					   dr.set();
				   }
			   }


           	//产生一条挂款记录
           	/*ReplyMoney reply=ReplyMoney.find(0);
           	reply.setHid(hospitalid);//医院id
           	reply.setReplyTime(new Date());//回款时间
           	reply.setReplyPrice(hangamount);//金额
           	reply.setType(1);//挂款
           	reply.setStatus(0);//待审核
           	reply.setStatusmember(0);//未通知服务商
           	reply.setCode("HK"+Seq.get());//回款编号
           	reply.setTime(new Date());//创建时间
           	reply.setMember(member);//创建人
           	reply.setProfile(member);//服务商
           	reply.set();
           	
           	back.set("hangid", String.valueOf(reply.getId()));//赋值挂款id
   */            	
           	//改变回款的状态
           	String[] replyidarr=replyid.split(",");
           	for(int i=0;i<replyidarr.length;i++){
           		int re=Integer.parseInt(replyidarr[i]);
           		ReplyMoney rem=ReplyMoney.find(re);
           		rem.set("statusmember", "2");//待审核
           	}
           	//改变发票的是否匹配字段
           	//String[] invoiceidarr=invoiceid.split(",");
           	for(int i=0;i<invoiceidarr.length;i++){
           		if(invoiceidarr[i]!=""){
           			int in=Integer.parseInt(invoiceidarr[i]);
               		Invoice inv=Invoice.find(in);
               		inv.set("matchstatus", "1");//待审核
           		}
           	}
           	
           	
           	
           	//发送短信通知
           	String user = Profile.find(h.member).getMember();
           	if(backflag!=1){
				ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+back.getPuid(),0,1);
				if(list.size() > 0){
					ShopSMSSetting sms = list.get(0);
					List<String> mobiles = ShopSMSSetting.getUserMobile(sms.hkfpsh);
					ShopHospital hospital=ShopHospital.find(hospitalid);
					if(!"".equals(MT.f(mobiles.toString())))
						SMSMessage.create("Home", user, mobiles.toString(), h.language, hospital.getName()+"的回款"+ShopHospital.getDecimal((double)replyamount)+"元已匹配发票，匹配"+ShopHospital.getDecimal((double)matchamount)+"元，挂款"+ShopHospital.getDecimal((double)hangamount)+"元，请审核。");
				}
			}

       		jo.put("type", "0");
       		out.print(jo.toString());
       		return;
           }
       }catch (Exception e) {
    	   e.printStackTrace();
    	   jo.put("type", "1");
    	   out.print(jo.toString());
    	   return;
	}
       
        
        if("searchbackinvoice".equals(act)){
        	int hid=h.getInt("hid");
        	List<BackInvoice> lstback=BackInvoice.find(" and hospitalid="+hid+" and status = 0 ", 0, Integer.MAX_VALUE);
        	if(lstback.size()==0){
        		out.print("0");
        	}else{
        		out.print("1");
        	}
        	return;
        }
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            int rid = h.getInt("rid");
            int puid = h.getInt("puid");
            if ("edit".equals(act))
            {
            	int add_type = h.getInt("type");
            	int hid = h.getInt("hid");
                ReplyMoney t = ReplyMoney.find(rid);
               if(t.getId()==0){
            	   t.setMember(h.member);
                   t.setStatus(3); // 新增时: 改为待提交状态
                   t.setTime(new Date());
                   t.setCode("HK"+Seq.get());
                   t.setType(0);
                   t.setPuid(puid);
               }else{
            	   /*if(t.getStatus()==2){
            		   t.setStatus(0);
            	   }*/
               }
               
               t.setReplyTime(h.getDate("replyTime"));
               
               t.setContext(h.get("context"));
               t.setReplyPrice(h.getFloat("replyPrice"));
               t.setHid(hid);
               t.setAdd_type(add_type);
               t.set();

            } else if ("del".equals(act))
            {
            	ReplyMoney.delete(rid);
            }else if("sub".equals(act)){
                ReplyMoney t = ReplyMoney.find(rid);
                ReplyMoney.submission(rid);
                // 提交审核 发送信息
                sendMessage(h, t);
            }else if("status".equals(act)){
            	int status = h.getInt("status");
            	ReplyMoney t = ReplyMoney.find(rid);
            	t.setStatus(status);
            	String content="";//短信内容
            	ShopHospital hospital=ShopHospital.find(t.getHid());
            	String hname=hospital.getName();//医院名称
            	if(status==2){
            		t.setReturnStr(h.get("returnStr"));
            		t.setThmember(h.member);
            		content=hname+"回款"+t.getReplyPrice()+"审核不通过。原因："+h.get("returnStr")+"。";
            	}else{
            		content=hname+"回款"+t.getReplyPrice()+"审核通过。";
            	}
            	
            	t.set();
            	//发送短信
            	String user = Profile.find(h.member).getMember();
        		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+t.getPuid(),0,1);
        		if(list.size() > 0){
        			ShopSMSSetting sms = list.get(0);
        			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.hkshwc);
        			if(!"".equals(MT.f(mobiles.toString())))
        				SMSMessage.create("Home", user, mobiles.toString(), h.language, content);
        		}
        		//回款通过后，改变当前医院的应收回款（减少应收回款的数额）
        		if(status==1){
        			ChangeYingshouData.jianyingshou2(t.getHid(), t.getReplyPrice(), t.getReplyTime(), h.member, t.getId());
        		}
        		
        		
            }else if("statusmember".equals(act)){//短信通知服务商
            	String [] rids = h.getValues("rids");
            	String hids="";//保存所有的医院id，用逗号分隔
            	for (int i = 0; i < rids.length; i++) {
					ReplyMoney r1 = ReplyMoney.find(Integer.parseInt(rids[i]));
					
					int hid=r1.getHid();//获取医院
					if(hids.indexOf(String.valueOf(hid))<0){
						
						hids+=hid+",";
					}
					//给服务商id赋值
					List<Profile> lstpro=Profile.find1(" and hospitals like "+Database.cite("%|"+hid+"|%"), 0, 1);//一个医院只有一个服务商
					if(lstpro.size()>0){
						Profile profile=lstpro.get(0);
						r1.setProfile(profile.profile);
						r1.setStatusmember(1);//改变匹配状态:已通知回款
						r1.set();
					}


					//高科
					if(Config.getInt("gaoke")==r1.getPuid()) {
						BackInvoice bi = BackInvoice.findHangId(r1.getId());
						int bid = bi.getId();
						//int bid = HangWith.findbid(r1.getId());
						float replyPrice = HangWith.findReplyPricePriceBid(bid);//原始金额
						float deductprice = HangWith.findDeductPriceBid(bid);//修改回款金额
						//如果修改过
						if(deductprice>0){
							r1.setReplyPrice(deductprice);
							r1.set();
						}
					}


				}



            	//根据医院id获取服务商
            	
            	String[] hidarr=hids.split(",");
            	for(int i=0;i<hidarr.length;i++){
            		String hid=hidarr[i];
            		ShopHospital hospital=ShopHospital.find(Integer.parseInt(hid));
            		List<Profile> lstpro=Profile.find1(" and hospitals like "+Database.cite("%|"+hid+"|%"), 0, 1);//一个医院只有一个服务商
            		if(lstpro.size()>0){
	            		Profile profile=lstpro.get(0);
	            		//发送短信
	            		SMSMessage.create(h.community, profile.member, profile.mobile, h.language, "您有“"+hospital.getName()+"”的回款需匹配发票。");
	            	}
            	}
            	
            }else if("statusmembernew".equals(act)){//短信通知服务商
            	String [] rids = h.getValues("rids");
            	String hids="";//保存所有的医院id，用逗号分隔
            	for (int i = 0; i < rids.length; i++) {
					RemainReplyMoney r1 = RemainReplyMoney.find(Integer.parseInt(rids[i]));
					
					int hid=r1.getHid();//获取医院
					if(hids.indexOf(String.valueOf(hid))<0){
						
						hids+=hid+",";
					}
					//给服务商id赋值
					List<Profile> lstpro=Profile.find1(" and hospitals like "+Database.cite("%|"+hid+"|%"), 0, 1);//一个医院只有一个服务商
					if(lstpro.size()>0){
						Profile profile=lstpro.get(0);
						r1.setProfile(profile.profile);
						r1.setStatusmember(1);//改变匹配状态:已通知回款
						r1.set();
					}
					
				}
            	//根据医院id获取服务商
            	
            	String[] hidarr=hids.split(",");
            	for(int i=0;i<hidarr.length;i++){
            		String hid=hidarr[i];
            		ShopHospital hospital=ShopHospital.find(Integer.parseInt(hid));
            		List<Profile> lstpro=Profile.find1(" and hospitals like "+Database.cite("%|"+hid+"|%"), 0, 1);//一个医院只有一个服务商
            		if(lstpro.size()>0){
	            		Profile profile=lstpro.get(0);
	            		//发送短信
	            		SMSMessage.create(h.community, profile.member, profile.mobile, h.language, "您有“"+hospital.getName()+"”的回款需匹配发票。");
	            	}
            	}
            	
            }else if("matchinvoice".equals(act)){
            	//服务商回款匹配发票
            	int member=h.getInt("member");//服务商id
            	int hospitalid=h.getInt("hospitalid");//医院id
            	String replyid=h.get("replyid");//回款id
            	String invoiceid=h.get("invoiceid");//选择的发票id
            	float replyamount=h.getFloat("replyamount");//回款金额
            	float hangamount=h.getFloat("hangamount");//挂款金额
            	float matchamount=h.getFloat("matchamount");//已匹配金额
            	float oldnoreply=(float)h.getDouble("oldnoreply");//应收账款
            	float soldnoreply=(float)h.getDouble("soldnoreply");//剩余应收账款
            	BackInvoice back=BackInvoice.find(0);
            	back.setMember(member);
            	
            	back.setHospitalid(hospitalid);
            	back.setCreatedate(new Date());
            	back.setReplyid(replyid);
            	back.setInvoiceid(invoiceid);
            	back.setStatus(0);//待审核
            	back.setReplyamount(replyamount);
            	back.setHangamount(hangamount);
            	back.setMatchamount(matchamount);
            	back.setOldnoreply(oldnoreply);
            	back.setSoldnoreply(soldnoreply);
            	back.set();
            	
            	//产生一条挂款记录
            	/*ReplyMoney reply=ReplyMoney.find(0);
            	reply.setHid(hospitalid);//医院id
            	reply.setReplyTime(new Date());//回款时间
            	reply.setReplyPrice(hangamount);//金额
            	reply.setType(1);//挂款
            	reply.setStatus(0);//待审核
            	reply.setStatusmember(0);//未通知服务商
            	reply.setCode("HK"+Seq.get());//回款编号
            	reply.setTime(new Date());//创建时间
            	reply.setMember(member);//创建人
            	reply.setProfile(member);//服务商
            	reply.set();
            	
            	back.set("hangid", String.valueOf(reply.getId()));//赋值挂款id
*/            	
            	//改变回款的状态
            	String[] replyidarr=replyid.split(",");
            	for(int i=0;i<replyidarr.length;i++){
            		int re=Integer.parseInt(replyidarr[i]);
            		ReplyMoney rem=ReplyMoney.find(re);
            		rem.set("statusmember", "2");//待审核
            	}
            	//改变发票的是否匹配字段
            	String[] invoiceidarr=invoiceid.split(",");
            	for(int i=0;i<invoiceidarr.length;i++){
            		if(invoiceidarr[i]!=""){
            			int in=Integer.parseInt(invoiceidarr[i]);
                		Invoice inv=Invoice.find(in);
                		inv.set("matchstatus", "1");//待审核
            		}
            	}
            	
            	
            	
            	//发送短信通知
            	String user = Profile.find(h.member).getMember();
        		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+back.getPuid(),0,1);
        		if(list.size() > 0){
        			ShopSMSSetting sms = list.get(0);
        			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.hkfpsh);
        			ShopHospital hospital=ShopHospital.find(hospitalid);
        			if(!"".equals(MT.f(mobiles.toString())))
        				SMSMessage.create("Home", user, mobiles.toString(), h.language, hospital.getName()+"的回款"+ShopHospital.getDecimal((double)replyamount)+"元已匹配发票，匹配"+ShopHospital.getDecimal((double)matchamount)+"元，挂款"+ShopHospital.getDecimal((double)hangamount)+"元，请审核。");
        		}
            }else if("matchinvoicenew".equals(act)){
            	//服务商回款匹配发票
            	int member=h.getInt("member");//服务商id
            	int hospitalid=h.getInt("hospitalid");//医院id
            	String replyid=h.get("replyid");//回款id
            	String invoiceid=h.get("invoiceid");//选择的发票id
            	float replyamount=h.getFloat("replyamount");//回款金额
            	float hangamount=h.getFloat("hangamount");//挂款金额
            	float matchamount=h.getFloat("matchamount");//已匹配金额
            	BackInvoice back=BackInvoice.find(0);
            	back.setMember(member);
            	
            	back.setHospitalid(hospitalid);
            	back.setCreatedate(new Date());
            	back.setReplyid(replyid);
            	back.setInvoiceid(invoiceid);
            	back.setStatus(0);//待审核
            	back.setReplyamount(replyamount);
            	back.setHangamount(hangamount);
            	back.setMatchamount(matchamount);
            	back.set();
            	//改变回款的状态
            	String[] replyidarr=replyid.split(",");
            	for(int i=0;i<replyidarr.length;i++){
            		int re=Integer.parseInt(replyidarr[i]);
            		RemainReplyMoney rem=RemainReplyMoney.find(re);
            		rem.set("statusmember", "2");//待审核
            	}
            	//改变发票的是否匹配字段
            	String[] invoiceidarr=invoiceid.split(",");
            	for(int i=0;i<invoiceidarr.length;i++){
            		int in=Integer.parseInt(invoiceidarr[i]);
            		Invoice inv=Invoice.find(in);
            		inv.set("matchstatus", "1");//待审核
            	}
            	//发送短信通知
            	String user = Profile.find(h.member).getMember();
        		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+back.getPuid(),0,1);
        		if(list.size() > 0){
        			ShopSMSSetting sms = list.get(0);
        			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.hkfpsh);
        			ShopHospital hospital=ShopHospital.find(hospitalid);
        			if(!"".equals(MT.f(mobiles.toString())))
        				SMSMessage.create("Home", user, mobiles.toString(), h.language, hospital.getName()+"的回款"+replyamount+"元已匹配发票，匹配"+matchamount+"元，挂款"+hangamount+"元，请审核。");
        		}
            }else if("backyes".equals(act)){
            	//订单管理员审核通过服务商的回款匹配发票
            	int backid=h.getInt("backid");
            	BackInvoice back=BackInvoice.find(backid);
            	back.set("status", "1");//审核通过
            	back.set("chargestatus", "2");//服务费申请状态：已通过
            	float oldnoreply=back.getOldnoreply();//医院的应收账款
            	float soldnoreply=back.getSoldnoreply();//剩余应收账款（匹配后）
            	//改变开始
            	if(oldnoreply!=soldnoreply){
            		//勾选了应收账款
            		ShopHospital hospital=ShopHospital.find(back.getHospitalid());
            		hospital.set("oldnoreplynew", ShopHospital.getDecimal((double)soldnoreply));
            		//增加改变应收的记录
            		/*SetDataRecord sr=new SetDataRecord(0);
            		sr.setHospitalid(hospital.getId());
            		sr.setIsback(4);
            		sr.setNoinvoice(-1);
            		sr.setNoreply((double)soldnoreply);
            		sr.setMember(h.member);
            		sr.setCreatedate(new Date());
            		sr.setIsinvoice(-1);
            		sr.setStatus(1);//回款改变
            		sr.setReplymoney((double)back.getReplyamount());
            		int count=SetDataRecord.count(" and hospitalid="+hospital.getId());
            		sr.setOrdernum(count+1);
            		sr.set();*/
            	}
            	//改变结束

				float replyPrice = HangWith.findReplyPricePriceBid(back.getId());//原始金额
				float deductprice = HangWith.findDeductPriceBid(back.getId());

				HangWith hw = HangWith.findHw(back.getId());

				if(Config.getInt("gaoke")==back.getPuid()) {//高科

					if(hw.getId()>0){//如果调配过 调整挂款金额
						back.setHangamount(hw.getDeductprice());
					}
				}

            	
            	//形成挂款记录
            	if(back.getHangamount()>0){
            		ReplyMoney reply=ReplyMoney.find(0);
                	reply.setHid(back.getHospitalid());//医院id
                	reply.setReplyTime(new Date());//回款时间
                	reply.setReplyPrice(back.getHangamount());//金额
                	reply.setType(1);//挂款
                	reply.setStatus(1);//已通过审核（不需要财务再次审核了，只需要订单管理员通知服务商即可。）
                	reply.setStatusmember(0);//未通知服务商
                	reply.setCode("GK"+Seq.get());//回款编号（挂款未gk）
                	reply.setTime(new Date());//创建时间
                	reply.setMember(h.member);//创建人(当前审核人作为该笔挂款的创建人）
                	reply.setProfile(back.getMember());//服务商
                	reply.setPuid(back.getPuid());
                	reply.set();
                	back.set("hangid", String.valueOf(reply.getId()));//赋值挂款id
            	}
            	
            	//改变回款状态
            	String[] replyidarr=back.getReplyid().split(",");
            	for(int i=0;i<replyidarr.length;i++){
            		if(replyidarr[i]!=""){
            			int re=Integer.parseInt(replyidarr[i]);
                		ReplyMoney rem=ReplyMoney.find(re);
                		rem.set("statusmember", "3");//已匹配发票
            		}
            		
            	}
            	//改变发票的匹配状态字段
            	String[] invoiceidarr=back.getInvoiceid().split(",");
            	for(int i=0;i<invoiceidarr.length;i++){
            		if(invoiceidarr[i].length()>0){
            			int in=Integer.parseInt(invoiceidarr[i]);
                		Invoice inv=Invoice.find(in);
                		inv.set("matchstatus", "2");//已匹配
            		}
            		
            	}
            	
            	//改变发票的匹配状态字段
            	String[] qianinvoiceids=MT.f(back.getQianinvoiceid(),",").split(",");
            	for(int i=0;i<qianinvoiceids.length;i++){
            		if(qianinvoiceids[i].length()>0){
            			int in=Integer.parseInt(qianinvoiceids[i]);
                		Invoice inv=Invoice.find(in);
                		//inv.set("matchstatus", "2");//已匹配
                		//inv.setMatchstatus(2);
                		inv.setDeductionstype(1);
                		inv.set();
            		}
            		
            	}
            	
            	
            	//改变发票的扣款归还状态
            	String[] huanids=MT.f(back.getHuanid(),",").split(",");
            	for(int i=0;i<huanids.length;i++){
            		if(huanids[i].length()>0){
            			int in=Integer.parseInt(huanids[i]);
                		Invoice inv=Invoice.find(in);
                		inv.setDeductionstype(2);//已还
                		inv.set();
            		}
            		
            	}
            	
            	//改变订单已回款粒数
            	String invoiceids=back.getInvoiceid();
            	if(invoiceids.length()>0){
            		invoiceids=invoiceids.substring(0, invoiceids.length()-1);
                	List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid in("+invoiceids+")", 0, Integer.MAX_VALUE);
                	for(int i=0;i<lstdata.size();i++){
                		InvoiceData data=lstdata.get(i);
                		String orderid=data.getOrderid();
                		ShopOrder shoporder=ShopOrder.findByOrderId(orderid);
                		shoporder.set("matchnum", String.valueOf(data.getNum()+shoporder.getMatchnum()));
                	}
            	}
            	//生成服务费申请记录
            	String ccode=askcharge(back.getMember(),back.getHospitalid(),backid);
            	//发送短信通知服务商
            	/*String user = Profile.find(h.member).getMember();
            	Profile fmember=Profile.find(back.getMember());
            	String fmobile=fmember.getMobile();
            	if(!"".equals(fmobile)){
            		SMSMessage.create("Home", user, fmobile, h.language, "编号"+ccode+"的服务费已完成，请开具服务费发票。");
            	}*/
            	
            	
            }else if("backyesnew".equals(act)){
            	//订单管理员审核通过服务商的回款匹配发票
            	int backid=h.getInt("backid");
            	BackInvoice back=BackInvoice.find(backid);
            	back.set("status", "1");//审核通过
            	back.set("chargestatus", "0");//服务费申请状态：未提交
            	//形成挂款记录
            	if(back.getHangamount()>0){
            		RemainReplyMoney reply=RemainReplyMoney.find(0);
                	reply.setHid(back.getHospitalid());//医院id
                	reply.setReplyTime(new Date());//(挂款)回款时间
                	reply.setAmount(back.getHangamount());//金额
                	reply.setType(1);//挂款
                	reply.setStatusmember(0);//未通知服务商
                	reply.setCode("GK"+Seq.get());//回款编号（挂款为gk）
                	reply.setTime(new Date());//创建时间
                	reply.setMember(h.member);//创建人(当前审核人作为该笔挂款的创建人）
                	reply.setProfile(back.getMember());//服务商
                	reply.set();
                	back.set("hangid", String.valueOf(reply.getId()));//赋值挂款id
            	
            	}
            	
            	//改变回款状态
            	String[] replyidarr=back.getReplyid().split(",");
            	for(int i=0;i<replyidarr.length;i++){
            		int re=Integer.parseInt(replyidarr[i]);
            		RemainReplyMoney rem=RemainReplyMoney.find(re);
            		rem.set("statusmember", "3");//已匹配发票
            	}
            	//改变发票的匹配状态字段
            	String[] invoiceidarr=back.getInvoiceid().split(",");
            	for(int i=0;i<invoiceidarr.length;i++){
            		int in=Integer.parseInt(invoiceidarr[i]);
            		Invoice inv=Invoice.find(in);
            		inv.set("matchstatus", "2");//已匹配
            	}
            	//改变订单已回款粒数
            	String invoiceids=back.getInvoiceid();
            	invoiceids=invoiceids.substring(0, invoiceids.length()-1);
            	List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid in("+invoiceids+")", 0, Integer.MAX_VALUE);
            	for(int i=0;i<lstdata.size();i++){
            		InvoiceData data=lstdata.get(i);
            		String orderid=data.getOrderid();
            		ShopOrder shoporder=ShopOrder.findByOrderId(orderid);
            		shoporder.set("matchnum", String.valueOf(data.getNum()+shoporder.getMatchnum()));
            	}
            	//发送短信通知服务商
            	String user = Profile.find(h.member).getMember();
            	Profile fmember=Profile.find(back.getMember());
            	String fmobile=fmember.getMobile();
            	if(!"".equals(fmobile)){
            		ShopHospital hospital=ShopHospital.find(back.getHospitalid());
            		SMSMessage.create("Home", user, fmobile, h.language, hospital.getName()+"的回款匹配发票已审核通过，可申请服务费。");
            	}
            	
            	
            }else if("backno".equals(act)){
            	//订单管理员审核不通过服务商的回款匹配发票
            	String nobackreason=h.get("nobackreason");//审核不通过原因
            	
            	int backid=h.getInt("backid");
            	BackInvoice back=BackInvoice.find(backid);
            	back.set("status","2");//审核不通过
            	back.set("nobackreason",nobackreason);
            	//改变回款状态
            	String[] replyidarr=back.getReplyid().split(",");
            	for(int i=0;i<replyidarr.length;i++){
            		int re=Integer.parseInt(replyidarr[i]);
            		ReplyMoney rem=ReplyMoney.find(re);
            		rem.set("statusmember", "1");//审核不通过状态变为之前的未匹配发票
            	}
            	//改变发票的匹配状态字段
            	String[] invoiceidarr=back.getInvoiceid().split(",");
            	for(int i=0;i<invoiceidarr.length;i++){
            		if(invoiceidarr[i].length()>0){
            			int in=Integer.parseInt(invoiceidarr[i]);
                		Invoice inv=Invoice.find(in);
                		inv.set("matchstatus", "0");//变为回款未匹配发票的状态
            		}
            	}
            	
            	//改变发票的匹配状态字段
            	String[] qianinvoiceids=MT.f(back.getQianinvoiceid(),",").split(",");
            	for(int i=0;i<qianinvoiceids.length;i++){
            		if(qianinvoiceids[i].length()>0){
            			int in=Integer.parseInt(qianinvoiceids[i]);
                		Invoice inv=Invoice.find(in);
                		inv.setMatchstatus(0);
                		inv.set();
            		}
            		
            	}
            	
            	//发送短信通知服务商
            	String user = Profile.find(h.member).getMember();
            	Profile fmember=Profile.find(back.getMember());
            	String fmobile=fmember.getMobile();
            	if(!"".equals(fmobile)){
            		ShopHospital hospital=ShopHospital.find(back.getHospitalid());
            		SMSMessage.create("Home", user, fmobile, h.language, hospital.getName()+"的回款匹配发票审核不通过，原因："+nobackreason);
            	}
            }else if("backnonew".equals(act)){
            	//订单管理员审核不通过服务商的回款匹配发票
            	String nobackreason=h.get("nobackreason");//审核不通过原因
            	
            	int backid=h.getInt("backid");
            	BackInvoice back=BackInvoice.find(backid);
            	back.set("status","2");//审核不通过
            	back.set("nobackreason",nobackreason);
            	//改变回款状态
            	String[] replyidarr=back.getReplyid().split(",");
            	for(int i=0;i<replyidarr.length;i++){
            		int re=Integer.parseInt(replyidarr[i]);
            		RemainReplyMoney rem=RemainReplyMoney.find(re);
            		rem.set("statusmember", "1");//审核不通过状态变为之前的未匹配发票
            	}
            	//改变发票的匹配状态字段
            	String[] invoiceidarr=back.getInvoiceid().split(",");
            	if(invoiceidarr.length>0){
            		for(int i=0;i<invoiceidarr.length;i++){
                		if(invoiceidarr[i].length()>0){
                			int in=Integer.parseInt(invoiceidarr[i]);
                    		Invoice inv=Invoice.find(in);
                    		inv.set("matchstatus", "0");//变为回款未匹配发票的状态
                		}
                	}
            	}
            	//发送短信通知服务商
            	String user = Profile.find(h.member).getMember();
            	Profile fmember=Profile.find(back.getMember());
            	String fmobile=fmember.getMobile();
            	if(!"".equals(fmobile)){
            		ShopHospital hospital=ShopHospital.find(back.getHospitalid());
            		SMSMessage.create("Home", user, fmobile, h.language, hospital.getName()+"的回款匹配发票审核不通过，原因："+nobackreason);
            	}
            }else if("statusdd".equals(act)){
            	//订单管理员退回回款(10.23加)
            	int status = h.getInt("status");
            	ReplyMoney t = ReplyMoney.find(rid);
            	t.setStatus(status);
            	String content="";//短信内容
            	ShopHospital hospital=ShopHospital.find(t.getHid());
            	String hname=hospital.getName();//医院名称
            	if(status==2){
            		t.setReturnStr(h.get("returnStr"));
            		t.setThmember(h.member);
            		content=hname+"回款"+t.getReplyPrice()+"审核不通过。原因："+h.get("returnStr")+"。";
            	}
            	t.set();
            	//发送短信
            	String user = Profile.find(h.member).getMember();
        		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+t.getPuid(),0,1);
        		if(list.size() > 0){
        			ShopSMSSetting sms = list.get(0);
        			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.hkshwc);
        			if(!"".equals(MT.f(mobiles.toString())))
        				SMSMessage.create("Home", user, mobiles.toString(), h.language, content);
        		}
        		
        	}
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch (Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    /**
     * 发送短信
     * @param h
     * @param t
     * @throws SQLException
     */
    private void sendMessage(Http h, ReplyMoney t) throws SQLException {
        //短信通知财务审核
        String user = Profile.find(h.member).getMember();
        ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+t.getPuid(),0,1);
        if(list.size() > 0){
             ShopSMSSetting sms = list.get(0);
             List<String> mobiles = ShopSMSSetting.getUserMobile(sms.hkds);
             ShopHospital hos=ShopHospital.find(t.getHid());
             if(!"".equals(MT.f(mobiles.toString())))
                 SMSMessage.create("Home", user, mobiles.toString(), h.language, hos.getName()+"回款"+t.getReplyPrice()+"元，等待审核。");
        }
    }

    /**
     * 添加服务费记录
     * @param pid 服务商id
     * @param hid 医院id
     * @param backin backinvoice的id
     * 
     */
    private static String askcharge(int pid,int hid,int backin){
    	String ccode="";
    	try {
    		//服务商提交服务费申请
        	//获取该服务商的应付服务费公式和进项税返还公式
    		
        	Profile profile=Profile.find(pid);
        	int formula=profile.formula;

        	int tax = 0;
        	
        	
        	String invoiceids="";//发票id
        	//获取发票id
        	
    		BackInvoice back=BackInvoice.find(backin);
    		back.set("chargestatus", "2");//待审核
    		String invoices=back.getInvoiceid();
    		invoiceids+=invoices;
        	
        	String[] invoiceidarr=invoiceids.split(",");
        	//计算服务费
        	//开票总金额1
        	float totalamount=0;
        	//开票总数量
        	int totalnum=0;
        	float fuwufei=0;
        	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        	Date fdate=sdf.parse("2018-05-01 00:00:00");
        	Date fdate2019=sdf.parse("2019-04-01 00:00:00");//开始新公式
			//计算进项税返还
			float jinxiang=0;
        	for(int i=0;i<invoiceidarr.length;i++){
        		if(invoiceidarr[i].length()>0){
        			int inv=Integer.parseInt(invoiceidarr[i]);
            		List<InvoiceData> lstidata=InvoiceData.find(" and invoiceid="+inv, 0, Integer.MAX_VALUE);
            		//计算日期（18年5月前的发票1.17,5月后的发票1.16）
        			Invoice invoi=Invoice.find(inv);

					Invoice io = Invoice.find(inv);
					int phpuid = InvoiceData.getPuid(io.getId());
					//ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, io.getMember());
					//start 2022-3-9 11:07:21 王双瑞添加
					for (InvoiceData lstidatum : lstidata) {

						ArrayList<ShopOrderData> shopOrderData = ShopOrderData.find(" AND order_id=" + Database.cite(lstidatum.getOrderid()), 0, Integer.MAX_VALUE);
						//获取商品id
						int productId = shopOrderData.get(0).getProductId();
						//获取商品的规格id
						ShopProduct shopProduct = ShopProduct.find(productId);
						//通过商品的规格id 查询规格
						ShopProductModel productModel = ShopProductModel.find(shopProduct.model_id);
						ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, io.getMember(),io.getHospitalid(),productModel.getId());
						//end 2022-3-9 11:07:44 王双瑞添加
//						ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, io.getMember(),io.getHospitalid());//

						if(tax==0){
							tax = puj.tax;//厂商
						}


						Date mdate=invoi.getMakeoutdate();//开票日期

						//Map<String,Double> imap =  Invoice.getTaxAmount(tax, inv, 0.9844, 1.13);
						//double mysum = imap.get("chargeamountsum");
						//fuwufei+=mysum;
						//double taxamount = imap.get("taxamount");
						//jinxiang += taxamount;

						//计算日期结束
						for(int j=0;j<lstidata.size();j++){

							InvoiceData idata=lstidata.get(j);
							float am=idata.getAmount();//开票金额
							totalamount+=am;
							int num=idata.getNum();//开票数量
							totalnum+=num;
							String orderid=idata.getOrderid();
							List<ShopOrderData> lstorder=ShopOrderData.find(" and order_id="+Database.cite(orderid), 0, 1);
							ShopOrderData orderdata=lstorder.get(0);//获取订单子表
							float danjia=orderdata.getAgent_price();//单价


							//float myfuwufei = Invoice.getTaxAmount(0,idata.getInvoiceid(),0.9844, 1.13);
							//Map<String,Double> imap =  Invoice.getTaxAmount(0, idata.getInvoiceid(), 0.9844, 1.13);
							//double mysum = imap.get("chargeamountsum");
							//fuwufei+=mysum;
							//套入计算公式
							double fwf = 0;
							if(mdate.getTime()>=fdate2019.getTime()){//最新公式
								fwf = (danjia-puj.agentPriceNew)*0.9844*(am/danjia)/1.13;
							}else {
								if(formula==1){
									//（单价-120）*0.983*（开票金额/单价）/1.17
									if(mdate.getTime()<fdate.getTime()){
										fwf =(danjia-puj.agentPriceNew)*0.983*(am/danjia)/1.17;
									}else{
										fwf =(danjia-puj.agentPriceNew)*0.984*(am/danjia)/1.16;
									}

								}else if(formula==2){
									//（单价-120）*0.9796*（开票金额/单价）/1.17
									if(mdate.getTime()<fdate.getTime()){
										fwf =(danjia-puj.agentPriceNew)*0.9796*(am/danjia)/1.17;
									}else{
										fwf =(danjia-puj.agentPriceNew)*0.9808*(am/danjia)/1.16;
									}

								}else {
									fwf = (danjia-puj.agentPriceNew)*0.9844*(am/danjia)/1.13;
								}
							}
							BigDecimal b0 = new BigDecimal(fwf);

							double fwf1 = b0.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();//四舍五入
							System.out.println(fwf1+"===");
							fuwufei+=fwf1;
						}
					}

        		}
        		
        	}

        	if(Double.isNaN(fuwufei)){
				fuwufei = 0;
			}

			BigDecimal b0 = new BigDecimal(fuwufei);

			double fuwufei2 = b0.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();//四舍五入

        	if(tax==1){
        		jinxiang=(float) (fuwufei2/1.06*0.06);
        	}else if(tax==2){
        		jinxiang=(float) ((fuwufei2/1.06*0.06)/2);
        	}else if(tax==3){
        		jinxiang=(float) (fuwufei2/1.03*0.03);
        	}else if(tax==4){
        		jinxiang=(float) ((fuwufei2/1.03*0.03)/2);
        	}

			BigDecimal b = new BigDecimal(fuwufei2);
			double Payable = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			BigDecimal b2=new BigDecimal(jinxiang);
			double Inputtax=b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

			BigDecimal b3=new BigDecimal(fuwufei2+jinxiang);
			double sum=b3.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

			System.out.println("=="+Payable+"--"+Inputtax+"-----"+sum);

			Charge charge=Charge.find(0);
        	charge.setMember(pid);
        	charge.setHospitalid(hid);
        	charge.setBackid(backin);
        	charge.setPayable((float)Payable);
        	charge.setInputtax((float)Inputtax);
        	charge.setTotal((float)sum);
        	charge.setPuid(back.getPuid());
        	
        	charge.setStatus(1);
        	charge.setCreatedate(new Date());
        	//charge.setChargecode("SE"+Seq.get());
        	//服务费编号：年份（两位数）+000（累加）
        	Calendar date = Calendar.getInstance();
            String year = String.valueOf(date.get(Calendar.YEAR));
            String year2=year.substring(2);//截取年份的后两位
            int count=0;
            if(year2.equals("18")){
            	count=Charge.count(" and  SUBSTRING(chargecode,1,2) like "+DbAdapter.cite(year2+"%"))+93;
            }else{
            	count=Charge.count(" and  SUBSTRING(chargecode,1,2) like "+DbAdapter.cite(year2+"%"));
            }
            String strc="";//年份后的增长
        	int count2=count+1;
            if(Integer.toString(count2).length()==2){
        		strc="0"+count2;
        	}else if(Integer.toString(count2).length()==1){
        		strc="00"+count2;
        	}else{
        		strc=count2+"";
        	}
            charge.setChargecode(year2+strc);
            ccode=year2+strc;
            charge.setInvoiceamount(totalamount);
        	charge.setInvoicenum(totalnum);
        	charge.set();
		} catch (Exception e) {
			// TODO: handle exception
		} finally{
			return ccode;
		}
    	
    	
    
    }

	public static void main(String[] args) {
		int pid=19070182;
		int hid=19070180;
		int backin=19070298;
		askcharge(pid,hid,backin);
	}
}
