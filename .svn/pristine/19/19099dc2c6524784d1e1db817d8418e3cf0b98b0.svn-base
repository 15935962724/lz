<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.os.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menuid=h.getInt("id");
//AdminFunction af=AdminFunction.find(menuid);

ArrayList al=Firewall.find();
String name=h.get("name","");
int protocol=h.getInt("protocol");
int mode=h.getInt("mode",-1);

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>防火强</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">名称:</td><td><input name="name" value="<%=name%>"></td>
    <td class="th">协议:</td><td><select name="protocol"><%=h.options(Firewall.PROTOCOL_TYPE,protocol)%></select></td>
    <td class="th">状态:</td><td><select name="mode"><option value="-1">--</option><%=h.options(Firewall.MODE_NAME,mode)%></select></td>
    <td><input type="submit" value="查询"/>
  </tr>
</table>
</form>

<form name="form2" action="/Firewalls.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="namex"/>
<input type="hidden" name="protocol"/>
<input type="hidden" name="port"/>
<input type="hidden" name="mode"/>
<input type="hidden" name="scope"/>
<input type="hidden" name="addresses"/>
<input type="hidden" name="profile"/>
<input type="hidden" name="program"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td></td>
  <td>分类</td>
  <td>名称</td>
  <td>协议</td>
  <td>端口</td>
  <td>状态</td>
  <td>范围</td>
  <td>操作</td>
</tr>
<%
for(int i=0;i<al.size();i++)
{
  Firewall t=(Firewall)al.get(i);
  if(t.name.indexOf(name)==-1||protocol>0&&protocol!=t.protocol||mode!=-1&&mode!=t.mode)continue;
  out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor='' data='"+t+"'><td>"+(i+1));
  //out.print("<td><input type='checkbox' name='' value=''>");
  out.print("<td>"+(t.profile==-1?t._interface:Firewall.PROFILE_NAME[t.profile]));
  out.print("<td>"+t.name);
  if(t.program==null)
  {
    out.print("<td>"+Firewall.PROTOCOL_TYPE[t.protocol]);
    out.print("<td>"+t.port);
  }else
  {
    out.print("<td colspan='2'>"+t.program);
  }
  out.print("<td>"+Firewall.MODE_NAME[t.mode]);
  out.print("<td>"+Firewall.SCOPE_NAME[t.scope]);
  out.println("<td><a href='###' onclick=mt.act('edit',this)>编辑</a>");
  out.println("<a href='###' onclick=mt.act('del',this)>删除</a>");
}
%>
</table>

<br/>
<input type="button" value="重置" onClick="mt.act('reset')"/>
<input type="button" value="添加" onClick="mt.act('edit')"/>

<h2>设置</h2>
<table id="tablecenter" cellspacing="0">
<tr>
  <td><input type="checkbox" name="notifications" <%=Firewall.NOTIFICATIONS?"checked":""%> onchange="mt.act(name)" id="notifications"/><label for="notifications">Windows 防火强阻止程序时通知我</label></td>
</tr>
<tr>
  <td>
    <input type="checkbox" name="opmode" <%=Firewall.OPMODE?"checked":""%> onchange="mt.act(name)" id="opmode"/><label for="opmode">启用 Windows 防火强</label>
    <input type="checkbox" name="exceptions" <%=Firewall.EXCEPTIONS?"checked":""%> onchange="mt.act('opmode')" id="exceptions"/><label for="exceptions">允行例外</label>
  </td>
</tr>
</table>
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
