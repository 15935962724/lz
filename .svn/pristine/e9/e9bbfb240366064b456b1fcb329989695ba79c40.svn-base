<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.io.*" %><%@page import="tea.db.*" %><%@page import="tea.resource.*" %><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
Http h=new Http(request);

String act=h.get("act");
if(act!=null)
{
  Profile p=Profile.find(h.key);
  if("lock".equals(act))//锁定
  {
    p.setLocking(h.getBool("lock"));
  }else if("clear".equals(act))
  {
    p.setPassword("");
  }
  out.print("<script>alert('信息修改成功!');history.go(-1);</script>");
  return;
}

String name=h.get("name");
String member=h.get("member");
String creditcard=h.get("creditcard");
String order=h.get("order","profile");
boolean asc=h.getBool("asc");
//SQL
String sql=" AND community="+DbAdapter.cite(teasession._strCommunity)+" AND creditcard IS NOT NULL";
if(member!=null)sql+=" AND member LIKE "+DbAdapter.cite("%"+member+"%");
if(creditcard!=null)sql+=" AND creditcard LIKE "+DbAdapter.cite("%"+creditcard.replaceAll(" ","")+"%");
if(name!=null)sql+=" AND EXISTS(SELECT pl.member FROM ProfileLayer pl WHERE p.member=pl.member AND firstname LIKE "+DbAdapter.cite("%"+name+"%")+")";
int sum=Profile.count(sql);
sql+=" ORDER BY "+order+" "+(asc?"ASC":"DESC");
if(h.getBool("exp"))
{
  response.setHeader("Content-Disposition", "attachment; filename="+new String("差点会员.xls".getBytes("GBK"),"ISO-8859-1"));
  ProfileGolf.exp(sql,teasession._nLanguage,response.getOutputStream());
  return;
}
int menuid=h.getInt("id");
StringBuffer par=new StringBuffer();
par.append("?id="+menuid);
par.append("&community="+h.community);
par.append("&name="+Http.enc(name));
par.append("&member="+Http.enc(member));
par.append("&creditcard="+Http.enc(creditcard));
par.append("&order="+order).append("&asc="+asc);
par.append("&pos=");




String tmp=request.getParameter("pos");
int pos=tmp!=null?Integer.parseInt(tmp):0;


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_edit(m)
{
  window.open('/jsp/type/golf/EditProfileGolf.jsp?community=<%=h.community%>&key='+m,'_self');
}
function f_lock(m,v)
{
  if(v&&!confirm('你确定要锁定此会员吗?  被锁定的会员无法登陆本系统!'))return;
  window.open('?id=<%=menuid%>&community=<%=h.community%>&key='+m+'&act=lock&lock='+v,'_self');
}
function f_clear(m)
{
  if(!confirm('你确定要清空密码吗?'))return;
  window.open('?id=<%=menuid%>&community=<%=h.community%>&key='+m+'&act=clear','_self');
}
</script>
</head>
<body>
<h1>会员管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>会员查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter">
<tr><td>姓名:<input name="name" value="<%=MT.f(name)%>" />
<td>会员号:<input name="member" value="<%=MT.f(member)%>"/>
<td>信用卡号:<input name="creditcard" value="<%=MT.f(creditcard)%>" />
<td>排序:<select name="order"><option value="profile">注册时间<option value="member">会员号<option value="creditcard">信用卡号</select><select name="asc"><option value="false">降序</option><option value="true">升序</option></select>
<td><input type="submit" value="查询" />
</td></tr>
</table>
<script>form1.order.value="<%=order%>";form1.asc.value="<%=asc%>";</script>
<br/>
<h2>查看会员 共<%=sum%>条</h2>
<table id="tablecenter">
  <tr id="tableonetr">
    <td>序号</td>
    <td>姓名（中文）</td>
    <td>差点会员号</td>
    <td>差点信用卡号</td>
    <td>会员ID</td>
    <td>电子邮箱</td>
    <td>移动电话</td>
    <td>住宅地址</td>
    <td>住宅电话</td>
    <td>公司名称</td>
    <td>现任职务</td>
    <td>操作</td>
  </tr>
<%
int lang=teasession._nLanguage;
Enumeration e=Profile.find(sql,pos,20);
for(int i=1+pos;e.hasMoreElements();i++)
{
  String m=(String)e.nextElement();
  Profile p=Profile.find(m);
  ProfileGolf pg=ProfileGolf.find(m);
  String mt=Http.enc(MT.enc(m));
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td>"+i);
  out.print("<td>"+p.getName(lang));
  out.print("<td><a href=/jsp/type/score/RO_Scores.jsp?community="+h.community+"&mt="+mt+">"+m+"</a>");
  out.print("<td>"+p.getCreditcard());
  out.print("<td>"+p.getCode());
  out.print("<td><a href=mailto:"+p.getEmail()+">"+p.getEmail()+"</a>");
  out.print("<td>"+p.getMobile());
  out.print("<td>"+MT.f(p.getPAddress(lang)));
  out.print("<td>"+MT.f(p.getPTelephone(lang)));
  out.print("<td>"+p.getOrganization(lang));
  out.print("<td>"+p.getJob(lang));
  out.print("<td><input type=button value='编辑' onclick=\"f_edit('"+mt+"')\" /> ");
  out.print(p.isLocking()?"<input type=button value='解锁' onclick=\"f_lock('"+mt+"',false)\" />":"<input type=button value='锁定' onclick=\"f_lock('"+mt+"',true)\" /> ");
  out.print("<input type=button value='清空密码' onclick=\"f_clear('"+mt+"')\" /> ");
}
%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage, par.toString(), pos, sum,20)%>
<br/>
<input type="button" value="导入" onclick="window.open('/jsp/type/golf/ImpProfile.jsp?community=<%=h.community%>','_self');" />
<input type="submit" value="导出" name="exp" />
<input type="button" value="添加" onclick="f_edit('')" />
</form>
</body>
</html>
