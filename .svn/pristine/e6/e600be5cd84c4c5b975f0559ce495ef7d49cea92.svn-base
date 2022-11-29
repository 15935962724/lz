<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.net.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

StringBuffer param=new StringBuffer();
param.append("?community=").append(community);

String _strId=(request.getParameter("id"));
param.append("&id=").append(_strId);

Resource r=new Resource();
r=r.add("/tea/resource/Workreport").add("/tea/ui/member/offer/Offers").add("/tea/ui/member/offer/ShoppingCarts").add("/tea/ui/member/Glance");

int workproject=0;
if(request.getParameter("workproject")!=null)
{
  workproject=Integer.parseInt(request.getParameter("workproject"));
}

StringBuffer sql=new StringBuffer();
String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}
String lastname=request.getParameter("lastname");
String firstname=request.getParameter("firstname");
String organization=request.getParameter("organization");
String email=request.getParameter("email");
String telephone=request.getParameter("telephone");
if(lastname!=null&&lastname.length()>0 || firstname!=null&&firstname.length()>0 || organization!=null&&organization.length()>0 || email!=null&&email.length()>0 || telephone!=null&&telephone.length()>0)
{
  sql.append(" AND member IN ( SELECT member FROM ProfileLayer WHERE 1=1 ");
  if(lastname!=null&&lastname.length()>0)
  {
    sql.append(" AND lastname LIKE "+DbAdapter.cite("%"+lastname+"%"));
    param.append("&lastname=").append(URLEncoder.encode(lastname,"UTF-8"));
  }
  if(firstname!=null&&firstname.length()>0)
  {
    sql.append(" AND firstname LIKE "+DbAdapter.cite("%"+firstname+"%"));
    param.append("&firstname=").append(URLEncoder.encode(firstname,"UTF-8"));
  }
  if(organization!=null&&organization.length()>0)
  {
    sql.append(" AND organization LIKE "+DbAdapter.cite("%"+organization+"%"));
    param.append("&organization=").append(URLEncoder.encode(organization,"UTF-8"));
  }
  if(email!=null&&email.length()>0)
  {
    sql.append(" AND email LIKE "+DbAdapter.cite("%"+email+"%"));
    param.append("&email=").append(URLEncoder.encode(email,"UTF-8"));
  }
  if(telephone!=null&&telephone.length()>0)
  {
    sql.append(" AND telephone LIKE "+DbAdapter.cite("%"+telephone+"%"));
    param.append("&telephone=").append(URLEncoder.encode(telephone,"UTF-8"));
  }
  sql.append(" )");
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

param.append("&pos=");

int count=Profile.countByCommunity(teasession._strCommunity,sql.toString());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onLoad="form1.member.focus();">
<!--选择会员-->
<h1><%=r.getString(teasession._nLanguage,"1169451073098")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" METHOD="GET" action="?" onSubmit="">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=request.getParameter("nexturl")%>"/>
<input type=hidden name="action" value="editwrtrade"/>

<h2><%=r.getString(teasession._nLanguage,"1168574879546")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr><td><%=r.getString(teasession._nLanguage,"MemberId")%></td><td><input name="member" type="text" /></td></tr>

<tr><td><%=r.getString(teasession._nLanguage,"1168584443703")%></td>
<td><select name="workproject" ><option value="0">-------------</option>
<%
java.util.Enumeration e=Workproject.find(teasession._strCommunity,"",pos,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  Workproject obj=Workproject.find(id);
  out.print("<option value="+id);
  if(id==workproject)
  out.print(" SELECTED ");
  out.print(" >"+obj.getName(teasession._nLanguage));
}
%>
</select><input type="button" value="..." onClick="window.open('/jsp/admin/workreport/Workprojects_2.jsp?community=<%=teasession._strCommunity%>&fieldname=form1.workproject','','height=500,width=500,left=200,top=100,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');"/></td></tr>

<tr><td><%=r.getString(teasession._nLanguage,"LastName")%></td><td><input name="lastname" type="text" /></td></tr>

<tr><td><%=r.getString(teasession._nLanguage,"FirstName")%></td><td><input name="firstname" type="text" value=""></td></tr>

<tr><td><%=r.getString(teasession._nLanguage,"Organization")%></td><td><input type="text" name="organization"></td></tr>

<tr><td>E-Mail</td><td><input type="text" name="email"></td></tr>

<tr><td><%=r.getString(teasession._nLanguage,"Telephone")%></td><td><input type="text" name="telephone"></td></tr>

</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"  onclick="">
</form>

<h2><%=r.getString(teasession._nLanguage,"1169440583427")+" ("+count+")"%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr><td><%=r.getString(teasession._nLanguage,"MemberId")%></td>
<td><%=r.getString(teasession._nLanguage,"LastName")%><%=r.getString(teasession._nLanguage,"FirstName")%></td>
<td><%=r.getString(teasession._nLanguage,"Organization")%></td>
<td>E-Mail</td>
<td><%=r.getString(teasession._nLanguage,"Telephone")%></td>
</tr>
<%
e=Profile.findByCommunity(teasession._strCommunity,sql.toString(),pos,25);
while(e.hasMoreElements())
{
  member=(String)e.nextElement();
  Profile p=Profile.find(member);
  out.print("<tr onMouseOver=bgColor='#BCD1E9'; onMouseOut=bgColor=''; style=\"cursor:hand;\" onclick=\" window.open('/jsp/admin/workreport/EditWrTrade_2.jsp?community="+community+"&node="+teasession._nNode+"&member="+java.net.URLEncoder.encode(member,"UTF-8")+"','_self'); \" ><td>"+member+"</td>");
  out.print("<td>"+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+"</td>");
  out.print("<td>"+p.getOrganization(teasession._nLanguage)+"</td>");
  out.print("<td>"+p.getEmail()+"</td>");
  out.print("<td>"+p.getTelephone(teasession._nLanguage)+"</td></tr>");
}
%>
<tr><td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count)%></td></tr>
</table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


