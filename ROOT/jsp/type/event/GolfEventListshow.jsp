<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Talkback"%>
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
 

StringBuffer sql=new StringBuffer(" and hidden = 0 and type =37 and community = ").append(DbAdapter.cite(community));
StringBuffer param=new StringBuffer();

String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

param.append("?community="+teasession._strCommunity);




int eventtype = 0;
if(teasession.getParameter("eventtype")!=null && teasession.getParameter("eventtype").length()>0)
{
	eventtype = Integer.parseInt(teasession.getParameter("eventtype"));
}

if(eventtype>0)
{
	sql.append(" and exists (select node from Event ev where ev.node = n.node and eventtype ="+eventtype+" )");
	param.append("&eventtype=").append(eventtype);

}

int data=0;
if(teasession.getParameter("data")!=null && teasession.getParameter("data").length()>0)
{
	data = Integer.parseInt(teasession.getParameter("data"));
}

if(data>0)
{
	Date d = new Date();
	Date dd = Entity.getDayTime(d,7);
	if(data==2)//未来一个月
	{
		dd= Entity.getDayTime(d,30); 
	}
	
	if(data==1 || data ==2){
		sql.append(" and exists (  ");
		sql.append("  select node from Event ev where ev.node = n.node ");
		sql.append(" and ev.timeStop >= ").append(DbAdapter.cite(Entity.sdf.format(d)));
		
		sql.append(" and ev.timeStop  <= ").append(DbAdapter.cite(Entity.sdf.format(dd)));
		sql.append(")");
	}else if(data==3)//未来全部
	{
		sql.append(" and exists (  ");
		sql.append("  select node from Event ev where ev.node = n.node ");
		sql.append(" and ev.timeStop >= ").append(DbAdapter.cite(Entity.sdf.format(d)));
		
		
		sql.append(")");
	}else if(data==4)//历史
	{
		sql.append(" and exists (  ");
		sql.append("  select node from Event ev where ev.node = n.node ");
		sql.append(" and ev.timeStop < ").append(DbAdapter.cite(Entity.sdf.format(d)));
		
		
		sql.append(")");
	}else if(data==5)//近期的活动
	{
		sql.append(" and exists (  ");
		sql.append("  select node from Event ev where ev.node = n.node ");
		sql.append(" and ev.timeStart > ").append(DbAdapter.cite(Entity.sdf.format(d)));
		sql.append(")");
	}else if(data==6)//历届活动
	{
		sql.append(" and exists (  "); 
		sql.append("  select node from Event ev where ev.node = n.node ");
		sql.append(" and ev.timeStop < ").append(DbAdapter.cite(Entity.sdf.format(d)));
		sql.append(")");
	}
	param.append("&data=").append(data);

	
}


// out.println(sql.toString());




int pos=0,size = 5;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count = Node.count(sql.toString());


%>

  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>

<script>
	function f_data(igd)
	{
		form1.data.value=igd;
		form1.submit();
	}
	function f_eventtype(igd)
	{
		form1.eventtype.value=igd;
		
		//
		
		form1.submit();
	}
</script>


<form name="form1" action="?" method="GET">
<input type="hidden" name="data" value="<%=data %>">
 <input type="hidden" name="eventtype" value="<%=eventtype %>">

<div class="classification">	
	<span id="eventtypeasd<%if(eventtype==0){out.print("_id");} %>"><a href="###" onClick="f_eventtype('0');">全部</a></span>
	<%
		for(int i=1;i<Event.EVENT_TYPE.length;i++)
		{
			out.print("<span id=eventtypeasd");
			if(eventtype==i)
			{
				out.print("_id");
			}
			
			out.print(">");
			out.print("<a href=\"###\" onclick=\"f_eventtype('"+i+"');\">");
			out.println(Event.EVENT_TYPE[i]);
			out.print("</a>");
			out.print("</span>");
			
			
		}
	%>
</div>
<div class="title">
<table cellpadding="0" cellspacing="0" class="tab1">
<tr><td class="left"><a href="###"  onclick="f_data('5');" <%if(data==5)out.println("class=select");%>>近期活动</a><a href="###"  onclick="f_data('0');" <%if(data==0)out.println("class=select");%>>最新发布</a><a href="###"  onclick="f_data('6');" <%if(data==6)out.println("class=select");%>>历届发布</a></td></tr>
<tr>
    <td class="right">
        <a href="###" onClick="f_data('0');">全部</a>
        <span id="weshow<%if(data==1){out.print("_id");} %>"><a href="###" onClick="f_data('1');">未来一周</a></span>
        <span id="weshow<%if(data==2){out.print("_id");} %>"><a href="###" onClick="f_data('2');">未来一个月</a></span>
        <span id="weshow<%if(data==3){out.print("_id");} %>"><a href="###" onClick="f_data('3');">未来全部</a></span>
        <span id="weshow<%if(data==4){out.print("_id");} %>"><a href="###" onClick="f_data('4');">历史活动</a></span>
    </td>
</tr>
</table>	
</div>

<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<%

java.util.Enumeration eu = Node.find(sql.toString(),pos,size);
if(!eu.hasMoreElements())
{
	out.print("<tr><td colspan=20 align=center class=Norecord>暂无记录</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
	
 	int nid = ((Integer)eu.nextElement()).intValue();
  	Node nobj = Node.find(nid);
  	Event eobj = Event.find(nid,teasession._nLanguage);


String te = nobj.Html2Text(nobj.getText(teasession._nLanguage));
 
  %>
  <tr>
  <td colspan="2" class="biao"><span class="subject"><a href="/html/event/<%=nid %>-<%=teasession._nLanguage %>.htm"><%=nobj.getSubject(teasession._nLanguage) %></a></span></td></tr>
  <tr>
  
  <td colspan="2"><table cellpadding="0" cellspacing="0" class="shij"><tr><td class="td06">时间：从<%if(eobj.getTimeStart()!=null){out.print(Entity.sdf.format(eobj.getTimeStart()));} %>到
    		<%if(eobj.getTimeStop()!=null)out.print(Entity.sdf.format(eobj.getTimeStop())); %></td>
            
            <td class="attention">关注<span><%=nobj.getClick() %></span>人</td><td class="comments">
    		评论<span><%=Talkback.count(" and node = "+nid)%></span>条</td></tr>
            <tr><td colspan="2" class="Message">
    		<%
    			Enumeration e  = Talkback.find(nid,0,1);
    			while(e.hasMoreElements())
    			{ 
    				int tid = ((Integer)e.nextElement()).intValue();
    				Talkback tobj = Talkback.find(tid);
    				out.print("<span>"+tobj.getCreator()._strR+"：</span>");
    				String tc = tobj.getContent(teasession._nLanguage);
    				if(tc!=null && tc.length()>30)
    				{
    					out.print(tc.substring(0,30)+"...");
    				}else
    				{
    					out.print(tc);
    				}
    				
    			}
    		%>
            </td></tr></table>
            </td></tr>
 <tr>  
    <td class="left"><img src="<%=eobj.getIntroPicture() %>" width="100"></td>
    
    <td class="right" valign="top">内容：<span style="color:#666;"><% if(te!=null && te.length()>150)
    			{
    				out.print(te.substring(0,50)+"...");
    			}else
    			{
    				out.print(te);
    			}
    		%> </span>
    		
    </td>
    
 
  </tr> 

 
  <%
  }
  %>

  </table>
  <div class="page">
  <% 
  	if(count>size){
  %>
  <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%>
<%} %>
</div>