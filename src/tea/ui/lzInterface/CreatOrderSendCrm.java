package tea.ui.lzInterface;

import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import tea.entity.Database;
import tea.entity.Filex;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.yl.shop.*;
import tea.ui.util.JsonUtil;
import util.Config;

import java.io.IOException;
import java.security.Security;
import java.sql.SQLException;
import java.util.*;

public class CreatOrderSendCrm {
    public static void main(String[] args) throws IOException, SQLException {
        int status = send("PO2009010003");

    }

    public static int send(String orderId) throws IOException, SQLException {
        //1.打开浏览器
        int responseStatus = 0;
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://api-tencent.xiaoshouyi.com/rest/data/v2.0/scripts/api/tfCrmApi/saveOrUpdateOrder?systemType=2&saveOrUpdate=1");
        httpPost.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36");
        String token = "";
        try {
            token = Utils.getToken();
        } catch (Exception e) {

        }
        try {

            httpPost.addHeader("Authorization", token);
            httpPost.addHeader("Content-type", "application/json");
            JSONObject jsonObject = new JSONObject();
            ShopOrder order = ShopOrder.findByOrderId(orderId);
            ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderId);
            ShopHospital hospital = ShopHospital.find(sod.getA_hospital_id());
            Profile profile = Profile.find(order.getMember());
            /*//如果该账户是服务商子账户  profile赋值为父账户
            if (profile.getMembertype() == 3) {
                // profile.parentpro 获取父profile 的 profile
                profile = Profile.find(profile.parentpro);
            }*/
            ArrayList<ShopOrderData> shopOrderData = ShopOrderData.find(" AND order_id=" + Database.cite(orderId), 0, Integer.MAX_VALUE);
            int puid = ShopOrderData.findPuid(order.getOrderId());
            ProcurementUnitJoin pu = ProcurementUnitJoin.find(puid, order.getMember(), hospital.getId());
            String crmid = pu.getCrmid();//服务商档案id
            jsonObject.put("customItem178__c", orderId);//粒子订单号
            jsonObject.put("customItem181__c", "30-Cxx-003");//销售订单类型       11.23非必传
            jsonObject.put("accountId",MT.f(hospital.getHos_code()));//正式
            //jsonObject.put("accountId", "1481107671649055");//客户名称  传crm id
            jsonObject.put("transactionDate", order.getCreateDate().getTime());//粒子下单时间
            jsonObject.put("customItem185__c", MT.f(crmid));//CRM服务商客户ID 接口中的F_ID 跟服务商公司关联
            //jsonObject.put("customItem185__c", "1496626116741931");
            jsonObject.put("ownerId", MT.f(profile.getCode()));//服务商人员（员工编号）     1399239950386126
            jsonObject.put("customItem217__c", MT.f(sod.getA_consignees()));
            jsonObject.put("contactAddress", MT.f(sod.getA_address()));
            //jsonObject.put("ownerId", "1399239950386126");//服务商人员（员工编号）
            int jid = pu.getJid();
            String customItem204__c = "";//销售组织  固定的值 CRM给的   君安  欣科  高科
            if (jid == Config.getInt("junan")) {
                customItem204__c = "15419";
            } else if (jid == Config.getInt("xinke")) {
                customItem204__c = "1540101";
            } else {
                customItem204__c = "1540600";
            }
            jsonObject.put("customItem204__c", customItem204__c);//销售组织
            JSONArray jsonArray = new JSONArray();
            String ncProId = "";
            for (int i = 0; i < shopOrderData.size(); i++) {
                ShopOrderData s = shopOrderData.get(i);
                JSONObject jsonObject2 = new JSONObject();
                List<NcLzProduct> ncLzProducts = NcLzProduct.find(" AND puid=" + puid + " AND status!=0 ", 0, Integer.MAX_VALUE);
                Double activity = s.getActivity();
                String ncProductCode = "";
                Boolean checkActivity = false;
                //查看当前厂商产品活度  是哪一个nc编码
                for (int j = 0; j < ncLzProducts.size(); j++) {
                    if (checkActivity) {
                        break;
                    }
                    NcLzProduct ncLzProduct = ncLzProducts.get(j);
                    if (ncLzProduct.getStatus() == 1) {//单个
                        if (Double.parseDouble(ncLzProduct.getActivity()) == activity) {
                            checkActivity = true;
                            ncProductCode = ncLzProduct.getNcCode();
                        }
                    } else {//范围
                        String activityScope = ncLzProduct.getActivityScope();
                        String[] split = activityScope.split("-");
                        if (activity >= Double.parseDouble(split[0]) && activity <= Double.parseDouble(split[1])) {
                            checkActivity = true;
                            ncProductCode = ncLzProduct.getNcCode();
                        }
                    }

                }

                jsonObject2.put("customItem213__c", s.getId());//id
                jsonObject2.put("productId", ncProductCode);
                //jsonObject2.put("productId", "4020102-C14-0001");//商品編碼
                jsonObject2.put("unitPrice", s.getAgent_price());//價格
                jsonObject2.put("quantity", s.getQuantity());//數量
                jsonObject2.put("customItem209__c", s.getCalibrationDate().getTime());//校準時間
                ncProId = ncProductCode;
                //当前活度的对应nc编码  存起来
                s.setNcPuidCode(ncProId);
                s.set();
                jsonArray.add(jsonObject2);
            }
            jsonObject.put("dataList", jsonArray.toString());

            StringEntity stringEntity = new StringEntity(jsonObject.toString(), ContentType.APPLICATION_JSON);

            httpPost.setEntity(stringEntity);

            //3.发送请求
            Security.addProvider(new BouncyCastleProvider());

            Filex.logs("log_interface/send_order/" + MT.f(new Date()) + ".log", "请求：" + jsonObject.toString());
            CloseableHttpResponse response = httpClient.execute(httpPost);
            Filex.logs("log_interface/send_order/" + MT.f(new Date()) + ".log", "响应：");
            HttpEntity entity = response.getEntity();
            String string = EntityUtils.toString(entity, "utf-8");
            SendCrmLog sendCrmLog = SendCrmLog.find(0);
            sendCrmLog.setStatus(1);
            sendCrmLog.setModifyTime(new Date());
            sendCrmLog.setContent(string.replaceAll(" ", ""));
            sendCrmLog.setOrder_id(orderId);
            sendCrmLog.set();
            Map<String, Object> map = JsonUtil.fromJsonObj(string);
            /*Map<String, Object> map = new Gson().fromJson(string, new TypeToken<Map<String, Object>>() {
            }.getType());*/
            Double c = (Double) map.get("code");
            boolean data = map.containsKey("data");
            if (data) {//存在data
                //将map中的json  取出来 将科学计数法转为String 去除 E15和.
                Object data1 = map.get("data");
                String ste = data1 + "";
                map = JsonUtil.fromJsonObj(ste);
                String id = map.get("id") + "";
                double v = Double.parseDouble(id);
                long l = (long) v;
                shopOrderData.get(0).setCrmOrderId(l+"");
                shopOrderData.get(0).set();

            }
            responseStatus = c.intValue();
            response.close();
            httpClient.close();
            Filex.logs("log_interface/send_order/" + MT.f(new Date()) + ".log", "响应：" + string);
        } catch (Exception e) {
            responseStatus = 2;
            SendCrmLog sendCrmLog = SendCrmLog.find(0);
            sendCrmLog.setStatus(1);
            sendCrmLog.setModifyTime(new Date());
            sendCrmLog.setContent("推送接口catch" + e);
            sendCrmLog.setOrder_id(orderId);
            sendCrmLog.set();
            Filex.logs("log_interface/send_order/" + MT.f(new Date()) + ".log", "响应：" + e);
        }
        return responseStatus;
    }
}
