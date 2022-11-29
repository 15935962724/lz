package tea.ui.weixin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.json.JSONArray;
import sun.misc.BASE64Decoder;
import tea.entity.Database;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.weixin.WeiXin;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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
				WeiXin weiXin = WeiXin.find("Home");
				nexturl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="
						+ weiXin.appid[1]
						+ "&redirect_uri="
						+ Http.enc("http://" + yming
								+ "/PhoneProjectReport.do?act=openid2&nexturl="
								+ Http.enc(nexturl))
						+ "&response_type=code&scope="
						+ h.get("scope", "snsapi_userinfo")
						+ "&state=STATE#wechat_redirect";
				Filex.logs("gdh11.txt", nexturl);
				response.sendRedirect(nexturl);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("openid2".equals(act)) { // 回调，获取openid
			try {
				Filex.logs("gdh22.txt", "111111111");
				WeiXin weiXin = WeiXin.find("Home");
				String openid = h.getCook("openid", ""), token = h.getCook(
						"token", "");
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
//				String headimgurl = jo2.getString("headimgurl");
				String nickname = jo2.getString("nickname");
				Filex.logs("weixinname.txt", "放--"+h.getCook("nickname","")+"");
				h.setCook("openid", openid, -1);
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

				Filex.logs("qdrnexturl.txt", "nexturl="+nexturl+"--"+h.member);

				if (code == null) { 
					nexturl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" +
							weiXin.appid[2] + "&redirect_uri=" + Http.enc("http://" + yming +
									"/PhoneProjectReport.do?act=qy&agentid=" + agentid + "&nexturl="
									+ Http.enc(nexturl)) + "&response_type=code&scope=" +
									h.get("scope", "snsapi_base") + "&state=STATE#wechat_redirect";
					response.sendRedirect(nexturl); 
					return; 
				} 
				// 获取Access_Token
				String access_token = getAccess_token(h.community, code);
				
				// 获取企业号成员信息 
				String str2 = (String) Http.open(
						"https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token="
								+ access_token + "&code=" + code + "&agentid=" + agentid, null);
				
				JSONObject jo2 = JSON.parseObject(str2); 
				String userid = jo2.getString("UserId");
				Filex.logs("gdh_QY.txt", "userid="+userid);
				// 获取UserId后，获取用户头像 
				String str3 = (String) Http.open("https://qyapi.weixin.qq.com/cgi-bin/user/get?access_token=" +
						access_token + "&userid=" + userid, null); 
				JSONObject jo3 = JSON.parseObject(str3); 
				String headimgurl = jo3.getString("avatar"); 
				h.setCook("headimgurl", headimgurl, -1);
				h.setCook("userid", MT.enc(userid), -1); 
				//Profile p = Profile.getPByUserid(userid);
				Filex.logs("log_qywx/"+MT.f(new Date())+".log"," AND userid=" + userid );
				ArrayList arrayList = Profile.find1(" AND userid=" + Database.cite(userid)+" AND deleted=0 " , 0, Integer.MAX_VALUE);
				Profile p = null;
				Filex.logs("log_qywx/"+MT.f(new Date())+".log",arrayList.size()+"");
				if(arrayList.size()>0){
						p = (Profile)arrayList.get(0);
				}
				Filex.logs("log_qywx/"+MT.f(new Date())+".log","userid=="+userid);
				if (null != p) {
					Filex.logs("log_qywx/"+MT.f(new Date())+".log","p不等于null==="+p.getProfile());
					request.getSession().setAttribute("member", p.getProfile());
					h.member = p.getProfile(); 
					h.setCook( "member",MT.enc(p.getLogint() + "|" + p.getMember() + "|" + p.getPassword()), -1);
					response.sendRedirect("http://" + yming + nexturl+"&qywxMember="+p.profile);
				} else {
					Filex.logs("log_qywx/"+MT.f(new Date())+".log","p等于null");
					Profile profile = Profile.find(userid);
					Filex.logs("log_qywx/"+MT.f(new Date())+".log","profile="+profile.getProfile());
					if(profile.getProfile() > 0) {
						//保存微信中设置的账户
						profile.set("userid",userid);
						h.member = profile.getProfile();
						request.getSession().setAttribute("member",profile.getProfile()); h.setCook( "member",
								MT.enc(profile.getLogint() + "|" + profile.getMember() + "|" +
										profile.getPassword()), -1);
						
						response.sendRedirect("http://" + yming + nexturl+"&qywxMember="+profile.profile);
					} else {
						out.print("<script>document.addEventListener('WeixinJSBridgeReady',function(){WeixinJSBridge.call('closeWindow')});</script>");
						send("您未被设置为管理账户，请与管理员联系！", userid, agentid, "");
						return;
						//out.print("<script>alert('用户不存在');</script>");
						//response.sendRedirect("/jsp/notuser.html"); 
					} 
				} 
			} catch(Exception e) {
				e.printStackTrace();
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
	
	public void send(String text,String senduser,int agentid,String url){
		try {
			
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
			String community = "Home";
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
	}
}
