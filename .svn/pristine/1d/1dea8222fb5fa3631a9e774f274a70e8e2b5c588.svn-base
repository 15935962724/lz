<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
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

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
int count=EonConsume.count(teasession._rv._strV,sql.toString());

par.append("&pos=");


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function editimd(igd)
{
  form1.action='/jsp/eon/EditEonConsume.jsp';
  form1.submit();
}
</script>
</head>
<body>

<h1>用户缴费记录</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>查询</h2>
<FORM name="form1" action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>
<input type=hidden name="id" value="<%=strid%>"/>
<input type=hidden name="act" >

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>时间<input name="start" value="<%if(start!=null)out.print(start);%>"><img src="/tea/image/public/Calendar2.gif" onclick="showCalendar('form1.start');">
    <input name="end" value="<%if(end!=null)out.print(end);%>"><img src="/tea/image/public/Calendar2.gif" onclick="showCalendar('form1.end');"></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>


<h2>列表(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap width="1">&nbsp;</td>
    <TD>金额</TD>
    <TD>时间</TD>
  </tr>
<%
java.util.Enumeration e=EonConsume.find(teasession._rv._strV,sql.toString(),pos,10);
for(int i=1;e.hasMoreElements();i++)
{
  int ecid=((Integer)e.nextElement()).intValue();
  EonConsume obj=EonConsume.find(ecid);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=i%></td>
    <td nowrap><%=obj.getMoneyToString()%></td>
    <td nowrap><%=obj.getTimeToString()%></td>
 </tr>
<%
}
%>
<tr><td colspan="2"><%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,10)%></tr>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="editimd(0);">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
