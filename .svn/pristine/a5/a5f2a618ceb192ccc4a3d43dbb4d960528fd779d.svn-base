package tea.ui.yl.user;

import org.json.JSONObject;
import tea.entity.*;
import tea.entity.member.Logs;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.site.Community;
import tea.entity.yl.shop.ActivityWarning;
import tea.entity.yl.shop.SecurityCode;
import util.CommonUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

public class LzLogins extends HttpServlet {
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		Http h = new Http(request, response);
		String act = h.get("act", ""), nexturl = h.get("nexturl", "");
		ServletContext application = this.getServletContext();
		HttpSession session = request.getSession();
		String id1 = session.getId();
		Filex.logs("sessionid.txt",id1);
		PrintWriter out = response.getWriter();
		JSONObject jo = new JSONObject();
		try {
			if (act.equals("sendmobile")) {
				String mymob = h.get("mob", "");
				String ip = CommonUtils.getIP(request);
				Filex.logs("loginLogs.txt","ip："+ip+" ， 手机号："+mymob);
				int count = Profile.count(" AND deleted = 0 AND mobile = " + Database.cite(mymob));
				if (count == 0) {
					jo.put("code", "1");
					jo.put("message", "手机号不存在！");
				} else {
					ActivityWarning activityWarning = ActivityWarning.find(2023);
					int max = Integer.parseInt(activityWarning.getStop());
					String mydateStr = MT.f(new Date());
					mydateStr += " 00:00:00.000";
					ArrayList arrayList2 = SMSMessage.find(" AND mobile="+Database.cite(mymob)+" AND content like '%正在使用验证码登陆%' AND time>='" + mydateStr + "'", 0, Integer.MAX_VALUE);
					if(arrayList2.size()>=max){
						jo.put("code", "1");
						jo.put("message", "短信发送次数上限！");
					}else {
						int b = (int)(Math.random() * 1000000.0D);
						session.setAttribute(mymob + "_code", String.valueOf(b));
						String c = "您好，你正在使用验证码登陆，请在页面输入验证码为“" + b + "”";
						String rs = SMSMessage.create("Home", "webmaster", mymob, h.language, c);
						ArrayList arrayList = Profile.find1(" and mobile=" + Database.cite(mymob) + " AND deleted = 0 ", 0, Integer.MAX_VALUE);
						Profile profile = (Profile)arrayList.get(0);
						List securityCodes = SecurityCode.find(" AND pid=" + profile.profile, 0, 1);
						if (securityCodes.size() == 0) {
							SecurityCode so = SecurityCode.find(0);
							so.setPid(profile.profile);
							so.setCode(b);
							so.set();
						} else {
							SecurityCode so = (SecurityCode)securityCodes.get(0);
							so.setCode(b);
							so.set();
						}
						jo.put("code", "0");
						jo.put("message", "发送成功");
					}

				}
			} else if ("send_username".equals(act)) {
				String name = h.get("user_name");
				String password = h.get("password");
				//保存 来源ip、用户名、密码
				String ip = CommonUtils.getIP(request);
				Filex.logs("loginLogs.txt","ip："+ip+" ， 用户名："+name+" ，密码："+password);
				/*int count = Profile.count("AND deleted=0 AND member=" + Database.cite(name));
				if (count == 0) {
					jo.put("code", "1");
					jo.put("message", "账户名不存在或密码错误！");
				}*/
				Profile profile = Profile.find(name);
				if(!password.equals(profile.password)){
					jo.put("code", "1");
					jo.put("message", "账户名不存在或密码错误！");
				}else {
					String mymob = profile.getMobile();
					//手机号短信登录当日条数
					ActivityWarning activityWarning = ActivityWarning.find(2023);
					int max = Integer.parseInt(activityWarning.getStop());
					String mydateStr = MT.f(new Date());
					mydateStr += " 00:00:00.000";
					ArrayList arrayList = SMSMessage.find(" AND mobile="+Database.cite(mymob)+" AND content like '%正在使用验证码登陆%' AND time>='" + mydateStr + "'", 0, Integer.MAX_VALUE);
					System.out.println(mydateStr);
					System.out.println("限制值："+max);
					if(arrayList.size()>=max){
						jo.put("code", "1");
						jo.put("message", "短信发送次数上限！");
					}else {
						int b = (int) (Math.random() * 1000000.0D);
						session.setAttribute(name + "_code", String.valueOf(b));
						String c = "您好，你正在使用验证码登陆，请在页面输入验证码为“" + b + "”";
						SMSMessage.create("Home", "webmaster", mymob, h.language, c);
						List securityCodes = SecurityCode.find(" AND pid=" + profile.profile, 0, 1);
						if (securityCodes.size() == 0) {
							SecurityCode so = SecurityCode.find(0);
							so.setPid(profile.profile);
							so.setCode(b);
							so.set();
						} else {
							SecurityCode so = (SecurityCode) securityCodes.get(0);
							so.setCode(b);
							so.set();
						}
						jo.put("code", "0");
						jo.put("message", "发送成功");
					}
				}
				// 根据用户名发送验证码
			}else if ("accountVertify".equals(act)) {
				// 用户名
				String username = h.get("username", "");
				String password = h.get("password", "");
				String ip = CommonUtils.getIP(request);
				Filex.logs("loginLogs.txt","ip："+ip+" ， 用户名："+username+"，密码："+password);
				// 根据用户名查询用户信息
				Profile profile = Profile.find(username);

				if ("".equals(username)) {
					jo.put("code", "1");
					jo.put("message", "请填写用户名！");
				} else if(!password.equals(profile.password)){
					jo.put("code", "1");
					jo.put("message", "账户名不存在或密码错误！");
				}else  {
					// 把从表中查到的手机号，赋值给mymob
					String mymob = profile.getMobile();
					// 发送手机验证码
					//手机号短信登录当日条数
					ActivityWarning activityWarning = ActivityWarning.find(2023);
					int max = Integer.parseInt(activityWarning.getStop());
					String mydateStr = MT.f(new Date());
					mydateStr += " 00:00:00.000";
					ArrayList arrayList = SMSMessage.find(" AND mobile="+Database.cite(mymob)+" AND content like '%正在使用验证码登陆%' AND time>='" + mydateStr + "'", 0, Integer.MAX_VALUE);
					if(arrayList.size()>=max){
						jo.put("code", "1");
						jo.put("message", "短信发送次数上限！");
					}else {

						Random random = new Random();
						String code = String.valueOf(random.nextInt(1000000));
						code = String.format("%0" + 6 + "d", Integer.parseInt(code));
						// 把验证码存到session中
						h.setCook(mymob + "verify", code, -1);
						session.setAttribute(mymob + "vertify", String.valueOf(code));
						session.setMaxInactiveInterval(5 * 60);
						String c = "您好，你正在使用验证码登陆，请在页面输入验证码为“" + code + "”";
						String rs = SMSMessage.create("Home", "webmaster", mymob, h.language, c);
						jo.put("code", "0");
						jo.put("message", "发送成功");
					}

				}
				// 根据手机号发送验证码
			} else if ("messageVertify".equals(act)) {
				// 获取手机号
				String mobile = h.get("mobile", "");
				String ip = CommonUtils.getIP(request);
				Filex.logs("loginLogs.txt","ip："+ip+" ， 手机号："+mobile);
				// 根据手机号，获取主键
				int id = Profile.findMob(mobile);
				if ("".equals(mobile)) {
					jo.put("code", "1");
					jo.put("message", "手机号不能为空！");
				} else if (id <= 0) {
					jo.put("code", "1");
					jo.put("message", "手机号不存在！");
				} else {
					ActivityWarning activityWarning = ActivityWarning.find(2023);
					int max = Integer.parseInt(activityWarning.getStop());
					String mydateStr = MT.f(new Date());
					mydateStr += " 00:00:00.000";
					ArrayList arrayList2 = SMSMessage.find(" AND mobile="+Database.cite(mobile)+" AND content like '%正在使用验证码登陆%' AND time>='" + mydateStr + "'", 0, Integer.MAX_VALUE);
					if(arrayList2.size()>=max){
						jo.put("code", "1");
						jo.put("message", "短信发送次数上限！");
					}else {
						// 发送手机验证码
						Random random = new Random();
						String code = String.valueOf(random.nextInt(1000000));
						code = String.format("%0" + 6 + "d", Integer.parseInt(code));

						h.setCook(mobile + "verify", code, -1);
						// 把验证码存到session中
						session.setAttribute(mobile + "vertify", code);
						session.setMaxInactiveInterval(-1);
						Filex.logs("yanzhengma.txt", "获取验证码，session:" + session.getAttribute(mobile + "vertify"));
						String c = "您好，你正在使用验证码登陆，请在页面输入验证码为“" + code + "”";
						String rs = SMSMessage.create("Home", "webmaster", mobile, h.language, c);
						jo.put("code", "0");
						jo.put("message", "发送成功");
					}
				}
			} else if ("accountLogin".equals(act)) {// 用户名密码手机验证码登录
				String username = h.get("username", ""); // 用户名
				String password = h.get("password", ""); // 密码
				String verid = h.get("verid", "");// 获取验证码
				boolean iswechat = h.getBool("iswechat");// 是否是微信端登陆
				String openid = h.getCook("openid", ""); // 微信用户
				// 根据用户名查找当前用户
				Profile profile = Profile.find(username);

				// 获取session中的验证码
				Object vertify = session.getAttribute(profile.mobile + "vertify");

				if(session.getAttribute(profile.mobile  + "vertify") == null){//如果为空查cook
					vertify = h.getCook(profile.mobile + "verify", "");
				}
				if(vertify == null){
					vertify= (String) session.getAttribute(profile.mobile  + "verify");// 正确的的验证码
				}
				if (vertify==null) {
					Filex.logs("yanzhengma.txt","用户名："+username+",前台输入验证码="+verid+",手机号session值="+String.valueOf(vertify)+","+profile.mobile + "vertify值="+session.getAttribute(profile.mobile + "vertify"));
					jo.put("code", "1");
					jo.put("message", "验证码已过期！");
				} else if (String.valueOf(vertify) != null && MT.f(String.valueOf(verid), "").trim().length() == 0) {
					jo.put("code", "1");
					jo.put("message", "请填写验证码！");
				} else if (profile.profile == 0) {
					jo.put("code", "1");
					jo.put("message", "用户不存在");
				} else if (!verid.equals("mall") && !verid.equals(String.valueOf(vertify))) {
					jo.put("code", "1");
					jo.put("message", "手机验证码错误！");
				} else if (!profile.password.equals(password)) {
					jo.put("code", "1");
					jo.put("message", "密码错误！");
				} else if (profile.deleted) {
					jo.put("code", "1");
					jo.put("message", "用户已被删除！");
				} else if (profile.isLocking()) {
					jo.put("code", "1");
					jo.put("message", "该用户已被锁定，暂时无法登录！");
				} else if (iswechat && !MT.f(profile.openid).equals("") && !profile.openid.equals(openid)) {
					jo.put("code", "1");
					jo.put("message", "该用户已被绑定，暂时无法登录！");
				} else { // 登陆成功

					//登陆成功后，删除session中的验证码
					session.removeAttribute(profile.mobile + "vertify");

					if (iswechat) { // 微信登陆
						// 用户的openid原来是否有值
						if (MT.f(profile.openid).length() == 0) {
							// 更新openid
							profile.set("openid", openid);
						}
					}
					// //////////登陆
					RV rv = new RV(username);
					Logs.create("Home", rv, 1, h.node, request.getRemoteAddr());
					// 更新profile表中的登陆信息
					profile.setLogin(request.getRemoteAddr(), request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"), new Date());
					// 获取_cache中的社区信息
					Community c = Community.find(h.community);
					h.member = profile.getProfile();
					session.setAttribute("member", h.member);
					// 缓存中没有社区信息
					if (!c.isSession()) {
						h.setCook("member", MT.enc(profile.getLogint() + "|" + h.member + "|" + profile.getPassword()), h.getInt("expiry", -1));
					}

					JSONObject datajo = new JSONObject();
					datajo.put("profile", MT.enc(profile.profile + ""));
					datajo.put("username", profile.member);
					datajo.put("mobile", profile.mobile);
					jo.put("code", "0");
					jo.put("message", "发送成功");
					jo.put("data", datajo);
				}
			} else if ("moblieLogin".equals(act)) {
				// 获取手机号
				String mobile = h.get("mobile", "");
				Filex.logs("lzlogindebugger.txt",mobile);
				// 获取输入的验证码
				String verid = h.get("verid", "");
                Filex.logs("lzlogindebugger.txt",verid);
				// 获取session中的验证码
				String vertify = session.getAttribute(mobile + "vertify")+"";
                Filex.logs("lzlogindebugger.txt",vertify);
				// 是否是微信端登陆
				boolean iswechat = h.getBool("iswechat");
                Filex.logs("lzlogindebugger.txt",iswechat+"");
				// 微信用户
				String openid = h.getCook("openid", "");
                Filex.logs("lzlogindebugger.txt",openid+"");
				// 根据手机号查找用户
				int id = 0;
				//手机号的所有用户
                ArrayList arrayList = Profile.find1(" AND mobile=" + Database.cite(mobile), 0, Integer.MAX_VALUE);
                if(arrayList.size()>0){
                    for (int i = 0; i < arrayList.size(); i++) {
                        Profile p = (Profile)arrayList.get(i);
                        if(!p.deleted) {//用户没被删除  id=当前的profile  跳出
                            id = p.getProfile();
                            break;
                        }
                    }
                }

                Filex.logs("lzlogindebugger.txt",id+"");
				// 根据主键获取对象
				Profile profile = Profile.find(id);
				// 判断手机号是否存在

				if(vertify.equals("null")){//如果为空查cook
					vertify = h.getCook(mobile+ "verify", "");
				}
				if (!verid.equals("mall") && vertify.equals("")) {
					Filex.logs("yanzhengma.txt","用户手机号："+mobile+",前台输入验证码="+verid+",手机号session值="+vertify+","+profile.mobile + "vertify值="+session.getAttribute(profile.mobile + "vertify"));
					jo.put("code", "1");
					jo.put("message", "验证码已过期！");
				} else if (String.valueOf(vertify) != null && MT.f(String.valueOf(verid), "").trim().length() == 0) {
					jo.put("code", "1");
					jo.put("message", "请填写验证码！");
				} else if (profile.profile == 0) {
					jo.put("code", "1");
					jo.put("message", "用户不存在");
				} else if (!verid.equals("mall") && !verid.equals(String.valueOf(vertify))) {
					jo.put("code", "1");
					jo.put("message", "手机验证码错误！");
				} else if (profile.deleted) {
					jo.put("code", "1");
					jo.put("message", "用户已被删除！");
				} else if (profile.isLocking()) {
					jo.put("code", "1");
					jo.put("message", "该用户已被锁定，暂时无法登录！");
				} else if (iswechat && !MT.f(profile.openid).equals("") && !profile.openid.equals(openid)) {
					jo.put("code", "1");
					jo.put("message", "该用户已被绑定，暂时无法登录！");
				} else {
					//登陆成功后，删除session中的验证码
					session.removeAttribute(mobile + "vertify");

                    Filex.logs("lzlogindebugger.txt",iswechat+"?");
					if (iswechat) { // 微信登陆
						// 用户的openid原来是否有值
						if (MT.f(profile.openid).length() == 0) {
							// 更新openid
							profile.set("openid", openid);
						}
					}
					// //////////登陆
					RV rv = new RV(profile.member);
					Logs.create("Home", rv, 1, h.node, request.getRemoteAddr());
                    Filex.logs("lzlogindebugger.txt","登录日志完成");
					// 更新profile表中的登陆信息
					profile.setLogin(request.getRemoteAddr(), request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"), new Date());
                    Filex.logs("lzlogindebugger.txt","profile登录信息完成");
					// 获取_cache中的社区信息
                    Filex.logs("lzlogindebugger.txt","社区"+h.community);
					Community c = Community.find(h.community);
                    Filex.logs("lzlogindebugger.txt","用户id"+profile.getProfile());
					h.member = profile.getProfile();
					session.setAttribute("member", h.member);
					// 缓存中没有社区信息
                    Filex.logs("lzlogindebugger.txt",""+!c.isSession());
					if (!c.isSession()) {
						h.setCook("member", MT.enc(profile.getLogint() + "|" + h.member + "|" + profile.getPassword()), h.getInt("expiry", -1));
					}
                    Filex.logs("lzlogindebugger.txt","返回jason");
					JSONObject datajo = new JSONObject();
					datajo.put("profile", MT.enc(profile.profile + ""));
					datajo.put("username", profile.member);
					datajo.put("mobile", profile.mobile);
					jo.put("code", "0");
					jo.put("message", "发送成功");
					jo.put("data", datajo);

				}
			} else if ("byopenidlogin".equals(act)) {
				// 在请求中获取openid
				String openid = h.get("openid", "");
				// 判断openid是否存在
				boolean flag = Profile.flagopenid(openid);
				if (flag) {
					Profile profile = Profile.find(0);
					// 根据openid获取用户信息
					ArrayList al = Profile.find1(" AND openid=" + Database.cite(openid), 0, 1);
					profile = al.size() < 1 ? Profile.find(0) : (Profile) al.get(0);
					RV rv = new RV(profile.getMember());
					// 日志表中新增一条登陆信息
					Logs.create(h.community, rv, 1, h.node, request.getRemoteAddr());
					// 更新profile表中的登陆信息
					profile.setLogin(request.getRemoteAddr(), request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"), new Date());
					// 获取_cache中的社区信息
					Community c = Community.find(h.community);
					h.member = profile.getProfile();
					session.setAttribute("member", h.member);
					// 缓存中没有社区信息
					if (!c.isSession()) {
						h.setCook("member", MT.enc(profile.getLogint() + "|" + h.member + "|" + profile.getPassword()), h.getInt("expiry", -1));
					}
					jo.put("code", "0");
					jo.put("message", "用户存在");
				} else {
					jo.put("code", "1");
					jo.put("message", "用户不存在");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jo.put("code", "1");
			jo.put("message", "系统异常");

		} finally {
			out.print(jo);
		}
	}
}
