<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%><%@page import="tea.entity.custom.papc.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>alert('您还没有登录或登录已超时，请重新登录！');top.location.replace('/');</script>");
  return;
}


StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);
sql.append(" AND deleted=0");

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String email=h.get("email","");
if(email.length()>0)
{
  sql.append(" AND email LIKE "+DbAdapter.cite("%"+email+"%"));
  par.append("&email="+h.enc(email));
}

String tel=h.get("tel","");
if(tel.length()>0)
{
  sql.append(" AND tel LIKE "+DbAdapter.cite("%"+tel+"%"));
  par.append("&tel="+h.enc(tel));
}

String org=h.get("org","");
if(org.length()>0)
{
  sql.append(" AND org LIKE "+DbAdapter.cite("%"+org+"%"));
  par.append("&org="+h.enc(org));
}

int position=h.getInt("position");
if(position>0)
{
  sql.append(" AND position LIKE "+DbAdapter.cite("%"+position+"%"));
  par.append("&position="+position);
}

int country=h.getInt("country");
if(country>0)
{
  sql.append(" AND country LIKE "+DbAdapter.cite("%"+country+"%"));
  par.append("&country="+country);
}


int pos=h.getInt("pos");
int sum=PapcApp.count(sql.toString());
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/country.js"></script>
</head>
<body>
<h1>数据申请管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">申请人：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">电子邮件：</td><td><input name="email" value="<%=email%>"/></td>
  <td class="th">电话：</td><td><input name="tel" value="<%=tel%>"/></td>
</tr>
<tr>
  <td class="th">单位：</td><td><input name="org" value="<%=org%>"/></td>
  <td class="th">身份：</td><td><select name="position"><%=h.options(PapcApp.POSITION_TYPE,position)%></select></td>
  <td class="th">国家：</td><td><script>mt.country('country',<%=country%>);</script>　　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Papcs.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="papcapp"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>用户名</td>
  <td>申请人</td>
  <td>电子邮件</td>
  <td>电话</td>
  <td>项目或课题名称及来源</td>
  <td>课题负责人</td>
  <td>申请时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=PapcApp.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    PapcApp t=(PapcApp)it.next();
    Profile p=Profile.find(t.member);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="papcapps" value="<%=t.papcapp%>"/></td>
    <td><a href="/jsp/custom/papc/MemberView.jsp?member=<%=t.member%>"><%=p.getMember()%></a></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=MT.f(t.email)%></td>
    <td><%=MT.f(t.tel)%></td>
    <td><%=MT.f(t.project,50)%></td>
    <td><%=MT.f(t.leader)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td>
      <a href="javascript:mt.act('view',<%=t.papcapp%>)">查看</a>
      <!--<a href="javascript:mt.act('edit',<%=t.papcapp%>)">编辑</a>-->
      <a href="javascript:mt.act('dels',<%=t.papcapp%>)">删除</a>
    </td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<input type="checkbox" onClick="mt.select(form2.papcapps,checked)" id="select"/><label for="select">全选</label>
<input type="button" name="multi" value="批量删除" onClick="mt.act('dels','')"/>
</form>

<script>
mt.disabled(form2.papcapps);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value='app'+a;
  form2.papcapp.value=id;
  if(a=='dels')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
    {
      form2.action='/jsp/custom/papc/PapcAppView.jsp';
    }else if(a=='edit')
    {
      form2.action='/PapcAppEdit.jsp';
    }
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
