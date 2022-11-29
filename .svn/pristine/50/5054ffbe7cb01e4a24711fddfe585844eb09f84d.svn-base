<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.admin.sales.*" %>
<%@page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer(" and latencytype is not null ");

String act =teasession.getParameter("act");
if(act != null){
  String lcmember = teasession.getParameter("memberid");
  Latency.delete(lcmember);
}

int id = 0;
if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
{
  id = Integer.parseInt(teasession.getParameter("id"));
}
param.append("&id=").append(id);



String member = teasession.getParameter("email");
if(member!=null && member.length()>0)
{
  member = member.trim();
  sql.append(" AND email LIKE ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&email=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}

int membertypes =0;
if(teasession.getParameter("latencytype")!=null && teasession.getParameter("latencytype").length()>0)
{
  membertypes = Integer.parseInt(teasession.getParameter("latencytype"));
}

if(membertypes>0)
{
  sql.append(" AND latencytype = ").append(membertypes);
  param.append("&latencytype=").append(membertypes);
}

String time_k = teasession.getParameter("time_k");
if(time_k!=null && time_k.length()>0)
{
  sql.append(" AND email in (select member from Profile where time>="+DbAdapter.cite(time_k)+") ");
  param.append("&time_k=").append(time_k);
}

String time_j = teasession.getParameter("time_j");
if(time_j!=null && time_j.length()>0)
{
  sql.append(" AND email in (select member from Profile where time<="+DbAdapter.cite(time_j)+") ");
  param.append("&time_j=").append(time_j);
}

int audit =-1;
if(teasession.getParameter("audit")!=null && teasession.getParameter("audit").length()>0)
{
  audit = Integer.parseInt(teasession.getParameter("audit"));
}
if(audit!=-1)
{
  if(audit == 0){
    sql.append(" AND (audit = 0 or audit is null)");
  }else{
    sql.append(" AND audit =").append(audit);
  }
  param.append("&audit=").append(audit);
}

sql.append(" AND email != ").append(DbAdapter.cite("webmaster"));
int pos=0,size=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

param.append("&pos=").append(pos);

int count=Latency.count(teasession._strCommunity,sql.toString());

sql.append(" order by latecydate desc");

String nexturl = request.getRequestURI()+"?"+param.toString();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>

<body bgcolor="#ffffff">
<script type="">
function f_delete(igd)
{
  if(confirm('确实要彻底删除吗？')){

    form2.memberid.value=igd;
    form2.act.value='delete';
    form2.action='/jsp/mov/MemberLatencyManage.jsp?community=<%=teasession._strCommunity%>';
    form2.submit();
  }
}
function f_Servicetype(igd,sgd)
{
  form1.memberorder.value=igd;
  form1.servicetype.value=sgd;
  form1.act.value='servicetype';
  form1.action='/jsp/mov/MemberDecide.jsp';
  form1.submit();
}
function f_sh(igd,id)
{
  form1.memberorder.value=igd;
  form1.id.value=id;
  form1.act.value ='sh';
  form1.action ='/jsp/mov/MemberManage.jsp';
  form1.submit();
}
</script>
<h1>会员审核管理</h1>
<h2>会员审核查询</h2>
<form action="?" name="form1" method="POST">
<input TYPE="hidden" name="id" value="<%=id%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr >
    <td width="20%">用户名：&nbsp;&nbsp;<input type="text" name="email" value="<%if(member!=null)out.print(member);%>" /></td>
      <td width="20%">会员类型：&nbsp;&nbsp;
        <select name="latencytype">
          <option value="0">------------</option>
          <option value="1" <%if(membertypes==1)out.print("selected");%>>企业用户</option>
          <option value="2" <%if(membertypes==2)out.print("selected");%>>个人用户</option>
          <option value="3" <%if(membertypes==3)out.print("selected");%>>合作伙伴</option>
        </select>
      </td>
      <td width="25%">注册时间：&nbsp;&nbsp;
        <input type="text" name="time_k" value="<%if(time_k!=null)out.print(time_k);%>" size="8" />&nbsp;<A href="###"><img onclick="showCalendar('form2.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;至&nbsp;
          <input type="text" name="time_j" value="<%if(time_j!=null)out.print(time_j);%>" size="8" />&nbsp;<A href="###"><img onclick="showCalendar('form2.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
      </td>

      <td width="15%">审核状态：&nbsp;&nbsp;
        <select name="audit">
          <option value="">---------</option>
          <option value="0" <%if(audit==0)out.print(" selected");%> >暂没有审核</option>
          <option value="1" <%if(audit==1)out.print(" selected");%> >审核通过</option>
          <option value="2" <%if(audit==2)out.print(" selected");%> >审核没有通过</option>
        </select>
      </td>
      <td><input type="submit" value="查询"/></td>
  </tr>
</table>
</form>
<h2>会员审核列表</h2>
<form action="?" name="form2" >
<input type="hidden" name="memberid"/>
<input type="hidden" name="servicetype"/>
<input type="hidden" name="act" value=""/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="5%">序号</td>
    <td>用户名</td>
    <td>会员类型</td>
    <td>注册时间</td>
    <td>审核状态</td>
    <td>操作</td>
  </tr>
  <%

  java.util.Enumeration e = Latency.find(teasession._strCommunity,sql.toString(),pos,size);
  if(!e.hasMoreElements())
  {
    out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
  }


  for(int i =1;e.hasMoreElements();i++)
  {
    int memberly = ((Integer)e.nextElement()).intValue();
    String ro [] =null;

    Latency ly = Latency.find(memberly);

    Profile p = Profile.find(ly.getMember());
    int ilytype = ly.getLatencytype();
    String types = "";
    if(ilytype==1)
    {
      types ="企业用户";

    }
    else if(ilytype==2)
    {
      types ="个体用户";

    }
    else if(ilytype==3)
    {
      types ="合作伙伴";
    }
    %>

    <tr>
      <td align="center"><%=i %></td>
      <td align="center"><a href="/jsp/mov/MemberLatencyInfo.jsp?lctype=0&memberly=<%=memberly%>"><%=ly.getEmail()%></a></td>
      <td align="center"><%=types%></td>
      <td align="center"><%=ly.getLatecyDateToSting()%></td>
      <td align="center"><%if(ly.getAudit()==0)out.print("暂没有审核");else if(ly.getAudit()==1)out.print("审核通过"); else if(ly.getAudit()==2)out.print("审核没有通过"); %></td>
      <td align="center">

        <input type="button" id="button1" <%if(ly.getAudit()==1)out.print("disabled");%> value="审核" onclick="window.open('/jsp/mov/MemberLatencyInfo.jsp?community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>&memberly=<%=memberly%>&lctype=1','_self');" >&nbsp;

        <input type="button" value="彻底删除" onclick="f_delete('<%=ly.getEmail() %>');"/>
      </td>
    </tr>

    <%}if(count>size){ %>
    <tr>
      <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>
    </tr>
    <%} %>
</table>

</form>

</body>
</html>
