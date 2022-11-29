<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location.replace('/servlet/StartLogin?community="+h.community+"');</script>");
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community);


int node=h.getInt("node");
if(node>0)
{
  sql.append(" AND node LIKE "+DbAdapter.cite("%"+node+"%"));
  par.append("&node="+node);
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String repository=h.get("repository");
String path="/res/"+h.community+"/"+repository;
sql.append(" AND path LIKE "+DbAdapter.cite(path+"/%"));
par.append("&repository="+h.enc(repository));

int order=h.getInt("order",1);
par.append("&order="+order);

boolean desc="true".equals(h.get("desc"));
par.append("&desc="+desc);

int pos=h.getInt("pos");
par.append("&pos=");

//ref
int len=application.getRealPath("/").length()-1;
File[] fs=new File(application.getRealPath(path)).listFiles();
if(fs!=null)
for(int i=0;i<fs.length;i++)
{
  if(fs[i].isDirectory())continue;
  path=fs[i].getPath().substring(len).replace('\\','/').replaceAll("['%#]", "_");
  ArrayList al=Attch.find(" AND path="+DbAdapter.cite(path),0,1);
  Attch a=al.size()<1?new Attch(0):(Attch)al.get(0);
  if(a.length!=fs[i].length())
  {
    a.community=h.community;
    a.name=path.substring(path.lastIndexOf('/')+1);
    a.type=path.substring(path.lastIndexOf('.')+1).toLowerCase();
    a.path=path;
    a.length=(int)fs[i].length();
    a.set();
  }
}


int sum=Attch.count(sql.toString());
String acts=h.get("acts","");

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
</style>
</head>
<body class="iframe">

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="repository" value="<%=repository%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>名称:<input name="name" value="<%=name%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<form name="form2" action="/Attchs.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="attch"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td><input type="checkbox" onclick="mt.select(form2.attchs,checked)" /></td>
  <td><a href="javascript:mt.order('O1')" id="O1">名称</a></td>
  <td><a href="javascript:mt.order('O2')" id="O2">大小</a></td>
  <td><a href="javascript:mt.order('O3')" id="O3">时间</a></td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  String[] ORDER_TYPE={"","name","length","time"};
  sql.append(" ORDER BY "+ORDER_TYPE[order]+(desc?" DESC":" ASC")+",attch");
  Iterator it=Attch.find(sql.toString(),pos,10).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Attch t=(Attch)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input name="attchs" type="checkbox" value="<%=t.attch%>" data='<%=t.toString3()%>' /></td>
    <td><img src="/tea/image/ico/<%=t.type%>.gif"/> <%=MT.f(t.name)%></td>
    <td><%=MT.f(t.length/1024F,2)%>K</td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
  <%
  }
  if(sum>10)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！ "+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,10));
}%>
</table>
<br/>
<input type="button" value="确定" name="multi" onclick="mt.act('edit','0')"/>
<input type="button" value="关闭" onclick="pmt.close()"/>
</form>

<script>
mt.disabled(form2.attchs);
var pmt=parent.mt;
mt.act=function()
{
  var arr=form2.attchs,v='|',h='';
  if(arr.tagName)arr=[arr];
  for(var i=0;i<arr.length;i++)
  {
    var t=arr[i];
    if(t.disabled||!t.checked)continue;
    eval('d='+t.getAttribute('data'));
    v+=t.value+'|';
    h+="<span id='_a"+t.value+"'><img src='/tea/image/ico/"+d.name.substring(d.name.lastIndexOf('.')+1)+".gif' class='ico' />"+d.name+"<img src='/tea/image/d7.gif' onclick='mt.fdel(this)' /></span>";
  }
  pmt.receive(v,null,h);
  pmt.close()
};
mt.fit();
</script>
</body>
</html>
