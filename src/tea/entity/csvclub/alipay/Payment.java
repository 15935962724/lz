package tea.entity.csvclub.alipay;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;

public class Payment {

    public static String CreateUrl(String paygateway, String service, String sign_type,
    		String out_trade_no,String input_charset,
    		String partner,String key,String show_url,
    		String body, String total_fee, String payment_type,
    		String seller_email,String subject ,String notify_url,
    		String return_url) {

        Map params = new HashMap();
        params.put("service", service);
        params.put("partner", partner);
        params.put("subject", subject);
        params.put("body", body);
        params.put("out_trade_no", out_trade_no);
        params.put("total_fee", total_fee);
        params.put("show_url", show_url);
        params.put("payment_type",payment_type);
        params.put("seller_email", seller_email);
        params.put("return_url", return_url);
        params.put("notify_url", notify_url);
        params.put("_input_charset", input_charset);

        String prestr = "";

        prestr = prestr + key;
        //System.out.println("prestr=" + prestr);

        String sign = tea.entity.csvclub.alipay.Md5Encrypt.md5(getContent(params, key));

        String parameter = "";
        parameter = parameter + paygateway;

        List keys = new ArrayList(params.keySet());
        for (int i = 0; i < keys.size(); i++) {
            try {
                parameter = parameter + keys.get(i) + "=" + URLEncoder.encode((String) params.get(keys.get(i)), input_charset) + "&";
            } catch (UnsupportedEncodingException e) {

                e.printStackTrace();
            }
        }

        parameter = parameter + "sign=" + sign + "&sign_type=" + sign_type;

        return parameter;

    }

    private static String getContent(Map params, String privateKey) {
        List keys = new ArrayList(params.keySet());
        Collections.sort(keys);

        String prestr = "";

        for (int i = 0; i < keys.size(); i++) {
            String key = (String) keys.get(i);
            String value = (String) params.get(key);

            if (i == keys.size() - 1) {
                prestr = prestr + key + "=" + value;
            } else {
                prestr = prestr + key + "=" + value + "&";
            }
        }

        return prestr + privateKey;
    }
}
