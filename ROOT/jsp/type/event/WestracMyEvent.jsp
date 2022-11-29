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

  
 

 

StringBuffer sql=new StringBuffer(" and member="+DbAdapter.cite(teasession._rv.toString())+"  and community = ").append(DbAdapter.cite(community));
StringBuffer param=new StringBuffer();

String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

param.append("?community="+teasession._strCommunity);
param.append("&id=").append(request.getParameter("id"));




int pos=0,size=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

int count = Eventregistration.Count(teasession._strCommunity,sql.toString());

sql.append(" order by times desc ");








%>


  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>
  <script src="/tea/city.js"></script>


<script type="text/javascript">

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

<div class="title">我参与过的活动</div>
<form name="form1" action="?" method="POST" target="tar" >
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<input type="hidden" name="community" value="<%=teasession._strCommunity%>">

<input type="hidden" name="nexturl" value="<%=nexturl %>">
<input type="hidden" name="act" >


<!--<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;个活动&nbsp;)&nbsp;&nbsp;</h2>-->
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter2">
 <tr id="tableonetr">
 
      <td nowrap>活动时间</td>
      <td nowrap>活动类型</td>
      <td nowrap>活动名称</td>
      <td nowrap>活动积分 </td>
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
 
    <td nowrap="nowrap">开始：<%if(eventobj.getTimeStart()!=null)out.print(Entity.sdf.format(eventobj.getTimeStart()));%><br>结束：<%if(eventobj.getTimeStop()!=null)out.print(Entity.sdf.format(eventobj.getTimeStop()));%>
    </td>
	<td nowrap><%=Event.EVENT_TYPE[eventobj.getEventtype()] %></td>
   <td><%=nobj.getSubject(teasession._nLanguage) %></td>
   <td nowrap><%=eventobj.getIntegral() %></td>
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
   <td class="operation">
 
   <%
   	if(eobj.getVerifg()==0)
   	{
   		//如果等待审核，可以修改报名表
   		out.println("<a href=\"###\" onclick=\"f_Wer('"+eid+"','"+eobj.getNode()+"');\" >活动报名表</a>");
   	}else 
   	{
   		out.println("<a href=\"###\" onclick=\"f_Wershow('"+eid+"','"+eobj.getNode()+"');\">查看报名表</a>");
   		if(nobj.getAudit()==4)//活动已经结束可以评论
   	   	{
   	   		out.println("<a href=\"###\" onclick=\"f_Score('"+eid+"');\">我要评论</a>");
   	   	}
   	}
   
   
   
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
