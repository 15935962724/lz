<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.net.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/ui/member/profile/ProfileServlet");

String _strId=request.getParameter("id");

int pos=0;
String tmp = request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

StringBuffer sql=new StringBuffer();
sql.append(" AND community=").append(DbAdapter.cite(teasession._strCommunity));

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND vmember LIKE ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}

int type=-1;
tmp = request.getParameter("type");
if(tmp!=null&&tmp.length()>0)
{
  type=Integer.parseInt(tmp);
  if(type!=-1)
  {
    sql.append(" AND type=").append(type);
    param.append("&type=").append(type);
  }
}
param.append("&pos=");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "操作日志")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form action="?">
<input type="hidden" name="id" value="<%=_strId%>" />
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<tr><td>会员:<input name="member" value="<%if(member!=null)out.print(member);%>"/></td>
<td>类型:<select name="type">
<option value="">-----------------</option>
<%
for(int i=0;i<Logs.LOGIN_TYPE.length;i++)
{
  out.print("<option value="+i);
  if(i==type)
  {
    out.print(" selected ");
  }
  out.println(">"+r.getString(teasession._nLanguage, Logs.LOGIN_TYPE[i]));
}
%>
</select>
</td>
<td><input type="submit" value="GO"/></td>
</table>
</form>

<h2>列表</h2>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<tr id="tableonetr">
<td width=1>&nbsp;</td>
<TD><%=r.getString(teasession._nLanguage, "MemberId")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Type")%></TD>
<td></td>
</tr><%
Enumeration e = Logs.find(sql.toString(), pos, 25);
for(int i=1; e.hasMoreElements(); i++)
{
  Logs log = (Logs)e.nextElement();
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td width=1>"+i);
  out.print("<td>"+log.getVMember());
  out.print("<td>"+log.getTimeToString());
 out.print("<td>"+log.getLog());
 if(log.getType()<=10){
    out.print("<td>"+r.getString(teasession._nLanguage, Logs.LOGIN_TYPE[log.getType()])+": "+log.getLog());
  }
}
%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(), pos, Logs.count(teasession._strCommunity,sql.toString()))%>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
