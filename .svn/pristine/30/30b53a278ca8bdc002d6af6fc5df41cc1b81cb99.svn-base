<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location='/servlet/StartLogin?bg=1&node="+h.node+"'</script>");
  return;
}

int menu=h.getInt("menu");

WxMenu root=WxMenu.getRoot(h.community,h.getInt("ftype"));
//if(menu==0)menu=root.menu;

WxMenu t=WxMenu.find(menu);
if(t.menu<1)
{
  t.father=h.getInt("father");
  t.type=1;
}


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>菜单管理</h1>

<form name="form2" action="/WxMenus.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="menu" value="<%=menu%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","")%>"/>

<table id="tablecenter">
  <tr>
    <td width="200px" class="th">父类：</td>
    <td><select name="father" class="tfont"><option value="<%=root.menu%>">--</option><%=root.options(t.father)%></select></td>
  </tr>
  <tr>
    <td class="th">名称：</td>
    <td><input name="name" value="<%=MT.f(t.name)%>" size="40" alt="菜单名称"/><span id="info" style="color:#FF0000"></span></td>
  </tr>
  <tr>
    <td class="th">类型：</td>
    <td><%=h.radios(WxMenu.MENU_TYPE,"type",t.type)%></td>
  </tr>
  <tr id="type_1" style="display:none">
    <td class="th">网址：</td>
    <td><input name="url" value="<%=MT.f(t.url)%>" size="60"/></td>
  </tr>
  <tr id="type_2" style="display:none">
    <td class="th">模块：</td>
    <td><input name="eventkey2" value="<%=MT.f(t.eventkey)%>" size="60"/></td>
  </tr>
  <tr id="type_3" style="display:none">
    <td class="th">节点号：</td>
    <td><input name="eventkey3" value="<%=MT.f(t.eventkey)%>" onchange="f_act(this)" size="60"/>多个用“,”分隔。</td>
  </tr>
  <tr>
    <td class="th">顺序：</td>
    <td><input name="sequence" value="<%=MT.f(t.sequence)%>" mask="int"/></td>
  </tr>
  <tr>
    <td></td>
    <td>
      <input name="hidden" type="checkbox" value="1" id="hidden_1" <%if(t.hidden)out.print(" checked ");%>/><label for="hidden_1">隐蔽/显示</label>
    </td>
  </tr>
</table>


<input type="submit" value="提交"/>
<input type="button" value="返回" onclick="history.back()" />
</form>

<script>
function f_act(a)
{
  var v=a.value+',';
  v=v.replace(/[,，;； ]+/g,',');
  if(v.charAt(0)==',')v=v.substring(1);
  a.value=v;
}
form2.name.onkeyup=form2.name.onchange=form2.father.onchange=function()
{
  var len=form2.father.selectedIndex==0?16:40;
  var v=form2.name.value;
  for(var i=0;i<v.length;i++)
  {
    len-=v.charCodeAt(i)>255?3:1;
  }
  $$('info').innerHTML=len<0?" 超过"+(-len)+"字节！":"";
};
for(var i=0;i<form2.type.length;i++)
form2.type[i].onclick=function()
{
  for(var i=0;i<form2.type.length;)
  {
    var t=$$('type_'+(++i));
    if(t)t.style.display=i==this.value?'':'none';
  }
};
form2.type[<%=t.type-1%>].onclick();
</script>
</body>
</html>
