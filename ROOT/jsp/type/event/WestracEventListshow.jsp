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




int pos=0,size = 3;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count = Node.count(sql.toString());



sql.append(" ORDER BY node DESC");




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
 <div class="content1Left">
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr>
	<td class="title">
		<a href="###" onClick="f_data('0');">活动特区</a></td></tr>
        <tr>
        <td class="ACTime">

		<span id="weshow<%if(data==1){out.print("_id");} %>"><a href="###" onClick="f_data('1');">未来一周</a></span>
		<span id="weshow<%if(data==2){out.print("_id");} %>"><a href="###" onClick="f_data('2');">未来一个月</a></span>
		<span id="weshow<%if(data==3){out.print("_id");} %>"><a href="###" onClick="f_data('3');">未来全部</a></span>
		<span id="weshow<%if(data==4){out.print("_id");} %>"><a href="###" onClick="f_data('4');">历史活动</a></span>
	</td>
    </tr>
    <tr><td class="class">分类</td></tr>
    <tr>
	<td class="ACClass">

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
	</td>
</tr>

</table></div>
 <div class="content1Right">
 <div class="title">
 <div class="left">
<a href="###"  onclick="f_data('5');" <%if(data==5)out.println("class=select");%>>近期活动</a>
<a href="###"  onclick="f_data('0');" <%if(data==0)out.println("class=select");%>>最新发布</a>
<a href="###"  onclick="f_data('6');" <%if(data==6)out.println("class=select");%>>历届发布</a>
</div>
<div class="right">
  <%
  	if(count>size){
  %>
  <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%>
<%} %>
</div>
</div>





<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">

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
  	Event eobj = Event.find(nid,teasession._nLanguage);


String te = nobj.Html2Text(nobj.getText(teasession._nLanguage));

  %>
 <tr>
    <td class="left"><img src="<%=eobj.getIntroPicture() %>" width="100"></td><td class="right"><span class="subject"><a href="/html/event/<%=nid %>-<%=teasession._nLanguage %>.htm"><%=nobj.getSubject(teasession._nLanguage) %></a></span>
    		时间：从<%if(eobj.getTimeStart()!=null){out.print(Entity.sdf.format(eobj.getTimeStart()));} %>到
    		<%if(eobj.getTimeStop()!=null)out.print(Entity.sdf.format(eobj.getTimeStop())); %><br>
    		地址：<%=eobj.getProvince()+("-市-".equals(eobj.getCity2())?"":eobj.getCity2())+eobj.getAddress() %><br>
    		内容：<span style="color:#666;"><% if(te!=null && te.length()>50)
    			{
    				out.print(te.substring(0,50)+"...");
    			}else
    			{
    				out.print(te);
    			}
    		%> </span><table cellpadding="0" cellspacing="0"><tr><td class="attention">关注<span><%=nobj.getClick() %></span>人</td><td class="comments">
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

    </td>


  </tr>


  <%
  }
  %>

  </table></div>
</form>
