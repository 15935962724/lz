<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%><%

Http h=new Http(request,response);

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&community="+h.community+"&id="+menuid);

String subject=h.get("subject","");
if(subject.length()>0)
{
  sql.append(" AND node IN(SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  par.append("&subject="+h.enc(subject));
}

int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

String path=h.get("path","");
if(path.length()>0)
{
  sql.append(" AND path LIKE "+DbAdapter.cite("%"+path+"%"));
  par.append("&path="+h.enc(path));
}
Date t0=h.getDate("t0");
if(t0!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(t0));
  par.append("&t0="+MT.f(t0));
}
Date t1=h.getDate("t1");
if(t1!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(t1));
  par.append("&t1="+MT.f(t1));
}

int pos=h.getInt("pos");
int sum=FRes.count(sql.toString());
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<style>
.tbn{border:1px solid #CCCCCC; width:100px; height:100px;overflow: hidden;text-align:center}
.file{width:0;filter:alpha(opacity=0);opacity:0;margin-left:-69px}
</style>
</head>
<body>
<h1>资源文件管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>节点主题:<input name="subject" value="<%=subject%>"/></td>
  <td>图片类型:<select name="type"><option value="0">--------</option><%=h.options(FRes.FRES_TYPE,type)%></select></td>
  <td>文件名:<input name="path" value="<%=path%>"/></td>
  <td>时间:<input name="t0" value="<%=MT.f(t0)%>" onclick="new Calendar().show('form1.t0')" size="10"/> - <input name="t1" value="<%=MT.f(t1)%>" onclick="new Calendar().show('form1.t1')" size="10"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/FRess.do" method="post" enctype="multipart/form-data" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="fres"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>缩略图</td>
  <td>节点主题</td>
  <td>图片类型</td>
  <td>路径</td>
  <td>描述</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=FRes.find(sql.toString(),pos,10).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    FRes t=(FRes)it.next();
    int id=t.fres;

  %>
  <tr>
    <td><%=i%></td>
    <td><a class="tbn" href="###" onclick="mt.img('<%=t.path%>')"><img src="<%=t.path%>"/></a></td>
    <td><%=MT.f(Node.find(t.node).getSubject(h.language))%></td>
    <td><%=MT.f(FRes.FRES_TYPE,t.type)%></td>
    <td><%=MT.f(t.path)%></td>
    <td><%=MT.f(t.alt)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><input type="button" value="重新上传"/><input type="file" name='file' size="1" class="file" onchange="f_act('upload',<%=t.fres%>)"> <input type="button" value="删除" onclick="f_act('del',<%=t.fres%>)"/></td>
  </tr>
  <%}
  if(sum>10)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,10));
}%>
</table>
</form>

<script>
form1.type.options[1]=null;
var imgs=document.images;
if(imgs)
for(var i=1;i<imgs.length;i++)
{
  var w=imgs[i].width,h=imgs[i].height;
  if(w<100&&h<100)continue;
  if(w>h)imgs[i].width=100;else imgs[i].height=100;
}
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.fres.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='upload')
  {
    form2.submit();
  }
}
</script>
</body>
</html>
