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
par.append("?community="+h.community+"&id="+menuid);

sql.append(" AND n.father="+h.node);

String subject=h.get("subject","");
if(subject.length()>0)
{
  sql.append(" AND nl.subject LIKE "+DbAdapter.cite("%"+subject+"%"));
  par.append("&subject="+h.enc(subject));
}

Date times=h.getDate("times");
if(times!=null)
{
  sql.append(" AND n.starttime>"+DbAdapter.cite(times));
  par.append("&times="+MT.f(times));
}

Date timee=h.getDate("timee");
if(timee!=null)
{
  sql.append(" AND n.starttime<"+DbAdapter.cite(timee));
  par.append("&timee="+MT.f(timee));
}

sql.append(" AND n.node IN(SELECT node FROM infrared WHERE 1=1");

int gender=h.getInt("gender");
if(gender>0)
{
  sql.append(" AND gender="+gender);
  par.append("&gender="+gender);
}

int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

String wzjdr=h.get("userip","");
if(wzjdr.length()>0)
{
  sql.append(" AND wzjdr LIKE "+DbAdapter.cite("%"+wzjdr+"%"));
  par.append("&wzjdr="+h.enc(wzjdr));
}

String reserve=h.get("reserve","");
if(reserve.length()>0)
{
  sql.append(" AND reserve IN(SELECT n.node FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node WHERE n.type=102 AND nl.subject LIKE "+DbAdapter.cite("%"+reserve+"%")+")");
  par.append("&reserve="+h.enc(reserve));
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
<h1>红外相机管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">物种名称：</td><td><input name="subject" value="<%=subject%>"/></td>
  <td class="th">对象类别：</td><td><select name="type"><%=h.options(Infrared.INFRARED_TYPE,type)%></select></td>
  <td class="th">动物性别：</td><td><select name="gender"><%=h.options(Infrared.GENDER_TYPE,gender)%></select></td>
</tr>
<tr>
  <td class="th">保护区名称：</td><td><input name="reserve" value="<%=reserve%>"/></td>
  <td class="th">物种鉴定人：</td><td><input name="wzjdr" value="<%=wzjdr%>"/></td>
  <td class="th">拍摄时间：</td><td><input name="times" value="<%=MT.f(times)%>" onClick="mt.date(this)" class="date"/> 至 <input name="timee" value="<%=MT.f(timee)%>" onClick="mt.date(this)" class="date"/></td>
  <td class="th"><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Infrareds.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>物种名称</td>
  <td>对象类别</td>
  <td>动物性别</td>
  <td>保护区名称</td>
  <td>物种鉴定人</td>
  <td>拍摄日期</td>
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
    Infrared t=Infrared.find(node);

  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=Infrared.INFRARED_TYPE[t.type]%></td>
    <td><%=Infrared.GENDER_TYPE[t.gender]%></td>
    <td><%=t.reserve<1?"--":Node.find(t.reserve).getAnchor(h.language).toString()%></td>
    <td><%=MT.f(t.wzjdr)%></td>
    <td><%=MT.f(t.pstime,1)%></td>
    <td><a href=javascript:mt.act('edit',<%=node%>)>编辑</a> <a href=javascript:mt.act('del',<%=node%>)>删除</a></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit','<%=h.node%>')"/>
<input type="button" value="导出" onclick="mt.show(null,0);form3.submit()"/>
</form>

<form name="form3" action="/Nodes.do?type=107&sum=<%=sum%>" method="post" target="_ajax">
<input type="hidden" name="act" value="exp"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
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
      if(a=='edit')
      {
        form2.action='/jsp/type/infrared/EditInfrared.jsp';
      }
      form2.target=form2.method='';
    }
    form2.submit();
  }
};
</script>
</body>
</html>
