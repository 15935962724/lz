package tea.ui.alisoft;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import tea.entity.member.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.alisoft.sip.sdk.isv.SignatureUtil;
import javax.servlet.http.HttpSession;
import tea.entity.member.OnlineList;
import tea.entity.RV;
import java.sql.*;


/**
 * Servlet implementation class for Servlet: ValidateUserServlet
 *
 */
/**
 * @author shuijing.linshj
 *2008-10-22
 */
public class GetUsingUser extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
	static final long serialVersionUID = 1L;
	public static java.text.SimpleDateFormat SIP_TIMESTAMP_FORMATER = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");// 时间格式

	/*
	 * (non-Java-doc)
	 *
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public GetUsingUser() {
		super();
	}

	/*
	 * (non-Java-doc)
	 *
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request,
	 *      HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	/*
	 * (non-Java-doc)
	 *
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request,
	 *      HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		@SuppressWarnings("unused")
		String message =null;//结果信息
		String code = null;// code为返回的状态码
		String result = null;// result为返回信息
		String userId = request.getParameter("user_id");//最终用户在ASSP上的唯一用户身份ID
		String appId = request.getParameter("app_id");//ISV软件的唯一不可变更的编号，注册软件时生成
		String appInstanceId = request.getParameter("app_instance_id");//最终用户订购ISV软件生成的唯一编码
		String token = request.getParameter("token");//token是身份验证令牌，可以在软件互联平台中跳转到ISV App时的URL参数中取得
		String sip_sessionid = request.getSession(true).getId();//在ISV应用中用户会话唯一标识
		String sip_appkey = "28052";//软件互联平台分配给ISV应用的唯一编号
		String sip_apiname = "alisoft.getUsingUser";//API名称
		String sip_appsecret = "b3a79260434d11deae718c0bea828c3d";//当前应用的安全编码
		String sip_timestamp = SIP_TIMESTAMP_FORMATER.format(new Date());//服务请求时间戳(yyyy-mm-dd hh:mi:ss)
		Map<String, String> map = new HashMap<String, String>();// 输入各个参数
		map.put("token", token);
		map.put("appId", appId);
		map.put("userId", userId);
		map.put("appInstanceId", appInstanceId);
		map.put("sip_sessionid", sip_sessionid);
		map.put("sip_appkey", sip_appkey);
		map.put("sip_appsecret", sip_appsecret);
		map.put("sip_apiname", sip_apiname);
		map.put("sip_timestamp", sip_timestamp);
		//签名,生成sip_sign参数,SignatureUtil是下载中心中sip-sdk-for-java-1.0.jar中的一个类,ISV可以将包下载上来,加载到工程中
		String sign = SignatureUtil.Signature(map, map.get("sip_appsecret"));
		map.put("sip_sign", sign);

		//组织要提交的参数
		String queryString = organizeParams(map).toString();

		String sipUrl ="http://sipdev.alisoft.com/sip/rest";
		/**
		 *目前阿里软件的服务集成平台（SIP）的接口
		 *测试地址是：http://sipdev.alisoft.com/sip/rest，软件测试开发调用
				 *正式环境地址是：http://sip.alisoft.com/sip/rest,软件发布上线后调用。
				 *这里使用正式环境URL,测试环境使用http://sipdev.alisoft.com/sip/rest。
		 **/
		try {
			HttpURLConnection conn = (HttpURLConnection) new URL(sipUrl).openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.connect();
			conn.getOutputStream().write(queryString.getBytes());
			String charset = this.getChareset(conn.getContentType());
			BufferedReader reader = new BufferedReader(new InputStreamReader(
			 conn.getInputStream(), charset));// 设置编码
			StringBuffer outbuffer = new StringBuffer();
			String line = null;
			while ((line = reader.readLine()) != null) {
				outbuffer.append(line);
			}
			reader.close();
			// 解析接口返回值
			code = conn.getHeaderField("sip_status");// 返回的状态码
			conn.disconnect();
			result = outbuffer.toString();// 返回内容
			//<?xml version="1.0" encoding="utf-8"?><SimpleUserInfo-array>  <SimpleUserInfo>    <userId>25205527</userId>    <userName>yuguangtao77</userName>  </SimpleUserInfo></SimpleUserInfo-array>
		} catch (Exception e) {
			e.printStackTrace();
		}
//		String url = "/jsp/info/failure.jsp?userId="+userId+"&appInstanceId="+appInstanceId+"&token="+token+"&message="+message+"&sip_appkey="+sip_appkey+"&sip_apiname="+sip_apiname+"&sip_timestamp="+sip_timestamp+"&sip_sign="+sign;
//		if (result != null) {
//			// 请求返回的status为成功状态
//			if ("9999".equals(code)) {
//				// 解析返回的结果result,确定用户的身份
//				String value = result.substring(result.indexOf("<String>") + 8, result.indexOf("</String>"));
//				//只有1或0，表示调用成功
//				if("1".equals(value) || "0".equals(value)) {
//					//免登陆通过业务逻辑
//					String member="admin"+userId;
//					try
//					{
//					if(!Profile.isExisted(member)){
//						Profile.createProfileAndRole(member,"Home","管理员","OA","/360/","1234",true);
//					}
//
//						HttpSession session = request.getSession(true);
//						OnlineList ol_obj = OnlineList.find(session.getId()); //添加到用户临时表中
//						Profile p = Profile.find(member);
//						RV rv = new RV(member);
//						ol_obj.setMember(member);
//						session.setAttribute("tea.RV",rv); //创建用户登陆 session
//						session.setAttribute("LoginId",member);
//						session.setAttribute("password",p.getPassword());
//					} catch(SQLException ex)
//					{
//						ex.getStackTrace();
//					}
//					url = "/jsp/admin/index.jsp";
//				}
//				message = returnMessage(value);
//			} else {
//				message = returnMessage(code);
//			}
//		} else {
//			message="未知异常";
//		}
//		response.setContentType("text/html;charset=gbk");
//
//		response.sendRedirect(url);

	}

	/**
	 * 根据传入的值，返回相应的message
	 * @param code
	 * @return
	 */
	private String returnMessage(String code) {
		@SuppressWarnings("unused")
		String message;
		switch (Integer.valueOf(code)) {
			case 1: message="应用的订购者"; break;
			case 0: message="应用的使用者"; break;
			case -1: message="尚未订购该应用"; break;
			case -2: message="非法用户"; break;
			case -3: message="没有订购"; break;
			case -4: message="订阅了多个，不明确"; break;
			case 1001: message="签名无效"; break;
			case 1002: message="请求已过期"; break;
			case 1004: message="需要绑定用户"; break;
			case 1005: message="需要提供appid"; break;
			case 1006: message="需要提供服务名"; break;
			case 1007: message="需要提供签名"; break;
			case 1008: message="需要提供时间戳"; break;
			case 1010: message="无权访问服务"; break;
			case 1011: message="服务不存在"; break;
			case 1012: message="需要提供SessionId"; break;
			case 1013: message="需要提供用户名"; break;
			case 1014: message="回调服务不存在"; break;
			case 1015: message="AppKey不存在"; break;
			case 1016: message="服务次数超过限制"; break;
			case 1017: message="服务请求过于频繁"; break;
			case 1018: message="登录请求URL过长"; break;
			case 1019: message="ISP请求IP非法"; break;
			case 1020: message="请求参数值长度溢出"; break;
			case 1021: message="isp处理请求失败"; break;
			default: message="未知异常";
		}
		return message;
	}

	/**
	 * 组织要提交的参数
	 * @param map
	 * @return
	 */
	private StringBuffer organizeParams(Map<String, String> map) {
		StringBuffer buffer = new StringBuffer();
		boolean notFirst = false;
		for (Map.Entry<String, ?> entry : map.entrySet()) {
			if (notFirst) {
				buffer.append("&");
			} else {
				notFirst = true;
			}
			Object value = entry.getValue();
			buffer.append(entry.getKey()).append("=").append(encodeURL(value));
		}
		return buffer;
	}

	/**
	 * 编码格式
	 * @param contentType
	 * @return
	 */
	private String getChareset(String contentType) {
		int i = contentType == null ? -1 : contentType.indexOf("charset=");
		return i == -1 ? "GBK" : contentType.substring(i + 8);// UTF-8
	}

	/**
	 * URL编码
	 *
	 * @param target
	 * @return
	 */
	private String encodeURL(Object target) {
		String result = (target != null) ? target.toString() : "";
		try {
			result = URLEncoder.encode(result, "gbk");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return result;
	}

}
