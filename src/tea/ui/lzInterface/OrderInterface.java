package tea.ui.lzInterface;

import com.alibaba.fastjson.JSONObject;
import tea.entity.MT;
import tea.entity.member.ModifyRecord;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.ShopOrderData;
import tea.entity.yl.shop.ShopOrderExpress;
import tea.entity.yl.shop.ShopSMSSetting;
import util.Config;
import util.DateUtil;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class OrderInterface extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jo = new JSONObject();
        String backTime = DateUtil.getStringFromDate(new Date(),"yyyyMMddHHmmss");
        BufferedReader br = new BufferedReader(new InputStreamReader(
                (ServletInputStream) request.getInputStream(), "utf-8"));
        StringBuffer sb = new StringBuffer("");
        String temp;
        while ((temp = br.readLine()) != null) {
            sb.append(temp);
        }
        br.close();
        System.out.println(sb.toString());
        JSONObject jsonObject =  JSONObject.parseObject(sb.toString());
        System.out.println(jsonObject);
        String act=jsonObject.getString("act");

//        Http h = new Http(request, response);
        try {
            if("factoryVersion".equals(act)){
                int type=jsonObject.getInteger("type");
                String orderId=jsonObject.getString("orderId");
                ShopOrderExpress soe= ShopOrderExpress.find(jsonObject.getInteger("id"));
                soe.order_id=orderId;
                soe.price= BigDecimal.valueOf(0);
                soe.express_code= jsonObject.getString("express_code");
                soe.person= jsonObject.getString("person");
                soe.mobile=jsonObject.getString("mobile");
                soe.time=jsonObject.getDate("time");
                soe.type=type;
                soe.NO2=jsonObject.getString("no2");
                soe.vtime=jsonObject.getDate("vtime");
//                soe.images=h.get("serveridwai");
//                soe.express_img = h.get("express_img");
                soe.set();
                ShopOrder order=ShopOrder.findByOrderId(orderId);

                if(Config.getInt("tongfu")==order.getPuid()){
                    if(order.getStatus()==2){
                        //?????????????????? ?????????????????????
                        //????????????????????????????????????????????????
                        String user = jsonObject.getString("user");
                        int mypuid = order.getPuid();//??????????????????
                        //?????????????????? ????????????
                        if(Config.getInt("tongfu")==order.getPuid()){
                            mypuid = ShopOrderData.findPuid(order.getOrderId());
                        }

                        ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+mypuid,0,1);
                        //ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
                        if(list.size() > 0){
                            ShopSMSSetting sms = list.get(0);
                            if(MT.f(sms.sczjbg)!=""){
                                List<String> mobiles = ShopSMSSetting.getUserMobile(sms.sczjbg);
                                if(!"".equals(MT.f(mobiles.toString())))
                                    SMSMessage.create("Home", user, mobiles.toString(), 1, "??????"+order.getOrderId()+"????????????????????????");
                            }
                        }

                    }
                    ModifyRecord.creatModifyRecord(order.getOrderId(),"????????????",0,"??????????????????"+jsonObject.getString("user")+"?????????????????????");
                }else{
                    order.set("status", "-5");
                }

                jo.put("status", "success");//????????????
                jo.put("time", backTime);//??????????????????
            }if("uploadReport".equals(act)){
                String orderId=jsonObject.getString("orderId");
                int soeid=jsonObject.getInteger("id");
                ShopOrderExpress soe=ShopOrderExpress.find(soeid);
                ShopOrder order = ShopOrder.findByOrderId(orderId);
                soe.images=jsonObject.getString("images");
                soe.set();
                order.set("status", "-1");//????????????????????????????????????????????????????????????
                //??????????????????????????????(???????????????)
                String user =jsonObject.getString("user");

                ShopOrder so = ShopOrder.findByOrderId(soe.order_id);

                ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+so.getPuid(),0,1);
                if(list.size() > 0){
                    ShopSMSSetting sms = list.get(0);
                    if(MT.f(sms.ckcs)!=""){
                        List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckcs);
                        if(!"".equals(MT.f(mobiles.toString())))
                            SMSMessage.create("Home", user, mobiles.toString(),1, order.getOrderId()+"??????????????????????????????????????????");
                    }

                }
                ModifyRecord.creatModifyRecord(order.getOrderId(),"????????????",0,"??????????????????"+jsonObject.getString("user")+"???????????????????????????");
                jo.put("status", "success");//????????????
                jo.put("time", backTime);//??????????????????
            }else {
                jo.put("status", "fail");//????????????
                jo.put("message", "act?????????????????????");
            }

        } catch (Exception e) {
            e.printStackTrace();
            jo.put("status", "fail");
            jo.put("message", "????????????");
        } finally {
            jo.put("time", backTime);//??????????????????
            out.print(jo);
        }
    }
}
