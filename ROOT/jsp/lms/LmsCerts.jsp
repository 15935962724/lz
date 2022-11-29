<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.lms.*"%><%

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

String  content=h.get("content","");
if(content.length()>0)
{
  sql.append(" AND content LIKE "+DbAdapter.cite("%"+content+"%"));
  par.append("&content="+h.enc(content));
}

int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type LIKE "+DbAdapter.cite("%"+type+"%"));
  par.append("&type="+type);
}

int rank=h.getInt("rank");
if(rank>0)
{
  sql.append(" AND rank="+rank);
  par.append("&rank="+rank);
}

int status=h.getInt("status");
if(status>0)
{
  sql.append(" AND status LIKE "+DbAdapter.cite("%"+status+"%"));
  par.append("&status="+status);
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsCert.count(sql.toString());
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
<h1><%=menuid<1?"证书管理":AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <th>证书编号:</th><td><input name="code" value="<%=code%>"/></td>
  <th>证书名称:</th><td><input name="name" value="<%=name%>"/></td>
  <th>证书等级:</th><td><select name="rank"><%=h.options(LmsCert.RANK_TYPE,rank)%></select></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h3>
<input type="button" value="添加" onclick="mt.act(null,'edit')" class="oper"/>
<input type="button" value="导出" onclick="mt.show(null,0);form3.submit();"/>
</h3>

<h2>列表</h2>
<form name="form2" action="/LmsCerts.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmscert"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>证书编号</td>
  <td>证书名称</td>
  <td>证书类型</td>
  <td>证书等级</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=LmsCert.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsCert t=(LmsCert)it.next();
  %>
  <tr id="<%=MT.enc(t.lmscert)%>">
    <td><%=i%></td>
    <td><%=MT.f(t.code)%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=LmsCert.LMSCERT_TYPE[t.type]%></td>
    <td><%=LmsCert.RANK_TYPE[t.rank]%></td>
    <td><%
    out.println("<a href=### onclick=mt.act(this,'view')>查看</a>");
    out.println("<a href=### onclick=mt.act(this,'edit') class='oper'>编辑</a>");
    out.println("<a href=### onclick=mt.act(this,'del') class='oper'>删除</a>");
    %></td>
  </tr>
  <%
  }
  out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</form>

<form name="form3" action="/LmsExports.do?name=证书信息.xlsx" method="post" target="_ajax">
<input type="hidden" name="act" value="sql"/>
<input type="hidden" name="key" value="<%=MT.enc("SELECT code 代码,name 名称,"+Lms.when(LmsCert.LMSCERT_TYPE,"type")+" 证书类型,"+Lms.when(LmsCert.RANK_TYPE,"rank")+" 证书等级,time 创建时间 FROM LmsCert WHERE 1=1"+sql.toString())%>"/>
</form>


<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.lmscert.value=t?mt.ftr(t).id:"";
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/jsp/lms/LmsCertView.jsp';
    else if(a=='edit')
      form2.action='/jsp/lms/LmsCertEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
