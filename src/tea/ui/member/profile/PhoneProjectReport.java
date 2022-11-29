package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bouncycastle.util.encoders.Base64Encoder;
import org.json.JSONArray;
import org.json.JSONException;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import sun.misc.BASE64Decoder;
import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.activity.Partake;
import tea.entity.helpinfo.VipUser;
import tea.entity.lvyou.ProfileLvyou;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.site.Site;
import tea.entity.weixin.WeiXin;
import tea.entity.weixin.WxUser;

/**
 * @author mall
 * @category 手机版的验证
 */
public class PhoneProjectReport extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Http h = new Http(request, response);
		String act = h.get("act"), nexturl = h.get("nexturl", "");
		String yming = request.getServerName();
		ServletContext application = this.getServletContext();
		String format = h.get("format");
		response.setContentType("json".equals(format) ? "application/json; charset=UTF-8"
				: "text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if ("openid".equals(act)) { // 访问微信，回转后进入openid2，获取openid
			try {
				WeiXin weiXin = WeiXin.find(h.community);
				nexturl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="
						+ weiXin.appid[1]
						+ "&redirect_uri="
						+ Http.enc("http://" + yming
								+ "/PhoneProjectReport.do?act=openid2&nexturl="
								+ Http.enc(nexturl))
						+ "&response_type=code&scope="
						+ h.get("scope", "snsapi_userinfo")
						+ "&state=STATE#wechat_redirect";
				response.sendRedirect(nexturl);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("openid2".equals(act)) { // 回调，获取openid
			try {
				WeiXin weiXin = WeiXin.find(h.community);
				String openid = h.getCook("openid", ""), token = h.getCook(
						"token", "");
				String useropenid = "";
				byte[] by = (byte[]) Http.open(
						"https://api.weixin.qq.com/sns/oauth2/access_token?appid="
								+ weiXin.appid[1] + "&secret="
								+ weiXin.appsecret[1] + "&code="
								+ h.get("code")
								+ "&grant_type=authorization_code", null);
				String str = new String(by);
				Filex.logs("openid_code.txt", str);
				JSONObject jo = JSON.parseObject(str);
				openid = jo.getString("openid");
				token = jo.getString("access_token");
				// 获取access_coken后，获取当前用户的照片
				byte[] by2 = (byte[]) Http.open(
						"https://api.weixin.qq.com/sns/userinfo?access_token="
								+ token + "&openid=" + openid + "&lang=zh_CN",
						null);
				String str2 = new String(by2, "UTF-8");
				JSONObject jo2 = JSON.parseObject(str2);
				String headimgurl = jo2.getString("headimgurl");
				String nickname = jo2.getString("nickname");

				// 获取指定的Access_Token
				String str4 = (String) Http.open(
						"https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="
								+ weiXin.appid[1] + "&secret="
								+ weiXin.appsecret[1], null);
				JSONObject jo4 = JSON.parseObject(str4);

				String str3 = (String) Http.open(
						"https://api.weixin.qq.com/cgi-bin/user/info?access_token="
								+ jo4.getString("access_token") + "&openid="
								+ openid + "&lang=zh_CN", null);
				JSONObject jo3 = JSON.parseObject(str3);
				useropenid = openid;
				openid = jo3.getString("unionid");

				WxUser wx = WxUser.find(useropenid.equals("") ? openid
						: useropenid);
				wx.community = h.community;
				wx.nickname = nickname;
				wx.avatar = headimgurl;
				wx.set();
				h.setCook("headimgurl", headimgurl, Integer.MAX_VALUE);
				if (!useropenid.equals("")) {
					h.setCook("useropenid", useropenid, Integer.MAX_VALUE);
				}
				h.setCook("openid", openid, -1);
				h.setCook(h.community + "useropenid", useropenid,
						Integer.MAX_VALUE);
				h.setCook("nickname", nickname, -1);
				response.sendRedirect(nexturl);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if (act.equals("qy")) { // 企业号
			try {
				String code = h.get("code"); // 获取code
				int agentid = h.getInt("agentid"); // 应用Id
				WeiXin weiXin = WeiXin.find(h.community);

				if (code == null) {
					nexturl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="
							+ weiXin.appid[2]
							+ "&redirect_uri="
							+ Http.enc("http://" + yming
									+ "/PhoneProjectReport.do?act=qy&agentid="
									+ agentid + "&nexturl=" + Http.enc(nexturl))
							+ "&response_type=code&scope="
							+ h.get("scope", "snsapi_base")
							+ "&state=STATE#wechat_redirect";
					response.sendRedirect(nexturl);
					return;
				}
				// 获取Access_Token
				String access_token = getAccess_token(h.community, code);

				// 获取企业号成员信息
				String str2 = (String) Http.open(
						"https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token="
								+ access_token + "&code=" + code + "&agentid="
								+ agentid, null);

				JSONObject jo2 = JSON.parseObject(str2);
				String userid = jo2.getString("UserId");

				// 获取UserId后，获取用户头像
				String str3 = (String) Http.open(
						"https://qyapi.weixin.qq.com/cgi-bin/user/get?access_token="
								+ access_token + "&userid=" + userid, null);
				JSONObject jo3 = JSON.parseObject(str3);
				String headimgurl = jo3.getString("avatar");
				h.setCook("headimgurl", headimgurl, -1);
				h.setCook("userid", MT.enc(userid), -1);
				boolean flag = Profile.findUserIds(userid, h.community);
				if (flag) {
					Profile p = Profile.findbyUserId(userid, h.community);
					request.getSession().setAttribute("member", p.getProfile());
					h.member = p.getProfile();
					h.setCook(
							"member",
							MT.enc(p.getLogint() + "|" + p.getMember() + "|"
									+ p.getPassword()), -1);// edn2
					p.setPhotopath2(headimgurl, h.language);
					response.sendRedirect("http://" + yming + nexturl);
				} else {
					Profile profile = Profile.find(userid);
					if (profile.getProfile() > 0) {
						Profile.updateUserid(userid, profile.getProfile());

						request.getSession().setAttribute("member",
								profile.getProfile());
						h.setCook(
								"member",
								MT.enc(profile.getLogint() + "|"
										+ profile.getMember() + "|"
										+ profile.getPassword()), -1);// edn2
						profile.setPhotopath2(headimgurl, h.language);
						response.sendRedirect("http://" + yming + nexturl);
					} else {
						out.print("<script>alert('用户不存在');</script>");
						response.sendRedirect("/jsp/notuser.html");
					}
				}
			} catch (Exception e) {

			}
		} else if (act.equals("sendText")) { // 企业号发送消息
			try {
				String text = h.get("text", "");
				String senduser = h.get("senduser", "");
				int agentid = h.getInt("agentid");
				String url = h.get("url", ""); // 访问路径
				String texturl = "";
				if (!url.equals("")) {
					texturl = "  <a href='" + url + "'>点击查看</a>";
				}
				JSONArray jsonArray = new JSONArray();
				Map<String, Object> map = new HashMap<String, Object>();
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("content", text + texturl);

				map.put("touser", senduser); // 接收用户
				map.put("msgtype", "text");// 发送类型
				map.put("agentid", agentid); // 应用id
				map.put("text", map2); // 发送文本
				map.put("safe", "0");// 表示是否是保密消息，0表示否，1表示是，默认0
				jsonArray.put(map);
				Filex.logs("sendText.txt", jsonArray.get(0).toString());
				String community = h.get("community", "");
				if (community.equals("")) {
					community = h.getCook("community", "Home");
				}

				WeiXin wx = WeiXin.find(community);
				String str = (String) Http.open(
						"https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid="
								+ wx.appid[2] + "&corpsecret="
								+ wx.appsecret[2], null);
				org.json.JSONObject jo = new org.json.JSONObject(str);
				String access_token = jo.getString("access_token");
				Object[] obj = Http.open(
						"https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token="
								+ access_token, null, jsonArray.get(0)
								.toString());
				for (int i = 0; i < obj.length; i++) {
					if (obj[i] == null)
						continue;
					Filex.logs("maluole.txt", "=======Obj" + obj[i]);
					org.json.JSONObject jo3 = new org.json.JSONObject(
							(String) obj[i]);
					Filex.logs("maluole.txt",
							"=======Error" + jo3.getInt("errcode"));
					return;
				}

			} catch (Exception e) {
			}
		} else if (act.equals("sendTextUrl")) { // 企业号发送消息
			try {
				String text = h.get("text", "");
				String senduser = h.get("senduser", "");
				int agentid = h.getInt("agentid");
				BASE64Decoder decode = new BASE64Decoder();
				String url = new String(decode.decodeBuffer(h.get("url", ""))); // 访问路径
				String texturl = "";
				if (!url.equals("")) {
					texturl = "  <a href='" + url + "'>点击这里访问</a>";
				}
				JSONArray jsonArray = new JSONArray();
				Map<String, Object> map = new HashMap<String, Object>();
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("content", text + texturl);

				map.put("touser", senduser); // 接收用户
				map.put("msgtype", "text");// 发送类型
				map.put("agentid", agentid); // 应用id
				map.put("text", map2); // 发送文本
				map.put("safe", "0");// 表示是否是保密消息，0表示否，1表示是，默认0
				jsonArray.put(map);
				Filex.logs("sendText.txt", jsonArray.get(0).toString());
				String community = h.getCook("community", "Home");
				WeiXin wx = WeiXin.find(community);
				String str = (String) Http.open(
						"https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid="
								+ wx.appid[2] + "&corpsecret="
								+ wx.appsecret[2], null);
				org.json.JSONObject jo = new org.json.JSONObject(str);
				String access_token = jo.getString("access_token");
				Http.open(
						"https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token="
								+ access_token, null, jsonArray.get(0)
								.toString());
			} catch (Exception e) {
			}
		} else if (act.equals("mobilevier")) {
			try {
				// 发送手机验证码
				StringBuffer sp = new StringBuffer();
				String mobile = h.get("mobile");
				if (VipUser.isMobile(mobile, h.community)) {
					// 如果存在
					sp.append("t");
				} else {
					// 发送手机验证码
					int b = (int) (Math.random() * 1000000);
					request.getSession().setAttribute(mobile + "_code",
							String.valueOf(b));
					String c = "为确保您的个人信息安全，需对您的手机号进行验证，本次验证码为：" + b
							+ "。如非本人操作请忽略。";
					Date date = new Date();// 取时间
					Calendar calendar = new GregorianCalendar();
					calendar.setTime(date);
					calendar.add(calendar.DATE, 1);// 把日期往后增加一天.整数往后推,负数往前移动
					date = calendar.getTime(); // 这个时间就是日期往后推一天的结果
					SimpleDateFormat formatter = new SimpleDateFormat(
							"yyyy-MM-dd");
					String dateString = formatter.format(date);
					String today = formatter.format(new Date());
					if (SMSMessage.count(" and mobile="
							+ DbAdapter.cite(mobile) + " and time>="
							+ DbAdapter.cite(today) + " and time<"
							+ DbAdapter.cite(dateString)) >= 5) {
						out.print("over");
						return;
					}

					SMSMessage.create818(h.community, "14090001", mobile,
							h.language, c);
					sp.append(b);
				}
				out.print(sp);
				return;
			} catch (Exception e) {

			}
		} else if (act.equals("sendMessage")) { // 发送短信
			String mobile = h.get("mobile"); // 手机号
			String c = h.get("context"); // 内容
			String commmunity = h.community;
			if (MT.f(commmunity).length() == 0) {
				commmunity = h.getCook("community", "Home");
			}
			try {
				Date date = new Date();// 取时间
				Calendar calendar = new GregorianCalendar();
				calendar.setTime(date);
				calendar.add(calendar.DATE, 1);// 把日期往后增加一天.整数往后推,负数往前移动
				date = calendar.getTime(); // 这个时间就是日期往后推一天的结果
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				String dateString = formatter.format(date);
				String today = formatter.format(new Date());
				if (SMSMessage.count(" and mobile=" + DbAdapter.cite(mobile)
						+ " and time>=" + DbAdapter.cite(today) + " and time<"
						+ DbAdapter.cite(dateString)) >= 5) {
					out.print("over");
					return;
				}
				SMSMessage.create818(commmunity, "14090001", mobile,
						h.language, c);
			} catch (SQLException e) {
			}
		} else if (act.equals("addqyuser")) { // 添加企业号用户

			try {
				int profile = Integer.parseInt(MT.dec(h.get("profile")));
				Profile p = Profile.find(profile);
				String token = getAccess_token(h.community, "");
				JSONArray jsonArray = new JSONArray();
				Map<String, Object> map = new HashMap<String, Object>();

				map.put("userid", p.member);// 账号Id
				map.put("name", p.getName(h.language));// 名字
				map.put("mobile", p.mobile); // 手机号
				map.put("weixinid", p.getWxcode());// 微信Id
				map.put("department",
						(p.getQydept() == 0 ? "1" : p.getQydept())); // 部门

				jsonArray.put(map);

				Object[] obj = Http.open(
						"https://qyapi.weixin.qq.com/cgi-bin/user/create?access_token="
								+ token, null, jsonArray.get(0).toString());
				for (int i = 0; i < obj.length; i++) {
					if (obj[i] == null)
						continue;
					org.json.JSONObject jo = new org.json.JSONObject(
							(String) obj[i]);

					out.print(jo.getInt("errcode"));
					return;
				}
				out.print("0");
				return;
			} catch (SQLException e) {
				e.printStackTrace();
				out.print("1");
			} catch (JSONException e) {
				e.printStackTrace();
				out.print("1");
			}
		} else if (act.equals("userrevice")) { // 要求用户关注

			try {
				int profile = Integer.parseInt(MT.dec(h.get("profile")));
				Profile p = Profile.find(profile);
				String token = getAccess_token(h.community, "");

				JSONArray jsonArray = new JSONArray();
				Map<String, Object> map = new HashMap<String, Object>();

				map.put("userid", p.member);// 账号Id

				jsonArray.put(map);

				Object[] obj = Http.open(
						"https://qyapi.weixin.qq.com/cgi-bin/invite/send?access_token="
								+ token, null, jsonArray.get(0).toString());
				for (int i = 0; i < obj.length; i++) {
					if (obj[i] == null)
						continue;
					org.json.JSONObject jo = new org.json.JSONObject(
							(String) obj[i]);
					out.print(jo.getInt("errcode"));
					return;
				}
				out.print("0");
				return;
			} catch (SQLException e) {
				e.printStackTrace();
				out.print("1");
			} catch (JSONException e) {
				e.printStackTrace();
				out.print("1");
			}
		} else if (act.equals("addqy")) { // 添加企业号用户

			try {
				Enumeration profileE = Profile.find(" AND community = "
						+ DbAdapter.cite(h.community)
						+ " AND (userid is null OR userid = '')", 0,
						Integer.MAX_VALUE);
				String token = getAccess_token(h.community, "");
				while (profileE.hasMoreElements()) {
					String members = (String) profileE.nextElement();
					Profile p = Profile.find(members);
					JSONArray jsonArray = new JSONArray();
					Map<String, Object> map = new HashMap<String, Object>();

					map.put("userid", p.member);// 账号Id
					map.put("name", p.getName(h.language));// 名字
					map.put("mobile", p.mobile); // 手机号
					map.put("weixinid", p.getWxcode());// 微信Id
					map.put("department",
							(p.getQydept() == 0 ? "1" : p.getQydept())); // 部门

					jsonArray.put(map);

					Http.open(
							"https://qyapi.weixin.qq.com/cgi-bin/user/create?access_token="
									+ token, null, jsonArray.get(0).toString());

					JSONArray jsonArray2 = new JSONArray();
					Map<String, Object> map2 = new HashMap<String, Object>();

					map2.put("userid", p.member);// 账号Id

					jsonArray2.put(map2);
					Http.open(
							"https://qyapi.weixin.qq.com/cgi-bin/invite/send?access_token="
									+ token, null, jsonArray2.get(0).toString());
				}
				out.print("0");
				return;

			} catch (SQLException e) {
				e.printStackTrace();
				out.print("1");
			} catch (JSONException e) {
				e.printStackTrace();
				out.print("1");
			}
		} else if (act.equals("returnpay")) { // 微信退款
			try {
				String community = h.get("community");
				WeiXin wx = WeiXin.find(community);
				int pid = h.getInt("pid");
				Partake par = Partake.find(pid);
				String pay = wx.getRefund(par.getCode(), par.getParPrice(), par
						.getParPrice(), community, getServletContext()
						.getRealPath("/"));
				out.print(pay);
			} catch (Exception e) {
			}
		}
	}

	public String getAccess_token(String community, String code) {
		String access_token = "";
		try {
			WeiXin wx = WeiXin.find(community);
			String str = (String) Http.open(
					"https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid="
							+ wx.appid[2] + "&corpsecret=" + wx.appsecret[2],
					null);
			JSONObject jo = JSON.parseObject(str);
			access_token = jo.getString("access_token");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return access_token;
	}
}
