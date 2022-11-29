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
String tmp=request.getParameter("posmytask");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
int count=Task.count(community,sql.toString());
param.append("&posmytask=");

sql.append(" ORDER BY times DESC");


%>

<form method="POST" action="/servlet/EditExportExcel" name="form3">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="nexturl" value="">
<input type="hidden" name="taid" value="">
<input type="hidden" name="act" value="">
<!--marquee behavior="scroll"-->
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter33">
<!--tr >
    <td nowrap>任务主题</td>
	<td nowrap>状态</td>
	<td nowrap>创建时间</td>
	<td nowrap>任务分配人</td>
	<td nowrap>所属项目</td>
	<td nowrap>操作</td>
</tr-->
<%
Enumeration tame = Task.findByCommunity(teasession._strCommunity,sql.toString(),pos,20);

if(!tame.hasMoreElements())
{
  %>
  <tr><td colspan="6" align="left">暂无任务</td>
  </tr>
  <%
}

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
  <tr>
    <td><a href="/jsp/admin/sales/task_inof.jsp?taid=<%=taid %>"><%=taobj.getMotif()%></a></td>
	<!--td nowrap><%=Task.FETTLE[fettle]%></td>
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
	</td-->
</tr>
<%
}
%>
 <tr><td align="center" colspan="6"><a href="/jsp/admin/sales/task.jsp" target="m"><font color="red">任务管理</font></a></td></tr>
 <tr><td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,20)%></td></tr>
</table>


