<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.custom.papc.*"%><%

Http h=new Http(request,response);

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

sql.append(" AND deleted=0");
par.append("?");

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

Date times=h.getDate("times");
if(times!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(times));
  par.append("&times="+MT.f(times));
}

Date timee=h.getDate("timee");
if(timee!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(timee));
  par.append("&timee="+MT.f(timee));
}


int pos=h.getInt("pos");
int sum=PapcApp.count(sql.toString());
par.append("&pos=");

%>
<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">申请人：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">申请时间：</td><td><input name="times" value="<%=MT.f(times)%>" onClick="mt.date(this)" class="date"/> 至 <input name="timee" value="<%=MT.f(timee)%>" onClick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
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
  <td>申请人</td>
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
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=MT.f(t.project,100)%></td>
    <td><%=MT.f(t.leader,100)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><a href="javascript:mt.act('del',<%=t.papcapp%>)">删除</a></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<div class="subut">
<input type="button" value="提交申请" onclick="mt.act('edit','0')"/></div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value='app'+a;
  form2.papcapp.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/html/folder/8-1.htm';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
