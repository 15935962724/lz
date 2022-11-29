package tea.ui.weibo;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.net.*;
import tea.entity.*;
import tea.entity.weibo.*;
import org.json.*;
import tea.entity.member.*;
import tea.ui.TeaSession;

public class OAuth2s extends HttpServlet
{

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("text/html; charset=UTF-8");
		Http h = new Http(request, response);
		String act = h.get("act"), nexturl = h.get("nexturl", "");

		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		try
		{
			WConfig s = WConfig.find(h.community);
			//应用回调页
			String url = "http://" + request.getServerName();
			int port = request.getServerPort();
			if (port != 80)
				url += ":" + port;
			url += request.getRequestURI() + "?" + request.getQueryString();
			System.out.println(url);
			//url = "http://2012kehujie.picc.com/OAuth2s.do?community=PICC&type=1";

			//&error_uri=%2Foauth2%2Fauthorize&error=access_denied&error_description=user%20denied%20your%20request.&error_code=21330
			int err = h.getInt("error_code");
			if (err == 21330)
			{
				out.print("<script>parent.mt.close();</script>");
				return;
			}
			String code = h.get("code");
			if (code == null)
			{
				int type = h.getInt("type");

				//1.让用户输入密码
				response.sendRedirect("https://api.weibo.com/oauth2/authorize?forcelogin=true&client_id=" + s.sinakey + "&redirect_uri=" + Http.enc(url) + "&response_type=code");
			} else
			{
				url = url.substring(0, url.length() - 6 - code.length()); //去掉code参数
				//2.获得用户ID
				String str = OAuth2.oauth("https://api.weibo.com/oauth2/access_token", "client_id=" + s.sinakey + "&client_secret=" + s.sinasecret + "&grant_type=authorization_code&code=" + code + "&redirect_uri=" + Http.enc(url), null, null);
				//{"access_token":"2.00dl9XyC0vaE6Qd5a14e10f8OWfi8E","expires_in":86400,"remind_in":"18700","uid":"2726821233"}
				JSONObject o = new JSONObject(str).getJSONObject("data");
				String userid = o.getString("uid");
				String token = o.getString("access_token");
				o.getInt("expires_in");//125968
				//str = OAuth2.oauth("https://api.weibo.com/2/users/show.json?uid=" + userid, null, null, token);
				//o = new JSONObject(str);
				//String name = o.getString("name");

				//
				s.set("sinatoken", s.sinatoken = token);
				out.print("<script>var pmt=parent.mt;pmt.receive('" + token + "');pmt.close();</script>");
				//TeaSession ts = new TeaSession(request);
				//Profile p = Profile.find(ts._rv._strR);
				//if (p.getTime() != null)
				//    p = Profile.create(member, TOKEN[0], h.community, null, request.getServerName());
				//p.set(1, userid, token, null);

				//
//                byte[] by = Filex.read("D:/完美世界/QQ截图20110602160113.png");
//                str = OAuth2.oauth("https://api.weibo.com/2/statuses/upload.json", "status=" + Http.enc("D:/完美世界/QQ截图20110602160113.png"), by, token);
//                out.print(str);
//                o = new JSONObject(str);
//                if (!o.isNull("error_code"))
//                {
//                    int err = o.getInt("error_code");
//                    switch (err)
//                    {
//                    case 20019:
//                        System.out.println("重复的内容！");
//                        break;
//                    }
//                }
			}
		} catch (Throwable ex)
		{
			ex.printStackTrace();
			response.sendError(500, ex.toString());
		} finally
		{
			out.close();
		}
	}

}
