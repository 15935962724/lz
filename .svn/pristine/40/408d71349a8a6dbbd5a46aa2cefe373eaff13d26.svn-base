<%@page import="java.util.Date"%>
<%@page import="tea.entity.site.Community"%>
<%@page import="tea.entity.member.ProfileBBS"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="tea.entity.Seq"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.member.Logs"%>
<%@page import="tea.entity.member.OnlineList"%>
<%@page import="tea.entity.RV"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<!-- qq登陆  -->
</head>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<body>
<%
try{
Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
String act = h.get("act");
	//if(act.equals("qq")){
		String openId=request.getParameter("openid");//得到openid token
		String accessToken=request.getParameter("access_token");
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
}catch(Exception e){
	out.print("<script>alert('登陆失败！请重试');location='/';</script>");
}
%>
</body>
</html>