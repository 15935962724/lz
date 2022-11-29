package tea.ui.weblogin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.json.JSONObject;

import tea.db.DbAdapter;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.RV;
import tea.entity.member.Logs;
import tea.entity.member.Profile;
import tea.entity.site.Community;
import tea.ui.TeaSession;

public class WebLogin extends HttpServlet {

	 public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	    {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		Http h=new Http(request,response);
		TeaSession teasession=new TeaSession(request);
		HttpSession session = request.getSession();
		out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
		String act = h.get("act");
		try {
			if("qqlogin".equals(act)){
				String code=request.getParameter("code");//获取返回code
				String url = "https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id=101144312&client_secret=e7e146844650eca81ab29d0f002c0e03&code="+code+"&redirect_uri=/";
				String json_str="";
				String myurl = "";
				HttpClient client=new HttpClient();
				HttpMethod method=new GetMethod(url);//发送请求
				client.executeMethod(method);
				json_str=method.getResponseBodyAsString();//获得token 
				method.releaseConnection(); //释放连接
				
				String nurl = "https://graph.qq.com/oauth2.0/me?access_token="+json_str;//拼获取openid请求的url
				client=new HttpClient();
				method=new GetMethod(nurl);//请求获取openid
				client.executeMethod(method);
				json_str=method.getResponseBodyAsString();
				method.releaseConnection(); //释放连接
				String str = json_str.substring(json_str.indexOf("(")+1,json_str.indexOf(")"));
				JSONObject obj = new JSONObject(str);
				String openid = (String)obj.get("openid");
				String openId=openid;
				String accessToken=json_str;
				boolean flag = Profile.flagopenid(openId);
				if(flag){
					Profile mypro = Profile.qqgetmember(openId);
				    RV rv = new RV(mypro.member);
		            Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
		            //OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
		            mypro.setLogin(request.getRemoteAddr(),request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"),new Date());
		            Community c = Community.find(h.community);
		            h.member = mypro.getProfile();
		            session.setAttribute("member",h.member);
		            if(c.isSession())
		            {
		                //session.setAttribute("tea.RV",rv);
		            } else
		            {
		                h.setCook("member",MT.enc(mypro.getLogint() + "|" + h.member + "|" + mypro.getPassword()),h.getInt("expiry", -1));
		            }
				    out.print("<script>location='/html/folder/2695-1.htm';</script>");
				    //out.print("<script>location='/';</script>");
				}else{
					out.print("<script>location='/jsp/pcadmin/loginflag.jsp?act=qq&access_token="+accessToken+"&openid="+openId+"';</script>");
				}
			}else if("qq".equals(act)){//保存新的openid
				String name = h.get("name");
				String pwd = h.get("pwd");
				String access_token = h.get("access_token");
				String openid = h.get("openid");
				String member = (String)Profile.find(" AND  " + DbAdapter.cite(name) + " IN(member,mobile,email)", 0, 1).nextElement();
				Profile p = Profile.find(member);
				p.setqqopenid(openid);
				out.print("<script>location='/html/folder/2695-1.htm';</script>");
			}else if("wxlogin".equals(act)){
				String code = request.getParameter("code");//获取code
				//url获取openid
				String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxc2dcc4a09edaa5eb&secret=1b7e68e3beebb3387633068da4732d04&code="+code+"&grant_type=authorization_code";
				String json_str="";
					HttpClient client=new HttpClient();
					HttpMethod method=new GetMethod(url);
					client.executeMethod(method);
					json_str=method.getResponseBodyAsString();
					method.releaseConnection(); //释放连接
				JSONObject obj = new JSONObject(json_str);
				String openid = (String)obj.get("openid");
				String access_token = (String)obj.get("access_token");
				boolean flag = Profile.flagwxid(openid);
					if(flag){
						Profile mypro = Profile.wxgetmember(openid);
					    RV rv = new RV(mypro.member);
			            Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
			            //OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
			            mypro.setLogin(request.getRemoteAddr(),request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"),new Date());
			            Community c = Community.find(h.community);
			            h.member = mypro.getProfile();
			            session.setAttribute("member",h.member);
			            if(c.isSession())
			            {
			                //session.setAttribute("tea.RV",rv);
			            } else
			            {
			                h.setCook("member",MT.enc(mypro.getLogint() + "|" + h.member + "|" + mypro.getPassword()),h.getInt("expiry", -1));
			            }
					    out.print("<script>location='/html/folder/2695-1.htm';</script>");
					}else{
						out.print("<script>location='/jsp/pcadmin/loginflag.jsp?act=wx&&access_token="+access_token+"&openid="+openid+"';</script>");
					}
				}else if("wx".equals(act)){//保存新的wxid
					String name = h.get("name");
					String pwd = h.get("pwd");
					String access_token = h.get("access_token");
					String openid = h.get("openid");
					String member = (String)Profile.find(" AND  " + DbAdapter.cite(name) + " IN(member,mobile,email)", 0, 1).nextElement();
					Profile p = Profile.find(member);
					p.setwxopenid(openid);
					out.print("<script>location='/html/folder/2695-1.htm';</script>");
				}
		} catch (Exception ex) {
			out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
		}
		out.flush();
		out.close();
	}

}
