<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.os.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
ArrayList al=IpSec.find(0,200);

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>IP安全策略</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/IpSecs.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="srcaddr"/>
<input type="hidden" name="dstaddr"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td></td>
  <td>源IP地址</td>
  <td>目标IP地址</td>
  <td>协议</td>
  <td>源端口</td>
  <td>目标端口</td>
  <td>描述</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
for(int i=0;i<al.size();i++)
{
  IpSec t=(IpSec)al.get(i);
  out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''><td>"+(i+1));
  out.print("<td>"+t.srcaddr);
  out.print("<td>"+t.dstaddr);
  out.print("<td>"+t.protocol);
  out.print("<td>"+(t.srcport==0?"全部":String.valueOf(t.srcport)));
  out.print("<td>"+(t.dstport==0?"全部":String.valueOf(t.dstport)));
  out.print("<td>"+t.description);
  out.print("<td>"+(t.time==0?"":MT.f(new Date(t.time*1000L),1)));
  out.print("<td><a href='###' onclick=mt.act('del',this)>删除</a>");
}
%>
</table>

<br/>
<input type="button" value="清空" onClick="mt.act('clear')"/>
<input type="button" value="添加" onClick="mt.act('add')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,b)
{
  form2.act.value=a;
  if(a=='del')
  {
    var tr=mt.ftr(b).childNodes;
    form2.srcaddr.value=tr[1].innerHTML;
    form2.dstaddr.value=tr[2].innerHTML;
    mt.show('确认删除？',2,'form2.submit()');
  }else if(a=='clear')
  {
    mt.show('确认清空？',2,'form2.submit()');
  }else if(a=='add')
  {
    form2.action='/jsp/os/IpSecEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
