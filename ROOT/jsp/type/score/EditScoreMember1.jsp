<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%
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

boolean isRole=h.getBool("role");


String member=teasession._rv.toString();

String menuid=request.getParameter("id");
StringBuffer par=new StringBuffer();
par.append("?id="+menuid);
par.append("&community="+teasession._strCommunity);
par.append("&role="+isRole);

//1////////////
String golf=request.getParameter("golf");
if(golf!=null&&(golf=golf.trim()).length()>0)
{
  par.append("&golf="+java.net.URLEncoder.encode(golf,"utf-8"));
}
String sql=" AND type=62 AND community="+DbAdapter.cite(teasession._strCommunity);
if(isRole)
{
  AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
  String role=aur.golf;
  if(role.length()<2)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("您无权管理球场!","utf-8"));
    return;
  }
  sql+=" AND node IN("+ role.substring(1,role.length()-1).replace('/',',')+")";
}
String name1=request.getParameter("name1");
if(name1!=null&&(name1=name1.trim()).length()>0)
{
  sql+=" AND EXISTS(SELECT node FROM NodeLayer nl WHERE nl.node=n.node AND nl.subject LIKE "+DbAdapter.cite("%"+name1+"%")+")";
  par.append("&name1="+java.net.URLEncoder.encode(name1,"utf-8"));
}

int sum1=Node.count(sql);

String tmp=request.getParameter("pos1");
int pos1=tmp!=null?Integer.parseInt(tmp):0;

//2////////////////////////////
String mid=request.getParameter("member");
if(mid!=null&&(mid=mid.trim()).length()>0)
{
  par.append("&member="+java.net.URLEncoder.encode(mid,"utf-8"));
}
String sql2=" AND community="+DbAdapter.cite(teasession._strCommunity);
String member2=request.getParameter("member2");
if(member2!=null&&(member2=member2.trim()).length()>0)
{
  sql2+=" AND member LIKE "+DbAdapter.cite("%"+member2+"%");
  par.append("&member2="+java.net.URLEncoder.encode(member2,"utf-8"));
}
String code2=request.getParameter("code2");
if(code2!=null&&(code2=code2.trim()).length()>0)
{
  sql2+=" AND code LIKE "+DbAdapter.cite("%"+code2+"%");
  par.append("&code2="+java.net.URLEncoder.encode(code2,"utf-8"));
}
String mobile2=request.getParameter("mobile2");
if(mobile2!=null&&(mobile2=mobile2.trim()).length()>0)
{
  sql2+=" AND mobile LIKE "+DbAdapter.cite("%"+mobile2+"%");
  par.append("&mobile2="+java.net.URLEncoder.encode(mobile2,"utf-8"));
}

int sum2=Profile.count(sql2);

tmp=request.getParameter("pos2");
int pos2=tmp!=null?Integer.parseInt(tmp):0;


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<title>提交个人成绩</title>
<script>
function f_c(obj)
{
  var arr=document.getElementsByTagName("INPUT");
  for(var i=0;i<arr.length;i++)
  {
    if(arr[i].name==obj.name)arr[i].checked=false;
  }
  obj.checked=true;
}
function f_s()
{
  if(submitCheckbox(form1.golf,'请选择球场！')&&submitCheckbox(form1.member,'请选择会员！'))
  {
    form1.action="/jsp/type/score/EditScoreMember2.jsp";
    form1.submit();
  }
}
</script> 
</head>
<body>

<h1>填写成绩</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type=hidden name="id" value="<%=menuid%>" >
<input type=hidden name="node" value="<%=teasession._nNode%>" >
<input type=hidden name="role" value="<%=isRole%>" >

<h2>选择球场</h2>
<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>球场名称:<input name="name1" value="<%if(name1!=null)out.print(name1);%>"/><input type="submit" value="搜索"/></td></tr>
</table>
<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
<td><td>球场名称</td>
<td>区域</td>
<td>打球次数</td>
</tr>
<%
Enumeration e=Node.find(sql,pos1,20);
for(int i=pos1+1;e.hasMoreElements();i++)
{
  int nid=((Integer)e.nextElement()).intValue();
  Node n=Node.find(nid);
  Golf g=Golf.find(nid,teasession._nLanguage);
  int sc=Score.count(" AND node="+nid);
  String area=g.getArea();
  try 
  {
    area=Table.find(Table.CITY,Integer.parseInt(area)).name;
  }catch(Exception ex)     
  {}
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td><input type=checkbox name='golf' onclick='f_c(this)' value='"+nid+"'");
  if(String.valueOf(nid).equals(golf))out.print(" checked=''");
  out.print(" />");
  out.print("<td>"+n.getSubject(teasession._nLanguage));
  out.print("<td>"+MT.f(area));
  out.print("<td>"+(sc<1?"--":String.valueOf(sc)));
} 
%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage, par.toString()+"&pos1=", pos1, sum1,20)%>
<input type=checkbox style="display: none;" name='member' checked="checked"  value='<%=teasession._rv.toString() %>'>
 
<br/>
<input type="submit" value="下一步" onclick="f_s()"/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

</body></html>
