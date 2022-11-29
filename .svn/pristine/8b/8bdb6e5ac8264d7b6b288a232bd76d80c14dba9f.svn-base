package tea.ui.yl.shop;

import org.json.JSONArray;
import org.json.JSONObject;
import tea.SeqShop;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.yl.shop.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

/**
 * TPS订单相关
 */
public class ShopTps extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();
        JSONObject jo = new JSONObject();
        int ismobile = h.getInt("ismobile");
        if(ismobile == 0) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
        }
        String message = "操作执行成功！";
        // 新增TPS订单
        if ("addTps".equals(act)) {
            try {
                int product_id = h.getInt("product_id");//产品id
                int hosid = h.getInt("hosid");//医院id
                int consignees_id = h.getInt("consignees_id");//签收人id
                int fws_id = h.getInt("fws_id");//服务商id
                Profile profile = Profile.find(consignees_id);
                if (product_id == 0) {
                    message = "产品未选择，下单失败";
                } else if (hosid == 0) {
                    message = "医院未选择，下单失败";
                } else if (consignees_id == 0) {
                    message = "签收人未选择，下单失败";
                } else if (fws_id == 0) {
                    message = "请重新登录下单";
                } else if (MT.f(profile.getEmail()).equals("")) {
                    message = "收货人没完善邮箱，完善后下单";
                } else {

                    ShopProduct p = ShopProduct.find(product_id);
                    ShopProductModel spm = ShopProductModel.find(p.model_id);
                    TpsOrder tpsOrder = TpsOrder.find(0);
                    tpsOrder.setFws_id(fws_id);
                    tpsOrder.setHospital_id(hosid);
                    //订单支付方式   1抵扣 2付款
                    tpsOrder.setOrderms(1);
                    tpsOrder.setStatus(1);// 1下单  2推送  3获取
                    tpsOrder.setOrder_id("TPS" + SeqShop.get());
                    tpsOrder.setHpcs(MT.f(spm.getModel()));
                    String f = MT.f(ShopCategory.find(p.category).name[1]);
                    int jifen = 0;
                    if(f.contains("时间")){// 时间
                        jifen = p.send_tps_number * 50;
                    }else {//次数
                        jifen = p.send_tps_number * 30;
                    }
                    if(jifen == 0){
                        message= "该产品未设置积分，请联系管理员处理！";

                    }else {
                        tpsOrder.setJifen(jifen);
                        tpsOrder.setXdms(f);
                        tpsOrder.setSend_tps_number(p.send_tps_number);
                        tpsOrder.setJqm("");
                        tpsOrder.setJhm("");
                        tpsOrder.setCreatetime(new Date());
                        tpsOrder.setConsignees_id(consignees_id);
                        tpsOrder.setEmail(profile.getEmail());
                        tpsOrder.set();
                    }


                }


            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
                return;
            }

        } else if ("submitsbm".equals(act)) {//提交设备码
            int orderId = h.getInt("orderId");//tps订单id
            String jqm = h.get("jqm");//机器码
            try {

                TpsOrder tpsOrder = TpsOrder.find(orderId);
                tpsOrder.setStatus(2);//订单状态  已推送
                tpsOrder.setJqm(jqm);//机器码
                tpsOrder.set();

                //推送邮件  固定格式
                Boolean aBoolean = TpsOrder.sendMailToFactory(orderId);
                if (!aBoolean) {//没推送成功， 返回错误 不保存机器码
                    tpsOrder.setStatus(1);
                    tpsOrder.setJhm(null);
                    message = "系统错误，请联系管理人员处理";

                } else {
                    tpsOrder.setJqmtime(new Date());//获取机器码时间
                }
                tpsOrder.set();


            } catch (SQLException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }


        }else if("inertjf".equals(act)){//初始化积分    一粒一积分    从2021-1-1开始计算

            try {
                com.alibaba.fastjson.JSONArray objects = new com.alibaba.fastjson.JSONArray();
                ArrayList arrayList = Profile.find1(" AND  membertype=2 AND type=0 AND deleted=0", 0, Integer.MAX_VALUE);
                for (int i = 0; i <arrayList.size() ; i++) {
                    JSONObject pojo = new JSONObject();
                    Profile p = (Profile) arrayList.get(i);
                    int profile = p.getProfile();
                    int sumNumber = TpsOrder.sumNumber(profile, "2021-01-01 00:00:00");
                    System.out.println(profile+"         "+sumNumber);
                    pojo.put("profile",profile);
                    pojo.put("sumNumber",sumNumber);
                    objects.add(pojo);
                }

                jo.put("data",objects);
            } catch (SQLException e) {
                e.printStackTrace();
            }




        }

        if (h.getInt("ismobile") == 1) {

            if (message.equals("操作执行成功！")) {
                jo.put("code", 1);
            } else {
                jo.put("code", 2);
            }
            jo.put("msg", message);

            out.print(jo);
            return;

        } else {
            out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
            return;
        }

    }
}
