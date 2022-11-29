<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location='/servlet/StartLogin?bg=1&node="+h.node+"'</script>");
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);
sql.append(" AND community="+DbAdapter.cite(h.community));

int ftype=h.getInt("ftype");
par.append("&ftype="+ftype);

int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

int pos=h.getInt("pos");
par.append("&pos=");

String acts=h.get("acts","");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>菜单管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="ftype" value="<%=ftype%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">类型：</td><td><select name="type"><%=h.options(WxMenu.MENU_TYPE,type)%></select></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表</h2>
<form name="form2" action="/WxMenus.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="ftype" value="<%=ftype%>"/>
<input type="hidden" name="menu"/>
<input type="hidden" name="father"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="20" align="center"><input type="checkbox" onClick="mt.select(form2.menus,checked)" title="选中/取消选中"></td>
  <td>名称</td>
  <td>类型</td>
  <td>移动</td>
  <td>操作</td>
</tr>
<%
sql.append(" ORDER BY sequence,menu");
ArrayList ali=WxMenu.find(" AND father="+WxMenu.getRoot(h.community,ftype).menu+sql.toString(),pos,15);
if(ali.size()<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  for(int i=0;i<ali.size();i++)
  {
    WxMenu t=(WxMenu)ali.get(i);
    out.print("<tr><td align='center'><input type='checkbox' name='menus' value='"+t.menu+"' /></td>");
    out.print("<td>");
    if(t.hidden)out.print("<s>");
    out.print(MT.red(t.name,name));
    out.print("</s><td>"+WxMenu.MENU_TYPE[t.type]);
    out.print("<td><img src='/tea/mt/move.gif' name='sequence' />");
    out.println("<td><a href=javascript:mt.act('edit',"+t.menu+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+t.menu+")>删除</a>");

    ArrayList alj=WxMenu.find(" AND father="+t.menu+sql.toString(),pos,15);
    for(int j=0;j<alj.size();)
    {
      t=(WxMenu)alj.get(j);
      out.print("<tr><td align='center'><input type='checkbox' name='menus' value='"+t.menu+"' /></td>");
      out.print("<td>"+(alj.size()==++j?"└":"├")+"─"+MT.red(t.name,name));
      out.print("<td>"+WxMenu.MENU_TYPE[t.type]);
      out.print("<td><img src='/tea/mt/move.gif' name='sequence' />");
      out.println("<td><a href=javascript:mt.act('edit',"+t.menu+")>编辑</a>");
      out.println("<a href=javascript:mt.act('del',"+t.menu+")>删除</a>");
    }
  }
  //if(sum>15)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,15));
}
%>
</table>
<input type="button" name="multi" value="批量删除" onClick="mt.act('del','0')"/>
<input type="button" value="添加" onClick="mt.act('edit','0')"/>
<input type="button" value="发布" onClick="mt.act('sync','0')"/>
</form>

注：最多包括3个一级菜单，每个一级菜单最多包含5个二级菜单。
<%--
if(h.debug)
{
%>
<form name="form3" action="/Menus.do" target="_ajax">
<input type="hidden" name="menu"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr><td class="th">选项：</td><td><input name="linkage" type="checkbox" id="linkage" /><label for="linkage">联动</label></td></tr>
</table>

<input type="button" value="扫描" onClick="mt.act3('scan','0')" />
</form>
<%
}
--%>


<script>
mt.disabled(form2.menus);
mt.sequence(form2.menus,<%=pos%>);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.menu.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='scan')
  {
    mt.show(null,0);
    form2.action='/Menus.do?act='+a+'&menu='+id;
    form2.method='';
    form2.submit();
  }else if(a=='sync')
  {
    form2.submit();
  }else
  {
    if(a=='view')
      form2.action='/MenuView.jsp';
    else if(a=='edit')
      form2.action='/jsp/weixin/WxMenuEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
mt.act3=function(a,id,b)
{
  form3.act.value=a;
  form3.menu.value=id;
  if(a=='scan')
  {
    mt.show(null,0);
    form3.submit();
  }
};
</script>
</body>
</html>
