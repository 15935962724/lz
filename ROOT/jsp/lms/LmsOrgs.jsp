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
  out.print("oper,audit,");
  return;
}

String acts=h.get("acts","");
int remind=acts.contains("audit,")?LmsOrg.count(sql.toString()+" AND state=1"):0;
if("remind".equals(act))
{
  out.print(remind);
  return;
}

String orgname=h.get("orgname","");
if(orgname.length()>0)
{
  sql.append(" AND orgname LIKE "+DbAdapter.cite("%"+orgname+"%"));
  par.append("&orgname="+h.enc(orgname));
}

String orgno=h.get("orgno","");
if(orgno.length()>0)
{
  sql.append(" AND orgno LIKE "+DbAdapter.cite("%"+orgno+"%"));
  par.append("&orgno="+h.enc(orgno));
}

int pos=h.getInt("pos");
par.append("&pos=");


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=menuid<1?"机构管理":AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <th>编号:</th><td><input name="orgno" value="<%=orgno%>"/></td>
  <th>名称:</th><td><input name="orgname" value="<%=orgname%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h3>
<%
if(acts.contains("oper,"))
{
  out.println("<input type='button' value='添加省助学发展机构' onclick=mt.act(null,'edit') />");
//}
//if(acts.contains("audit,"))
//{
  out.println("<input type='button' value='禁用' name='multi' onclick=mt.act(null,'state4') />");
}
%>
<input type="button" value="导出" onclick="mt.show(null,0);form3.submit();"/>
</h3>

<h2>列表</h2>
<form name="form2" action="/LmsOrgs.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsorg"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="father"/>
<input type="hidden" name="state"/>

<table id="tablecenter" cellspacing="0" class="alignLeft">
<tr id="tableonetr">
  <td width="15"><input type="checkbox" onclick="mt.select(form2.lmsorgs,checked)"/></td>
  <td>机构名称</td>
  <td>机构编号</td>
  <td>状态</td>
  <td>操作</td>
</tr>
<%
int sum=LmsOrg.count(" AND isasp=1"+sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=LmsOrg.find(" AND isasp=1"+sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsOrg t=(LmsOrg)it.next();
  %>
  <tr id="<%=MT.enc(t.lmsorg)%>">
    <td><input type="checkbox" name="lmsorgs" value="<%=t.lmsorg%>"/></td>
    <td><img src="/tea/image/tree/plus.gif" onclick="mt.act(this,'open',0)" /><%=MT.f(t.orgname)%></td>
    <td><%=MT.f(t.orgno)%></td>
    <td><%=LmsOrg.STATE_TYPE[t.state]%></td>
    <td><%
    out.println("<a href=### onclick=mt.act(this,'view')>查看</a>");
    out.println("<a href=### onclick=mt.act(this,'edit0',"+t.lmsorg+")>添加学习服务中心</a>");
    out.println("<a href=### onclick=mt.act(this,'edit')>编辑</a>");
    out.println("<a href=### onclick=mt.act(this,'del')>删除</a>");
    if(acts.contains("oper,"))
    {
      if(t.state==1)out.println("<a href=### onclick=mt.act(this,'state')>审核</a>");
    }
    %></td>
  </tr>
  <%
    out.print("<tbody style='display:none'>");
    ArrayList al=LmsOrg.find(" AND isasp=0 AND father="+t.lmsorg+sql.toString(),0,200);
    for(int j=0;j<al.size();j++)
    {
      LmsOrg to=(LmsOrg)al.get(j);
    %>
    <tr id="<%=MT.enc(to.lmsorg)%>">
      <td><input type="checkbox" name="lmsorgs" value="<%=to.lmsorg%>"/></td>
      <td>　　<img src="/tea/image/tree/minus.gif" /><%=MT.f(to.orgname)%></td>
      <td><%=MT.f(to.orgno)%></td>
      <td><%=LmsOrg.STATE_TYPE[to.state]%></td>
      <td><%
      out.println("<a href=### onclick=mt.act(this,'view0')>查看</a>");
      if(acts.contains("oper,"))
      {
        out.println("<a href=### onclick=mt.act(this,'edit0')>编辑</a>");
        out.println("<a href=### onclick=mt.act(this,'del')>删除</a>");
      }
      if(acts.contains("audit,"))
      {
        if(to.state==1)out.println("<a href=### onclick=mt.act(this,'state')>审核</a>");
      }
      %></td>
    </tr>
    <%
    }
    out.print("</tbody>");
  }
  if(sum>20)out.print("<tr><td colspan='5' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}%>
</table>
</form>

<form name="form3" action="/LmsExports.do?name=助学发展机构.xlsx" method="post" target="_ajax">
<input type="hidden" name="act" value="lmsorg"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
</form>
<script>
mt.disabled(form2.lmsorgs);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.lmsorg.value=t?mt.ftr(t).id:"";
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='open')
  {
    var tb=mt.ftr(t).parentNode;
    tb=(tb.nextElementSibling||tb.nextSibling).style;
    t.src="/tea/image/tree/"+(tb.display=='none'?"minus":"plus")+".gif";
    tb.display=tb.display=='none'?'':'none';
  }else if(a=='state')
  {
    mt.show("状态：<input type='radio' name='_state' value='2' id='_state_2' checked /><label for='_state_2'>通过</label>　<input type='radio' name='_state' value='3' id='_state_3' /><label for='_state_3'>不通过</label>",2,"form2.state.value=$$('_state_2').checked?2:3;form2.submit()");
  }else if(a=='state4')
  {
    form2.submit();
  }else
  {
    if(a=='view')
      form2.action='/jsp/lms/LmsOrgView.jsp';
    else if(a=='edit')
      form2.action='/jsp/lms/LmsOrgEdit.jsp';
    if(a=='view0')
      form2.action='/jsp/lms/LmsOrgView0.jsp';
    else if(a=='edit0')
    {
      if(b)
      {
        form2.father.value=b;
        form2.lmsorg.value="";
      }
      form2.action='/jsp/lms/LmsOrgEdit0.jsp';
    }
    form2.target=form2.method='';
    form2.submit();
  }
};
edn.remind(<%=remind%>);
</script>
</body>
</html>
