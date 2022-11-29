package tea.ui.yl.shopnew;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.ScriptStyle;
import jxl.format.UnderlineStyle;
import jxl.write.DateFormats;
import jxl.write.Formula;
import jxl.write.Label;
import jxl.write.NumberFormat;
import jxl.write.WritableCell;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableImage;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

import java.io.*;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.*;
import tea.entity.yl.shopnew.BackInvoice;
import tea.entity.yl.shopnew.Charge;
import tea.entity.yl.shopnew.Invoice;
import tea.entity.yl.shopnew.InvoiceData;
import tea.entity.yl.shopnew.ReplyMoney;

import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.poi.ss.usermodel.BorderStyle;
import util.Config;

public class Charges extends HttpServlet
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
        if("dcdata".equals(act)){
        	//导出服务费确认单
        	javax.servlet.ServletOutputStream os = response.getOutputStream();
            jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
        	try{
        		//样式开始
        		WritableFont titleWf = new WritableFont(WritableFont.createFont("楷体_GB2312"),// 字体  
                        14,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_title = new WritableCellFormat(titleWf); //第一行样式
        		WritableFont titleWf0 = new WritableFont(WritableFont.createFont("隶书"),// 字体  
                        14,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.BOLD,                  // 粗体  
                        true,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_title0 = new WritableCellFormat(titleWf0); //第一行样式
        		WritableFont titleWf2 = new WritableFont(WritableFont.createFont("Times New Roman"),// 字体  
                        10,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_title2 = new WritableCellFormat(titleWf2); 
        		WritableFont titleWf3 = new WritableFont(WritableFont.createFont("Times New Roman"),// 字体  
                        14,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.NO_BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_title3 = new WritableCellFormat(titleWf3); 
        		WritableFont titleWf4 = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        14,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.NO_BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_title4 = new WritableCellFormat(titleWf4);
        		WritableFont titleWf5 = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        14,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.NO_BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_title5 = new WritableCellFormat(titleWf5);
        		WritableFont titleWf6 = new WritableFont(WritableFont.createFont("Times New Roman"),// 字体  
                        14,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_title6 = new WritableCellFormat(titleWf6);
        		wcf_title6.setAlignment(Alignment.CENTRE);
        		WritableFont con = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        11,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.NO_BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_con = new WritableCellFormat(con);
        		wcf_con.setAlignment(Alignment.JUSTIFY);
        		wcf_con.setBorder(Border.ALL, BorderLineStyle.THIN); // 添加边框  
        		WritableFont con2 = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        11,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_con2 = new WritableCellFormat(con2);
        		wcf_con2.setBorder(Border.ALL, BorderLineStyle.THIN); // 添加边框  
        		wcf_con2.setAlignment(Alignment.CENTRE);//居中
        		WritableFont con_fan = new WritableFont(WritableFont.createFont("宋体"), //返还增值税
                        11,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.NO_BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_con_fan = new WritableCellFormat(con_fan);
        		wcf_con_fan.setAlignment(Alignment.CENTRE);
        		wcf_con_fan.setBorder(Border.ALL, BorderLineStyle.THIN); // 添加边框  
        		WritableFont con_spec = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        10,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.NO_BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_con_spec = new WritableCellFormat(con_spec);
        		wcf_con_spec.setAlignment(Alignment.JUSTIFY);//自动换行
        		wcf_con_spec.setBorder(Border.ALL, BorderLineStyle.THIN); // 添加边框  
        		WritableFont tishicon = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        12,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.NO_BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_tishi = new WritableCellFormat(tishicon);
        		WritableFont tishicon2 = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        9,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.NO_BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_tishi2 = new WritableCellFormat(tishicon2);
        		NumberFormat nf = new jxl.write.NumberFormat("¥#,##0.00"); //金额格式
        		WritableCellFormat wcf_jine = new jxl.write.WritableCellFormat(nf); 
        		wcf_jine.setBorder(Border.ALL, BorderLineStyle.THIN);
        		WritableFont con_chong = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        11,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.NO_BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_con_chong = new WritableCellFormat(con_chong);
        		wcf_con_chong.setBackground(Colour.LIGHT_TURQUOISE);//背景颜色
        		wcf_con_chong.setAlignment(Alignment.CENTRE);
        		wcf_con_chong.setBorder(Border.ALL, BorderLineStyle.THIN); // 添加边框  




        		//样式结束
        		int chargeid=h.getInt("chargeid");
        		Charge charge=Charge.find(chargeid);
        		Profile profile=Profile.find(charge.getMember());

        		int backid = charge.getBackid();
        		BackInvoice back = BackInvoice.find(backid);
                int shinvoice = 0;
                try{
                    String[] invoiceidarr=back.getInvoiceid().split(",");
                    for(int x=0;x<invoiceidarr.length;x++) {
                        shinvoice = Integer.parseInt(invoiceidarr[x]);
                    }
                }catch (Exception e){

                }

				int phpuid = InvoiceData.getPuid(shinvoice);
				Invoice invoice1 = Invoice.find(shinvoice);

                //ProcurementUnitJoin pj = ProcurementUnitJoin.find(phpuid,profile.profile);
				ProcurementUnitJoin pj = ProcurementUnitJoin.find(phpuid,profile.profile,invoice1.getHospitalid());

                ProcurementUnit pu = ProcurementUnit.find(charge.getPuid());

        		String member=profile.getMember();//服务商名称
        		String company=MT.f(pj.company);//服务商公司名称
        		String hospital=ShopHospital.find(charge.getHospitalid()).getName();//医院名称
        		int tax=pj.tax;//返还增值税
        		int formu=profile.formula;
        		float canshu=(float) 0.983;
        		if(formu==2){
        			canshu=(float) 0.9796;
        		}
        		response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(MT.f(new Date())+hospital + ".xls", "UTF-8"));
                //移走
                jxl.write.WritableSheet ws = wwb.createSheet("服务费确认单", 0);
                int index = 0;
                int hang=5;//行数
                //在A1处添加图片，图片大小占10行3列，只支持png格式  
                /*File file = new File("/res/extitle.png");  
                WritableImage image = new WritableImage(0, 0, 3, 5, file);  
                ws.addImage(image); */ 
                
                /*String path=request.getRequestURI();
                System.out.println("1:"+path);
                String path2=application.getRealPath(request.getRequestURI());
                System.out.println("2:"+path2);*/
                String path3=application.getRealPath("/")+"res/extitle.png";
                File file = new File(path3);
                WritableImage image = new WritableImage(0, 0, 0.5, 1.1, file);  
                ws.addImage(image);
                image.setX(0.5);
                
                //添加横线
                String path4=application.getRealPath("/")+"res/exline.png";
                File file2 = new File(path4);  
                WritableImage image2 = new WritableImage(0, 0, 10, 0.05, file2);  
                ws.addImage(image2);
                image2.setY(1.1);
                
                
                Label title0=new Label(1,0,"CIC",wcf_title0);
                ws.addCell(title0);
                Label title=new Label(5,0,pu.getFullname(),wcf_title); //第一行
                ws.addCell(title);
                //ws.mergeCells(7,0,9,0);
                Label entitle=new Label(5,1,pu.getFullnameen(),wcf_title2);//第二行
                ws.addCell(entitle);
                
                Label to=new Label(1,2,"TO:",wcf_title3);//第三行
                ws.addCell(to);
                Label fuwushang=new Label(2,2,company+"   "+member,wcf_title4);
                //ws.mergeCells(2, 2, 7, 2);//合并服务商
                ws.addCell(fuwushang);
                Label from=new Label(1,3,"FROM:",wcf_title3);//第四行
                ws.addCell(from);
                Label tongfu=new Label(2,3,pu.getFullname()+" FAX:"+pu.getMobile(),wcf_title5);
                //ws.mergeCells(2, 3, 6, 3);
                ws.addCell(tongfu);
                /*Label fax=new Label(7,3,"FAX:010-68570005",wcf_title3);
                ws.mergeCells(7, 3, 8, 3);
                ws.addCell(fax);*/
                Label dian=new Label(0,4,"碘[125I]密封籽源技术服务费确认单",wcf_title6);
                ws.mergeCells(0, 4, 9, 4);
                ws.addCell(dian);
                
            	ws.addCell(new jxl.write.Label(index++, hang, "医院",wcf_con));
                ws.addCell(new jxl.write.Label(index++, hang, "订货日期",wcf_con));
                ws.addCell(new jxl.write.Label(index++, hang, "发货数量",wcf_con));
                
                ws.addCell(new jxl.write.Label(index++, hang, "分销价",wcf_con));
                ws.addCell(new jxl.write.Label(index++, hang, "单价",wcf_con));
                
                ws.addCell(new jxl.write.Label(index++, hang, "发票金额",wcf_con));
                ws.addCell(new jxl.write.Label(index++, hang, "开票日期",wcf_con));
                
                ws.addCell(new jxl.write.Label(index++, hang, "付款日期",wcf_con));
                ws.addCell(new jxl.write.Label(index++, hang, "付款金额",wcf_con));
                
                ws.addCell(new jxl.write.Label(index++, hang, "应付服务费",wcf_con));
                //充某某公司服务费
                hang=hang+1;
                Label chong=new Label(0,hang,"冲"+company+"服务费",wcf_con_chong);
                ws.addCell(chong);
                ws.mergeCells(0, hang, 9, hang);
                
                //开始
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date fdate=sdf.parse("2018-05-01 00:00:00");
                Date fdate2019=sdf.parse("2019-04-01 00:00:00");//开始新公式
                
                
                int hangnum=0;//记录行数
                int quantitysum=0;//发货数量小计
                float invoiceamountsum=0;//发票金额小计
                float fkamountsum=0;//付款金额小计
                float chargeamountsum=0;//应付服务费小计
                //String[] backidarr=charge.getBackid().split(",");//BackInvoice的id
                int hang2=hang+1;;
                
                	//int backid=charge.getBackid();
                	BackInvoice backinvoice=BackInvoice.find(backid);
                	String[] invoiceidarr=MT.f(backinvoice.getInvoiceid(),",").split(",");//已匹配的发票id
                	String[] replyids=MT.f(backinvoice.getReplyid(),",").split(",");//已匹配的回款id
                	for(int j=0;j<invoiceidarr.length;j++){
                		//循环发票
                		int invoiceid=Integer.parseInt(invoiceidarr[j]);
                		Invoice invoice=Invoice.find(invoiceid);//发票主表
                		List<InvoiceData> lstidata=InvoiceData.find(" and invoiceid="+invoiceid, 0, Integer.MAX_VALUE);
                		for(int k=0;k<lstidata.size();k++){
                			InvoiceData idata=lstidata.get(k);
                			List<ShopOrderData> lstorderdata=ShopOrderData.find(" and order_id = "+Database.cite(idata.getOrderid()), 0, 1);
                			if(lstorderdata.size()>0){
                				ShopOrderData orderdata=lstorderdata.get(0);//订单子表
                				ShopOrder order=ShopOrder.findByOrderId(idata.getOrderid());//订单
                				//订货日期
                				String orderdate=MT.f(order.getCreateDate());
                				//发货数量
                				//int quantity=orderdata.getQuantity();
								int quantity=idata.getNum();
                				quantitysum+=quantity;//发货数量小计
                				//分销价
                				float agent_price_s=orderdata.getAgent_price_s();
                				//单价
                				float agent_price=orderdata.getAgent_price();
                				//发票金额
                				float invoiceamount=idata.getAmount();
                				invoiceamountsum+=invoiceamount;//发票金额小计
                				//开票日期
                				String invoicedate=MT.f(invoice.getMakeoutdate());
                				//付款日期
                				ReplyMoney rm=ReplyMoney.find(Integer.parseInt(replyids[0]));
                				String replytime=MT.f(rm.getReplyTime());
								//付款金额
								float fkamount=idata.getAmount();
								fkamountsum+=fkamount;//付款金额小计
								//应付服务费
								String formula=MT.f(profile.formula, 1) ;
								double chargeamount=0;//应付服务费


								float mychataxamount = 0;

								if(invoice.getMakeoutdate().getTime()>=fdate2019.getTime()){//最新公式
									chargeamount=((agent_price-pj.agentPriceNew)*0.9844*(invoiceamount/agent_price)/1.13);
									//Map<String,Double> imap =  Invoice.getTaxAmount(tax, invoice.getId(), 0.9844, 1.13);
									//double mysum = imap.get("chargeamountsum");
									//chargeamount = (float)mysum;

									//mychataxamount = (float)(imap.get("chargeamountsum")+imap.get("taxamount"));

									canshu=(float) 0.9844;
								}else {
									if(formula.equals("1")){
										//（单价-120）*0.983*（开票金额/单价）/1.17
										if(invoice.getMakeoutdate().getTime()<fdate.getTime()){
											chargeamount= ((agent_price-pj.agentPriceNew)*0.983*(invoiceamount/agent_price)/1.17);
											//Map<String,Double> imap =  Invoice.getTaxAmount(tax, invoice.getId(), 0.983, 1.17);
											//double mysum = imap.get("chargeamountsum");
											//chargeamount = (float)mysum;
											//mychataxamount = (float)(imap.get("chargeamountsum")+imap.get("taxamount"));
										}else{
											chargeamount=((agent_price-pj.agentPriceNew)*0.984*(invoiceamount/agent_price)/1.16);
											//Map<String,Double> imap =  Invoice.getTaxAmount(tax, invoice.getId(), 0.984, 1.16);
											//double mysum = imap.get("chargeamountsum");
											//chargeamount = (float)mysum;
											canshu=(float)0.984;
											//mychataxamount = (float)(imap.get("chargeamountsum")+imap.get("taxamount"));
										}

									}else if(formula.equals("2")){
										//（单价-120）*0.9796*（开票金额/单价）/1.17
										if(invoice.getMakeoutdate().getTime()<fdate.getTime()){
											chargeamount= ((agent_price-pj.agentPriceNew)*0.9796*(invoiceamount/agent_price)/1.17);
											//Map<String,Double> imap =  Invoice.getTaxAmount(tax, invoice.getId(), 0.9796, 1.17);
											//double mysum = imap.get("chargeamountsum");
											//chargeamount = (float)mysum;
											//mychataxamount = (float)(imap.get("chargeamountsum")+imap.get("taxamount"));
										}else{
											chargeamount= ((agent_price-pj.agentPriceNew)*0.9808*(invoiceamount/agent_price)/1.16);
											//Map<String,Double> imap =  Invoice.getTaxAmount(tax, invoice.getId(), 0.9808, 1.16);
											//double mysum = imap.get("chargeamountsum");
											//chargeamount = (float)mysum;
											canshu=(float)0.9808;
											//mychataxamount = (float)(imap.get("chargeamountsum")+imap.get("taxamount"));
										}

									}else {//最新公式
										chargeamount=((agent_price-pj.agentPriceNew)*0.9844*(invoiceamount/agent_price)/1.13);
										//Map<String,Double> imap =  Invoice.getTaxAmount(tax, invoice.getId(), 0.9844, 1.13);
										//double mysum = imap.get("chargeamountsum");
										//chargeamount = (float)mysum;

										//mychataxamount = (float)(imap.get("chargeamountsum")+imap.get("taxamount"));

										canshu=(float) 0.9844;
									}
								}
                                BigDecimal b0 = new BigDecimal(chargeamount);
                                double fwf1 = b0.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();//四舍五入
                                System.out.println(fwf1+"===");
                                chargeamountsum+=fwf1;

								double taxamount = 0;
								if(tax==1){
									taxamount = fwf1/1.06*0.06;
								}else if(tax==2){
									taxamount = (fwf1/1.06*0.06)/2;
								}else if(tax==3){
									taxamount = fwf1/1.03*0.03;
								}else if(tax==4){
									taxamount = (fwf1/1.03*0.03)/2;
								}
								//mychataxamount = (float)(chargeamountsum+taxamount);



                				//chargeamountsum+=chargeamount;//应付服务费小计
                				//Filex.logs("ytexl.txt", String.valueOf(chargeamountsum));
                				index = 0;
                				
                				ws.addCell(new jxl.write.Label(index++,hang2 ,MT.f(hospital),wcf_con_spec));
                                ws.addCell(new jxl.write.Label(index++, hang2, orderdate,wcf_con_spec));
                                ws.addCell(new jxl.write.Number(index++, hang2, quantity,wcf_con_spec));
                                ws.addCell(new jxl.write.Number(index++, hang2, agent_price_s,wcf_jine));//分销价
                                ws.addCell(new jxl.write.Number(index++, hang2, agent_price,wcf_jine));//单价
                                ws.addCell(new jxl.write.Number(index++, hang2, invoiceamount,wcf_jine));
                                ws.addCell(new jxl.write.Label(index++, hang2, invoicedate,wcf_con_spec));
                               
                                ws.addCell(new jxl.write.Label(index++, hang2, replytime,wcf_con_spec));
                                ws.addCell(new jxl.write.Number(index++, hang2, fkamount,wcf_jine));	

                                //服务费

								//0.9844, 1.13

								Formula f0 = new Formula(index++, hang2, fwf1+"",wcf_jine);  //计算应付服务费
								ws.addCell(f0);
								/*if(invoice.getAdjustmentService()!=0){//调整过服务费
									Formula f0 = new Formula(index++, hang2, invoice.getAdjustmentService()+"",wcf_jine);  //计算应付服务费
									ws.addCell(f0);
								}else{
									if(charge.getPuid()!= Config.getInt("gaoke")){
										if(invoice.getPuid()!= Config.getInt("gaoke")){
											Formula f0 = new Formula(index++, hang2, fwf1+"",wcf_jine);  //计算应付服务费
											ws.addCell(f0);
										}else{
											if(invoice.getMakeoutdate().getTime()>=fdate2019.getTime()){//最新公式
												Formula f0 = new Formula(index++, hang2, "(E"+(hang2+1)+"-D"+(hang2+1)+")*"+canshu+"*(F"+(hang2+1)+"/E"+(hang2+1)+")/1.13",wcf_jine);  //计算应付服务费
												ws.addCell(f0);
											}else {
												//新增
												if(invoice.getMakeoutdate().getTime()<fdate.getTime()){
													Formula f0 = new Formula(index++, hang2, "(E"+(hang2+1)+"-D"+(hang2+1)+")*"+canshu+"*(F"+(hang2+1)+"/E"+(hang2+1)+")/1.17",wcf_jine);  //计算应付服务费
													ws.addCell(f0);
												}else{
													Formula f0 = new Formula(index++, hang2, "(E"+(hang2+1)+"-D"+(hang2+1)+")*"+canshu+"*(F"+(hang2+1)+"/E"+(hang2+1)+")/1.16",wcf_jine);  //计算应付服务费
													ws.addCell(f0);
												}
											}
										}
									}else{
										Formula f0 = new Formula(index++, hang2, mychataxamount+"",wcf_jine);  //计算应付服务费
										ws.addCell(f0);
									}
								}*/

                                //设置行高
                                ws.setRowView(hang2, 1005);
                                //订货日期和开票日期改格式
                                /*WritableCell ce= ws.getWritableCell(3,k+1+hang);
                                NumberFormat redDoubleFormat3=new NumberFormat("¥#");
                                WritableCellFormat wcf=new WritableCellFormat(redDoubleFormat3);
                                ce.setCellFormat(wcf);*/
                                hang2++;
                                
                			}
                			/*if(k==lstidata.size()-1){
                				hangnum=k+1+hang;
                				//小计
                				//利用公式取得值  
                		        Formula f1 = new Formula(2, hangnum+1, "SUM(C"+(hang+2)+":C"+(hangnum+1)+")",wcf_con);  //发货数量
                		        ws.addCell(f1);
                		        //发票金额
                		        Formula f2 = new Formula(5, hangnum+1, "SUM(F"+(hang+2)+":F"+(hangnum+1)+")",wcf_jine);  
                		        ws.addCell(f2);
                				//付款金额
                		        Formula f3 = new Formula(8, hangnum+1, "SUM(I"+(hang+2)+":I"+(hangnum+1)+")",wcf_jine);  
                		        ws.addCell(f3);
                		        //应付服务费
                		        Formula f4 = new Formula(9, hangnum+1, "SUM(J"+(hang+2)+":J"+(hangnum+1)+")",wcf_jine);  
                		        ws.addCell(f4);
                			}*/
                		}
                	}
                
                
    				hangnum=hang2;
    				//小计
    				//利用公式取得值  
    		        Formula f1 = new Formula(2, hangnum, "SUM(C"+(hang+2)+":C"+(hangnum)+")",wcf_con);  //发货数量
    		        ws.addCell(f1);
    		        //发票金额
    		        Formula f2 = new Formula(5, hangnum, "SUM(F"+(hang+2)+":F"+(hangnum)+")",wcf_jine);  
    		        ws.addCell(f2);
    				//付款金额
    		        Formula f3 = new Formula(8, hangnum, "SUM(I"+(hang+2)+":I"+(hangnum)+")",wcf_jine);  
    		        ws.addCell(f3);
    		        //应付服务费
    		        Formula f4 = new Formula(9, hangnum, "SUM(J"+(hang+2)+":J"+(hangnum)+")",wcf_jine);  
    		        ws.addCell(f4);
    			
                //小计
                Label sub1=new Label(0,hangnum,"小计",wcf_con);
                ws.addCell(sub1);
                /*Label sub2=new Label(2,hangnum+1,String.valueOf(quantitysum),wcf_con);//发货数量
                ws.addCell(sub2);*/
                /*Label sub3=new Label(5,hangnum+1,"￥"+invoiceamountsum,wcf_con);//发票金额
                ws.addCell(sub3);
                Label sub4=new Label(8,hangnum+1,"￥"+fkamountsum,wcf_con);//付款金额
                ws.addCell(sub4);*/
                /*Label sub5=new Label(9,hangnum+1,"￥"+chargeamountsum,wcf_con);//应付服务费
                ws.addCell(sub5);*/
                //设置行高
                ws.setRowView(hangnum, 585);
                //返还增值税


				float taxamount=charge.getInputtax();
				//计算进项税返还
				//if(charge.getPuid()!= Config.getInt("gaoke")){

					Label fanh=new Label(0,hangnum+1,Profile.TAX[Integer.parseInt(MT.f(pj.tax,0))],wcf_con_fan);//返还增值税
					ws.mergeCells(0, hangnum+1, 8, hangnum+1);
					ws.addCell(fanh);

					Label fanh2=new Label(9,hangnum+2,"￥"+taxamount,wcf_con2);
					ws.addCell(fanh2);
					Formula f5 =null;
					f5=new Formula(9, hangnum+1, "J"+(hangnum+1)+"/1.06*0.06",wcf_jine);
					if(tax==1){
						f5=new Formula(9, hangnum+1, "J"+(hangnum+1)+"/1.06*0.06",wcf_jine);
					}else if(tax==2){
						f5=new Formula(9, hangnum+1, "(J"+(hangnum+1)+"/1.06*0.06)/2",wcf_jine);
					}else if(tax==3){
						f5=new Formula(9, hangnum+1, "J"+(hangnum+1)+"/1.03*0.03",wcf_jine);
					}else if(tax==4){
						f5=new Formula(9, hangnum+1, "(J"+(hangnum+1)+"/1.03*0.03)/2",wcf_jine);
					}
					ws.addCell(f5);
				/*}else{
				}*/

                //设置行高
                ws.setRowView(hangnum+1, 720);


				wcf_jine = new jxl.write.WritableCellFormat(nf);
				wcf_jine.setBorder(Border.ALL, BorderLineStyle.THIN);
				wcf_jine.setAlignment(Alignment.RIGHT);

				Label koukuan=new Label(0,hangnum+2,"服务费结算比例：",wcf_con2);
				ws.mergeCells(0, hangnum+2, 8, hangnum+2);
				ws.addCell(koukuan);
				Label koukuan1 = new Label(9, hangnum+2, BackInvoice.deductionRecordTypeARR[back.getDeductionRecordType()],wcf_jine);
				ws.addCell(koukuan1);

				DecimalFormat df = new DecimalFormat("0.00");// 保留小数点后二位
				double v0 = Double.parseDouble(df.format(charge.getTotal()));

				float deductionRecordTypeARRnum =  BackInvoice.deductionRecordTypeARRnum[back.getDeductionRecordType()];

				double v1 = Double.parseDouble(df.format(charge.getTotal()*deductionRecordTypeARRnum));

				if(back.getQianamount()>0){//欠款
					v1 = v1 - back.getQianamount();
				}
				if(back.getHuanamount()>0){//还款
					v1 = v1 + back.getHuanamount();
				}
				double v2 = Double.parseDouble(df.format(v1));

				int kounum = 1;

				koukuan=new Label(0,hangnum+kounum+2,"扣款：",wcf_con2);
				ws.mergeCells(0, hangnum+kounum+2, 8, hangnum+kounum+2);
				ws.addCell(koukuan);
				koukuan1 = new Label(9, hangnum+kounum+2, "￥"+back.getQianamount(),wcf_jine);
				ws.addCell(koukuan1);

				kounum++;

				koukuan=new Label(0,hangnum+kounum+2,"还款：",wcf_con2);
				ws.mergeCells(0, hangnum+kounum+2, 8, hangnum+kounum+2);
				ws.addCell(koukuan);
				koukuan1 = new Label(9, hangnum+kounum+2, "￥"+back.getHuanamount(),wcf_jine);
				ws.addCell(koukuan1);

				kounum++;
				//int kounum = 0;



                //合计支付
                Label heji=new Label(0,hangnum+kounum+2,"合计支付：",wcf_con2);
                ws.mergeCells(0, hangnum+kounum+2, 8, hangnum+kounum+2);
                ws.addCell(heji);
				//"SUM(J"+(hangnum+kounum+1)+":J"+(hangnum+kounum+2)+"
				Label f6 = new Label(9, hangnum+kounum+2, "￥"+v2+"",wcf_jine);
		        ws.addCell(f6);
                //设置行高
                ws.setRowView(hangnum+kounum+2, 615);
                //提示





                BigDecimal b = new BigDecimal(chargeamountsum);

        		double chargeamountsum2 = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        		BigDecimal b2=new BigDecimal(taxamount);
        		double taxamount2=b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        		//DecimalFormat df = new DecimalFormat("######0.00");
                Label tishi1=new Label(0,hangnum+3+kounum,"确认无误后，请传真回执并请将技术服务发票（发票金额："+df.format(chargeamountsum2)+"元和"+df.format(taxamount2)+"元",wcf_tishi);
                ws.addCell(tishi1);
                //设置行高
                ws.setRowView(hangnum+kounum+4, 360);
                Label tishi2=new Label(0,hangnum+4+kounum,"两张发票）开给我公司，收到发票后我们会及时将钱汇入贵公司帐号。",wcf_tishi);
                ws.addCell(tishi2);
                //部门
                Label bumen=new Label(5,hangnum+5+kounum,pu.getFullname(),wcf_tishi);
                ws.addCell(bumen);
                //设置行高
                ws.setRowView(hangnum+kounum+5, 360);
               // if(category>1)ws.addCell(new jxl.write.Label(0, solist.size()+1,"开票金额合计："+pricesum));
                //日期
                Label datetime=new Label(7,hangnum+6+kounum,MT.f(new Date()),wcf_tishi);
                ws.addCell(datetime);
                //添加横线
                String path5=application.getRealPath("/")+"res/exline2.png";
                File file3 = new File(path5);  
                WritableImage image3 = new WritableImage(0, hangnum+kounum+6, 10, 0.02, file3);
                ws.addImage(image3);
                double yval=hangnum+kounum+7+0.1;
                image3.setY(yval);
                //设置行高
                ws.setRowView(hangnum+7+kounum, 360);
                //地址电话
                Label addresstel=new Label(1,hangnum+kounum+8,"地址："+pu.getAddress()+"                     电话："+pu.getTelephone(),wcf_tishi2);
                ws.addCell(addresstel);
                //设置行高
                ws.setRowView(hangnum+8+kounum, 360);
                //邮编传真
                Label youbian=new Label(1,hangnum+kounum+9,"邮编："+pu.zipcode+"                                          传真："+pu.fax,wcf_tishi2);
                ws.addCell(youbian);
                //设置行高
                ws.setRowView(hangnum+9+kounum, 360);
                //网址
                Label wangzhi=new Label(1,hangnum+kounum+10,"网址："+pu.getWebsite()+"                           E-mail:"+pu.getEmail(),wcf_tishi2);
                ws.addCell(wangzhi);
                //设置行高
                ws.setRowView(hangnum+10+kounum, 360);
                //样式============================
                //列宽
                /*ws.setColumnView(0, 8);//第一列宽度
                ws.setColumnView(1, 12);
                ws.setColumnView(2, 6);
                ws.setColumnView(3, 9);
                ws.setColumnView(4, 9);
                ws.setColumnView(5, 12);
                ws.setColumnView(6, 12);
                ws.setColumnView(7, 12);
                ws.setColumnView(8, 13);
                ws.setColumnView(9, 14);*/
                ws.setColumnView(0, 7);//第一列宽度
                ws.setColumnView(1, 8);
                ws.setColumnView(2, 6);
                ws.setColumnView(3, 8);
                ws.setColumnView(4, 8);
                ws.setColumnView(5, 12);
                ws.setColumnView(6, 7);
                ws.setColumnView(7, 7);
                ws.setColumnView(8, 12);
                ws.setColumnView(9, 12);
                //行高
                ws.setRowView(0, 690);
                ws.setRowView(1, 405);
                ws.setRowView(2, 345);
                ws.setRowView(3, 810);
                ws.setRowView(4, 420);
                ws.setRowView(5, 690);
                ws.setRowView(6, 285);
	            
            }catch (Exception e) {
            	e.printStackTrace();
			}
        	finally {
        		try {
        			wwb.write();
        			wwb.close();
        			os.close();
        			return;
        			
        		}catch (Exception e) {
					// TODO: handle exception
				}
        	}
        	
        }else if("dctzdata".equals(act)){
        	//导出服务支付通知单
        	javax.servlet.ServletOutputStream os = response.getOutputStream();
            jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
        	int chargeid=h.getInt("chargeid");
    		Charge charge=Charge.find(chargeid);

			try {
			Profile profile = Profile.find(charge.getMember());

			int backid1 = charge.getBackid();
			BackInvoice back1 = BackInvoice.find(backid1);
			int shinvoice = 0;
			try{
				String[] invoiceidarr=back1.getInvoiceid().split(",");
				for(int x=0;x<invoiceidarr.length;x++) {
					shinvoice = Integer.parseInt(invoiceidarr[x]);
				}
			}catch (Exception e){

			}

			int phpuid = InvoiceData.getPuid(shinvoice);
			Invoice invoice1 = Invoice.find(shinvoice);

			//ProcurementUnitJoin pj = ProcurementUnitJoin.find(phpuid,profile.profile);
			ProcurementUnitJoin pj = ProcurementUnitJoin.find(phpuid,profile.profile,invoice1.getHospitalid());


			ProcurementUnit pu = ProcurementUnit.find(charge.getPuid());

    			//样式开始
    			//样式开始
        		WritableFont titleWf = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        16,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.NO_BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_title = new WritableCellFormat(titleWf); //第一行样式
        		wcf_title.setAlignment(Alignment.CENTRE);
        		WritableFont bianhaoWf = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        12,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT); 
        		WritableCellFormat wcf_bianhao = new WritableCellFormat(bianhaoWf); //编号样式
        		
        		WritableFont con = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        12,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.NO_BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线  
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_con = new WritableCellFormat(con);
        		wcf_con.setWrap(true);//自动换行
        		wcf_con.setBorder(Border.ALL,BorderLineStyle.THIN);
        		
        		WritableFont dateWf = new WritableFont(WritableFont.createFont("宋体"),// 字体  
                        14,//WritableFont.DEFAULT_POINT_SIZE,   // 字号  
                        WritableFont.BOLD,                  // 粗体  
                        false,                                 // 斜体  
                        UnderlineStyle.NO_UNDERLINE,            // 下划线
                        Colour.BLACK,                       // 字体颜色  
                        ScriptStyle.NORMAL_SCRIPT);  
        		WritableCellFormat wcf_date = new WritableCellFormat(dateWf);
        		NumberFormat nf = new jxl.write.NumberFormat("¥#,##0.00"); //金额格式
        		WritableCellFormat wcf_jine = new jxl.write.WritableCellFormat(nf); 
        		wcf_jine.setBorder(Border.ALL, BorderLineStyle.THIN);
    			//样式结束
        		String member=profile.getMember();//服务商名称
        		String company=MT.f(pj.company);//服务商公司名称
        		String hospital=ShopHospital.find(charge.getHospitalid()).getName();//医院名称
        		int tax=pj.tax;//返还增值税
        		int formu=pj.formula;//公式参数
        		float canshu=(float) 0.983;
        		if(formu==2){
        			canshu=(float) 0.9796;
        		}



        		//获取回款
        		float replyamount=0;//回款金额
        		float invoiceamount=0;//开票金额
        		//String[] backidarr=charge.getBackid().split(",");
        		
        			int backid=charge.getBackid();
        			BackInvoice back=BackInvoice.find(backid);
        			String[] replyidarr=back.getReplyid().split(",");
        			for(int j=0;j<replyidarr.length;j++){
        				int replyid=Integer.parseInt(replyidarr[j]);
        				ReplyMoney reply=ReplyMoney.find(replyid);
        				float replyprice=reply.getReplyPrice();
        				replyamount+=replyprice;
        			}
        			String[] invoiceidarr=back.getInvoiceid().split(",");
        			for(int j=0;j<invoiceidarr.length;j++){
        				int invoiceid=Integer.parseInt(invoiceidarr[j]);
        				Invoice invoice=Invoice.find(invoiceid);
        				float invoiceprice=invoice.getAmount();
        				invoiceamount+=invoiceprice;
        			}
        		
        		//获取发票
        		
        		response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(MT.f(new Date())+"服务费支付单-"+member + ".xls", "UTF-8"));
                
                jxl.write.WritableSheet ws = wwb.createSheet("服务费支付通知单", 0);
                Label title0=new Label(0,0,"籽源部技术服务费支付通知单",wcf_title);
                ws.addCell(title0);
                ws.mergeCells(0, 0, 3, 0);
                //开始
                
                int index=0;
                int hang=3;
                //加服务费编号
                ws.addCell(new jxl.write.Label(3, hang-1, "编号："+charge.getChargecode(),wcf_bianhao));
                
                ws.addCell(new jxl.write.Label(index++, hang, "返还服务费公司",wcf_con));
                ws.setRowView(hang, 285);
                ws.addCell(new jxl.write.Label(index++, hang, "回款对应医院",wcf_con));
               
                //ws.addCell(new jxl.write.Label(index++, hang, "回款金额",wcf_con));
                
                ws.addCell(new jxl.write.Label(index++, hang, "回款金额",wcf_con));//上面的回款金额注释，开票金额改为回款金额
                
                ws.addCell(new jxl.write.Label(index++, hang, "返还服务费金额",wcf_con));
                
                index=0;
                hang=hang+1;
                
                ws.addCell(new jxl.write.Label(index++, hang, company,wcf_con));
                ws.addCell(new jxl.write.Label(index++, hang, hospital,wcf_con));
                ws.addCell(new jxl.write.Label(index++, hang, "",wcf_con));
                ws.addCell(new jxl.write.Label(index++, hang, "",wcf_con));
              
                ws.mergeCells(0, hang, 0, hang+6);
                ws.mergeCells(1, hang, 1, hang+6);
                ws.mergeCells(2, hang, 2, hang+6);
                ws.mergeCells(3, hang, 3, hang+6);
               
                //小计
                index=0;
                hang=hang+7;
                ws.addCell(new jxl.write.Label(index++, hang, "小计",wcf_con));
                ws.mergeCells(0, hang, 1, hang);
                ws.setRowView(hang, 495);
                //ws.addCell(new jxl.write.Number(2, hang, replyamount,wcf_jine));
                ws.addCell(new jxl.write.Number(2, hang, invoiceamount,wcf_jine));//开票金额改为回款金额，上面的回款金额注释
                ws.addCell(new jxl.write.Number(3, hang, charge.getPayable(),wcf_jine));
                //增值税
                index=0;
                hang=hang+1;
                ws.addCell(new jxl.write.Label(index++, hang, Profile.TAX[tax],wcf_con));
                ws.mergeCells(0, hang, 2, hang);
                ws.setRowView(hang, 495);
                Formula f5 =null;



                if(tax==1){
                	f5=new Formula(3, hang, "D"+(hang)+"/1.06*0.06",wcf_jine);
                }else if(tax==2){
                	f5=new Formula(3, hang, "(D"+(hang)+"/1.06*0.06)/2",wcf_jine);
                }else if(tax==3){
                	f5=new Formula(3, hang, "D"+(hang)+"/1.03*0.03",wcf_jine);
                }else if(tax==4){
                	f5=new Formula(3, hang, "(D"+(hang)+"/1.03*0.03)/2",wcf_jine);
                }




		        ws.addCell(f5);
		        //合计
		        index=0;
		        hang=hang+1;
		        ws.addCell(new jxl.write.Label(index++, hang, "合计", wcf_con));
		        ws.mergeCells(0, hang, 2, hang);
		        ws.setRowView(hang, 495);
		        //ws.addCell(new jxl.write.Number(index++, hang,"SUM(E"+hang+":E"+(hang-1)+")",wcf_jine));
		        Formula f6 = new Formula(3, hang, "SUM(D"+hang+":D"+(hang-1)+")",wcf_jine);  
		        ws.addCell(f6);
		        hang=hang+2;
		        ws.addCell(new jxl.write.Label(3, hang, MT.f(new Date()), wcf_date));
		        hang=hang+2;
		        ws.addCell(new jxl.write.Label(0, hang, "经办人：", wcf_con));
		        ws.setRowView(hang, 780);
		        ws.addCell(new jxl.write.Label(1, hang, "", wcf_con));
		        ws.mergeCells(1, hang, 2, hang);
		        ws.addCell(new jxl.write.Label(0, hang+1, "部门领导：", wcf_con));
		        ws.setRowView(hang+1, 780);
		        ws.addCell(new jxl.write.Label(1, hang+1, "", wcf_con));
		        ws.mergeCells(1, hang+1, 2, hang+1);
		        ws.addCell(new jxl.write.Label(0, hang+2, "财管部经办人：", wcf_con));
		        ws.setRowView(hang+2, 780);
		        ws.addCell(new jxl.write.Label(1, hang+2, "", wcf_con));
		        ws.mergeCells(1, hang+2, 2, hang+2);
		        ws.addCell(new jxl.write.Label(0, hang+3, "财管部门审核：", wcf_con));
		        ws.setRowView(hang+3, 780);
		        ws.addCell(new jxl.write.Label(1, hang+3, "", wcf_con));
		        ws.mergeCells(1, hang+3, 2, hang+3);
		        ws.addCell(new jxl.write.Label(0, hang+4, "分公司领导：", wcf_con));
		        ws.setRowView(hang+4, 780);
		        ws.addCell(new jxl.write.Label(1, hang+4, "", wcf_con));
		        ws.mergeCells(1, hang+4, 2, hang+4);
		        
		        //样式============================
                //列宽
                ws.setColumnView(0, 20);//第一列宽度
                ws.setColumnView(1, 20);
                ws.setColumnView(2, 20);
                ws.setColumnView(3, 20);
                
                wwb.write();
	            wwb.close();
	            os.close();
	            return;
			} catch (Throwable e) {
    			e.printStackTrace();
				// TODO: handle exception
			}
    		
    		
        }else if("exp_sh".equals(act)){
        	try{
        		response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("服务费" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("服务费", 0);
                int index = 0;
                	ws.addCell(new jxl.write.Label(index++, 0, "服务费编号"));
                    ws.addCell(new jxl.write.Label(index++, 0, "医院"));
                    ws.addCell(new jxl.write.Label(index++, 0, "服务商"));
                    
                    ws.addCell(new jxl.write.Label(index++, 0, "应付服务费"));
                    ws.addCell(new jxl.write.Label(index++, 0, "进项税返还"));
                    
                    ws.addCell(new jxl.write.Label(index++, 0, "应付服务费总额"));
                    ws.addCell(new jxl.write.Label(index++, 0, "时间"));
                    
                    ws.addCell(new jxl.write.Label(index++, 0, "状态"));
                    
                    
                String sql = h.get("sql");
                //导出，把取消的订单筛选掉
                List<Charge> lstcharge=Charge.find(sql.toString()+" order by createdate desc ", 0, Integer.MAX_VALUE);
                
                for(int e = 0;e<lstcharge.size();e++){
                	Charge charge=lstcharge.get(e);
              	  	ShopHospital hospital=ShopHospital.find(charge.getHospitalid());//医院
              	  	Profile profile=Profile.find(charge.getMember());//服务商
              	    index = 0;
      			    ws.addCell(new jxl.write.Label(index++, e+1,MT.f(charge.getChargecode())));
	                ws.addCell(new jxl.write.Label(index++, e+1, MT.f(hospital.getName())));
	                ws.addCell(new jxl.write.Label(index++, e+1, MT.f(profile.member)));
	                  ws.addCell(new jxl.write.Label(index++, e+1, MT.f(charge.getPayable())));
	                  ws.addCell(new jxl.write.Label(index++, e+1,MT.f(charge.getInputtax())));
	                  ws.addCell(new jxl.write.Label(index++, e+1, MT.f(charge.getTotal())));
	                  ws.addCell(new jxl.write.Label(index++, e+1, MT.f(charge.getCreatedate(),1)));
	                 
	                  ws.addCell(new jxl.write.Label(index++, e+1, Charge.ISTZFWS[charge.getIstzfws()])); //收货人
	                  
	                  
                }
                
                wwb.write();
	            wwb.close();
	            os.close();
	            return;
            }catch (Exception e) {
			}
			return;
        }
        
       PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            if ("tzfws".equals(act)){
            	int chargeid=h.getInt("chargeid");
            	Charge charge=Charge.find(chargeid);
            	charge.set("istzfws", "1");
            	String code=charge.getChargecode();
            	int member=charge.getMember();//服务商id
            	Profile profile=Profile.find(member);
            	String mobile=profile.getMobile();
            	if(!"".equals(mobile)){
            		//ShopHospital hospital=ShopHospital.find(back.getHospitalid());
            		SMSMessage.create("Home", profile.member, mobile, h.language, "服务费编号"+code+"，请签字盖章回寄至公司。");
            	}
            	
            }else if("cwshtg".equals(act)){
            	int chargeid=h.getInt("chargeid");
            	Charge charge=Charge.find(chargeid);
            	charge.set("istzfws", "2");
            	String code=charge.getChargecode();
            	int member=charge.getMember();//服务商id
            	Profile profile=Profile.find(member);
            	String mobile=profile.getMobile();
            	if(!"".equals(mobile)){
            		//ShopHospital hospital=ShopHospital.find(back.getHospitalid());
            		SMSMessage.create("Home", profile.member, mobile, h.language, "服务费"+code+"已完成，请开具服务费发票。");
            	}
            }
            /*if ("askcharge".equals(act))
            {
            	//服务商提交服务费申请
            	//获取该服务商的应付服务费公式和进项税返还公式
            	Profile profile=Profile.find(h.member);
            	int formula=profile.formula;
            	int tax=profile.tax;
            	
            	int hid=h.getInt("hospital");
            	
            	String [] charges = h.getValues("issigns");//backinvoice的id
            	String invoiceids="";//发票id
            	//获取发票id
            	for(int i=0;i<charges.length;i++){
            		int backin=Integer.parseInt(charges[i]);
            		BackInvoice back=BackInvoice.find(backin);
            		back.set("chargestatus", "1");//待审核
            		String invoices=back.getInvoiceid();
            		invoiceids+=invoices;
            	}
            	String[] invoiceidarr=invoiceids.split(",");
            	//计算服务费
            	//开票总金额1
            	float totalamount=0;
            	//开票总数量
            	int totalnum=0;
            	float fuwufei=0;
            	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            	Date fdate=sdf.parse("2018-05-01 00:00:00");
            	for(int i=0;i<invoiceidarr.length;i++){
            		int inv=Integer.parseInt(invoiceidarr[i]);
            		List<InvoiceData> lstidata=InvoiceData.find(" and invoiceid="+inv, 0, Integer.MAX_VALUE);
            		//计算日期（18年5月前的发票1.17,5月后的发票1.16）
        			Invoice invoi=Invoice.find(inv);
        			Date mdate=invoi.getMakeoutdate();//开票日期
        			
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
            			//套入计算公式
            			if(formula==1){
            				//（单价-120）*0.983*（开票金额/单价）/1.17
            				if(mdate.getTime()<fdate.getTime()){
            					fuwufei+=(danjia-120)*0.983*(am/danjia)/1.17;
            				}else{
            					fuwufei+=(danjia-120)*0.983*(am/danjia)/1.16;
            				}
            				
            			}else{
            				//（单价-120）*0.9796*（开票金额/单价）/1.17
            				if(mdate.getTime()<fdate.getTime()){
            					fuwufei+=(danjia-120)*0.9796*(am/danjia)/1.17;
            				}else{
            					fuwufei+=(danjia-120)*0.9796*(am/danjia)/1.16;
            				}
            				
            			}
            		}
            	}
            	//计算进项税返还
            	float jinxiang=0;
            	if(tax==1){
            		jinxiang=(float) (fuwufei/1.06*0.06);
            	}else if(tax==2){
            		jinxiang=(float) ((fuwufei/1.06*0.06)/2);
            	}else if(tax==3){
            		jinxiang=(float) (fuwufei/1.03*0.03);
            	}else if(tax==4){
            		jinxiang=(float) ((fuwufei/1.03*0.03)/2);
            	}
            	
            	String backid="";
            	for(int i=0;i<charges.length;i++){
            		backid+=charges[i]+",";
            	}
            	Charge charge=Charge.find(0);
            	charge.setMember(h.member);
            	charge.setHospitalid(hid);
            	charge.setBackid(backid);
            	charge.setPayable(fuwufei);
            	charge.setInputtax(jinxiang);
            	charge.setTotal(fuwufei+jinxiang);
            	
            	charge.setStatus(0);
            	charge.setCreatedate(new Date());
            	charge.setChargecode("SE"+Seq.get());
            	charge.setInvoiceamount(totalamount);
            	charge.setInvoicenum(totalnum);
            	charge.set();
            	//发送短信
            	String user = Profile.find(h.member).getMember();
            	ShopHospital hospital=ShopHospital.find(charge.getHospitalid());
        		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find("",0,1);
        		if(list.size() > 0){
        			ShopSMSSetting sms = list.get(0);
        			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.fwfsh);
        			if(!"".equals(MT.f(mobiles.toString())))
        				SMSMessage.create("Home", user, mobiles.toString(), h.language, "申请服务费"+hospital.getName()+charge.getTotal()+"元，请审核。");
        		}
            }else if("backyes".equals(act)){
            	//订单管理员同意申请
            	int chargeid=h.getInt("chargeid");
            	Charge charge=Charge.find(chargeid);
            	charge.set("status", "1");
            	//修改backinvoice的状态
            	String[] backids=charge.getBackid().split(",");
            	for(int i=0;i<backids.length;i++){
            		int backid=Integer.parseInt(backids[i]);
            		BackInvoice invoice=BackInvoice.find(backid);
            		invoice.set("chargestatus", "2");//2为审核通过
            	}
            	//发送短信通知服务商
            	String user = Profile.find(h.member).getMember();
            	Profile fmember=Profile.find(charge.getMember());
            	String fmobile=fmember.getMobile();
            	if(!"".equals(fmobile)){
            		ShopHospital hospital=ShopHospital.find(charge.getHospitalid());
            		SMSMessage.create("Home", user, fmobile, h.language, "服务费申请"+hospital.getName()+"的"+charge.getTotal()+"元审核通过。");
            	}
            }else if("backno".equals(act)){
            	//订单管理员审核不通过
            	int chargeid=h.getInt("chargeid");
            	String nobackreason=h.get("nobackreason");//不通过原因
            	Charge charge=Charge.find(chargeid);
            	charge.set("status", "2");
            	charge.set("nobackreason", nobackreason);
            	//修改backinvoice的状态
            	String[] backids=charge.getBackid().split(",");
            	for(int i=0;i<backids.length;i++){
            		int backid=Integer.parseInt(backids[i]);
            		BackInvoice invoice=BackInvoice.find(backid);
            		invoice.set("chargestatus", "0");//0为未提交
            	}
            	//发送短信通知服务商
            	String user = Profile.find(h.member).getMember();
            	Profile fmember=Profile.find(charge.getMember());
            	String fmobile=fmember.getMobile();
            	if(!"".equals(fmobile)){
            		ShopHospital hospital=ShopHospital.find(charge.getHospitalid());
            		SMSMessage.create("Home", user, fmobile, h.language, "服务费申请"+hospital.getName()+"的"+charge.getTotal()+"元审核不通过，原因："+nobackreason);
            	}
            }*/
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
}
