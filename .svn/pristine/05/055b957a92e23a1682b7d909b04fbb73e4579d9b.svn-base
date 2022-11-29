<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.sales.*" %>
<%@page import="java.util.*" %>
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
String cm=teasession._rv.toString();

StringBuffer param=new StringBuffer();
param.append("?community=").append(community);
param.append("&id=").append(_strId);

StringBuffer sql=new StringBuffer();

//接纳人中必须有我 and 任务还没有委托去出
sql.append(" AND ( (assignerid LIKE ").append(DbAdapter.cite("%/"+cm+"/%")).append(" AND id NOT IN ( SELECT task FROM TaskConsign ) )");

//'我要做的任务'中显示 委托给我的任务/////
sql.append(" OR id IN ( SELECT task FROM TaskConsign WHERE consign LIKE ").append(DbAdapter.cite("%/"+cm+"/%")).append("))");

StringBuffer sql2=new StringBuffer();
sql2.append(" AND member=").append(DbAdapter.cite(cm));
sql2.append(" AND assignerid NOT LIKE ").append(DbAdapter.cite("%/"+cm+"/%"));


StringBuffer sql3=new StringBuffer();//委托
sql3.append(" AND tc.assigner=").append(DbAdapter.cite(cm));
sql3.append(" AND t.assignerid LIKE ").append(DbAdapter.cite("%/"+cm+"/%"));

String motif = request.getParameter("motif");
if(motif!=null && (motif.trim()).length()>0)
{
  sql.append(" AND motif LIKE ").append(DbAdapter.cite("%"+motif+"%"));
  sql2.append(" AND motif LIKE ").append(DbAdapter.cite("%"+motif+"%"));
  sql3.append(" AND t.motif LIKE ").append(DbAdapter.cite("%"+motif+"%"));
  param.append("&motif=").append(URLEncoder.encode(motif,"UTF-8"));
}

String attime = request.getParameter("attime");
if(attime!=null && (attime.trim()).length()>0)
{
  sql.append(" AND attime=").append(DbAdapter.cite(attime));
  sql2.append(" AND attime=").append(DbAdapter.cite(attime));
  sql3.append(" AND t.attime=").append(DbAdapter.cite(attime));
  param.append("&attime=").append(attime);
}

int fettle=0;
String _strFettle=request.getParameter("fettle");
if(_strFettle!=null&&_strFettle.length()>0)
{
  fettle = Integer.parseInt(_strFettle);
  if(fettle!=0)
  {
    sql.append(" AND fettle=").append(fettle);
    sql2.append(" AND fettle=").append(fettle);
    sql3.append(" AND t.fettle=").append(fettle);
  }
  param.append("&fettle=").append(fettle);
}else
{
  sql.append(" AND fettle=").append(1);
  sql2.append(" AND fettle=").append(1);
  sql3.append(" AND t.fettle=").append(1);
  param.append("&fettle=").append(1);
}

int flowitem=-1;
String _strFlowitem=request.getParameter("flowitem");
if(_strFlowitem!=null&&_strFlowitem.length()>0)
{
	flowitem=Integer.parseInt(_strFlowitem);
	sql.append(" AND flowitem=").append(flowitem);
  	sql2.append(" AND flowitem=").append(flowitem);
  	sql3.append(" AND t.flowitem=").append(flowitem);
	param.append("&flowitem=").append(flowitem);
}

////////////////我要做的任务//////提交人//////
String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
	sql.append(" AND member=").append(DbAdapter.cite(member));
	param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}

////////////////我分配的任务//////接纳人//////
String assignerid=request.getParameter("assignerid");
if(assignerid!=null&&assignerid.length()>0)
{
	sql2.append(" AND assignerid=").append(DbAdapter.cite(assignerid));
	param.append("&assignerid=").append(URLEncoder.encode(assignerid,"UTF-8"));
}

//////////////分页////////////////////
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
int count=Task.count(community,sql.toString());
param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="times";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);
///////////////////////////
int pos2=0;
if(request.getParameter("pos2")!=null)
{
  pos2=Integer.parseInt(request.getParameter("pos2"));
}
int count2=Task.count(community,sql2.toString());
param.append("&pos2=").append(pos2);
sql2.append(" ORDER BY ").append(order).append(" ").append(desc);
///////////////////////////
int pos3=0;
if(request.getParameter("pos3")!=null)
{
  pos3=Integer.parseInt(request.getParameter("pos3"));
}
int count3=TaskConsign.count(community,sql3.toString());
param.append("&pos3=").append(pos3);



%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_edit(v)
{
  form3.nexturl.value=location;
  form3.taid.value=v;
  form3.action="/jsp/admin/sales/newzhuangtai.jsp";
  form3.submit();
}
function f_consign(v)
{
  form3.nexturl.value=location;
  form3.taid.value=v;
  form3.action="/jsp/admin/sales/EditTaskConsign.jsp";
  form3.submit();
}
function f_back(v)
{
  form3.nexturl.value=location;
  form3.taid.value=v;
  form3.method="POST";
  form3.act.value="deletetaskconsign";
  form3.action="/servlet/EditTask";
  form3.submit();
}
</script>
</head>
<body>
<h1>我的任务管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>



<form name="form2" action="?">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="id" value="<%=_strId%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
	<td nowrap>任务主题:<input type="text" name="motif" value="<%if(motif!=null)out.print(motif);%>"></td>
	<td nowrap>到期日期:<input name="attime" size="10" value="<%if(teasession.getParameter("attime")!=null)out.print(teasession.getParameter("attime")); %>" readonly><A href="#"><img onClick="showCalendar('form2.attime');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td>
	<td nowrap>所属项目:
     <select name="flowitem" >
      <option value="">------------------</option>
      <%
        Enumeration flme = Flowitem.find(teasession._strCommunity, "");
        while (flme.hasMoreElements())
        {
          int flid = ((Integer) flme.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if (flobj.getManager().indexOf("/"+cm+"/") != -1 || flobj.getMember().indexOf("/"+cm+"/") != -1)
          {
            out.print("<option value=" + flid);
            if (flid == flowitem)
            out.print(" selected ");
            out.print(" >" + flobj.getName(teasession._nLanguage));
          }
        }
      %>
    </select><input type="button" value="..." onClick="window.open('/jsp/admin/workreport/Workprojects_2.jsp?community=<%=teasession._strCommunity%>&fieldname=form2.flowitem','','height=500,width=500,left=200,top=100,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');"/>	</td></tr><tr><td nowrap>完成状态:<select name="fettle">
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

	<td nowrap>提交人:<select name="member">
	<option value="">-----------
	<%
	Enumeration e=Task.findByAssignerid(teasession._strCommunity,cm);
	while(e.hasMoreElements())
	{
		String m=(String)e.nextElement();
		Profile p=Profile.find(m);

		out.print("<OPTION VALUE="+m);
		if(m.equals(member))
		out.print(" SELECTED ");
		out.print(">"+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
	}
	%>
	</select></td>
	<td nowrap>接纳人:<select name="assignerid">
	<option value="">-----------
	<%
	Enumeration e2=Task.findByMember(teasession._strCommunity,cm);
	while(e2.hasMoreElements())
	{
		String m=(String)e2.nextElement();
		Profile p=Profile.find(m);
		if(p.getTime()!=null)
		{
			out.print("<OPTION VALUE="+m);
			if(m.equals(assignerid))
			out.print(" SELECTED ");
			out.print(">"+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
		}
	}
	%>
	</select>　　
	  <input name="submit" type="submit" value=" 查 询 "></td>
	</tr>
</table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>我要做的任务</h2>
<form method="POST" action="/servlet/EditExportExcel" name="form3">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="nexturl" value="">
<input type="hidden" name="taid" value="">
<input type="hidden" name="act" value="">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
    <td nowrap>任务主题</td>
	<td nowrap>状态</td>
	<td nowrap>创建时间</td>
	<td nowrap>任务分配人</td>
	<td nowrap>所属项目</td>
	<td nowrap>操作</td>
</tr>
<%
Enumeration tame = Task.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
while(tame.hasMoreElements())
{
	int taid = ((Integer)tame.nextElement()).intValue();
	Task taobj = Task.find(taid);
	assignerid=taobj.getAssignerid();
	fettle=taobj.getFettle();

	Flowitem fobj = Flowitem.find(taobj.getFlowitem());

    Profile probj = Profile.find(taobj.getMember());
    boolean bool=assignerid.indexOf("/"+cm+"/")==-1;//是否已经委托过

%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><a href="/jsp/admin/sales/task_inof.jsp?taid=<%=taid %>"><%=taobj.getMotif()%></a></td>
	<td nowrap><%=Task.FETTLE[fettle]%></td>
	<td nowrap><%=taobj.getTimesToString()%></td>
	<td nowrap><%
        out.print(probj.getName(teasession._nLanguage));
        if(bool)
        {
            out.println(" / ");
            Enumeration e3=TaskConsign.findByCommunity(teasession._strCommunity," AND task="+taid+" AND consign LIKE "+DbAdapter.cite("%/"+cm+"/%"));
            while(e3.hasMoreElements())
            {
              String a=(String)e3.nextElement();
              Profile p = Profile.find(a);
              out.println(p.getName(teasession._nLanguage));
            }
        }
        %></td>
        <td nowrap><%=fobj.getName(teasession._nLanguage) %></td>
	<td nowrap><a href ="javascript:f_edit(<%=taid%>);">编辑任务状态</a>
	<%
	//接纳人中有我,才可以进行委托 && 任务未完成
	if(!bool&&fettle!=2)
	{
	  out.println("<a href=javascript:f_consign("+taid+");>委托</a>");
	}
	%>
	</td>
</tr>
<%
}
%>
 <tr><td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
</table>

<h2>我分配的任务</h2>
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

	Enumeration tame2 = Task.findByCommunity(teasession._strCommunity,sql2.toString(),pos2,10);
	while(tame2.hasMoreElements())
	{
		int taid2 = ((Integer)tame2.nextElement()).intValue();
		Task taobj2 = Task.find(taid2);
		Flowitem fobj2 = Flowitem.find(taobj2.getFlowitem());

 %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><a href="/jsp/admin/sales/task_inof.jsp?taid=<%=taid2 %>"><%=taobj2.getMotif() %></a></td>
	<td nowrap><%=Task.FETTLE[taobj2.getFettle()] %></td>
	<td nowrap><%=taobj2.getTimesToString()%></td>
	<td nowrap><%
           String ass[] =taobj2.getAssignerid().split("/");
           for(int i =1;i<ass.length;i++)
           {
        	 Profile probj = Profile.find(ass[i]);
             if(probj.getTime()!=null)
             {
               out.print(probj.getLastName(teasession._nLanguage)+probj.getFirstName(teasession._nLanguage)+"&nbsp;");
             }
           }
        %></td>
	<td nowrap><%=fobj2.getName(teasession._nLanguage) %></td>
	<td nowrap><a href ="/jsp/admin/sales/newtask.jsp?taid=<%=taid2%>&nexturl=/jsp/admin/sales/task.jsp'"><img alt="" src="/tea/image/public/icon_edit.gif" /></a> &nbsp;<a href="/jsp/admin/sales/newtask.jsp?taid=<%=taid2 %>&delete=delete" onClick="return window.confirm('您确定要删除此内容吗？');"> <img alt="" src="/tea/image/public/del.gif" /></a></td>
</tr>
<%
	}
 %>
<tr><td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos2=","&")+"&pos2=",pos2,count2,10)%></td></tr>
</table>

<input type="hidden" name="sql" value="<%=sql %>">
<input type="hidden" name="files" value="tasks">
<input type="button" value="新建任务" onClick="location='/jsp/admin/sales/newtask.jsp'">&nbsp;&nbsp;&nbsp;
<input type="submit" name="exportall" value="导出Excel表" >


<h2>我委托的任务</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
    <td nowrap>任务主题</td>
	<td nowrap>状态</td>
	<td nowrap>委托时间</td>
	<td nowrap>委托接纳人</td>
	<td nowrap>所属项目</td>
	<td nowrap>操作</td>
</tr>
<%
Enumeration e3=TaskConsign.findByCommunity(teasession._strCommunity,sql3.toString(),pos3,count3);
while(e3.hasMoreElements())
{
  int task=((Integer)e3.nextElement()).intValue();
  Task obj = Task.find(task);
  TaskConsign tc=TaskConsign.find(task,cm);
  Flowitem fi = Flowitem.find(obj.getFlowitem());

  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td><a href=/jsp/admin/sales/task_inof.jsp?taid="+task+">"+obj.getMotif()+"</a></td>");
  out.print("<td nowrap>"+Task.FETTLE[obj.getFettle()]);
  out.print("<td nowrap>"+tc.getTimeToString());
  out.print("<td nowrap>");
  String cs[] =tc.getConsign().split("/");
  for(int i =1;i<cs.length;i++)
  {
    Profile probj = Profile.find(cs[i]);
    out.print(probj.getLastName(teasession._nLanguage)+probj.getFirstName(teasession._nLanguage)+" ");
  }
  out.print("<td nowrap>"+fi.getName(teasession._nLanguage));
  out.print("<td nowrap><a href=javascript:f_back("+task+")>收回</a>");
}
%>
</table>
</form>

</body>
</html>



