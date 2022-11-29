<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();
String strid=request.getParameter("id");

StringBuffer par=new StringBuffer();
StringBuffer sql=new StringBuffer();

par.append("?community="+teasession._strCommunity);
par.append("&id="+strid);

String start=request.getParameter("start");
if(start!=null&&(start=start.trim()).length()>0)
{
  sql.append(" AND time > "+DbAdapter.cite(start));
  par.append("&start="+start);
}
String end=request.getParameter("end");
if(end!=null&&(end=end.trim()).length()>0)
{
  sql.append(" AND time < "+DbAdapter.cite(end));
  par.append("&end="+end);
}
int type=-1;
String tmp=request.getParameter("type");
if(tmp!=null&&tmp.length()>0)
{
  type=Integer.parseInt(tmp);
  par.append("&type="+type);
}
if(type==-1)
{
  sql.append(" AND status IS NOT NULL");
}else
{
  sql.append(" AND status="+type);
}

int pos=0;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
int count=EonRecord.count(teasession._strCommunity,sql.toString());

par.append("&pos=");

String member=teasession._rv._strV;

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_act(act,erid)
{
  if(act=="down")
  {
    form1.action="/servlet/EonRecords";
  }
  form1.eonrecord.value=erid;
}
</script>
</head>
<body>

<h1>用户通话记录</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>查询</h2>
<form name="form1" action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="id" value="<%=strid%>">
<input type=hidden name="eonrecord" >
<input type=hidden name="act" >

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>时间<input name="start" value="<%if(start!=null)out.print(start);%>"><img src="/tea/image/public/Calendar2.gif" onclick="showCalendar('form1.start');">
      <input name="end" value="<%if(end!=null)out.print(end);%>"><img src="/tea/image/public/Calendar2.gif" onclick="showCalendar('form1.end');">
    </td>
    <td>状态:<select name="type">
    <option value="">-------------</option>
    <%
    for(int i=0;i<EonRecord.STATUS_TYPE.length;i++)
    {
      out.print("<option value="+i);
      if(i==type)out.print(" selected ");
      out.print(">"+EonRecord.STATUS_TYPE[i]);
    }
    %>
    </select>
    </td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>


<h2>列表(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="1">&nbsp;</td>
    <TD>节点</TD>
    <TD>开始时间</TD>
    <TD>停止时间</TD>
    <TD>主叫</TD>
    <TD>被叫</TD>
    <TD>通话时长</TD>
    <TD>消费金额</TD>
    <TD>接通状态</TD>
  </tr>
<%
if(count>0)
{
  java.util.Enumeration e=EonRecord.find(teasession._strCommunity,sql.toString(),pos,10);
  for(int i=1;e.hasMoreElements();i++)
  {
    int erid=((Integer)e.nextElement()).intValue();
    EonRecord obj=EonRecord.find(erid);
    String m=obj.getMember();
    String cm=obj.getCallMember();
    int status=obj.getStatus();
    int node=obj.getNode();
    Node n=Node.find(node);
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td width="1"><%=i%></td>
      <td><%=n.getAnchor(teasession._nLanguage)%></td>
      <td><%=obj.getStartTimeToString()%></td>
      <td><%=obj.getEndTimeToString()%></td>
      <td><%=m%><%//=m.equals(member)?"主叫":"被叫"%></td>
      <td>
      <%
      if(cm!=null)out.print(cm+" ");
      out.print(obj.getCallTel());
      %></td>
      <td><%=obj.getTalkTimeToString()%></td>
      <td><%=obj.getConsumeToString()+"("+(obj.isSide()?"主叫":"被叫")+")"%></td>
      <td><%
      if(status==3)
      {
        out.print("<a href=javascript:f_act('downmessage',"+erid+">");
      }
      out.print(EonRecord.STATUS_TYPE[status]+"</a>");
      %></td>
    </tr>
    <%
  }
  out.print("<tr><td colspan=20>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,10)+"</tr>");
}else
{
  out.print("<tr><td colspan=20 align=center>暂无记录</td>");
}
%>
</table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
