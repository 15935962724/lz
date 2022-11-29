<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.os.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
ArrayList al=Interface.find();
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>网络连接</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form2" action="/Firewalls.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl"/>
<%
for(int i=0;i<al.size();i++)
{
  Interface t=(Interface)al.get(i);
  //if(t.name.indexOf(name)==-1||protocol>0&&protocol!=t.protocol||mode!=-1&&mode!=t.mode)continue;
  out.print("<h2>"+t.name+"</h2>");
  out.print("<table id='tablecenter' cellspacing='0'>");
  //Address
  out.print("<tr><td></td><td><input type='checkbox' name='asource' "+(t.asource?"checked":"")+" id='asource"+i+"'><label for='asource"+i+"'>自动获得IP地址</label>");
  out.print("<tr><td>IP地址：</td><td><input name='aaddr' value='"+t.aaddr+"' />");
  out.print("<tr><td>子网掩码：</td><td><input name='amask' value='"+t.amask+"' />");
  out.print("<tr><td>默认网关：</td><td><input name='agateway' value='"+t.agateway+"' />");
  //DNS
  out.print("<tr><td></td><td><input type='checkbox' name='dsource' "+(t.dsource?"checked":"")+" id='dsource"+i+"'><label for='dsource"+i+"'>自动获得DNS服务器地址</label>");
  out.print("<tr><td>DNS 服务器：</td><td><textarea name='daddr'>"+t.daddr+"</textarea>");
  //WINS
  out.print("<tr><td></td><td><input type='checkbox' name='wsource' "+(t.wsource?"checked":"")+" id='wsource"+i+"'><label for='wsource"+i+"'>自动获得WINS地址</label>");
  out.print("<tr><td>WINS地址：</td><td><textarea name='waddr'>"+t.waddr+"</textarea>");
  out.print("</table>");
}
%>

<br/>
<input type="button" value="重置" onClick="mt.act('reset')"/>
<input type="button" value="添加" onClick="mt.act('edit')"/>
</form>


<script>
mt.act=function(a,b)
{
  form2.act.value=a;
  if(b)
  {
    eval('d='+mt.ftr(b).getAttribute('data'));
    for(var p in d)
    {
      form2[p=='name'?p+'x':p].value=d[p];
    }
  }
  form2.nexturl.value=location.pathname+location.search;
  if(a=='del')
  {
    mt.show('确认删除？',2,'form2.submit()');
  }else if(a=='reset')
  {
    mt.show('确认重置？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/os/FirewallEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }else
  {
    form2.nexturl.value="";
    form2.submit();
  }
};
</script>
</body>
</html>
