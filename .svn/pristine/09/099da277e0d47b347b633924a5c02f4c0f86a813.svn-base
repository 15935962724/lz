package tea.entity.weibo;

import java.net.*;
import java.text.*;
import java.util.*;
import java.io.*;
import tea.entity.*;
import org.json.*;
import java.sql.SQLException;
import java.security.cert.*;
import javax.net.ssl.*;
import java.security.SecureRandom;

public class OAuth2
{

	//{"error":"expired_token","error_code":21327,"request":"/2/emotions.json"}
	public static String oauth(String url, String par, byte[] pic, String token) throws SQLException
	{
		try
		{
			HttpURLConnection conn = (HttpURLConnection)new URL(url).openConnection();
			conn.setRequestProperty("Authorization", "OAuth2 " + token);
			conn.setRequestProperty("API-RemoteIP", "127.0.0.1");
			if (par != null)
			{
				if (pic != null)
					conn.addRequestProperty("Content-Type", "multipart/form-data; boundary=Jf4mVY1mx_eLBt5GRmSe9hz6i_u6bW");
				conn.setDoOutput(true);
				OutputStream os = conn.getOutputStream();
				if (pic == null)
				{
					os.write(par.toString().getBytes());
				} else
				{
					System.out.println(par.toString());
					String[] arr = par.toString().split("&");
					for (int i = 0; i < arr.length; i++)
					{
						int j = arr[i].indexOf('=');
						os.write(("--Jf4mVY1mx_eLBt5GRmSe9hz6i_u6bW\r\nContent-Disposition: form-data; name=\"" + arr[i].substring(0, j) + "\"\r\n\r\n" + URLDecoder.decode(arr[i].substring(j + 1), "UTF-8") + "\r\n").getBytes("UTF-8"));
					}
					os.write("--Jf4mVY1mx_eLBt5GRmSe9hz6i_u6bW\r\nContent-Disposition: form-data; name=\"pic\"; filename=\"pic.jpg\"\r\n\r\n".getBytes());
					os.write(pic);
					os.write("\r\n--Jf4mVY1mx_eLBt5GRmSe9hz6i_u6bW--\r\n".getBytes());
				}
				os.close();
			}
			//
			int code = conn.getResponseCode();
			InputStream is = code == 200 ? conn.getInputStream() : conn.getErrorStream();
			String str = new String(Filex.read(is), "UTF-8");
			if (code == 200)
			{
				str = "{\"request\":\"\",\"error_code\":0,\"error\":\"\",data:" + str + "}";
			}
			Filex.logs("OAuth2.log", str);
			return str;
		} catch (Exception ex)
		{
			ex.printStackTrace();
			return null;
		}
	}

	//
	public String token;
	public OAuth2(String token)
	{
		this.token = token;
	}

	//根据微博ID删除指定微博
	public String delete(long mid) throws SQLException, JSONException
	{
		String json = oauth("https://api.weibo.com/2/statuses/destroy.json", "id=" + mid, null, token);
		JSONObject o = new JSONObject(json);
		int code = o.getInt("error_code");
		if (code > 0)
		{
			return err(code, o.getString("error"));
		}
		return null;
	}

	public static String err(int code, String err)
	{
		switch (code)
		{
		case 20012: //Text too long, please input text less than 140 characters!
			err = "内容过长,内容最多140字！";
			break;
		case 20019: //repeat content!
			err = "不能连续发布相同的微博！";
			break;
		case 20101: //target weibo does not exist!
			err = "微博已经不存在了！";
			return null;
		case 20102: //not your own weibo!
			err = "无法删除别人发布的微博！";
			break;
		case 21321: //applications over the unaudited use restrictions!
			err = "该应用没有审核，只能使用测试帐号！";
			break;
		case 21327: //expired_token
			err = "授权已过期！";
			break;
		case 21332: //invalid_access_token
			err = "授权已失效！";
			break;
		case 10024: //User requests for /statuses/update out of rate limit!
			err = "请求次数过多！";
			break;
		}
		return "错误：" + err;
	}

}
