<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %>
<html>
<head>
<base target="_parent"/>
<style>
body{padding:0px;margin:0px;}
.tablecenter td{font-size:12px;}
.tablecenter .title td{height:24px}
.tablecenter td a{text-decoration:none;}
.tablecenter td a:hover{text-decoration:underline;}
</style>
</head>
<body>
<table width="656" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999" class="tablecenter">
<tr class="title">
<td width="50" align="center" bgcolor="#cccccc">排名 </td>
<td width="300" align="center" bgcolor="#cccccc">作者 </td>
<td align="center" bgcolor="#cccccc">工分</td>
</tr>
<%


Http h=new Http(request);

Enumeration e=Profile.find(" AND member NOT IN('webmaster','admin','admin1','admin2','admin3','admin4','admin5') AND time>'2011-11-01' ORDER BY integral DESC",0,8);
for(int i=1;e.hasMoreElements();i++)
{
  String m=(String)e.nextElement();
  ProfileBBS mb=ProfileBBS.find(h.community,m);
  Profile p=Profile.find(m);

  out.print("<tr><td height=\"25\" align=\"center\" bgcolor=\"#FFFFFF\" >"+i+"</td><td align=\"center\" bgcolor=\"#FFFFFF\"><span id=\"BBSIDmemberid\"><a href='/html/folder/3-1.htm?member="+Http.enc(m)+"'>"+m+"</a></span></td><td align=\"center\" bgcolor=\"#FFFFFF\">"+(int)p.getIntegral()+"</td></tr>");
}
%>
</table>
</body>
</html>
