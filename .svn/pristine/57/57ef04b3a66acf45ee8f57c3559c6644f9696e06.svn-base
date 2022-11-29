<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.member.*"%><%@page import="tea.entity.yl.shop.ShortState"%>
<%

Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

par.append("?community="+h.community+"&id="+menuid);



Date stime=h.getDate("stime");
if(stime!=null)
{
  sql.append(" AND SendedTime>"+Database.cite(stime));
  par.append("&stime="+MT.f(stime));
}
Date etime=h.getDate("etime");
if(etime!=null)
{
  sql.append(" AND SendedTime<"+Database.cite(etime));
  par.append("&etime="+MT.f(etime));
}

String mobile=h.get("mobile","");
if(mobile.length()>0)
{
  sql.append(" AND MobilePhone LIKE "+DbAdapter.cite("%"+mobile+"%"));
  par.append("&mobile="+h.enc(mobile));
}

int stat=h.getInt("stat");
if(stat>0)
{
  if(stat==1){
	  sql.append(" AND ReportState=1 ");
  }else if(stat==2){
	  sql.append(" AND ReportState!=1 ");
  }
  par.append("&stat="+stat);
}



int pos=h.getInt("pos");
int sum=ShortState.count(sql.toString());
sql.append(" order by SendedTime desc");
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>短信发送情况</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>手机号:</td><td><input name="mobile" value="<%=mobile%>"/></td>
  <%--<td>类型:</td><td><select name="type"><option value="-1">----</option><%=h.options(SMSMessage.SMS_TYPE,type)%></select>--%>
  <td>时间：</td><td><input name="stime" value="<%=MT.f(stime)%>" class="date" readonly onclick="mt.date(this)"/>至<input name="etime" value="<%=MT.f(etime)%>" class="date" readonly onclick="mt.date(this)"/></td>
  <td>状态：</td>
  <td>
  <select name="stat">
  <option value="0" <%=stat==0?"selected":"" %>>---</option>
  <option value="1" <%=stat==1?"selected":"" %>>成功</option>
  <option value="2" <%=stat==2?"selected":"" %>>失败</option>
  </select>
  </td>
</tr>
<tr>
  <td colspan="6"><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/servlet/EditSMSMessage" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="smsmessage"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>手机号</td>
  <td>信息发送时间</td>
  <td>信息发送状态</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{

  Iterator it=ShortState.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShortState t=(ShortState)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.getMobilePhone())%></td>
    <td><%=t.getSendedTime()!=null?ShortState.sdf.format(t.getSendedTime()):""%></td>
    <td><%=MT.f(t.getReportState()==1?"成功":"失败")%></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
</form>


</body>
</html>
