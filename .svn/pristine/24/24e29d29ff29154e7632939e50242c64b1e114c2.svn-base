<%@page contentType="text/html;charset=UTF-8" %><%@ page  import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.db.*" %>
<%@page import="java.util.Date" %>
<%@page import="tea.entity.Entity" %>
<%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.net.URLEncoder"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/fun");

AdminUsrRole robj = AdminUsrRole.find(teasession._strCommunity, teasession._rv.toString());

if(!robj.isExists())
{
	 out.println("<script>window.top.location.href='/jsp/admin/indexmember.jsp';</script>");
	 return;
}

%><html>
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

function fchange(a,j,n,c,e,t)
{
  var cf=document.getElementById('currentfolder');
  if(cf)
  {
    cf.id='folder';
  }
  a.id='currentfolder';
  parent.f_cols(0,200);
}
</script>

<body class="working">
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
<h2 class="Workingcond"><span><%=teasession._rv.toString() %></span>&nbsp;的工作状态</h2>
<%
StringBuffer sql = new StringBuffer(" AND n.type = 39 AND r.cbutors=0  AND ( n.audits!=4 or n.audits is null ) ");

Date ts =Entity.sdf2.parse(Entity.sdf.format(new Date())+" 00:00");
Date ts2 =Entity.sdf2.parse(Entity.sdf.format(new Date())+" 23:59");



int countr=Node.countReport(teasession._strCommunity," AND n.type = 39 AND r.cbutors=0 AND n.time >= "+DbAdapter.cite(ts)+" AND n.time<="+DbAdapter.cite(ts2)+" and n.rcreator ="+DbAdapter.cite(teasession._rv._strR) );
int countrall=Node.countReport(teasession._strCommunity,sql.toString()+" and n.rcreator ="+DbAdapter.cite(teasession._rv._strR) );


String nodecountsql = NodeRole.getRole3(teasession._strCommunity,teasession._rv.toString(), 8,sql.toString()+" and n.audits=1");

int countr2=Node.countReport(teasession._strCommunity,sql.toString()+"  and n.audits=1 and ( "+nodecountsql+")");
int countr2all=Node.countReport(teasession._strCommunity,sql.toString()+"  and (n.audits=2 or n.audits=3 ) and auditmember = "+DbAdapter.cite(teasession._rv.toString())+" ") ;



int countr3=Node.countReport(teasession._strCommunity,"  and n.type=39 and r.cbutors = 1 and n.audits!=0 and n.audits!=4 and n.audits=1  ");
int countr3all=Node.countReport(teasession._strCommunity,"  and n.type=39 and r.cbutors = 1 and n.audits!=0 and n.audits!=4    and auditmember = "+DbAdapter.cite(teasession._rv.toString())+" ") ;

int countbbs=Node.count(" and type=57 and node in (select node from BBS where search=0) ");

int countbr = 0;
DbAdapter db2 = new DbAdapter();
try
{
	  db2.executeQuery("SELECT count(id) FROM BBSReply WHERE   search=0 and  node in (select node from Node  where  type = 57 )  ");
	  if(db2.next())
	  {
		  countbr = db2.getInt(1);
	  }
}finally
{
	db2.close();
}
//个人信息
int newcount=Message.count(teasession._strCommunity,teasession._rv._strR,0," AND reader NOT LIKE " + DbAdapter.cite("%/" + teasession._rv._strR + "/%"));
%>
<table border="0" cellpadding="0" cellspacing="0" id="WorkInfo">
  <tr  id=tableonetr class="tr01">
    <td nowrap class="td01">您今天已上传&nbsp;<font color="red"><%=countr %></font>&nbsp;篇文章&nbsp;
    <a href="/jsp/general/AdminNodeLists2.jsp?membername=<%=URLEncoder.encode(teasession._rv._strR,"UTF-8") %>&time_c=<%=Entity.sdf.format(new Date())+" 00:00" %>&&time_d=<%=Entity.sdf.format(new Date())+" 23:59" %>">查看</a>
    &nbsp;
    你累积上传<font color="red"><%=countrall %></font>&nbsp;篇稿件&nbsp;
    <a href="/jsp/general/AdminNodeLists2.jsp?membername=<%=URLEncoder.encode(teasession._rv._strR,"UTF-8") %>">查看</a>

    </td>
    <td nowrap class="td02">您有&nbsp;<font color="red"><%=countr2%></font>&nbsp;篇文章需要审核、签发&nbsp;
    <a href="/jsp/general/AdminNodeLists2.jsp?audits=1">查看</a>
    &nbsp;
    你累积处理了&nbsp;<font color="red"><%=countr2all%></font>&nbsp;篇稿件
     <a href="/jsp/general/AdminNodeLists2.jsp?auditmember=<%=URLEncoder.encode(teasession._rv._strR,"UTF-8") %>&desktop=desktop">查看</a>


    </td>
  </tr>

   <tr  id=tableonetr class="tr02">
    <td nowrap class="td03">
		      您有&nbsp;<font color="red"><%=countr3 %></font>&nbsp;篇投稿需要处理&nbsp;
		   <a href="/jsp/general/ContributorsNodeLists.jsp?node=<%=Community.find(teasession._strCommunity).getNode() %>">查看</a>
		   您累积处理了&nbsp;<font color="red"><%=countr3all %></font>&nbsp;篇投稿稿件
		     <a href="/jsp/general/ContributorsNodeLists.jsp?node=<%=Community.find(teasession._strCommunity).getNode() %>&auditmember=<%=URLEncoder.encode(teasession._rv._strR,"UTF-8") %>">查看</a>
    </td>


    <td nowrap class="td04">您有&nbsp;<font color="red"><%=countbbs%></font>&nbsp;个新主题
    &nbsp;<a href="/jsp/type/bbs/BBSManage.jsp?search=0">查看</a>&nbsp;<font color="red"><%=countbr%></font>&nbsp;条新帖子需要查阅&nbsp;
    <a href="/jsp/type/bbs/AdminBBSReplyManage.jsp?search=0">查看</a></td>
  </tr>

    <tr  id=tableonetr class="tr03">
    <td nowrap class="td05">共有40篇新博文等待您的审核&nbsp;<a href=###>查看</a></td>
    <td nowrap class="td06">您有&nbsp;<font color=red><%=newcount %></font>&nbsp;条个人信息尚未阅读&nbsp;<a href="/jsp/message/MemberMailbox.jsp">查看</a></td>
  </tr>
</table>
<div class="Quicktips">您可以进行以下快捷操作</div>
<div class="QuicktipsCon">
<table cellpadding="0" cellspacing="18">
  <tr>

    <td class="td01"><span><a href="/jsp/admin/index_leftup.jsp?id=<%=teasession.getParameter("id")!=null?Integer.parseInt(teasession.getParameter("id")):0%>&node=<%=Node.getRoot(teasession._strCommunity) %>&community=<%=teasession._strCommunity %>" onfocus=this.blur() onclick=fchange(this) target="MenuFrame">文章上传</a></span><br/>今日上传
    <a href="/jsp/general/AdminNodeLists2.jsp?membername=<%=URLEncoder.encode(teasession._rv._strR,"UTF-8") %>&time_c=<%=Entity.sdf.format(new Date())+" 00:00" %>&&time_d=<%=Entity.sdf.format(new Date())+" 23:59" %>">
    &nbsp;<font color="red"><%=countr %></font>&nbsp;</a>篇</td>
    <td class="td02"><span><a href="/jsp/general/AdminNodeLists2.jsp?audits=1">文章审核</a></span><br/> <a href="/jsp/general/AdminNodeLists2.jsp?audits=1">&nbsp;<font color="red"><%=countr2%></font>&nbsp;</a>篇新文档

    </td>
    <td class="td03"><span><a href="/jsp/general/ContributorsNodeLists.jsp?node=<%=Community.find(teasession._strCommunity).getNode() %>">来稿处理</a></span><br/><a href="/jsp/general/ContributorsNodeLists.jsp?node=<%=Community.find(teasession._strCommunity).getNode() %>">
    &nbsp;<font color="red"><%=countr3 %></font>&nbsp;</a>篇新稿件</td>

    <td class="td04"><span><a href="/jsp/type/bbs/BBSManage.jsp?search=0">帖子查阅</a></span><br/>
    <a href="/jsp/type/bbs/BBSManage.jsp?search=0">&nbsp;<font color="red"><%=countbbs%></font>&nbsp;</a>新主题,
      <a href="/jsp/type/bbs/AdminBBSReplyManage.jsp?search=0">&nbsp;<font color="red"><%=countbr%></font>&nbsp;</a>新帖

      </td>
    <td class="td05"><span>博文审核</span><br/>12篇新博文</td>
    <td class="td06"><span>个人信息</span><br/><a href="/jsp/message/MemberMailbox.jsp">&nbsp;<font color=red><%=newcount %></font>&nbsp;</a>条新信息</td>
  </tr>
</table>
</div>


<div class="Quicktips2">审核快捷操作</div>
<div class="QuicktipsCon2">
<table cellpadding="0" cellspacing="18">
  <tr>
   <td class="td01">
 <%
 String url = "/jsp/general/NodeReportAll.jsp?node="+Community.find(teasession._strCommunity).getNode();

	 if(AccessMember.isAuditAll(teasession._strCommunity,Community.find(teasession._strCommunity).getNode() , teasession._rv.toString(), 1))
	 {
		 // out.println("<input type=button value='审核' onclick=f_audit('"+nodeid+"','');>");
		 StringBuffer sql_audit=new StringBuffer();
		 sql_audit.append(" and type = 39 ");
		 sql_audit.append(" and n.audits = 0 ");

		 sql_audit.append(AccessMember.getRole(teasession._strCommunity,Community.find(teasession._strCommunity).getNode(),teasession._rv.toString()));

		 int count=Node.countReport(teasession._strCommunity,sql_audit.toString());

		 out.println("需一级初审文章");
		 out.println(" <a href="+url+"&audits=0 >"+count+"</a>");
		 out.println("篇");

	 }
 if(AccessMember.isAuditAll(teasession._strCommunity,Community.find(teasession._strCommunity).getNode() , teasession._rv.toString(), 2))
 {
	 // out.println("<input type=button value='审核' onclick=f_audit('"+nodeid+"','');>");
	 StringBuffer sql_audit=new StringBuffer();
	 sql_audit.append(" and type = 39 ");
	 sql_audit.append(" and n.audits = 1 ");
	 sql_audit.append(AccessMember.getRole(teasession._strCommunity,Community.find(teasession._strCommunity).getNode(),teasession._rv.toString()));

	 int count=Node.countReport(teasession._strCommunity,sql_audit.toString());

	 out.println("需一级终审文章");
	 out.println(" <a href="+url+"&audits=1 >"+count+"</a>");
	 out.println("篇");
 }
 if(AccessMember.isAuditAll(teasession._strCommunity,Community.find(teasession._strCommunity).getNode() , teasession._rv.toString(), 4))
 {
	 // out.println("<input type=button value='审核' onclick=f_audit('"+nodeid+"','');>");
	 StringBuffer sql_audit=new StringBuffer();
	 sql_audit.append(" and type = 39 ");
	 sql_audit.append(" and n.audits = 2 ");
	 sql_audit.append(AccessMember.getRole(teasession._strCommunity,Community.find(teasession._strCommunity).getNode(),teasession._rv.toString()));
	 int count=Node.countReport(teasession._strCommunity,sql_audit.toString());

	 out.println("需二级初审文章");
	 out.println(" <a href="+url+"&audits=2 >"+count+"</a>");
	 out.println("篇");
 }
 if(AccessMember.isAuditAll(teasession._strCommunity,Community.find(teasession._strCommunity).getNode() , teasession._rv.toString(), 8))
 {
	 // out.println("<input type=button value='审核' onclick=f_audit('"+nodeid+"','');>");
	 StringBuffer sql_audit=new StringBuffer();
	 sql_audit.append(" and type = 39 ");
	 sql_audit.append(" and n.audits = 3 ");
	 sql_audit.append(AccessMember.getRole(teasession._strCommunity,Community.find(teasession._strCommunity).getNode(),teasession._rv.toString()));
	 int count=Node.countReport(teasession._strCommunity,sql_audit.toString());

	 out.println("需二级终审文章");
	 out.println(" <a href="+url+"&audits=3 >"+count+"</a>");
	 out.println("篇");
 }
 %>
   </td>

  </tr>
</table>
</div>


<%
AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
boolean f = false;
if(arobj.getRole()!=null && arobj.getRole().length()>0)
{
	for(int i=1;i<arobj.getRole().split("/").length;i++){

		AdminRole aobj = AdminRole.find(Integer.parseInt(arobj.getRole().split("/")[i]));
		if(aobj.getLevels()==0)
		{
			f = true;
			break;
		}
	}
}
if(f){
%>
<table border="0" cellpadding="0" cellspacing="0" id="workingOther">
  <tr  id=tableonetr>
    <td nowrap>
    	<a href="/jsp/admin/popedom/AdminUsrRoles.jsp">用户统计</a>
    	<a href="/jsp/mov/ClssnMember.jsp">会员统计</a>
    	<a href="/jsp/general/ContributorsNodeLists.jsp?node=<%=Community.find(teasession._strCommunity).getNode() %>">投稿统计</a>
    	<a href="/jsp/type/bbs/BBSManage.jsp">发帖统计</a>
    	<a href=###>博文统计</a>
    	<a href=###>积分统计</a>
    	<a href=###>订阅统计</a>
    </td>

  </tr>
</table>

<%} %>
</body>
</html>



