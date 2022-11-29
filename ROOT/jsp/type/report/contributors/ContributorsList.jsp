<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.db.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.admin.*" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);

if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
String member = teasession._rv._strR;



String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer(" and n.type = 39 and r.cbutors=1  and n.audits!=4   ");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

sql.append(" and n.rcreator =").append(DbAdapter.cite(member));


param.append("&node=").append(teasession._nNode);



String divid = "cblid1";
if(teasession.getParameter("divid")!=null && teasession.getParameter("divid").length()>0)
{
	divid = teasession.getParameter("divid");
} 

int father = 0;
if(teasession.getParameter("father")!=null && teasession.getParameter("father").length()>0)
{
 father  = Integer.parseInt( teasession.getParameter("father"));
}
if(father>0) 
{
   sql.append(" and n.father = ").append(father);
   param.append("&father=").append(father);
}
String subject = teasession.getParameter("subject");
if(teasession.getParameter("subject")!=null&& teasession.getParameter("subject").length()>0)
{
  subject = subject.trim();
  sql.append(" and n.node in (select node from NodeLayer where subject like "+DbAdapter.cite("%"+subject+"%")+")");
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}

String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND n.time >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND n.time <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}


//审核状态
int audits=-1;
if(teasession.getParameter("audits")!=null && teasession.getParameter("audits").length()>0)
{
	audits = Integer.parseInt(teasession.getParameter("audits"));
}
if(audits>=0)
{
	sql.append(" and n.audits = ").append(audits);
	param.append("&audits=").append(audits);
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Node.countReport(teasession._strCommunity,sql.toString());

String o=request.getParameter("o");
if(o==null)
{
	o="n.time";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");
param.append("&o=").append(o).append("&aq=").append(aq);

tea.entity.site.Community community_jsp=tea.entity.site.Community.find(teasession._strCommunity);
%>

<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

<style type="text/css">
body{margin:0;padding:0; background:#fff;font: 70% Arial, Helvetica, sans-serif;}
#scrlContainer{visibility:hidden;background:#f1f1f1;position:relative;overflow:hidden;width:100%;height:20px;line-height:20px;margin:1em;}
#scrlContent{position:absolute;left:0;top:0;white-space:nowrap;}
</style>
</head>
<script>
function f_add(igd)
{
	form1.action = '/jsp/type/report/contributors/ContributorsAdmin.jsp?adminact=admin';
	form1.divid.value=igd; 
    form1.submit();
}
 function f_edit(igd)
 {
   form1.nid.value = igd;
   form1.action = '/jsp/type/report/contributors/ContributorsAdmin.jsp?adminact=admin';
   form1.submit();
 }
 function f_audit(igd)
 {
	 form1.nid.value=igd;
	
	
	 	if(confirm('您确定要 投稿吗？'))
	{
			 sendx("/servlet/EditContributors?nid="+igd+"&act=ContributorsListAudit&nexturl="+form1.nexturl.value,
				 function(data)
				 {
				   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
				   {
						alert(data);
						window.location.reload();
				   }
				 }
			);
	 }
 }
 function f_delete(igd)
 {
   if(confirm('此删除将不能恢复，您确定要删除吗？'))
   {
     form1.nid.value = igd;
     form1.act.value='delete';
     form1.action = '/servlet/EditContributors';
     form1.submit();
   }
 }
 
function f_order(v)
  {
    var aq=form1.aq.value=="true";
    if(form1.o.value==v)
    {
      form1.aq.value=!aq;
    }else
    {
      form1.o.value=v;
    }
    form1.action="?";
    form1.submit();
  } 
//状态搜索
function f_s(igd,igd2)
{
	form1.audits.value=igd;
	form1.divid.value=igd2;
	form1.action="?";
	form1.submit();
}

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
//查看退稿原因
function f_rejection(igd)
{
	 var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:550px;dialogHeight:180px;';
	  var url = '/jsp/type/report/contributors/Rejection.jsp?nid='+igd+'&community='+form1.community.value+'&act=CLRE';
	  var rs = window.showModalDialog(url,self,y);
	
	  if(rs==1)
	  {
		  window.location.reload();
	  }
}
</script>
<body class="membercenter">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community_jsp.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<table class="membertable" border="0" cellpadding="0" cellspacing="0">
<tr class="top"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>
<tr class="middle"><td class="memberleft"></td><td class="membercenter2">
<h1><span>在线投稿</span></h1>

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
    		out.print("<font color=Black>•</font>&nbsp;</<a href=\"/jsp/admin/flow/BulletinContent.jsp?community="+teasession._strCommunity+"&bulletin="+ids+"\"  target=\"_blank\">");
    			out.print(obj.getCaption());
    		out.print("</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    	//out.print("</td>");
   // out.print("</tr>");
  }
}
%> </div> 
</div></div>

<%
	out.print(community_jsp.getTips(teasession._nLanguage));
%>

<form name="form1" METHOD=POST action="?data=<%=new Date() %>">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node" value="<%=teasession._nNode%>">

<input type='hidden' name="nid" >
<input type='hidden' name="act" >
<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
<input type='hidden' name="nexturl" value="<%=nexturl%>">
<input type=hidden name=member value="<%=member%>"/>
<input type="hidden" name="audits" />
<input type=hidden name=id value="<%=teasession.getParameter("id")%>"/>
<input type="hidden" name="divid" value="<%=divid %>">

<div  class="cnlistclass">
<%
	out.print("<a href=### onclick=f_s('-1','cblid1'); class=cblclass1");
	if("cblid1".equals(divid))
	{
		out.print(" id="+divid);
	}
	out.print(">全部稿件</a>");
	
	out.print("<a href=### onclick=f_s('0','cblid2'); class=cblclass2");
	if("cblid2".equals(divid))
	{
		out.print(" id="+divid);
	}
	out.print(">新建稿</a>");
	
	out.print("<a href=### onclick=f_s('1','cblid3'); class=cblclass3");
	if("cblid3".equals(divid))
	{
		out.print(" id="+divid);
	}
	out.print(">待审稿</a>");
	
	out.print("<a href=### onclick=f_s('2','cblid4'); class=cblclass4");
	if("cblid4".equals(divid))
	{
		out.print(" id="+divid);
	}
	out.print(">已发稿</a>");
	
	out.print("<a href=### onclick=f_s('3','cblid5'); class=cblclass5");
	if("cblid5".equals(divid))
	{
		out.print(" id="+divid);
	}
	out.print(">已退稿</a>"); 
	out.print("<span id=cnlistCen2>目前共有&nbsp;<font color=#000000 size=3>"+count+"</font>&nbsp;篇稿子</span>");
	out.print("<a href=### onclick=f_add('cblid6'); class=cblclass6");
	if("cblid6".equals(divid))
	{
		out.print(" id="+divid);
	}
	out.print(">上传稿件</a>");
	
%>
</div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr  id=tableonetr>
    <td nowrap>投稿栏目</td>
    <td nowrap>投稿主题</td>
    <td nowrap><a href="javascript:f_order('n.time');">投稿时间
    <%
    if(o.equals("n.time"))
	  {
	    if(aq)
	    out.print("&nbsp;<img src=\"/tea/image/pic_time_1.gif\" >");
	    else
	  	  out.print("&nbsp;<img src=\"/tea/image/pic_time_0.gif\" >");
	  }
	 
    %></a>
    </td>
    <td nowrap>审核状态</td>
    <td nowrap>操作</td>
  </tr>
  <%
  java.util.Enumeration e = Node.findReport(teasession._strCommunity,sql.toString(),pos,pageSize);
  if(!e.hasMoreElements())
  {
    out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
  }
     while(e.hasMoreElements())
     {
       int nid = ((Integer)e.nextElement()).intValue(); 
       Node nobj = Node.find(nid);
       Node father_obj = Node.find(nobj.getFather());
  %>
  <tr>
    <td><a href="/html/node/<%=nobj.getFather() %>.htm" target=_blank><%=father_obj.getSubject(teasession._nLanguage)%></a></td>
    <td><%=nobj.getSubject(teasession._nLanguage)%></td>
    <td><%=nobj.getTimeToString()%></td>
    <td>
		<%
		if(nobj.getAudit()==0)
		{
			out.print(Node.AUDIT_TYPE[nobj.getAudit()]);
		}
		if(nobj.getAudit()==1)//待审核
		{
			out.print("<font color=red>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</font>");
		}else if(nobj.getAudit()==2)//审核通过
		{
			out.print("<font color=#00cc00>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</font>");
		}else if(nobj.getAudit()==3)//已经退稿
		{
			out.print("<font color=#666666><a href=### onclick=f_rejection('"+nid+"');>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</a></font>");
			out.println("&nbsp;");
			out.print("<a href=### onclick=f_rejection('"+nid+"');><font color=red>退稿原因</font></a>");
		}
		%>
	</td>
    <td>
     
     	<%
     	 
     		if(nobj.getAudit()==0)
     		{
     			out.print("<a href=### onclick=f_edit('"+nid+"');>编辑</a>&nbsp;");
     			out.print("<a href=### onclick=f_audit('"+nid+"');>投稿</a>&nbsp;");
     			///out.print("<a href=### onclick=f_delete('"+nid+"');>删除</a>&nbsp;");
     		}
     		out.print("<a href=### onclick=window.open('/jsp/type/report/contributors/ContributorsShow.jsp?node="+nid+"','_blank');>预览</a>&nbsp;");
     		if(nobj.getAudit()==0||nobj.getAudit()==3)
     		{
     			out.print("<a href=### onclick=f_delete('"+nid+"');>删除</a>&nbsp;");
     		}
     	%>
      
    </td>
 
  </tr>
  <%} %>
  <%if (count > pageSize) {  %>
  <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%}  %>
</table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td nowrap="nowrap">投稿栏目：</td>
<td>
  <select name="father">
    <option value="0">--请选择投稿栏目--</option>
        <%
        java.util.Enumeration fe = Node.find(" and type = 1 and "+DbAdapter.bitand("options1",4)+"!=0 " ,0,Integer.MAX_VALUE);
        while(fe.hasMoreElements())
        {
          int nid2 = ((Integer)fe.nextElement()).intValue();
          Node nobj2 = Node.find(nid2);
           Category cat = Category.find(nid2); //39 

           if(cat.getCategory()==39 || cat.getCategory() == 40)
           {
             out.print("<option value = "+nid2);
             if(father == nid2)
             {
               out.print(" selected ");
             }
             out.print(">"+nobj2.getSubject(teasession._nLanguage));
             out.print("</option>");
           }
        }
        %>
    </select>
</td>
<td nowrap="nowrap">投稿主题:</td>

<td><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"></td>


  <td nowrap="nowrap">投稿时间：</td>
  <td>
  从&nbsp;
  <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly>
  <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
  &nbsp;到&nbsp;
  <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly>
  <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
  </td>

<td><input class="SearchArt" type="submit" value=""/></td>
</tr>
<tr class="QuickEntryTr">
	<td colspan="7"><div class="QuickEntry"><div class="left">快捷入口：</div>
	<a href="http://<%=request.getServerName() %>" target=_blank>浏览网站</a>
	<a href="/jsp/profile/MemberNewsletter.jsp" target=_blank>在线读报</a>
	<a href="/html/folder/24992-1.htm" target=_blank>进入论坛</a>
	<a href=###>进入博客</a>
	<a href="/jsp/message/MemberMailbox.jsp">个人信箱</a>
	</div></td>
</tr>
</table>


</form>
</td><td class="memberright"></td></tr>
<tr class="bottom"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>
</table>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community_jsp.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>

</html>
