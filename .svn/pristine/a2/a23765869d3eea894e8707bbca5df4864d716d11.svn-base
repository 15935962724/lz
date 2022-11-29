package tea.ui.lzInterface;


import net.sf.json.JSONArray;
import org.json.JSONObject;
import tea.entity.*;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.ShopHospital;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.ShopOrderData;
import tea.entity.yl.shop.ShopSMSSetting;
import tea.entity.yl.shopnew.*;
import util.Config;
import util.DateUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;


public class InvoiceInterface extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act", "");
        PrintWriter out = response.getWriter();
        JSONObject jo = new JSONObject();
        Enumeration e2 = request.getParameterNames();//获取所有参数名

        //获取请求的URL、参数
        StringBuffer stb = new StringBuffer();
        while (e2.hasMoreElements()) {//通过Enumeration类中的hasMoreElements()判断是否还有参数名
            String parameterName = (String) e2.nextElement(); //获取当前参数名
            //通过request.getParameter("")的方法来获取对应参数名的值
            stb.append(parameterName + "=" + request.getParameter(parameterName) + "&");

        }
        Filex.logs("log_interface/InvoiceInterface/Invoice_" + MT.f(new Date()) + ".log", "请求报文：" + request.getRequestURI() + "?" + stb.toString());

        try {
            if ("ADD_INVOICE_CODE".equals(act)) {//新增发票
                int invoiceId = h.getInt("INVOICE_ID", -1);//发票id
                String creatDate = h.get("CREAT_DATE", "");//开票日期
                String goldInvoiceCode = h.get("GOLD_INVOICE_CODE", "");//金票税号
                String trackingNumber = h.get("TRACKING_NUMBER", "");//物流单号  非必须
                String occTime = h.get("OCC_TIME", "");//请求时间
                Boolean checkDate = false;
                Date creatDateNew = new Date();
                try {
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                    creatDateNew = df.parse(creatDate);//抛异常就不是正确格式
                } catch (Exception f) {
                    checkDate = true;
                }
                int count = Invoice.count(" AND id=" + invoiceId);
                if (checkDate) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "CREAT_DATE参数有误！");
                } else if ("".equals(goldInvoiceCode)) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "GOLD_INVOICE_CODE参数不能为空！");
                } else if ("".equals(occTime)) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "OCC_TIME参数不能为空！");
                } else if (invoiceId==-1) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "INVOICE_ID参数不能为空！");
                } else  if(count!=1){
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "INVOICE_ID参数有误！");
                }else {
                    Invoice invoice = Invoice.find(invoiceId);
                    invoice.setInvoiceno(goldInvoiceCode);
                    invoice.setMakeoutdate(creatDateNew);
                    invoice.setStatus(2);//发票已开
                    invoice.set();
                    //发送短信通知订单管理员
                    String user = "webmaster";
                    ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid=" + invoice.getPuid(), 0, 1);
                    if (list.size() > 0) {
                        ShopSMSSetting sms = list.get(0);
                        List<String> mobiles = ShopSMSSetting.getUserMobile(sms.cwykp);
                        if (!"".equals(MT.f(mobiles.toString())))
                            SMSMessage.create("Home", user, mobiles.toString(), 1, invoice.getHospital() + invoice.getNum() + "粒已开具发票。");
                    }

                    List<InvoiceData> lstinvoicedata = InvoiceData.find(" and invoiceid=" + invoiceId, 0, Integer.MAX_VALUE);
                    //计算已开发票数量
                    for (int i = 0; i < lstinvoicedata.size(); i++) {
                        InvoiceData data = lstinvoicedata.get(i);
                        data.set("status", "2");
                        String orderid = data.getOrderid();
                        List<InvoiceData> lstdata = InvoiceData.find(" and orderid=" + Database.cite(orderid) + " and status in(2,4,6)", 0, Integer.MAX_VALUE);
                        int yinum = 0;
                        float yiamount = 0;
                        for (int j = 0; j < lstdata.size(); j++) {
                            InvoiceData idata = lstdata.get(j);
                            yinum += idata.getNum();
                            yiamount += idata.getAmount();
                        }
                        ShopOrder shoporder = ShopOrder.findByOrderId(orderid);
                        shoporder.set("isinvoicenum", String.valueOf(yinum));//已开发票数量
                        shoporder.set("isinvoiceamount", String.valueOf(yiamount));//已开发票金额
                        //改变invoicestatus
                        List<ShopOrderData> lstorderdata = ShopOrderData.find(" and order_id=" + Database.cite(orderid), 0, Integer.MAX_VALUE);
                        if (lstorderdata.size() > 0) {
                            ShopOrderData orderdata = lstorderdata.get(0);
                            if (orderdata.getQuantity() == yinum) {
                                shoporder.set("invoicestatus", "3");
                            }
                        }

                    }
                    //开具发票后导致未开票粒子数减少，未开票粒子数增加
                    ChangeLiziData.makenoinvoice(invoice.getHospitalid(), invoice.getNum(), invoice.getMakeoutdate(), h.member, invoice.getId());
                    //开具发票后导致应收账款增加
                    ChangeYingshouData.addyingshou(invoice.getHospitalid(), invoice.getAmount(), invoice.getMakeoutdate(), h.member, invoice.getId());

                    jo.put("status", "success");
                    jo.put("id", invoiceId);
                }

            }else if("westrac".equals(act)){
                net.sf.json.JSONObject jsonObject = new net.sf.json.JSONObject();
                jsonObject.put("isok","true");
                JSONArray jsonArray = new JSONArray();
                for (int i = 1; i <3 ; i++) {
                    net.sf.json.JSONObject jsonObject2 = new net.sf.json.JSONObject();
                    jsonObject2.put("khmc","khmc"+i);
                    jsonObject2.put("lastmodifybyidccname","lastmodifybyidccname"+i);
                    jsonObject2.put("khdb_name","khdb_name"+i);
                    jsonObject2.put("owneridccname","owneridccname"+i);
                    jsonObject2.put("createdate",new Date()+"");
                    jsonObject2.put("createbyid","createbyid"+i);
                    jsonObject2.put("createbyidccname","createbyidccname"+i);
                    jsonObject2.put("htdqrq",new Date()+"");
                    jsonObject2.put("cvaconccname","cvaconccname"+i);
                    jsonObject2.put("khdbName","khdbName"+i);
                    jsonObject2.put("khdm","khdm"+i);
                    jsonObject2.put("recordtype","recordtype"+i);
                    jsonObject2.put("currency","currency"+i);
                    jsonObject2.put("id","id"+i);
                    jsonObject2.put("CVACon","CVACon"+i);
                    jsonObject2.put("lastmodifybyid","lastmodifybyid"+i);
                    jsonObject2.put("tbzt","tbzt"+i);
                    jsonObject2.put("lastmodifydate",new Date()+"");
                    jsonObject2.put("CCObjectAPI","CCObjectAPI"+i);
                    jsonObject2.put("khmcName","khmcName"+i);
                    jsonObject2.put("khmcccname","khmcccname"+i);
                    jsonObject2.put("htqsrq",new Date()+"");
                    jsonObject2.put("cvacon","cvacon"+i);
                    jsonObject2.put("khdb","khdb"+i);
                    jsonObject2.put("khdbccname","khdbccname"+i);
                    jsonObject2.put("ownerid","ownerid"+i);
                    jsonObject2.put("recordtypeccname","recordtypeccname"+i);
                    jsonObject2.put("khmc_name","khmc_name"+i);
                    jsonObject2.put("khgm","khgm"+i);
                    jsonObject2.put("tbsj","tbsj"+i);
                    jsonObject2.put("name","name"+i);
                    jsonObject2.put("summarize","summarize"+i);
                    jsonObject2.put("lbsaddress","lbsaddress"+i);
                    jsonObject2.put("khgx","khgx"+i);
                    jsonArray.add(jsonObject2);
                }
                jsonObject.put("data", jsonArray.toString());
                out.print(jsonObject);
                return;

            } else {
                jo.put("status", "fail");//返回失败
                jo.put("message", "act参数有误！");
            }

        } catch (Exception e) {
            e.printStackTrace();
            jo.put("status", "fail");
            jo.put("message", "系统异常");
        } finally {
            String backTime = DateUtil.getStringFromDate(new Date(), "yyyy-MM-dd HH:mm:ss");
            jo.put("OCC_TIME", backTime);//接口响应时间
            Filex.logs("log_interface/InvoiceInterface/Invoice_" + MT.f(new Date()) + ".log", "响应报文：" + jo.toString());
            if(!"westrac".equals(act)) {
                out.print(jo);
            }
        }
    }
}
