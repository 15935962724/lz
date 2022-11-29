<%@page import="java.util.Date"%>
<%@page import="tea.entity.site.Community"%>
<%@page import="org.apache.commons.httpclient.params.HttpMethodParams"%>
<%@page import="tea.entity.member.ProfileBBS"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.member.Logs"%>
<%@page import="tea.entity.member.OnlineList"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.Seq"%>
<%@page import="tea.entity.RV"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<!-- 微信登陆  -->
		<%
		try{
		Http h=new Http(request,response);
		TeaSession teasession=new TeaSession(request);
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
		}
		catch(Exception e){
			out.print("<script>alert('登陆失败！请重试');location='/';</script>");
		}
		%>
</head>
<body>
</body>
</html>