<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.sales.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.net.URLEncoder"%>
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

String _strId=request.getParameter("id");

StringBuffer param=new StringBuffer("?community="+community);
param.append("&id=").append(_strId);

StringBuffer sql=new StringBuffer();
sql.append(" AND member=").append(DbAdapter.cite(teasession._rv.toString()));

String motif = request.getParameter("motif");
if(motif!=null && (motif.trim()).length()>0)
{
	sql.append(" AND motif LIKE ").append(DbAdapter.cite("%"+motif+"%"));
 	param.append("&motif=").append(URLEncoder.encode(motif,"UTF-8"));
}

String attime = request.getParameter("attime");
if(attime!=null && (attime.trim()).length()>0)
{
	sql.append(" AND attime=").append(DbAdapter.cite(attime));
	param.append("&attime=").append(attime);
}
int fettle =0;
if(request.getParameter("fettle")!=null && request.getParameter("fettle").length()>0)
{
	fettle = Integer.parseInt(request.getParameter("fettle"));
	if(fettle!=0)
	{
		sql.append(" and fettle=").append(fettle);
		param.append("&fettle=").append(fettle);
	}
}

int pos2=0;
if(request.getParameter("pos2")!=null)
{
	pos2=Integer.parseInt(request.getParameter("pos2"));

}

String order=request.getParameter("order");
		if(order==null)
		order="times";
		param.append("&order=").append(order);

		String desc=request.getParameter("desc");
		if(desc==null)
		desc="desc";
		param.append("&desc=").append(desc);



int count2=Task.count(community,sql.toString());
param.append("&pos2=");


sql.append(" ORDER BY ").append(order).append(" ").append(desc);




%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_export()
{
  form2.act.value="exporttask";
  form2.action="/servlet/EditTask";
  form2.submit();
}
function f_edit(id)
{
  form2.action="/jsp/admin/sales/Newclienttask.jsp";
  form2.taid.value=id;
  form2.submit();
}
function f_delete(id)
{
 if(confirm('您确定要删除此内容吗？'))
 {
    form2.action="/jsp/admin/sales/Newclienttask.jsp?taid="+id+"&delete=delete";
    form2.taid.value=id;
    form2.submit();
 }
}
</script>
</head>
<body>
<h1>我的任务管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="?" method="post">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="id" value="<%=_strId%>">
<input type="hidden" name="act">
<input type="hidden" name="sql" value="<%=sql%>">
<input type="hidden" name="taid">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
	<td nowrap>任务主题：</td>
	<td nowrap><input type="text" name="motif" value="<%if(motif!=null)out.print(motif);%>"></td>
	<td nowrap>到期日期:<input name="attime" size="10"  value="<%if(attime!=null)out.print(attime);%>" readonly><A href="###"><img onClick="showCalendar('form2.attime');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td>
	<td nowrap>完成状态:</td><td nowrap><select name="fettle">
			<%
				for(int i=0;i<Task.FETTLE.length;i++)
				{
					out.print("<option value="+i);
					if(fettle==i)
						out.print(" selected");
					out.print(">"+Task.FETTLE[i]);
					out.print("</option>");
				}
			 %>
		</select>

		</td>
		<td><input type="submit" value=" 查 询 "></td>
	</tr>
</table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>我的需求管理</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
    <td nowrap>任务主题</td>
	<td nowrap>状态</td>
	<td nowrap>创建时间</td>
	<td nowrap>任务接纳人</td>
	<td nowrap>所属项目</td>
	<td nowrap>操作</td>
</tr>
<%

	Enumeration tame2 = Task.findByCommunity(teasession._strCommunity,sql.toString(),pos2,10);
	while(tame2.hasMoreElements())
	{
		int taid2 = ((Integer)tame2.nextElement()).intValue();
		Task obj = Task.find(taid2);
        Flowitem fobj = Flowitem.find(obj.getFlowitem());
 %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><a href="/jsp/admin/sales/task_inof.jsp?taid=<%=taid2 %>"><%=obj.getMotif() %></a></td>
	<td nowrap><%=Task.FETTLE[obj.getFettle()] %></td>
	<td nowrap><%=obj.getTimesToString()%></td>
	<td nowrap><%=obj.getAssigneridToString(teasession._nLanguage)%></td>
    <td nowrap><%=fobj.getName(teasession._nLanguage)%></td>
	<td nowrap><a href="javascript:f_edit(<%=taid2%>);">编辑</a>
	<a href="javascript:f_delete(<%=taid2%>);">删除</a></td>
</tr>
<%
	}
 %>
<tr><td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos2,count2,10)%></td></tr>
</table>

<input type="hidden" name="files" value="tasks">

<input type="button" value="新建任务" onClick="location='/jsp/admin/sales/Newclienttask.jsp'">&nbsp;&nbsp;&nbsp;
<input type="button" value="导出Excel表" onclick="f_export();">

</body>
</html>



