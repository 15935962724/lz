<%@ page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.text.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.stat.*"%><%

Http h=new Http(request);

String menu=h.get("id","");
boolean ifr="562fb2c0c2d9af15c3054e35".equals(menu);
if(ifr)h.member=1;
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?id="+menu);

int tab=h.getInt("tab");
sql.append(tab==0?"last":"lastb");
par.append("&tab="+tab);

sql.append(" -n 50");

String ip=h.get("ip","");
if(ip.length()>0)
{
  sql.append(" -i "+ip);
  par.append("&ip="+Http.enc(ip));
}

String time=h.get("time","");
if(time.length()>0)
{
  sql.append(" -t "+time);
  par.append("&time="+Http.enc(time));
}

String user=h.get("user","");
if(user.length()>0)
{
  sql.append(" "+user);
  par.append("&user="+Http.enc(user));
}

String str;
if(!OS.isWin)
{
  str=OS.exec(sql.toString());
  Filex.write("last.txt",str);
}else
  str=Filex.read("D:/~2/last.txt","GBK");

SimpleDateFormat sdf=new SimpleDateFormat("E MMM dd HH:mm:ss yyyy",Locale.ENGLISH);


%><!DOCTYPE html><html>
<head>
<meta name="viewport" content="width=device-width,user-scalable=0">
<link href="<%=ifr?"http://center.redcome.com":""%>/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js"></script>
<%
if(ifr)out.print("<link href=http://center.redcome.com/res/ROOT/cssjs/community.css rel=stylesheet type=text/css><style>h1{display:none}</style>");
%>
</head>
<body>
<h1>登录日志</h1>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<table id="tablecenter" class="sear">
<tr>
  <td><label>用户：<i></i><input type="text" name="user" value="<%=MT.f(user)%>" class="txt" /></label></td>
  <td style="display:none"><label>地址：<i></i><input type="text" name="ip" value="<%=MT.f(ip)%>" class="txt" /></label></td>
  <td><input type="submit" value="查询" class="sub"/></td>
</tr>
</table>
</form>

<!--<%=sql.toString()%>-->

<h2>列表</h2>

<div class="switch">
<%
String[] TYPE={"成功","失败"};
for(int i=0;i<TYPE.length;i++)
{
  out.print("<a href=javascript:mt.tab("+i+") class="+(i==tab?"current":"")+">"+TYPE[i]+"</a>");
}
%>
</div>
<div class="content">
<table id="tablecenter" class="partners">
<tr id="tableonetr">
  <td>序号</td>
  <td>用户</td>
  <td>终端</td>
  <td>地址</td>
  <td>时间</td>
</tr>
<%
String[] month={"--","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
String[] arr=str.split("\n");
if(arr.length<4)out.print("<tr><td colspan=10 align=center>暂无"+(str.contains("Permission denied")?"权限":"记录")+"!</td></tr>");
else for(int i=0;i<arr.length;i++)
{
  String[] td=arr[i].split(" +",4);
  if(td.length<2)continue;
  if("begins".equals(td[1]))
  {
    time=MT.f(sdf.parse(td[2]+" "+td[3]),2);//.replaceAll("[- :]","");
    continue;
  }
  if("localhost".equals(td[2]))td[2]="127.0.0.1";
  out.println("<tr><td>"+(i+1));
  out.print("<td>"+td[0]);
  out.print("<td>"+td[1]);
  out.print("<td>"+td[2]+"<em>"+Ip.f(td[2])+"</em>");
  out.print("<td>"+Arrayx.indexOf(month,td[3].substring(4,7))+"-"+td[3].substring(8));
}
%>
</table>

开始：<%=time%>

</body>
</html>
