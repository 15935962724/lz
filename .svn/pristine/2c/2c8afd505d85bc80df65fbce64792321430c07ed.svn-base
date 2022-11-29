<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

%>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">

<script>
	function f_subnull()
	{
		ymPrompt.win('/jsp/westrac/WestracClueJudge.jsp?t='+new Date().getTime(),500,300,'提示框',null,null,null,true);
	}
	function f_wcj(igd)
	{
		if(igd==0){
			//去注册
		window.open('/html/folder/17-1.htm','_self');
		}else if(igd==1)
		{
			//直接填写
			window.open('/html/folder/95-1.htm','_self');
		}else if(igd==2)
		{
			//去登陆 
			window.open('/html/folder/41-1.htm','_self');
		}else if(igd==3)
		{
			ymPrompt.close();
			ymPrompt.win({message:'/jsp/westrac/WestracUpgradeMember.jsp',width:750,height:650,title:'升级为履友',handler:function(){},maxBtn:false,minBtn:false,iframe:true});
			//是
			
		}else if(igd==4) 
		{
			//否
			window.open('/html/folder/95-1.htm','_self');
		}
	}
	function f_subNonull()
	{
		ymPrompt.win('/jsp/westrac/WestracClueJudge.jsp?t='+new Date().getTime()+'&act=0',500,300,'提示框',null,null,null,true);
	}
	
	function wu()
 	{
 		ymPrompt.close();
 		window.location.href='/html/folder/3-1.htm';
 		
 	}
</script> 

<%
	if(teasession._rv==null)
	{//没有登录
		
		out.print("<a href=\"###\" onclick=\"f_subnull();\">我提供线索</a>");

    }
	else
	{
		Profile pobj = Profile.find(teasession._rv._strR);
		
		if(pobj.getMembertype()==0)  
		{
		//普通会员
			out.print("<a href=\"###\" onclick=\"f_subNonull();\">我提供线索</a>");
		}else if(pobj.getMembertype()==1 || pobj.getMembertype()==2)
		{
			out.print("<a href=\"###\" onclick=\"f_wcj('4');\">我提供线索</a>");
		}
	
	} 

%>
	
	
	
	
	
	
	
	
	
	
