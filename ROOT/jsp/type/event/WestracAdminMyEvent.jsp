<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
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
String community=teasession._strCommunity;



if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}

  
 

 String member = teasession.getParameter("member");

StringBuffer sql=new StringBuffer(" and member="+DbAdapter.cite(member)+"  and community = ").append(DbAdapter.cite(community));
StringBuffer param=new StringBuffer();

String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

param.append("?community="+teasession._strCommunity);
param.append("&id=").append(request.getParameter("id"));
param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));

String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
	sql.append(" and exists (select member from NodeLayer nl where nl.node=Eventregistration.node and nl.subject like "+DbAdapter.cite("%"+subject+"%")+" )");	
	param.append("&subject=").append(URLEncoder.encode(subject,"UTF-8"));
}

String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" and exists (select node from Event e where e.node = Eventregistration.node and e.timeHoldStart >="+DbAdapter.cite(time_c)+")");
  param.append("&time_c=").append(time_c);
}

String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  
  sql.append(" and exists (select node from Event e where e.node = Eventregistration.node and e.timeHoldStop<="+DbAdapter.cite(time_d)+")");
  param.append("&time_d=").append(time_d);
}

int pos=0,size=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

int count = Eventregistration.Count(teasession._strCommunity,sql.toString());

sql.append(" order by times desc ");








%>
<html>
<base target="tar"/>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">


  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>
  <script src="/tea/Calendar.js" type="text/javascript"></script>
  <script src="/tea/city.js"></script>

</HEAD>
<script type="text/javascript">
window.name='tar';
//修改申请表
function f_Wer(igd,igd2)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
	 var url = '/jsp/type/event/WestracEventRegistration.jsp?t='+new Date().getTime()+"&node="+igd2+"&eid="+igd+"&community="+form1.community.value;
	 var rs = window.showModalDialog(url,self,y);

}
//查看详细
function f_Wershow(igd,igd2)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
	 var url = '/jsp/type/event/WestracEventRegistrationShow.jsp?t='+new Date().getTime()+"&node="+igd2+"&eid="+igd+"&community="+form1.community.value;
	 var rs = window.showModalDialog(url,self,y);
}
function f_Score(igd)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:430px;dialogHeight:160px;';
	 var url = '/jsp/type/event/WestracEventScore.jsp?t='+new Date().getTime()+"&eid="+igd+"&community="+form1.community.value;
	 var rs = window.showModalDialog(url,self,y);

}
</script> 
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<h1>俱乐部会员：<%=member %>&nbsp;&nbsp;参与过的活动</h1>
<form name="form1" action="?" method="POST" target="tar" >
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<input type="hidden" name="community" value="<%=teasession._strCommunity%>">

<input type="hidden" name="member" value="<%=member %>">
<input type="hidden" name="act" >

<h2>查询</h2>
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">

 <tr>
 	<td align="right">活动时间：</td>
 	<td> 从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />


</td>
 
 	<td align="right">活动名称：</td>
 	<td><input type="text" name="subject" value=""></td>
 	<td><input type="submit"  value="查询"></td>
 </tr>
 
 
 </table>
 


<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;个活动&nbsp;)&nbsp;&nbsp;</h2>
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
 
      <td nowrap>活动时间</td>
      <td nowrap>活动类型</td>
      <td nowrap>活动名称</td>
      <td nowrap>所获积分 </td>
      <td nowrap>活动状态</td>
      <td nowrap>报名状态</td>    
      <td>操作</td>
</tr>
<%



java.util.Enumeration eu = Eventregistration.find(teasession._strCommunity,sql.toString(),pos,size);
if(!eu.hasMoreElements())
{
	out.print("<tr><td colspan=20 align=center>暂无记录</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
	
 	int eid = ((Integer)eu.nextElement()).intValue();
 	Eventregistration eobj = Eventregistration.find(eid);
 	Profile p = Profile.find(eobj.getMember());
	Event eventobj = Event.find(eobj.getNode(),teasession._nLanguage);
	Node nobj = Node.find(eobj.getNode());
 	
	
  %>
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="">  
 
    <td nowrap="nowrap">开始：<%if(eventobj.getTimeHoldStart()!=null)out.print(Entity.sdf.format(eventobj.getTimeHoldStart()));%>
    结束：<%if(eventobj.getTimeHoldStop()!=null)out.print(Entity.sdf.format(eventobj.getTimeHoldStop()));%>
    </td>
	<td nowrap><%=Event.EVENT_TYPE[eventobj.getEventtype()] %></td>
   <td nowrap><%=nobj.getSubject(teasession._nLanguage) %></td>
   <td nowrap>积分</td>
   <td nowrap><%=Event.AUDIT_TYPE[nobj.getAudit()] %></td>
   <td>
   	<%
   	String vstr = null;
   		if(eobj.getVerifg()==0)
   		{
   			vstr = "等待审核";
   		}else if(eobj.getVerifg()==1)
   		{
   			vstr = "已审核";
   			if(eobj.getConfirmtype()==1)
   			{
   				vstr ="已参加";
   			}else if(eobj.getConfirmtype()==2)
   			{
   				vstr = "未参加";
   			}
   			
   		}
   		out.print(vstr);
   	%>
   </td>
   <td>
 
   <%
   
   		out.println("<a href=\"###\" onclick=\"f_Wershow('"+eid+"','"+eobj.getNode()+"');\">查看报名表</a>");
  
   %>
   
   </td>
  </tr> 
  
 
 
  <%
  }
  %>
  <%if(count>size){ %>
      <tr>
        <td colspan="3" align="right">
      <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>    
      </td> </tr>
      <%} %>
  </table>
</form>
</body>
</html>
