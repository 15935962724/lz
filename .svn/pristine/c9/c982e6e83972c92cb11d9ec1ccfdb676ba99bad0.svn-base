<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuilder sql=new StringBuilder(),par=new StringBuilder();

int menuid=h.getInt("id");
par.append("?id="+menuid);

sql.append(" AND p.type!=1 AND p.deleted=0 AND pl.language="+h.language);

String str=Lms.query(h,sql,par,false);

String act=h.get("act");
if("action".equals(act))
{
  out.print("oper,");
  return;
}

int type=h.getInt("type",-1);
if(type!=-1)
{
  sql.append(" AND p.type="+type);
  par.append("&type="+type);
}

String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND p.member LIKE "+DbAdapter.cite("%"+member+"%"));
  par.append("&member="+h.enc(member));
}


Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND p.time>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND p.time<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

String card=h.get("card","");
if(card.length()>0)
{
  sql.append(" AND p.card LIKE "+DbAdapter.cite("%"+card+"%"));
  par.append("&card="+MT.f(card));
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND pl.firstname LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+MT.f(name));
}

boolean photo=h.getBool("photo");
if(photo)
{
  sql.append(" AND pl.photopath IS NULL");
  par.append("&photo="+photo);
}

int order=h.getInt("order",4);
par.append("&order="+order);

boolean desc=!"false".equals(h.get("desc"));
par.append("&desc="+desc);


int pos=h.getInt("pos");
par.append("&pos=");

int sum=Profile.count(sql.toString());
String acts=h.get("acts","");


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/lms/lms.js" type="text/javascript"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
.null<%=(acts.contains("oper,")?"":",.oper")%>{display:none}
</style>
</head>
<body>
<h1><%=menuid<1?"招生管理":AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0" class="alignLeft">
<tr>
  <%=str%>
  <th>学号:</th><td><input name="member" value="<%=member%>"/></td>
</tr>
<tr>
  <th>姓名:</th><td><input name="name" value="<%=name%>"/></td>
  <th>证件号码:</th><td><input name="card" value="<%=card%>"/></td>
  <th>状态:</th><td><select name="type"><option value="-1">--</option><%=h.options(Lms.MEMBER_TYPE,type)%></select></td>
</tr>
<tr>
  <th>报名日期:</th><td><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <th>选项:</th><td><input type="checkbox" name="photo" <%=photo?" checked":""%> id="_photo"/><label for="_photo">列出无照片学员</label></td>
  <th></th><td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h3>
<input type="button" value="添加" onclick="mt.act(null,'edit')" class="oper"/>
<input type="button" value="仅导出数据" onclick="mt.act3('member','招生信息.xlsx')"/>
<input type="button" value="仅导出照片" onclick="mt.act3('photo','招生信息.zip')"/>
<input type="button" value="导入" onclick="mt.act(null,'imp')" class="oper"/>
</h3>

<h2>列表</h2>
<form name="form2" action="/LmsMembers.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0" class="alignLeft">
<tr id="tableonetr">
  <td></td>
  <td><a href="javascript:mt.order('O1')" id="O1">学号</a></td>
  <td><a href="javascript:mt.order('O2')" id="O2">姓名</a></td>
  <td><a11 href="javascript:mt.order('O3')" id="O3">机构名称</a></td>
  <td><a href="javascript:mt.order('O4')" id="O4">报名日期</a></td>
  <td><a href="javascript:mt.order('O5')" id="O5">入学日期</a></td>
  <td><a href="javascript:mt.order('O6')" id="O6">状态</a></td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  String[] ORDER_TYPE={"p.profile","p.member","pl.firstname","==","p.time","p.ltime0","p.type"};
  sql.append(" ORDER BY "+ORDER_TYPE[order]+(desc?" DESC":" ASC")+",p.profile"+(desc?" DESC":" ASC"));
  Iterator it=Profile.find1(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Profile t=(Profile)it.next();
    LmsOrg lo=LmsOrg.find(t.getAgent());
    type=t.getType();
  %>
  <tr id="<%=MT.enc(t.profile)%>" enc=<%=t.profile%>>
    <td><%=i%></td>
    <td><%=t.getMember()%></td>
    <td><%=Lms.getAnchor(t)%></td>
    <td><%=MT.f(lo.orgname)%></td>
    <td><%=MT.f(t.getTime())%></td>
    <td><%=MT.f(t.getVerifgtime())%></td>
    <td><%=Lms.MEMBER_TYPE[type]%></td>
    <td><%
    out.println("<a href=### onclick=mt.act(this,'score')>报考记录"+MT.f(LmsScore.count(" AND member="+t.profile),'(')+"</a>");
    out.println("<a href=### onclick=mt.act(this,'edit') class='oper'>编辑</a>");
    if(type==0)out.println("<a href=### onclick=mt.act(this,'del') class='oper'>删除</a>");
    else if(type!=4)out.println("<a href=### onclick=mt.act(this,'leave') class='oper'>退学申请</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='8' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}%>
</table>
</form>

<form name="form3" action="/LmsExports.do?name=招生信息.xlsx" method="post" target="_ajax">
<input type="hidden" name="act" value="member"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.member.value=t?mt.ftr(t).id:"";
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='score')
  {
    mt.show('/jsp/lms/LmsScoreIfr.jsp?member='+form2.member.value,2,'报考记录',550);
  }else
  {
    if(a=='view')
      form2.action='/LmsProView.jsp';
    else if(a=='edit')
      form2.action='/jsp/lms/LmsMemberEdit.jsp';
    else if(a=='leave')
      form2.action='/jsp/lms/LmsLeaveEdit.jsp';
    else if(a=='imp')
      form2.action='/jsp/lms/LmsMemberImp.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
mt.act3=function(a,b)
{
  form3.act.value=a;
  form3.action="/LmsExports.do?name="+b;
  mt.show(null,0);
  form3.submit();
};
form1.type.options[2]=null;
</script>
</body>
</html>
