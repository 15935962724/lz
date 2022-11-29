<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.util.regex.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.stat.*"%><%

Http h=new Http(request,response);

String menu=h.get("id","");
boolean ifr="562fb2c0c2d9af15c3054e35".equals(menu);
if(ifr)h.member=1;
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer par=new StringBuffer("?id="+menu);

int local=h.getInt("local");
if(local>0)par.append("&local="+local);

String foreign=h.get("foreign","");
if(foreign.length()>0)par.append("&foreign="+Http.enc(foreign));

String str=OS.exec(OS.isWin?"netstat -abno -p TCP":"netstat -atnp");
//str=Filex.read("d:/~2/netstat.txt","UTF-8");
//OS.isWin=false;
Filex.write("netstat.txt",str);
str=str.substring(str.indexOf(OS.isWin?"PID":"name"),str.lastIndexOf('['));

str=OS.isWin?str.replaceAll("无法获取所有权信息","[无法获取所有权信息]").replaceAll(" ?[Ss]erver ?","Server"):str.replaceAll(": [^\r\n]+","");//进程名

String[] arr=str.split("[ \r\n]+");

int x=OS.isWin?0:2;//多两列:Recv-Q、Send-Q

HashMap st=new HashMap(),hm=new HashMap(),desc=new HashMap();
for(int i=1,j=5;i<arr.length;i+=j)
{
  j=5;
  i+=x;

  //状态
  Integer tmp=(Integer)st.get(arr[i+3]);
  st.put(arr[i+3],Integer.valueOf(tmp==null?1:tmp.intValue()+1));
  if("TIME_WAIT".equals(arr[i+3]))continue;

  String name;
  if(OS.isWin)
  {
    int pid=Integer.parseInt(arr[i+4]);
    if(pid==0)continue;

    //进程
    while(arr[i+j].charAt(0)!='[')j++;
    name=arr[i+j];j++;
    name=name.substring(1,name.length()-1);//去掉中括号
  }else
  {
    name=arr[i+4].substring(arr[i+4].indexOf('/')+1);
  }

  //本地地址
  if(local==1&&!arr[i+1].startsWith("127."))continue;
  if(local==2&&arr[i+1].startsWith("127."))continue;

  //外部地址
  String ip=arr[i+2];
  if(ip.indexOf(foreign)==-1)continue;
  desc.put(arr[i+1],name);

  ArrayList al=(ArrayList)hm.get(name);
  if(al==null)
  {
    al=new ArrayList();
    hm.put(name,al);
  }
  name=(String)desc.get(ip);
  if(name==null)
  {
    if(ip.startsWith("::ffff:"))ip=ip.substring(7);
    int s=ip.indexOf(':');
    name=s<8?"":Ip.f(ip.substring(0,s));
  }
  al.add("<td>"+arr[i-x]+"<td>"+arr[i+1]+"<td>"+ip+"　<em>"+name+"</em><td>"+arr[i+3]);
}
String[] LOCAL={"--","只看本机","排除本机"};

//http://www.cnblogs.com/xiao-yu/archive/2011/05/24/2055987.html

%><!DOCTYPE html><html><head>
<meta name="viewport" content="width=device-width,user-scalable=0">
<link href="<%=ifr?"http://center.redcome.com":""%>/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js"></script>
<%
if(ifr)out.print("<style>h1{display:none}</style>");
%>
</head>
<body>
<h1>网络连接</h1>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<table id="tablecenter" class="sear">
<tr>
  <td>本地:<select name="local"><%=h.options(LOCAL,local)%></select></td>
  <td>外部:<input name="foreign" value="<%=MT.f(foreign)%>" /></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<h2>列表</h2>
<form name="form2" action="/IpSecs.do?act=kill" method="post" target="_ajax">
<input type="hidden" name="name" />
<input type="hidden" name="nexturl" />
<div class="switch">
<%
StringBuilder sb=new StringBuilder();
Iterator it=hm.keySet().iterator();
for(int i=0;it.hasNext();i++)
{
  String name=(String)it.next();
  ArrayList al=(ArrayList)hm.get(name);
  out.print("<a href=javascript:; onclick=mt.tab(this);form2.name.value=firstChild.textContent; name=a_tab>"+name+"<em>"+al.size()+"</em></a>");

  sb.append("<table id=tablecenter name=tab style=display:none><tr id=tableonetr><td>序号<td>协议<td>本地地址<td>外部地址<td>状态");
  for(int j=0;j<al.size();j++)sb.append("<tr><td align='center'>"+(j+1)+al.get(j));
  sb.append("</table>");
}
%>
</div>

<div class="of-auto">
  <%=sb.toString()%>
<input type="submit" value="杀掉"/>
</div>
</form>

<div class="of-auto">
<table id="tablecenter">
<%
it=st.keySet().iterator();
for(int i=0;it.hasNext();i++)
{
  String name=(String)it.next();
  out.print("<tr><td>"+name+"<td>"+st.get(name));
}
%>
</table>
</div>
<script>
form2.nexturl.value=location.pathname+location.search;
$name('a_tab')[0].click();
</script>

</body>
</html>
