package tea.ui.lzInterface;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import tea.ui.util.JsonUtil;

import java.io.IOException;
import java.security.Security;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class Utils {
    public static String getToken() throws IOException, SQLException {//获取token
        String value = "";
        try {
            SendCrmLog sendCrmLog = SendCrmLog.find(0);
            sendCrmLog.setStatus(1);
            sendCrmLog.setModifyTime(new Date());
            sendCrmLog.setContent("进token了");
            sendCrmLog.setOrder_id("");
            sendCrmLog.set();
            //打开浏览器
            CloseableHttpClient httpClient = HttpClients.createDefault();
            //声明请求
            HttpPost httpPost = new HttpPost("https://api-tencent.xiaoshouyi.com/oauth2/token.action");
            //在post请求中模仿浏览器
            httpPost.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36");

            List<NameValuePair> parameters = new ArrayList<NameValuePair>(0);
            parameters.add(new BasicNameValuePair("client_id", "e39f3c7a13028ffea88b0ffc07a82c54"));
            parameters.add(new BasicNameValuePair("client_secret", "642b8e788be06683cdf4084c477513d8"));
            parameters.add(new BasicNameValuePair("redirect_url", "https://api-tencent.xiaoshouyi.com"));
            parameters.add(new BasicNameValuePair("password", "YUjie728OsYBq5F9"));
            parameters.add(new BasicNameValuePair("username", "18938846526"));
            parameters.add(new BasicNameValuePair("grant_type", "password"));
            UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(parameters, "UTF-8");
            httpPost.setEntity(formEntity);
            //3.发送请求
            Security.addProvider(new BouncyCastleProvider());
            CloseableHttpResponse response = httpClient.execute(httpPost);
            int responseStatus = 0;
            HttpEntity entity = response.getEntity();
            String string = EntityUtils.toString(entity, "utf-8");
            Map<String, Object> map = JsonUtil.fromJsonObj(string);
            for (String m : map.keySet()) {
                if ("access_token".equals(m)) {
                    Object o = map.get(m);
                    value = o + "";
                }
            }
            if (value.equals("")) {
                System.out.println("没获取到");
            } else {
                System.out.println("获取到了token");
            }
            //5.关闭资源
            response.close();
            httpClient.close();
            System.out.println("-------------" + string);
            sendCrmLog = SendCrmLog.find(0);
            sendCrmLog.setStatus(1);
            sendCrmLog.setModifyTime(new Date());
            sendCrmLog.setContent("返回token" + value);
            sendCrmLog.setOrder_id("");
            sendCrmLog.set();
        }catch (Exception e){
            return value;
        }
        return value;
    }
}
