<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.resource.Common" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.admin.sales.*" %>>
<%@ page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

int laid = 0;
if(teasession.getParameter("laid")!=null && teasession.getParameter("laid").length()>0)
	laid = Integer.parseInt(teasession.getParameter("laid"));

String bschanceholder=null,bschancename=null,dates=null,chance=null,
money=null, nexts=null,remark=null,member=null,bsupdatename=null,timelook=null,timeupdate=null;
boolean clienttype=false;
//int //origin=0,moments=0,types=0,type=0,moment=0,latencyclient=0;
int type=0,moment=0,latencyclient=0,clientname=0;
Saleschance laobj = Saleschance.find(laid);
if(laid>0)
{
	bschanceholder = laobj.getbschanceholder();
	bschancename = laobj.getbscname();
	clientname =laobj.getClientname();
	clienttype = laobj.getClienttype();
	type = laobj.getType();
	dates = laobj.getDatesToString();
	moment = laobj.getMoment();
	chance = laobj.getChance();
	money = laobj.getMoney();
	latencyclient = laobj.getLatencyclient();
	nexts = laobj.getNexts();
	remark = laobj.getRemark();
	member = laobj.getMember();
	bsupdatename = laobj.getBsupdatename();//修改人
	timelook = laobj.getTimelookToString();
	timeupdate = laobj.getTimeupdateToString();
}
if(teasession.getParameter("delete")!=null)
{
	laobj.delete();
	response.sendRedirect("/jsp/admin/sales/saleschanceview.jsp");
	return;
}
%>
<%
java.util.Date   date=new   java.util.Date();
timeupdate = Saleschance.sdf.format(date);
timelook =Saleschance.sdf.format( date);
 %>
 <script>   
  function   sub(){   
        if(/\D/.test(form1.money.value))
        {
        	alert("只能输入数字");
        	form1.money.select();
        	return   false;
        }   
        else
		  	return   true;   
  }   
  </script>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<h1>客户机会添加</h1>
<form name=form1 METHOD=doGet  action="/servlet/SaleschanceServlet" onsubmit="return sub();">
 <input type="submit" value="保存" name="submit"> &nbsp;&nbsp;<input type="submit" value="保存并新建" name="submit">
&nbsp;&nbsp;<input type="button" value="取消" onClick="location='/jsp/admin/sales/saleschance.jsp'">
<input type="button" value="返回" onClick="location='/jsp/admin/sales/Saleschanceview.jsp'">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type ="hidden" name="laid" value="<%=laid %>">
<input type ="hidden" name="timeupdate" value="<%=timeupdate%>"><!--修改时间    -->
<input type ="hidden" name="timelook" value="<%=timelook%>"><!-- --cha -->
<input type ="hidden" name="bsupdatename" value="<%=teasession._rv  %>">


<tr>
	    <td nowrap>业务机会所有人:</td>
	    <td nowrap><%=teasession._rv %></td>
	</tr>
	<tr >
	    <td nowrap>业务机会名称:</td><td nowrap><input type="text" name="bschancename" size="27" value="<%if(bschancename!=null)out.print(laobj.getbscname()) ;%>"></td>
	</tr>
	<tr >
	    <td>客户</td>
      <td>
      <input type=hidden name=clienttype value="<%=clienttype%>" >
      <select name="client" onChange="f_client(this.selectedIndex);">
      <option value="0">-------------
         <%
         int len=0;
         java.util.Enumeration e= Latency.findByCommunity(teasession._strCommunity,"");
          while(e.hasMoreElements())
          {
        	int id=((Integer)e.nextElement()).intValue();
        	Latency l=Latency.find(id);
			out.print("<option value="+id);
			if(!clienttype&&clientname==id)
			out.print(" SELECTED ");
			out.print(" >"+l.getFamily()+l.getFirsts());
			len++;
          }
          e= Workproject.find(teasession._strCommunity,"",0,200);
          while(e.hasMoreElements())
          {
        	int id=((Integer)e.nextElement()).intValue();
        	Workproject wp=Workproject.find(id);
			out.print("<option value="+id);
			if(clienttype&&clientname==id)
			out.print(" SELECTED ");
			out.print(" >"+wp.getName(teasession._nLanguage));
          }
          %>
      </select><input type="button" value="..." onclick="window.open('/jsp/admin/sales/clientserver.jsp?community=<%=teasession._strCommunity%>&client=form1.client&clienttype=form1.clienttype','','width=550,height=400,top='+(screen.height-400)/2+',left='+(screen.width-550)/2+',scrollbars=0,resizable=0,status=0');" >
      <script type="text/javascript">
      function f_client(v)
      {
      	form1.clienttype.value=v><%=len%>;
      }
      </script>
      </td>
	</tr>
	<tr>

		<td nowrap>类型:</td>
		<td nowrap><select name="type">
			<%
					for(int i=0;i<Saleschance.TYPES.length;i++)
					{
						out.print("<option value="+i);
						if(type==i)
							out.print(" selected");
						out.print(">"+Saleschance.TYPES[i]);
						out.print("</option>");
					}
			%>
			</select></td>
	</tr>
	<tr >
	    <td nowrap>结束时间：</td><td nowrap><input type="text" name="dates" size="27" value="<% if (dates!=null)out.print(laobj.getDates()); %>"><a href=### onclick="showCalendar('form1.dates');"><img src=/tea/image/public/Calendar2.gif ></a></td>
	</tr>
	<tr>
		<td nowrap>阶段:</td>
		<td nowrap><select name="moment">
				<%
					for(int i=0;i<Saleschance.MOMENTS.length;i++)
					{
						out.print("<option value="+i);
						if(latencyclient==i)
							out.print(" selected");
						out.print(">"+Saleschance.MOMENTS[i]);
						out.print("</option>");
					}
			%>
			</select></td>
	</tr>
	<tr>
		<td nowrap>可能性：</td><td nowrap><input type="text" name="chance" size="27" value="<% if(laobj.getChance()!=null)out.print(laobj.getChance()); %>"></td>
	</tr>
	<tr>
		<td nowrap>金额：</td><td nowrap><input type="text" name="money" size="27" value="<% if(laobj.getMoney()!=null)out.print(laobj.getMoney()); %>"></td>
	</tr>
	<tr>
		<td nowrap>潜在客户来源：</td><td nowrap><select name="latencyclient">
				<%
				for(int i=0;i<Saleschance.ORIGIN.length;i++)
					{
						out.print("<option value="+i);
						if(latencyclient==i)
							out.print(" selected");
						out.print(">"+Saleschance.ORIGIN[i]);
						out.print("</option>");
					}
				%>
			</select></td></tr>
	<tr>
		<td nowrap>下一步：</td><td nowrap><input type="text" name="nexts" size="27" value="<% if(laobj.getNexts()!=null)out.print(laobj.getNexts()); %>"></td>
	</tr>
	<tr>
		<td nowrap>备注：</td><td nowrap><textarea cols=37 rows=3 name="remark" wrap="yes" ><% if(laobj.getRemark()!=null)out.print(laobj.getRemark()); %></textarea></td>
	</tr>
</table>
 <input type="submit" value="保存" name="submit"> &nbsp;&nbsp;<input type="submit" value="保存并新建" name="submit">
&nbsp;&nbsp;<input type="button" value="取消" onClick="location='/jsp/admin/sales/saleschance.jsp'">
</FORM>
</body>
</html>




