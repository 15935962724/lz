<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

sql.append(" AND community="+DbAdapter.cite(h.community));
par.append("&community="+h.community);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

int cnt=h.getInt("cnt");
if(cnt>0)
{
  sql.append(" AND cnt LIKE "+DbAdapter.cite("%"+cnt+"%"));
  par.append("&cnt="+cnt);
}

Date stime=h.getDate("stime");
if(stime!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(stime));
  par.append("&stime="+MT.f(stime));
}

Date etime=h.getDate("etime");
if(etime!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(etime));
  par.append("&etime="+MT.f(etime));
}

int sum=WxGroup.count(sql.toString());


int pos=h.getInt("pos");
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>组管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称:</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">时间:</td><td><input name="stime" value="<%=MT.f(stime)%>" onclick="mt.date(this)" class="date"/> - <input name="etime" value="<%=MT.f(etime)%>" onclick="mt.date(this)" class="date"/>　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/WxGroups.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="wxgroup"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>成员数量</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY wxgroup");
  Iterator it=WxGroup.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    WxGroup t=(WxGroup)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=MT.f(t.cnt)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td>
      <a href="javascript:mt.act('edit',<%=t.wxgroup%>)">编辑</a>
<!--      <a href="javascript:mt.act('del',<%=t.wxgroup%>)">删除</a>-->
    </td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit','')"/>
<input type="button" value="同步" onclick="mt.act('sync',0)"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.wxgroup.value=id;
  //mt.show('接口暂不开放！');
  //return;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='sync')
  {
    mt.show(null,0);
    form2.submit();
  }else if(a=='edit')
  {
    form2.action='/jsp/weixin/WxGroupEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
