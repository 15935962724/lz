<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%

request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/fun");

String q=request.getParameter("q");

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);

if(q!=null&&(q=q.trim()).length()>0)
{
	sql.append(" AND ( member LIKE ").append(DbAdapter.cite("%"+q+"%"));
	sql.append(" OR member IN (SELECT member FROM ProfileLayer WHERE");
	sql.append(" firstname LIKE ").append(DbAdapter.cite("%"+q+"%"));
	sql.append(" OR lastname LIKE ").append(DbAdapter.cite("%"+q+"%"));
	sql.append("))");

	param.append("&q=").append(URLEncoder.encode(q,"UTF-8"));
}

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}
param.append("&pos=");

int count=Profile.count(sql.toString());

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<style>
body{background:url(/res/ROOT/u/0709/070921023.jpg) no-repeat right top;
background-attachment:fixed;}

#mytable {border:1px solid #c1dad7;background:#f5fafa;color:#456b72;margin-top:20px;width:90%}
#mytable a{color:#456b72;}
.tr1{border-top:1px dotted #c1dad7;}
.td1{border-left:1px dotted #c1dad7;border-right:1px dotted #c1dad7;}
.bgtr{background:#fef1f3;font-weight:bolder;line-height:20px;}
tr{height:25px;}


</style>
</head>
<body>
<h2>列表(<%=count%>)</h2>
<table id="mytable">
<tr class="bgtr"><td width=1>&nbsp;</td><td>用户ID</td><td class="td1">用户密码</td><td>用户Email</td><td>注册社区</td><td>注册时间</td></tr>
<%


Enumeration e = Profile.find(sql.toString(),pos,25);
if(e.hasMoreElements())
{
	for(int i=1;e.hasMoreElements();i++)
	{
		String member = (String)e.nextElement();
		Profile obj = Profile.find(member);
		out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
		out.print("<td width=1>"+i);
		out.print("</td><td class=\"tr1\">"+obj.getMember());
		out.print("</td><td class=\"td1 tr1\">&nbsp;"+obj.getPassword());
		out.print("</td><td class=\"tr1\">&nbsp;"+obj.getEmail());
		out.print("</td><td>&nbsp;"+obj.getCommunity());
		out.print("</td><td>&nbsp;"+obj.getTimeToString());
		out.print("</td></tr>");
	}
	out.print("<tr><td colspan=6 align=center>"+new tea.htmlx.FPNL(teasession._nLanguage, param.toString(), pos, count));
}else
{
	out.print("暂无记录");
}

%>
</table>
</body>
</html>


