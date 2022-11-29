<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

String act=h.get("act");
if("action".equals(act))
{
  out.print("oper,");
  return;
}

String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND code LIKE "+DbAdapter.cite("%"+code+"%"));
  par.append("&code="+h.enc(code));
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsPro.count(sql.toString());
String acts=h.get("acts","");


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.null<%=(acts.contains("oper,")?"":",.oper")%>{display:none}
</style>
</head>
<body>
<h1><%=menuid<1?"专业管理":AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <th>代码:</th><td><input name="code" value="<%=code%>"/></td>
  <th>名称:</th><td><input name="name" value="<%=name%>"/></td>
  <th>时间:</th><td><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h3>
<input type="button" value="添加" onclick="mt.act(null,'edit')" class="oper"/>
<input type="button" value="导出" onclick="mt.show(null,0);form3.submit();"/>
</h3>

<h2>列表</h2>
<form name="form2" action="/LmsPros.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmspro"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>代码</td>
  <td>名称</td>
  <td>毕业学分</td>
  <td>创建时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=LmsPro.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsPro t=(LmsPro)it.next();
  %>
  <tr id="<%=MT.enc(t.lmspro)%>">
    <td><%=i%></td>
    <td><%=MT.f(t.code)%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=MT.f(t.credit)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><%
    out.println("<a href=### onclick=mt.act(this,'view')>查看</a>");
    out.println("<a href=### onclick=mt.act(this,'edit') class='oper'>编辑</a>");
    out.println("<a href=### onclick=mt.act(this,'del') class='oper'>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</form>

<form name="form3" action="/LmsExports.do?name=专业.xlsx" method="post" target="_ajax">
<input type="hidden" name="act" value="sql"/>
<input type="hidden" name="key" value="<%=MT.enc("SELECT code 代码,name 名称,credit 毕业学分,time 创建时间 FROM LmsPro WHERE 1=1"+sql.toString())%>"/>
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.lmspro.value=t?mt.ftr(t).id:"";
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/jsp/lms/LmsProView.jsp';
    else if(a=='edit')
      form2.action='/jsp/lms/LmsProEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
