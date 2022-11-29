package tea.ui.yl.shop;

import net.sf.json.JSONObject;
import tea.SeqShop;
import tea.db.DbAdapter;
import tea.entity.Database;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.admin.AdminRole;
import tea.entity.admin.AdminUsrRole;
import tea.entity.member.ModifyRecord;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.weixin.WxUser;
import tea.entity.yl.shop.*;
import tea.entity.yl.shopnew.*;
import util.CommonUtils;
import util.Config;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

/*import tea.ui.lzInterface.CreatOrderSendCrm;*/

/**
 * 商品订单
 */
public class ShopOrders extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        CommonUtils utils = new CommonUtils();
        JSONObject jo = new JSONObject();
        if ("exp".equals(act)) {
            try {
                int category = h.getInt("category");
                int exflag = h.getInt("exflag");
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("订单" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("订单", 0);
                int index = 0;
                ws.addCell(new jxl.write.Label(index++, 0, "订货日期"));
                ws.addCell(new jxl.write.Label(index++, 0, "订单号"));
                ws.addCell(new jxl.write.Label(index++, 0, "销售编码"));

                ws.addCell(new jxl.write.Label(index++, 0, "用户"));
                ws.addCell(new jxl.write.Label(index++, 0, "服务商"));

                ws.addCell(new jxl.write.Label(index++, 0, "订货单位"));
                ws.addCell(new jxl.write.Label(index++, 0, "收货单位"));

                ws.addCell(new jxl.write.Label(index++, 0, "收货人"));
                ws.addCell(new jxl.write.Label(index++, 0, "签收人"));

                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "购买数量"));
                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "活度"));

                if (exflag > 0) ws.addCell(new jxl.write.Label(index++, 0, "退货数量"));
                if (exflag > 0) ws.addCell(new jxl.write.Label(index++, 0, "退货金额"));

                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "单价"));
                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "总价"));

                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "开票价"));
                ws.addCell(new jxl.write.Label(index++, 0, "开票金额"));

                ws.addCell(new jxl.write.Label(index++, 0, "开票日期"));
                ws.addCell(new jxl.write.Label(index++, 0, "原发票号"));
                if (exflag > 0) ws.addCell(new jxl.write.Label(index++, 0, "新发票号"));

                ws.addCell(new jxl.write.Label(index++, 0, "备注"));

                String sql = h.get("sql");
                List<ShopOrder> solist = ShopOrder.findOrders(category, sql, 0, Integer.MAX_VALUE);
                double pricesum = 0;//订单总额
                double tsum = 0;//退款总额
                for (int e = 0; e < solist.size(); e++) {
                    ShopOrder so = solist.get(e);
                    Profile profile = Profile.find(so.getMember());
                    String uname = MT.f(profile.member);
                    ShopOrderDispatch sodh = ShopOrderDispatch.findByOrderId(so.getOrderId());
                    List<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id = " + Database.cite(so.getOrderId()), 0, Integer.MAX_VALUE);
                    ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
                    String proname = "";
                    double prices = 0;
                    int count = 0;
                    double price = 0;
                    double agent_unit = 0;
                    double agent_amount = 0;
                    if (so.isLzCategory()) {
                        for (int r = 0; r < sodlist.size(); r++) {
                            ShopOrderData sod = sodlist.get(r);
                            proname = sod.getActivity() + "";
                            prices += sod.getAmount();
                            count += sod.getQuantity();
                            price = sod.getUnit();
                            if (profile.membertype == 2) {
                                //服务商开票价
                                //ShopPriceSet sps = ShopPriceSet.find(sodh.getA_hospital_id(),sod.getProductId(),0);
                                price = sod.getAgent_price_s();        //服务商显示价
                                prices = sod.getAgent_price_s() * sod.getQuantity();    //服务商显示总价
                                agent_unit = sod.getAgent_price();        //服务商开票价
                                agent_amount = sod.getAgent_amount();    //服务商开票金额
                            } else {
                                agent_unit = price;
                                agent_amount = prices;
                            }
                            pricesum += agent_amount;
                        }
                    } else {
                        for (int r = 0; r < sodlist.size(); r++) {
                            ShopOrderData sod = sodlist.get(r);
                            prices += sod.getAmount();
                            pricesum += prices;
                            count += sod.getQuantity();
                            price = sod.getUnit();
                        }
                    }
                    double tprice = 0;//退款金额
                    int tquantity = 0;//退货数量  此处针对粒子
                    List<ShopExchanged> selist = ShopExchanged.find(" AND order_id = " + Database.cite(so.getOrderId()) + " AND type = 1 and status = 1 ", 0, Integer.MAX_VALUE);
                    for (int x = 0; x < selist.size(); x++) {
                        ShopExchanged sex = selist.get(x);
                        ShopOrderData sod = ShopOrderData.find(" AND product_id = " + sex.product_id + " AND order_id = " + Database.cite(so.getOrderId()), 0, 1).get(0);
                        tprice += (sod.getUnit() * sex.quantity);
                        tquantity = sex.quantity;
                    }
                    tsum += tprice;
                    index = 0;
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(so.getCreateDate())));
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(so.getOrderId())));
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(soe.NO1)));
                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? uname : ""));
                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? "" : uname));
                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? MT.f(so.getOrderUnit()) : MT.f(sodh.getA_hospital())));
                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? MT.f(sodh.getN_company()) : MT.f(sodh.getA_hospital())));

                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(sodh.getA_consignees()))); //收货人
                    ws.addCell(new jxl.write.Label(index++, e + 1, Profile.getMemberByOpenId(so.getSign_user_openid())));    //签收人

                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(count)));
                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(proname)));

                    if (exflag > 0) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(tquantity)));
                    if (exflag > 0) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(tprice, 2)));

                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(price, 2)));
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(prices, 2)));

                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(agent_unit, 2)));
                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(agent_amount, 2)));

                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(sodh.getN_invoiceTime())));
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(sodh.getN_invoiceNo())));
                    if (exflag > 0) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(sodh.getN_invoiceNoNew())));

                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(so.getUserRemarks())));
                }
                if (exflag > 0) {
                    ws.addCell(new jxl.write.Label(0, solist.size() + 1, "开票金额合计：" + (pricesum / 10000) + " 万 退款金额：" + tsum + " 实际获得金额：" + ((pricesum - tsum) / 10000) + "万"));
                } else {
                    ws.addCell(new jxl.write.Label(0, solist.size() + 1, "开票金额合计：" + (pricesum / 10000) + " 万"));
                }

                wwb.write();
                wwb.close();
                os.close();
                return;
            } catch (Exception e) {
            }
        } else if ("exp_sh".equals(act)) {
            try {

                int crole = AdminRole.findByName("价格", "Home");//角色
                Enumeration ce = AdminUsrRole.findByRole(crole);

                boolean isadmin = false;//是否显示价格
                while (ce.hasMoreElements()) {
                    int cpro = Integer.parseInt(String.valueOf(ce.nextElement()));
                    if (cpro == h.member) {
                        isadmin = true;
                        break;
                    }
                }
                if (h.member == 14100001) {
                    isadmin = true;
                }

                int category = h.getInt("category");
                int exflag = h.getInt("exflag");
                String puid = h.get("puid");//高科导出增加订单数

                //同辐收货人
                String tfshr = "";
                if ("tongfu".equals(puid)) {
                    ProcurementUnit procurementUnit = ProcurementUnit.find(0);
                    tfshr = procurementUnit.getPerson();
                }
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("订单" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("订单", 0);
                int index = 0;
                ws.addCell(new jxl.write.Label(index++, 0, "订货日期"));
                ws.addCell(new jxl.write.Label(index++, 0, "订单号"));
                ws.addCell(new jxl.write.Label(index++, 0, "销售编码"));

                ws.addCell(new jxl.write.Label(index++, 0, "用户"));
                ws.addCell(new jxl.write.Label(index++, 0, "服务商"));

                //ws.addCell(new jxl.write.Label(index++, 0, "服务商公司"));

                ws.addCell(new jxl.write.Label(index++, 0, "订货单位"));
                ws.addCell(new jxl.write.Label(index++, 0, "收货单位"));
                if ("tongfu".equals(puid)) {
                    ws.addCell(new jxl.write.Label(index++, 0, "同辐收货人"));
                }
                ws.addCell(new jxl.write.Label(index++, 0, "收货人"));
                ws.addCell(new jxl.write.Label(index++, 0, "收货地址"));
                ws.addCell(new jxl.write.Label(index++, 0, "收货人手机"));
                ws.addCell(new jxl.write.Label(index++, 0, "签收人"));

                ws.addCell(new jxl.write.Label(index++, 0, "购买数量"));
                ws.addCell(new jxl.write.Label(index++, 0, "活度"));

                if (isadmin) {
                    if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "单价"));
                    if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "总价"));

                    /*if(category>1)ws.addCell(new jxl.write.Label(index++, 0, "开票价"));
                    if(category>1)ws.addCell(new jxl.write.Label(index++, 0, "开票金额"));*/
                    ws.addCell(new jxl.write.Label(index++, 0, "开票价"));
                    ws.addCell(new jxl.write.Label(index++, 0, "开票金额"));
                }

                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "开票日期"));
                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "原发票号"));

                ws.addCell(new jxl.write.Label(index++, 0, "备注"));
                if (("tongfu").equals(puid)) {
                    ws.addCell(new jxl.write.Label(index++, 0, "厂商"));
                }
                ws.addCell(new jxl.write.Label(index++, 0, "已开票数量"));
                ws.addCell(new jxl.write.Label(index++, 0, "未开票数量"));
                ws.addCell(new jxl.write.Label(index++, 0, "发货日期"));
                ws.addCell(new jxl.write.Label(index++, 0, "发货运单号"));
                ws.addCell(new jxl.write.Label(index++, 0, "状态"));
                ws.addCell(new jxl.write.Label(index++, 0, "签收时间"));
                ws.addCell(new jxl.write.Label(index++, 0, "发票运单号"));
                if ("tongfu".equals(puid)) {
                    ws.addCell(new jxl.write.Label(index++, 0, "生产批号"));
                    ws.addCell(new jxl.write.Label(index++, 0, "有效期"));
                }
                ws.addCell(new jxl.write.Label(index++, 0, "校准日期"));

                String sql = h.get("sql");
                //导出，把取消的订单筛选掉
                List<ShopOrder> solist = ShopOrder.find(" AND so.status!=5 " + sql + " order by so.createDate desc ", 0, Integer.MAX_VALUE);
                if ("tongfu".equals(puid)) {//同福订单导出排序
                    solist = ShopOrder.find(" AND so.status!=5 " + sql + " order by so.createDate ", 0, Integer.MAX_VALUE);
                }
                if (10 == h.getInt("status10")) {//出库君安
                    solist = ShopOrder.find(" AND so.status!=5 " + sql, 0, Integer.MAX_VALUE);
                }
                double pricesum = 0;//订单总额
                double tsum = 0;//退款总额
                for (int e = 0; e < solist.size(); e++) {
                    Date calibrationDate = new Date();
                    ShopOrder so = solist.get(e);
                    Profile profile = Profile.find(so.getMember());
                    String uname = MT.f(profile.member);
                    ShopOrderDispatch sodh = ShopOrderDispatch.findByOrderId(so.getOrderId());
                    List<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id = " + Database.cite(so.getOrderId()), 0, Integer.MAX_VALUE);
                    ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
                    if (so.getStatus() == 7) {
                        soe = ShopOrderExpress.findByOrderId(so.getOldorderid());
                    }
                    String proname = "";
                    double prices = 0;
                    int count = 0;
                    double price = 0;
                    double agent_unit = 0;
                    double agent_amount = 0;
                    int invoicenum = 0;
                    if (so.isLzCategory()) {
                        for (int r = 0; r < sodlist.size(); r++) {
                            ShopOrderData sod = sodlist.get(r);
                            calibrationDate = sod.getCalibrationDate();
                            invoicenum += sod.getQuantity();
                            proname = sod.getActivity() + "";
                            prices += sod.getAmount();
                            count += sod.getQuantity();
                            price = sod.getUnit();
                            if (profile.membertype == 2) {
                                //服务商开票价
                                //ShopPriceSet sps = ShopPriceSet.find(sodh.getA_hospital_id(),sod.getProductId(),0);
                                price = sod.getAgent_price_s();        //服务商显示价
                                prices = sod.getAgent_price_s() * sod.getQuantity();    //服务商显示总价
                                agent_unit = sod.getAgent_price();        //服务商开票价
                                agent_amount = sod.getAgent_amount();    //服务商开票金额
                            } else {
                                agent_unit = price;
                                agent_amount = prices;
                            }
                            pricesum += agent_amount;
                        }
                    } else {
                        for (int r = 0; r < sodlist.size(); r++) {
                            ShopOrderData sod = sodlist.get(r);
                            prices += sod.getAmount();
                            pricesum += prices;
                            count += sod.getQuantity();
                            price = sod.getUnit();
                        }
                    }
                    double tprice = 0;//退款金额
                    int tquantity = 0;//退货数量  此处针对粒子
                    List<ShopExchanged> selist = ShopExchanged.find(" AND order_id = " + Database.cite(so.getOrderId()) + " AND type = 1 and status = 1 ", 0, Integer.MAX_VALUE);
                    for (int x = 0; x < selist.size(); x++) {
                        ShopExchanged sex = selist.get(x);
                        ShopOrderData sod = ShopOrderData.find(" AND product_id = " + sex.product_id + " AND order_id = " + Database.cite(so.getOrderId()), 0, 1).get(0);
                        tprice += (sod.getUnit() * sex.quantity);
                        tquantity = sex.quantity;
                    }
                    tsum += tprice;
                    index = 0;
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(so.getCreateDate())));
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(so.getOrderId())));
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(soe.NO1)));
                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? uname : ""));
                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? "" : uname));

                    int ho_id = 0;
                    String fwsName = "";
                    int aaa = ShopOrderData.findPuid(so.getOrderId());
                    ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
                    List<ShopHospital> list1 = ShopHospital.find("AND name=" + DbAdapter.cite(sod.getA_hospital()), 0, Integer.MAX_VALUE);
                    for (ShopHospital d : list1) {
                        ho_id = d.getId();
                    }
                    ProcurementUnitJoin pu = ProcurementUnitJoin.find(aaa, so.getMember(), ho_id);
                    fwsName = pu.getCompany();

                    //ws.addCell(new jxl.write.Label(index++, e + 1, fwsName));

                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? MT.f(so.getOrderUnit()) : MT.f(sodh.getA_hospital())));
                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? MT.f(sodh.getN_company()) : MT.f(sodh.getA_hospital())));

                    if ("tongfu".equals(puid)) {
                        ws.addCell(new jxl.write.Label(index++, e + 1, tfshr)); //同辐收货人
                    }
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(sodh.getA_consignees()))); //收货人
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(sodh.getA_address()))); //收货地址
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(sodh.getA_mobile()))); //收货人手机
                    /*增加君安订单状态   2019-12-17 刘卓奇*/

                    int status = so.getStatus();
                    String statusContent = "";
                    if (status == 0)
                        statusContent = "未付款";
                    else if (status == 1)
                        statusContent = "确认发货";
                    else if (status == 2)
                        statusContent = "未出库";
                    else if (status == 3)
                        statusContent = "已出库";
                    else if (status == 4)
                        statusContent = "已完成";
                    else if (status == 5)
                        statusContent = "已取消";
                    else if (status == 7)
                        statusContent = "已退货";
                    else if (status == -1)
                        statusContent = "待验收";
                    else if (status == -2)
                        statusContent = "待入库";
                    else if (status == -3)
                        statusContent = "验收不通过";
                    else if (status == -4)
                        statusContent = "入库不通过";
                    else if (status == -5)
                        statusContent = "待出库";


                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(sodh.getA_consignees())));    //签收人

                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(count)));//数量
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(proname)));

                    if (isadmin) {
                        if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(price, 2)));

                        if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(prices, 2)));


                        /*if(category>1)ws.addCell(new jxl.write.Label(index++, e+1, MT.f(agent_unit,2)));
                        if(category>1)ws.addCell(new jxl.write.Label(index++, e+1, MT.f(agent_amount,2)));*/
                        ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(agent_unit, 2)));

                        //ws.addCell(new jxl.write.Label(index++, e+1, MT.f(agent_amount,2)));//服务商开票价
                        if (so.getIsinvoiceamount() == 0) {
                            ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(agent_unit * count, 2)));
                        } else {
                            ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(so.getIsinvoiceamount(), 2)));

                        }
                    }
                    //获取开票日期和发票号
                    List<InvoiceData> lstindata = InvoiceData.find(" and orderid=" + DbAdapter.cite(so.getOrderId()), 0, Integer.MAX_VALUE);
                    String invoicedate = "";//开票日期
                    String invoiceno = "";//发票号
                    for (int a = 0; a < lstindata.size(); a++) {
                        InvoiceData indata = lstindata.get(a);
                        Invoice invoice = Invoice.find(indata.getInvoiceid());

                        if (a == lstindata.size() - 1) {
                            if (invoice.getInvoiceno() != null) {
                                invoiceno += invoice.getInvoiceno();
                            }
                            if (invoice.getMakeoutdate() != null) {
                                invoicedate += MT.f(invoice.getMakeoutdate());
                            }
                        } else {
                            if (invoice.getInvoiceno() != null) {
                                invoiceno += invoice.getInvoiceno() + ",";
                            }
                            if (invoice.getMakeoutdate() != null) {
                                invoicedate += MT.f(invoice.getMakeoutdate()) + ",";
                            }
                        }


                    }
                        /*if(category>1)ws.addCell(new jxl.write.Label(index++, e+1, MT.f(sodh.getN_invoiceTime())));
                        if(category>1)ws.addCell(new jxl.write.Label(index++, e+1,  MT.f(sodh.getN_invoiceNo())));*/
                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, invoicedate));
                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, invoiceno));

                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(so.getUserRemarks())));
                    if (("tongfu").equals(puid)) {
                        ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(ProcurementUnit.findName(ShopOrderData.findPuid(so.getOrderId())))));
                    }
                    ws.addCell(new jxl.write.Label(index++, e + 1, so.getIsinvoicenum() + ""));
                    ws.addCell(new jxl.write.Label(index++, e + 1, invoicenum - so.getIsinvoicenum() + ""));
                    //发货日期
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(soe.time)));
                    //发货运单号
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(soe.express_code)));
                    //状态
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(statusContent))); //订单状态
                    //签收时间
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(so.getReceiptTime(), 1))); //签收时间    210428 王双瑞要求增加签收时间
                    //发票运单号
                    if (lstindata.size() > 0) {
                        InvoiceData invoiceData = lstindata.get(0);
                        Invoice invoice = Invoice.find(invoiceData.getInvoiceid());
                        ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(invoice.getCourierno()))); //发票单号
                    } else {
                        ws.addCell(new jxl.write.Label(index++, e + 1, "")); //发票单号
                    }
                    if (("tongfu").equals(puid)) {
                        ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(soe.NO2)));
                        ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(soe.vtime)));
                    }
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(calibrationDate)));




                }

                if (category > 1) ws.addCell(new jxl.write.Label(0, solist.size() + 1, "开票金额合计：" + pricesum));
                if ("gaoke".equals(puid)) ws.addCell(new jxl.write.Label(0, solist.size() + 2, "订单数量合计：" + solist.size()));
                wwb.write();
                wwb.close();
                os.close();
                return;
            } catch (Exception e) {
            }
        } else if ("exp_yiyuan".equals(act)) {//导出君安服务商医院信息  20200715 李双瑞要求改为所有医院
            try {
                int exp_type = h.getInt("exp_type");//导出那个厂商的医院信息    0高科   1欣科  2君安
                String name = "";
                String typenum = "";
                if (exp_type == 0) {
                    name += "高科";
                    typenum = Config.getString("gaoke");
                } else if (exp_type == 1) {
                    name += "欣科";
                    typenum = Config.getString("xinke");
                } else if (exp_type == 2) {
                    name += "君安";
                    typenum = Config.getString("junan");
                } else {
                    name += "所有";
                }
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(name + "服务商医院信息" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("医院信息", 0);
                int index = 0;
                if (exp_type == 3) {
                    ws.addCell(new jxl.write.Label(index++, 0, "厂商"));
                }
                ws.addCell(new jxl.write.Label(index++, 0, "医院名称"));
                ws.addCell(new jxl.write.Label(index++, 0, "服务商姓名"));
                ws.addCell(new jxl.write.Label(index++, 0, "公司名称"));
                ws.addCell(new jxl.write.Label(index++, 0, "手机号"));

/*                ws.addCell(new jxl.write.Label(index++, 0, "开票价格"));
                ws.addCell(new jxl.write.Label(index++, 0, "底价"));*/
                ws.addCell(new jxl.write.Label(index++, 0, "收货人"));
                ws.addCell(new jxl.write.Label(index++, 0, "收货地址"));
                ws.addCell(new jxl.write.Label(index++, 0, "收货人手机"));
                ws.addCell(new jxl.write.Label(index++, 0, "收票人"));
                ws.addCell(new jxl.write.Label(index++, 0, "收票地址"));
                ws.addCell(new jxl.write.Label(index++, 0, "收票人手机"));
                int myindex = 0;

                int exindex = 1;

                for (int k = 0; k < 3; k++) {//第一次循环高科 二次欣科 三次君安
                    String fuwuname = "";
                    if (exp_type == 0) {
                        typenum = Config.getString("gaoke");
                    } else if (exp_type == 1) {
                        typenum = Config.getString("xinke");
                    } else if (exp_type == 2) {
                        typenum = Config.getString("junan");
                    } else {
                        if (k == 0) {
                            typenum = Config.getString("gaoke");
                            fuwuname = "高科";
                        } else if (k == 1) {
                            typenum = Config.getString("xinke");
                            fuwuname = "欣科";
                        } else if (k == 2) {
                            typenum = Config.getString("junan");
                            fuwuname = "君安";
                        }
                    }
                    ArrayList arrayList = Profile.find1(" AND procurementUnit like " + Database.cite("%" + typenum + "%"), 0, Integer.MAX_VALUE);
                    for (int e = 0; e < arrayList.size(); e++) {
                        Profile o = (Profile) arrayList.get(e);
                        String hospitals = o.hospitals;
                        if (hospitals != null && !"".equals(hospitals)) {
                            String[] substring = hospitals.split("[|]");
                            if (substring.length > 1) {
                                for (int i = 1; i < substring.length; i++) {
                                    String s = substring[i];
                                    ShopHospital shopHospital = ShopHospital.find(Integer.parseInt(s));
                                    if (shopHospital.getProductPuid() != Integer.parseInt(typenum)) {
                                        continue;
                                    }
                                    if (shopHospital.getName() != null) {
                                        List<ProcurementUnitJoin> pujlist = ProcurementUnitJoin.find(" AND profile = " + o.profile, 0, Integer.MAX_VALUE);
                                        ProcurementUnitJoin puj = null;
                                        if (pujlist.size() > 0) {
                                            puj = pujlist.get(0);
                                        }
                               /* ArrayList arrayList1 = ShopProduct.find("AND puid=" + Config.getInt("junan"), 0, 1);
                                ShopProduct o1 = null;
                                int product_id = 0;
                                if (arrayList1.size() > 0) {
                                    o1 = (ShopProduct) arrayList1.get(0);
                                    product_id = o1.product;
                                }*/

                                /*ArrayList arrayList2 = ShopPriceSet.find("AND product_id=" + product_id + " AND hospital_id=" + Integer.valueOf(s), 0, 1);
                                ShopPriceSet shopPriceSet = null;
                                if (arrayList2.size() > 0) {
                                    shopPriceSet = (ShopPriceSet) arrayList2.get(0);
                                }*/
                                        ArrayList arrayList3 = Profile.find1("AND hospital like " + DbAdapter.cite("%" + s + "%"), 0, Integer.MAX_VALUE);
                                        Profile p = null;
                                        Profile p2 = null;
                                        for (int j = 0; j < arrayList3.size(); j++) {
                                            Profile profile = (Profile) arrayList3.get(j);
                                            if (profile.particles_sign == 1) {//收货人
                                                p = profile;
                                            }
                                            if (profile.invoice_sign == 1) {//发票
                                                p2 = profile;
                                            }
                                        }
                                        index = 0;
                                        if (exp_type == 3) {
                                            ws.addCell(new jxl.write.Label(index++, exindex, fuwuname));
                                        }
                                        ws.addCell(new jxl.write.Label(index++, exindex, MT.f(shopHospital == null ? "" : shopHospital.getName())));
                                        ws.addCell(new jxl.write.Label(index++, exindex, MT.f(o == null ? "" : o.getMember())));
                                        ws.addCell(new jxl.write.Label(index++, exindex, MT.f(puj == null ? "" : puj.getCompany())));
                                        ws.addCell(new jxl.write.Label(index++, exindex, MT.f(o == null ? "" : o.getMobile())));


                                /*ws.addCell(new jxl.write.Label(index++, exindex, MT.f(shopPriceSet == null ? "" : shopPriceSet.price + "")));
                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(puj == null ? "" : puj.getAgentPriceNew() + "")));*/
                                        ws.addCell(new jxl.write.Label(index++, exindex, MT.f(p == null ? "" : p.getMember())));
                                        ws.addCell(new jxl.write.Label(index++, exindex, MT.f(p == null ? "" : p.address)));
                                        ws.addCell(new jxl.write.Label(index++, exindex, MT.f(p == null ? "" : p.getMobile())));

                                        ws.addCell(new jxl.write.Label(index++, exindex, MT.f(p2 == null ? "" : p2.getMember())));
                                        ws.addCell(new jxl.write.Label(index++, exindex, MT.f(p2 == null ? "" : p2.address)));
                                        ws.addCell(new jxl.write.Label(index++, exindex, MT.f(p2 == null ? "" : p2.getMobile())));

                                        myindex++;
                                        exindex++;


                                    }
                                }
                            }
                        }


                    }
                    if (exp_type != 3) {//不导出全部
                        break;
                    }
                }


                wwb.write();
                wwb.close();
                os.close();
                return;
            } catch (Exception e) {
            }
        } else if ("exp_shfp".equals(act)) {
            try {
                int category = h.getInt("category");
                int exflag = h.getInt("exflag");
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("分批订单" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("订单", 0);
                int index = 0;
                ws.addCell(new jxl.write.Label(index++, 0, "序号"));
                ws.addCell(new jxl.write.Label(index++, 0, "订货日期"));
                ws.addCell(new jxl.write.Label(index++, 0, "订单号"));
                ws.addCell(new jxl.write.Label(index++, 0, "订单活度"));
                ws.addCell(new jxl.write.Label(index++, 0, "服务商"));
                ws.addCell(new jxl.write.Label(index++, 0, "订货单位"));
                ws.addCell(new jxl.write.Label(index++, 0, "收货人"));
                ws.addCell(new jxl.write.Label(index++, 0, "收货地址"));

                ws.addCell(new jxl.write.Label(index++, 0, "购买数量"));
                ws.addCell(new jxl.write.Label(index++, 0, "批数"));
                ws.addCell(new jxl.write.Label(index++, 0, "分批收订活度"));
                ws.addCell(new jxl.write.Label(index++, 0, "库存批号"));
                ws.addCell(new jxl.write.Label(index++, 0, "库存质检号"));
                ws.addCell(new jxl.write.Label(index++, 0, "入库活度"));
                ws.addCell(new jxl.write.Label(index++, 0, "当前活度"));
                ws.addCell(new jxl.write.Label(index++, 0, "数量"));
                ws.addCell(new jxl.write.Label(index++, 0, "批次数量"));

                ws.addCell(new jxl.write.Label(index++, 0, "分批时间"));

                int myindex = 0;

                int exindex = 1;

                String sql = h.get("sql");
                //导出，把取消的订单筛选掉
                List<ShopOrder> solist = ShopOrder.find(" AND so.status!=5 " + sql, 0, Integer.MAX_VALUE);
                double pricesum = 0;//订单总额
                double tsum = 0;//退款总额
                for (int e = 0; e < solist.size(); e++) {
                    ShopOrder so = solist.get(e);
                    Profile profile = Profile.find(so.getMember());
                    String uname = MT.f(profile.member);
                    ShopOrderDispatch sodh = ShopOrderDispatch.findByOrderId(so.getOrderId());
                    List<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id = " + Database.cite(so.getOrderId()), 0, Integer.MAX_VALUE);
                    ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
                    if (so.getStatus() == 7) {
                        soe = ShopOrderExpress.findByOrderId(so.getOldorderid());
                    }
                    String proname = "";
                    double prices = 0;
                    int count = 0;
                    double price = 0;
                    double agent_unit = 0;
                    double agent_amount = 0;




                    String querySql = " AND order_id=" + DbAdapter.cite(so.getOrderId());
                    List<ShopOrderData> sodList = ShopOrderData.find(querySql, 0, Integer.MAX_VALUE);
                    ShopOrderData odata = ShopOrderData.find(0);
                    if (sodList.size() > 0) {
                        odata = sodList.get(0);
                    }
                    ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());

                    //分批
                    String sodbsql = " AND ordercode = " + Database.cite(so.getOrderId());
                    int sodbcount = ShopOrderDatasBatches.count(sodbsql);
                    List<ShopOrderDatasBatches> sodblist = ShopOrderDatasBatches.find(sodbsql, 0, Integer.MAX_VALUE);




                    if(sodbcount>0) {
                        for (int i = 0; i < sodblist.size(); i++) {
                            ShopOrderDatasBatches sodb1 = sodblist.get(i);


                            String[] soids = MT.f(sodb1.getSoid(), ",").split(",");
                            for (int j = 1; j < soids.length; j++) {
                                StockOperation so1 = StockOperation.find(Integer.parseInt(soids[j]));
                                ProductStock ps1 = ProductStock.find(so1.getPsid());
                                index = 0;
                                ws.addCell(new jxl.write.Label(index++, exindex, (myindex + 1) + ""));
                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(odata.getCalibrationDate())));
                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(so.getOrderId())));
                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(odata.getActivity())));
                                ws.addCell(new jxl.write.Label(index++, exindex, uname));
                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(sod.getA_hospital())));

                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(sodh.getA_consignees()))); //收货人

                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(sodh.getA_address()))); //收货地址

                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(odata.getQuantity())));//数量

                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f((i + 1))));


                                ws.addCell(new jxl.write.Label(index++, exindex, sodb1.getActivity() + ""));
                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(ps1.getBatch())));


                                NumberFormat ddf1 = NumberFormat.getNumberInstance();
                                ddf1.setMaximumFractionDigits(3);
                                String s = ddf1.format(so1.getActivity());
                                String s2 = ddf1.format(ps1.getActivity());
                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(ps1.getQuality())));
                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(s2)));
                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f((s))));

                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f((so1.getAmount() + so1.getReserve()))));

                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(sodb1.getNumber())));

                                ws.addCell(new jxl.write.Label(index++, exindex, MT.f(sodb1.getTime())));

                                myindex++;
                                exindex++;
                            }

                        }
                    }


                }


                wwb.write();
                wwb.close();
                os.close();
                return;
            } catch (Exception e) {
            }
        } else if ("exp_invoice".equals(act)) {
            try {
                int category = h.getInt("category");
                int exflag = h.getInt("exflag");
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("订单" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("订单", 0);
                int index = 0;
                ws.addCell(new jxl.write.Label(index++, 0, "订货日期"));
                ws.addCell(new jxl.write.Label(index++, 0, "订单号"));
                ws.addCell(new jxl.write.Label(index++, 0, "销售编码"));
                ws.addCell(new jxl.write.Label(index++, 0, "生产编码"));
                ws.addCell(new jxl.write.Label(index++, 0, "收件人"));

                ws.addCell(new jxl.write.Label(index++, 0, "用户"));
                ws.addCell(new jxl.write.Label(index++, 0, "服务商"));

                ws.addCell(new jxl.write.Label(index++, 0, "订货单位"));
                ws.addCell(new jxl.write.Label(index++, 0, "收货单位"));

                ws.addCell(new jxl.write.Label(index++, 0, "购买数量"));
                ws.addCell(new jxl.write.Label(index++, 0, "活度"));


                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "单价"));
                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "总价"));

                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "开票价"));
                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "开票金额"));

                if (category > 1) ws.addCell(new jxl.write.Label(index++, 0, "备注"));

                //if(category>1)ws.addCell(new jxl.write.Label(index++, 0, "开票日期"));
                //if(category>1)ws.addCell(new jxl.write.Label(index++, 0, "原发票号"));

                String sql = h.get("sql");
                //导出，把取消的订单筛选掉
                List<ShopOrder> solist = ShopOrder.find(" AND so.status!=5 " + sql, 0, Integer.MAX_VALUE);
                double pricesum = 0;//订单总额
                double tsum = 0;//退款总额
                for (int e = 0; e < solist.size(); e++) {
                    ShopOrder so = solist.get(e);
                    Profile profile = Profile.find(so.getMember());
                    String uname = MT.f(profile.member);
                    ShopOrderDispatch sodh = ShopOrderDispatch.findByOrderId(so.getOrderId());
                    List<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id = " + Database.cite(so.getOrderId()), 0, Integer.MAX_VALUE);
                    ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
                    String proname = "";
                    double prices = 0;
                    int count = 0;
                    double price = 0;
                    double agent_unit = 0;
                    double agent_amount = 0;
                    if (so.isLzCategory()) {
                        for (int r = 0; r < sodlist.size(); r++) {
                            ShopOrderData sod = sodlist.get(r);
                            proname = sod.getActivity() + "";
                            prices += sod.getAmount();
                            count += sod.getQuantity();
                            price = sod.getUnit();
                            if (profile.membertype == 2) {
                                //服务商开票价
                                //ShopPriceSet sps = ShopPriceSet.find(sodh.getA_hospital_id(),sod.getProductId(),0);
                                price = sod.getAgent_price_s();        //服务商显示价
                                prices = sod.getAgent_price_s() * sod.getQuantity();    //服务商显示总价
                                agent_unit = sod.getAgent_price();        //服务商开票价
                                agent_amount = sod.getAgent_amount();    //服务商开票金额
                            } else {
                                agent_unit = price;
                                agent_amount = prices;
                            }
                            pricesum += agent_amount;
                        }
                    } else {
                        for (int r = 0; r < sodlist.size(); r++) {
                            ShopOrderData sod = sodlist.get(r);
                            prices += sod.getAmount();
                            pricesum += prices;
                            count += sod.getQuantity();
                            price = sod.getUnit();
                        }
                    }
                    double tprice = 0;//退款金额
                    int tquantity = 0;//退货数量  此处针对粒子
                    List<ShopExchanged> selist = ShopExchanged.find(" AND order_id = " + Database.cite(so.getOrderId()) + " AND type = 1 and status = 1 ", 0, Integer.MAX_VALUE);
                    for (int x = 0; x < selist.size(); x++) {
                        ShopExchanged sex = selist.get(x);
                        ShopOrderData sod = ShopOrderData.find(" AND product_id = " + sex.product_id + " AND order_id = " + Database.cite(so.getOrderId()), 0, 1).get(0);
                        tprice += (sod.getUnit() * sex.quantity);
                        tquantity = sex.quantity;
                    }
                    tsum += tprice;
                    index = 0;
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(so.getCreateDate())));
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(so.getOrderId())));
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(soe.NO1)));
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(soe.NO2)));
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(sodh.getN_consignees())));

                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? uname : ""));
                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? "" : uname));
                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? MT.f(so.getOrderUnit()) : MT.f(sodh.getA_hospital())));
                    ws.addCell(new jxl.write.Label(index++, e + 1, profile.membertype != 2 ? MT.f(sodh.getN_company()) : MT.f(sodh.getA_hospital())));

                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(count)));
                    ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(proname)));

                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(price, 2)));
                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(prices, 2)));

                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(agent_unit, 2)));
                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(agent_amount, 2)));

                    if (category > 1) ws.addCell(new jxl.write.Label(index++, e + 1, MT.f(sodh.getN_remark())));

                    //if(category>1)ws.addCell(new jxl.write.Label(index++, e+1, MT.f(sodh.getN_invoiceTime())));
                    //if(category>1)ws.addCell(new jxl.write.Label(index++, e+1,  MT.f(sodh.getN_invoiceNo())));

                }

                //if(category>1)ws.addCell(new jxl.write.Label(0, solist.size()+1,"开票金额合计："+pricesum));

                wwb.write();
                wwb.close();
                os.close();
                return;
            } catch (Exception e) {
            }
        } else if ("exp_noinvo".equals(act)) {
            //未开票订单导出
            try {

                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("未开票订单" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("未开票订单", 0);
                int index = 0;
                ws.addCell(new jxl.write.Label(index++, 0, "订单编号"));
                ws.addCell(new jxl.write.Label(index++, 0, "服务商"));
                ws.addCell(new jxl.write.Label(index++, 0, "医院"));
                ws.addCell(new jxl.write.Label(index++, 0, "订单数量"));
                ws.addCell(new jxl.write.Label(index++, 0, "订单金额"));
                ws.addCell(new jxl.write.Label(index++, 0, "下单时间"));
                ws.addCell(new jxl.write.Label(index++, 0, "开票数量"));
                ws.addCell(new jxl.write.Label(index++, 0, "开票金额"));
                ws.addCell(new jxl.write.Label(index++, 0, "是否已催缴"));

                String sql = h.get("sql");
                //导出，把取消的订单筛选掉
                List<ShopOrder> solist = ShopOrder.find(sql, 0, Integer.MAX_VALUE);
                for (int i = 0; i < solist.size(); i++) {
                    ShopOrder order = solist.get(i);
                    int p = order.getMember();
                    Profile profile = Profile.find(p);//
                    ShopOrderDispatch dispatch = ShopOrderDispatch.findByOrderId(order.getOrderId());
                    int hid = dispatch.getA_hospital_id();
                    ShopHospital hospital = ShopHospital.find(hid);//医院
                    List<ShopOrderData> lstdata = ShopOrderData.find(" and order_id=" + Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);
                    int ordernum = 0;//订单数量
                    double orderamount = 0;//订单金额
                    if (lstdata.size() > 0) {
                        ShopOrderData data = lstdata.get(0);
                        ordernum = data.getQuantity();
                        orderamount = data.getAmount();
                    }
                    //发票号
                    String invoicenos = "";
                    List<InvoiceData> lstindata = InvoiceData.find(" and orderid=" + Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);
                    for (int j = 0; j < lstindata.size(); j++) {
                        InvoiceData indata = lstindata.get(j);
                        int invoiceid = indata.getInvoiceid();
                        Invoice invoice = Invoice.find(invoiceid);
                        String no = invoice.getInvoiceno();
                        if (no != null && invoicenos != "" && invoicenos.indexOf(no) == -1) {
                            if (j == lstindata.size() - 1) {
                                invoicenos += no;
                            } else {
                                invoicenos += no + ",";
                            }
                        } else if (invoicenos == "") {
                            if (j == lstindata.size() - 1) {
                                invoicenos += no;
                            } else {
                                invoicenos += no + ",";
                            }
                        }
                    }

                    //回款id
                    String replyids = "";
                    for (int j = 0; j < lstindata.size(); j++) {
                        InvoiceData indata = lstindata.get(j);
                        int invoiceid = indata.getInvoiceid();
                        Invoice invoice = Invoice.find(invoiceid);
                        int inid = invoice.getId();
                        List<BackInvoice> lstback = BackInvoice.find(" and invoiceid like" + Database.cite("%" + inid + "%") + " and status = 1 ", 0, Integer.MAX_VALUE);
                        if (lstback.size() > 0) {
                            BackInvoice back = lstback.get(0);
                            String reply = back.getReplyid();
                            replyids += reply;
                        }


                    }
                    //回款编号
                    String replynos = "";
                    if (replyids.length() > 0) {
                        String replynoarr[] = replynos.split(",");
                        for (int j = 0; j < replynoarr.length; j++) {
                            int re = Integer.parseInt(replynoarr[j]);
                            ReplyMoney replymoney = ReplyMoney.find(re);
                            String code = replymoney.getCode();
                            if (j == replynoarr.length - 1) {
                                replynos += code;
                            } else {
                                replynos += code + ",";
                            }
                        }
                    }
                    index = 0;
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(order.getOrderId())));
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(profile.member)));
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(hospital.getName())));
                    ws.addCell(new jxl.write.Label(index++, i + 1, String.valueOf(ordernum)));
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(orderamount)));
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(order.getCreateDate(), 1)));
                    ws.addCell(new jxl.write.Label(index++, i + 1, String.valueOf(order.getIsinvoicenum())));
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(order.getIsinvoiceamount())));
                    ws.addCell(new jxl.write.Label(index++, i + 1, order.getIsurged() == 0 ? "否" : "是"));

                }
                wwb.write();
                wwb.close();
                os.close();
                return;
            } catch (Exception e) {
            }

        } else if ("exp_noreply".equals(act)) {
            //未回款订单导出
            try {

                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("未回款订单" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("未回款订单", 0);
                int index = 0;
                ws.addCell(new jxl.write.Label(index++, 0, "订单编号"));
                ws.addCell(new jxl.write.Label(index++, 0, "服务商"));
                ws.addCell(new jxl.write.Label(index++, 0, "医院"));
                ws.addCell(new jxl.write.Label(index++, 0, "订单数量"));
                ws.addCell(new jxl.write.Label(index++, 0, "订单金额"));
                ws.addCell(new jxl.write.Label(index++, 0, "下单时间"));
                ws.addCell(new jxl.write.Label(index++, 0, "开票数量"));
                ws.addCell(new jxl.write.Label(index++, 0, "开票金额"));
                ws.addCell(new jxl.write.Label(index++, 0, "是否已催缴"));

                String sql = h.get("sql");
                //导出，把取消的订单筛选掉
                List<ShopOrder> solist = ShopOrder.find(sql, 0, Integer.MAX_VALUE);
                for (int i = 0; i < solist.size(); i++) {
                    ShopOrder order = solist.get(i);
                    int p = order.getMember();
                    Profile profile = Profile.find(p);//
                    ShopOrderDispatch dispatch = ShopOrderDispatch.findByOrderId(order.getOrderId());
                    int hid = dispatch.getA_hospital_id();
                    ShopHospital hospital = ShopHospital.find(hid);//医院
                    List<ShopOrderData> lstdata = ShopOrderData.find(" and order_id=" + Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);
                    int ordernum = 0;//订单数量
                    double orderamount = 0;//订单金额
                    if (lstdata.size() > 0) {
                        ShopOrderData data = lstdata.get(0);
                        ordernum = data.getQuantity();
                        orderamount = data.getAmount();
                    }
                    //发票号
                    String invoicenos = "";
                    List<InvoiceData> lstindata = InvoiceData.find(" and orderid=" + Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);
                    for (int j = 0; j < lstindata.size(); j++) {
                        InvoiceData indata = lstindata.get(j);
                        int invoiceid = indata.getInvoiceid();
                        Invoice invoice = Invoice.find(invoiceid);
                        String no = invoice.getInvoiceno();
                        if (invoicenos != "" && invoicenos.indexOf(no) == -1) {
                            if (j == lstindata.size() - 1) {
                                invoicenos += no;
                            } else {
                                invoicenos += no + ",";
                            }
                        }
                    }

                    //回款id
                    String replyids = "";
                    for (int j = 0; j < lstindata.size(); j++) {
                        InvoiceData indata = lstindata.get(j);
                        int invoiceid = indata.getInvoiceid();
                        Invoice invoice = Invoice.find(invoiceid);
                        int inid = invoice.getId();
                        List<BackInvoice> lstback = BackInvoice.find(" and invoiceid like" + Database.cite("%" + inid + "%") + " and status = 1 ", 0, Integer.MAX_VALUE);
                        if (lstback.size() > 0) {
                            BackInvoice back = lstback.get(0);
                            String reply = back.getReplyid();
                            replyids += reply;
                        }


                    }
                    //回款编号
                    String replynos = "";
                    if (replyids.length() > 0) {
                        String replynoarr[] = replynos.split(",");
                        for (int j = 0; j < replynoarr.length; j++) {
                            int re = Integer.parseInt(replynoarr[j]);
                            ReplyMoney replymoney = ReplyMoney.find(re);
                            String code = replymoney.getCode();
                            if (j == replynoarr.length - 1) {
                                replynos += code;
                            } else {
                                replynos += code + ",";
                            }
                        }
                    }
                    index = 0;
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(order.getOrderId())));
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(profile.member)));
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(hospital.getName())));
                    ws.addCell(new jxl.write.Label(index++, i + 1, String.valueOf(ordernum)));
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(orderamount)));
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(order.getCreateDate(), 1)));
                    ws.addCell(new jxl.write.Label(index++, i + 1, String.valueOf(order.getIsinvoicenum())));
                    ws.addCell(new jxl.write.Label(index++, i + 1, MT.f(replynos)));
                    ws.addCell(new jxl.write.Label(index++, i + 1, order.getIsurgedreply() == 0 ? "否" : "是"));

                }
                wwb.write();
                wwb.close();
                os.close();
                return;
            } catch (Exception e) {
            }
        } else if ("exp_urged".equals(act)) {
            //服务商导出催缴订单
            try {

                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("催缴记录" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("催缴记录", 0);
                int index = 0;
                ws.addCell(new jxl.write.Label(index++, 0, "催缴时间"));
                ws.addCell(new jxl.write.Label(index++, 0, "订单编号"));
                ws.addCell(new jxl.write.Label(index++, 0, "医院"));
                ws.addCell(new jxl.write.Label(index++, 0, "数量"));
                ws.addCell(new jxl.write.Label(index++, 0, "下单时间"));
                ws.addCell(new jxl.write.Label(index++, 0, "状态"));


                String sql = h.get("sql");
                //导出，把取消的订单筛选掉

                List<UrgedRecord> lstrecord = UrgedRecord.find(sql.toString(), 0, Integer.MAX_VALUE);
                for (int i = 0; i < lstrecord.size(); i++) {
                    UrgedRecord record = lstrecord.get(i);
                    String orderids = record.getOrderid();
                    String[] orderidarr = orderids.split(",");

                    for (int j = 0; j < orderidarr.length; j++) {

                        String orderid = orderidarr[j];
                        ShopOrder t = ShopOrder.findByOrderId(orderid);

                        ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(t.getOrderId());

                        String querySql = " AND order_id=" + DbAdapter.cite(t.getOrderId());
                        List<ShopOrderData> sodList = ShopOrderData.find(querySql, 0, Integer.MAX_VALUE);
                        ShopOrderData odata = new ShopOrderData(0);
                        if (sodList.size() > 0) {
                            odata = sodList.get(0);
                        }
                        String uname = MT.f(Profile.find(t.getMember()).member);
                        int status = t.getStatus();
                        String statusContent = "";
                        if (status == 0)
                            statusContent = "等待付款";
                        else if (status == 1 || status == 2)
                            statusContent = "等待发货";
                        else if (status == 3)
                            statusContent = "等待收货";
                        else if (status == 4)
                            statusContent = "已完成";
                        else if (status == 5)
                            statusContent = "<a href='###' onclick=\"mt.show('" + MT.f(t.getCancelReason()) + "');\">已取消</a>";
                        index = 0;
                        ws.addCell(new jxl.write.Label(index++, j + 1, MT.f(record.getCreatedate(), 1)));
                        ws.addCell(new jxl.write.Label(index++, j + 1, MT.f(t.getOrderId())));
                        ws.addCell(new jxl.write.Label(index++, j + 1, MT.f(sod.getA_hospital())));
                        ws.addCell(new jxl.write.Label(index++, j + 1, String.valueOf(odata.getQuantity())));
                        ws.addCell(new jxl.write.Label(index++, j + 1, MT.f(t.getCreateDate(), 1)));
                        ws.addCell(new jxl.write.Label(index++, j + 1, statusContent));


                    }
                }


                wwb.write();
                wwb.close();
                os.close();
                return;
            } catch (Exception e) {
            }

        }


        PrintWriter out = response.getWriter();
        if ("checkprice".equals(act)) {
            try {
                //根据用户id查询用户地址信息
                ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member);
                int hospitalId = soa.getHospitalId();
                //获得购物车
                String cartCookie = h.getCook("cart", "|");
                String[] ps = cartCookie.split("[|]");
                if (ps.length > 0) {
                    for (int i = 1; i < ps.length; i++) {
                        String cartP = ps[i];
                        String[] arr = cartP.split("&");

                        int checkFlag = Integer.parseInt(arr[2]);
                        if (checkFlag == 0) continue;

                        //cartCookie=cartCookie.replace("|"+cartP+"|", "|");

                        //判断product_id是否商品的id，如果不是则为套装id
                        int product_id = Integer.parseInt(arr[0]);
                        //获取每个商品的代理商开票价格


                        ShopProduct p = ShopProduct.find(product_id);
                        float price = 0.0f;
                        float agent_price_s = 0.0f; //代理商显示价
                        float agent_price = 0.0f;    //代理商开票价
                        Profile pf = Profile.find(h.member);
                        if (pf.membertype == 2) {//代理商价格
                            ShopPriceSet sps1 = ShopPriceSet.find(hospitalId, p.product, 0);            //代理商显示价
                            agent_price_s = sps1.price;
                            ShopPriceSet sps = ShopPriceSet.find(hospitalId, p.product, 0);    //代理商医院开票价
                            if (sps.price > 0) {
                                price = sps.price; //医院的开票价
                            }
                            if (sps.agentPrice > 0) {
                                agent_price = sps.agentPrice; //代理商开票价
                            }
                        }
                        if (agent_price == 0) {
                            out.print(p.name[1] + " " + p.yucode);
                            return;
                        }

                    }

                }
                ShopHospital hospital = ShopHospital.find(hospitalId);
                if (hospital.getIssign() == 1) {
                    int dates = 7;
                    int invoicePuid = hospital.getInvoicePuid();
                    if (Config.getString("gaoke").equals("" + invoicePuid)) {
                        dates = 30;
                    }
                    //判断有无未签收订单
                    String sql = " and datediff(day,createdate,getdate())>" + dates + " and createdate > " + Database.cite(h.get("limitdate")) + " and status=3 and order_id in(select order_id from shoporderdispatch where a_hospital_id=" + hospitalId + ")";
                    List<ShopOrder> lstorder = ShopOrder.find(sql, 0, Integer.MAX_VALUE);

                    if (lstorder.size() > 0) {

                        out.print("对不起！" + hospital.getName() + "，该医院" + dates + "天前的订单还有未签收的，因此不能提交订单！如有疑问，请与管理员联系！");
                        return;
                    }
                }
                if (hospital.getIsstoporder() == 1) {
                    out.print("对不起！" + hospital.getName() + "，该医院已被停止订货，因此不能提交订单！如有疑问，请与管理员联系！");
                    return;
                }

                out.print("0");
                return;
            } catch (Exception e) {
                // TODO: handle exception
            }

            //h.setCook("cart",cartCookie,-1);


        } else if ("checkpricewx".equals(act)) {
            try {
                //根据用户id查询用户地址信息
                ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member);
                int hospitalId = soa.getHospitalId();

                int product_id = h.getInt("product_id", 0);

                //获取每个商品的代理商开票价格
                ShopProduct p = ShopProduct.find(product_id);
                float price = 0.0f;
                float agent_price_s = 0.0f; //代理商显示价
                float agent_price = 0.0f;    //代理商开票价
                Profile pf = Profile.find(h.member);
                if (pf.membertype == 2) {//代理商价格
                    ShopPriceSet sps1 = ShopPriceSet.find(hospitalId, p.product, 0);            //代理商显示价
                    agent_price_s = sps1.price;
                    ShopPriceSet sps = ShopPriceSet.find(hospitalId, p.product, 0);    //代理商医院开票价
                    if (sps.price > 0) {
                        price = sps.price; //医院的开票价
                    }
                    if (sps.agentPrice > 0) {
                        agent_price = sps.agentPrice; //代理商开票价
                    }
                }
                if (agent_price == 0) {
                    out.print(p.name[1] + " " + p.yucode);
                    return;
                }
                ShopHospital hospital = ShopHospital.find(hospitalId);
                if (hospital.getIssign() == 1) {
                    int dates = 7;
                    int invoicePuid = hospital.getInvoicePuid();
                    if (Config.getString("gaoke").equals("" + invoicePuid)) {
                        dates = 30;
                    }
                    //判断有无未签收订单
                    String sql = " and datediff(day,createdate,getdate())>" + dates + " and createdate > " + Database.cite(h.get("limitdate")) + " and status=3 and order_id in(select order_id from shoporderdispatch where a_hospital_id=" + hospitalId + ")";
                    List<ShopOrder> lstorder = ShopOrder.find(sql, 0, Integer.MAX_VALUE);

                    if (lstorder.size() > 0) {


                        out.print("对不起！" + hospital.getName() + "，该医院" + dates + "天前的订单还有未签收的，因此不能提交订单！如有疑问，请与管理员联系！");
                        return;
                    }
                }

                out.print("0");
                return;


            } catch (Exception e) {
                // TODO: handle exception
            }
        } else if ("checkpriceunit".equals(act)) {
            try {
                //根据用户id查询用户地址信息
                //ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member);
                int hospitalId = h.getInt("hospital_id");

                int product_id = h.getInt("product_id", 0);

                //获取每个商品的代理商开票价格
                ShopProduct p = ShopProduct.find(product_id);
                float price = 0.0f;
                float agent_price_s = 0.0f; //代理商显示价
                float agent_price = 0.0f;    //代理商开票价
                float agent_pricedls = 0.0f;    //代理商底价
                Profile pf = Profile.find(h.member);
                if (pf.membertype == 2) {//代理商价格
                    ShopPriceSet sps1 = ShopPriceSet.find(hospitalId, p.product, 0);            //代理商显示价
                    agent_price_s = sps1.price;
                    ShopPriceSet sps = ShopPriceSet.find(hospitalId, p.product, 0);    //代理商医院开票价
                    if (sps.price > 0) {
                        price = sps.price; //医院的开票价
                    }
                    if (sps.agentPrice > 0) {
                        agent_price = sps.agentPrice; //代理商开票价
                    }
                    agent_pricedls = ShopPriceSet.findpirce(p, hospitalId, h.member);
                    /*if (agent_pricedls == 0) {
                        out.print("对不起" + p.name[1] + " " + p.yucode + "，此商品管理员没有设置底价，请与管理员联系，设置底价后才可提交订单！");
                        return;
                    }*/
                    if (agent_price == 0) {
                        out.print(p.name[1] + " " + p.yucode);
                        return;
                    }
                } else {
                    ShopPriceSet sps = ShopPriceSet.find(hospitalId, p.product, 0);

                    if (sps.price == 0) {
                        out.print("对不起" + p.name[1] + " " + p.yucode + "，此商品管理员没有设置医院开票价格，请与管理员联系，设置医院开票价格后才可提交订单！");
                        return;
                    }

                    if (sps.id != 0) {
                        if (sps.agentPrice > 0) {
                            agent_price = sps.agentPrice; //代理商医院开票价
                        }
                        if (agent_price == 0) {
                            out.print(p.name[1] + " " + p.yucode);
                            return;
                        }
                    }
                }


                ShopHospital hospital = ShopHospital.find(hospitalId);
                if (hospital.getIssign() == 1) {
                    int dates = 7;
                    int invoicePuid = hospital.getInvoicePuid();
                    if (Config.getString("gaoke").equals("" + invoicePuid)) {
                        dates = 30;
                    }
                    //判断有无未签收订单
                    String sql = " and datediff(day,createdate,getdate())>" + dates + " and createdate > " + Database.cite(h.get("limitdate")) + " and status=3 and order_id in(select order_id from shoporderdispatch where a_hospital_id=" + hospitalId + ")";
                    List<ShopOrder> lstorder = ShopOrder.find(sql, 0, Integer.MAX_VALUE);

                    if (lstorder.size() > 0) {


                        out.print("对不起！" + hospital.getName() + "，该医院" + dates + "天前的订单还有未签收的，因此不能提交订单！如有疑问，请与管理员联系！");
                        return;
                    }
                }

                out.print("0");
                return;


            } catch (Exception e) {
                // TODO: handle exception
            }
        } else if ("checkorderissign".equals(act)) {
            ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member);
            int hospitalId = soa.getHospitalId();
            String sql = " and datediff(day,createdate,getdate())>7 and createdate > " + Database.cite("2017-9-1") + " and status=3 and order_id in(select order_id from shoporderdispatch where a_hospital_id=" + hospitalId + ")";
            List<ShopOrder> lstorder = ShopOrder.find(sql, 0, Integer.MAX_VALUE);
            String orderidarr = "";
            if (lstorder.size() > 0) {
                for (int i = 0; i < lstorder.size(); i++) {
                    ShopOrder order = lstorder.get(i);
                    String orderid = order.getOrderId();
                    if (i == lstorder.size() - 1) {
                        orderidarr += orderid;
                    } else {
                        orderidarr += orderid + ",";
                    }
                }
                ShopHospital hospital = ShopHospital.find(hospitalId);
                int dates = 7;
                int invoicePuid = hospital.getInvoicePuid();
                if (Config.getString("gaoke").equals("" + invoicePuid)) {
                    dates = 30;
                }
                out.print("对不起！" + hospital.getName() + "，该医院" + dates + "天前的订单还有未签收的，因此不能提交订单！未签收订单号包括：" + orderidarr + "。如有疑问，请与管理员联系！");
            } else {
                out.print("0");
            }
            return;
        } else if ("submitajax".equals(act)) {
            String mes = "";
            try {
                String orderId = h.get("orderId");
                ShopOrder so = ShopOrder.findByOrderId(orderId);
                int type = 0;
                int allocate = h.getInt("allocate");//是否调配
                Profile p1 = Profile.find(h.member);
                int issalesman = p1.issalesman;

                double perce = p1.membertype == 2 ? 0.03 : 0.01;
                double activity = h.getDouble("activity");
                int quantitynum = h.getInt("quantity");
                if (h.member < 1) {
                    type = 1;//未登录
                    jo.put("type", type);
                    out.print(jo);
                    return;
                } else if (so.getId() < 1) {//添加订单

                    String token = request.getParameter("token");
                    String stoken = (String) request.getSession().getAttribute("token");

                    //if (null != token && token.equals(stoken)) {

                    //int allocatetype = h.getInt("allocatetype");//是否同意调配


                    int junan = h.getInt("junan");
                    if (junan == 1) {
                        if (allocate == 0) {
                            Date expecteddelivery = h.getDate("expecteddelivery");
                            if (expecteddelivery == null) {
                                expecteddelivery = new Date();
                            }
                            //System.out.println("====submitajax--findStock");
                            int count = ProductStock.findStock(activity, perce, issalesman, expecteddelivery, 0);
                            if (quantitynum > count) {//库存不足
                                type = 2;//
                                jo.put("type", type);
                                out.print(jo);
                                return;
                            }
                        }
                    }

                    request.getSession().removeAttribute("token");
                    //String sT = h.getCook("saveTime", null);
                    //if(checkSave(sT)){
                    int hosid = h.getInt("hosid");
                    Filex.logs("checkpro.txt", "后端医院hosid=" + hosid + "");
                    Filex.logs("checkpro.txt", "后端用户id=" + h.member + "");
                    ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member, hosid);
                    if (soa.getId() < 1) {
                        mes = "对不起！收货人信息没有填写，不能提交订单！";
                        jo.put("type", 3);
                        jo.put("mes", mes);
                        out.print(jo);
                        return;
                    }


                    //厂商资质
                    int puid = h.getInt("puid");
                    boolean afterPu = ProcurementUnit.checkZZ(puid);
                    if (!afterPu) {
                        Filex.logs("stopSubmit.txt", "puid=" + puid + ", 厂商资质过期");
                        mes = "对不起！厂商资质过期，请联系管理员处理！";
                        jo.put("type", 3);
                        jo.put("mes", mes);
                        out.print(jo);
                        return;
                    }

                    //医院资质
                    //开票单位高科不判断资质invoicePuid
                    ShopHospital hos = ShopHospital.find(hosid);
                    int invoicePuid = hos.getInvoicePuid();
//                    if((invoicePuid+"").equals(Config.getString("gaoke"))||(invoicePuid+"").equals(Config.getString("junan"))) {
//                        Boolean checkNoSubmitOrder =  CommonUtils.checkNoSubmitOrder();
//                        if(checkNoSubmitOrder){
//                            Filex.logs("stopSubmit.txt", "puid=" + puid + ", 厂商不可提交订单");
//                            mes = "对不起！该产品厂商不可提交订单！";
//                            jo.put("type", 3);
//                            jo.put("mes", mes);
//                            out.print(jo);
//                            return;
//                        }
//                    }

                    if((invoicePuid+"").equals(Config.getString("junan"))) {
                        Boolean checkNoSubmitOrder =  CommonUtils.checkNoSubmitOrder();
                        if(checkNoSubmitOrder){
                            Filex.logs("stopSubmit.txt", "puid=" + puid + ", 厂商不可提交订单");
                            mes = "对不起！该产品厂商不可提交订单！";
                            jo.put("type", 3);
                            jo.put("mes", mes);
                            out.print(jo);
                            return;
                        }
                    }

                    if (!Config.getString("gaoke").equals("" + invoicePuid)) {
                        boolean after = ShopHospital.checkHospitalZZ(hosid);
                        if (!after) {
                            Filex.logs("stopSubmit.txt", "hosid=" + hosid + ", 医院资质过期");
                            mes = "对不起！此医院资质过期，请联系管理员处理！";
                            jo.put("type", 3);
                            jo.put("mes", mes);
                            out.print(jo);
                            return;
                        }
                    }



                    //同一家医院   下单标定日期一致   本订单之后5分钟才可以下单
                    ArrayList<ShopOrder> shopOrders = ShopOrder.find(" AND order_id in(select order_id from shopOrderDispatch where a_hospital_id=" + hosid + ") order by createdate desc ", 0, 1);
//                    if (shopOrders.size() > 0) {
//                        ShopOrder shopOrder = shopOrders.get(0);
//                        Date createDate = shopOrder.getCreateDate();
//                        Date date = new Date(System.currentTimeMillis() - 2 * 60 * 1000);
//                        if (date.before(createDate)) {
//                            mes = "对不起！此医院提交订单频繁，请2分钟后提交订单！";
//                            jo.put("type", 3);
//                            jo.put("mes", mes);
//                            out.print(jo);
//                            return;
//                        }
//                    }

                    ActivityWarning activityWarning = ActivityWarning.find(hosid);

                    Double now_mci = activity * quantitynum; //当前订单  mci数
                    Double old_mci = 0.0D; //今年的订单 mci数
                    Double yujing_mci = 0.0D;//预警值  mci数
                    Double jingjie_mci;//警戒值  mci数
                    Double stop_mci;//停止值  mci数
                    Double sum_mci = 0.0D;
                    ArrayList<ShopOrderData> shopOrderDataList = new ArrayList<>();


                    float bqmci = hos.getBqmci();
                    String bq1 = hos.getBq1();
                    //停止订货值  有的话  今年+本单超过这个值  不可下单
                    //7.13 吕志超要求调整为    BQ数量除以370000000得到的Mci值为医院总量    减去历史订单得到的剩余值 和 停货值（Mci）对比
                    if (activityWarning.getStop() != null && bq1 != null && bqmci > 0) {
                        String stop = activityWarning.getStop();
                        stop_mci = Double.valueOf(stop);
                        if (shopOrderDataList.size() == 0) {
                            shopOrderDataList = ShopOrderData.find2(" ,ShopOrderDispatch sod,ShopOrder so where sod.order_id = so.order_id AND sod.order_id=da.order_id     AND so.createdate>dateadd(year, datediff(year, 0, getdate()), 0)  AND sod.a_hospital_id=" + hosid, 0, Integer.MAX_VALUE);
                            for (int i = 0; i < shopOrderDataList.size(); i++) {
                                ShopOrderData shopOrderData = shopOrderDataList.get(i);
                                Double activity1 = shopOrderData.getActivity() * shopOrderData.getQuantity();
                                old_mci = old_mci + activity1;
                            }
                        }
                        sum_mci = old_mci + now_mci;

                        //BQMCI - 当前下单总量 小于等于停货值
                        if (bqmci - sum_mci <= stop_mci) {
                            Filex.logs("stopSubmit.txt", hos.getName() + " :  BqMci=" + bqmci + ", old_mci=" + old_mci + ", now_mci=" + now_mci + ", stop_mci=" + stop_mci);
                            mes = "对不起！此医院达到停货值不可下单 ";
                            jo.put("type", 3);
                            jo.put("mes", mes);
                            out.print(jo);
                            return;
                        }

                    }

                    //先看手否可以下单，可以下单在判断是否预警
                    if (activityWarning.getYjyydh() != null) {
                        if (activityWarning.getYjyydh().length() == 11) {
                            //医院有预警电话

                            Boolean isSelect = false;
                            if (activityWarning.getWarning() != null) {//有预警值
                                String warning = activityWarning.getWarning().replaceAll(",", "");
                                yujing_mci = Double.valueOf(warning);
                                isSelect = true;
                                shopOrderDataList = ShopOrderData.find2(" ,ShopOrderDispatch sod,ShopOrder so where sod.order_id = so.order_id AND sod.order_id=da.order_id     AND so.createdate>dateadd(year, datediff(year, 0, getdate()), 0)  AND sod.a_hospital_id=" + hosid, 0, Integer.MAX_VALUE);
                                for (int i = 0; i < shopOrderDataList.size(); i++) {
                                    ShopOrderData shopOrderData = shopOrderDataList.get(i);
                                    Double activity1 = shopOrderData.getActivity() * shopOrderData.getQuantity();
                                    old_mci = old_mci + activity1;
                                }
                                if (old_mci < yujing_mci && sum_mci > yujing_mci) {//下单前 小于预警  加上本次mci大于预警  发短信
                                    try {
                                        SMSMessage.sendExpireMessage("Home", "amdin", activityWarning.getYjyydh(), 1, hos.getName() + " 超过预警值 ", 1);
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }

                            if (activityWarning.getWarning2() != null) {
                                String warning = activityWarning.getWarning2().replaceAll(",", "");
                                jingjie_mci = Double.valueOf(warning);
                                if (!isSelect) {//预警值没走过
                                    shopOrderDataList = ShopOrderData.find2(" ,ShopOrderDispatch sod,ShopOrder so where sod.order_id = so.order_id AND sod.order_id=da.order_id     AND so.createdate>dateadd(year, datediff(year, 0, getdate()), 0)  AND sod.a_hospital_id=" + hosid, 0, Integer.MAX_VALUE);
                                    for (int i = 0; i < shopOrderDataList.size(); i++) {
                                        ShopOrderData shopOrderData = shopOrderDataList.get(i);
                                        Double activity1 = shopOrderData.getActivity() * shopOrderData.getQuantity();
                                        old_mci = old_mci + activity1;
                                    }
                                    sum_mci = old_mci + now_mci;
                                }

                                if (old_mci < jingjie_mci && sum_mci > jingjie_mci) {//下单前 小于警戒  加上本次mci大于警戒  发短信
                                    try {
                                        SMSMessage.sendExpireMessage("Home", "amdin", activityWarning.getYjyydh(), 1, hos.getName() + " 超过警戒值 ", 1);
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }


                            }


                        }
                    }

                    setOrders(so, h);

                    long currentTime = System.currentTimeMillis();
                    h.setCook("saveTime", String.valueOf(currentTime), -1);

                    Profile profile = Profile.find(so.getMember());
                    //订单附加表
                    ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
                    String quantity = h.get("quantity"); //商品数量

                    //获取短信内容
                    String content = utils.getSms_content("tjdd");

                    if (Config.getInt("gaoke") == so.getPuid()) {
                        content = utils.getSms_content("tjddgaoke");
                        String querySql = " AND order_id=" + DbAdapter.cite(so.getOrderId());
                        List<ShopOrderData> sodList = ShopOrderData.find(querySql, 0, Integer.MAX_VALUE);
                        ShopOrderData odata = null;
                        if (sodList.size() > 0) {
                            odata = sodList.get(0);
                        }
                        content = content.replace("activity", odata.getActivity() + "");
                    }

                    content = utils.replace(content, profile.getMember(), so.getOrderId(), "", "", sod.getA_hospital(), sod.getA_consignees(), quantity);

                    String user = Profile.find(h.member).getMember();

                    ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid=" + so.getPuid(), 0, 1);
                    if (list.size() > 0) {
                        ShopSMSSetting sms = list.get(0);
                        List<String> mobiles = ShopSMSSetting.getUserMobile(sms.tjdd);
                        if (!"".equals(MT.f(mobiles.toString())))
                            SMSMessage.create("Home", user, mobiles.toString(), h.language, content);
                    }
                    //客户
                    if (!"".equals(MT.f(profile.mobile, ""))) {
                        SMSMessage.create("Home", user, profile.mobile, h.language, content);
                    }

//	        		}else{
//
//	        		}
                    if (junan == 1) {//不直接减库存了
                        //StockOperation.set(activity, quantitynum,perce, issalesman, h.member,so.getId(),new Date());
                        StockOperation.setOrder(activity, quantitynum, perce, issalesman, h.member, so.getId(), new Date());

                    }

                    jo.put("orderId", MT.enc(so.getOrderId()));
                    jo.put("type", type);
                   /* } else {
                        Filex.logs("subOrder.txt", "提交失败，传入Token：" + token + ",SessionToken:" + stoken);
                        jo.put("type", 4);
                        mes = "重复提交，请刷新重试！";
                        jo.put("mes", mes);
                        out.print(jo);
                        return;
                    }*/

                }
            } catch (Throwable e) {
                Filex.logs("ordererr.txt", MT.f(new Date(), 2) + e.toString());
                mes = "系统异常，请刷新重试！";
                jo.put("type", 3);
                jo.put("mes", mes);
            }

            //out.print("<script>top.location.replace('"+nexturl+"?orderId="+MT.enc(so.getOrderId())+"');</script>");
            out.print(jo);
            return;

        } else if ("submitEquipmentajax".equals(act)) {
            String mes = "";
            try {
                String orderId = h.get("orderId");
                ShopOrder so = ShopOrder.findByOrderId(orderId);
                int type = 0;
                Profile p1 = Profile.find(h.member);

                if (so.getId() < 1) {//添加订单

                    String token = request.getParameter("token");
                    String stoken = (String) request.getSession().getAttribute("token");

                    request.getSession().removeAttribute("token");

                    setOrdersEquipment(so, h);//器械与设备订单
                    ModifyRecord.creatModifyRecord(so.getOrderId(), "下单", h.member, "用户下单");

                    long currentTime = System.currentTimeMillis();
                    h.setCook("saveTime", String.valueOf(currentTime), -1);

                    Profile profile = Profile.find(so.getMember());
                    //订单附加表
                    ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
                    String quantity = h.get("quantity"); //商品数量

                    //获取短信内容
                    String content = utils.getSms_content("tjdd");

                    if (Config.getInt("gaoke") == so.getPuid()) {
                        content = utils.getSms_content("tjddgaoke");
                        String querySql = " AND order_id=" + DbAdapter.cite(so.getOrderId());
                        List<ShopOrderData> sodList = ShopOrderData.find(querySql, 0, Integer.MAX_VALUE);
                        ShopOrderData odata = null;
                        if (sodList.size() > 0) {
                            odata = sodList.get(0);
                        }
                        content = content.replace("activity", odata.getActivity() + "");
                    }

                    content = utils.replace(content, profile.getMember(), so.getOrderId(), "", "", sod.getA_hospital(), sod.getA_consignees(), quantity);

                    String user = Profile.find(h.member).getMember();

                    ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid=" + so.getPuid(), 0, 1);
                    if (list.size() > 0) {
                        ShopSMSSetting sms = list.get(0);
                        List<String> mobiles = ShopSMSSetting.getUserMobile(sms.tjdd);
                        if (!"".equals(MT.f(mobiles.toString())))
                            SMSMessage.create("Home", user, mobiles.toString(), h.language, content);
                    }
                    //客户goPayment
                    if (!"".equals(MT.f(profile.mobile, ""))) {
                        SMSMessage.create("Home", user, profile.mobile, h.language, content);
                    }

                    jo.put("orderId", MT.enc(so.getOrderId()));
                    jo.put("type", type);

                }
            } catch (Throwable e) {
                Filex.logs("ordererr.txt", MT.f(new Date(), 2) + e.toString());
                mes = "系统异常，请刷新重试！";
                jo.put("type", 3);
                jo.put("mes", mes);
            }

            //out.print("<script>top.location.replace('"+nexturl+"?orderId="+MT.enc(so.getOrderId())+"');</script>");
            out.print(jo);
            return;

        } else if ("submitajaxtps".equals(act)) {
            String mes = "";
            try {
                String orderId = h.get("orderId");
                ShopOrder so = ShopOrder.findByOrderId(orderId);
                int type = 0;
                int allocate = h.getInt("allocate");//是否调配
                Profile p1 = Profile.find(h.member);
                int issalesman = p1.issalesman;

                double perce = p1.membertype == 2 ? 0.03 : 0.01;
                double activity = h.getDouble("activity");
                int quantitynum = h.getInt("quantity");
                if (h.member < 1) {
                    type = 1;//未登录
                    jo.put("type", type);
                    out.print(jo);
                    return;
                } else if (so.getId() < 1) {//添加订单

                    String token = request.getParameter("token");
                    String stoken = (String) request.getSession().getAttribute("token");

                    if (null != token && token.equals(stoken)) {

                        request.getSession().removeAttribute("token");
                        //String sT = h.getCook("saveTime", null);
                        //if(checkSave(sT)){
                        setOrderstps(so, h);

                        long currentTime = System.currentTimeMillis();
                        h.setCook("saveTime", String.valueOf(currentTime), -1);

                        Profile profile = Profile.find(so.getMember());
                        //订单附加表
                        ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
                        String quantity = h.get("quantity"); //商品数量

                        //获取短信内容
                        String content = utils.getSms_content("tjdd");

                        //content = utils.replace(content, profile.getMember(), so.getOrderId(), "", "",sod.getA_hospital(),sod.getA_consignees(),quantity);

						/*String user = Profile.find(h.member).getMember();

						ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
						if(list.size() > 0){
							ShopSMSSetting sms = list.get(0);
							List<String> mobiles = ShopSMSSetting.getUserMobile(sms.tjdd);
							if(!"".equals(MT.f(mobiles.toString())))
								SMSMessage.create("Home", user, mobiles.toString(), h.language, content);
						}
						//客户
						if(!"".equals(MT.f(profile.mobile,""))){
							SMSMessage.create("Home", user, profile.mobile, h.language, content);
						}*/

//	        		}else{
//
//	        		}

                        jo.put("orderId", MT.enc(so.getOrderId()));
                        jo.put("type", type);
                    } else {
                        Filex.logs("subOrder.txt", "重复提交:" + so.getOrderId() + "\r\n");
                        jo.put("type", 3);
                        mes = "重复提交，请刷新重试！";
                        jo.put("mes", mes);
                        out.print(jo);
                        return;
                    }

                }
            } catch (Throwable e) {
                System.out.println(e.toString());
                Filex.logs("ordererr.txt", MT.f(new Date(), 2) + e.toString());
                mes = "系统异常，请刷新重试！";
                jo.put("type", 3);
                jo.put("mes", mes);
            }

            //out.print("<script>top.location.replace('"+nexturl+"?orderId="+MT.enc(so.getOrderId())+"');</script>");
            out.print(jo);
            return;

        } else if ("editallocate".equals(act)) {
            String mes = "";
            try {
                String orderId = h.get("orderId");
                ShopOrder so = ShopOrder.findByOrderId(orderId);
                int type = 0;
                Profile p1 = Profile.find(so.getMember());
                int issalesman = p1.issalesman;

                double perce = p1.membertype == 2 ? 0.03 : 0.01;
                double activity = h.getDouble("activity");
                int quantitynum = h.getInt("quantity");
                Date expecteddelivery = h.getDate("expecteddelivery");

                int count = ProductStock.findStock(activity, perce, issalesman, expecteddelivery, 1);
                if (quantitynum > count) {//库存不足
                    type = 2;//
                    jo.put("type", type);
                    out.print(jo);
                    return;
                }
                String[] dataid = h.getValues("dataid");
                for (int i = 0; i < dataid.length; i++) {
                    ShopOrderData sod = ShopOrderData.find(Integer.parseInt(dataid[i]));
                    sod.setExpectedDelivery(expecteddelivery);
                    sod.setExpectedActivity(activity);
                    sod.set();
                }

    			/*int status = StockOperation.set(activity, quantitynum,perce, issalesman,h.member,so.getId(),expecteddelivery);
    			if(status==1){
					jo.put("type", "2");
				}else{
					jo.put("type", type);
				}*/
            } catch (Exception e) {
                e.printStackTrace();
                mes = "系统异常，请刷新重试！";
                jo.put("type", 3);
                jo.put("mes", mes);
            }

            //out.print("<script>top.location.replace('"+nexturl+"?orderId="+MT.enc(so.getOrderId())+"');</script>");
            out.print(jo);
            return;

        } else if ("reallocate".equals(act)) {
            String mes = "";
            String orderId = h.get("orderId");
            ShopOrder so = ShopOrder.findByOrderId(orderId);
            int type = 0;
            try {
                String[] dataid = h.getValues("dataid");
                for (int i = 0; i < dataid.length; i++) {
                    ShopOrderData sod = ShopOrderData.find(Integer.parseInt(dataid[i]));
                    sod.setExpectedDelivery(null);
                    sod.setExpectedActivity(0.0);
                    sod.set();
                }
                StockOperation.setStill(so.getId());
                //StockOperation.set(activity, quantitynum,perce, issalesman,h.member,so.getId(),expecteddelivery);
                jo.put("type", type);
            } catch (Exception e) {
                e.printStackTrace();
                mes = "系统异常，请刷新重试！";
                jo.put("type", 3);
                jo.put("mes", mes);
            }

            //out.print("<script>top.location.replace('"+nexturl+"?orderId="+MT.enc(so.getOrderId())+"');</script>");
            out.print(jo);
            return;

        } else
            try {
                out.println("<script>var mt=parent.mt;</script>");
                String orderId = h.get("orderId");
                ShopOrder so = ShopOrder.findByOrderId(orderId);
                if ("submit".equals(act)) {
                    if (h.member < 1) {
                        out.print("<script>mt.show(\"&nbsp;&nbsp;&nbsp;&nbsp;对不起！您还未登录，登陆后才可提交订单！<br/>"
                                + "已是网站会员，点击 <a href=javascript:parent.location='/" + (h.status == 1 ? "x" : "") + "html/folder/14102033-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>登录</a>"
                                + "&nbsp;&nbsp;还不是网站会员，点击 <a href=javascript:parent.location='/html/folder/14102034-1.htm' target='_blank' style='font-weight:bold;font-size:14px;color:#0079D2'>注册</a>\")</script>");
                        return;
                    } else if (so.getId() < 1) {//添加订单
                        String token = request.getParameter("token");
                        String stoken = (String) request.getSession().getAttribute("token");
                        if (null != token && token.equals(stoken)) {
                            request.getSession().removeAttribute("token");
                            //String sT = h.getCook("saveTime", null);
                            //if(checkSave(sT)){
                            setOrders(so, h);

                            long currentTime = System.currentTimeMillis();
                            h.setCook("saveTime", String.valueOf(currentTime), -1);

                            Profile profile = Profile.find(so.getMember());
                            //订单附加表
                            ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
                            String quantity = h.get("quantity"); //商品数量

                            //获取短信内容
                            String content = utils.getSms_content("tjdd");

                            if (Config.getInt("gaoke") == so.getPuid()) {
                                content = utils.getSms_content("tjddgaoke");
                                String querySql = " AND order_id=" + DbAdapter.cite(so.getOrderId());
                                List<ShopOrderData> sodList = ShopOrderData.find(querySql, 0, Integer.MAX_VALUE);
                                ShopOrderData odata = null;
                                if (sodList.size() > 0) {
                                    odata = sodList.get(0);
                                }
                                content = content.replace("activity", odata.getActivity() + "");
                            }

                            content = utils.replace(content, profile.getMember(), so.getOrderId(), "", "", sod.getA_hospital(), sod.getA_consignees(), quantity);

                            String user = Profile.find(h.member).getMember();

                            ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid=" + so.getPuid(), 0, 1);
                            if (list.size() > 0) {
                                ShopSMSSetting sms = list.get(0);
                                List<String> mobiles = ShopSMSSetting.getUserMobile(sms.tjdd);
                                if (!"".equals(MT.f(mobiles.toString())))
                                    SMSMessage.create("Home", user, mobiles.toString(), h.language, content);
                            }
                            //客户
                            if (!"".equals(MT.f(profile.mobile, ""))) {
                                SMSMessage.create("Home", user, profile.mobile, h.language, content);
                            }

//		        		}else{
//
//		        		}
                        } else {
                            Filex.logs("subOrder.txt", "重复提交:" + so.getOrderId() + "\r\n");
                        }
                    }

                    out.print("<script>top.location.replace('" + nexturl + "?orderId=" + MT.enc(so.getOrderId()) + "');</script>");
                    return;
                } else if ("status".equals(act)) {
                    int status = h.getInt("status");
                    if (status == 4)//确认收货时，记录收货时间
                    {
                        so.setReceiptTime(new Date());
                        ShopMyPoints.setPoints(so.getOrderId(), h.member);//积分
                    } else if (status == 5) {
                        //取消订单，记录取消原因
                        so.setCancelReason(h.get("cancelReason"));
                        so.setCanceltime(new Date());
                        so.setCancelmember(h.member);
                        StockOperation.setStill(so.getId());//清楚占用库存

                        List<ShopOrderDatasBatches> sblist = ShopOrderDatasBatches.find(" AND ordercode=" + DbAdapter.cite(orderId), 0, Integer.MAX_VALUE);
                        for (int i = 0; i < sblist.size(); i++) {
                            ShopOrderDatasBatches sod = sblist.get(i);
                            StockOperation.setStillBat(sod.getSoid());//清楚占用库存
                        }

                    }
                    so.setStatus(status);
                    so.set();
                    /*if(status!=3) {//完成出库  节点推送CRM  推送成功出库成功
                        so.setStatus(status);
                        so.set();
                    }*/
                    if (status == 4) {
                        ModifyRecord.creatModifyRecord(so.getOrderId(), "收货", h.member, "订单确认收货");
                    } else if (status == 5) {
                        ModifyRecord.creatModifyRecord(so.getOrderId(), "取消", h.member, "取消订单操作");
                    }
                    if (status == 2) {
                        //客服确认的时候给高科平台发送数据，发送成功 在往下走，发送失败的话提示 请联系管理员，不往下走
                        String sendOrderData = sendGaoKeData(so);
                        System.out.println("给高科平台发送数据:"+sendOrderData);

                        //订单附加表
                        ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
                        //
                        String querySql = " AND order_id=" + DbAdapter.cite(orderId);
                        List<ShopOrderData> sodList = ShopOrderData.find(querySql, 0, Integer.MAX_VALUE);
                        ShopOrderData odata = ShopOrderData.find(0);
                        //获取短信内容
                        String content = utils.getSms_content("qrfh");
                        content = utils.replace(content, "", so.getOrderId(), "", "", sod.getA_hospital(), sod.getA_consignees(), odata.getQuantity() + "");


                        ProcurementUnit pu1 = ProcurementUnit.find(so.getPuid());
                        String invoice = pu1.getName();
                        content = content.replaceAll("invoice", invoice);

                        String user = Profile.find(h.member).getMember();

                        //确认发货
                        if (so.isLzCategory()) {
                            int mypuid = so.getPuid();//默认开票单位
                            //查看开票单位 不是同辐
                            if (Config.getInt("tongfu") == mypuid) {
                                mypuid = ShopOrderData.findPuid(so.getOrderId());
                            }

                            ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid=" + mypuid, 0, 1);
                            if (list.size() > 0) {
                                ShopSMSSetting sms = list.get(0);
                                List<String> mobiles = ShopSMSSetting.getUserMobile(sms.qrfh);
                                if (!"".equals(MT.f(mobiles.toString())))
                                    SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
                            }


                        }

                        Profile pro = Profile.find(so.getMember());
                        if (!"".equals(MT.f(pro.mobile, "")))
                            SMSMessage.create(h.community, user, pro.mobile, h.language, content);
                        ModifyRecord.creatModifyRecord(so.getOrderId(), "订单已确认", h.member, "订单确认");

                    } else if (status == 3) {
                        //点击确认发货创建订单CRM
                        int send = 1;
                        //int send = CreatOrderSendCrm.send(so.getOrderId());
                        if (send != 1) {
                            //删除保存订单
                            out.print("<script>mt.show('CRM推送失败，出库失败！',1,'" + nexturl + "');</script>");
                            return;
                        } else {
                            so.setStatus(status);
                            so.set();
                            //出厂信息
                            ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
                            //订单附加
                            ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
                            String querySql = " AND order_id=" + DbAdapter.cite(orderId);
                            List<ShopOrderData> sodList = ShopOrderData.find(querySql, 0, Integer.MAX_VALUE);
                            ShopOrderData odata = sodList.size() > 0 ? sodList.get(0) : ShopOrderData.find(0);
                            //获取短信内容
                            String content = utils.getSms_content("ckwc");

                            if (Config.getInt("gaoke") == so.getPuid()) {
                                content = utils.getSms_content("ckwcgaoke");
                                content = content.replace("activity", odata.getActivity() + "");
                            }

                            content = utils.replace(content, "", so.getOrderId(), soe.express_code, "", sod.getA_hospital(), sod.getA_consignees(), odata.getQuantity() + "");
                            String user = Profile.find(h.member).getMember();
                            //出库


                            ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid=" + so.getPuid(), 0, 1);
                            if (list.size() > 0) {
                                ShopSMSSetting sms = list.get(0);
                                List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckwc);
                                if (!"".equals(MT.f(mobiles.toString())))
                                    SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
                            }

                            //查看开票单位 是同辐
                            int mypuid = ShopOrderData.findPuid(so.getOrderId());
                            if (Config.getInt("tongfu") == so.getPuid()) {
                                list = ShopSMSSetting.find(" and puid=" + mypuid, 0, 1);
                                if (list.size() > 0) {
                                    ShopSMSSetting sms = list.get(0);
                                    List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckwc);
                                    if (!"".equals(MT.f(mobiles.toString())))
                                        SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
                                }
                            }


                            Profile pro = Profile.find(so.getMember());
                            if (!"".equals(MT.f(pro.mobile, "")))
                                SMSMessage.create(h.community, user, pro.mobile, h.language, content);

                            //给收货人发送短信
                            SMSMessage.create(h.community, user, sod.getA_mobile(), h.language, content);
                            ModifyRecord.creatModifyRecord(sod.getOrder_id(), "订单出库", h.member, "订单出库");
                        }
                    }

                } else if ("refundSendCrm".equals(act)) {//退货推送CRM
                   /*int send = CreatOrderSendCrm.send(so.getOrderId());
                    if(send!=1){
                        //删除保存订单
                        out.print("<script>mt.show('CRM推送失败！',1,'" + nexturl + "');</script>");
                        return;
                    }*/
                } else if ("payment".equals(act)) {//后台确认收款
                    so.set("isPayment", "1");
                } else if ("orderPayment".equals(act)) {//前台完成支付
                    //so.set("status", "1");
                    //so.set("isPayment", "1");
                    so.setStatus(1);
                    so.setPayment(true);
                    so.setPayTime(new Date());
                    so.set();
                    ShopMyPoints.setPoints(so.getOrderId(), so.getMember());
                } else if ("orderPaymentTps".equals(act)) {//前台完成支付
                    //so.set("status", "1");
                    //so.set("isPayment", "1");
                    //so.setStatus(1);
                    so.setStatus(4);
                    so.setPayment(true);
                    so.setPayTime(new Date());
                    so.setPayType(1);
                    so.set();
                    ShopMyPoints.setPoints(so.getOrderId(), so.getMember());

                    if (so.getOrderType() == 1) {//tps
                        int jhpstastus = 0;
                        int flag0 = 0;
                        int flag1 = 1;
                        List<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id=" + DbAdapter.cite(orderId), 0, Integer.MAX_VALUE);
                        for (int i = 0; i < sodlist.size(); i++) {
                            ShopOrderData sod = sodlist.get(i);
                            ShopOrder so1 = ShopOrder.findByOrderId(sod.getOrderId());
                            ShopProduct sp1 = ShopProduct.find(sod.getProductId());
                            int flag = JihuoUse.useCode(sod.getProductId(), so1.getOrderId(), so1.getMember(), sp1.model_id);
                            if (flag == 0) {//发送失败
                                sod.setGetJihuo(2);//该商品获取激活码失败
                                flag0++;
                                sod.set();
                            } else {
                                flag1++;
                                sod.setGetJihuo(1);//该商品获取激活码成功
                                sod.set();
                            }
                        }
                        if (flag0 > 0) {
                            so.setJhpstastus(1);//部分成功
                            so.set();
                            out.print("<script>mt.show('激活码不足请补发激活码！',1,'" + nexturl + "');</script>");
                            return;
                        } else {
                            if (flag1 > 0) {
                                so.setJhpstastus(2);//全部成功未失败
                                so.set();
                            }
                        }

                    }

                } else if ("del".equals(act)) {
                    //so.set("status","5");

                    List<ShopOrderDatasBatches> sblist = ShopOrderDatasBatches.find(" AND ordercode=" + DbAdapter.cite(orderId), 0, Integer.MAX_VALUE);
                    for (int i = 0; i < sblist.size(); i++) {
                        ShopOrderDatasBatches sod = sblist.get(i);
                        StockOperation.setStillBat(sod.getSoid());//清楚占用库存
                    }


                    List<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id=" + DbAdapter.cite(orderId), 0, Integer.MAX_VALUE);
                    for (int i = 0; i < sodlist.size(); i++) {
                        ShopOrderData sod = sodlist.get(i);
                        ShopOrder so1 = ShopOrder.findByOrderId(sod.getOrderId());
                        StockOperation.setStill(so1.getId());//清楚占用库存
                        sod.delete();
                    }


                    so.delete();
                } else if ("updateremarks".equals(act)) {
                    String remarks = h.get("remarks");
                    so.set("remarks", remarks);
                } else if ("lzsign".equals(act)) {        //粒子扫码签收
                    String sn = "http://" + request.getServerName();
                    //判断签收人
                    String orderid = h.get("orderid");    //订单ID
                    //根据openid 查找其所在的医院 -粒子签收
                    String openid = h.getCook("openid", "");
//	        	Filex.logs("gdh_sing.txt", "openid="+openid);
                    //微信发送消息
                    WxUser wu = WxUser.find(openid);
                    int hospital = Profile.getHospitalByOpenId(openid, 0);
                    if (hospital > 0) {
                        //查找订单所属医院
                        ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderid);
                        //判断签收人和订单所属的医院是否相同
                        if (hospital == sod.getA_hospital_id()) {
                            //签收成功
                            ShopOrder soObj = ShopOrder.findByOrderId(orderid);
                            if (soObj.getStatus() == 3) {
                                soObj.setStatus(4);    //已完成（已签收）
                                soObj.setReceiptTime(new Date());    //签收时间
                                soObj.setSign_user_openid(openid);    //签收人openid
                                soObj.set();
                                wu.send("text", "<a href='" + sn + "/jsp/yl/shop/ShopOrderDatasInfo.jsp?orderId=" + orderid + "'>签收成功，点击查看详情！</a>");
                            } else {
                                wu.send("text", "该订单已签收过，谢谢！");
                            }
                        } else {
                            wu.send("text", "签收人不匹配,请与管理员联系-010-68533123！");    //签收人不匹配
                        }
                    } else {
                        wu.send("text", "您尚未成为签收人，请与管理员联系-010-68533123！");
                    }
                    //关闭 浏览器窗口
                    out.print("<script>document.addEventListener('WeixinJSBridgeReady',function(){WeixinJSBridge.call('closeWindow')});</script>");
                    return;

                } else if ("fpsign".equals(act)) {        //发票扫码签收
                    String sn = "http://" + request.getServerName();
                    //判断签收人
                    String orderid = h.get("orderid");    //订单ID
                    //根据openid 查找其所在的医院 -发票签收
                    String openid = h.getCook("openid", "");
//	        	Filex.logs("gdh_sing.txt", "openid="+openid);
                    //微信发送消息
                    WxUser wu = WxUser.find(openid);
                    int hospital = Profile.getHospitalByOpenId(openid, 1);
                    if (hospital > 0) {
                        //查找订单所属医院
                        ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderid);
                        //判断签收人和订单所属的医院是否相同
                        if (hospital == sod.getA_hospital_id()) {
                            //签收成功
                            if (MT.f(sod.getSign_user_openid()).length() > 0) {
                                wu.send("text", "该发票单已签收过，谢谢！");
                            } else {
                                sod.setStatus(1);
                                sod.setSign_user_openid(openid);    //签收人
                                sod.setSing_date(new Date());        //签收时间
                                sod.set();
                                //根据订单id查询订单详情信息
                                StringBuffer sql = new StringBuffer();
                                sql.append(" AND order_id=" + DbAdapter.cite(orderId));
                                List<ShopOrderData> sodList = ShopOrderData.find(sql.toString(), 0, Integer.MAX_VALUE);
                                ShopOrderData orderData = sodList.get(0);
                                wu.send("text", "订单号：" + orderid + "\n发票号：" + sod.getN_invoiceNo() + "\n金额：" + orderData.getAmount());
                                //wu.send("text","<a href='"+sn+"/jsp/yl/shop/ShopOrderDatasInfo.jsp?orderId="+orderid+"'>签收成功，点击查看详情！</a>");
                            }
                        } else {
                            wu.send("text", "发票签收人不匹配,请与管理员联系-010-68533123！");    //签收人不匹配
                        }
                    } else {
                        wu.send("text", "您尚未成为签收人，请与管理员联系-010-68533123！");
                    }
                    //关闭 浏览器窗口
                    out.print("<script>document.addEventListener('WeixinJSBridgeReady',function(){WeixinJSBridge.call('closeWindow')});</script>");
                    return;

                } else if ("invoice_edit".equals(act)) {//补开发票
                    String orderid = h.get("id");
                    String invoiceName = h.get("invoiceName");
                    String invoiceDutyParagraph = h.get("invoiceDutyParagraph");
                    String invoiceProvinces = h.get("invoiceProvinces");
                    String invoiceOpeningBank = h.get("invoiceOpeningBank");
                    String invoiceAddress = h.get("invoiceAddress");
                    String invoiceCostName = h.get("invoiceCostName");
                    String invoiceMobile = h.get("invoiceMobile");
                    String invoiceAccountNumber = h.get("invoiceAccountNumber");
                    ShopOrder shopOrder = ShopOrder.findByOrderId(orderid);
                    if (shopOrder.getOrderType() == 1) {
                        if (1 == h.getInt("ismobile")) {
                            nexturl = "/mobjsp/yl/shopweb/TPSOrders.jsp?orderType=1";
                        } else {
                            nexturl = "/jsp/yl/shopweb/TPSOrders.jsp?orderType=1";
                        }

                    } else if (shopOrder.getOrderType() == 2) {
                        if (1 == h.getInt("ismobile")) {
                            nexturl = "/mobjsp/yl/shopweb/TPSOrders.jsp?orderType=2";
                        } else {
                            nexturl = "/jsp/yl/shopweb/TPSOrders.jsp?orderType=2";
                        }
                    }
                    shopOrder.setIsbkinvoice(1);
                    shopOrder.setInvoiceName(invoiceName);
                    shopOrder.setInvoiceDutyParagraph(invoiceDutyParagraph);
                    shopOrder.setInvoiceProvinces(invoiceProvinces);
                    shopOrder.setInvoiceOpeningBank(invoiceOpeningBank);
                    shopOrder.setInvoiceAddress(invoiceAddress);
                    shopOrder.setInvoiceCostName(invoiceCostName);
                    shopOrder.setInvoiceMobile(invoiceMobile);
                    shopOrder.setInvoiceAccountNumber(invoiceAccountNumber);
                    shopOrder.setInvoice(1);
                    shopOrder.setIsinvoice(1);
                    shopOrder.set();


                } else if ("start_invoice".equals(act)) {
                    String order_id = h.get("orderId");
                    List<ShopOrder> list = ShopOrder.find("AND order_id = " + DbAdapter.cite(order_id), 0, 1);
                    ShopOrder sh = list.get(0);
                    sh.setInvoiceStatus(1);
                    sh.set();
                } else if ("sendCode".equals(act)) {//补发激活码
                    int flag0 = 0;
                    int flag1 = 1;
                    List<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id=" + DbAdapter.cite(orderId) + "AND getJihuo=2", 0, Integer.MAX_VALUE);//没有激活码的订单详情
                    for (int i = 0; i < sodlist.size(); i++) {
                        ShopOrderData sod = sodlist.get(i);
                        ShopOrder so1 = ShopOrder.findByOrderId(sod.getOrderId());
                        ShopProduct sp1 = ShopProduct.find(sod.getProductId());
                        int flag = JihuoUse.useCode(sod.getProductId(), so1.getOrderId(), so1.getMember(), sp1.model_id);
                        if (flag == 0) {//发送失败
                            sod.setGetJihuo(2);//该商品获取激活码失败
                            sod.set();
                            flag0++;
                        } else {
                            flag1++;
                            sod.setGetJihuo(1);//该商品获取激活码成功
                            sod.set();
                        }
                    }
                    if (flag0 > 0) {
                        so.setJhpstastus(1);//部分成功
                    } else {
                        if (flag1 > 0) {
                            so.setJhpstastus(2);//全部成功未失败
                        }
                    }
                    so.set();
                    if (flag0 > 0) {
                        out.print("<script>mt.show('操作失败,激活码不足请补充！',1,'" + nexturl + "');</script>");
                        return;
                    }


                } else if ("isbatche".equals(act)) {//取消分批

                    List<ShopBatchesData> sbdlist = ShopBatchesData.find(" AND sbd.orderId = " + Database.cite(so.getOrderId()) + " AND (number-occupyNumber)<> 0 AND ps.psid <> 0 order by sbd.time,sbd.id   ", 0, Integer.MAX_VALUE);

                    for (int i = 0; i < sbdlist.size(); i++) {
                        ShopBatchesData sbd = sbdlist.get(i);

                        ProductStock p = ProductStock.find(sbd.psid);
                        StockOperation so1 = new StockOperation();
                        p.setOrdernum(p.getOrdernum() - sbd.getNumber());//减去用户占用的库存
                        p.set();
                        so1.setAmount(sbd.getNumber()); // 数量
                        so1.setDescribe("管理员取消分批,用户占用库存：" + p.getOrdernum() + "支"); // 描述//so.setReserve(number); // 预留数量
                        // 计算有效期
                        so1.setActivity(p.getActivity());
                        so1.setPsid(p.psid); // 库存id
                        so1.setCid(14102669); // 类别id
                        so1.setOid(so.getId());
                        so1.setMember(h.member);
                        Date date = new Date();
                        //so1.setValid();
                        so1.setCalibrationtime(date);
                        so1.setType(7);//管理员操作
                        so1.setTime(new Date());
                        so1.set();

                        sbd.setOccupyNumber(sbd.getNumber());//数量还原
                        sbd.set();

                    }

                    so.setIsbatche(1);
                    so.set();
                } else if ("updateBqlMci".equals(act)) {
                    //医院Bql MCI重新计算赋值
                    ArrayList<ShopHospital> shopHospitals = ShopHospital.find(" AND bq1 is not null ", 0, Integer.MAX_VALUE);
                    for (int i = 0; i < shopHospitals.size(); i++) {
                        ShopHospital hospital = shopHospitals.get(i);
                        String bq1 = hospital.getBq1();
                        float mciByBq = ShopHospital.getMciByBq(bq1);
                        hospital.setBqmci(mciByBq);
                        hospital.set();
                    }
                    //活度预警值去除，号
                    ArrayList<ActivityWarning> activityWarnings = ActivityWarning.find(" AND warning is not null AND warning2 is not null ", 0, Integer.MAX_VALUE);
                    for (int i = 0; i < activityWarnings.size(); i++) {
                        ActivityWarning activityWarning = activityWarnings.get(i);
                        String warning = activityWarning.getWarning();
                        warning = warning.replaceAll(",", "");
                        String warning2 = activityWarning.getWarning2();
                        warning2 = warning2.replaceAll(",", "");
                        activityWarning.setWarning(warning);
                        activityWarning.setWarning2(warning2);
                        activityWarning.update();
                    }


                } else if ("testSubmitOrder".equals(act)) {

                    int hosid = h.getInt("hosid");
                    int quantitynum = h.getInt("quantitynum");
                    double activity = h.getDouble("activity");
                    ActivityWarning activityWarning = ActivityWarning.find(hosid);
                    ShopHospital hos = ShopHospital.find(hosid);
                    float bqmci = hos.getBqmci();
                    String bq1 = hos.getBq1();
                    //停止订货值  有的话  今年+本单超过这个值  不可下单
                    //7.13 吕志超要求调整为    BQ数量除以370000000得到的Mci值为医院总量    减去历史订单得到的剩余值 和 停货值（Mci）对比
                    Double now_mci = activity * quantitynum; //当前订单  mci数
                    Double old_mci = 0.0D; //今年的订单 mci数
                    Double stop_mci;//停止值  mci数
                    Double sum_mci = 0.0D;
                    if (activityWarning.getStop() != null && bq1 != null && bqmci > 0) {
                        String stop = activityWarning.getStop();
                        stop_mci = Double.valueOf(stop);
                        List<ShopOrderData> shopOrderDataList = ShopOrderData.find2(" ,ShopOrderDispatch sod,ShopOrder so where sod.order_id = so.order_id AND sod.order_id=da.order_id     AND so.createdate>dateadd(year, datediff(year, 0, getdate()), 0)  AND sod.a_hospital_id=" + hosid, 0, Integer.MAX_VALUE);
                        for (int i = 0; i < shopOrderDataList.size(); i++) {
                            ShopOrderData shopOrderData = shopOrderDataList.get(i);
                            Double activity1 = shopOrderData.getActivity() * shopOrderData.getQuantity();
                            old_mci = old_mci + activity1;
                        }

                        sum_mci = old_mci + now_mci;

                        //BQMCI - 当前下单总量 小于等于停货值
                        if (bqmci - sum_mci <= stop_mci) {
                            out.print("<script>mt.show('超过停货值！',1,'" + nexturl + "');</script>");
                            return;
                        }

                    }
                } else if ("testYYZZ".equals(act)) {
                    ShopHospital hos = ShopHospital.find(h.getInt("hid"));
                    int invoicePuid = hos.getInvoicePuid();
                    if (!Config.getString("gaoke").equals("" + invoicePuid)) {
                        boolean after = ShopHospital.checkHospitalZZ(h.getInt("hid"));
                        if (!after) {
                            out.print("<script>mt.show('资质过期了！',1,'" + nexturl + "');</script>");
                            return;
                        }
                    }
                } else if ("testPUZZ".equals(act)) {
                    boolean isok = ProcurementUnit.checkZZ(h.getInt("puid"));
                    if (!isok) {
                        out.print("<script>mt.show('资质过期了！',1,'" + nexturl + "');</script>");
                        return;
                    }
                }else if("TESTNOSUMITORDER".equals(act)){
                    Boolean aBoolean = CommonUtils.checkNoSubmitOrder();
                    if(aBoolean){
                        out.print("<script>mt.show('不可下单！',1,'" + nexturl + "');</script>");
                        return;
                    }
                }
                out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
            } catch (Throwable ex) {
                out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
                ex.printStackTrace();
            } finally {
                out.close();
            }

    }

    private void setOrders(ShopOrder so, Http h) throws SQLException {
        //根据用户id查询用户地址信息
        int hosid = h.getInt("hosid");
        ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member, hosid);
        //根据用户id查询用户发票信息
        //ShopNvoice sn = ShopNvoice.getObjByMember(h.member);

        so.setOrderId("PO" + SeqShop.get());
        so.setMember(h.member);
        so.setAmount(h.getDouble("amount"));
        so.setPayType(h.getInt("payType"));
        //so.setInvoice(sn.getType());
        so.setCreateDate(new Date());
        so.setStatus(0);
        so.setPayment(false);
        so.setUserRemarks(h.get("userRemarks"));
        so.setLzCategory(h.getBool("isLzCategory"));
        so.setOrderUnit(h.get("orderUnit"));

        so.setPuid(h.getInt("puid"));

        so.setAllocate(h.getInt("allocate"));
        so.setAllocatetype(h.getInt("allocatetype"));

        so.set();

        ModifyRecord.creatModifyRecord(so.getOrderId(), "下单", h.member, "校准时间：" + h.get("calidate") + "，粒子活度：" + h.get("activity") + "，粒子数：" + h.getInt("quantity"));

        ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
        //添加收货人地址信息
        sod.setA_consignees(MT.f(soa.getConsignees()));
        String cityname = h.get("cityname");
        sod.setA_address(MT.f(cityname) + MT.f(soa.getAddress()));
        sod.setA_mobile(MT.f(soa.getMobile()));
        sod.setA_hospital_id(soa.getHospitalId());
        sod.setA_telphone(MT.f(soa.getTelphone()));
        sod.setA_zipcode(MT.f(soa.getZipcode()));

        sod.setA_hospital(soa.getHospital());        //医院
        sod.setA_department(soa.getDepartment());    //科室
        JSONObject sodJson = JSONObject.fromObject(h);


        //添加收货人发票信息
		/*sod.setN_company(MT.f(sn.getCompany()));
		sod.setN_openbank(MT.f(sn.getOpenbank()));
		sod.setN_accountNo(MT.f(sn.getAccountNo()));
		sod.setN_taxpayerid(MT.f(sn.getTaxpayerId()));
		sod.setN_telphone(MT.f(sn.getTelphone()));
		sod.setN_zip(MT.f(sn.getZip()));
		sod.setN_address(MT.f(sn.getAddress()));
		sod.setN_type(sn.getType());*/

        sod.set();

        //添加订单详细
        //判断是否是微信提交的订单，微信中没有购物车   iswx=1 微信
        int iswx = h.getInt("iswx", 0);
        if (iswx != 1) {
            String cartCookie = h.getCook("cart", "|");
            String[] ps = cartCookie.split("[|]");
            if (ps.length > 0) {
                for (int i = 1; i < ps.length; i++) {
                    String cartP = ps[i];
                    String[] arr = cartP.split("&");

                    int checkFlag = Integer.parseInt(arr[2]);
                    if (checkFlag == 0) continue;

                    cartCookie = cartCookie.replace("|" + cartP + "|", "|");

                    int quantity = Integer.parseInt(arr[1]);//数量

                    //判断product_id是否商品的id，如果不是则为套装id
                    int product_id = Integer.parseInt(arr[0]);
                    //添加订单详细
                    setOrderData(soa.getHospitalId(), product_id, so.getOrderId(), quantity, h);
                }
            }
            //h.setCook("cart",cartCookie,-1);
        } else {
            //添加订单详细
            int product_id = h.getInt("product_id", 0);
            int quantity = h.getInt("quantity", 0); //商品数量
            setOrderData(soa.getHospitalId(), product_id, so.getOrderId(), quantity, h);
        }

    }

    private void setOrderstps(ShopOrder so, Http h) throws SQLException {
        //根据用户id查询用户地址信息
        int hosid = h.getInt("hosid");
        ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member, hosid);
        //根据用户id查询用户发票信息
        //ShopNvoice sn = ShopNvoice.getObjByMember(h.member);

        so.setOrderId("PO" + SeqShop.get());
        so.setMember(h.member);
        so.setAmount(h.getDouble("amount"));
        so.setPayType(h.getInt("payType"));
        //so.setInvoice(sn.getType());
        so.setCreateDate(new Date());
        so.setStatus(0);
        so.setPayment(false);
        so.setUserRemarks(h.get("userRemarks"));
        so.setLzCategory(h.getBool("isLzCategory"));
        so.setOrderUnit(h.get("orderUnit"));

        so.setPuid(h.getInt("puid"));

        so.setAllocate(h.getInt("allocate"));
        so.setAllocatetype(h.getInt("allocatetype"));


        so.setIsinvoice(h.getInt("isinvoice"));

        so.setIsinvoice(h.getInt("isinvoice"));
        so.setInvoiceName(h.get("invoiceName"));
        so.setInvoiceDutyParagraph(h.get("invoiceDutyParagraph"));
        so.setInvoiceProvinces(h.get("invoiceProvinces"));
        so.setInvoiceAddress(h.get("invoiceAddress"));
        so.setInvoiceMobile(h.get("invoiceMobile"));
        so.setInvoiceOpeningBank(h.get("invoiceOpeningBank"));
        so.setInvoiceAccountNumber(h.get("invoiceAccountNumber"));
        so.setInvoiceCostName(h.get("invoiceCostName"));


        int address_ok = h.getInt("address_ok");
        Consignee cs = Consignee.find(address_ok);
        so.setName(cs.getName());
        so.setMobile(cs.getMobile());
        so.setCity(cs.getCity());
        so.setAddress(cs.getAddress());
        so.setYoubian(cs.getYoubian());
        so.setMail(cs.getMail());

        so.setOrderType(h.getInt("orderType"));//1tps 2其他设备

        so.set();

        ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
        //添加收货人地址信息
        sod.setA_consignees(MT.f(soa.getConsignees()));
        String cityname = h.get("cityname");
        sod.setA_address(MT.f(cityname) + MT.f(soa.getAddress()));
        sod.setA_mobile(MT.f(soa.getMobile()));
        sod.setA_hospital_id(soa.getHospitalId());
        sod.setA_telphone(MT.f(soa.getTelphone()));
        sod.setA_zipcode(MT.f(soa.getZipcode()));

        sod.setA_hospital(soa.getHospital());        //医院
        sod.setA_department(soa.getDepartment());    //科室

        //添加收货人发票信息
		/*sod.setN_company(MT.f(sn.getCompany()));
		sod.setN_openbank(MT.f(sn.getOpenbank()));
		sod.setN_accountNo(MT.f(sn.getAccountNo()));
		sod.setN_taxpayerid(MT.f(sn.getTaxpayerId()));
		sod.setN_telphone(MT.f(sn.getTelphone()));
		sod.setN_zip(MT.f(sn.getZip()));
		sod.setN_address(MT.f(sn.getAddress()));
		sod.setN_type(sn.getType());*/

        sod.set();

        String[] product_ids = h.getValues("product_id");
        String[] quantitys = h.getValues("quantity");
        if (product_ids != null) {
            for (int z = 0; z < product_ids.length; z++) {
                setOrderDataTps(soa.getHospitalId(), Integer.parseInt(product_ids[z]), so.getOrderId(), Integer.parseInt(quantitys[z]), h);
            }
        }
        //添加订单详细
		/*int product_id = h.getInt("product_id",0);
		int quantity = h.getInt("quantity",0); //商品数量
		setOrderData(soa.getHospitalId(),product_id,so.getOrderId(),quantity,h);*/

    }

    private void setOrdersEquipment(ShopOrder so, Http h) throws SQLException {
        //根据用户id查询用户地址信息
        int hosid = h.getInt("hosid");
        ShopOrderAddress soa = ShopOrderAddress.getObjByMember(h.member, hosid);
        //根据用户id查询用户发票信息
        //ShopNvoice sn = ShopNvoice.getObjByMember(h.member);

        so.setOrderId("PO" + SeqShop.get());
        so.setMember(h.member);
        so.setAmount(h.getDouble("amount"));
        so.setPayType(h.getInt("payType"));
        //so.setInvoice(sn.getType());
        so.setCreateDate(new Date());
        so.setStatus(0);
        so.setPayment(false);
        so.setUserRemarks(h.get("userRemarks"));
        so.setLzCategory(h.getBool("isLzCategory"));
        so.setOrderUnit(h.get("orderUnit"));

        so.setPuid(h.getInt("puid"));

        so.setAllocate(h.getInt("allocate"));
        so.setAllocatetype(h.getInt("allocatetype"));


        so.setIsinvoice(h.getInt("isinvoice"));

        so.setIsinvoice(h.getInt("isinvoice"));
        so.setInvoiceName(h.get("invoiceName"));
        so.setInvoiceDutyParagraph(h.get("invoiceDutyParagraph"));
        so.setInvoiceProvinces(h.get("invoiceProvinces"));
        so.setInvoiceAddress(h.get("invoiceAddress"));
        so.setInvoiceMobile(h.get("invoiceMobile"));
        so.setInvoiceOpeningBank(h.get("invoiceOpeningBank"));
        so.setInvoiceAccountNumber(h.get("invoiceAccountNumber"));
        so.setInvoiceCostName(h.get("invoiceCostName"));


        int address_ok = h.getInt("address_ok");
        Consignee cs = Consignee.find(address_ok);
        so.setName(cs.getName());
        so.setMobile(cs.getMobile());
        so.setCity(cs.getCity());
        so.setAddress(cs.getAddress());
        so.setYoubian(cs.getYoubian());
        so.setMail(cs.getMail());

        so.setOrderType(h.getInt("orderType"));//1tps 2其他设备

        so.set();

        ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
        //添加收货人地址信息
        sod.setA_consignees(MT.f(soa.getConsignees()));
        String cityname = h.get("cityname");
        sod.setA_address(MT.f(cityname) + MT.f(soa.getAddress()));
        sod.setA_mobile(MT.f(soa.getMobile()));
        sod.setA_hospital_id(soa.getHospitalId());
        sod.setA_telphone(MT.f(soa.getTelphone()));
        sod.setA_zipcode(MT.f(soa.getZipcode()));

        sod.setA_hospital(soa.getHospital());        //医院
        sod.setA_department(soa.getDepartment());    //科室
        sod.set();

        String[] product_ids = h.getValues("product_id");
        String[] quantitys = h.getValues("quantity");
        if (product_ids != null) {
            for (int z = 0; z < product_ids.length; z++) {
                int productOrSpage_id = Integer.parseInt(product_ids[z]);
                int quantity = Integer.parseInt(quantitys[z]);
                String orderId = so.getOrderId();

                ShopProduct p = ShopProduct.find(Integer.parseInt(product_ids[z]));
                float price = ShopPriceSet.find(hosid, productOrSpage_id, 0).price;
                float agent_price_s = 0.0f; //代理商显示价
                float agent_price = 0.0f;    //代理商开票价
                int hospitalId = soa.getHospitalId();
                ShopOrder sos = ShopOrder.findByOrderId(orderId);
                price = p.price;

                ShopPriceSet shopPriceSet = ShopPriceSet.find(hospitalId, p.product, 0);

                ShopOrderData sodata = new ShopOrderData(0);
                sodata.setOrderId(orderId);
                sodata.setProductId(productOrSpage_id);
                sodata.setQuantity(quantity);
                sodata.setUnit((double) price);
                sodata.setAmount((double) price * quantity);
                sodata.setAgent_price_s(agent_price_s);
                sodata.setAgent_price(shopPriceSet.price);
                sodata.setAgent_amount(agent_price * quantity);
                sodata.set();

                sos.setNoinvoicenum(quantity);
                sos.setIsinvoicenum(0);
                so.setNoinvoiceamount(agent_price * quantity);
                sos.setIsinvoiceamount(0);
                sos.set();

            }
        }

    }

    /**
     * @param orderId  订单编号
     * @param quantity 数量
     * @param h
     * @return price   商品价格
     * @throws SQLException
     */
    private void setOrderData(int hospitalId, int productOrSpage_id, String orderId, int quantity, Http h) throws SQLException {
        ShopProduct p = ShopProduct.find(productOrSpage_id);
        float price = 0.0f;
        float agent_price_s = 0.0f; //代理商显示价
        float agent_price = 0.0f;    //代理商开票价
        boolean isLiziClazz = false;
        ShopOrder so = ShopOrder.findByOrderId(orderId);
        if (p.isExist) {
            if (p.category == ShopCategory.getCategory("lzCategory"))
                isLiziClazz = true;
            price = p.price;
            Profile pf = Profile.find(h.member);
            if (pf.qualification == 1 && isLiziClazz) {//资质审核通过，并且商品类为 “碘I125粒子”
                ShopQualification sq = ShopQualification.findByMember(h.member);
                if (sq.id > 0) {
                    ShopPriceSet sps = ShopPriceSet.find(sq.hospital_id, p.product, 0);
                    if (sps.price > 0) {
                        price = sps.price;
                    }
                }
            }
            //int hosid = h.getInt("hosid");
            if (pf.membertype == 2) {//代理商价格
                agent_price_s = ShopPriceSet.findpirce(p, hospitalId, h.member);//底价
                ShopPriceSet sps = ShopPriceSet.find(hospitalId, p.product, 0);    //代理商医院开票价
                if (sps.price > 0) {
                    price = sps.price; //医院的开票价
                }
                if (sps.agentPrice > 0) {
                    agent_price = sps.agentPrice; //代理商医院开票价
                }
            } else {
                ShopHospital sho = ShopHospital.find(hospitalId);
                ShopPriceSet sps = ShopPriceSet.find(hospitalId, p.product, 0);    //代理商医院开票价
                if (sps.price > 0) {
                    price = sps.price; //医院的开票价
                    agent_price_s = sps.price; //医院的开票价为底价
                    agent_price = sps.price; //医院的开票价为底价
                }
                if (sho.getAddflag() == 0) {
                    so.setApplyUnit(hospitalId);//如果vip下单 无代理商增加记录
                }
            }
        } else {
            ShopPackage spage = ShopPackage.find(productOrSpage_id);
            ShopProduct spageP = ShopProduct.find(spage.getProduct_id());
            String[] sarr = spage.getProduct_link_id().split("\\|");
            if (spageP.category == ShopCategory.getCategory("lzCategory"))
                isLiziClazz = true;
            else {
                for (int m = 1; m < sarr.length; m++) {
                    ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[m]));
                    if (!isLiziClazz && s1.category == ShopCategory.getCategory("lzCategory")) {
                        isLiziClazz = true;
                        break;
                    }
                }
            }
            price = (float) spage.getSetPrice();
        }

        ShopOrderData sodata = new ShopOrderData(0);
        sodata.setOrderId(orderId);
        sodata.setProductId(productOrSpage_id);
        sodata.setQuantity(quantity);
        sodata.setUnit((double) price);
        sodata.setAmount((double) price * quantity);
        sodata.setAgent_price_s(agent_price_s);
        sodata.setAgent_price(agent_price);
        sodata.setAgent_amount(agent_price * quantity);

        if (isLiziClazz) {//商品或套装中有产品为类别为粒子时，存储校准时间
            //Date calibrationDate = h.getDate("calidate_"+productOrSpage_id);
            Date calibrationDate = h.getDate("calidate");
            sodata.setCalibrationDate(calibrationDate);
            sodata.setActivity(h.getDouble("activity"));
        }

        sodata.set();
        if (210513438 == productOrSpage_id) {//碘[125I]密封籽源包装壳   issubmitinvoice  2  不允许提交开票
            so.setIssubmitinvoice(2);
        }
        so.setNoinvoicenum(quantity);
        so.setIsinvoicenum(0);
        so.setNoinvoiceamount(agent_price * quantity);
        so.setIsinvoiceamount(0);
        so.set();
    }

    /**
     * @param orderId  订单编号
     * @param quantity 数量
     * @param h
     * @return price   商品价格
     * @throws SQLException
     */
    private void setOrderDataTps(int hospitalId, int productOrSpage_id, String orderId, int quantity, Http h) throws SQLException {
        ShopProduct p = ShopProduct.find(productOrSpage_id);
        float price = 0.0f;
        float agent_price_s = 0.0f; //代理商显示价
        float agent_price = 0.0f;    //代理商开票价
        boolean isLiziClazz = false;
        ShopOrder so = ShopOrder.findByOrderId(orderId);
        price = p.price;
		/*if(p.isExist){
			if(p.category==ShopCategory.getCategory("lzCategory"))
				isLiziClazz = true;
			price = p.price;
			Profile pf = Profile.find(h.member);
			if(pf.qualification==1&&isLiziClazz){//资质审核通过，并且商品类为 “碘I125粒子”
				ShopQualification sq = ShopQualification.findByMember(h.member);
				if(sq.id>0){
					ShopPriceSet sps = ShopPriceSet.find(sq.hospital_id,p.product,0);
					if(sps.price>0){
						price=sps.price;
					}
				}
			}
			//int hosid = h.getInt("hosid");
			if(pf.membertype==2){//代理商价格
				agent_price_s = ShopPriceSet.findpirce(p, hospitalId, h.member);//底价
				ShopPriceSet sps = ShopPriceSet.find(hospitalId,p.product,0);	//代理商医院开票价
				if(sps.price>0){
					price=sps.price; //医院的开票价
				}
				if(sps.agentPrice >0){
					agent_price = sps.agentPrice; //代理商医院开票价
				}
			}else {
				ShopHospital sho = ShopHospital.find(hospitalId);
				ShopPriceSet sps = ShopPriceSet.find(hospitalId,p.product,0);	//代理商医院开票价
				if(sps.price>0){
					price=sps.price; //医院的开票价
					agent_price_s=sps.price; //医院的开票价为底价
					agent_price=sps.price; //医院的开票价为底价
				}
				if(sho.getAddflag()==0) {
					so.setApplyUnit(hospitalId);//如果vip下单 无代理商增加记录
				}
			}
		}else{
			ShopPackage spage = ShopPackage.find(productOrSpage_id);
			ShopProduct spageP = ShopProduct.find(spage.getProduct_id());
			String [] sarr = spage.getProduct_link_id().split("\\|");
			if(spageP.category==ShopCategory.getCategory("lzCategory"))
				isLiziClazz = true;
			else{
				for(int m=1;m<sarr.length;m++){
					ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[m]));
					if(!isLiziClazz&&s1.category==ShopCategory.getCategory("lzCategory")){
						isLiziClazz = true;
						break;
					}
				}
			}
			price=(float) spage.getSetPrice();
		}*/

        ShopOrderData sodata = new ShopOrderData(0);
        sodata.setOrderId(orderId);
        sodata.setProductId(productOrSpage_id);
        sodata.setQuantity(quantity);
        sodata.setUnit((double) price);
        sodata.setAmount((double) price * quantity);
        sodata.setAgent_price_s(agent_price_s);
        sodata.setAgent_price(agent_price);
        sodata.setAgent_amount(agent_price * quantity);

        if (isLiziClazz) {//商品或套装中有产品为类别为粒子时，存储校准时间
            //Date calibrationDate = h.getDate("calidate_"+productOrSpage_id);
            Date calibrationDate = h.getDate("calidate");
            sodata.setCalibrationDate(calibrationDate);
            sodata.setActivity(h.getDouble("activity"));
        }

        sodata.set();

        so.setNoinvoicenum(quantity);
        so.setIsinvoicenum(0);
        so.setNoinvoiceamount(agent_price * quantity);
        so.setIsinvoiceamount(0);
        so.set();
    }



    private void setOrderDataEquipment(int hospitalId, int productOrSpage_id, String orderId, int quantity, Http h) throws SQLException {
        ShopProduct p = ShopProduct.find(productOrSpage_id);
        float price = 0.0f;
        float agent_price_s = 0.0f; //代理商显示价
        float agent_price = 0.0f;    //代理商开票价
        boolean isLiziClazz = false;
        ShopOrder so = ShopOrder.findByOrderId(orderId);
        price = p.price;

        ShopPriceSet shopPriceSet = ShopPriceSet.find(hospitalId, p.product, 0);

        ShopOrderData sodata = new ShopOrderData(0);
        sodata.setOrderId(orderId);
        sodata.setProductId(productOrSpage_id);
        sodata.setQuantity(quantity);
        sodata.setUnit((double) price);
        sodata.setAmount((double) price * quantity);
        sodata.setAgent_price_s(agent_price_s);
        sodata.setAgent_price(shopPriceSet.price);
        sodata.setAgent_amount(agent_price * quantity);
        sodata.set();

        so.setNoinvoicenum(quantity);
        so.setIsinvoicenum(0);
        so.setNoinvoiceamount(agent_price * quantity);
        so.setIsinvoiceamount(0);
        so.set();
    }




    private boolean checkSave(String sT) {
        if (!"".equals(sT) && null != sT) {
            long currentTime = System.currentTimeMillis();
            long stD = Long.parseLong(sT);
            long resutl = currentTime - stD;
            if (resutl < 5000) {
                return false;
            }
        }
        return true;
    }
    private Boolean checkConsignees(int h_id, ShopOrderAddress soa) {
        boolean isok = false;
        List<Profile> pList = Profile.getProfileByHospitalId(h_id,0);
        for (int i = 0; i <pList.size() ; i++) {
            Profile profile = pList.get(i);
            if(profile.getProfile()==soa.getConsignees_id()){
                isok = true;
            }
        }
        return isok;

    }

    /**
     * 厂商如果是高科的话 传给高科的数据
     * @param so
     * @return
     */
    private static String sendGaoKeData(ShopOrder so) throws SQLException {
        JSONObject jsonobject = new JSONObject();
        ShopOrderDispatch shopOrderDispatch = ShopOrderDispatch.findByOrderId(so.getOrderId());
//        JSONObject sodJson = JSONObject.fromObject(shopOrderDispatch);
        jsonobject.put("shopOrderDispatch",shopOrderDispatch);//收货信息
        ShopOrderData shopOrderData = ShopOrderData.findShopOrderData(so.getOrderId());
        JSONObject shopOrderDataJson = new JSONObject();
        shopOrderDataJson.put("id",shopOrderData.getId());
        shopOrderDataJson.put("orderId",shopOrderData.getOrderId());
        shopOrderDataJson.put("productId",shopOrderData.getProductId());
        shopOrderDataJson.put("unit",shopOrderData.getUnit());
        shopOrderDataJson.put("quantity",shopOrderData.getQuantity());
        shopOrderDataJson.put("amount",shopOrderData.getAmount());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String calibrationDate = simpleDateFormat.format(shopOrderData.getCalibrationDate());
        System.out.println(shopOrderData.getCalibrationDate().getTime());
        shopOrderDataJson.put("calibrationDate",calibrationDate);
        shopOrderDataJson.put("activity",shopOrderData.getActivity());
        shopOrderDataJson.put("agent_price_s",shopOrderData.getAgent_price_s());
        shopOrderDataJson.put("agent_price",shopOrderData.getAgent_price());
        shopOrderDataJson.put("exprctedActivity",shopOrderData.getExpectedActivity());
        shopOrderDataJson.put("getJihuo",shopOrderData.getGetJihuo());
        jsonobject.put("shopOrderData",shopOrderDataJson);//订单详情
//        JSONObject shopOrderJson = JSONObject.fromObject(so);//传递订单信息
        jsonobject.put("shopOrder",so);
        return jsonobject.toString();
    }

}