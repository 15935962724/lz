<%@page import="tea.entity.node.Files"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Meeting"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page import="tea.entity.node.MeetingInvite"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}
  
StringBuffer sql=new StringBuffer(" and type =41 and community = ").append(DbAdapter.cite(community));
StringBuffer param=new StringBuffer();

String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

param.append("?community="+teasession._strCommunity);

int node =0;
if(teasession.getParameter("node")!=null && teasession.getParameter("node").length()>0)
{
	node = Integer.parseInt(teasession.getParameter("node"));	
}
//if(node>0){
	sql.append(" and father="+node);
	param.append("&node="+node);
//}

//会议名称
String subject=teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
	subject=subject.trim();
  
  sql.append(" and  exists (select node from NodeLayer nl where n.node=nl.node and nl.subject like "+DbAdapter.cite("%"+subject+"%")+" ) ");
  param.append("&subject=").append(URLEncoder.encode(subject,"UTF-8")); 
}
 
int pos=0,size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count = Node.count(sql.toString());

sql.append(" order by time desc ");

%>
<html>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>
</HEAD>
<body>
<script type="text/javascript">
//删除
function f_delete(igd)
{
	if(confirm('确认删除')){
	  sendx("/Filess.do?act=delete&node="+igd,
				 function(data)
				 {

				    alert('信息删除成功');
				    window.location.reload();
				 }
				 );	
	}
}



//点击操作显示
function f_cz(igd)
{
	
	if(document.getElementById('trid'+igd).style.display=='')
	{
		document.getElementById('trid'+igd).style.display='none';
	}
	else if(document.getElementById('trid'+igd).style.display=='none')
	{
		document.getElementById('trid'+igd).style.display='';
		
	}
}
//发布
function f_fb(igd)
{
	 sendx("/jsp/admin/edn_ajax.jsp?act=WestracEventFB&node="+igd,
			 function(data)
			 {
		        data = data.trim();
		 		if(data=='false')
		 		{
		 			 alert("会议发布成功");
		 		}else if(data=='true')
			   {
		 			alert("会议取消发布");
			   }
			    window.location.reload();
			 }
			 );	
}
//报名审核会员
function f_verifg(igd)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
	 var url = '/jsp/type/meeting/WestracMeetingMemberList.jsp?t='+new Date().getTime()+"&node="+igd;
	 var rs = window.showModalDialog(url,self,y);
	 //if(rs==1)
	 //{
		// window.location.reload(); 
	// }
}
//短信邀请会员
function f_invite(igd)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
	 var url = '/jsp/type/meeting/WestracMeetingInvite.jsp?node='+igd;
	 var rs = window.showModalDialog(url,self,y);
}

function f_confirm(igd)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
	 var url = '/jsp/type/event/WestracEventConfirmMember.jsp?t='+new Date().getTime()+"&node="+igd;
	 var rs = window.showModalDialog(url,self,y);
}


//会议通知
function f_meetingNotice(igd)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
	 var url = '/jsp/type/meeting/WestracMeetingNoticeList.jsp?node='+igd;
	 var rs = window.showModalDialog(url,self,y);
	 //if(rs==1)
	 //{
		// window.location.reload(); 
	// }
}
</script>
<h1>会议文件管理列表</h1>
<form name="form2" action="?" method="POST">
<input type="hidden" name="node" value="<%=teasession._nNode %>" >

<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter"> 
	<tr>
		<td align="right">会议名称：</td>
		<td><input type="text" name="subject" value="<%=Entity.getNULL(subject) %>"> </td>
		 <td colspan="10" align="left"><input type="submit" value="查询" /></td>
	</tr>

</table>
</form>
<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;个文件&nbsp;)&nbsp;&nbsp;
<input type="button" value="创建文件" onclick="window.open('/jsp/type/meeting/WestracEditMeetingFiles.jsp?NewNode=ON&Type=41&node=<%=teasession._nNode%>&nexturl=<%=URLEncoder.encode(nexturl)%>','_self');">

</h2>

<form name="form1" action="?" method="GET">

<input type="hidden" name="act" >
<input type="hidden" name="node" value="<%=teasession._nNode %>" >

<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
 
      <td nowrap>文件名称</td>
      <td nowrap>作者</td>
      <td nowrap>所属单位</td>
      
      <td nowrap>操作</td>

</tr>
<%

java.util.Enumeration eu = Node.find(sql.toString(),pos,size);
if(!eu.hasMoreElements())
{
	out.print("<tr><td colspan=20 align=center>暂无记录</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
	
 	int nid = ((Integer)eu.nextElement()).intValue();
  	Node nobj = Node.find(nid);
  	
  	Files eobj = Files.find(nid,teasession._nLanguage);
  	
  %>
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="">  
    <td nowrap="nowrap"><a href="/html/files/<%=nid%>-<%=teasession._nLanguage%>.htm" target="_blank"><%=nobj.getSubject(teasession._nLanguage) %></a></td>
    <td nowrap="nowrap"><%=eobj.getAuthor() %></td>
    <td nowrap="nowrap"><%=eobj.getUnitname() %></td>
    <td nowrap> 
    <a href="###" onclick="f_cz('<%=nid%>');" >操作</a>

    </td> 
  </tr> 
  <tr id="trid<%=nid %>" style="display:none">
  	<td align="right" colspan="10">
  		<%-- <a href="###"  onclick="window.open('/jsp/type/meeting/WestracMeetingShow.jsp?node=<%=nid%>&nexturl=<%=nexturl%>','_self');">详细</a>&nbsp; --%>
  		<a href="###"  onclick="window.open('/jsp/type/meeting/WestracEditMeetingFiles.jsp?EditNode=ON&Type=41&node=<%=nid%>&nexturl=<%=URLEncoder.encode(nexturl)%>','_self');">编辑</a>&nbsp;
  		<%-- <a href="###" onclick="window.open('/jsp/type/meeting/WestracMeetingFiles.jsp?Type=41&node=<%=fileNode._nNode%>&nexturl=<%=nexturl%>','_self');">上传资料</a>&nbsp; --%>
  		<a href="###"  onClick="f_delete('<%=nid%>');" >删除</a>&nbsp;
  		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  	</td>
  </tr>
 
  <%
  }
  %>
  <% 
  	if(count>size){
  %>
  <tr><td colspan="20"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
<%} %>
  </table>
</form>
</body>
</html>
