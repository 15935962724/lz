<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.ui.*"%>
<%
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

String strid=request.getParameter("id");

String tmp;
int pos=0;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
sql.append(" AND father=0");
sql.append(" AND rcreator IN( SELECT community FROM Community)");
par.append("?community=").append(teasession._strCommunity).append("&id=").append(strid);

String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND rcreator LIKE ").append(DbAdapter.cite("%"+member+"%"));
  par.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}
String subject=request.getParameter("subject");
String content=request.getParameter("content");
boolean isB=subject!=null&&subject.length()>0;
boolean isC=content!=null&&content.length()>0;
if(isB||isC)
{
  sql.append(" AND node IN(SELECT node FROM NodeLayer WHERE");
  if(isB)
  {
    sql.append(" subject LIKE ").append(DbAdapter.cite("%"+subject+"%"));
    par.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
  }
  if(isC)
  {
    if(isB)sql.append(" AND");
    sql.append(" content LIKE ").append(DbAdapter.cite("%"+content+"%"));
    par.append("&content=").append(java.net.URLEncoder.encode(content,"UTF-8"));
  }
  sql.append(")");
}
///
String contact=request.getParameter("contact");
String telephone=request.getParameter("telephone");
String email=request.getParameter("email");
boolean isCC=contact!=null&&contact.length()>0;
boolean isCT=telephone!=null&&telephone.length()>0;
boolean isCE=email!=null&&email.length()>0;
if(isCC||isCT||isCE)
{
  sql.append(" AND node IN(SELECT node FROM Company WHERE 1=1");
  if(isCC)
  {
    sql.append(" AND contact LIKE ").append(DbAdapter.cite("%"+contact+"%"));
    par.append("&contact=").append(java.net.URLEncoder.encode(contact,"UTF-8"));
  }
  if(isCT)
  {
    sql.append(" telephone LIKE ").append(DbAdapter.cite("%"+telephone+"%"));
    par.append("&telephone=").append(java.net.URLEncoder.encode(telephone,"UTF-8"));
  }
  if(isCE)
  {
    sql.append(" email LIKE ").append(DbAdapter.cite("%"+email+"%"));
    par.append("&email=").append(java.net.URLEncoder.encode(email,"UTF-8"));
  }
  sql.append(")");
}

par.append("&pos=");


int count=Node.count(sql.toString());



%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_edit(act,nid,m)
{
  form1.nexturl.value=location.pathname+location.search;
  switch(act)
  {
    case "pause":
    act="/jsp/community/PauseCompany.jsp";
    break;
    case "edit":
    act="/jsp/type/company/windows/EditCompany2.jsp";
    break;
  }
  form1.action=act;
  if(m)
  {
    form1.method=m;
  }
  form1.community.value=nid;
  form1.submit();
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "已开通第一站的企业")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>搜索</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=strid%>">
<input type="hidden" name="nexturl">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap="nowrap">名　称:<input type="text" name="subject" value="<%if(isB)out.print(subject);%>"></td>
    <td nowrap="nowrap">简介:<input type="text" name="content" value="<%if(isC)out.print(content);%>"></td>
    <td colspan="2" nowrap="nowrap">会员:<input type="text" name="member" value="<%if(member!=null)out.print(member);%>"></td>
	</tr>
	<tr>
    <td nowrap="nowrap">联系人:<input type="text" name="contact" value="<%if(isCC)out.print(contact);%>"></td>
    <td nowrap="nowrap">电话:<input type="text" name="telephone" value="<%if(isCT)out.print(telephone);%>"></td>
    <td nowrap="nowrap">邮箱:<input type="text" name="email" value="<%if(isCE)out.print(email);%>"></td>
    <td nowrap="nowrap"><input type="submit" value="GO"></td>
  </tr>
</table>

<h2><%=r.getString(teasession._nLanguage, "列表"+" ( "+count+" )")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td>&nbsp;</td>
    <td nowrap="nowrap"><%=r.getString(teasession._nLanguage, "名称")%></td>
    <td nowrap="nowrap"><%=r.getString(teasession._nLanguage, "会员")%></td>
    <td nowrap="nowrap"><%=r.getString(teasession._nLanguage, "联系人")%></td>
    <td ><%=r.getString(teasession._nLanguage, "电话")%></td>
    <td nowrap="nowrap"><%=r.getString(teasession._nLanguage, "邮箱")%></td>
    <td nowrap="nowrap"><%=r.getString(teasession._nLanguage, "有效期")%></td>
    <td>&nbsp;</td>
  </tr>
<%
Enumeration e=Node.find(sql.toString(),pos,20);
for(int i=1+pos;e.hasMoreElements();i++)
{
  int nid=((Integer)e.nextElement()).intValue();
  Node n=Node.find(nid);
  Company c=Company.find(nid);
  Community community=Community.find(n.getCreator()._strR);
  String con=c.getContact(teasession._nLanguage);
  String tel=c.getTelephone(teasession._nLanguage);
  String ema=c.getEmail(teasession._nLanguage);
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td>"+i);
  out.print("<td nowrap>&nbsp;"+n.getSubject(teasession._nLanguage));
  out.print("<td nowrap>&nbsp;"+n.getCreator());
  out.print("<td nowrap>&nbsp;");if(con!=null)out.print(con);
  out.print("<td nowrap>&nbsp;");if(tel!=null)out.print(tel);
  out.print("<td nowrap>&nbsp;");if(ema!=null)out.print(ema);
  out.print("<td nowrap>&nbsp;"+community.getStopTimeToString());
  out.print("<td>");
  String pause=community.getPause(teasession._nLanguage);
  if(pause!=null&&pause.length()>0)
  {
    out.print("<input type=button value="+r.getString(teasession._nLanguage, "恢复")+" onClick=f_edit('pause','"+n.getCommunity()+"','post')>");
  }else
  {
    out.print("<input type=button value="+r.getString(teasession._nLanguage, "暂停")+" onClick=f_edit('pause','"+n.getCommunity()+"')>");
  }
  out.print("<input type=button value="+r.getString(teasession._nLanguage, "编辑")+" onClick=f_edit('edit','"+n.getCommunity()+"')>");
}
out.print("<tr><td colspan=8>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,20));
%>
</table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
