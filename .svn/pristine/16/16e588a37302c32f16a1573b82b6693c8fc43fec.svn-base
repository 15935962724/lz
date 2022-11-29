<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

Resource r = new Resource();
r.add("/tea/resource/fashiongolf");

TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Profile pobj = Profile.find(teasession._rv.toString());
%>
<%//审核成功以后的的商户
if(pobj.getMembertype()==5)//审核成功后的商户
{
	/*out.println("　<a href='/html/folder/574-1.htm'>[商家中心]</a>");*/

	AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());

%>

<!-- 添加商户的菜单 -->
<div class="titleMerchants" style="margin-top:0px;"><%=r.getString(teasession._nLanguage, "MerchantManagement")%></div>
<ul class="ulMerchants">
<!-- 球场管理 -->
<%
if(aur.golf!=null && aur.golf.length()>1)
{
	
 	 out.println("<li class=li12>");
 	 out.println("<a href=\"/html/folder/2700-1.htm\">"+r.getString(teasession._nLanguage, "Stadiummanagement")+"</a>");
 	 out.println("</li>");
	 out.println("<li class=li13>");
 	 out.println("<a href=\"/html/folder/2697-1.htm\">"+r.getString(teasession._nLanguage, "Courtorders")+"</a>");
 	 out.println("</li>");
	
}
%>
<!-- 教练管理 -->
<%
if(aur.golfcoach!=null && aur.golfcoach.length()>1)
{
	
 	 out.println("<li class=li14>");
 	 out.println("<a href=\"/html/folder/2699-1.htm\">"+r.getString(teasession._nLanguage, "Coachmanagement")+"</a>");
 	 out.println("</li>");
	 out.println("<li class=li15>");
 	 out.println("<a href=\"/html/folder/2696-1.htm\">"+r.getString(teasession._nLanguage, "Coachappointment")+"</a>");
 	 out.println("</li>");
	
}
%>
<!-- 活动管理 -->
<%

 	 out.println("<li class=li16>");
 	 out.println("<a href=\"/html/folder/2698-1.htm\">"+r.getString(teasession._nLanguage, "activeinformation")+"</a>");
 	 out.println("</li>");

%>

</ul>
<%} %>



<div class="title" style="margin-top:0px;"><%=r.getString(teasession._nLanguage, "Forum")%></div>
<ul>
<li class="li01"><a href="/html/folder/2718-1.htm"><%=r.getString(teasession._nLanguage, "Sentapost")%></a></li>
<li class="li02"><a href="/html/folder/2720-1.htm"><%=r.getString(teasession._nLanguage, "Replytopost")%></a></li>
<li class="li03"><a href="/html/folder/2719-1.htm"><%=r.getString(teasession._nLanguage, "MyFriends")%></a></li>
<li class="li04"><a href="/html/folder/2713-1.htm"><%=r.getString(teasession._nLanguage, "ForumCredits")%></a></li>
</ul>
<div class="title"><%=r.getString(teasession._nLanguage, "AccountManagement")%></div>
<ul>
<li class="li05"><a href="/html/folder/2712-1.htm"><%=r.getString(teasession._nLanguage, "Myorders")%></a></li>
<li class="li06"><a href="/html/folder/2702-1.htm"><%=r.getString(teasession._nLanguage, "Mycomments")%></a></li>
<include src="/jsp/type/golf/GolfMerchantinclude.jsp?nexturl=/html/folder/2701-1.htm"/>
</ul>
<div class="title"><%=r.getString(teasession._nLanguage, "PersonalInformation")%></div>
<ul>
<li class="li08"><a href="/html/folder/2717-1.htm"><%=r.getString(teasession._nLanguage, "PersonalInformation")%></a></li>
<li class="li09"><a href="/html/folder/2716-1.htm"><%=r.getString(teasession._nLanguage, "ChangePassword")%></a></li>
<li class="li10"><a href="/html/folder/2715-1.htm"><%=r.getString(teasession._nLanguage, "Letter")%></a></li>
<li class="li11"><a href="/html/folder/2714-1.htm"><%=r.getString(teasession._nLanguage, "subscription")%></a></li>
</ul>

