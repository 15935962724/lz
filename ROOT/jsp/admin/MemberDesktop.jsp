<%@page contentType="text/html;charset=UTF-8" %><%@ page  import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.db.*" %>
<%@page import="java.util.Date" %>
<%@page import="tea.entity.Entity" %>
<%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="java.net.URLEncoder"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/fun");

%><!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<style type="text/css">
body{margin:0;padding:0; background:#fff;font: 70% Arial, Helvetica, sans-serif;}
#scrlContainer{visibility:hidden;position:relative;overflow:hidden;height:20px;line-height:20px;margin:1em;}
#scrlContent{position:absolute;left:0;top:0;white-space:nowrap;}
</style>
<script> 

//公告滚动js
var scrlSpeed=1
scrlSpeed=(document.all)? scrlSpeed : Math.max(1, scrlSpeed-1)
function initScroll(container,object){

    if (document.getElementById(container) != null){
        var contObj=document.getElementById(container);
        var obj=document.getElementById(object);
        contObj.style.visibility = "visible";
        contObj.scrlSpeed = scrlSpeed;
        widthContainer = contObj.offsetWidth/2;
        
        obj.style.left=parseInt(widthContainer)+"px";
        widthObject=obj.offsetWidth;
        interval=setInterval("objScroll('"+ container +"','"+ object +"',"+ widthContainer +")",20);
        contObj.onmouseover = function(){
            contObj.scrlSpeed=0;
        }
        contObj.onmouseout = function(){
            contObj.scrlSpeed=scrlSpeed;
        }
    }
}
function objScroll(container,object,widthContainer){
	widthContainer =widthContainer+widthContainer;
	
    var contObj=document.getElementById(container);
    var obj=document.getElementById(object);
    widthObject=obj.offsetWidth;
    if (parseInt(obj.style.left)>(widthObject*(-1))){
        obj.style.left=parseInt(obj.style.left)-contObj.scrlSpeed+"px";
    } else {
        obj.style.left=parseInt(widthContainer)+"px";
    }
}
window.onload=function(){
    initScroll("scrlContainer", "scrlContent");
}
</script>
<body class="membercenter">
<table class="membertable" border="0" cellpadding="0" cellspacing="0">

<tr class="top"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>

<tr class="middle"><td class="memberleft"></td><td class="membercenter2">
<h1><span>会员中心</span></h1>
<div class="scrlContainer">
<div id="scrlContainer">
    <div id="scrlContent">
<%

java.util.Enumeration enumer =  Bulletin.find(teasession._strCommunity," AND type=1 ",0,Integer.MAX_VALUE);
if(!enumer.hasMoreElements())
{
  out.print("暂无部门公告");
}else
{
 
  for(int index=1;enumer.hasMoreElements();index++)
  {
    int ids = ((Integer)enumer.nextElement()).intValue();
    Bulletin obj = Bulletin.find(ids);
    //out.print("<tr>");
    //	out.print("<td>"); 
    		out.print("<font color=Black>•</font>&nbsp;<a href=\"/jsp/admin/flow/BulletinContent.jsp?community="+teasession._strCommunity+"&bulletin="+ids+"\"  target=\"_blank\">");
    			out.print(obj.getCaption());
    		out.print("</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    	//out.print("</td>");
   // out.print("</tr>");
  }
}
%> </div> 
</div></div>
<table border="0" cellpadding="0" cellspacing="0" id="memberindex">
  <tr  id=tableonetr>
  <td rowspan="4" width="107" align="center"><img src="/res/Home/1010/10109910.gif"></td>
  <td align="left"><b><%=teasession._rv.toString() %></b>&nbsp;<%
  
//个人信息
  int newcount=Message.count(teasession._strCommunity,teasession._rv._strR,0," AND reader NOT LIKE " + DbAdapter.cite("%/" + teasession._rv._strR + "/%"));
  Profile p = Profile.find(teasession._rv._strR);
AdminUsrRole aobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
if(aobj.isExists()&&aobj.getBbsHost()!=null)
{
	out.print("论坛版主");
}
%></td>
</tr>
<tr>
	<td align="left">您的积分：<b><%=p.getIntegral() %></b>分,其中（论坛<b><%=p.getPoint() %></b>分/投稿<b><%=p.getContributeintegral() %></b>分）</td>
</tr>
<tr>
	<td align="left">您的会员级别是：
	<span><%
	MemberOrder mobj = MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,MemberOrder.getMemberType(teasession._strCommunity,teasession._rv.toString()),teasession._rv.toString()));
	if(mobj.getPeriod()>0)
	{
		out.print("金牌会员");
	}else
	{
	out.print(MemberType.find(MemberOrder.getMemberType(teasession._strCommunity,teasession._rv._strR)).getMembername()); 
	}
	%></span>&nbsp;
	<%
		
		if(mobj.getVerifg()==0){
			out.print("(未付费)");
			}else if(mobj.getVerifg()==1)//数字报会员的有效期
			{
				int d  = 0; 
				if(mobj.getBecometime()!=null)
				{
					 d =Entity.countDays(Entity.sdf.format(new Date()),Entity.sdf.format(mobj.getBecometime()));
				}
				
				
				if(d>=1){
					out.print("&nbsp;有效期："+Entity.sdf.format(mobj.getVerifgtime())+"&nbsp;至&nbsp;"+Entity.sdf.format(mobj.getBecometime()));
					out.print("&nbsp;目前还剩&nbsp;<font color=red>"+d+"</font>&nbsp;天");
				}else
				{
					out.print("(<font color=red>已到期</font>)"); 
				}
			}
		
	%> 
	
	<a href=###>查看会员权限</a></td>
</tr>
<tr>
	<td align="left">您上次登陆时间：<%=Entity.sdf2.format(Logs.getLastLogin(teasession._rv.toString())) %>&nbsp;&nbsp;&nbsp;&nbsp;注册时间：<%=Entity.sdf2.format(p.getTime()) %></td>
</tr>
</table>
<div class=LatestEmail>
	<%
	if(newcount>0){
		out.print("<span>个人信息:您有"+newcount+"条信息信息&nbsp;<a href=/jsp/message/MemberMailbox.jsp>立即查看</a></span>");
	}
	%>
</div>
<div class=LatestEmail>
	<% 
	if(MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,teasession._rv.toString())).getProxymembertype2()==1){
		out.print("<span><a href=/jsp/mov/ClssnProxyMemberList2.jsp>管理自己的代理人</a></span>");
	}
	%>
</div>
<div class="Quicktips">您可以进行以下快捷操作</div>
<div class="QuicktipsCon">
<table cellpadding="0" cellspacing="18">
  <tr>
    <td class="td1"><a href="http://<%=request.getServerName() %>" target="_blank">浏览网站</a></td>
    <td class="td2"><a href="/jsp/profile/MemberNewsletter.jsp" target="_blank">在线读报</a></td>
    <td class="td3"><a href="/jsp/type/report/contributors/ContributorsList.jsp?membertype=0&node=1">在线投稿</a></td>
    <td class="td4"><a href="/html/folder/24992-1.htm" target="_blank">进入论坛</a></td>
    <td class="td5"><a href=### target="_blank">进入博客</a></td>
    <td class="td6"><a href="/jsp/message/MemberMailbox.jsp">个人信箱</a></td>
  </tr>
</table>
</div>
<div class="Notes">
网址：www.labournews.com.cn　　　　联系电话：010-84229115、84229199<br>
传真：010-84229117　　　　　　　　　电子邮箱：ldbwlb@126.com  
</div>  
</td><td class="memberright"></td></tr>
<tr class="bottom"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>

</table>
</body>
</html>



