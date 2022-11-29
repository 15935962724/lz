<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);
sql.append(" AND father="+h.node);

String subject=h.get("subject","");
if(subject.length()>0)
{
  sql.append(" AND node IN(SELECT node FROM NodeLayer WHERE 1=1");
  sql.append(" AND subject LIKE "+DbAdapter.cite("%"+subject+"%"));
  par.append("&subject="+h.enc(subject));
  sql.append(")");
}

Date times=h.getDate("times");
if(times!=null)
{
  sql.append(" AND starttime>"+DbAdapter.cite(times));
  par.append("&times="+MT.f(times));
}

Date timee=h.getDate("timee");
if(timee!=null)
{
  sql.append(" AND starttime<"+DbAdapter.cite(timee));
  par.append("&timee="+MT.f(timee));
}


sql.append(" AND node IN(SELECT node FROM specimen WHERE 1=1");
String unit=h.get("unit","");
if(unit.length()>0)
{
  sql.append(" AND unit LIKE "+DbAdapter.cite("%"+unit+"%"));
  par.append("&unit="+h.enc(unit));
}

String reserve=h.get("reserve","");
if(reserve.length()>0)
{
  sql.append(" AND reserve IN(SELECT n.node FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node WHERE n.type=102 AND nl.subject LIKE "+DbAdapter.cite("%"+reserve+"%")+")");
  par.append("&reserve="+h.enc(reserve));
}

String species1=h.get("species1","");
if(species1.length()>0)
{
  sql.append(" AND species1 LIKE "+DbAdapter.cite("%"+species1+"%"));
  par.append("&species1="+h.enc(species1));
}

String cperson=h.get("cperson","");
if(cperson.length()>0)
{
  sql.append(" AND cperson LIKE "+DbAdapter.cite("%"+cperson+"%"));
  par.append("&cperson="+h.enc(cperson));
}
String csite=h.get("csite","");
if(csite.length()>0)
{
  sql.append(" AND csite LIKE "+DbAdapter.cite("%"+csite+"%"));
  par.append("&csite="+h.enc(csite));
}
sql.append(")");


int pos=h.getInt("pos");
par.append("&pos=");
int sum=Node.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>标本管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称：</td><td><input name="subject" value="<%=subject%>"/></td>
  <td class="th">保存单位及其标本馆：</td><td><input name="unit" value="<%=unit%>"/></td>
  <td class="th">保护区：</td><td><input name="reserve" value="<%=reserve%>"/></td>
</tr>
<tr>
  <td class="th">采集人：</td><td><input name="cperson" value="<%=cperson%>"/></td>
  <td class="th">采集地：</td><td><input name="csite" value="<%=csite%>"/></td>
  <td class="th">采集时间：</td><td><input name="times" value="<%=MT.f(times)%>" onClick="mt.date(this)" class="date"/> 至 <input name="timee" value="<%=MT.f(timee)%>" onClick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Specimens.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>保存单位及其标本馆</td>
  <td>保护区</td>
  <td>采集人</td>
  <td>采集时间</td>
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
    int node=((Integer)e.nextElement()).intValue();
    Node n=Node.find(node);
    Specimen t=Specimen.find(node);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=MT.f(t.unit)%></td>
    <td><%=Node.find(t.reserve).getAnchor(h.language)%></td>
    <td><%=MT.f(t.cperson)%></td>
    <td><%=MT.f(t.ctime)%></td>
    <td>
    <%
    out.println("<a href=javascript:mt.act('hidden',"+node+")>"+(n.isHidden()?"发布":"取消发布")+"</a>");
    out.println("<a href=javascript:mt.act('edit',"+node+")>编辑</a>");
    out.println("<a href=javascript:mt.act('ide',"+node+")>鉴定("+SIdentify.count(" AND node="+node)+")</a>");
    out.println("<a href=javascript:mt.act('pic',"+node+")>图片("+SPicture.count(" AND specimen="+node)+")</a>");
    out.println("<a href=javascript:mt.act('del',"+node+")>删除</a>");
    %>
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit','<%=h.node%>')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.node.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='hidden')
    {
    }else
    {
      if(a=='ide')
        form2.action='/jsp/type/specimen/SIdentifys.jsp';
      else if(a=='pic')
      {
        form2.node.name="specimen";
        form2.action='/jsp/type/spicture/SPictures.jsp';
      }else if(a=='edit')
      {
        form2.action='/jsp/type/specimen/EditSpecimen.jsp';
      }
      form2.target=form2.method='';
    }
    form2.submit();
  }
};
</script>
</body>
</html>
