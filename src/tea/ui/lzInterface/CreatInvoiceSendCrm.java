package tea.ui.lzInterface;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
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
import tea.entity.yl.shopnew.Invoice;
import tea.entity.yl.shopnew.InvoiceData;
import tea.ui.util.JsonUtil;
import util.Config;

import java.io.IOException;
import java.math.BigDecimal;
import java.security.Security;
import java.sql.SQLException;
import java.util.*;

import static java.math.BigDecimal.valueOf;

public class CreatInvoiceSendCrm {
    public static void main(String[] args) throws IOException, SQLException {
        /*Invoice invoice = Invoice.find(20110196);
        int send = send(invoice);
        System.out.println(send);*/
        String token = Utils.getToken();
        System.out.println(token);

    }

    public static int send(Invoice invoice) throws IOException, SQLException {
        int responseStatus = 0;
        //order 订单   type 1新增  2修改
        try {

            int puid = invoice.getPuid();
            CloseableHttpClient httpClient = HttpClients.createDefault();
            HttpPost httpPost = new HttpPost("https://api-sandbox.xiaoshouyi.com/rest/data/v2.0/scripts/api/tfCrmApi/saveOrUpdateInvoiceRequest?systemType=2&saveOrUpdate=1");
            httpPost.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36");
            String token = Utils.getToken();
            httpPost.addHeader("Authorization", token);
            httpPost.addHeader("Content-type", "application/json");
            int hospitalid = invoice.getHospitalid();
            ShopHospital hospital = ShopHospital.find(hospitalid);
            ProcurementUnitJoin pu = ProcurementUnitJoin.find(puid, invoice.getMember(), hospital.getId());
            Profile profile = Profile.find(invoice.getMember());
            String crmid = pu.getCrmid();//服务商档案id
            List<NameValuePair> parameters = new ArrayList<NameValuePair>(0);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("name", invoice.getId());
            jsonObject.put("customItem2__c",hospital.getHos_code());//客户ID 客商编码
            jsonObject.put("customItem25__c",hospital.getId());//粒子医院id
            //jsonObject.put("customItem2__c", "1481107671649055");//医院接口   CRM_CODE
            jsonObject.put("customItem16__c",crmid);
            //jsonObject.put("customItem16__c", "1496626116741931");//F_ID 服务商接口
            jsonObject.put("customItem4__c", profile.getMobile());//服务商用户账号  手机号
            jsonObject.put("ownerId",MT.f(profile.getCode()));
            //jsonObject.put("ownerId", "1399239950386126");//服务商人员编号
            jsonObject.put("customItem5__c",MT.f(invoice.getConsigness()));//收票人
            jsonObject.put("customItem6__c",MT.f(invoice.getAddress()));//收票人地址
            jsonObject.put("customItem7__c",MT.f(invoice.getTelphone()));//收票人电话
            String customItem204__c = "";//销售组织  固定的值 CRM给的   君安  欣科  高科
            if (puid == Config.getInt("junan")) {
                customItem204__c = "15419";
            } else if (puid == Config.getInt("xinke")) {
                customItem204__c = "1540101";
            } else {
                customItem204__c = "1540600";
            }
            jsonObject.put("customItem3__c", customItem204__c);
            JSONArray jsonArray = new JSONArray();
            List<InvoiceData> lstdata = InvoiceData.find(" and invoiceid=" + invoice.getId(), 0, Integer.MAX_VALUE);

            for (int i = 0; i < lstdata.size(); i++) {
                JSONObject jsonObject2 = new JSONObject();
                InvoiceData data = lstdata.get(i);//发票
                String orderid = data.getOrderid();//订单id
                String pro_puid = MT.f(ProcurementUnit.findName(puid));//商品厂商
                List<ShopOrderData> lstorderdata = ShopOrderData.find(" and order_id=" + Database.cite(orderid), 0, 1);//订单详情
                ShopOrderData sod = lstorderdata.get(0);
                String ncPuidCode = sod.getNcPuidCode();
                String crmOrderId = sod.getCrmOrderId();
                int num = data.getNum();//开票数量
                BigDecimal amount = valueOf(data.getAmount());//总金额
                BigDecimal agentPrice = valueOf(sod.getAgent_price());//单价
                jsonObject2.put("customItem1__c", pro_puid + "");
                jsonObject2.put("customItem2__c", crmOrderId + "");
                jsonObject2.put("customItem6__c", data.getId() + "");
                jsonObject2.put("customItem5__c", ncPuidCode + "");
                jsonObject2.put("customItem8__c", agentPrice + "");
                jsonObject2.put("customItem9__c", num + "");
                jsonObject2.put("customItem10__c", amount + "");
                jsonArray.add(jsonObject2);
            }
            jsonObject.put("dataList", jsonArray.toString());
            Filex.logs("log_interface/send_invoice/" + MT.f(new Date()) + ".log", "请求：" + jsonObject.toString());
            StringEntity stringEntity = new StringEntity(jsonObject.toString(), ContentType.APPLICATION_JSON);
            httpPost.setEntity(stringEntity);

            //3.发送请求
            Security.addProvider(new BouncyCastleProvider());
            CloseableHttpResponse response = httpClient.execute(httpPost);


            HttpEntity entity = response.getEntity();
            String string = EntityUtils.toString(entity, "utf-8");
            SendCrmLog sendCrmLog = SendCrmLog.find(0);
            sendCrmLog.setStatus(5);
            sendCrmLog.setModifyTime(new Date());
            sendCrmLog.setContent(string);
            sendCrmLog.setOrder_id(invoice.getId() + "");
            sendCrmLog.set();
            Filex.logs("log_interface/send_invoice/" + MT.f(new Date()) + ".log", "响应：" + string);
            Map<String, Object> map = JsonUtil.fromJsonObj(string);
            Double c = (Double) map.get("code");
           /* boolean data = map.containsKey("data");
            if (data) {//存在data
                //将map中的json  取出来 将科学计数法转为String 去除 E15和.
                Object data1 = map.get("data");
                String ste = data1 + "";
                map = JsonUtil.fromJsonObj(ste);
                String id = map.get("id") + "";
                double v = Double.parseDouble(id);
                long l = (long) v;
            }*/
            responseStatus = c.intValue();

            //5.关闭资源
            response.close();
            httpClient.close();
            return responseStatus;

        } catch (Exception e) {
            responseStatus = 2;
        }
        return responseStatus;
    }
}
