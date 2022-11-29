<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
//h.member=teasession._rv.toString();


StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);

sql.append(" AND father="+h.node);


//
sql.append(" AND node IN(SELECT node FROM people WHERE 1=1");
int sex=h.getInt("sex");
if(sex>0)
{
  sql.append(" AND sex="+sex);
  par.append("&sex="+sex);
}

String org=h.get("org","");
if(org.length()>0)
{
  sql.append(" AND org LIKE "+DbAdapter.cite("%"+org+"%"));
  par.append("&org="+h.enc(org));
}

String job=h.get("job","");
if(job.length()>0)
{
  sql.append(" AND job LIKE "+DbAdapter.cite("%"+job+"%"));
  par.append("&job="+h.enc(job));
}

String mobile=h.get("mobile","");
if(mobile.length()>0)
{
  sql.append(" AND mobile LIKE "+DbAdapter.cite("%"+mobile+"%"));
  par.append("&mobile="+h.enc(mobile));
}

String tel=h.get("tel","");
if(tel.length()>0)
{
  sql.append(" AND tel LIKE "+DbAdapter.cite("%"+tel+"%"));
  par.append("&tel="+h.enc(tel));
}
sql.append(")");

//NodeLayer
String subject=h.get("subject","");
if(subject.length()>0)
{
  sql.append(" AND node IN(SELECT node FROM NodeLayer WHERE 1=1");
  sql.append(" AND subject LIKE "+DbAdapter.cite("%"+subject+"%"));
  par.append("&subject="+h.enc(subject));
  sql.append(")");
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=Node.count(sql.toString());
sql.append(" ORDER BY sequence");



%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>人物管理——<%=Node.find(h.node).getSubject(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>姓名：<input name="subject" value="<%=subject%>"/></td>
  <td>性别：<select name="sex"><%=h.options(People.SEX_TYPE,sex)%></select></td>
  <td>单位：<input name="org" value="<%=org%>"/></td>
</tr>
<tr>
  <td>职务：<input name="job" value="<%=job%>"/></td>
  <td>手机：<input name="mobile" value="<%=mobile%>"/></td>
  <td>电话：<input name="tel" value="<%=tel%>"/>　　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Peoples.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>姓名</td>
  <td>性别</td>
  <td>单位名称</td>
  <td>职务</td>
  <td>手机</td>
  <td>电话</td>
  <td>顺序</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Enumeration e=Node.find(sql.toString(),pos,20);
  for(int i=1+pos;e.hasMoreElements();i++)
  {
    int nid=((Integer)e.nextElement()).intValue();
    Node n=Node.find(nid);
    People t=People.find(nid,h.language);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%><input type="hidden" name="nodes" value="<%=nid%>"/></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=People.SEX_TYPE[t.sex]%></td>
    <td><%=MT.f(t.org)%></td>
    <td><%=MT.f(t.job)%></td>
    <td><%=MT.f(t.mobile)%></td>
    <td><%=MT.f(t.tel)%></td>
    <td><img name="sequence" src="/tea/image/public/move2.gif" id="<%=nid%>" value="<%=n.getSequence()%>" /></td>
    <td>
      <input type="button" value="编辑" onclick="mt.act('edit',<%=t.node%>)"/>
      <input type="button" value="删除" onclick="mt.act('del',<%=t.node%>)"/>
    </td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="导出" onclick="mt.act('exp','<%=h.node%>')"/>
<input type="button" value="添加" onclick="mt.act('edit','<%=h.node%>')"/>
</form>


<script>
mt.sequence(form2.nodes,<%=pos%>);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.node.value=id;
  form2.key.disabled=a!='exp';
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/type/people/EditPeople.jsp';form2.target=form2.method='';
    form2.submit();
  }else if(a=='exp')
  {
    form2.submit();
  }
};
</script>
</body>
</html>
