<%@page import="tea.entity.node.MeetingApplicants"%>
<%@page import="tea.entity.node.MeetingInvite"%>
<%@page import="tea.entity.node.Album"%>
<%@page import="tea.ui.node.type.album.Albums"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
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

  
 String album = teasession.getParameter("album");

StringBuffer sql=new StringBuffer(),param=new StringBuffer();

String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

Profile p=Profile.find(teasession._rv._strV);
//AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
int profile=p.profile;

sql.append(" and ma.profile="+profile);
param.append("?profile="+profile);

//会议名称
String subject=teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
	subject=subject.trim();
  
  sql.append(" and  exists (select node from NodeLayer nl where ymi.node=nl.node and nl.subject like "+DbAdapter.cite("%"+subject+"%")+" ) ");
  param.append("&subject=").append(URLEncoder.encode(subject,"UTF-8")); 
}

int pos=0,size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

//sql.append(" AND m.timeStop>=getdate()");
int count = MeetingApplicants.count(sql.toString());

sql.append(" order by m.time desc ");


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

function f_enroll(nid,adminunitid)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
	 var url = '/jsp/type/meeting/WestracMeetingApplicants.jsp?t=&node='+nid+'&adminunitid='+adminunitid;
	 var rs = window.showModalDialog(url,self,y);
}

function f_enroll2(nid,adminunitid)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
	 var url = '/jsp/type/meeting/WestracMeetingRegistration.jsp?t=&node='+nid+'&adminunitid='+adminunitid;
	 var rs = window.showModalDialog(url,self,y);
}

 
</script>
<h1>会议管理列表</h1>
<form name="form2" action="?" method="POST">
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="album" value="<%=album %>" >

<input type="hidden" name="node" value="<%=teasession._nNode %>" >

<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter"> 
	<tr>
		<td align="right">会议名称：</td>
		<td><input type="text" name="subject" value="<%=Entity.getNULL(subject) %>"> </td>
		 <td colspan="10" align="left"><input type="submit" value="查询" /></td>
	</tr>

</table>
</form>
<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;个会议&nbsp;)&nbsp;&nbsp;

</h2>

<form name="form1" action="?" method="GET">

<input type="hidden" name="act" >
<input type="hidden" name="album" value="<%=album %>" >

<input type="hidden" name="node" value="<%=teasession._nNode %>" >




<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
 
      <td nowrap>会议名称</td>
      <td nowrap>会议地址</td>
      <td nowrap>组织单位 </td>
      <td nowrap>报名时间</td>
      <td nowrap>举行时间</td>
      
      <td nowrap>操作</td>
     

</tr>
<%
if(count<1)
{
	out.print("<tr><td colspan=20 align=center>暂无记录</td></tr>");
}
ArrayList enList = MeetingApplicants.find(sql.toString(),pos,size);
for(int i=0;i<enList.size();i++)
{
	MeetingApplicants ma = (MeetingApplicants)enList.get(i);
  	
  	int nid = ma.getNode();
  	Node nobj = Node.find(nid);
  	Meeting eobj = Meeting.find(nid,teasession._nLanguage);
  	
  %>
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="">  
    <td nowrap="nowrap"><a href="/html/event/<%=nid%>-<%=teasession._nLanguage%>.htm" target="_blank"><%=nobj.getSubject(teasession._nLanguage) %></a></td>
    <td nowrap="nowrap"><%=eobj.getProvince()+"&nbsp;"%><%if(!"-市-".equals(eobj.getCity2() ))out.print(eobj.getCity2() ); %></td>
    <td nowrap="nowrap"><%=eobj.getCorp() %></td>
    <td nowrap="nowrap"><%
    if(eobj.getTimeStart()!=null)
    {
    	out.println(Entity.sdf.format(eobj.getTimeStart()));
    }
    if(eobj.getTimeStop()!=null)
    {
    	out.println("-");
    	out.println(Entity.sdf.format(eobj.getTimeStop()));
    }
  %></td>
  <td nowrap="nowrap"><%
    if(eobj.getTimeHoldStart()!=null)
    {
    	out.println(Entity.sdf.format(eobj.getTimeHoldStart()));
    }
    if(eobj.getTimeHoldStop()!=null)
    {
    	out.println("-");
    	out.println(Entity.sdf.format(eobj.getTimeHoldStop()));
    }
  %></td>
    <td nowrap> 
    <%
    out.println("<a href='/html/category/"+eobj.getFiles()+"-"+teasession._nLanguage+".htm'  >下载</a>");
	%>
	
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
