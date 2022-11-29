package util;

import org.springframework.util.Assert;
import tea.entity.Attch;
import tea.entity.Filex;
import tea.entity.yl.shop.ActivityWarning;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;

public class CommonUtils {

	public final String SMS_CONTENT = "sms_content.properties";
	
	/**
	 * 通过key获取.properties中的value
	 * @param key
	 * @return value
	 * */
	public String getValue(String key,String properties_file){
		String value="";
        try {
            Properties properties = new Properties();
			properties.load(new InputStreamReader(this.getClass().getClassLoader().getResourceAsStream(properties_file), "UTF-8")); 
			value = properties.getProperty(key);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return value;
	}
	/**
	 * 读取sms_content.properties
	 * */
	public String getSms_content(String key){
		String result = getValue(key, SMS_CONTENT);
		return result;
	}
	
	public String replace(String content,String user,String order,String waybill,String returnid){
		content = content.replace("user", user);
		content = content.replace("order", order);
		content = content.replace("waybill", waybill);
		content = content.replace("returnid", returnid);
		return content;
	}
	public String replace(String content,String user,String order,String waybill,String returnid,String hospital,String consignees,String quantity){
		content = content.replace("user", user);
		content = content.replace("order", order);
		content = content.replace("waybill", waybill);
	    content = content.replace("returnid", returnid);
		content = content.replace("hospital", hospital);
		content = content.replace("consignees", consignees);
		content = content.replace("quantity", quantity);
		return content;
	}
	public String replaceMob(String content,String user,String order,String waybill,String returnid,String hospital,String consignees,String quantity,String telephone){
		content = content.replace("user", user);
		content = content.replace("order", order);
		content = content.replace("waybill", waybill);
		content = content.replace("returnid", returnid);
		content = content.replace("hospital", hospital);
		content = content.replace("consignees", consignees);
		content = content.replace("quantity", quantity);
		content = content.replace("telephone", telephone);
		return content;
	}

	public static String getFileUrlByAttchId(String yuming,int attchId){

	    StringBuffer sb = new StringBuffer();

        try {
            Attch attch = Attch.find(attchId);
            sb.append(yuming).append(attch.path);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return sb.toString();
    }

    public static String getIP(HttpServletRequest request) {
		Assert.notNull(request, "HttpServletRequest is null");
		String ip = request.getHeader("X-Requested-For");
		if (ip==null || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Forwarded-For");
		}
		if (ip==null || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip==null || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip==null || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");

		}
		if (ip==null || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip==null || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip==null ? null : ip.split(",")[0];
	}

	/**
	 *  高科、君安 到日期后不可下单、申请开票
	 * @return
	 */
	public static Boolean checkNoSubmitOrder() {
		ActivityWarning activityWarning = ActivityWarning.find(2022);
		boolean after = false;
		String warning2 = activityWarning.getWarning2();
		Filex.logs("stopSubmit.txt", "停止下单时间：" + warning2 );
		if(warning2!=null) {
			Date endTime = DateUtil.getDateFromString(warning2,"yyyy-MM-dd HH:ss");
			if(endTime!=null) {
				after = endTime.before(new Date());
			}
		}
		return after;
	}
}
